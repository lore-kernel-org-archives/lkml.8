Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC59EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28EC2051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341097;
	bh=CKIMJQM3BUgv/kNo+zVhPYPGAjCSUM4KvYD2NODQKhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mFoPD7lqG+sYNpfGa3KEiEL8iAiG39dxwsiEyD19xH+ijCU53cuPpX8PuymNpP4eF
	 vgSdmcamq0q4wLtRHm/bFKnEyB4xUXP2XZeIstD7OYugrX69f+r7qwXW+kAn4mU4Qy
	 z1N7/AGz2GCLZnp8eV2PfDZnNcvnAtAYaWbNiuBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbgEANvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730772AbgEANic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:38:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17912173E;
        Fri,  1 May 2020 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340312;
        bh=CKIMJQM3BUgv/kNo+zVhPYPGAjCSUM4KvYD2NODQKhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yYOinUR7FAYWBey5qBSmlaXl/AUJ0gJiHnl35mjtV2rtuZ0xUpYqrPxyIhAEIb+O4
         FRf+2S2zeyNN1CyiDVFR5mMOCmfZI1Jjeoae3Y+z2jK0X+Fzuh7cYbfVXwbh9BSqGP
         RrSFH4qGrFhaRA/Q7AvnLjcJFFdU0HlgWWe69W/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.4 14/83] s390/ftrace: fix potential crashes when switching tracers
Date:   Fri,  1 May 2020 15:22:53 +0200
Message-Id: <20200501131527.389876682@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Rudo <prudo@linux.ibm.com>

commit 8ebf6da9db1b2a20bb86cc1bee2552e894d03308 upstream.

Switching tracers include instruction patching. To prevent that a
instruction is patched while it's read the instruction patching is done
in stop_machine 'context'. This also means that any function called
during stop_machine must not be traced. Thus add 'notrace' to all
functions called within stop_machine.

Fixes: 1ec2772e0c3c ("s390/diag: add a statistic for diagnose calls")
Fixes: 38f2c691a4b3 ("s390: improve wait logic of stop_machine")
Fixes: 4ecf0a43e729 ("processor: get rid of cpu_relax_yield")
Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/diag.c  |    2 +-
 arch/s390/kernel/smp.c   |    4 ++--
 arch/s390/kernel/trace.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -133,7 +133,7 @@ void diag_stat_inc(enum diag_stat_enum n
 }
 EXPORT_SYMBOL(diag_stat_inc);
 
-void diag_stat_inc_norecursion(enum diag_stat_enum nr)
+void notrace diag_stat_inc_norecursion(enum diag_stat_enum nr)
 {
 	this_cpu_inc(diag_stat.counter[nr]);
 	trace_s390_diagnose_norecursion(diag_map[nr].code);
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -403,7 +403,7 @@ int smp_find_processor_id(u16 address)
 	return -1;
 }
 
-bool arch_vcpu_is_preempted(int cpu)
+bool notrace arch_vcpu_is_preempted(int cpu)
 {
 	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
 		return false;
@@ -413,7 +413,7 @@ bool arch_vcpu_is_preempted(int cpu)
 }
 EXPORT_SYMBOL(arch_vcpu_is_preempted);
 
-void smp_yield_cpu(int cpu)
+void notrace smp_yield_cpu(int cpu)
 {
 	if (MACHINE_HAS_DIAG9C) {
 		diag_stat_inc_norecursion(DIAG_STAT_X09C);
--- a/arch/s390/kernel/trace.c
+++ b/arch/s390/kernel/trace.c
@@ -14,7 +14,7 @@ EXPORT_TRACEPOINT_SYMBOL(s390_diagnose);
 
 static DEFINE_PER_CPU(unsigned int, diagnose_trace_depth);
 
-void trace_s390_diagnose_norecursion(int diag_nr)
+void notrace trace_s390_diagnose_norecursion(int diag_nr)
 {
 	unsigned long flags;
 	unsigned int *depth;


