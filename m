Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6DEC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4B02070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C5rPjeEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgGTLoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgGTLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A7CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KKo+ARh0uAKwb2D65RyOQ5eVqFj9oDQ2/wINbHm2qds=; b=C5rPjeEKhH7jIGSLkB3/xKwXqL
        +xkyyD/6RVlqJA18U4QAhVYNJBUjzSmEqcX+yYLy7vivYJAi9hb40ChJFEyw/LF9Zti2GLdAT+op/
        /zMDfHLPBogOOinXjiCm8OZedIg3/UcNXPZwEbefgpXHPXHCQCfK2CG1stnW08CqtM6xtznIzxLDi
        EL5VpLw/L+bFX11NeMmU6X17SHNSUN40JZy3Y64jcM6Fl6ATFPrz6TVaI41IeG9Nmk/Jsz8VSRzKF
        tExWJz+LS0TnGOMEH3KmOCfKCbWFtTOqduMD0D1bjl07BStn1L/QXxuzSRQRgwJQ27vDuGqq93bda
        v0Epk4BQ==;
Received: from [2001:4bb8:105:4a81:ec09:aa20:3c1e:ebea] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxUDz-00014o-83; Mon, 20 Jul 2020 11:44:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nds32: use get_kernel_nofault in dump_mem
Date:   Mon, 20 Jul 2020 13:44:48 +0200
Message-Id: <20200720114448.205876-2-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720114448.205876-1-hch@lst.de>
References: <20200720114448.205876-1-hch@lst.de>
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
 arch/nds32/kernel/traps.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index b66f889bc6df9b..ee0d9ae192a504 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -25,17 +25,8 @@ extern void show_pte(struct mm_struct *mm, unsigned long addr);
 void dump_mem(const char *lvl, unsigned long bottom, unsigned long top)
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
 	pr_emerg("%s(0x%08lx to 0x%08lx)\n", lvl, bottom, top);
 
 	for (first = bottom & ~31; first < top; first += 32) {
@@ -48,7 +39,9 @@ void dump_mem(const char *lvl, unsigned long bottom, unsigned long top)
 		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
 			if (p >= bottom && p < top) {
 				unsigned long val;
-				if (__get_user(val, (unsigned long *)p) == 0)
+
+				if (get_kernel_nofault(val,
+						(unsigned long *)p) == 0)
 					sprintf(str + i * 9, " %08lx", val);
 				else
 					sprintf(str + i * 9, " ????????");
@@ -56,8 +49,6 @@ void dump_mem(const char *lvl, unsigned long bottom, unsigned long top)
 		}
 		pr_emerg("%s%04lx:%s\n", lvl, first & 0xffff, str);
 	}
-
-	set_fs(fs);
 }
 
 EXPORT_SYMBOL(dump_mem);
-- 
2.27.0

