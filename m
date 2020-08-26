Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03ACC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C2EC214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598452793;
	bh=MPfx5aMRKvl6ZwBRmQ7wZoUEayNIgC3zvUTNwgksdSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r5IXgvDryMKDfYjrKUcIkiUu945OE2ZW3/5l72M3uNhurT0biPYIILEE1Q4fPqVWY
	 rpqtvuFrsm0HIm4KNLsEE1TC4zVGxpAlxGlcD5ryckHapMKHMrriiZTEYlVtEGNPIU
	 xE6p7f64RcfCdv7X7uUSDISoTMC68D0OMnJhjRbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHZOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgHZOjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:39:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6614A2177B;
        Wed, 26 Aug 2020 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598452790;
        bh=MPfx5aMRKvl6ZwBRmQ7wZoUEayNIgC3zvUTNwgksdSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiYrI2soBiXl7DPVV0RzATq2/1Ocm5qQ6CI5eH7flFsCHyC+pNxXpDA/ZoRk10tFT
         pp18pv46oDlUwUlOjMRphDG2sA2C7jBTigsPDVHy/urYkMKQ3I9t6LDwD/Ln4pDUMk
         z9JV2hcMyjmNq/Gq+1Ry83IdXuMcbDZzhXZXKOSc=
Date:   Wed, 26 Aug 2020 16:40:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     arnd@arndb.de, rikard.falkeborn@gmail.com, rogerable@realtek.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: improve status check
Message-ID: <20200826144006.GA4178874@kroah.com>
References: <20200826135337.17105-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826135337.17105-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 06:53:37AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this error
> 
> rtsx_usb.c:505:10: warning: The left operand of '&'
>   is a garbage value
>         if (val & cd_mask[card])
>             ~~~ ^
> 
> val is set when rtsx_usb_get_card_status() is successful.  The
> problem is how it checks its callers returns.
> 
> 	/* usb_control_msg may return positive when success */
> 	if (ret < 0)
> 		return ret;
> 
> This is correct for the usb_control_msg() the call. However,
> the call to rtsx_usb_get_status_with_bulk is only successful
> when 0 is returned.
> 
> So make status checking block specific.
> 
> Fixes: 730876be2566 ("mfd: Add realtek USB card reader driver")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/misc/cardreader/rtsx_usb.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
> index 59eda55d92a3..bd392b0c66af 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -304,14 +304,15 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
>  		*status = *buf;
>  
>  		kfree(buf);
> +
> +		/* usb_control_msg may return positive when success */

it _WILL_ return positive.  it will return negative for an error.  It
will never return 0.

> +		if (ret < 0)
> +			return ret;
>  	} else {
>  		ret = rtsx_usb_get_status_with_bulk(ucr, status);
> +		if (ret)
> +			return ret;
>  	}
> -
> -	/* usb_control_msg may return positive when success */
> -	if (ret < 0)
> -		return ret;
> -

I fail to see how this code is incorrect today.

Well, I do see a bug in here, but you aren't fixing it (short read is
not checked), see the recent linux-usb@vger mail thread about that
problem that we will be fixing tree-wide over time soon...

How can your move of these lines modify anything?

thanks,

greg k-h
