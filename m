Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E012C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0A52184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589045870;
	bh=+jhPw0rKcLdSwEpXP+vf94JohnnlOBJwaZ5En19kTlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/uwec0qBUniuW2de7TIT1lJNh5gTWlxK68ub1ZclcwVjGAwIxpb4miCsshEBBuoy
	 YNH/e1V9xPYYTq9HBoFg3sqa8mwYnwwN587geYYz2eNWjm3T7INJUjiRPbIMew5WkR
	 PX9clIdKSrRagvyf9crX7Dp09ti6XaUhu24EWAsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgEIRhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 13:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgEIRhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:37:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7719C2192A;
        Sat,  9 May 2020 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589045832;
        bh=+jhPw0rKcLdSwEpXP+vf94JohnnlOBJwaZ5En19kTlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mod8d75B92+rWLttUL4g2Tu+0EghX7N/Er7lNFB77Seg70dYLku1egPJ/XQX8QHWm
         aTy9DvIdaF4v6z0yfhER+D/UTTAVE6w8OSdBvl32XL0PWzcXgDN3MBdouQsA2B4AfN
         02Dbd3zQSHF83PDOHpt8Cx89z2Q8ITf8V+PW2AAM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v11 09/18] x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
Date:   Sat,  9 May 2020 13:36:46 -0400
Message-Id: <20200509173655.13977-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509173655.13977-1-sashal@kernel.org>
References: <20200509173655.13977-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

[ luto: Rename the variables from FS and GS to FSBASE and GSBASE and
  make <asm/fsgsbase.h> safe to include on 32-bit kernels. ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/fsgsbase.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index bca4c743de77c..fdd1177499b40 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -19,6 +19,36 @@ extern unsigned long x86_gsbase_read_task(struct task_struct *task);
 extern void x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase);
 extern void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase);
 
+/* Must be protected by X86_FEATURE_FSGSBASE check. */
+
+static __always_inline unsigned long rdfsbase(void)
+{
+	unsigned long fsbase;
+
+	asm volatile("rdfsbase %0" : "=r" (fsbase) :: "memory");
+
+	return fsbase;
+}
+
+static __always_inline unsigned long rdgsbase(void)
+{
+	unsigned long gsbase;
+
+	asm volatile("rdgsbase %0" : "=r" (gsbase) :: "memory");
+
+	return gsbase;
+}
+
+static __always_inline void wrfsbase(unsigned long fsbase)
+{
+	asm volatile("wrfsbase %0" :: "r" (fsbase) : "memory");
+}
+
+static __always_inline void wrgsbase(unsigned long gsbase)
+{
+	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
+}
+
 /* Helper functions for reading/writing FS/GS base */
 
 static inline unsigned long x86_fsbase_read_cpu(void)
-- 
2.20.1

