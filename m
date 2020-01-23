Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6BBC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBB32465B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579746207;
	bh=1QmCH/JYy/sKFYSdAi0OoUw3eG/SDRKxnh1y7+VRTBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qa95n3a/2Agj0CZmLf4X+NxCpiw+N77tckUBArcs0WXVg2x0+xB0pZUeHaq1GAscX
	 7nPY4sJxPhJaezEuEYCOE+vEf8SECUMKNkhiRtDXodNvGhmCyLabiJOMRmBVhN7Ewg
	 adj3xdM+FBKVz8hWTpRyIGd3E2URNCMt0La2EPuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgAWCXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 21:23:10 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52755 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 21:23:09 -0500
Received: by mail-pj1-f67.google.com with SMTP id a6so464602pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 18:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cfSOjtYS4rLQfkETqk/xjea9kmEf0GUn36B+SElmJqQ=;
        b=akHRSSBWCjQEzrr//88cCDuITRHPxItXqixMdVHnQLow0anXycM/NP5/8be6w5rOKH
         jBStSde7rBNq02I0FXzNoJ9vvkSx9xIFlZwDCrxG1BPa5JMXbEGY7mOtp2wy9jodvbJQ
         qIpcJauz4H4fsSrlemuBX1Fw478ve42bF9fxBW2xuimF8nuAFpir9IOBEWQIp83PZ1+H
         UYzFtAQPMaQfIBbwHL8xK5nBkG0DnlMBg5tgNH07d2mn33ftZori8MuTcumCvykHaIkx
         EIsxbEDCWWZlbpOwU5X9Nlq1QIzJldSEUPD+GuaWpIfShRWt8mabpxZb8vOC6CYnu29+
         /CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cfSOjtYS4rLQfkETqk/xjea9kmEf0GUn36B+SElmJqQ=;
        b=SWv5mr2kI5WfwB0unpOhx/HDPA1WIY7YZYX+ILxYmuEH2kRDNOj2xFpeBIzAbpP9AV
         oZJPvjm6JpK8ttNdCKMECiyguZ14XPaetUefCkfim7QRoVZFFqoxACnamqSERLmdw2Bu
         8QZNeZg0CueLMKco4JmuBtJDNSjKeqrVysFr9H8xhI7hHmU3loti6IY2sSmP6EMA7U0g
         iTeveVCo4RdMXm+00xU07HnoVQDpV+2RSceqUCdrJjKU1rfCG3cUICenolSrPtr2xVyf
         6+fnAnrWnj68Q9wLdVNjDgtjXgZH6zWowl3B/uPm1Pn1IUywOzDOAbqfuyzi3wB9a046
         5Mwg==
X-Gm-Message-State: APjAAAVvc023dVSeydWicD5mfh9CH9QWwOzqwWBC21Hs5WRvrCrpQ6EU
        hnsLzkYi3DvupsMASi/Z28o=
X-Google-Smtp-Source: APXvYqxMKZBUH6of0XFcBsTyM8h63wm/3gcC/6ThgcyQpjTazVPHWCXCXyRbqiLRiqW3qGhHUGLWdw==
X-Received: by 2002:a17:902:bd96:: with SMTP id q22mr13265756pls.318.1579746188861;
        Wed, 22 Jan 2020 18:23:08 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id ep12sm313647pjb.7.2020.01.22.18.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 18:23:07 -0800 (PST)
Date:   Wed, 22 Jan 2020 18:23:05 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] zram: do not set ZRAM_IDLE bit for idlepage writeback in
 writeback_store()
Message-ID: <20200123022305.GF249784@google.com>
References: <20200121113557.11608-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121113557.11608-1-zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:35:57PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, we will call zram_set_flag() to set ZRAM_IDLE bit even for
> idlepage writeback. That is pointless. Let's set it only for hugepage mode.

Could you be more specific? What do you see the problem with that?

> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/block/zram/zram_drv.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 4285e75..eef5767 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -689,16 +689,18 @@ static ssize_t writeback_store(struct device *dev,
>  		if (mode == IDLE_WRITEBACK &&
>  			  !zram_test_flag(zram, index, ZRAM_IDLE))
>  			goto next;
> -		if (mode == HUGE_WRITEBACK &&
> -			  !zram_test_flag(zram, index, ZRAM_HUGE))
> -			goto next;
> +		if (mode == HUGE_WRITEBACK) {
> +			if (!zram_test_flag(zram, index, ZRAM_HUGE))
> +				goto next;
> +			/* Need for hugepage writeback racing */
> +			zram_set_flag(zram, index, ZRAM_IDLE);
> +		}
> +
>  		/*
>  		 * Clearing ZRAM_UNDER_WB is duty of caller.
>  		 * IOW, zram_free_page never clear it.
>  		 */
>  		zram_set_flag(zram, index, ZRAM_UNDER_WB);
> -		/* Need for hugepage writeback racing */
> -		zram_set_flag(zram, index, ZRAM_IDLE);
>  		zram_slot_unlock(zram, index);
>  		if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
>  			zram_slot_lock(zram, index);
> -- 
> 1.9.1
> 
