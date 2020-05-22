Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FA1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70483204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgx8gKPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgEVKi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgEVKi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:38:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E030C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:38:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c11so184804wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u5ekOXjdCF2nXbH79Q7LEzQnOc+V4196q80nwEIT7VA=;
        b=jgx8gKPEEC5mEz2yG91WCd5ZuM4Tmq4dCB0P2h5QZSt1i3CBWgJVuVBSKsmNx64ozJ
         K1oMO9EQJpyOkKLDNiu9s7//cbq+ZUMpLZWg8kmH6G9svyi9AV1od3hvbpkpTzak3CMD
         gKwAgBoGpeBx+62gjOx0mLro+cpETGFAk6vlPlPFvYoozfUaS8Tl4zywEMYPHI8gJ5se
         uYeyWTGYuaBHwUaBjXCWFwbJkBdQ5/cLvKCmNArYBjxRjMd3m0my4cULw11OuqSXSK9+
         scdCP/LoGj3Ewn2ssu06CRRZ7oj+T1i8Z2qtT1m22DDCnvF1CuRwZAsxklUTF1mWNew6
         rOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u5ekOXjdCF2nXbH79Q7LEzQnOc+V4196q80nwEIT7VA=;
        b=XVwTYjcnkvCFpJQogSE3f0yd+sPusqE8KMID608aAPp8nTMqWQy2nspjSrXt0G9QDZ
         zSN7PfHLGuvYgKuRcQ9i1WIlIwh+l7OUxB5bhIicYbh0QGOWIQI15Yzg6E1euRzRfRhe
         Ku07vMZIqBIgGzjmcoOf45Le18MxGpwHHlzlzcT4HVpLxGiZwFne+pgDnzphlDzMX1RE
         p20n8Cm4j1V4rpc4OfLxCTQV/r6enwn6ZfbdAVW7B3Imjz9anJ/+kwYGSY7wMoJRmpzu
         +HrZZAXCJvdhGL4J9efpmnfE7lTUyayqEVcY0cIWAFroZfesOPdTi7nk3wkGi4mmZ+bg
         6p/g==
X-Gm-Message-State: AOAM5325OlNJAMl4T9Ul5uE+n08yosQ5zEb+29Jf6xg7W5pQYF3yWP0t
        imF2oMip40IZNb58nyz2XsPOgg==
X-Google-Smtp-Source: ABdhPJyVYVwpd2cGwbI1cwgrnY/FwYgZWa7g1HoGd9SZHh6oeSBCoGRmX2gu4z433mgSugYLpNKZ/A==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr2826884wrp.408.1590143906200;
        Fri, 22 May 2020 03:38:26 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s8sm6278286wrg.50.2020.05.22.03.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 03:38:25 -0700 (PDT)
Date:   Fri, 22 May 2020 11:38:23 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Make kdb_printf robust to run in NMI context
Message-ID: <20200522103823.uwb6jpjwpzhhjwwt@holly.lan>
References: <1590141746-23559-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590141746-23559-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 03:32:26PM +0530, Sumit Garg wrote:
> While rounding up CPUs via NMIs, its possible that a rounded up CPU
> maybe holding a console port lock leading to kgdb master CPU stuck in
> a deadlock during invocation of console write operations. So in order
> to avoid such a deadlock, invoke bust_spinlocks() prior to invocation
> of console handlers.
> 
> Also, add a check for console port to be enabled prior to invocation of
> corresponding handler.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 924bc92..e32ece6 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -699,7 +699,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  			}
>  		}
>  		for_each_console(c) {
> +			if (!(c->flags & CON_ENABLED))
> +				continue;
> +			bust_spinlocks(1);
>  			c->write(c, cp, retlen - (cp - kdb_buffer));
> +			bust_spinlocks(0);

I think it might actually be better to directly manipulate oops_in_progress
here.

bust_spinlocks(0) will call unblank_screen() and console_unblank() and
I don't think calling these is worth the risk (and whilst kicking klogd
is safe I think its also not required).


Daniel.



>  			touch_nmi_watchdog();
>  		}
>  	}
> @@ -761,7 +765,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  			}
>  		}
>  		for_each_console(c) {
> +			if (!(c->flags & CON_ENABLED))
> +				continue;
> +			bust_spinlocks(1);
>  			c->write(c, moreprompt, strlen(moreprompt));
> +			bust_spinlocks(0);
>  			touch_nmi_watchdog();
>  		}
>  
> -- 
> 2.7.4
> 
