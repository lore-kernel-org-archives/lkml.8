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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FF3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6555321D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pkj3AoKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgIJTxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731228AbgIJPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:04:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576DBC061798
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:03:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z22so9198364ejl.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HqUXASV8/J3adrJxXgdebB7pk8ZpozkrNnLZPnpPNz4=;
        b=Pkj3AoKbeUgiieMQGOBBSCv4hAIabp6HD4z7SwRKSQXzeQVnvUY9NclvHaMBB3AukI
         OeZ16zao3mj/tA5K/qnV/UXvBhDqtj9kXfih1Z/95CYitvGGUuH12OSbVwqGiBEPKc2X
         mPunU57VHbofMqqE2WILflqHCZ5aniN756WNwZQ8IntDcxuEK8fxG9FRXcvYoCG0ZIzH
         SXQNBBfPhHgLeP4gKejeaq1080pHRA8dYpoqkpV7HEaO3VMM8ukwpTCCFJG3cx0ML2Av
         U3XgwHp2t4S5mkZYftyAGZJ8yHB3QqZal3VKugtR4Oyci0plvPjq24R4rdVh7+H9ojXl
         JFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HqUXASV8/J3adrJxXgdebB7pk8ZpozkrNnLZPnpPNz4=;
        b=rNikSS03uwe/qPWJAibweUmFdnWZEVZ8RBz7lmItl1kPAOLc+wNPohDZW9s+j+0E5/
         0JArIAyh+ShNAY/CMIMXEmNjc70cEv/2WHpuERCYdGbaxpTXpKYY7HVKe0E997vLCgfJ
         3q6gfpJWspLSxzTNWsiLGfKcR47AnTBqmtf4aatAR1RN/HAZzTHKbyWb/XT8F5tBemHX
         hvXq0bHZH4TcPiC1CyGVwvoc5TjrqMuTgZmRnsPPA6DEx3Epwb0jcUkCpH/NJpscjV3w
         YCpW8Aw/aWB7TkRvfyjATzr1LIgwPOmLCXAVt77uKepcJtnEwFmp6/n7R4G3pIMsyGz4
         ujFg==
X-Gm-Message-State: AOAM530DYm6e8E4R2wxP5Q39x0hsBtLQojUBg4lwvNRDZ3ooxXvK4Jrx
        XNUOwE3sOcvxDiZ0S/5raCfrqEaORFg=
X-Google-Smtp-Source: ABdhPJyy8pgpuxkqHnwZgy5ljQ60MBDVDbkq2sTdP45lagzvQroYJGthXP4LKBlNHEuyDs4OX9jrYA==
X-Received: by 2002:a17:907:2055:: with SMTP id pg21mr9619393ejb.501.1599750219086;
        Thu, 10 Sep 2020 08:03:39 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id o3sm7443925edt.79.2020.09.10.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:03:38 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 02/15] habanalabs/gaudi: add NIC firmware-related definitions
Date:   Thu, 10 Sep 2020 18:03:15 +0300
Message-Id: <20200910150328.20545-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910150328.20545-1-oded.gabbay@gmail.com>
References: <20200910150328.20545-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Add new structures and messages that the driver use to interact with the
firmware to receive information and events (errors) about GAUDI's NIC.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../misc/habanalabs/include/common/cpucp_if.h | 34 ++++++++++++++++---
 .../habanalabs/include/gaudi/gaudi_fw_if.h    | 24 +++++++++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index dcde440427b4..ace746bb206e 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -9,6 +9,7 @@
 #define CPUCP_IF_H
 
 #include <linux/types.h>
+#include <linux/if_ether.h>
 
 /*
  * EVENT QUEUE
@@ -199,6 +200,11 @@ enum pq_init_status {
  *       CpuCP to write to the structure, to prevent data corruption in case of
  *       mismatched driver/FW versions.
  *
+ * CPUCP_PACKET_NIC_INFO_GET -
+ *       Fetch information from the device regarding the NIC. the host's driver
+ *       passes the max size it allows the CpuCP to write to the structure, to
+ *       prevent data corruption in case of mismatched driver/FW versions.
+ *
  * CPUCP_PACKET_TEMPERATURE_SET -
  *       Set the value of the offset property of a specified thermal sensor.
  *       The packet's arguments specify the desired sensor and the field to
@@ -238,12 +244,12 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_MAX_POWER_GET,		/* sysfs */
 	CPUCP_PACKET_MAX_POWER_SET,		/* sysfs */
 	CPUCP_PACKET_EEPROM_DATA_GET,		/* sysfs */
