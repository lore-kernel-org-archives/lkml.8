Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28558C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CF32070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585210478;
	bh=elz3UD004qynkZxjoJv1nYmnugnX1dCGwgJS0d8+k4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KrPR9SWZYj9hHlRiqDzqYQmi21g/xGvc8uRM5zg1L91/zQqkeH4y4DJOzEHB+7NG5
	 C2tE/Eez6Un2tEWlXgyM2GZwPWmbdL7LKmOrwxvjRHb/Fgz7ehfuTEEat8Q0GXt1/n
	 MvnyQqzBOPhqZbfz4S58xKC4xxSLtaUJIT5tEh0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgCZIOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgCZIOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:14:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CAC82070A;
        Thu, 26 Mar 2020 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585210476;
        bh=elz3UD004qynkZxjoJv1nYmnugnX1dCGwgJS0d8+k4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y9+4WRWnBTZ4ra47yUm7mmra9bmFqu1h7f7HB6RjbmAhL43j7Iy3niG05rhzaD0K/
         5mJRdJl3Ts07KRxp/f70IXq0X6fH5jxc54OvzoLILi+2i4aZ8lcxOgc22fZz5AELx+
         jxdQL6+7di777t5ZsUpmXbMy7tcWBnPvZZV/XEI8=
Date:   Thu, 26 Mar 2020 09:14:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, anenbupt@gmail.com
Subject: Re: [PATCH] USB: io_edgeport: fix  slab-out-of-bounds Read in
 edge_interrupt_callback
Message-ID: <20200326081433.GA979574@kroah.com>
References: <1585122757-4528-1-git-send-email-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585122757-4528-1-git-send-email-hqjagain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 03:52:37PM +0800, Qiujun Huang wrote:
> The boundary condition should be (length - 1) as we access data[position+1].
> 
> Reported-and-tested-by: syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  drivers/usb/serial/io_edgeport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> index 5737add..4cca0b8 100644
> --- a/drivers/usb/serial/io_edgeport.c
> +++ b/drivers/usb/serial/io_edgeport.c
> @@ -710,7 +710,7 @@ static void edge_interrupt_callback(struct urb *urb)
>  		/* grab the txcredits for the ports if available */
>  		position = 2;
>  		portNumber = 0;
> -		while ((position < length) &&
> +		while ((position < length - 1) &&
>  				(portNumber < edge_serial->serial->num_ports)) {
>  			txCredits = data[position] | (data[position+1] << 8);
>  			if (txCredits) {
> -- 
> 1.8.3.1
> 

Johan, any objection from me taking this in my tree now?

thanks,

greg k-h
