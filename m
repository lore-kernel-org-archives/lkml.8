Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8801C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A785B21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD9KbQRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIJTeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbgIJPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:46:56 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA255C0617AB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:04:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gr14so9252068ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3UPlh3Kyd3Y4TY4RZl2rxdxtBbfraaBRvID8Rle5+Mg=;
        b=BD9KbQRzjtq6zrQc9NFmvlPMK4of6zDGEF8y4yRn5fExSO3y0KsjiEb61n3Xmysgh8
         VGVLMPe0N1DVxzhTcwNk1mX9n5UIfpWInRVKXQtfMr793pIC6uY2rz7z9+VLII/YMzXM
         csxUQDX+ziMXosAAkj2YrAeg3tqno/TZeHcwCcFqhRT+wqkPA0wftFA2rPS3avmS7GVo
         J/Fn8PIq9Q5Dc6Wp1da0RIXXplWTwsfq5hi7WVvW42GtRYBj+icTNcq85Gnda13SbXSE
         0J49bK14hMrK4c+utKgn44VMpV/3YpzmeHkjh2uq+Udsu11SNAM/hkTvky3wFzzw2sA7
         DiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3UPlh3Kyd3Y4TY4RZl2rxdxtBbfraaBRvID8Rle5+Mg=;
        b=tSCKZ3LrtKm3nfcebkqcbTkUBKDNzu1/M5IQXzy5rx5HeMZkPJurHcbUzu3HO/YMjE
         Tncp2/uzhYI9qOY+K7gf+nna5bLwt+Vg4VKhfHvzVPFIy+K3QPN1YWkDe9VRDt+L5XTy
         YberFJAV6dVOAoIsJPMbvFDtJCvjy0HEUW1IO1fh3eEJ5o5xkI6I5PqC0WSFCzHG9u/5
         r8qwZbpKdkmVyJ1o7nXkHCRVSI0p5Ot50zwwybVrODyrUSwddam15o+FH4LJ2b9bn6L+
         lcWpkOtc0jKgmGiV/hovm7LjoyxA1muACPk1hZ3VaVbqMl9dnUVKbQcjuSmKbxUH+dIg
         smKA==
X-Gm-Message-State: AOAM530OBO3lJ2uJsdpkUdxCIQmLHWf7/NhjUOEoMi/jfTy/DmW8yBZh
        GIi1hbWb7qzVuF897geBSnGVPh0gf0Q=
X-Google-Smtp-Source: ABdhPJxOTIyh31yb4f3+y791eNHSdne+YYppbXiXlhSaSyotwHbrhunvMsXUyRPBWDWj4lbR5ud3sg==
X-Received: by 2002:a17:907:374:: with SMTP id rs20mr9726694ejb.135.1599750250719;
        Thu, 10 Sep 2020 08:04:10 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id o3sm7443925edt.79.2020.09.10.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:04:09 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 14/15] habanalabs/gaudi: support DCB protocol
Date:   Thu, 10 Sep 2020 18:03:27 +0300
Message-Id: <20200910150328.20545-15-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910150328.20545-1-oded.gabbay@gmail.com>
References: <20200910150328.20545-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Add DCB support to configure the NIC's Priority Flow Control (PFC).
The added support is minimal because a full support is not
currently required.

A summary of the supported callbacks:

- ieee_getpfc: get the current PFC configuration. PFC is enabled by
               default.
- ieee_setpfc: set PFC configuration. Only 0 or all 4 priorities can be
               enabled, no subset is allowed.
- getdcbx: get DCBX capability.
- setdcbx: set DCBX capability. Only host LLDP agent and IEEE protocol
           flavors are supported.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/Makefile        |   2 +-
 drivers/misc/habanalabs/gaudi/gaudi_nic.c     |   3 +
 .../misc/habanalabs/gaudi/gaudi_nic_dcbnl.c   | 108 ++++++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic_dcbnl.c

diff --git a/drivers/misc/habanalabs/gaudi/Makefile b/drivers/misc/habanalabs/gaudi/Makefile
index e3002dc34a74..9757c8ba1cb0 100644
--- a/drivers/misc/habanalabs/gaudi/Makefile
+++ b/drivers/misc/habanalabs/gaudi/Makefile
@@ -3,5 +3,5 @@ HL_GAUDI_FILES := gaudi/gaudi.o gaudi/gaudi_hwmgr.o gaudi/gaudi_security.o \
 	gaudi/gaudi_coresight.o
 
 HL_GAUDI_FILES += gaudi/gaudi_nic.o gaudi/gaudi_phy.o \
-	gaudi/gaudi_nic_ethtool.o \
+	gaudi/gaudi_nic_ethtool.o gaudi/gaudi_nic_dcbnl.o \
 	gaudi/gaudi_nic_debugfs.o
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_nic.c b/drivers/misc/habanalabs/gaudi/gaudi_nic.c
index 108db990efa8..1ea410cdafdf 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_nic.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_nic.c
@@ -2745,6 +2745,9 @@ static int port_register(struct hl_device *hdev, int port)
 
 	ndev->netdev_ops = &gaudi_nic_netdev_ops;
 	ndev->ethtool_ops = &gaudi_nic_ethtool_ops;
