Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B915C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E8E20756
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ApUZGocY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgEVR5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:57:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51062 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730702AbgEVR5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SbtXz2KxBEXJVwWCF/dhZtyuKKpK8ni/j8x+ZnTXLmE=; b=ApUZGocY6403LXIv55sOILFDLz
        QEwHOlCRYKGJhB2DMRy9u3VcZwuGKDP0A7WbFtzpkFZ7tbszOrwkCarkm6Dh7IOSgVxtfuObQC4Dc
        igBILVPcuqfBXx3+bguBI4DSTIYwGQ6TB4QF/x1CmedC/kZFZAq+ZkHK5FadjqF7wfaUhYJOb8gf6
        Md4HSkDXgm43Tyg+uHvuXP6dhIMOZoFfMKGrUR0JT+gGni0BLL6Kq+8ScT9POYTu47ENOWT8FSDnO
        nWUFALAJXnYyqtdDGvtI73CqG0AURZQoo1YSQP0bALlE/tbtZoZouJc7iZvnDncZ/rlWpDBfcZaZp
        7Mn2VXOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcBsv-00083d-8x; Fri, 22 May 2020 17:55:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBD14305EEE;
        Fri, 22 May 2020 19:55:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B78A20B5D17E; Fri, 22 May 2020 19:55:03 +0200 (CEST)
Date:   Fri, 22 May 2020 19:55:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 07/25] lockdep: Add preemption disabled assertion API
Message-ID: <20200522175503.GQ325280@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-8-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519214547.352050-8-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:45:29PM +0200, Ahmed S. Darwish wrote:
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 206774ac6946..54c929ea5b98 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -702,6 +702,14 @@ do {									\
>  			  "Not in hardirq as expected\n");		\
>  	} while (0)
>  
> +/*
> + * Don't define this assertion here to avoid a call-site's header file
> + * dependency on sched.h task_struct current. This is needed by call
> + * sites that are inline defined at header files already included by
> + * sched.h.
> + */
> +void lockdep_assert_preemption_disabled(void);

So how about:

#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_TRACE_IRQFLAGS)
#define lockdep_assert_preemption_disabled() do { \
		WARN_ON(debug_locks && !preempt_count() && \
			current->hardirqs_enabled); \
	} while (0)
#else
#define lockdep_assert_preemption_disabled() do { } while (0)
#endif

That is both more consistent with the things you claim it's modelled
after and also completely avoids that header dependency.
