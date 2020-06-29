Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B05C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CFF208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391191AbgF2V2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgF2Smn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CEEC033C29;
        Mon, 29 Jun 2020 11:26:35 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUD-002Dxh-Sd; Mon, 29 Jun 2020 18:26:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 37/41] xtensa: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:24 +0100
Message-Id: <20200629182628.529995-37-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/xtensa/kernel/ptrace.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index b4c07bd890fe..d46180b69600 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -37,8 +37,7 @@
 
 static int gpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	struct pt_regs *regs = task_pt_regs(target);
 	struct user_pt_regs newregs = {
@@ -60,8 +59,7 @@ static int gpr_get(struct task_struct *target,
 	       regs->areg,
 	       (WSBITS - regs->windowbase) * 16);
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &newregs, 0, -1);
+	return membuf_write(&to, &newregs, sizeof(newregs));
 }
 
 static int gpr_set(struct task_struct *target,
@@ -115,8 +113,7 @@ static int gpr_set(struct task_struct *target,
 
 static int tie_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	int ret;
 	struct pt_regs *regs = task_pt_regs(target);
@@ -141,8 +138,7 @@ static int tie_get(struct task_struct *target,
 	newregs->cp6 = ti->xtregs_cp.cp6;
 	newregs->cp7 = ti->xtregs_cp.cp7;
 #endif
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  newregs, 0, -1);
+	ret = membuf_write(&to, newregs, sizeof(*newregs));
 	kfree(newregs);
 	return ret;
 }
@@ -197,7 +193,7 @@ static const struct user_regset xtensa_regsets[] = {
 		.n = sizeof(struct user_pt_regs) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = gpr_get,
+		.get2 = gpr_get,
 		.set = gpr_set,
 	},
 	[REGSET_TIE] = {
@@ -205,7 +201,7 @@ static const struct user_regset xtensa_regsets[] = {
 		.n = sizeof(elf_xtregs_t) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = tie_get,
+		.get2 = tie_get,
 		.set = tie_set,
 	},
 };
-- 
2.11.0

