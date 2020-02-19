Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A779EC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C94B24672
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NQ3bDPR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgBSPP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:15:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgBSPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=XeL6LCi2HGnzcbE5ZCpOQlzWnrcj0g6s0cgd62YAoiY=; b=NQ3bDPR7GS/aiOhZMtWcmVSCfs
        7BTql1fH2tqu1P6YIXpTbpE2eoYsg4KV5TkzDqbXp/KvXmwMecqXuhhxY8UUa5ZcaQGi5/wIVMqXV
        uamD+J6CG7dVyq3YIN5xZmo3lAOqrQuba53B8fZLITTGSu1s1xKgUnjtqoXvS3BvvE4+l81Eid0H/
        mSNFBdXv3jNhD13kPZwbj4SS50U4p710hbqSoXt4G7Dlb7OTZEgrsaXJgIoVvvgHa3JPFsHdjNgEf
        mVaxsueySMflR1iDyL3YLScMQsnHWYhlO0S8P0yAel16kLJERkjGSl5vGEp88VHVKj0uH+1a4ZD1u
        A/F6mgrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R3A-0007fV-KE; Wed, 19 Feb 2020 15:14:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 005073077F5;
        Wed, 19 Feb 2020 16:12:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 915502B4D7B83; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150745.125119627@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v3 13/22] tracing: Remove regular RCU context for _rcuidle tracepoints (again)
References: <20200219144724.800607165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
taught perf how to deal with not having an RCU context provided.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/tracepoint.h |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
 		 * For rcuidle callers, use srcu since sched-rcu	\
 		 * doesn't work from the idle path.			\
 		 */							\
-		if (rcuidle) {						\
+		if (rcuidle)						\
 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
-			rcu_irq_enter_irqsave();			\
-		}							\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
@@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle) {						\
-			rcu_irq_exit_irqsave();				\
+		if (rcuidle)						\
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
-		}							\
 									\
 		preempt_enable_notrace();				\
 	} while (0)


