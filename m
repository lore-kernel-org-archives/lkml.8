Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CD4C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1AE7206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kuKwNOQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgEDR2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729873AbgEDR2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:28:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D8C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=afbLJe7FW7rZfKqpOjG70Tp1qRCBlhgrW5EzTWyIN78=; b=kuKwNOQzLm20nxHIr43h/f1GCp
        gUtLyIwR+ZBL2HyxPS8KmZdIj98Cc1nLXlaWILzPhZFfHYBhmwT+4GYjPfMS29jdNKHZqBXNn/Y4y
        6za7ZmRZh4qcXOVlEjNK7W+Q9rK7To7uf7EKukzL+AR5Ru+qGHBigjuLR5W7nN55BbCXRjKPJS4iL
        sUmTtZ/ADcl+GTVCrSLtlLNeFPNaKAxspGBFQV1jE6I6wPlFmkUl0wzLE/2BHt+IpIpqiq8WEcOWD
        lGdPlGHCpLYMjb7ZJwT3JVLDyRagjgAe7ypF7jfqtHcKaHibFaWdKgqrFm2KHjkMqSl6dEpSAPTCF
        Wr7UTnsg==;
Received: from 089144205116.atnat0014.highway.webapn.at ([89.144.205.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVetb-0004ES-Gr; Mon, 04 May 2020 17:28:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] x86/uv: Remove the UV*_HUB_IS_SUPPORTED macros
Date:   Mon,  4 May 2020 19:15:21 +0200
Message-Id: <20200504171527.2845224-6-hch@lst.de>
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

All of the macros are always defined to one.  Remove them and the dead
code keyed off them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/uv/uv_hub.h  | 19 -------------------
 arch/x86/include/asm/uv/uv_mmrs.h |  7 -------
 2 files changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 950cd1395d5dd..a998e65e6a584 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -244,51 +244,32 @@ static inline int uv_hub_info_check(int version)
 #define UV4_HUB_REVISION_BASE		7
 #define UV4A_HUB_REVISION_BASE		8	/* UV4 (fixed) rev 2 */
 
-/* WARNING: UVx_HUB_IS_SUPPORTED defines are deprecated and will be removed */
 static inline int is_uv1_hub(void)
 {
-#ifdef	UV1_HUB_IS_SUPPORTED
 	return is_uv_hubbed(uv(1));
-#else
-	return 0;
-#endif
 }
 
 static inline int is_uv2_hub(void)
 {
-#ifdef	UV2_HUB_IS_SUPPORTED
 	return is_uv_hubbed(uv(2));
-#else
-	return 0;
-#endif
 }
 
 static inline int is_uv3_hub(void)
 {
-#ifdef	UV3_HUB_IS_SUPPORTED
 	return is_uv_hubbed(uv(3));
-#else
-	return 0;
-#endif
 }
 
 /* First test "is UV4A", then "is UV4" */
 static inline int is_uv4a_hub(void)
 {
-#ifdef	UV4A_HUB_IS_SUPPORTED
 	if (is_uv_hubbed(uv(4)))
 		return (uv_hub_info->hub_revision == UV4A_HUB_REVISION_BASE);
-#endif
 	return 0;
 }
 
 static inline int is_uv4_hub(void)
 {
-#ifdef	UV4_HUB_IS_SUPPORTED
 	return is_uv_hubbed(uv(4));
-#else
-	return 0;
-#endif
 }
 
 static inline int is_uvx_hub(void)
diff --git a/arch/x86/include/asm/uv/uv_mmrs.h b/arch/x86/include/asm/uv/uv_mmrs.h
index 62c79e26a59ac..9ee5ed6e8b348 100644
--- a/arch/x86/include/asm/uv/uv_mmrs.h
+++ b/arch/x86/include/asm/uv/uv_mmrs.h
@@ -99,13 +99,6 @@
 #define UV3_HUB_PART_NUMBER_X	0x4321
 #define UV4_HUB_PART_NUMBER	0x99a1
 
-/* Compat: Indicate which UV Hubs are supported. */
-#define UV1_HUB_IS_SUPPORTED	1
-#define UV2_HUB_IS_SUPPORTED	1
-#define UV3_HUB_IS_SUPPORTED	1
-#define UV4_HUB_IS_SUPPORTED	1
-#define UV4A_HUB_IS_SUPPORTED	1
-
 /* Error function to catch undefined references */
 extern unsigned long uv_undefined(char *str);
 
-- 
2.26.2

