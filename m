Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B4C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0160C20BED
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584564941;
	bh=ww+xwOFBU3zz7iF4aJfE+W8ibmT3RGBIjIOVdYlprP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aStdH6cKsW7n9PtoZjgil6iu7UC1aqc3HiTTyc3gtEtQEMMThgN63lZa4/cDlJjBQ
	 8zo+vEMQBzk+KYT4daJ/0Pb4N3ecN+UTUPiwMDb2gF54Tv6A6lY2aMA1hgP2BnlKNS
	 EFd5kORH435l/YPzkRQqlgF2X82vqlZw4TX96uSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgCRUzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbgCRUzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:55:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74193208E0;
        Wed, 18 Mar 2020 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564936;
        bh=ww+xwOFBU3zz7iF4aJfE+W8ibmT3RGBIjIOVdYlprP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyK3PkrKrqwIl6ZEV0399QmD+8BQ76FMj+B3HaxeYb+wklD4dYtxpnjzIOhLfXoKo
         TTfQK5dh6LjbwLdDgkNuyiIn7qrfmj4F6P6U/vJJN66DQM475pbmb7VcCo55FNDeBi
         91h/upK0wKidu0zI//0EY1YDHJqWCVOACwJ+tR34=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/37] fsl/fman: detect FMan erratum A050385
Date:   Wed, 18 Mar 2020 16:54:54 -0400
Message-Id: <20200318205509.17053-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205509.17053-1-sashal@kernel.org>
References: <20200318205509.17053-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit b281f7b93b258ce1419043bbd898a29254d5c9c7 ]

Detect the presence of the A050385 erratum.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/Kconfig | 28 +++++++++++++++++++++
 drivers/net/ethernet/freescale/fman/fman.c  | 18 +++++++++++++
 drivers/net/ethernet/freescale/fman/fman.h  |  5 ++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/Kconfig b/drivers/net/ethernet/freescale/fman/Kconfig
index dc0850b3b517b..0b07ece83a2fe 100644
--- a/drivers/net/ethernet/freescale/fman/Kconfig
+++ b/drivers/net/ethernet/freescale/fman/Kconfig
@@ -7,3 +7,31 @@ config FSL_FMAN
 	help
 		Freescale Data-Path Acceleration Architecture Frame Manager
 		(FMan) support
+
+config DPAA_ERRATUM_A050385
+	bool
+	depends on ARM64 && FSL_DPAA
+	default y
+	help
+		DPAA FMan erratum A050385 software workaround implementation:
+		align buffers, data start, SG fragment length to avoid FMan DMA
+		splits.
+		FMAN DMA read or writes under heavy traffic load may cause FMAN
+		internal resource leak thus stopping further packet processing.
+		The FMAN internal queue can overflow when FMAN splits single
+		read or write transactions into multiple smaller transactions
+		such that more than 17 AXI transactions are in flight from FMAN
+		to interconnect. When the FMAN internal queue overflows, it can
+		stall further packet processing. The issue can occur with any
+		one of the following three conditions:
+		1. FMAN AXI transaction crosses 4K address boundary (Errata
+		A010022)
+		2. FMAN DMA address for an AXI transaction is not 16 byte
+		aligned, i.e. the last 4 bits of an address are non-zero
+		3. Scatter Gather (SG) frames have more than one SG buffer in
+		the SG list and any one of the buffers, except the last
+		buffer in the SG list has data size that is not a multiple
+		of 16 bytes, i.e., other than 16, 32, 48, 64, etc.
+		With any one of the above three conditions present, there is
+		likelihood of stalled FMAN packet processing, especially under
+		stress with multiple ports injecting line-rate traffic.
diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index e80fedb27cee8..21d8023535ae4 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -1,5 +1,6 @@
 /*
  * Copyright 2008-2015 Freescale Semiconductor Inc.
+ * Copyright 2020 NXP
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -566,6 +567,10 @@ struct fman_cfg {
 	u32 qmi_def_tnums_thresh;
 };
 
+#ifdef CONFIG_DPAA_ERRATUM_A050385
+static bool fman_has_err_a050385;
+#endif
+
 static irqreturn_t fman_exceptions(struct fman *fman,
 				   enum fman_exceptions exception)
 {
@@ -2517,6 +2522,14 @@ struct fman *fman_bind(struct device *fm_dev)
 }
 EXPORT_SYMBOL(fman_bind);
 
+#ifdef CONFIG_DPAA_ERRATUM_A050385
+bool fman_has_errata_a050385(void)
+{
+	return fman_has_err_a050385;
+}
+EXPORT_SYMBOL(fman_has_errata_a050385);
+#endif
+
 static irqreturn_t fman_err_irq(int irq, void *handle)
 {
 	struct fman *fman = (struct fman *)handle;
@@ -2844,6 +2857,11 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		goto fman_free;
 	}
 
+#ifdef CONFIG_DPAA_ERRATUM_A050385
+	fman_has_err_a050385 =
+		of_property_read_bool(fm_node, "fsl,erratum-a050385");
+#endif
+
 	return fman;
 
 fman_node_put:
diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index 935c317fa6964..f2ede1360f03a 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -1,5 +1,6 @@
 /*
  * Copyright 2008-2015 Freescale Semiconductor Inc.
+ * Copyright 2020 NXP
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -398,6 +399,10 @@ u16 fman_get_max_frm(void);
 
 int fman_get_rx_extra_headroom(void);
 
+#ifdef CONFIG_DPAA_ERRATUM_A050385
+bool fman_has_errata_a050385(void);
+#endif
+
 struct fman *fman_bind(struct device *dev);
 
 #endif /* __FM_H */
-- 
2.20.1

