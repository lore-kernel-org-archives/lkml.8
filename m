Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7EEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C1F208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEZEfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 00:35:16 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41357 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgEZEfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 00:35:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TzggL66_1590467712;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzggL66_1590467712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 May 2020 12:35:12 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/entry: Don't write to CR3 when restoring to kernel CR3
Date:   Tue, 26 May 2020 04:35:06 +0000
Message-Id: <20200526043507.51977-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526043507.51977-1-laijs@linux.alibaba.com>
References: <20200526043507.51977-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip resuming KERNEL pages since it is already KERNEL CR3

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 1c7f13bb6728..505246185624 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -268,14 +268,13 @@ For 32-bit we have the following conventions - kernel is built with
 .macro RESTORE_CR3 scratch_reg:req save_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 
-	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
-
 	/*
-	 * KERNEL pages can always resume with NOFLUSH as we do
-	 * explicit flushes.
+	 * Skip resuming KERNEL pages since it is already KERNEL CR3.
 	 */
 	bt	$PTI_USER_PGTABLE_BIT, \save_reg
-	jnc	.Lnoflush_\@
+	jnc	.Lend_\@
+
+	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
 
 	/*
 	 * Check if there's a pending flush for the user ASID we're
@@ -293,10 +292,6 @@ For 32-bit we have the following conventions - kernel is built with
 	SET_NOFLUSH_BIT \save_reg
 
 .Lwrcr3_\@:
-	/*
-	 * The CR3 write could be avoided when not changing its value,
-	 * but would require a CR3 read *and* a scratch register.
-	 */
 	movq	\save_reg, %cr3
 .Lend_\@:
 .endm
-- 
2.20.1

