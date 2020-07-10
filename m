Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1CBC433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCAA2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FwiKwS4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGJN5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGJN5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:57:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9ADC08C5CE;
        Fri, 10 Jul 2020 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wVXOB0bwTse/Sz4zv+YiEUb+RJzy2LQixEil7fBzx3k=; b=FwiKwS4KtMrB3DtxFidvXGvg0I
        r21BX3mpVgWXJKfxFomXL6ipq2kN7zleUIZLHIAbMnMpLdQtb/DSzVlrlmPGjkDSwQYb/Ilbvhs/2
        WziOZM487LBn6WlXuxadZhfCkIqsQNlqGNj7vbNwzJUph3scHCDLYUbjGg4Uv08dLpkQWrzop/Pwk
        wbZahGTPC78QyBsCk0xmnF74kxhkVEMKVN6MX34XcylMWuz0HlrCWPJjzzX12YFH9pgOnzty9K42A
        1yG3wZji4FLx4YXEHKmUfdEJY5VvA6Lvoyj5W+B3LlgBQiop3s3LgBEMAibpXcCDxk66G2yZLOfm5
        /DeL8dzQ==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttWX-0004gf-LT; Fri, 10 Jul 2020 13:57:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] nds32: use uaccess_kernel in show_regs
Date:   Fri, 10 Jul 2020 15:57:02 +0200
Message-Id: <20200710135706.537715-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710135706.537715-1-hch@lst.de>
References: <20200710135706.537715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the uaccess_kernel helper instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 9712fd474f2ca3..f06265949ec28b 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -121,7 +121,7 @@ void show_regs(struct pt_regs *regs)
 		regs->uregs[3], regs->uregs[2], regs->uregs[1], regs->uregs[0]);
 	pr_info("  IRQs o%s  Segment %s\n",
 		interrupts_enabled(regs) ? "n" : "ff",
-		segment_eq(get_fs(), KERNEL_DS)? "kernel" : "user");
+		uaccess_kernel() ? "kernel" : "user");
 }
 
 EXPORT_SYMBOL(show_regs);
-- 
2.26.2

