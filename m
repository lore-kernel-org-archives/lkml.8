Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72CC02073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UEDHHTpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgEDR2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729873AbgEDR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:28:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC58C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2eWR80X//rI2SFTijS6f8qhwEHYuA3d+2YR0B7HYuFI=; b=UEDHHTpov9qv8nSpoG4GadSuqk
        714MLHdlmudePiNVwFye9JP13CnBaX9hlNOnSh/wsIvmMaTngxjggcyKE0kcMxmEI4GvhChx9MSOR
        6DucrCPLYkRdRWW7oskmvBa/jxDTV/Kik7Wq7ixBiw1MJqSUzgzp7bffaIj6b+Z2fkStcExfkPea3
        MI/BjLk4oUaIcN7M3YC+K10Q8n4riv1LbNjBRDHu2TVSIMo3+mDsFhsVmOeHeUVb2Hh+2MG5jxhfl
        M1pe5EluW7VULRz1UBNRBdv/BCgaRhrdkDYjem8SnEnBfXkttBIUBjTxsDhZQVZrZIA6EYRfZ4Ep1
        mj/Tk8aw==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVetg-0004Gf-Lz; Mon, 04 May 2020 17:28:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] x86/uv: Mark uv_min_hub_revision_id static
Date:   Mon,  4 May 2020 19:15:23 +0200
Message-Id: <20200504171527.2845224-8-hch@lst.de>
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

This variable is only used inside x2apic_uv_x and not even declared
in a header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index cb07a98771f9f..f1a0142e27319 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -48,8 +48,7 @@ static struct {
 	unsigned int gnode_shift;
 } uv_cpuid;
 
-int uv_min_hub_revision_id;
-EXPORT_SYMBOL_GPL(uv_min_hub_revision_id);
+static int uv_min_hub_revision_id;
 
 unsigned int uv_apicid_hibits;
 EXPORT_SYMBOL_GPL(uv_apicid_hibits);
-- 
2.26.2

