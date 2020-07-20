Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4E92070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBZEVVUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgGTLoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgGTLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:44:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF30C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8KcdwEeAcx3Daxv4E4fZ7SRipQ6fOdSHere+LTZwYW8=; b=nBZEVVUoHciyNHdl3+6SWgtTJB
        BTHgvq9FVMMxdUxsjriWx3XfyCyRS7+oesSd8yydoxB/Z2o9EY5MkOcknNt9nbKZPuvpPGmljmImR
        3jkfd94VWqMXBLkzONh6klhSOyFP2nFUtQWm+o1hi1gj0LelLUkZargrpw+FBsa6H071EjPCqI7yi
        fWUn14+BvT3/A0bn0yiTzHeg0pvcdm19YrDVsqzkuXssA5ZmN7EbJfCpW5VxyaNWMTPuyAVzwx/T+
        sXQbEZZXPSgUdgk/RGdZ/GfxoPNd6ZcI2qvWCefOJ0po4Z01c1/eCr0QX1DzOzhDz2hYJ3+Xa0K/O
        QtCTu6KQ==;
Received: from [2001:4bb8:105:4a81:ec09:aa20:3c1e:ebea] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxUD9-00012J-6C; Mon, 20 Jul 2020 11:43:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     gxt@pku.edu.cn
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] unicore32: use get_kernel_nofault in dump mem and dump_instr
Date:   Mon, 20 Jul 2020 13:43:58 +0200
Message-Id: <20200720114358.201161-1-hch@lst.de>
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
 arch/unicore32/kernel/traps.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index a3ac01df1a2e43..c1964a4a1edbb0 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -65,17 +65,8 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		     unsigned long top)
 {
 	unsigned long first;
-	mm_segment_t fs;
 	int i;
 
-	/*
-	 * We need to switch to kernel mode so that we can use __get_user
-	 * to safely read from kernel space.  Note that we now dump the
-	 * code first, just in case the backtrace kills us.
-	 */
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	printk(KERN_DEFAULT "%s%s(0x%08lx to 0x%08lx)\n",
 			lvl, str, bottom, top);
 
@@ -89,7 +80,8 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
 			if (p >= bottom && p < top) {
 				unsigned long val;
-				if (__get_user(val, (unsigned long *)p) == 0)
+				if (get_kernel_nofault(val, (unsigned long *)p)
+						== 0)
 					sprintf(str + i * 9, " %08lx", val);
 				else
 					sprintf(str + i * 9, " ????????");
@@ -97,31 +89,19 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		}
 		printk(KERN_DEFAULT "%s%04lx:%s\n", lvl, first & 0xffff, str);
 	}
-
-	set_fs(fs);
 }
 
 static void dump_instr(const char *lvl, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
 	const int width = 8;
-	mm_segment_t fs;
 	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
 	int i;
 
-	/*
-	 * We need to switch to kernel mode so that we can use __get_user
-	 * to safely read from kernel space.  Note that we now dump the
-	 * code first, just in case the backtrace kills us.
-	 */
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	for (i = -4; i < 1; i++) {
 		unsigned int val, bad;
 
-		bad = __get_user(val, &((u32 *)addr)[i]);
-
+		bad = get_kernel_nofault(val, &((u32 *)addr)[i]);
 		if (!bad)
 			p += sprintf(p, i == 0 ? "(%0*x) " : "%0*x ",
 					width, val);
@@ -131,8 +111,6 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 		}
 	}
 	printk(KERN_DEFAULT "%sCode: %s\n", lvl, str);
-
-	set_fs(fs);
 }
 
 static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
-- 
2.27.0

