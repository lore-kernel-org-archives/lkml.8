Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687E0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488C82068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OChvkshW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgEDR2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729873AbgEDR2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:28:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B2AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9CPuzJvyt79Srz/mhdpFm81+U9pcelEPdIzi3BsC6M4=; b=OChvkshWtqIvwsXCA5XhNKv/qi
        KJzj/C/S5LNgArSCeeck5TRBFApA6v4So5rOlTBMpczjp9IM+6h1EGtODmTpPE4XuIT4QAC4J/DxU
        CyMM6Mf67Kxi7tSBGXv4qi8sB2n6k1P4bJ7U1Bk126vLNtrp6JPo7bqE7Ats1VFZAHnwhk9QLTRw+
        Hm513oWQvoDrtkU5Su/y4kNWQG2uOnb7vN3XMBsiu6Sj5WmF6grPf2nLdrNd3NVknmtjY3/0XrUpC
        51YJllvWZ96F7WT02L4+nMmQ4qio54mAWHfCPOpGte+JqnIl4iXNi/C2KSfAKAYLXsvHMR/OxGweL
        BKZcFTsA==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVete-0004GA-5r; Mon, 04 May 2020 17:28:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] x86/uv: Mark is_uv_hubless static
Date:   Mon,  4 May 2020 19:15:22 +0200
Message-Id: <20200504171527.2845224-7-hch@lst.de>
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

is_uv_hubless is only used in x2apic_uv_x.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/uv/uv.h       | 2 --
 arch/x86/kernel/apic/x2apic_uv_x.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 45ea95ce79b46..ae587ce544f44 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -31,7 +31,6 @@ static inline bool is_early_uv_system(void)
 }
 extern int is_uv_system(void);
 extern int is_uv_hubbed(int uvtype);
-extern int is_uv_hubless(int uvtype);
 extern void uv_cpu_init(void);
 extern void uv_nmi_init(void);
 extern void uv_system_init(void);
@@ -44,7 +43,6 @@ static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
 static inline bool is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubbed(int uv)	{ return 0; }
-static inline int is_uv_hubless(int uv) { return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
 static inline const struct cpumask *
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index ad53b2abc859f..cb07a98771f9f 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -385,11 +385,10 @@ int is_uv_hubbed(int uvtype)
 }
 EXPORT_SYMBOL_GPL(is_uv_hubbed);
 
-int is_uv_hubless(int uvtype)
+static int is_uv_hubless(int uvtype)
 {
 	return (uv_hubless_system & uvtype);
 }
-EXPORT_SYMBOL_GPL(is_uv_hubless);
 
 void **__uv_hub_info_list;
 EXPORT_SYMBOL_GPL(__uv_hub_info_list);
-- 
2.26.2

