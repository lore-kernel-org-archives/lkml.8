Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA494C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F12220673
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQDZAPmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgELOZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgELOZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:25:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:25:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m24so12383636wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Id76DUUx7BnCr5PksX/RIXDmuZEvMLrGK6iNbMFQn+M=;
        b=eQDZAPmTTPyiCe56SuT9EzeYjpzxoz1Hky2+xzFEQTSscBQvhvcOxcAiDgZjSfXiqx
         qAcIp1pinbm5IAAhK1KO2kD/zr+ekAOYCav+lfUOBKbFhvv+Q3yP2mGapHhY6QmdbZ7W
         or1/3gFQaJZOpUE4jo65P57NPBl1wO3Y5Tpa2r3CSSZDRHP5tyxNXpIifxop5u5GDUca
         DfMWpC+tBWbhQPsIts+F9FL1ippOzG70eajkhMGpU0Xm7SY/lguQBXTJy0//jcsi0hHH
         gm0SBaIfBEVZARsYTGDCikCjZLTBPo1NEXa5M+EC+p3DLFugr+PToE+XZZmWn/oI9xzo
         Xhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Id76DUUx7BnCr5PksX/RIXDmuZEvMLrGK6iNbMFQn+M=;
        b=RVKUIMaQiSTJeCSBi5RsB8UTzS5gryY0Byf+k83RftCzU0sTMVTawEu7159w6WtPAP
         1zJotD0yv35B4FNeLaFWODOZKQvXo1RjqPbUQpNPrX26Yixp3u+yLdYeaKuGTzvDNAsN
         6VXlhPZnYVLH/OmQfgZpS54jRW+fIwamDhHwaE4ZEHF0W2iNYfHYzCtFGRJCxadceF1A
         VkQvf58iU5EqBBgfm4Q87XLujl6sQxBUzFBTyz6NwEBP0ZwkmIrJubCaA7NuGWvFsKyz
         Yduovg2SKyhG/ZTTrEO2JPngJzZH0bMTt73zL8k06dcaphCOn3y+HGhiAnV5hw/Jdxio
         pFqA==
X-Gm-Message-State: AGi0PubSLmZ0oPilpzRqKoMwjDy4NlcOoQS5oZzoSpjnOFXTCTR6F2LI
        2ysHEyvLwLyxISSKNyJtax6EspenD+PQ+A==
X-Google-Smtp-Source: APiQypKv25eha3G11RcrJWFD7ghsZkSKgRpbG4Esl49WWvuGkAdPYPYmzLGk6Dp9On3WQUNUTsNf6g==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr11635494wmi.124.1589293537286;
        Tue, 12 May 2020 07:25:37 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c19sm24088581wrb.89.2020.05.12.07.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 07:25:35 -0700 (PDT)
Date:   Tue, 12 May 2020 15:25:33 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kgdb: Fix broken handling of printk() in NMI context
Message-ID: <20200512142533.ta4uejwmq5gchtlx@holly.lan>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:18:34PM +0530, Sumit Garg wrote:
> Since commit 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> in NMI"), kgdb entry in NMI context defaults to use safe NMI printk()

I didn't see the author on Cc: nor any of the folks whose hands it
passed through. It would definitely be good to involve them in this
discussion.


> which involves CPU specific buffers and deferred printk() until exit from
> NMI context.
> 
> But kgdb being a stop-the-world debugger, we don't want to defer printk()
> especially backtrace on corresponding CPUs. So instead switch to normal
> printk() mode in kgdb_cpu_enter() if entry is in NMI context.

So, firstly I should *definitely* take a mea cupla for not shouting
about this at the time (I was on Cc:... twice). Only thing I can say
confidently is that the test suite didn't yell about this and so I
didn't look at this as closely as I should have done (and that it
didn't yell is mostly because I'm still building out the test suite
coverage).

Anyhow...

This feels a little like we are smearing the printk() interception logic
across the kernel in ways that make things hard to read. If we accepted
this patch we then have, the new NMI interception logic, the old kdb
interception logic and some hacks in the kgdb trap handler to defang the
NMI interception logic and force the kdb logic to kick in.

Wouldn't it be better to migrate kdb interception logic up a couple of
levels so that it continues to function even when we are in nmi printk
mode. That way *all* the printk() interception code would end up in
one place.

Finally some clue description of how to provoke the problem would be
useful... that sort of things helps me to grow the test suite coverage.


Daniel.


> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> 
> Similar change was posted earlier specific to arm64 here [1]. But after
> discussions it emerged out that this broken handling of printk() in NMI
> context should be a common problem that is relevant to other archs as well.
> So fix this handling in kgdb_cpu_enter() as there can be multiple entry
> points to kgdb in NMI context.
> 
> [1] https://lkml.org/lkml/2020/4/24/328
> 
>  kernel/debug/debug_core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 2b7c9b6..ab2933f 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -567,6 +567,15 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  	kgdb_info[ks->cpu].enter_kgdb++;
>  	kgdb_info[ks->cpu].exception_state |= exception_state;
>  
> +	/*
> +	 * kgdb entry in NMI context defaults to use safe NMI printk() which
> +	 * involves CPU specific buffers and deferred printk() until exit from
> +	 * NMI context. But kgdb being a stop-the-world debugger, we don't want
> +	 * to defer printk(). So instead switch to normal printk() mode here.
> +	 */
> +	if (in_nmi())
> +		printk_nmi_exit();
> +
>  	if (exception_state == DCPU_WANT_MASTER)
>  		atomic_inc(&masters_in_kgdb);
>  	else
> @@ -635,6 +644,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  			atomic_dec(&slaves_in_kgdb);
>  			dbg_touch_watchdogs();
>  			local_irq_restore(flags);
> +			if (in_nmi())
> +				printk_nmi_enter();
>  			return 0;
>  		}
>  		cpu_relax();
> @@ -772,6 +783,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  	raw_spin_unlock(&dbg_master_lock);
>  	dbg_touch_watchdogs();
>  	local_irq_restore(flags);
> +	if (in_nmi())
> +		printk_nmi_enter();
>  
>  	return kgdb_info[cpu].ret_state;
>  }
> -- 
> 2.7.4
> 
