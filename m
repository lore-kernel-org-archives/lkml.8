Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875DAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A1A2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LppZWpUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFBSra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:47:29 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E78BC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:47:29 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id f89so2299957qva.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Ek/i/6ax6ZbXrDVWsNeagdjRVYMfWWo92kpBvqURLc=;
        b=LppZWpUdNriiyHnLSTR7EoXopJSgF50Fg0SDsKilB92+au5FkrfdbbZA88O7fiaujy
         rCPGNy84abgA2FoZBfAqUz/sMIMNP0PByfkxmuoXEaUPPAZCkQfkn3spgV7hps6DIVCd
         HviyA2Ulz80HeQ0A091ARwEy0YDbb1AnwdQrNIusvzgx6+RfL8xCAjqlPj+LqttT59eP
         iYvcvnj3mpLI+JKoTTfhpKU+iVUvogrF1sFspdSEGfMEsVxpTHb0PpmjRD6rke/6BWsi
         NWU7DrfwbCPNU74TcXLPLjv4FlHMA4Fis4qo0eEOvRl0tXgsjKnNz2gzPIjmv/P9OEhj
         LYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Ek/i/6ax6ZbXrDVWsNeagdjRVYMfWWo92kpBvqURLc=;
        b=SYxk+jQ3CN7Z+i4fmPJfr83UaWLA891c32dIrJYd9gJ/mvwwyJ1D00t2AeH8JPq/oI
         O0ICfAR2fYWz+49I5x4mMj43Z7A6bw/hEWPBE+xKvYcrLKdJmrzEd0nnmZVdmMsQ/k0R
         voV4sfQ7NKMrqsFJWVJMByyz9Opcc052x/j1cMBv+DHvTOvj0H99MxTqsshiNjfKPedg
         iDgwyT12v43XBLhu25qBC5SvLsA6Chb5im1BG1OfmmtaeNAfRMpfcZ3c4kUSuATYHgVV
         eQDdPkLJ+83f4aPa4kBePEQ61BKpX0a4YLcxzeZod9T7+9S7iVU7HU9E5ytsWAN69mv3
         xKqw==
X-Gm-Message-State: AOAM532Sc5erGtqlfsaN1GwmPh/hmexJ8+I2+4rLHNUmTLtqDODEHh9T
        2m/xzlaUZtBplTphV8e7KU7VNphw4uffmQ==
X-Google-Smtp-Source: ABdhPJz5qHBqjeOiFEIVRjToyL8LZDQGkfq2HX9tcEnka+4baxtizORgBdeZqLo9JIMzqtpopg6JBg==
X-Received: by 2002:a05:6214:365:: with SMTP id t5mr11153638qvu.126.1591123648788;
        Tue, 02 Jun 2020 11:47:28 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l2sm3708904qtc.80.2020.06.02.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:47:28 -0700 (PDT)
Date:   Tue, 2 Jun 2020 14:47:20 -0400
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/14] x86/entry: Clarify irq_{enter,exit}_rcu()
Message-ID: <20200602184720.GA1607@lca.pw>
References: <20200529212728.795169701@infradead.org>
 <20200529213321.359433429@infradead.org>
 <20200602144235.GA1129@lca.pw>
 <20200602150511.GH706478@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602150511.GH706478@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 05:05:11PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 02, 2020 at 10:42:35AM -0400, Qian Cai wrote:
> 
> > Reverted this commit fixed the POWER9 boot warning,
> 
> ARGH, I'm an idiot. Please try this instead:
>
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index a3eb6eba8c41..c4201b7f42b1 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -438,7 +438,7 @@ void irq_exit_rcu(void)
>   */
>  void irq_exit(void)
>  {
> -	irq_exit_rcu();
> +	__irq_exit_rcu();
>  	rcu_irq_exit();
>  	 /* must be last! */
>  	lockdep_hardirq_exit();

This works fine.
