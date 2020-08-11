Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34715C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3602076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WH6Zpbi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgHKG1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgHKG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:27:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tHm64C/K319CawL1Utw9/ujWZDpftWfDesnIuDRE+5s=; b=WH6Zpbi2msSZ0uT5t9XaZ8WIr9
        j1QCkVRYlP8mX6dTCAAKSAG+FmMrHkmhMwuOYG/g11ibR9ur1RQeR6wPBhfPuCcRVt8a+ZBR5xd3s
        JkYrCpnA7AgXL6aDIiG62FkF4OQx6NwN/rfH0rnx6fm2rmJnlTskabmtkRuof2hBaHR40FRKsUWIz
        vpVZ2LfJX8Qa5UHXQnsUo7LHx+CX/1UXNswg5GhV/QEgx8mLyIP4vfQXUyosKD1U47PRNhM04CV/2
        ELKCcrYDUVqmHHT8SPQQuIqhbY6AT1xnwAGpVdGSt89Hxvjld7cZD97oTWnRYi8qyLbZMIxJPpPVD
        xk67ClZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Nl0-0001zc-UW; Tue, 11 Aug 2020 06:27:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D253A980CA0; Tue, 11 Aug 2020 08:27:33 +0200 (CEST)
Date:   Tue, 11 Aug 2020 08:27:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH 1/2 v3] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Message-ID: <20200811062733.GP3982@worktop.programming.kicks-ass.net>
References: <20200811000959.2486636-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811000959.2486636-1-posk@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 05:09:58PM -0700, Peter Oskolkov wrote:
> @@ -27,6 +35,12 @@
>  
>  static void ipi_mb(void *info)
>  {

The #ifdef wants to behere, otherwise you'll get a compile warning for
!RSEQ builds.

> +	int *flags = info;
> +
> +#ifdef CONFIG_RSEQ
> +	if (flags && (*flags == MEMBARRIER_FLAG_RSEQ))
> +		rseq_preempt(current);
> +#endif
>  	smp_mb();	/* IPIs should be serializing but paranoid. */
>  }

But yes, this looks much better.

Mathieu did mention a few other points that I didn't see addressed:

 - he didn't like abusing the @flags syscall argument for a CPUid;
 - he wondered if we should support SYNC_CORE + RSEQ.


Not sure we can easily change the syscall at this point, but the latter
point could be addressed with something like this.

---
Index: linux-2.6/kernel/sched/membarrier.c
===================================================================
--- linux-2.6.orig/kernel/sched/membarrier.c
+++ linux-2.6/kernel/sched/membarrier.c
@@ -374,8 +374,26 @@ static int membarrier_register_private_e
  */
 SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
 {
+	int cflags = 0, int cpuid = -1;
+
 	if (unlikely(flags) && cmd != MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
 		return -EINVAL;
+
+	if (cmd & (MEMBARRIER_CMD_PRIVATE_EXPEDITED |
+		   MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE |
+		   MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)) {
+
+		if (cmd & MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
+			cflags |= MEMBARRIER_FLAG_RSEQ;
+
+		if (cmd & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
+			cflags |= MEMBARRIER_FLAG_SYNC_CORE;
+			cpuid = flags;
+		}
+
+		cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED;
+	}
+
 	switch (cmd) {
 	case MEMBARRIER_CMD_QUERY:
 	{
@@ -396,18 +414,16 @@ SYSCALL_DEFINE2(membarrier, int, cmd, in
 		return membarrier_global_expedited();
 	case MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED:
 		return membarrier_register_global_expedited();
-	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
-		return membarrier_private_expedited(0, -1);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
 		return membarrier_register_private_expedited(0);
-	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
-		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE, -1);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
 		return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
-	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
-		return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, flags);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
 		return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
+
+	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
+		return membarrier_private_expedited(cflags, cpuid);
+
 	default:
 		return -EINVAL;
 	}

