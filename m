Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E870CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30E624954
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VbcWCICn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgEDR3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730297AbgEDR3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:29:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E767EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wpAchFK0XXJsltEJOn1VsdwOaYFdXnj1scPu0+J57Lo=; b=VbcWCICn0hvvFdqlYReNYNLHGa
        cQO/1GeA2/l8wGw3JUCCOVH14qmZTxXELlp1RRUJ9HGwIgbEZOB3UKXJ/wfrqW9WZmi1Z7/fFN3iD
        Npz8RXGZJE1heGN4le9AvBj/xXGEdJuvh3BN6h5ed+xbuBXIFPyfWnvBrelcljcf3L+dmG1E+Bf14
        CEmHh4Af0EXQYDuCXNmO1IPNjSngDmlepa5ldbkdY9uhEWhSaDdEkqKJuxug8nQEYjfyTHyZfA6Wu
        DujHynL4FaYAbnx1z0PosIERkoMwlHIyaT0rQcvvZLoQQvRmTmPeKknJJGdBU2gYxeG4uhN0ID+EN
        ocEpGuPw==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVetn-0004IE-2c; Mon, 04 May 2020 17:28:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] x86/uv: Remove _uv_hub_info_check
Date:   Mon,  4 May 2020 19:15:25 +0200
Message-Id: <20200504171527.2845224-10-hch@lst.de>
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

Neither this functions not the helpers used to implement it are used
anywhere in the kernel tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/uv/uv_hub.h   | 14 --------------
 arch/x86/kernel/apic/x2apic_uv_x.c |  6 ------
 2 files changed, 20 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 8a25d95cdf200..9eabd7e52fd15 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -219,20 +219,6 @@ static inline struct uv_hub_info_s *uv_cpu_hub_info(int cpu)
 	return (struct uv_hub_info_s *)uv_cpu_info_per(cpu)->p_uv_hub_info;
 }
 
-#define	UV_HUB_INFO_VERSION	0x7150
-extern int uv_hub_info_version(void);
-static inline int uv_hub_info_check(int version)
-{
-	if (uv_hub_info_version() == version)
-		return 0;
-
-	pr_crit("UV: uv_hub_info version(%x) mismatch, expecting(%x)\n",
-		uv_hub_info_version(), version);
-
-	BUG();	/* Catastrophic - cannot continue on unknown UV system */
-}
-#define	_uv_hub_info_check()	uv_hub_info_check(UV_HUB_INFO_VERSION)
-
 /*
  * HUB revision ranges for each UV HUB architecture.
  * This is a software convention - NOT the hardware revision numbers in
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 3830538095e6a..8cf0e24cf8835 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -415,12 +415,6 @@ static __initdata struct uv_gam_range_s		*_gr_table;
 
 #define	SOCK_EMPTY	((unsigned short)~0)
 
-extern int uv_hub_info_version(void)
-{
-	return UV_HUB_INFO_VERSION;
-}
-EXPORT_SYMBOL(uv_hub_info_version);
-
 /* Default UV memory block size is 2GB */
 static unsigned long mem_block_size __initdata = (2UL << 30);
 
-- 
2.26.2

