Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4CBC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29E422453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TxkUt0fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgGNMcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgGNMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:32:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D5C061794;
        Tue, 14 Jul 2020 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vxsAwsLR9Ng86EmjXAj4oPak8ui2caJnN1kRrf8YMkM=; b=TxkUt0fvN0cBumf0X2G+oxwUHh
        T4zUaBfi1LUwv/EGkZGTwqindXnCsG5Ts0euiKipOmc8n7xpOOEcPc+yenI7tnRlKnPd8LDl0M1+u
        CDuvAhCcAoo3kyyPv1DvaFYIliQWqOqOg7LwkaiYibyysWBZYp2GoSWBOjTmlb8Sqr7Rp2WvROPRV
        AsSgaXmKgsjAatiU4NwKiCpNGi3Hjc3jKMvrd7BQFZ/EfVGdwr+0OOsijxcHOjfZFF1ANgSaBoUc2
        FYguOYVH+NC2nEQ8kug9B08Qf27u67U4koktmXJHT6nso7dXraerlCrrhY9dcW9i7eFAeLMq2iDGS
        2gyIsBvA==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvK6W-00026a-3l; Tue, 14 Jul 2020 12:32:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Date:   Tue, 14 Jul 2020 14:18:55 +0200
Message-Id: <20200714121856.955680-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714121856.955680-1-hch@lst.de>
References: <20200714121856.955680-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code handling non-coherent DMA depends on being able to remap code
as non-cached.  But that can't be done without an MMU, so using this
option on NOMMU builds is broken.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f8027eee08edae..337eb496c45a0a 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -61,6 +61,7 @@ config SUPERH
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA
 	select NEED_SG_DMA_LENGTH
+	select NO_DMA if !MMU && !DMA_COHERENT
 	select NO_GENERIC_PCI_IOPORT_MAP if PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND
@@ -135,7 +136,7 @@ config DMA_COHERENT
 	bool
 
 config DMA_NONCOHERENT
-	def_bool !DMA_COHERENT
+	def_bool !NO_DMA && !DMA_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 
 config PGTABLE_LEVELS
-- 
2.26.2

