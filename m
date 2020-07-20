Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9FEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0B82176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="afdUoels"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgGTLnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgGTLnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:43:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579BCC061794;
        Mon, 20 Jul 2020 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=W4WLHXIfNQtxiKgvxyLnjwO1h+Hh0xCAt/g2ZbmAybM=; b=afdUoelsLVWde9hy6q29g6mncT
        Z7mG8gOZoz2FuAdgNLWqFILEZGX4rozcT8wMed/yRsmvRGOG1y50EnC/L3nYpLSxnb17WBhDh/Jx8
        OhDpLnqY7xVsHYWT6V9e1NJvJjmHOIJZLLl/SpsrnGKgmnftpAS2hlZIGgQoy4EbpHbF+RsuOja0v
        pUHevPzHIDC6Bfl8/oytQQagR1mIVaximrYmGX1tCgRlGceQTRpXyipK2dCHc6qJ5c/kRszlk1WNk
        Pr82ES1JIyK9eJTDG/4pfQOCqvjejsM4/JJ4wKVIFtK4aD4zESclXylhr4MmZA6yUn9f7Mha4kO7x
        +/xyb8sw==;
Received: from [2001:4bb8:105:4a81:ec09:aa20:3c1e:ebea] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxUCR-0000zj-CX; Mon, 20 Jul 2020 11:43:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: use get_kernel_nofault in show_registers
Date:   Mon, 20 Jul 2020 13:43:14 +0200
Message-Id: <20200720114314.196686-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the proper get_kernel_nofault helper to access an unsafe kernel
pointer without faulting instead of playing with set_fs and get_user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/kernel/traps.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index df6fc782754f73..c265355fa244d4 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -846,7 +846,6 @@ static void show_trace(unsigned long *stack, const char *loglvl)
 void show_registers(struct pt_regs *regs)
 {
 	struct frame *fp = (struct frame *)regs;
-	mm_segment_t old_fs = get_fs();
 	u16 c, *cp;
 	unsigned long addr;
 	int i;
@@ -919,10 +918,9 @@ void show_registers(struct pt_regs *regs)
 	show_stack(NULL, (unsigned long *)addr, KERN_INFO);
 
 	pr_info("Code:");
-	set_fs(KERNEL_DS);
 	cp = (u16 *)regs->pc;
 	for (i = -8; i < 16; i++) {
-		if (get_user(c, cp + i) && i >= 0) {
+		if (get_kernel_nofault(c, cp + i) && i >= 0) {
 			pr_cont(" Bad PC value.");
 			break;
 		}
@@ -931,7 +929,6 @@ void show_registers(struct pt_regs *regs)
 		else
 			pr_cont(" <%04x>", c);
 	}
-	set_fs(old_fs);
 	pr_cont("\n");
 }
 
-- 
2.27.0

