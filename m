Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F323C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2EF2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdmt9jvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgEVQDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgEVQDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:03:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD3C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:03:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l17so10686209wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v7wWb7qz1S/4lL8SzUygns1tNzo6SO+dGchGg8zLr9M=;
        b=pdmt9jvSDpqc8VKxRM6ywNws6EyfZ67QtvF5KUqSkObbIgXcqhf0pYqSji8iOn8wQ8
         rU62omd9QZzYnv0h34TdkeRL09Mpgdg4IkTLQOBm1sLhwj+gbl2oKLfFvy7ce0oijm8V
         I/ZtkWI0RbSw8rfaiSKOEoGBDtZKM0JjjDJzisQ4JwxF1zM72dqqxb7/IUTFKUkYSaEY
         t12b5VowqgPLJelJ/1PHZNO9vzM/IwdBY7qU/qzOk5oHUzLNmzj5IErvaNGnQbq1hSi6
         obORDL0EH4eMh9H5EQuR2E1ESTS7zWZ09YuwTlPZRlgKrKSiM4IlXe3KhHTNpj5MfAfU
         lX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v7wWb7qz1S/4lL8SzUygns1tNzo6SO+dGchGg8zLr9M=;
        b=LkMcsUBsCc0g8Pp4PxBKyBkBnxOPEhWvVppZYE1QKQWl2F+aCy6PaNYV+HNSieeqTc
         cPXkoeoP6vS8Lg/0XZnt7zsY73u5xUG0dvtpt6WDOp9Uxz3VwaNqDX5pXmO0uI58I+l8
         q0XEvDi7EVDAdwBeC7AOVX7sreLyiCfZScfokTb3VE1vY0mGkd/g9k/li6lHtTZv/Mpp
         nY1rnKmKcri6O/flthViHVq8YsVLONLVQ0ZvaHsL8lhqeqgjy1wvzfyI8juSXKUJi9a7
         QRizDyc/PMB096/E0vvtr2BBGHzQccuJN5zPqk4hNWlNZlIL1Q5WSSeAzkYiTh1wo8LH
         emIA==
X-Gm-Message-State: AOAM530aJp7iI588/EXYvpyVfpBQaGe+Xws9z9eyZUYs0nLXY/oqeTpa
        JVdT7RWBHfvO3qg1lppCXyCtjA==
X-Google-Smtp-Source: ABdhPJwU51KpmkS467wd2YMDKD0z34ZlqcGlXENl9FRlqREBHGZ+7bsCCEAi8bTDtYZlmauzrcd5QQ==
X-Received: by 2002:adf:e84e:: with SMTP id d14mr3802982wrn.31.1590163381322;
        Fri, 22 May 2020 09:03:01 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v205sm9818955wmg.11.2020.05.22.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 09:03:00 -0700 (PDT)
Date:   Fri, 22 May 2020 17:02:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] kdb: Switch kdb_printf to use safer console poll APIs
Message-ID: <20200522160258.yq63iigp74u3ngtn@holly.lan>
References: <1590158071-15325-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590158071-15325-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 08:04:31PM +0530, Sumit Garg wrote:
> In kgdb NMI context, polling driver APIs are more safer to use instead
> of console APIs since the polling drivers know they will execute from
> all sorts of crazy places. And for the most common use cases this would
> also result in no console handler ever being called. So switch to use
> polling driver APIs in case a particular console supports polling mode.

This comment seems rather half hearted, not least because it doesn't
explain what the current problem is nor why using the polling API is
safer.

Compare the above against the advice in
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
and I think it comes up short. Perhaps also consider Ingo Molnar's much
more concise suggestion on describing changes:

: Please use the customary changelog style we use in the kernel:
:   " Current code does (A), this has a problem when (B).
:   We can improve this doing (C), because (D)."
-- http://lkml.iu.edu/hypermail//linux/kernel/1311.1/01157.html


> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 3a5a068..8e0d581 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -24,6 +24,7 @@
>  #include <linux/kgdb.h>
>  #include <linux/kdb.h>
>  #include <linux/kallsyms.h>
> +#include <linux/tty_driver.h>
>  #include "kdb_private.h"
>  
>  #define CMD_BUFLEN 256
> @@ -699,11 +700,24 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  			}
>  		}
>  		for_each_console(c) {
> +			int line;
> +			struct tty_driver *p;
> +
>  			if (!(c->flags & CON_ENABLED))
>  				continue;
> -			++oops_in_progress;
> -			c->write(c, cp, retlen - (cp - kdb_buffer));
> -			--oops_in_progress;
> +			p = c->device ? c->device(c, &line) : NULL;
> +			if (p && p->ops && p->ops->poll_put_char) {

What prevents this logic from matching an active console that hasn't
been selected as the polling driver?


> +				len = retlen - (cp - kdb_buffer);
> +				cp2 = cp;
> +				while (len--) {
> +					p->ops->poll_put_char(p, line, *cp2);
> +					cp2++;
> +				}

Assuming it is possible to identify the console that matches the
currently selected polling driver can't we just drop the
is_console test and get rid of this branch entirely.

The only reason for the is_console test is to avoid issuing messages
twice so if we are able to suppress the c->write() for the same UART
then is_console check becomes pointless and can go.


> +			} else {
> +				++oops_in_progress;
> +				c->write(c, cp, retlen - (cp - kdb_buffer));
> +				--oops_in_progress;
> +			}
>  			touch_nmi_watchdog();
>  		}
>  	}
> @@ -765,11 +779,24 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  			}
>  		}
>  		for_each_console(c) {
> +			int line;
> +			struct tty_driver *p;
> +
>  			if (!(c->flags & CON_ENABLED))
>  				continue;
> -			++oops_in_progress;
> -			c->write(c, moreprompt, strlen(moreprompt));
> -			--oops_in_progress;
> +			p = c->device ? c->device(c, &line) : NULL;
> +			if (p && p->ops && p->ops->poll_put_char) {
> +				len = strlen(moreprompt);
> +				cp = moreprompt;
> +				while (len--) {
> +					p->ops->poll_put_char(p, line, *cp);
> +					cp++;
> +				}
> +			} else {
> +				++oops_in_progress;
> +				c->write(c, moreprompt, strlen(moreprompt));
> +				--oops_in_progress;
> +			}

Maybe also consider pulling the string emit to a separate function.


Daniel.
