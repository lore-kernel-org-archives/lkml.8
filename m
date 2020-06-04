Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48588C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A6020897
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgFDHfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:35:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:32251 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgFDHfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:35:07 -0400
IronPort-SDR: vUq4SSJXPYtf/j85XCR1wccfiEOgm7F00BMvCuwfyZeOzpY7HIh3uPXNSJw6j3Sj/cDOGzy65L
 GGMOdrW40LYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 00:34:57 -0700
IronPort-SDR: esa9Ypk3UmCQcpph61KBDknHwtXEW3LOYZMSUOrO0HQaAq7JixmgHhhl9b+tMxNRKA28EEPHaP
 LluybsG8ezKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; 
   d="scan'208";a="348021574"
Received: from pg-nxl3.altera.com ([10.142.129.93])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2020 00:34:53 -0700
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Thor Thayer <thor.thayer@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dalon Westergreen <dalon.westergreen@linux.intel.com>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Dinh Nguyen <dinh.nguyen@intel.com>
Subject: [PATCH v3 06/10] net: eth: altera: Add missing identifier names to function declarations
Date:   Thu,  4 Jun 2020 15:32:52 +0800
Message-Id: <20200604073256.25702-7-joyce.ooi@intel.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20200604073256.25702-1-joyce.ooi@intel.com>
References: <20200604073256.25702-1-joyce.ooi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalon Westergreen <dalon.westergreen@linux.intel.com>

The sgdma and msgdma header files included function declarations
without identifier names for pointers.  Add appropriate identifier
names.

Signed-off-by: Dalon Westergreen <dalon.westergreen@linux.intel.com>
Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>
---
v2: this patch is added in patch version 2
v3: no change
---
 drivers/net/ethernet/altera/altera_msgdma.h | 30 ++++++++++++++-------------
 drivers/net/ethernet/altera/altera_sgdma.h  | 32 +++++++++++++++--------------
 2 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_msgdma.h b/drivers/net/ethernet/altera/altera_msgdma.h
index 9813fbfff4d3..23f5b2a13898 100644
--- a/drivers/net/ethernet/altera/altera_msgdma.h
+++ b/drivers/net/ethernet/altera/altera_msgdma.h
@@ -6,19 +6,21 @@
 #ifndef __ALTERA_MSGDMA_H__
 #define __ALTERA_MSGDMA_H__
 
-void msgdma_reset(struct altera_tse_private *);
-void msgdma_enable_txirq(struct altera_tse_private *);
-void msgdma_enable_rxirq(struct altera_tse_private *);
-void msgdma_disable_rxirq(struct altera_tse_private *);
-void msgdma_disable_txirq(struct altera_tse_private *);
-void msgdma_clear_rxirq(struct altera_tse_private *);
-void msgdma_clear_txirq(struct altera_tse_private *);
-u32 msgdma_tx_completions(struct altera_tse_private *);
-void msgdma_add_rx_desc(struct altera_tse_private *, struct tse_buffer *);
-int msgdma_tx_buffer(struct altera_tse_private *, struct tse_buffer *);
-u32 msgdma_rx_status(struct altera_tse_private *);
-int msgdma_initialize(struct altera_tse_private *);
-void msgdma_uninitialize(struct altera_tse_private *);
-void msgdma_start_rxdma(struct altera_tse_private *);
+void msgdma_reset(struct altera_tse_private *priv);
+void msgdma_enable_txirq(struct altera_tse_private *priv);
+void msgdma_enable_rxirq(struct altera_tse_private *priv);
+void msgdma_disable_rxirq(struct altera_tse_private *priv);
+void msgdma_disable_txirq(struct altera_tse_private *priv);
+void msgdma_clear_rxirq(struct altera_tse_private *priv);
+void msgdma_clear_txirq(struct altera_tse_private *priv);
+u32 msgdma_tx_completions(struct altera_tse_private *priv);
+void msgdma_add_rx_desc(struct altera_tse_private *priv,
+			struct tse_buffer *buffer);
+int msgdma_tx_buffer(struct altera_tse_private *priv,
+		     struct tse_buffer *buffer);
+u32 msgdma_rx_status(struct altera_tse_private *priv);
+int msgdma_initialize(struct altera_tse_private *priv);
+void msgdma_uninitialize(struct altera_tse_private *priv);
+void msgdma_start_rxdma(struct altera_tse_private *priv);
 
 #endif /*  __ALTERA_MSGDMA_H__ */
diff --git a/drivers/net/ethernet/altera/altera_sgdma.h b/drivers/net/ethernet/altera/altera_sgdma.h
index 08afe1c9994f..3fb201417820 100644
--- a/drivers/net/ethernet/altera/altera_sgdma.h
+++ b/drivers/net/ethernet/altera/altera_sgdma.h
@@ -6,20 +6,22 @@
 #ifndef __ALTERA_SGDMA_H__
 #define __ALTERA_SGDMA_H__
 
-void sgdma_reset(struct altera_tse_private *);
-void sgdma_enable_txirq(struct altera_tse_private *);
-void sgdma_enable_rxirq(struct altera_tse_private *);
-void sgdma_disable_rxirq(struct altera_tse_private *);
-void sgdma_disable_txirq(struct altera_tse_private *);
-void sgdma_clear_rxirq(struct altera_tse_private *);
-void sgdma_clear_txirq(struct altera_tse_private *);
-int sgdma_tx_buffer(struct altera_tse_private *priv, struct tse_buffer *);
-u32 sgdma_tx_completions(struct altera_tse_private *);
-void sgdma_add_rx_desc(struct altera_tse_private *priv, struct tse_buffer *);
-void sgdma_status(struct altera_tse_private *);
-u32 sgdma_rx_status(struct altera_tse_private *);
-int sgdma_initialize(struct altera_tse_private *);
-void sgdma_uninitialize(struct altera_tse_private *);
-void sgdma_start_rxdma(struct altera_tse_private *);
+void sgdma_reset(struct altera_tse_private *priv);
+void sgdma_enable_txirq(struct altera_tse_private *priv);
+void sgdma_enable_rxirq(struct altera_tse_private *priv);
+void sgdma_disable_rxirq(struct altera_tse_private *priv);
+void sgdma_disable_txirq(struct altera_tse_private *priv);
+void sgdma_clear_rxirq(struct altera_tse_private *priv);
+void sgdma_clear_txirq(struct altera_tse_private *priv);
+int sgdma_tx_buffer(struct altera_tse_private *priv,
+		    struct tse_buffer *buffer);
+u32 sgdma_tx_completions(struct altera_tse_private *priv);
+void sgdma_add_rx_desc(struct altera_tse_private *priv,
+		       struct tse_buffer *buffer);
+void sgdma_status(struct altera_tse_private *priv);
+u32 sgdma_rx_status(struct altera_tse_private *priv);
+int sgdma_initialize(struct altera_tse_private *priv);
+void sgdma_uninitialize(struct altera_tse_private *priv);
+void sgdma_start_rxdma(struct altera_tse_private *priv);
 
 #endif /*  __ALTERA_SGDMA_H__ */
-- 
2.13.0

