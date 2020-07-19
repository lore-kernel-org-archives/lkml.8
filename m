Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E613BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B9E20734
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595150607;
	bh=FXGs3363erCGNX9TvamANt772GZXMe1t8CEolW3wfm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gv+Ht9GcwRG8Gubb7SSEO4jafkuYT+kSUC6sqhumFDZWt7EQjjIZaUgrhrUfRD/Q/
	 gR7ndfyyeKqxH+54rFgux13eHPh8X5qQwMy2zgewi2wG/U0VJRObpL2qhb9AKKRp9k
	 ilDmftw08cvCOvAHhLZeAkJhre5XJFCqLiAElW+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgGSJX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 05:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgGSJXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 05:23:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD8F20734;
        Sun, 19 Jul 2020 09:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595150605;
        bh=FXGs3363erCGNX9TvamANt772GZXMe1t8CEolW3wfm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1fI3FoyPB5WBOn4JCjyjO8Bcy2Verdht6rMHQfwSeQkCv/UCmqRmfBZUupKHYk4la
         C0nyl1Puf2jMPkX+Tch5T0l49QbBMh91nFayM1rhuINf9hSN337UFPEB3aN/Cly7Ep
         CqJBlE5mzvHJLtJ0ySjArhYO9GVYUa5VwsZ3hmiA=
Date:   Sun, 19 Jul 2020 11:23:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: properly check endpoint types
Message-ID: <20200719092338.GC171181@kroah.com>
References: <20200718155836.86384-1-rkovhaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718155836.86384-1-rkovhaev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 08:58:36AM -0700, Rustam Kovhaev wrote:
> As syzkaller detected, wlan-ng driver submits bulk urb without checking
> that the endpoint type is actually bulk, add usb_urb_ep_type_check()
> 
> Reported-and-tested-by: syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=c2a1fa67c02faa0de723
> Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
> ---
>  drivers/staging/wlan-ng/hfa384x_usb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
> index fa1bf8b069fd..7cde60ea68a2 100644
> --- a/drivers/staging/wlan-ng/hfa384x_usb.c
> +++ b/drivers/staging/wlan-ng/hfa384x_usb.c
> @@ -339,6 +339,12 @@ static int submit_rx_urb(struct hfa384x *hw, gfp_t memflags)
>  
>  	hw->rx_urb_skb = skb;
>  
> +	result = usb_urb_ep_type_check(&hw->rx_urb);
> +	if (result) {
> +	       netdev_warn(hw->wlandev->netdev, "invalid rx endpoint");
> +	       goto cleanup;
> +	}

In looking at this again, can you just make these checks in the probe
function, and abort binding the driver to the device at that point in
time?  This feels really late in the init sequence.

The real problem here is in the hfa384x_create() function, where it
blindly takes the 1 and 2 endpoints and assumes that those are the
"correct type".  How about checking the types there, and if they are
incorrect, returning an error from that function and have the caller
return the error as well.

That should keep anything else in the driver from being initialized and
set up, and stop bad devices from being bound to the driver at a much
earlier point in time.

Note, just checking for the valid type/direction of those endpoints
should be sufficient.

thanks,

greg k-h
