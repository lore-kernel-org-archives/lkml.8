Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C78C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4815207D8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tl+Go6jN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgFCLmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgFCLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:47 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB078C08C5C3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=DZFIrEVCB225to0ilfsUv+WkHWiGxuEfVVcHeS1Uxeg=; b=tl+Go6jNiKC54zdRV+VlFp6dX9
        bYKTyR3iXc2qjStURDDE5Wloz4fqe0V7OILwB+beN+beTbjbU1x4gOLotZODo/QFdhlDYqFbJekTi
        ZxfnXc/p7ruwcWjL6DE+9QUnBtylYBzkBwDZxu6AxocqQNy//O4wdwXRldJm6MCvXqeH9yFDhxbX5
        MqvHfHrnPvkGKXYQclY/2I1G6kKb4SFZug6WLmWSE/WuCMJfBToGHE8qGDk/ttTRUMm6Qg7Vf4EQS
        l+4s/63xxWNPKnLNIyP1K+AoKqpPH1kU7MS6yOYvXK7WsNQ6soN1m0BdcIYRWCOpHSNFfkazVqma9
        Ckrfo6qA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRms-0005og-UZ; Wed, 03 Jun 2020 11:42:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 10600306FFE;
        Wed,  3 Jun 2020 13:42:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C2359209DB0DC; Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Message-ID: <20200603114052.300804240@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Jun 2020 13:40:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 9/9] x86/entry, cpumask: Provide non-instrumented variant of cpu_is_offline()
References: <20200603114014.152292216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: exc_nmi()+0x12: call to cpumask_test_cpu.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_check_crashing_cpu()+0x12: call to cpumask_test_cpu.constprop.0()leaves .noinstr.text section

  cpumask_test_cpu()
    test_bit()
      instrument_atomic_read()
      arch_test_bit()

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/mce/core.c |    2 +-
 arch/x86/kernel/nmi.c          |    2 +-
 include/linux/cpumask.h        |   15 ++++++++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1083,7 +1083,7 @@ static noinstr bool mce_check_crashing_c
 {
 	unsigned int cpu = smp_processor_id();
 
-	if (cpu_is_offline(cpu) ||
+	if (arch_cpu_is_offline(cpu) ||
 	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
 
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -478,7 +478,7 @@ static DEFINE_PER_CPU(unsigned long, nmi
 
 DEFINE_IDTENTRY_NMI(exc_nmi)
 {
-	if (IS_ENABLED(CONFIG_SMP) && cpu_is_offline(smp_processor_id()))
+	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
 		return;
 
 	if (this_cpu_read(nmi_state) != NMI_NOT_RUNNING) {
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -888,7 +888,20 @@ static inline const struct cpumask *get_
 	return to_cpumask(p);
 }
 
-#define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
+#if NR_CPUS > 1
+static __always_inline bool arch_cpu_online(int cpu)
+{
+	return arch_test_bit(cpu, cpumask_bits(cpu_online_mask));
+}
+#else
+static __always_inline bool arch_cpu_online(int cpu)
+{
+	return cpu == 0;
+}
+#endif
+
+#define arch_cpu_is_offline(cpu)	unlikely(!arch_cpu_online(cpu))
+#define cpu_is_offline(cpu)		unlikely(!cpu_online(cpu))
 
 #if NR_CPUS <= BITS_PER_LONG
 #define CPU_BITS_ALL						\