-	CPUCP_RESERVED,
+	CPUCP_PACKET_NIC_INFO_GET,		/* internal */
 	CPUCP_PACKET_TEMPERATURE_SET,		/* sysfs */
 	CPUCP_PACKET_VOLTAGE_SET,		/* sysfs */
 	CPUCP_PACKET_CURRENT_SET,		/* sysfs */
-	CPUCP_PACKET_PCIE_THROUGHPUT_GET,		/* internal */
-	CPUCP_PACKET_PCIE_REPLAY_CNT_GET,		/* internal */
+	CPUCP_PACKET_PCIE_THROUGHPUT_GET,	/* internal */
+	CPUCP_PACKET_PCIE_REPLAY_CNT_GET,	/* internal */
 	CPUCP_PACKET_TOTAL_ENERGY_GET,		/* internal */
 };
 
@@ -288,7 +294,7 @@ struct cpucp_packet {
 		/* For led set */
 		__le32 led_index;
 
-		/* For get CpuCP info/EEPROM data */
+		/* For get CpuCP info/EEPROM data/NIC info */
 		__le32 data_max_size;
 	};
 
@@ -367,6 +373,12 @@ struct eq_generic_event {
 #define CARD_NAME_MAX_LEN		16
 #define VERSION_MAX_LEN			128
 #define CPUCP_MAX_SENSORS		128
+#define CPUCP_MAX_NICS			128
+#define CPUCP_LANES_PER_NIC		4
+#define CPUCP_NIC_QSFP_EEPROM_MAX_LEN	1024
+#define CPUCP_MAX_NIC_LANES		(CPUCP_MAX_NICS * CPUCP_LANES_PER_NIC)
+#define CPUCP_NIC_MASK_ARR_LEN		((CPUCP_MAX_NICS + 63) / 64)
+#define CPUCP_NIC_POLARITY_ARR_LEN	((CPUCP_MAX_NIC_LANES + 63) / 64)
 
 struct cpucp_sensor {
 	__le32 type;
@@ -415,4 +427,18 @@ struct cpucp_info {
 	char card_name[CARD_NAME_MAX_LEN];
 };
 
+struct cpucp_mac_addr {
+	__u8 mac_addr[ETH_ALEN];
+};
+
+struct cpucp_nic_info {
+	struct cpucp_mac_addr mac_addrs[CPUCP_MAX_NICS];
+	__le64 link_mask[CPUCP_NIC_MASK_ARR_LEN];
+	__le64 pol_tx_mask[CPUCP_NIC_POLARITY_ARR_LEN];
+	__le64 pol_rx_mask[CPUCP_NIC_POLARITY_ARR_LEN];
+	__le64 link_ext_mask[CPUCP_NIC_MASK_ARR_LEN];
+	__u8 qsfp_eeprom[CPUCP_NIC_QSFP_EEPROM_MAX_LEN];
+	__le64 auto_neg_mask[CPUCP_NIC_MASK_ARR_LEN];
+};
+
 #endif /* CPUCP_IF_H */
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
index 8aadc6357da1..d61a4c87b765 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
@@ -8,6 +8,8 @@
 #ifndef GAUDI_FW_IF_H
 #define GAUDI_FW_IF_H
 
+#include <linux/types.h>
+
 #define GAUDI_EVENT_QUEUE_MSI_IDX	8
 #define GAUDI_NIC_PORT1_MSI_IDX		10
 #define GAUDI_NIC_PORT3_MSI_IDX		12
@@ -31,6 +33,28 @@ enum gaudi_pll_index {
 	IF_PLL
 };
 
+enum gaudi_nic_axi_error {
+	RXB,
+	RXE,
+	TXS,
+	TXE,
+	QPC_RESP,
+	NON_AXI_ERR,
+};
+
+/*
+ * struct eq_nic_sei_event - describes an AXI error cause.
+ * @axi_error_cause: one of the events defined in enum gaudi_nic_axi_error.
+ * @id: can be either 0 or 1, to further describe unit with interrupt cause
+ *      (i.e. TXE0 or TXE1).
+ * @pad[6]: padding structure to 64bit.
+ */
+struct eq_nic_sei_event {
+	__u8 axi_error_cause;
+	__u8 id;
+	__u8 pad[6];
+};
+
 #define GAUDI_PLL_FREQ_LOW		200000000 /* 200 MHz */
 
 #endif /* GAUDI_FW_IF_H */
-- 
2.17.1

