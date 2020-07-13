Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D62C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FD020809
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auR2Ei99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgGMM2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGMM2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:28:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653C0C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:28:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z3so5917548pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NkRMPzDOPhwF4AMv+VfvaJWfNs8Xu8T4sYtwHMMp7iU=;
        b=auR2Ei99k4ekpl6E8bJTZ5lwolMtWGb2Fz6QXIYk/s/99swEizNxCZZY9Xm/DgnTJg
         skSfN6oo0VGPDYuXwkRW8xs/bcC8TTOHETnP/Ik3rb9aAaFsWkLMPBLZF2PYzqQYK0Kz
         bujFHS1291PBpkkrTu2Lat0VB30A2bXaaml7eg1qIUAWmr8yuwHK1is/JQOa3yITTtt5
         0Po5/ZiEr69IzkAfg0hF073mP6VQlhjyGjJph2zst+XAR3NscmXiSbhj9WIe6HZLq/sP
         EbS4Z0RHXCc2fNcgurAHmHW6+xBuA6pewuis/V5XSFETESn0pw+WhYwRWFRNgmz0bM0o
         4Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NkRMPzDOPhwF4AMv+VfvaJWfNs8Xu8T4sYtwHMMp7iU=;
        b=V0lqpgRF4k5rlWWuFz/h0MBv+erCNuFRSP1W9bkNVkmoihAQobwDkKgWKPlkDbAAjw
         KMAXztsHRsjmAvXHrXywJSWCtyclAP6swDnbeT14hXa2+E+YLY27hBYFuDGpWtsgYfsd
         ZA9FXSmG+eIz188+ZEdUTKE5M2/0/WMb1aNysRxoMGHqY58O/0YaK+9V9WxzpZs3zeKg
         yJ0gBmYkPmUHiB/nn1QPf32CzKugz0F7LJDKSpG1i1iaGihfnJKwqwcaQDfIGkMp4INd
         Sg5zy7QLiBd0P/8LjagcKhiyIaR+HJEs2r53K/rn3QP8t4KJn/DGEDXnn28aWxxME+Z6
         Ue9Q==
X-Gm-Message-State: AOAM531FM/LgwX1HGdRjsOOWGa5Fu5qDSwgEcJ0xClG7Bw0F/dmonLgG
        lOJRDvTVwhz7FqYcOYHDrtw7t7RUjVFPOzZl
X-Google-Smtp-Source: ABdhPJxntBLt1MicQ59S0RfqmyeuKehGT37U6inHm3C9/NIDDsscjv/w6pSdKYgqobl7+jvLc/PLaA==
X-Received: by 2002:a65:6384:: with SMTP id h4mr67670673pgv.196.1594643325934;
        Mon, 13 Jul 2020 05:28:45 -0700 (PDT)
Received: from hyd1soter3.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id p1sm31891839pja.2.2020.07.13.05.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 05:28:45 -0700 (PDT)
From:   rakeshs.lkm@gmail.com
To:     sbhatta@marvell.com, sgoutham@marvell.com, jerinj@marvell.com,
        rsaladi2@marvell.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sunil Kovvuri Goutham <Sunil.Goutham@cavium.com>
Subject: [net-next PATCH 1/2] octeontx2-af: add npa error af interrupt handlers
Date:   Mon, 13 Jul 2020 17:56:39 +0530
Message-Id: <20200713122640.4155-2-rakeshs.lkm@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713122640.4155-1-rakeshs.lkm@gmail.com>
References: <20200713122640.4155-1-rakeshs.lkm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerin Jacob <jerinj@marvell.com>

Added debug messages for NPA NPA_AF_RVU_INT, NPA_AF_GEN_INT, NPA_AF_ERR_INT
and NPA_AF_RAS error AF interrupts

Signed-off-by: Jerin Jacob <jerinj@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <Sunil.Goutham@cavium.com>
Signed-off-by: Rakesh Babu <rsaladi2@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   7 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   2 +
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   | 230 ++++++++++++++++++
 .../marvell/octeontx2/af/rvu_struct.h         |  23 ++
 4 files changed, 262 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 557e4292c846..6c4027f04cfc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2130,6 +2130,8 @@ static void rvu_unregister_interrupts(struct rvu *rvu)
 {
 	int irq;

+	rvu_npa_unregister_interrupts(rvu);
+
 	/* Disable the Mbox interrupt */
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT_ENA_W1C,
 		    INTR_MASK(rvu->hw->total_pfs) & ~1ULL);
