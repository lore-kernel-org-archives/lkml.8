Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E812C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B6A207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XLi1i0av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgHRLb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHRL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:28:25 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EEDC061349
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Thn9yqgRHu/PXpLQKdHMdfKNVEezxunukJ744Cn+7Tk=; b=XLi1i0avdpSzdJ3HpTlAsy5isC
        eXAVGEM0IuNXIJzRmebZRdiwvvH9dMTiGER0bqScGuBQt+yyfRPBzBTLAEgGyA/fRSTNEzpl/jqBu
        DY8xDlIfG5SbxdUR2txJUWXxbl1Eu2/8ASmNeOibRrYbu8M8biMc1DDwtlVxB+xkNsSW7ngdoQNDV
        S7NSAhYKCufk5U9RgT5bWLLXaGjbV9A5D7LepgopdbNiV+7isGGPYnfH8DJgD9n6Ia6aBV75gc5Yj
        WYutR3ZxneTuPWuSQprpe41WM3IzYSVOtx0QMkuaaFM/AzreCRQdwGu3S5D3O3C3xw1xYOP3ZA+9N
        E3Z5Sqng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7zmO-0002AJ-5H; Tue, 18 Aug 2020 11:27:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91FCA305815;
        Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 63876200D4C38; Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Message-ID: <20200818112418.196673066@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 12:51:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [PATCH v2 04/10] irq_work: Unconditionally build on SMP
References: <20200818105102.926463950@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/Makefile   |    1 +
 kernel/irq_work.c |    3 +++
 2 files changed, 4 insertions(+)

--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_TRACE_CLOCK) += trace/
 obj-$(CONFIG_RING_BUFFER) += trace/
 obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
+obj-$(CONFIG_SMP) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
 obj-$(CONFIG_KCSAN) += kcsan/
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <asm/processor.h>
 
+#ifdef CONFIG_IRQ_WORK
 
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
@@ -212,3 +213,5 @@ void irq_work_sync(struct irq_work *work
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
+
+#endif /* CONFIG_IRQ_WORK */


