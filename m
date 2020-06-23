Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C27DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C81120780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YgiRjbS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbgFWQin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbgFWQin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:38:43 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47FC061573;
        Tue, 23 Jun 2020 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RzoHJHCZ7hm1ROHNKEIr2G/Z119807J1u519SSBhfx0=; b=YgiRjbS+IO71QOmY2cByo1vbGd
        Gr24I10sI0aOw80E4fgkhtZ/AKg3XhTw57Qw6cjSh/E0wUOY1uFLr5SvBxinBVMLvOYhvKKOIIOfS
        Ub2c1tYdQ/ZKB4e6yg6v3VKsF8VH6KvVMGJ6zlf5OFXjokqIYTpFZ4qOqMCAKFQbNhnfvbHyni2a+
        JPUMJ3W7qwtOc6iPpxmGRsIV7IeJ/WaFssNyCVTi/Zq3eC9ALn7KCDMlnIBgfSu2sLmSMiuBTZiyp
        ZYlO+YF76UT2iHB4NtD8Ja0m0I+D7XNLD2TfRoqDaV66RGO6WCaPNE0OI96yvwqw/YM4+1ZjVmLv+
        yI8aQuBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnlvS-0002Zv-1A; Tue, 23 Jun 2020 16:37:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C847F300F28;
        Tue, 23 Jun 2020 18:37:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B66FF234EBA5B; Tue, 23 Jun 2020 18:37:30 +0200 (CEST)
Date:   Tue, 23 Jun 2020 18:37:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk, elver@google.com
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623163730.GA4800@hirez.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 06:13:21PM +0200, Ahmed S. Darwish wrote:
> Well, freshly merged code is using it. For example, KCSAN:
> 
>     => f1bc96210c6a ("kcsan: Make KCSAN compatible with lockdep")
>     => kernel/kcsan/report.c:
> 
>     void kcsan_report(...)
>     {
> 	...
>         /*
>          * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
>          * we do not turn off lockdep here; this could happen due to recursion
>          * into lockdep via KCSAN if we detect a race in utilities used by
>          * lockdep.
>          */
>         lockdep_off();
> 	...
>     }

Marco, do you remember what exactly happened there? Because I'm about to
wreck that. That is, I'm going to make TRACE_IRQFLAGS ignore
lockdep_off().
