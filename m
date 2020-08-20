Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8968BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BFE20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgHTOHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731265AbgHTN6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:58:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABDC9206DA;
        Thu, 20 Aug 2020 13:58:49 +0000 (UTC)
Date:   Thu, 20 Aug 2020 09:58:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rjw@rjwysocki.net, joel@joelfernandes.org,
        svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH 2/9] sched,idle,rcu: Push rcu_idle deeper into the idle
 path
Message-ID: <20200820095848.5ee14ceb@oasis.local.home>
In-Reply-To: <20200820074640.401636694@infradead.org>
References: <20200820073031.886217423@infradead.org>
        <20200820074640.401636694@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 09:30:33 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> +++ b/drivers/cpuidle/cpuidle.c
> @@ -145,22 +145,27 @@ static void enter_s2idle_proper(struct c

[..]
>  	drv->states[index].enter_s2idle(dev, drv, index);
> -	WARN_ON(!irqs_disabled());
> +	if (WARN_ON(!irqs_disabled()))
> +		local_irq_disable();
>  	/*

This looks like a fix that should go in as a separate patch. As it
looks unrelated to this patch.

-- Steve
