Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D83DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C337207C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="SQtovXi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgFJLAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgFJLAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:00:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812CCC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:00:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c190029f750dc462a5b02.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:29f7:50dc:462a:5b02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B0AD1EC0317;
        Wed, 10 Jun 2020 13:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591786848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBzOABQUd591TyBEU9dsi0//qzbZT6iFLsu3+nMNxcQ=;
        b=SQtovXi38gLCy5hfVcdADCqEDzVedb2q9TE/Nvzkrdube+faNm9cxIvtzgiG7kwwfWhxwU
        gMMFSTya0B9xyP0aQ4am2o99oTgWHkqiOin8myn0bChPoiJuzemtXHpKzaD3QEWS0Rd6uw
        2iuBsi8K2HRnc0/EZadubvGGpsicxYc=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] x86/msr: Pass a single MSR value to __rwmsr_on_cpus() too
Date:   Wed, 10 Jun 2020 13:00:35 +0200
Message-Id: <20200610110037.11853-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610110037.11853-1-bp@alien8.de>
References: <20200610110037.11853-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

__rwmsr_on_cpus() is the low-level worker function which is called by
the exported {rd,wr}msr_on_cpus() when an MSR is supposed to be set with
values for CPUs or an MSR is supposed to be read from CPUs into an array
of percpu variables in @msrs.

The low-level machinery supports also passing a single MSR value for the
single CPU {rd,wr}msr_on_cpu() handlers.

Pass that value to __rwmsr_on_cpus() too and enforce a mutually
exclusive either a single MSR value "XOR" an array of per-CPU MSR
values.

This is the prerequisite for supporting writing the same MSR value on
multiple CPUs.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/lib/msr-smp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index fee8b9c0520c..15e1157d6b29 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -97,7 +97,7 @@ int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 EXPORT_SYMBOL(wrmsrl_on_cpu);
 
 static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
-			    struct msr *msrs,
+			    struct msr *msrs, u64 reg_val,
 			    void (*msr_func) (void *info))
 {
 	struct msr_info rv;
@@ -105,8 +105,13 @@ static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
 
 	memset(&rv, 0, sizeof(rv));
 
+	/* Can't have both. */
+	if (WARN_ON(msrs && reg_val))
+		return;
+
 	rv.msrs	  = msrs;
 	rv.msr_no = msr_no;
+	rv.reg.q  = reg_val;
 
 	this_cpu = get_cpu();
 
@@ -126,7 +131,7 @@ static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
  */
 void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
 {
-	__rwmsr_on_cpus(mask, msr_no, msrs, __rdmsr_on_cpu);
+	__rwmsr_on_cpus(mask, msr_no, msrs, 0, __rdmsr_on_cpu);
 }
 EXPORT_SYMBOL(rdmsr_on_cpus);
 
@@ -140,7 +145,7 @@ EXPORT_SYMBOL(rdmsr_on_cpus);
  */
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
 {
-	__rwmsr_on_cpus(mask, msr_no, msrs, __wrmsr_on_cpu);
+	__rwmsr_on_cpus(mask, msr_no, msrs, 0, __wrmsr_on_cpu);
 }
 EXPORT_SYMBOL(wrmsr_on_cpus);
 
-- 
2.21.0