+#ifdef CONFIG_DCB
+	ndev->dcbnl_ops = &gaudi_nic_dcbnl_ops;
+#endif
 	ndev->watchdog_timeo = NIC_TX_TIMEOUT;
 	ndev->min_mtu = ETH_MIN_MTU;
 	ndev->max_mtu = NIC_MAX_MTU;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_nic_dcbnl.c b/drivers/misc/habanalabs/gaudi/gaudi_nic_dcbnl.c
new file mode 100644
index 000000000000..b8f37fd0d3cf
--- /dev/null
+++ b/drivers/misc/habanalabs/gaudi/gaudi_nic_dcbnl.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2018-2020 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "gaudi_nic.h"
+
+#define PFC_PRIO_NUM		4
+#define PFC_PRIO_MASK_ALL	GENMASK(PFC_PRIO_NUM - 1, 0)
+#define PFC_PRIO_MASK_NONE	0
+#define PFC_STAT_TX_OFFSET	17
+#define PFC_STAT_RX_OFFSET	27
+
+#ifdef CONFIG_DCB
+static int gaudi_nic_dcbnl_ieee_getpfc(struct net_device *netdev,
+					struct ieee_pfc *pfc)
+{
+	struct gaudi_nic_device **ptr = netdev_priv(netdev);
+	struct gaudi_nic_device *gaudi_nic = *ptr;
+	struct hl_device *hdev = gaudi_nic->hdev;
+	u32 port = gaudi_nic->port;
+	int rc = 0, i, tx_idx, rx_idx;
+
+	if (disabled_or_in_reset(gaudi_nic)) {
+		dev_info_ratelimited(hdev->dev,
+				"port %d is in reset, can't get PFC", port);
+		return -EBUSY;
+	}
+
+	pfc->pfc_en = gaudi_nic->pfc_enable ? PFC_PRIO_MASK_ALL :
+							PFC_PRIO_MASK_NONE;
+	pfc->pfc_cap = PFC_PRIO_NUM;
+
+	for (i = 0 ; i < PFC_PRIO_NUM ; i++) {
+		tx_idx = PFC_STAT_TX_OFFSET + i;
+		rx_idx = PFC_STAT_RX_OFFSET + i;
+
+		pfc->requests[i] = gaudi_nic_read_mac_stat_counter(hdev, port,
+								tx_idx, false);
+		pfc->indications[i] = gaudi_nic_read_mac_stat_counter(hdev,
+							port, rx_idx, true);
+	}
+
+	return rc;
+}
+
+static int gaudi_nic_dcbnl_ieee_setpfc(struct net_device *netdev,
+					struct ieee_pfc *pfc)
+{
+	struct gaudi_nic_device **ptr = netdev_priv(netdev);
+	struct gaudi_nic_device *gaudi_nic = *ptr;
+	struct hl_device *hdev = gaudi_nic->hdev;
+	u32 port = gaudi_nic->port;
+	u8 curr_pfc_en;
+
+	if (pfc->pfc_en & ~PFC_PRIO_MASK_ALL) {
+		dev_info_ratelimited(hdev->dev,
+					"PFC supports %d priorities only, port %d\n",
+					PFC_PRIO_NUM, port);
+		return -EINVAL;
+	}
+
+	if ((pfc->pfc_en != PFC_PRIO_MASK_NONE) &&
+			(pfc->pfc_en != PFC_PRIO_MASK_ALL)) {
+		dev_info_ratelimited(hdev->dev,
+					"PFC should be enabled/disabled on all priorities, port %d\n",
+					port);
+		return -EINVAL;
+	}
+
+	if (disabled_or_in_reset(gaudi_nic)) {
+		dev_info_ratelimited(hdev->dev,
+				"port %d is in reset, can't set PFC", port);
+		return -EBUSY;
+	}
+
+	curr_pfc_en = gaudi_nic->pfc_enable ? PFC_PRIO_MASK_ALL :
+							PFC_PRIO_MASK_NONE;
+
+	if (pfc->pfc_en == curr_pfc_en)
+		return 0;
+
+	gaudi_nic->pfc_enable = !gaudi_nic->pfc_enable;
+
+	gaudi_nic_set_pfc(gaudi_nic);
+
+	return 0;
+}
+
+static u8 gaudi_nic_dcbnl_getdcbx(struct net_device *netdev)
+{
+	return DCB_CAP_DCBX_HOST | DCB_CAP_DCBX_VER_IEEE;
+}
+
+static u8 gaudi_nic_dcbnl_setdcbx(struct net_device *netdev, u8 mode)
+{
+	return !(mode == (DCB_CAP_DCBX_HOST | DCB_CAP_DCBX_VER_IEEE));
+}
+
+const struct dcbnl_rtnl_ops gaudi_nic_dcbnl_ops = {
+	.ieee_getpfc	= gaudi_nic_dcbnl_ieee_getpfc,
+	.ieee_setpfc	= gaudi_nic_dcbnl_ieee_setpfc,
+	.getdcbx	= gaudi_nic_dcbnl_getdcbx,
+	.setdcbx	= gaudi_nic_dcbnl_setdcbx
+};
+#endif
-- 
2.17.1

