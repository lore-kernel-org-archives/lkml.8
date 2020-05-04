Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75693C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB1C20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DehRRxLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgEDRT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729667AbgEDRTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:19:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DA7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MM253sF1U6dObDLa771vU13RUASD51CrGjHZh2c0+1E=; b=DehRRxLf8f91cTv3rjoJHqR1z9
        Sc46SbNNkc8OBs2DdwUvjxf68P16HxlltRgLJ++nMzgBw3PuR54SWOWnRbCANkmn6ciintqEn5SGD
        6Hm7QIdn5dUvRktx7dvuvbabBbTRVG8XArfITKLbjtSU//lNTR2OJU23fHxPidTWgQlcg1YFA+RwN
        3vdn7lT5bSUsshQMDjtNqcFaevXgD0TYBmUQkwmpLA6RnZAF4xM53agPgvEpenWgE8Tnh7aXL7C6E
        oVDN81Y766LoV8oYUHk23iiyoWnocaC9aMUD9V7GDTtio4Gt5wMIAg6iovx9/3OBRSJDnUnJXv/2U
        H8yqajlA==;
Received: from 089144205116.atnat0014.highway.webapn.at ([89.144.205.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVel0-0005EH-Se; Mon, 04 May 2020 17:19:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] x86/uv: Mark uv_bios_call and uv_bios_call_irqsave static
Date:   Mon,  4 May 2020 19:15:17 +0200
Message-Id: <20200504171527.2845224-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504171527.2845224-1-hch@lst.de>
References: <20200504171527.2845224-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both functions are only used inside of bios_uv.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/uv/bios.h | 6 ------
 arch/x86/platform/uv/bios_uv.c | 9 ++++-----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 389174eaec794..fc85dafa5e496 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -123,12 +123,6 @@ enum uv_memprotect {
 	UV_MEMPROT_ALLOW_RW
 };
 
-/*
- * bios calls have 6 parameters
- */
-extern s64 uv_bios_call(enum uv_bios_cmd, u64, u64, u64, u64, u64);
-extern s64 uv_bios_call_irqsave(enum uv_bios_cmd, u64, u64, u64, u64, u64);
-
 extern s64 uv_bios_get_sn_info(int, int *, long *, long *, long *, long *);
 extern s64 uv_bios_freq_base(u64, u64 *);
 extern int uv_bios_mq_watchlist_alloc(unsigned long, unsigned int,
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index c60255da5a6cd..ca287554e2342 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -45,7 +45,8 @@ static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 	return ret;
 }
 
-s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
+static s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4,
+		u64 a5)
 {
 	s64 ret;
 
@@ -57,10 +58,9 @@ s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(uv_bios_call);
 
-s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
-					u64 a4, u64 a5)
+static s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
+		u64 a4, u64 a5)
 {
 	unsigned long bios_flags;
 	s64 ret;
@@ -77,7 +77,6 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 	return ret;
 }
 
-
 long sn_partition_id;
 EXPORT_SYMBOL_GPL(sn_partition_id);
 long sn_coherency_id;
-- 
2.26.2

