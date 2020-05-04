Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22528C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025CF20746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VLbijv2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgEDR27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730297AbgEDR25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:28:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48171C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=S9xgYPRZeAUT/6brILVPMeaqyLuWOvNMi6ClAEL63v4=; b=VLbijv2h/KMTMPfGPxqMPYYMin
        /loKyUb5rERrzvYmQwjHteMrIddIE7dB29fuXxcRKksm55UQwlGL/+j0NAGF7lMRY5P79gFJOGwiQ
        mhobhXFQXpKKqll4s3st1IEbfDXv52TWQsrCOmkWUdKnxPp3t+78aJzKHsegOBcgpznL8WhN3KEzR
        WgwjShh336gbsH/ZyXZ6QgpfzChtBRieDiEKY2StRSzc9cANk67oLRakZeLR0+EaLhNuVC5b7kVJm
        oz8rOhCZcxmv4FUndZj122aFGXSbToM2FOKBkmXPg85OXNUfNipLtvT0WzDzP5f7gqAICTLw7jO5L
        jo00jitw==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVetk-0004Hq-Au; Mon, 04 May 2020 17:28:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] x86/uv: Simplify uv_send_IPI_one
Date:   Mon,  4 May 2020 19:15:24 +0200
Message-Id: <20200504171527.2845224-9-hch@lst.de>
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

Merge two helpers only used by uv_send_IPI_one into the main function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/uv/uv_hub.h   | 20 --------------------
 arch/x86/kernel/apic/x2apic_uv_x.c | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index a998e65e6a584..8a25d95cdf200 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -837,26 +837,6 @@ static inline void uv_set_cpu_scir_bits(int cpu, unsigned char value)
 }
 
 extern unsigned int uv_apicid_hibits;
-static unsigned long uv_hub_ipi_value(int apicid, int vector, int mode)
-{
-	apicid |= uv_apicid_hibits;
-	return (1UL << UVH_IPI_INT_SEND_SHFT) |
-			((apicid) << UVH_IPI_INT_APIC_ID_SHFT) |
-			(mode << UVH_IPI_INT_DELIVERY_MODE_SHFT) |
-			(vector << UVH_IPI_INT_VECTOR_SHFT);
-}
-
-static inline void uv_hub_send_ipi(int pnode, int apicid, int vector)
-{
-	unsigned long val;
-	unsigned long dmode = dest_Fixed;
-
-	if (vector == NMI_VECTOR)
-		dmode = dest_NMI;
-
-	val = uv_hub_ipi_value(apicid, vector, dmode);
-	uv_write_global_mmr64(pnode, UVH_IPI_INT, val);
-}
 
 /*
  * Get the minimum revision number of the hub chips within the partition.
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f1a0142e27319..3830538095e6a 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -588,12 +588,21 @@ static int uv_wakeup_secondary(int phys_apicid, unsigned long start_rip)
 
 static void uv_send_IPI_one(int cpu, int vector)
 {
-	unsigned long apicid;
-	int pnode;
+	unsigned long apicid = per_cpu(x86_cpu_to_apicid, cpu);
+	int pnode = uv_apicid_to_pnode(apicid);
+	unsigned long dmode, val;
+
+	if (vector == NMI_VECTOR)
+		dmode = dest_NMI;
+	else
+		dmode = dest_Fixed;
 
-	apicid = per_cpu(x86_cpu_to_apicid, cpu);
-	pnode = uv_apicid_to_pnode(apicid);
-	uv_hub_send_ipi(pnode, apicid, vector);
+	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
+		((apicid | uv_apicid_hibits) << UVH_IPI_INT_APIC_ID_SHFT) |
+		(dmode << UVH_IPI_INT_DELIVERY_MODE_SHFT) |
+		(vector << UVH_IPI_INT_VECTOR_SHFT);
+
+	uv_write_global_mmr64(pnode, UVH_IPI_INT, val);
 }
 
 static void uv_send_IPI_mask(const struct cpumask *mask, int vector)
-- 
2.26.2

