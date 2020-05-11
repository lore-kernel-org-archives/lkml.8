Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795FC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F72208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589172827;
	bh=+jhPw0rKcLdSwEpXP+vf94JohnnlOBJwaZ5En19kTlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iuXsIm+7gnCE+WfTI+8RjZ51lft0doa3XuNrAGyBzWjdA5icbiYaidUt//75sbNZP
	 w8dTf5IEx3fNnbPNljiQOYp2xdAotAnSjhqfbMQiMjOR/a5Lt+oEkBugmX+2OuFpfF
	 1reeEjAbw/97FG9VMhE2kAZZOHn0x2cBDrFA8z74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgEKExp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbgEKExj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:53:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FD52082E;
        Mon, 11 May 2020 04:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172819;
        bh=+jhPw0rKcLdSwEpXP+vf94JohnnlOBJwaZ5En19kTlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nV6qc3lVOfq5pcVCLPmhg28LTpNiTLBEtGTVdW2qWeZZWaDO0mkxCK+zvaeYFVo/H
         YWtKnk6wdf+I2XzxzkIkC9SJ+O7m7ngY9pNtVCb4m6D76buDjQ9dh3TAePPJHrD00Z
         WNZ0HVlSqV5pdKrf8WddNt/HHRpMGay4TDAKdWU0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v12 09/18] x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
Date:   Mon, 11 May 2020 00:53:02 -0400
Message-Id: <20200511045311.4785-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
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

