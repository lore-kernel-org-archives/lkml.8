Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF98C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07ED92054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoBQcU/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbgEVQfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgEVQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:35:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B521C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:35:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so10728087wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aJwZ3Ckwgo1m0H1dH17N6VKfpW1UDHWvmlrmQBPFQ0Y=;
        b=eoBQcU/hPq3Tho3ql0eupAFwWPYksaNn6M2AuoyE02KKzBjkGj4EkJUbuiCDBACi8S
         VehjIN4LHqNY7n6zJoEB5evLeJSLObftp8ANDCZn/KRJaNZvDkb7usMJF2Rs3VEreeM8
         u7vZiGnBXD/FNIETzkdaKLfPi8NQTvQNIpqWrtvFt/DBDIlRm6zc1rZpqu1da1Bkm3ti
         TNjn4IAPotifhxTXaOUcj5QCH+Q0BqDvHQdZuKcCG4HuE8KuhuRpuY3USOtRrLDnt2JS
         kg+ZF3b1ac4jdtQ40LZzTCvRrKGz6G/Uymr4+sFH6n3X4t1RgNCKPPAgkGCuz2jXjYuy
         sDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJwZ3Ckwgo1m0H1dH17N6VKfpW1UDHWvmlrmQBPFQ0Y=;
        b=sCa2FW93LNdvBrXkHgzWMYSB+bywTsZxgXesQcjCc80aMLcpBcj0k28jE1z4+MPaMH
         3b1Rs47ik2C8zsgzh0Zsv86RFI6Zoc/RjrOAcgEyl+VQ6H4iM9rPfHFkA/990hxm7BfU
         bpNAE1OQ8c/kMNIdQWlhoHaDXjJxEdjthIi1nloZiP4ZuRuFIHMxiue108uKv5TUmkvk
         YJCI3OV5h2H1U5PJnmE9trovzzm63breBHYYPlCQCPLQXLKq6j4Fv5uWpZFP0bqcbIVi
         kVAVLWQ7FsYfKJVvP7Rk+X4ZlVSD7QwwV7bpNtIRx1ChRmXJBmSa4qArNlvJLjpOTFO1
         BKSg==
X-Gm-Message-State: AOAM530HxPfEZCJDr81VilixX/OANbfYgzmSrB2yleDtMj00F56qoIxu
        EltqY9oun2fTJymKXho5Cp9fwHqwEXU=
X-Google-Smtp-Source: ABdhPJw0guDo/MfMaCq0B2Q9JalhSQNRqc3cjYJ1Pvcldrh+o3y5FDpBv0a/tek2Yd0Zf6CDaY/Cng==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr3908152wrw.93.1590165311120;
        Fri, 22 May 2020 09:35:11 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id p9sm9916855wrj.29.2020.05.22.09.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 09:35:10 -0700 (PDT)
Date:   Fri, 22 May 2020 17:35:08 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kdb: Make kdb_printf robust to run in NMI context
Message-ID: <20200522163508.e7476dd2vulntppc@holly.lan>
References: <1590158027-15254-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590158027-15254-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 08:03:47PM +0530, Sumit Garg wrote:
> While rounding up CPUs via NMIs, its possible that a rounded up CPU
> maybe holding a console port lock leading to kgdb master CPU stuck in
> a deadlock during invocation of console write operations. So in order
> to avoid such a deadlock, invoke bust_spinlocks() prior to invocation
> of console handlers.
> 
> Also, add a check for console port to be enabled prior to invocation of
> corresponding handler.

Perhaps this should have been two patches.

In fact, to be honest, I'd suggest combining all the patches to improve
kdb console handling (including a fixed version of the RFC) into a
single patch set.


> Suggested-by: Petr Mladek <pmladek@suse.com>
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> 
> Changes in v2:
> - Use oops_in_progress directly instead of bust_spinlocks().
> 
>  kernel/debug/kdb/kdb_io.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 924bc92..3a5a068 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -699,7 +699,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  			}
>  		}
>  		for_each_console(c) {
> +			if (!(c->flags & CON_ENABLED))
> +				continue;
> +			++oops_in_progress;

Given the subtly of what is going on I think we need some comments in
the code on what we are doing and why.


>  			c->write(c, cp, retlen - (cp - kdb_buffer));
> +			--oops_in_progress;
>  			touch_nmi_watchdog();
>  		}
>  	}
> @@ -761,7 +765,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  			}
>  		}
>  		for_each_console(c) {
> +			if (!(c->flags & CON_ENABLED))
> +				continue;
> +			++oops_in_progress;
>  			c->write(c, moreprompt, strlen(moreprompt));
> +			--oops_in_progress;
>  			touch_nmi_watchdog();

As with the other patches maybe the first patch in the set should be
factoring out the common code before making changes to it.


Daniel.