@@ -2337,6 +2339,11 @@ static int rvu_register_interrupts(struct rvu *rvu)
 		goto fail;
 	}
 	rvu->irq_allocated[offset] = true;
+
+	ret = rvu_npa_register_interrupts(rvu);
+	if (ret)
+		goto fail;
+
 	return 0;

 fail:
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index dcf25a092008..63c9f6049ad5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -453,6 +453,8 @@ void rvu_npa_freemem(struct rvu *rvu);
 void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf);
 int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 			struct npa_aq_enq_rsp *rsp);
+int rvu_npa_register_interrupts(struct rvu *rvu);
+void rvu_npa_unregister_interrupts(struct rvu *rvu);

 /* NIX APIs */
 bool is_nixlf_attached(struct rvu *rvu, u16 pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
index 67471cb2b129..2476d20280cb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
@@ -8,8 +8,10 @@
  * published by the Free Software Foundation.
  */

+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/stringify.h>

 #include "rvu_struct.h"
 #include "rvu_reg.h"
@@ -541,3 +543,231 @@ void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf)

 	npa_ctx_free(rvu, pfvf);
 }
+
+static irqreturn_t rvu_npa_af_rvu_intr_handler(int irq, void *rvu_irq)
+{
+	struct rvu *rvu = (struct rvu *)rvu_irq;
+	int blkaddr;
+	u64 intr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
+	if (blkaddr < 0)
+		return IRQ_NONE;
+
+	intr = rvu_read64(rvu, blkaddr, NPA_AF_RVU_INT);
+
+	if (intr & BIT_ULL(0))
+		dev_err(rvu->dev, "NPA: Unmapped slot error\n");
+
+	/* Clear interrupts */
+	rvu_write64(rvu, blkaddr, NPA_AF_RVU_INT, intr);
+	return IRQ_HANDLED;
+}
+
+static const char *rvu_npa_inpq_to_str(u16 in)
+{
+	switch (in) {
+	case 0:
+		return NULL;
+	case BIT(NPA_INPQ_NIX0_RX):
+		return __stringify(NPA_INPQ_NIX0_RX);
+	case BIT(NPA_INPQ_NIX0_TX):
+		return __stringify(NPA_INPQ_NIX0_TX);
+	case BIT(NPA_INPQ_NIX1_RX):
+		return __stringify(NPA_INPQ_NIX1_RX);
+	case BIT(NPA_INPQ_NIX1_TX):
+		return __stringify(NPA_INPQ_NIX1_TX);
+	case BIT(NPA_INPQ_SSO):
+		return __stringify(NPA_INPQ_SSO);
+	case BIT(NPA_INPQ_TIM):
+		return __stringify(NPA_INPQ_TIM);
+	case BIT(NPA_INPQ_DPI):
+		return __stringify(NPA_INPQ_DPI);
+	case BIT(NPA_INPQ_AURA_OP):
+		return __stringify(NPA_INPQ_AURA_OP);
+	case BIT(NPA_INPQ_INTERNAL_RSV):
+		return __stringify(NPA_INPQ_INTERNAL_RSV);
+	}
+
+	return "Reserved";
+}
+
+static irqreturn_t rvu_npa_af_gen_intr_handler(int irq, void *rvu_irq)
+{
+	struct rvu *rvu = (struct rvu *)rvu_irq;
+	const char *err_msg;
+	int blkaddr, val;
+	u64 intr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
+	if (blkaddr < 0)
+		return IRQ_NONE;
+
+	intr = rvu_read64(rvu, blkaddr, NPA_AF_GEN_INT);
+
+	if (intr & BIT_ULL(32))
+		dev_err(rvu->dev, "NPA: Unmapped PF func error\n");
+
+	val = FIELD_GET(GENMASK(31, 16), intr);
+	err_msg = rvu_npa_inpq_to_str(val);
+	if (err_msg)
+		dev_err(rvu->dev, "NPA: Alloc disabled for %s\n", err_msg);
+
+	val = FIELD_GET(GENMASK(15, 0), intr);
+	err_msg = rvu_npa_inpq_to_str(val);
+	if (err_msg)
+		dev_err(rvu->dev, "NPA: Free disabled for %s\n", err_msg);
+
+	/* Clear interrupts */
+	rvu_write64(rvu, blkaddr, NPA_AF_GEN_INT, intr);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rvu_npa_af_err_intr_handler(int irq, void *rvu_irq)
+{
+	struct rvu *rvu = (struct rvu *)rvu_irq;
+	int blkaddr;
+	u64 intr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
+	if (blkaddr < 0)
+		return IRQ_NONE;
+
+	intr = rvu_read64(rvu, blkaddr, NPA_AF_ERR_INT);
+
+	if (intr & BIT_ULL(14))
+		dev_err(rvu->dev, "NPA: Memory fault on NPA_AQ_INST_S read\n");
+
+	if (intr & BIT_ULL(13))
+		dev_err(rvu->dev, "NPA: Memory fault on NPA_AQ_RES_S write\n");
+
+	if (intr & BIT_ULL(12))
+		dev_err(rvu->dev, "NPA: AQ doorbell error\n");
+
+	/* Clear interrupts */
+	rvu_write64(rvu, blkaddr, NPA_AF_ERR_INT, intr);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rvu_npa_af_ras_intr_handler(int irq, void *rvu_irq)
+{
+	struct rvu *rvu = (struct rvu *)rvu_irq;
+	int blkaddr;
+	u64 intr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
+	if (blkaddr < 0)
+		return IRQ_NONE;
+
+	intr = rvu_read64(rvu, blkaddr, NPA_AF_RAS);
+
+	if (intr & BIT_ULL(34))
+		dev_err(rvu->dev, "NPA: Poisoned data on NPA_AQ_INST_S read\n");
+
+	if (intr & BIT_ULL(33))
+		dev_err(rvu->dev, "NPA: Poisoned data on NPA_AQ_RES_S write\n");
+
+	if (intr & BIT_ULL(32))
+		dev_err(rvu->dev, "NPA: Poisoned data on HW context read\n");
+
+	/* Clear interrupts */
+	rvu_write64(rvu, blkaddr, NPA_AF_RAS, intr);
+	return IRQ_HANDLED;
+}
+
+static bool rvu_npa_af_request_irq(struct rvu *rvu, int blkaddr, int offset,
+				   const char *name, irq_handler_t fn)
+{
+	int rc;
+
+	WARN_ON(rvu->irq_allocated[offset]);
+	rvu->irq_allocated[offset] = false;
+	sprintf(&rvu->irq_name[offset * NAME_SIZE], name);
+	rc = request_irq(pci_irq_vector(rvu->pdev, offset), fn, 0,
+			 &rvu->irq_name[offset * NAME_SIZE], rvu);
+	if (rc)
+		dev_warn(rvu->dev, "Failed to register %s irq\n", name);
+	else
+		rvu->irq_allocated[offset] = true;
+
+	return rvu->irq_allocated[offset];
+}
+
+int rvu_npa_register_interrupts(struct rvu *rvu)
+{
+	int blkaddr, base;
+	bool rc;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
+	if (blkaddr < 0)
+		return blkaddr;
+
+	/* Get NPA AF MSIX vectors offset. */
+	base = rvu_read64(rvu, blkaddr, NPA_PRIV_AF_INT_CFG) & 0x3ff;
+	if (!base) {
+		dev_warn(rvu->dev,
+			 "Failed to get NPA_AF_INT vector offsets\n");
+		return 0;
+	}
+
+	/* Register and enable NPA_AF_RVU_INT interrupt */
+	rc = rvu_npa_af_request_irq(rvu, blkaddr, base +  NPA_AF_INT_VEC_RVU,
+				    "NPA_AF_RVU_INT",
+				    rvu_npa_af_rvu_intr_handler);
+	if (!rc)
+		goto err;
+	rvu_write64(rvu, blkaddr, NPA_AF_RVU_INT_ENA_W1S, ~0ULL);
+
+	/* Register and enable NPA_AF_GEN_INT interrupt */
+	rc = rvu_npa_af_request_irq(rvu, blkaddr, base + NPA_AF_INT_VEC_GEN,
+				    "NPA_AF_RVU_GEN",
+				    rvu_npa_af_gen_intr_handler);
+	if (!rc)
+		goto err;
+	rvu_write64(rvu, blkaddr, NPA_AF_GEN_INT_ENA_W1S, ~0ULL);
+
+	/* Register and enable NPA_AF_ERR_INT interrupt */
+	rc = rvu_npa_af_request_irq(rvu, blkaddr, base + NPA_AF_INT_VEC_AF_ERR,
+				    "NPA_AF_ERR_INT",
+				    rvu_npa_af_err_intr_handler);
+	if (!rc)
+		goto err;
+	rvu_write64(rvu, blkaddr, NPA_AF_ERR_INT_ENA_W1S, ~0ULL);
+
+	/* Register and enable NPA_AF_RAS interrupt */
+	rc = rvu_npa_af_request_irq(rvu, blkaddr, base + NPA_AF_INT_VEC_POISON,
+				    "NPA_AF_RAS",
+				    rvu_npa_af_ras_intr_handler);
+	if (!rc)
+		goto err;
+	rvu_write64(rvu, blkaddr, NPA_AF_RAS_ENA_W1S, ~0ULL);
+
+	return 0;
+err:
+	rvu_npa_unregister_interrupts(rvu);
+	return rc;
+}
+
+void rvu_npa_unregister_interrupts(struct rvu *rvu)
+{
+	int i, offs, blkaddr;
+	u64 reg;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
+	if (blkaddr < 0)
+		return;
+
+	reg = rvu_read64(rvu, blkaddr, NPA_PRIV_AF_INT_CFG);
+	offs = reg & 0x3FF;
+
+	rvu_write64(rvu, blkaddr, NPA_AF_RVU_INT_ENA_W1C, ~0ULL);
+	rvu_write64(rvu, blkaddr, NPA_AF_GEN_INT_ENA_W1C, ~0ULL);
+	rvu_write64(rvu, blkaddr, NPA_AF_ERR_INT_ENA_W1C, ~0ULL);
+	rvu_write64(rvu, blkaddr, NPA_AF_RAS_ENA_W1C, ~0ULL);
+
+	for (i = 0; i < NPA_AF_INT_VEC_CNT; i++)
+		if (rvu->irq_allocated[offs + i]) {
+			free_irq(pci_irq_vector(rvu->pdev, offs + i), rvu);
+			rvu->irq_allocated[offs + i] = false;
+		}
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index a3ecb5de9000..bf5f03aeb5f0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -60,6 +60,16 @@ enum rvu_af_int_vec_e {
 	RVU_AF_INT_VEC_CNT    = 0x5,
 };

+/* NPA Admin function Interrupt Vector Enumeration */
+enum npa_af_int_vec_e {
+	NPA_AF_INT_VEC_RVU	= 0x0,
+	NPA_AF_INT_VEC_GEN	= 0x1,
+	NPA_AF_INT_VEC_AQ_DONE	= 0x2,
+	NPA_AF_INT_VEC_AF_ERR	= 0x3,
+	NPA_AF_INT_VEC_POISON	= 0x4,
+	NPA_AF_INT_VEC_CNT	= 0x5,
+};
+
 /**
  * RVU PF Interrupt Vector Enumeration
  */
@@ -100,6 +110,19 @@ enum npa_aq_instop {
 	NPA_AQ_INSTOP_UNLOCK = 0x5,
 };

+/* ALLOC/FREE input queues Enumeration from coprocessors */
+enum npa_inpq {
+	NPA_INPQ_NIX0_RX       = 0x0,
+	NPA_INPQ_NIX0_TX       = 0x1,
+	NPA_INPQ_NIX1_RX       = 0x2,
+	NPA_INPQ_NIX1_TX       = 0x3,
+	NPA_INPQ_SSO           = 0x4,
+	NPA_INPQ_TIM           = 0x5,
+	NPA_INPQ_DPI           = 0x6,
+	NPA_INPQ_AURA_OP       = 0xe,
+	NPA_INPQ_INTERNAL_RSV  = 0xf,
+};
+
 /* NPA admin queue instruction structure */
 struct npa_aq_inst_s {
 #if defined(__BIG_ENDIAN_BITFIELD)
--
2.17.1
