Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127ABC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89C823D3B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586182936;
	bh=079T5wNZmSG8ZgElAL/OT/dS/9EsBX27bHZ9pHlhHc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LTp0YLtbw9GY8yJ8C54nYFvB5GqW+zoDygne+tl+p2xmDFMaYGTHAHcuqmrmbQdKq
	 fz94ZHUqYCBemCbOLeDzBgNJgaKW9g0OieINs7qRvYS19606XCA2BqP0SHfomTB1Sc
	 cKGQPx4khz1vTXRQYAD6PViT85K83tJktV5mBv7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgDFOWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgDFOWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:22:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D50C23D4D;
        Mon,  6 Apr 2020 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586182934;
        bh=079T5wNZmSG8ZgElAL/OT/dS/9EsBX27bHZ9pHlhHc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATLYI5tDGQeBumcAM2blpXje1MIDHzL0PJrmYX6l244ju4FDGPaeLvzqYkcItaI8h
         8YEi/zGP7kQdZFsDpAhji+JYnAOqfzuJsxZvf+w7Vh1pBXjM3V+RTC3rv9S1qQyvUC
         hmtDvVYkq13RNfTKPTIpQ319x4GJqAb9KERFRg6Q=
Date:   Mon, 6 Apr 2020 16:22:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: vt6656: Use define instead of magic number
 for tx_rate
Message-ID: <20200406142212.GA48502@kroah.com>
References: <20200404141400.3772-1-oscar.carter@gmx.com>
 <20200404141400.3772-3-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404141400.3772-3-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 04:13:59PM +0200, Oscar Carter wrote:
> Use the define RATE_11M present in the file "device.h" instead of the
> magic number 3. So the code is more clear.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/staging/vt6656/baseband.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
> index 3e4bd637849a..a785f91c1566 100644
> --- a/drivers/staging/vt6656/baseband.c
> +++ b/drivers/staging/vt6656/baseband.c
> @@ -24,6 +24,7 @@
> 
>  #include <linux/bits.h>
>  #include <linux/kernel.h>
> +#include "device.h"
>  #include "mac.h"
>  #include "baseband.h"
>  #include "rf.h"
> @@ -141,7 +142,7 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 pkt_type,
> 
>  	rate = (unsigned int)vnt_frame_time[tx_rate];
> 
> -	if (tx_rate <= 3) {
> +	if (tx_rate <= RATE_11M) {
>  		if (preamble_type == 1)
>  			preamble = 96;
>  		else
> --
> 2.20.1

This doesn't apply to my tree :(

