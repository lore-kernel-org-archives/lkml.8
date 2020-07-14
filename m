Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD8AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01C6207CD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kz01khxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGNLBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGNLBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:01:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566AEC061755;
        Tue, 14 Jul 2020 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dLJ+rswlwOb9VgarkBahNyYojmAUY/xiMFDZ6ppJYq8=; b=Kz01khxc0JwwuZnVk8sIru0ipf
        o0d8wJyabxrEX2NNseTwAW9ee/TD6/cNvWILaL6Jyr1x1fwztZHD9HGX1/nF+lhj0I6J+4Zy/pBs5
        zy3/VlfHrn2a9R29W3rU/ZDeSZekvc+Jc2XJi/KpH4Zq2CqAwUQSXrvalLeS33yo5y1ufgkkEV6gj
        iiCgi4O4JciPs8Kxjg6z5bGsJx8WVKqosaMuX36dAliAyMFuCTSFZ4mAy0FK+MZHBJH1Iti6GRTlu
        7G+lR2TYNLx5MMBH58KjINfHWfuicHp3DvETkmodt5HAUCdYFiM51FXMNYNUGiXUsO6AVoEhOxoM6
        bzBJcIdA==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvIgt-00065C-BH; Tue, 14 Jul 2020 11:01:39 +0000
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
Date:   Tue, 14 Jul 2020 12:55:01 +0200
Message-Id: <20200714105505.935079-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714105505.935079-1-hch@lst.de>
References: <20200714105505.935079-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the uaccess_kernel helper instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Greentime Hu <green.hu@gmail.com>
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

