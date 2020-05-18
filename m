Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E5DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089F0207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgERNCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:02:12 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38741 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:02:12 -0400
X-Originating-IP: 84.210.220.251
Received: from consensus.lan (cm-84.210.220.251.getinternet.no [84.210.220.251])
        (Authenticated sender: fredrik@strupe.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 31480C0010;
        Mon, 18 May 2020 13:01:58 +0000 (UTC)
From:   Fredrik Strupe <fredrik@strupe.net>
To:     Russell King <linux@armlinux.org.uk>, Rabin Vincent <rabin@rab.in>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Fredrik Strupe <fredrik@strupe.net>
Subject: [PATCH] arm: uprobes: Don't hook on thumb instructions
Date:   Mon, 18 May 2020 14:59:48 +0200
Message-Id: <20200518125948.25315-1-fredrik@strupe.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since uprobes is not supported for thumb, check that the thumb bit is
not set when matching the uprobes instruction hooks.

The Arm UDF instructions used for uprobes triggering
(UPROBE_SWBP_ARM_INSN and UPROBE_SS_ARM_INSN) coincidentally share the
same encoding as a pair of unallocated 32-bit thumb instructions (not
UDF) when the condition code is 0b1111 (0xf). This in effect makes it
possible to trigger the uprobes functionality from thumb, and at that
using two unallocated instructions which are not permanently undefined.

Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
Fixes: c7edc9e326d5 ("ARM: add uprobes support")
---
 arch/arm/probes/uprobes/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index c4b49b322e8a..f5f790c6e5f8 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -204,7 +204,7 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 static struct undef_hook uprobes_arm_break_hook = {
 	.instr_mask	= 0x0fffffff,
 	.instr_val	= (UPROBE_SWBP_ARM_INSN & 0x0fffffff),
-	.cpsr_mask	= MODE_MASK,
+	.cpsr_mask	= (PSR_T_BIT | MODE_MASK),
 	.cpsr_val	= USR_MODE,
 	.fn		= uprobe_trap_handler,
 };
@@ -212,7 +212,7 @@ static struct undef_hook uprobes_arm_break_hook = {
 static struct undef_hook uprobes_arm_ss_hook = {
 	.instr_mask	= 0x0fffffff,
 	.instr_val	= (UPROBE_SS_ARM_INSN & 0x0fffffff),
-	.cpsr_mask	= MODE_MASK,
+	.cpsr_mask	= (PSR_T_BIT | MODE_MASK),
 	.cpsr_val	= USR_MODE,
 	.fn		= uprobe_trap_handler,
 };
-- 
2.20.1

