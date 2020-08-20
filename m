Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4179FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22955206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgHTODL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730653AbgHTNy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:54:59 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2780206DA;
        Thu, 20 Aug 2020 13:54:57 +0000 (UTC)
Date:   Thu, 20 Aug 2020 09:54:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rjw@rjwysocki.net, joel@joelfernandes.org,
        svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH 1/9] lockdep: Use raw_cpu_*() for per-cpu variables
Message-ID: <20200820095456.6550b78a@oasis.local.home>
In-Reply-To: <20200820074640.342269393@infradead.org>
References: <20200820073031.886217423@infradead.org>
        <20200820074640.342269393@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 09:30:32 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> +++ b/include/linux/lockdep.h
> @@ -535,19 +535,27 @@ do {									\
>  DECLARE_PER_CPU(int, hardirqs_enabled);
>  DECLARE_PER_CPU(int, hardirq_context);
>  
> +/*
> + * The below lockdep_assert_*() macros se raw_cpu_read() to access the above

 s/se/use/ ?

-- Steve
	
> + * per-cpu variables. This is required because this_cpu_read() will potentially
> + * call into preempt/irq-disable and that obviously isn't right. This is also
> + * correct because when IRQs are enabled, it doesn't matter if we accidentally
> + * read the value from our previous CPU.
> + */
