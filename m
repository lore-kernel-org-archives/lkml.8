Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D5AC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4C12076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xM67Iwmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGQNUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:20:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59550 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGQNUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:20:44 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKe6m112037;
        Fri, 17 Jul 2020 08:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594992040;
        bh=UCZPBWE5BRuKb4cOnM3DUnsgMsEyp2k2nTodxng89BI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xM67IwmxhtqzMuI0xz5i8N0w+u3W9hmZvBMuF3wt8jF5pocR8hRR237mOd6iYUlsh
         uP+A23+EfWHsoAthg9fDKqGVGdaYgOgs2V0XYGsOGiqgh+D4RClhLSaEyU8T9LWC78
         EkPW7JuKc+oFx8d865KpoVa/SUzcycubusaC1hzs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HDKe9u060974
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 08:20:40 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 08:20:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 08:20:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKdWj107470;
        Fri, 17 Jul 2020 08:20:40 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next v2 4/6] soc: ti: k3-ringacc: add request pair of rings api.
Date:   Fri, 17 Jul 2020 16:20:17 +0300
Message-ID: <20200717132019.20427-5-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717132019.20427-1-grygorii.strashko@ti.com>
References: <20200717132019.20427-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new API k3_ringacc_request_rings_pair() to request pair of rings at
once, as in the most cases Rings are used with DMA channels, which need to
request pair of rings - one to feed DMA with descriptors (TX/RX FDQ) and
one to receive completions (RX/TX CQ). This will allow to simplify Ringacc
API users.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/soc/ti/k3-ringacc.c       | 24 ++++++++++++++++++++++++
 include/linux/soc/ti/k3-ringacc.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 8a8f31d59e24..4cf1150de88e 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -322,6 +322,30 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
 }
 EXPORT_SYMBOL_GPL(k3_ringacc_request_ring);
 
+int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,
+				  int fwd_id, int compl_id,
+				  struct k3_ring **fwd_ring,
+				  struct k3_ring **compl_ring)
+{
+	int ret = 0;
+
+	if (!fwd_ring || !compl_ring)
+		return -EINVAL;
+
+	*fwd_ring = k3_ringacc_request_ring(ringacc, fwd_id, 0);
+	if (!(*fwd_ring))
+		return -ENODEV;
+
+	*compl_ring = k3_ringacc_request_ring(ringacc, compl_id, 0);
+	if (!(*compl_ring)) {
+		k3_ringacc_ring_free(*fwd_ring);
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(k3_ringacc_request_rings_pair);
+
 static void k3_ringacc_ring_reset_sci(struct k3_ring *ring)
 {
 	struct k3_ringacc *ringacc = ring->parent;
diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
index 26f73df0a524..7ac115432fa1 100644
--- a/include/linux/soc/ti/k3-ringacc.h
+++ b/include/linux/soc/ti/k3-ringacc.h
@@ -107,6 +107,10 @@ struct k3_ringacc *of_k3_ringacc_get_by_phandle(struct device_node *np,
 struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
 					int id, u32 flags);
 
+int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,
+				  int fwd_id, int compl_id,
+				  struct k3_ring **fwd_ring,
+				  struct k3_ring **compl_ring);
 /**
  * k3_ringacc_ring_reset - ring reset
  * @ring: pointer on Ring
-- 
2.17.1

