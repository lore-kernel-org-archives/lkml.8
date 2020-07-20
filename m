Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D18C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA252176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fcBDzryS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgGTLox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgGTLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE14C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GsKzmsgfnJRljn2BlzzYICUcX5JYaJa3ns+KRq5Iam8=; b=fcBDzrySvc82oSYFvjEghKa4gd
        +MG4I39ft1LJtCO19wshZTvU/8voeQvdJqMQePIi9kL/R3fIwcng9vRszdnY1IE/V0dQ7u9VR1Ikc
        Fmg0/ezkyIWSyCSMgHxUZtT5caH0prFVsDLEL/1FBF30Y1sxx4oOogHJJRV63+PhUH14bU5oP8PQh
        QKVeLwXtHUEgOmc02jbFk1sGRWXN3cmtDSXTbHvlF7fLiRWf3wUU/hoQqVAAitKNdhVEfv8dzvJ8w
        ETpRVa6Iun4+W4OPw7MPcxKB8/0YrQGtxCwsSEveCwmjeAGB5iVvYIAtDkhpUQABM+ojhF2mGL0FX
        a8pQ1Qbg==;
Received: from [2001:4bb8:105:4a81:ec09:aa20:3c1e:ebea] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxUDw-00014k-UK; Mon, 20 Jul 2020 11:44:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nds32: remove dump_instr
Date:   Mon, 20 Jul 2020 13:44:47 +0200
Message-Id: <20200720114448.205876-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_inst has a return before actually doing anything, so just drop the
whole thing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/traps.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 6a9772ba739276..b66f889bc6df9b 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -62,40 +62,6 @@ void dump_mem(const char *lvl, unsigned long bottom, unsigned long top)
 
 EXPORT_SYMBOL(dump_mem);
 
-static void dump_instr(struct pt_regs *regs)
-{
-	unsigned long addr = instruction_pointer(regs);
-	mm_segment_t fs;
-	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
-	int i;
-
-	return;
-	/*
-	 * We need to switch to kernel mode so that we can use __get_user
-	 * to safely read from kernel space.  Note that we now dump the
-	 * code first, just in case the backtrace kills us.
-	 */
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
-	pr_emerg("Code: ");
-	for (i = -4; i < 1; i++) {
-		unsigned int val, bad;
-
-		bad = __get_user(val, &((u32 *) addr)[i]);
-
-		if (!bad) {
-			p += sprintf(p, i == 0 ? "(%08x) " : "%08x ", val);
-		} else {
-			p += sprintf(p, "bad PC value");
-			break;
-		}
-	}
-	pr_emerg("Code: %s\n", str);
-
-	set_fs(fs);
-}
-
 #define LOOP_TIMES (100)
 static void __dump(struct task_struct *tsk, unsigned long *base_reg,
 		   const char *loglvl)
@@ -179,7 +145,6 @@ void die(const char *str, struct pt_regs *regs, int err)
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem("Stack: ", regs->sp, (regs->sp + PAGE_SIZE) & PAGE_MASK);
-		dump_instr(regs);
 		dump_stack();
 	}
 
-- 
2.27.0

