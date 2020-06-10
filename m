Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE48C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1E1206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="J6cLlSM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgFJLAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgFJLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:00:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4462CC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:00:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c190029f750dc462a5b02.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:29f7:50dc:462a:5b02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C87C91EC0337;
        Wed, 10 Jun 2020 13:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591786848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8D/Xd4asti5WQ80/nNPSNC21MIxmP2e26aliItYjwlQ=;
        b=J6cLlSM4lAeA5Zda4NkEZZIoTvZnDv7pdBuFBtw/tpMfkBTrj3wEzGUwD6Cx43nK/GxX3Q
        pGj5ikcGvPEViMrZRTQ+Kvhpm02ppqzRO5ld2NTy0X7lgTmCKCbtXa7ZSqE6G++QRJzhbc
        sE6Qhh4r9oNsCFfE5sBIKNqDO5KF9DM=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] x86/msr: Add wrmsrl_val_on_cpus()
Date:   Wed, 10 Jun 2020 13:00:36 +0200
Message-Id: <20200610110037.11853-3-bp@alien8.de>
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

Add a helper which writes the same MSR value on a set of CPUs.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/msr.h |  8 ++++++++
 arch/x86/lib/msr-smp.c     | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 86f20d520a07..71393a4c2104 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -342,6 +342,7 @@ int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
+void wrmsrl_val_on_cpus(const struct cpumask *mask, u32 msr_no, u64 reg_val);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
@@ -379,6 +380,13 @@ static inline void wrmsr_on_cpus(const struct cpumask *m, u32 msr_no,
 {
 	wrmsr_on_cpu(0, msr_no, msrs[0].l, msrs[0].h);
 }
+
+static inline void wrmsrl_val_on_cpus(const struct cpumask *mask, u32 msr_no,
+				      u64 reg_val)
+{
+	wrmsrl(msr_no, reg_val);
+}
+
 static inline int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no,
 				    u32 *l, u32 *h)
 {
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 15e1157d6b29..f67ee2fdec69 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -149,6 +149,21 @@ void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
 }
 EXPORT_SYMBOL(wrmsr_on_cpus);
 
+/*
+ * wrmsr a single MSR value on a bunch of CPUs. To be used for MSRs which are
+ * the same on each core.
+ *
+ * @mask:       which CPUs
+ * @msr_no:     which MSR
+ * @reg_val:	MSR value
+ *
+ */
+void wrmsrl_val_on_cpus(const struct cpumask *mask, u32 msr_no, u64 reg_val)
+{
+	__rwmsr_on_cpus(mask, msr_no, NULL, reg_val, __wrmsr_on_cpu);
+}
+EXPORT_SYMBOL(wrmsrl_val_on_cpus);
+
 struct msr_info_completion {
 	struct msr_info		msr;
 	struct completion	done;
-- 
2.21.0

