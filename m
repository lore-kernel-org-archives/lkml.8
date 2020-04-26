Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD79C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 08:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2E72071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 08:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ34fFKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgDZIlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 04:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDZIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 04:41:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8057DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 01:41:36 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d17so7097417pgo.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/hn3JcKxN0S13cO3HF3zlhVdTTEZ7T4EOIDuTD56HzY=;
        b=KJ34fFKRVdMnPE0KgXcZNXPUsfW2keh59XM0TUNtuPdVnaRKlAO2sPii1n1QFQI63b
         WKLbs8oCU38CbQ9G5RPRgdHmHMjpspmmi514Q9QxO3k/2Ms2I4xS0ZsK0yeVeJzvwEpe
         /EkcaLBMhqzs4PTP45Uxmdpa2TGUFts0WNnhdLxxI+UB75gFhqyM15ltKZyGvjxbhr9/
         pAw6v66bdxLMOOLq6ooNvflZAbhtDkLApzMzsbU6qFZ0j8diKX6vD+59Zs62W7AEEEBg
         TJ4eJ75YPKYX+qh6VrAWXw/xd/IsB2AQPYV3eLYFf2Wwct1mWzY+oePGhf3cGxZ1qLKP
         +lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/hn3JcKxN0S13cO3HF3zlhVdTTEZ7T4EOIDuTD56HzY=;
        b=bDPoqRLESi5oU/ra+mubbYrg1XZPDMuuDO3UkjeRti6B50oIRdudBA0MZSx94b0grA
         Ii/xL+I+Ab0wUdi/0Aen1mjZxln5XHmH22M/LzhpFI67WQX6GBWxPgK66FNLIiHrNNOf
         TzCFqhipj1oTn+xxia122CY0V6QalnEUfbG39GWHI54q+xwk9Aq2AMs+jXertHpZL0M0
         zrK2LyuWC42qNpr4MfH7a+QK8a9huzafpHc1/GUoIpSdsYa53pGgPG8EtL9qweEA4E3j
         Q8IY2F+u2nf2dbjOxKmnszUsaMnoXvmb8Pz+t0bDMLBw2SYSUWOJ2d98v2ButeYgn9LJ
         wo5A==
X-Gm-Message-State: AGi0PubcLSD8+Ty9XwVRz8dkBhrcw+CKT/VqIN2Q5fykBcniZxuX6S7W
        ywtjyiRFnJ9X6D1WDuZTWDo=
X-Google-Smtp-Source: APiQypKTf5js5nk2nkooje9o09IndK/arDv8ZbZG3Xrf8EYPlJ8P1pnrlxouYvDTO7pKVwatkLR6gg==
X-Received: by 2002:a63:4f0a:: with SMTP id d10mr17376637pgb.146.1587890493364;
        Sun, 26 Apr 2020 01:41:33 -0700 (PDT)
Received: from localhost.localdomain ([211.51.91.100])
        by smtp.gmail.com with ESMTPSA id h14sm8397092pjc.46.2020.04.26.01.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 01:41:32 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: qlge: change prefix to qlge_*
Date:   Sun, 26 Apr 2020 17:41:20 +0900
Message-Id: <20200426084120.28295-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In terms of namespace, The driver uses either qlge_, ql_ or nothing.
also there is macro using QL_. This can make crash with other qlogic
drivers. Rename everything to use the qlge_ or QLGE_ prefix.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/qlge/qlge.h         |  488 +++++------
 drivers/staging/qlge/qlge_dbg.c     |  638 +++++++-------
 drivers/staging/qlge/qlge_ethtool.c |  484 +++++------
 drivers/staging/qlge/qlge_main.c    | 1200 +++++++++++++--------------
 drivers/staging/qlge/qlge_mpi.c     |  386 ++++-----
 5 files changed, 1598 insertions(+), 1598 deletions(-)

diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
index fc8c5ca8935d..a8da06c978ff 100644
--- a/drivers/staging/qlge/qlge.h
+++ b/drivers/staging/qlge/qlge.h
@@ -955,7 +955,7 @@ enum {
 	MB_CMD_GET_PORT_CFG = 0x00000123,
 	MB_CMD_GET_LINK_STS = 0x00000124,
 	MB_CMD_SET_LED_CFG = 0x00000125, /* Set LED Configuration Register */
-		QL_LED_BLINK = 0x03e803e8,
+		QLGE_LED_BLINK = 0x03e803e8,
 	MB_CMD_GET_LED_CFG = 0x00000126, /* Get LED Configuration Register */
 	MB_CMD_SET_MGMNT_TFK_CTL = 0x00000160, /* Set Mgmnt Traffic Control */
 	MB_SET_MPI_TFK_STOP = (1 << 0),
@@ -986,14 +986,14 @@ enum {
 	MB_CMD_STS_PARAM_ERR = 0x00004006,	/* Parameter Error. */
 };
 
-struct mbox_params {
+struct qlge_mbox_params {
 	u32 mbox_in[MAILBOX_COUNT];
 	u32 mbox_out[MAILBOX_COUNT];
 	int in_count;
 	int out_count;
 };
 
-struct flash_params_8012 {
+struct qlge_flash_params_8012 {
 	u8 dev_id_str[4];
 	__le16 size;
 	__le16 csum;
@@ -1010,7 +1010,7 @@ struct flash_params_8012 {
 #define FUNC1_FLASH_OFFSET 0x140600
 
 /* Flash related data structures. */
-struct flash_params_8000 {
+struct qlge_flash_params_8000 {
 	u8 dev_id_str[4];	/* "8000" */
 	__le16 ver;
 	__le16 size;
@@ -1036,15 +1036,15 @@ struct flash_params_8000 {
 	u8 reserved2[4];
 };
 
-union flash_params {
-	struct flash_params_8012 flash_params_8012;
-	struct flash_params_8000 flash_params_8000;
+union qlge_flash_params {
+	struct qlge_flash_params_8012 flash_params_8012;
+	struct qlge_flash_params_8000 flash_params_8000;
 };
 
 /*
  * doorbell space for the rx ring context
  */
-struct rx_doorbell_context {
+struct qlge_rx_doorbell_context {
 	u32 cnsmr_idx;		/* 0x00 */
 	u32 valid;		/* 0x04 */
 	u32 reserved[4];	/* 0x08-0x14 */
@@ -1055,7 +1055,7 @@ struct rx_doorbell_context {
 /*
  * doorbell space for the tx ring context
  */
-struct tx_doorbell_context {
+struct qlge_tx_doorbell_context {
 	u32 prod_idx;		/* 0x00 */
 	u32 valid;		/* 0x04 */
 	u32 reserved[4];	/* 0x08-0x14 */
@@ -1064,7 +1064,7 @@ struct tx_doorbell_context {
 };
 
 /* DATA STRUCTURES SHARED WITH HARDWARE. */
-struct tx_buf_desc {
+struct qlge_tx_buf_desc {
 	__le64 addr;
 	__le32 len;
 #define TX_DESC_LEN_MASK	0x000fffff
@@ -1082,7 +1082,7 @@ struct tx_buf_desc {
 #define OPCODE_IB_MPI_IOCB		0x21
 #define OPCODE_IB_AE_IOCB		0x3f
 
-struct ob_mac_iocb_req {
+struct qlge_ob_mac_iocb_req {
 	u8 opcode;
 	u8 flags1;
 #define OB_MAC_IOCB_REQ_OI	0x01
@@ -1102,10 +1102,10 @@ struct ob_mac_iocb_req {
 	__le32 reserved3;
 	__le16 vlan_tci;
 	__le16 reserved4;
-	struct tx_buf_desc tbd[TX_DESC_PER_IOCB];
+	struct qlge_tx_buf_desc tbd[TX_DESC_PER_IOCB];
 } __packed;
 
-struct ob_mac_iocb_rsp {
+struct qlge_ob_mac_iocb_rsp {
 	u8 opcode;		/* */
 	u8 flags1;		/* */
 #define OB_MAC_IOCB_RSP_OI	0x01	/* */
@@ -1122,7 +1122,7 @@ struct ob_mac_iocb_rsp {
 	__le32 reserved[13];
 } __packed;
 
-struct ob_mac_tso_iocb_req {
+struct qlge_ob_mac_tso_iocb_req {
 	u8 opcode;
 	u8 flags1;
 #define OB_MAC_TSO_IOCB_OI	0x01
@@ -1147,10 +1147,10 @@ struct ob_mac_tso_iocb_req {
 #define OB_MAC_TRANSPORT_HDR_SHIFT 6
 	__le16 vlan_tci;
 	__le16 mss;
-	struct tx_buf_desc tbd[TX_DESC_PER_IOCB];
+	struct qlge_tx_buf_desc tbd[TX_DESC_PER_IOCB];
 } __packed;
 
-struct ob_mac_tso_iocb_rsp {
+struct qlge_ob_mac_tso_iocb_rsp {
 	u8 opcode;
 	u8 flags1;
 #define OB_MAC_TSO_IOCB_RSP_OI	0x01
@@ -1167,7 +1167,7 @@ struct ob_mac_tso_iocb_rsp {
 	__le32 reserved2[13];
 } __packed;
 
-struct ib_mac_iocb_rsp {
+struct qlge_ib_mac_iocb_rsp {
 	u8 opcode;		/* 0x20 */
 	u8 flags1;
 #define IB_MAC_IOCB_RSP_OI	0x01	/* Override intr delay */
@@ -1226,7 +1226,7 @@ struct ib_mac_iocb_rsp {
 	__le64 hdr_addr;	/* */
 } __packed;
 
-struct ib_ae_iocb_rsp {
+struct qlge_ib_ae_iocb_rsp {
 	u8 opcode;
 	u8 flags1;
 #define IB_AE_IOCB_RSP_OI		0x01
@@ -1251,7 +1251,7 @@ struct ib_ae_iocb_rsp {
  * These three structures are for generic
  * handling of ib and ob iocbs.
  */
-struct ql_net_rsp_iocb {
+struct qlge_net_rsp_iocb {
 	u8 opcode;
 	u8 flags0;
 	__le16 length;
@@ -1259,7 +1259,7 @@ struct ql_net_rsp_iocb {
 	__le32 reserved[14];
 } __packed;
 
-struct net_req_iocb {
+struct qlge_net_req_iocb {
 	u8 opcode;
 	u8 flags0;
 	__le16 flags1;
@@ -1272,7 +1272,7 @@ struct net_req_iocb {
  * It is defined as:
  * "Work Queue Initialization Control Block"
  */
-struct wqicb {
+struct qlge_wqicb {
 	__le16 len;
 #define Q_LEN_V		(1 << 4)
 #define Q_LEN_CPP_CONT	0x0000
@@ -1298,7 +1298,7 @@ struct wqicb {
  * It is defined as:
  * "Completion Queue Initialization Control Block"
  */
-struct cqicb {
+struct qlge_cqicb {
 	u8 msix_vect;
 	u8 reserved1;
 	u8 reserved2;
@@ -1327,7 +1327,7 @@ struct cqicb {
 	__le16 sbq_len;		/* entry count */
 } __packed;
 
-struct ricb {
+struct qlge_ricb {
 	u8 base_cq;
 #define RSS_L4K 0x80
 	u8 flags;
@@ -1347,32 +1347,32 @@ struct ricb {
 
 /* SOFTWARE/DRIVER DATA STRUCTURES. */
 
-struct oal {
-	struct tx_buf_desc oal[TX_DESC_PER_OAL];
+struct qlge_oal {
+	struct qlge_tx_buf_desc oal[TX_DESC_PER_OAL];
 };
 
-struct map_list {
+struct qlge_map_list {
 	DEFINE_DMA_UNMAP_ADDR(mapaddr);
 	DEFINE_DMA_UNMAP_LEN(maplen);
 };
 
-struct tx_ring_desc {
+struct qlge_tx_ring_desc {
 	struct sk_buff *skb;
-	struct ob_mac_iocb_req *queue_entry;
+	struct qlge_ob_mac_iocb_req *queue_entry;
 	u32 index;
-	struct oal oal;
-	struct map_list map[MAX_SKB_FRAGS + 2];
+	struct qlge_oal oal;
+	struct qlge_map_list map[MAX_SKB_FRAGS + 2];
 	int map_cnt;
-	struct tx_ring_desc *next;
+	struct qlge_tx_ring_desc *next;
 };
 
-#define QL_TXQ_IDX(qdev, skb) (smp_processor_id() % (qdev->tx_ring_count))
+#define QLGE_TXQ_IDX(qdev, skb) (smp_processor_id() % (qdev->tx_ring_count))
 
-struct tx_ring {
+struct qlge_tx_ring {
 	/*
 	 * queue info.
 	 */
-	struct wqicb wqicb;	/* structure used to inform chip of new queue */
+	struct qlge_wqicb wqicb;	/* structure used to inform chip of new queue */
 	void *wq_base;		/* pci_alloc:virtual addr for tx */
 	dma_addr_t wq_base_dma;	/* pci_alloc:dma addr for tx */
 	__le32 *cnsmr_idx_sh_reg;	/* shadow copy of consumer idx */
@@ -1385,11 +1385,11 @@ struct tx_ring {
 	u16 cq_id;		/* completion (rx) queue for tx completions */
 	u8 wq_id;		/* queue id for this entry */
 	u8 reserved1[3];
-	struct tx_ring_desc *q;	/* descriptor list for the queue */
+	struct qlge_tx_ring_desc *q;	/* descriptor list for the queue */
 	spinlock_t lock;
 	atomic_t tx_count;	/* counts down for every outstanding IO */
 	struct delayed_work tx_work;
-	struct ql_adapter *qdev;
+	struct qlge_adapter *qdev;
 	u64 tx_packets;
 	u64 tx_bytes;
 	u64 tx_errors;
@@ -1438,9 +1438,9 @@ struct qlge_bq {
 #define QLGE_BQ_CONTAINER(bq) \
 ({ \
 	typeof(bq) _bq = bq; \
-	(struct rx_ring *)((char *)_bq - (_bq->type == QLGE_SB ? \
-					  offsetof(struct rx_ring, sbq) : \
-					  offsetof(struct rx_ring, lbq))); \
+	(struct qlge_rx_ring *)((char *)_bq - (_bq->type == QLGE_SB ? \
+					  offsetof(struct qlge_rx_ring, sbq) : \
+					  offsetof(struct qlge_rx_ring, lbq))); \
 })
 
 /* Experience shows that the device ignores the low 4 bits of the tail index.
@@ -1457,8 +1457,8 @@ struct qlge_bq {
 		     (_bq)->next_to_clean); \
 })
 
-struct rx_ring {
-	struct cqicb cqicb;	/* The chip's completion queue init control block. */
+struct qlge_rx_ring {
+	struct qlge_cqicb cqicb;	/* The chip's completion queue init control block. */
 
 	/* Completion queue elements. */
 	void *cq_base;
@@ -1470,7 +1470,7 @@ struct rx_ring {
 	dma_addr_t prod_idx_sh_reg_dma;
 	void __iomem *cnsmr_idx_db_reg;	/* PCI doorbell mem area + 0 */
 	u32 cnsmr_idx;		/* current sw idx */
-	struct ql_net_rsp_iocb *curr_entry;	/* next entry on queue */
+	struct qlge_net_rsp_iocb *curr_entry;	/* next entry on queue */
 	void __iomem *valid_db_reg;	/* PCI doorbell mem area + 0x04 */
 
 	/* Large buffer queue elements. */
@@ -1488,7 +1488,7 @@ struct rx_ring {
 	char name[IFNAMSIZ + 5];
 	struct napi_struct napi;
 	u8 reserved;
-	struct ql_adapter *qdev;
+	struct qlge_adapter *qdev;
 	u64 rx_packets;
 	u64 rx_multicast;
 	u64 rx_bytes;
@@ -1499,11 +1499,11 @@ struct rx_ring {
 /*
  * RSS Initialization Control Block
  */
-struct hash_id {
+struct qlge_hash_id {
 	u8 value[4];
 };
 
-struct nic_stats {
+struct qlge_nic_stats {
 	/*
 	 * These stats come from offset 200h to 278h
 	 * in the XGMAC register.
@@ -1623,7 +1623,7 @@ enum {
 };
 
 #define MPI_COREDUMP_COOKIE 0x5555aaaa
-struct mpi_coredump_global_header {
+struct qlge_mpi_coredump_global_header {
 	u32	cookie;
 	u8	id_string[16];
 	u32	time_lo;
@@ -1633,7 +1633,7 @@ struct mpi_coredump_global_header {
 	u8	info[220];
 };
 
-struct mpi_coredump_segment_header {
+struct qlge_mpi_coredump_segment_header {
 	u32	cookie;
 	u32	seg_num;
 	u32	seg_size;
@@ -1753,236 +1753,236 @@ enum {
 #define SHADOW_OFFSET	0xb0000000
 #define SHADOW_REG_SHIFT	20
 
-struct ql_nic_misc {
+struct qlge_nic_misc {
 	u32 rx_ring_count;
 	u32 tx_ring_count;
 	u32 intr_count;
 	u32 function;
 };
 
-struct ql_reg_dump {
+struct qlge_reg_dump {
 	/* segment 0 */
-	struct mpi_coredump_global_header mpi_global_header;
+	struct qlge_mpi_coredump_global_header mpi_global_header;
 
 	/* segment 16 */
-	struct mpi_coredump_segment_header nic_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header nic_regs_seg_hdr;
 	u32 nic_regs[64];
 
 	/* segment 30 */
-	struct mpi_coredump_segment_header misc_nic_seg_hdr;
-	struct ql_nic_misc misc_nic_info;
+	struct qlge_mpi_coredump_segment_header misc_nic_seg_hdr;
+	struct qlge_nic_misc misc_nic_info;
 
 	/* segment 31 */
 	/* one interrupt state for each CQ */
-	struct mpi_coredump_segment_header intr_states_seg_hdr;
+	struct qlge_mpi_coredump_segment_header intr_states_seg_hdr;
 	u32 intr_states[MAX_CPUS];
 
 	/* segment 32 */
 	/* 3 cam words each for 16 unicast,
 	 * 2 cam words for each of 32 multicast.
 	 */
-	struct mpi_coredump_segment_header cam_entries_seg_hdr;
+	struct qlge_mpi_coredump_segment_header cam_entries_seg_hdr;
 	u32 cam_entries[(16 * 3) + (32 * 3)];
 
 	/* segment 33 */
-	struct mpi_coredump_segment_header nic_routing_words_seg_hdr;
+	struct qlge_mpi_coredump_segment_header nic_routing_words_seg_hdr;
 	u32 nic_routing_words[16];
 
 	/* segment 34 */
-	struct mpi_coredump_segment_header ets_seg_hdr;
+	struct qlge_mpi_coredump_segment_header ets_seg_hdr;
 	u32 ets[8 + 2];
 };
 
-struct ql_mpi_coredump {
+struct qlge_mpi_coredump {
 	/* segment 0 */
-	struct mpi_coredump_global_header mpi_global_header;
+	struct qlge_mpi_coredump_global_header mpi_global_header;
 
 	/* segment 1 */
-	struct mpi_coredump_segment_header core_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header core_regs_seg_hdr;
 	u32 mpi_core_regs[MPI_CORE_REGS_CNT];
 	u32 mpi_core_sh_regs[MPI_CORE_SH_REGS_CNT];
 
 	/* segment 2 */
-	struct mpi_coredump_segment_header test_logic_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header test_logic_regs_seg_hdr;
 	u32 test_logic_regs[TEST_REGS_CNT];
 
 	/* segment 3 */
-	struct mpi_coredump_segment_header rmii_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header rmii_regs_seg_hdr;
 	u32 rmii_regs[RMII_REGS_CNT];
 
 	/* segment 4 */
-	struct mpi_coredump_segment_header fcmac1_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header fcmac1_regs_seg_hdr;
 	u32 fcmac1_regs[FCMAC_REGS_CNT];
 
 	/* segment 5 */
-	struct mpi_coredump_segment_header fcmac2_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header fcmac2_regs_seg_hdr;
 	u32 fcmac2_regs[FCMAC_REGS_CNT];
 
 	/* segment 6 */
-	struct mpi_coredump_segment_header fc1_mbx_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header fc1_mbx_regs_seg_hdr;
 	u32 fc1_mbx_regs[FC_MBX_REGS_CNT];
 
 	/* segment 7 */
-	struct mpi_coredump_segment_header ide_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header ide_regs_seg_hdr;
 	u32 ide_regs[IDE_REGS_CNT];
 
 	/* segment 8 */
-	struct mpi_coredump_segment_header nic1_mbx_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header nic1_mbx_regs_seg_hdr;
 	u32 nic1_mbx_regs[NIC_MBX_REGS_CNT];
 
 	/* segment 9 */
-	struct mpi_coredump_segment_header smbus_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header smbus_regs_seg_hdr;
 	u32 smbus_regs[SMBUS_REGS_CNT];
 
 	/* segment 10 */
-	struct mpi_coredump_segment_header fc2_mbx_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header fc2_mbx_regs_seg_hdr;
 	u32 fc2_mbx_regs[FC_MBX_REGS_CNT];
 
 	/* segment 11 */
-	struct mpi_coredump_segment_header nic2_mbx_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header nic2_mbx_regs_seg_hdr;
 	u32 nic2_mbx_regs[NIC_MBX_REGS_CNT];
 
 	/* segment 12 */
-	struct mpi_coredump_segment_header i2c_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header i2c_regs_seg_hdr;
 	u32 i2c_regs[I2C_REGS_CNT];
 	/* segment 13 */
-	struct mpi_coredump_segment_header memc_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header memc_regs_seg_hdr;
 	u32 memc_regs[MEMC_REGS_CNT];
 
 	/* segment 14 */
-	struct mpi_coredump_segment_header pbus_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header pbus_regs_seg_hdr;
 	u32 pbus_regs[PBUS_REGS_CNT];
 
 	/* segment 15 */
-	struct mpi_coredump_segment_header mde_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header mde_regs_seg_hdr;
 	u32 mde_regs[MDE_REGS_CNT];
 
 	/* segment 16 */
-	struct mpi_coredump_segment_header nic_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header nic_regs_seg_hdr;
 	u32 nic_regs[NIC_REGS_DUMP_WORD_COUNT];
 
 	/* segment 17 */
-	struct mpi_coredump_segment_header nic2_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header nic2_regs_seg_hdr;
 	u32 nic2_regs[NIC_REGS_DUMP_WORD_COUNT];
 
 	/* segment 18 */
-	struct mpi_coredump_segment_header xgmac1_seg_hdr;
+	struct qlge_mpi_coredump_segment_header xgmac1_seg_hdr;
 	u32 xgmac1[XGMAC_DUMP_WORD_COUNT];
 
 	/* segment 19 */
-	struct mpi_coredump_segment_header xgmac2_seg_hdr;
+	struct qlge_mpi_coredump_segment_header xgmac2_seg_hdr;
 	u32 xgmac2[XGMAC_DUMP_WORD_COUNT];
 
 	/* segment 20 */
-	struct mpi_coredump_segment_header code_ram_seg_hdr;
+	struct qlge_mpi_coredump_segment_header code_ram_seg_hdr;
 	u32 code_ram[CODE_RAM_CNT];
 
 	/* segment 21 */
-	struct mpi_coredump_segment_header memc_ram_seg_hdr;
+	struct qlge_mpi_coredump_segment_header memc_ram_seg_hdr;
 	u32 memc_ram[MEMC_RAM_CNT];
 
 	/* segment 22 */
-	struct mpi_coredump_segment_header xaui_an_hdr;
+	struct qlge_mpi_coredump_segment_header xaui_an_hdr;
 	u32 serdes_xaui_an[XG_SERDES_XAUI_AN_COUNT];
 
 	/* segment 23 */
-	struct mpi_coredump_segment_header xaui_hss_pcs_hdr;
+	struct qlge_mpi_coredump_segment_header xaui_hss_pcs_hdr;
 	u32 serdes_xaui_hss_pcs[XG_SERDES_XAUI_HSS_PCS_COUNT];
 
 	/* segment 24 */
-	struct mpi_coredump_segment_header xfi_an_hdr;
+	struct qlge_mpi_coredump_segment_header xfi_an_hdr;
 	u32 serdes_xfi_an[XG_SERDES_XFI_AN_COUNT];
 
 	/* segment 25 */
-	struct mpi_coredump_segment_header xfi_train_hdr;
+	struct qlge_mpi_coredump_segment_header xfi_train_hdr;
 	u32 serdes_xfi_train[XG_SERDES_XFI_TRAIN_COUNT];
 
 	/* segment 26 */
-	struct mpi_coredump_segment_header xfi_hss_pcs_hdr;
+	struct qlge_mpi_coredump_segment_header xfi_hss_pcs_hdr;
 	u32 serdes_xfi_hss_pcs[XG_SERDES_XFI_HSS_PCS_COUNT];
 
 	/* segment 27 */
-	struct mpi_coredump_segment_header xfi_hss_tx_hdr;
+	struct qlge_mpi_coredump_segment_header xfi_hss_tx_hdr;
 	u32 serdes_xfi_hss_tx[XG_SERDES_XFI_HSS_TX_COUNT];
 
 	/* segment 28 */
-	struct mpi_coredump_segment_header xfi_hss_rx_hdr;
+	struct qlge_mpi_coredump_segment_header xfi_hss_rx_hdr;
 	u32 serdes_xfi_hss_rx[XG_SERDES_XFI_HSS_RX_COUNT];
 
 	/* segment 29 */
-	struct mpi_coredump_segment_header xfi_hss_pll_hdr;
+	struct qlge_mpi_coredump_segment_header xfi_hss_pll_hdr;
 	u32 serdes_xfi_hss_pll[XG_SERDES_XFI_HSS_PLL_COUNT];
 
 	/* segment 30 */
-	struct mpi_coredump_segment_header misc_nic_seg_hdr;
-	struct ql_nic_misc misc_nic_info;
+	struct qlge_mpi_coredump_segment_header misc_nic_seg_hdr;
+	struct qlge_nic_misc misc_nic_info;
 
 	/* segment 31 */
 	/* one interrupt state for each CQ */
-	struct mpi_coredump_segment_header intr_states_seg_hdr;
+	struct qlge_mpi_coredump_segment_header intr_states_seg_hdr;
 	u32 intr_states[MAX_RX_RINGS];
 
 	/* segment 32 */
 	/* 3 cam words each for 16 unicast,
 	 * 2 cam words for each of 32 multicast.
 	 */
-	struct mpi_coredump_segment_header cam_entries_seg_hdr;
+	struct qlge_mpi_coredump_segment_header cam_entries_seg_hdr;
 	u32 cam_entries[(16 * 3) + (32 * 3)];
 
 	/* segment 33 */
-	struct mpi_coredump_segment_header nic_routing_words_seg_hdr;
+	struct qlge_mpi_coredump_segment_header nic_routing_words_seg_hdr;
 	u32 nic_routing_words[16];
 	/* segment 34 */
-	struct mpi_coredump_segment_header ets_seg_hdr;
+	struct qlge_mpi_coredump_segment_header ets_seg_hdr;
 	u32 ets[ETS_REGS_DUMP_WORD_COUNT];
 
 	/* segment 35 */
-	struct mpi_coredump_segment_header probe_dump_seg_hdr;
+	struct qlge_mpi_coredump_segment_header probe_dump_seg_hdr;
 	u32 probe_dump[PRB_MX_DUMP_TOT_COUNT];
 
 	/* segment 36 */
-	struct mpi_coredump_segment_header routing_reg_seg_hdr;
+	struct qlge_mpi_coredump_segment_header routing_reg_seg_hdr;
 	u32 routing_regs[RT_IDX_DUMP_TOT_WORDS];
 
 	/* segment 37 */
-	struct mpi_coredump_segment_header mac_prot_reg_seg_hdr;
+	struct qlge_mpi_coredump_segment_header mac_prot_reg_seg_hdr;
 	u32 mac_prot_regs[MAC_ADDR_DUMP_TOT_WORDS];
 
 	/* segment 38 */
-	struct mpi_coredump_segment_header xaui2_an_hdr;
+	struct qlge_mpi_coredump_segment_header xaui2_an_hdr;
 	u32 serdes2_xaui_an[XG_SERDES_XAUI_AN_COUNT];
 
 	/* segment 39 */
-	struct mpi_coredump_segment_header xaui2_hss_pcs_hdr;
+	struct qlge_mpi_coredump_segment_header xaui2_hss_pcs_hdr;
 	u32 serdes2_xaui_hss_pcs[XG_SERDES_XAUI_HSS_PCS_COUNT];
 
 	/* segment 40 */
-	struct mpi_coredump_segment_header xfi2_an_hdr;
+	struct qlge_mpi_coredump_segment_header xfi2_an_hdr;
 	u32 serdes2_xfi_an[XG_SERDES_XFI_AN_COUNT];
 
 	/* segment 41 */
-	struct mpi_coredump_segment_header xfi2_train_hdr;
+	struct qlge_mpi_coredump_segment_header xfi2_train_hdr;
 	u32 serdes2_xfi_train[XG_SERDES_XFI_TRAIN_COUNT];
 
 	/* segment 42 */
-	struct mpi_coredump_segment_header xfi2_hss_pcs_hdr;
+	struct qlge_mpi_coredump_segment_header xfi2_hss_pcs_hdr;
 	u32 serdes2_xfi_hss_pcs[XG_SERDES_XFI_HSS_PCS_COUNT];
 
 	/* segment 43 */
-	struct mpi_coredump_segment_header xfi2_hss_tx_hdr;
+	struct qlge_mpi_coredump_segment_header xfi2_hss_tx_hdr;
 	u32 serdes2_xfi_hss_tx[XG_SERDES_XFI_HSS_TX_COUNT];
 
 	/* segment 44 */
-	struct mpi_coredump_segment_header xfi2_hss_rx_hdr;
+	struct qlge_mpi_coredump_segment_header xfi2_hss_rx_hdr;
 	u32 serdes2_xfi_hss_rx[XG_SERDES_XFI_HSS_RX_COUNT];
 
 	/* segment 45 */
-	struct mpi_coredump_segment_header xfi2_hss_pll_hdr;
+	struct qlge_mpi_coredump_segment_header xfi2_hss_pll_hdr;
 	u32 serdes2_xfi_hss_pll[XG_SERDES_XFI_HSS_PLL_COUNT];
 
 	/* segment 50 */
 	/* semaphore register for all 5 functions */
-	struct mpi_coredump_segment_header sem_regs_seg_hdr;
+	struct qlge_mpi_coredump_segment_header sem_regs_seg_hdr;
 	u32 sem_regs[MAX_SEMAPHORE_FUNCTIONS];
 };
 
@@ -1991,8 +1991,8 @@ struct ql_mpi_coredump {
  * to hook the interrupts.  It is also used in a single
  * irq environment as a context to the ISR.
  */
-struct intr_context {
-	struct ql_adapter *qdev;
+struct qlge_intr_context {
+	struct qlge_adapter *qdev;
 	u32 intr;
 	u32 irq_mask;		/* Mask of which rings the vector services. */
 	u32 hooked;
@@ -2005,20 +2005,20 @@ struct intr_context {
 
 /* adapter flags definitions. */
 enum {
-	QL_ADAPTER_UP = 0,	/* Adapter has been brought up. */
-	QL_LEGACY_ENABLED = 1,
-	QL_MSI_ENABLED = 2,
-	QL_MSIX_ENABLED = 3,
-	QL_DMA64 = 4,
-	QL_PROMISCUOUS = 5,
-	QL_ALLMULTI = 6,
-	QL_PORT_CFG = 7,
-	QL_CAM_RT_SET = 8,
-	QL_SELFTEST = 9,
-	QL_LB_LINK_UP = 10,
-	QL_FRC_COREDUMP = 11,
-	QL_EEH_FATAL = 12,
-	QL_ASIC_RECOVERY = 14, /* We are in ascic recovery. */
+	QLGE_ADAPTER_UP = 0,	/* Adapter has been brought up. */
+	QLGE_LEGACY_ENABLED = 1,
+	QLGE_MSI_ENABLED = 2,
+	QLGE_MSIX_ENABLED = 3,
+	QLGE_DMA64 = 4,
+	QLGE_PROMISCUOUS = 5,
+	QLGE_ALLMULTI = 6,
+	QLGE_PORT_CFG = 7,
+	QLGE_CAM_RT_SET = 8,
+	QLGE_SELFTEST = 9,
+	QLGE_LB_LINK_UP = 10,
+	QLGE_FRC_COREDUMP = 11,
+	QLGE_EEH_FATAL = 12,
+	QLGE_ASIC_RECOVERY = 14, /* We are in ascic recovery. */
 };
 
 /* link_status bit definitions */
@@ -2056,21 +2056,21 @@ enum {
 	CFG_DEFAULT_MAX_FRAME_SIZE = 0x00002580,
 };
 
-struct nic_operations {
-	int (*get_flash) (struct ql_adapter *);
-	int (*port_initialize) (struct ql_adapter *);
+struct qlge_nic_operations {
+	int (*get_flash) (struct qlge_adapter *);
+	int (*port_initialize) (struct qlge_adapter *);
 };
 
 /*
  * The main Adapter structure definition.
  * This structure has all fields relevant to the hardware.
  */
-struct ql_adapter {
-	struct ricb ricb;
+struct qlge_adapter {
+	struct qlge_ricb ricb;
 	unsigned long flags;
 	u32 wol;
 
-	struct nic_stats nic_stats;
+	struct qlge_nic_stats nic_stats;
 
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 
@@ -2103,14 +2103,14 @@ struct ql_adapter {
 
 	u32 mailbox_in;
 	u32 mailbox_out;
-	struct mbox_params idc_mbc;
+	struct qlge_mbox_params idc_mbc;
 	struct mutex	mpi_mutex;
 
 	int tx_ring_size;
 	int rx_ring_size;
 	u32 intr_count;
 	struct msix_entry *msi_x_entry;
-	struct intr_context intr_context[MAX_RX_RINGS];
+	struct qlge_intr_context intr_context[MAX_RX_RINGS];
 
 	int tx_ring_count;	/* One per online CPU. */
 	u32 rss_ring_count;	/* One per irq vector.  */
@@ -2123,8 +2123,8 @@ struct ql_adapter {
 	int ring_mem_size;
 	void *ring_mem;
 
-	struct rx_ring rx_ring[MAX_RX_RINGS];
-	struct tx_ring tx_ring[MAX_TX_RINGS];
+	struct qlge_rx_ring rx_ring[MAX_RX_RINGS];
+	struct qlge_tx_ring tx_ring[MAX_TX_RINGS];
 	unsigned int lbq_buf_order;
 	u32 lbq_buf_size;
 
@@ -2140,13 +2140,13 @@ struct ql_adapter {
 	u32 port_link_up;
 	u32 port_init;
 	u32 link_status;
-	struct ql_mpi_coredump *mpi_coredump;
+	struct qlge_mpi_coredump *mpi_coredump;
 	u32 core_is_dumped;
 	u32 link_config;
 	u32 led_config;
 	u32 max_frame_size;
 
-	union flash_params flash;
+	union qlge_flash_params flash;
 
 	struct workqueue_struct *workqueue;
 	struct delayed_work asic_reset_work;
@@ -2156,7 +2156,7 @@ struct ql_adapter {
 	struct delayed_work mpi_idc_work;
 	struct delayed_work mpi_core_to_log;
 	struct completion ide_completion;
-	const struct nic_operations *nic_ops;
+	const struct qlge_nic_operations *nic_ops;
 	u16 device_id;
 	struct timer_list timer;
 	atomic_t lb_count;
@@ -2167,7 +2167,7 @@ struct ql_adapter {
 /*
  * Typical Register accessor for memory mapped device.
  */
-static inline u32 ql_read32(const struct ql_adapter *qdev, int reg)
+static inline u32 qlge_read32(const struct qlge_adapter *qdev, int reg)
 {
 	return readl(qdev->reg_base + reg);
 }
@@ -2175,7 +2175,7 @@ static inline u32 ql_read32(const struct ql_adapter *qdev, int reg)
 /*
  * Typical Register accessor for memory mapped device.
  */
-static inline void ql_write32(const struct ql_adapter *qdev, int reg, u32 val)
+static inline void qlge_write32(const struct qlge_adapter *qdev, int reg, u32 val)
 {
 	writel(val, qdev->reg_base + reg);
 }
@@ -2190,7 +2190,7 @@ static inline void ql_write32(const struct ql_adapter *qdev, int reg, u32 val)
  * 1 4k chunk of memory.  The lower half of the space is for outbound
  * queues. The upper half is for inbound queues.
  */
-static inline void ql_write_db_reg(u32 val, void __iomem *addr)
+static inline void qlge_write_db_reg(u32 val, void __iomem *addr)
 {
 	writel(val, addr);
 }
@@ -2206,7 +2206,7 @@ static inline void ql_write_db_reg(u32 val, void __iomem *addr)
  * queues. The upper half is for inbound queues.
  * Caller has to guarantee ordering.
  */
-static inline void ql_write_db_reg_relaxed(u32 val, void __iomem *addr)
+static inline void qlge_write_db_reg_relaxed(u32 val, void __iomem *addr)
 {
 	writel_relaxed(val, addr);
 }
@@ -2221,7 +2221,7 @@ static inline void ql_write_db_reg_relaxed(u32 val, void __iomem *addr)
  * update the relevant index register and then copy the value to the
  * shadow register in host memory.
  */
-static inline u32 ql_read_sh_reg(__le32  *addr)
+static inline u32 qlge_read_sh_reg(__le32  *addr)
 {
 	u32 reg;
 	reg =  le32_to_cpu(*addr);
@@ -2233,132 +2233,132 @@ extern char qlge_driver_name[];
 extern const char qlge_driver_version[];
 extern const struct ethtool_ops qlge_ethtool_ops;
 
-int ql_sem_spinlock(struct ql_adapter *qdev, u32 sem_mask);
-void ql_sem_unlock(struct ql_adapter *qdev, u32 sem_mask);
-int ql_read_xgmac_reg(struct ql_adapter *qdev, u32 reg, u32 *data);
-int ql_get_mac_addr_reg(struct ql_adapter *qdev, u32 type, u16 index,
+int qlge_sem_spinlock(struct qlge_adapter *qdev, u32 sem_mask);
+void qlge_sem_unlock(struct qlge_adapter *qdev, u32 sem_mask);
+int qlge_read_xgmac_reg(struct qlge_adapter *qdev, u32 reg, u32 *data);
+int qlge_get_mac_addr_reg(struct qlge_adapter *qdev, u32 type, u16 index,
 			u32 *value);
-int ql_get_routing_reg(struct ql_adapter *qdev, u32 index, u32 *value);
-int ql_write_cfg(struct ql_adapter *qdev, void *ptr, int size, u32 bit,
+int qlge_get_routing_reg(struct qlge_adapter *qdev, u32 index, u32 *value);
+int qlge_write_cfg(struct qlge_adapter *qdev, void *ptr, int size, u32 bit,
 		 u16 q_id);
-void ql_queue_fw_error(struct ql_adapter *qdev);
-void ql_mpi_work(struct work_struct *work);
-void ql_mpi_reset_work(struct work_struct *work);
-void ql_mpi_core_to_log(struct work_struct *work);
-int ql_wait_reg_rdy(struct ql_adapter *qdev, u32 reg, u32 bit, u32 ebit);
-void ql_queue_asic_error(struct ql_adapter *qdev);
-void ql_set_ethtool_ops(struct net_device *ndev);
-int ql_read_xgmac_reg64(struct ql_adapter *qdev, u32 reg, u64 *data);
-void ql_mpi_idc_work(struct work_struct *work);
-void ql_mpi_port_cfg_work(struct work_struct *work);
-int ql_mb_get_fw_state(struct ql_adapter *qdev);
-int ql_cam_route_initialize(struct ql_adapter *qdev);
-int ql_read_mpi_reg(struct ql_adapter *qdev, u32 reg, u32 *data);
-int ql_write_mpi_reg(struct ql_adapter *qdev, u32 reg, u32 data);
-int ql_unpause_mpi_risc(struct ql_adapter *qdev);
-int ql_pause_mpi_risc(struct ql_adapter *qdev);
-int ql_hard_reset_mpi_risc(struct ql_adapter *qdev);
-int ql_soft_reset_mpi_risc(struct ql_adapter *qdev);
-int ql_dump_risc_ram_area(struct ql_adapter *qdev, void *buf, u32 ram_addr,
+void qlge_queue_fw_error(struct qlge_adapter *qdev);
+void qlge_mpi_work(struct work_struct *work);
+void qlge_mpi_reset_work(struct work_struct *work);
+void qlge_mpi_core_to_log(struct work_struct *work);
+int qlge_wait_reg_rdy(struct qlge_adapter *qdev, u32 reg, u32 bit, u32 ebit);
+void qlge_queue_asic_error(struct qlge_adapter *qdev);
+void qlge_set_ethtool_ops(struct net_device *ndev);
+int qlge_read_xgmac_reg64(struct qlge_adapter *qdev, u32 reg, u64 *data);
+void qlge_mpi_idc_work(struct work_struct *work);
+void qlge_mpi_port_cfg_work(struct work_struct *work);
+int qlge_mb_get_fw_state(struct qlge_adapter *qdev);
+int qlge_cam_route_initialize(struct qlge_adapter *qdev);
+int qlge_read_mpi_reg(struct qlge_adapter *qdev, u32 reg, u32 *data);
+int qlge_write_mpi_reg(struct qlge_adapter *qdev, u32 reg, u32 data);
+int qlge_unpause_mpi_risc(struct qlge_adapter *qdev);
+int qlge_pause_mpi_risc(struct qlge_adapter *qdev);
+int qlge_hard_reset_mpi_risc(struct qlge_adapter *qdev);
+int qlge_soft_reset_mpi_risc(struct qlge_adapter *qdev);
+int qlge_dump_risc_ram_area(struct qlge_adapter *qdev, void *buf, u32 ram_addr,
 			  int word_count);
-int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi_coredump *mpi_coredump);
-int ql_mb_about_fw(struct ql_adapter *qdev);
-int ql_mb_wol_set_magic(struct ql_adapter *qdev, u32 enable_wol);
-int ql_mb_wol_mode(struct ql_adapter *qdev, u32 wol);
-int ql_mb_set_led_cfg(struct ql_adapter *qdev, u32 led_config);
-int ql_mb_get_led_cfg(struct ql_adapter *qdev);
-void ql_link_on(struct ql_adapter *qdev);
-void ql_link_off(struct ql_adapter *qdev);
-int ql_mb_set_mgmnt_traffic_ctl(struct ql_adapter *qdev, u32 control);
-int ql_mb_get_port_cfg(struct ql_adapter *qdev);
-int ql_mb_set_port_cfg(struct ql_adapter *qdev);
-int ql_wait_fifo_empty(struct ql_adapter *qdev);
-void ql_get_dump(struct ql_adapter *qdev, void *buff);
-netdev_tx_t ql_lb_send(struct sk_buff *skb, struct net_device *ndev);
-void ql_check_lb_frame(struct ql_adapter *, struct sk_buff *);
-int ql_own_firmware(struct ql_adapter *qdev);
-int ql_clean_lb_rx_ring(struct rx_ring *rx_ring, int budget);
-
-/* #define QL_ALL_DUMP */
-/* #define QL_REG_DUMP */
-/* #define QL_DEV_DUMP */
-/* #define QL_CB_DUMP */
-/* #define QL_IB_DUMP */
-/* #define QL_OB_DUMP */
-
-#ifdef QL_REG_DUMP
-void ql_dump_xgmac_control_regs(struct ql_adapter *qdev);
-void ql_dump_routing_entries(struct ql_adapter *qdev);
-void ql_dump_regs(struct ql_adapter *qdev);
-#define QL_DUMP_REGS(qdev) ql_dump_regs(qdev)
-#define QL_DUMP_ROUTE(qdev) ql_dump_routing_entries(qdev)
-#define QL_DUMP_XGMAC_CONTROL_REGS(qdev) ql_dump_xgmac_control_regs(qdev)
+int qlge_core_dump(struct qlge_adapter *qdev, struct qlge_mpi_coredump *mpi_coredump);
+int qlge_mb_about_fw(struct qlge_adapter *qdev);
+int qlge_mb_wol_set_magic(struct qlge_adapter *qdev, u32 enable_wol);
+int qlge_mb_wol_mode(struct qlge_adapter *qdev, u32 wol);
+int qlge_mb_set_led_cfg(struct qlge_adapter *qdev, u32 led_config);
+int qlge_mb_get_led_cfg(struct qlge_adapter *qdev);
+void qlge_link_on(struct qlge_adapter *qdev);
+void qlge_link_off(struct qlge_adapter *qdev);
+int qlge_mb_set_mgmnt_traffic_ctl(struct qlge_adapter *qdev, u32 control);
+int qlge_mb_get_port_cfg(struct qlge_adapter *qdev);
+int qlge_mb_set_port_cfg(struct qlge_adapter *qdev);
+int qlge_wait_fifo_empty(struct qlge_adapter *qdev);
+void qlge_get_dump(struct qlge_adapter *qdev, void *buff);
+netdev_tx_t qlge_lb_send(struct sk_buff *skb, struct net_device *ndev);
+void qlge_check_lb_frame(struct qlge_adapter *, struct sk_buff *);
+int qlge_own_firmware(struct qlge_adapter *qdev);
+int qlge_clean_lb_rx_ring(struct qlge_rx_ring *rx_ring, int budget);
+
+/* #define QLGE_ALL_DUMP */
+/* #define QLGE_REG_DUMP */
+/* #define QLGE_DEV_DUMP */
+/* #define QLGE_CB_DUMP */
+/* #define QLGE_IB_DUMP */
+/* #define QLGE_OB_DUMP */
+
+#ifdef QLGE_REG_DUMP
+void qlge_dump_xgmac_control_regs(struct qlge_adapter *qdev);
+void qlge_dump_routing_entries(struct qlge_adapter *qdev);
+void qlge_dump_regs(struct qlge_adapter *qdev);
+#define QLGE_DUMP_REGS(qdev) qlge_dump_regs(qdev)
+#define QLGE_DUMP_ROUTE(qdev) qlge_dump_routing_entries(qdev)
+#define QLGE_DUMP_XGMAC_CONTROL_REGS(qdev) qlge_dump_xgmac_control_regs(qdev)
 #else
-#define QL_DUMP_REGS(qdev)
-#define QL_DUMP_ROUTE(qdev)
-#define QL_DUMP_XGMAC_CONTROL_REGS(qdev)
+#define QLGE_DUMP_REGS(qdev)
+#define QLGE_DUMP_ROUTE(qdev)
+#define QLGE_DUMP_XGMAC_CONTROL_REGS(qdev)
 #endif
 
-#ifdef QL_STAT_DUMP
-void ql_dump_stat(struct ql_adapter *qdev);
-#define QL_DUMP_STAT(qdev) ql_dump_stat(qdev)
+#ifdef QLGE_STAT_DUMP
+void qlge_dump_stat(struct qlge_adapter *qdev);
+#define QLGE_DUMP_STAT(qdev) qlge_dump_stat(qdev)
 #else
-#define QL_DUMP_STAT(qdev)
+#define QLGE_DUMP_STAT(qdev)
 #endif
 
-#ifdef QL_DEV_DUMP
-void ql_dump_qdev(struct ql_adapter *qdev);
-#define QL_DUMP_QDEV(qdev) ql_dump_qdev(qdev)
+#ifdef QLGE_DEV_DUMP
+void qlge_dump_qdev(struct qlge_adapter *qdev);
+#define QLGE_DUMP_QDEV(qdev) qlge_dump_qdev(qdev)
 #else
-#define QL_DUMP_QDEV(qdev)
+#define QLGE_DUMP_QDEV(qdev)
 #endif
 
-#ifdef QL_CB_DUMP
-void ql_dump_wqicb(struct wqicb *wqicb);
-void ql_dump_tx_ring(struct tx_ring *tx_ring);
-void ql_dump_ricb(struct ricb *ricb);
-void ql_dump_cqicb(struct cqicb *cqicb);
-void ql_dump_rx_ring(struct rx_ring *rx_ring);
-void ql_dump_hw_cb(struct ql_adapter *qdev, int size, u32 bit, u16 q_id);
-#define QL_DUMP_RICB(ricb) ql_dump_ricb(ricb)
-#define QL_DUMP_WQICB(wqicb) ql_dump_wqicb(wqicb)
-#define QL_DUMP_TX_RING(tx_ring) ql_dump_tx_ring(tx_ring)
-#define QL_DUMP_CQICB(cqicb) ql_dump_cqicb(cqicb)
-#define QL_DUMP_RX_RING(rx_ring) ql_dump_rx_ring(rx_ring)
-#define QL_DUMP_HW_CB(qdev, size, bit, q_id) \
-		ql_dump_hw_cb(qdev, size, bit, q_id)
+#ifdef QLGE_CB_DUMP
+void qlge_dump_wqicb(struct qlge_wqicb *wqicb);
+void qlge_dump_tx_ring(struct qlge_tx_ring *tx_ring);
+void qlge_dump_ricb(struct qlge_ricb *ricb);
+void qlge_dump_cqicb(struct qlge_cqicb *cqicb);
+void qlge_dump_rx_ring(struct qlge_rx_ring *rx_ring);
+void qlge_dump_hw_cb(struct qlge_adapter *qdev, int size, u32 bit, u16 q_id);
+#define QLGE_DUMP_RICB(ricb) qlge_dump_ricb(ricb)
+#define QLGE_DUMP_WQICB(wqicb) qlge_dump_wqicb(wqicb)
+#define QLGE_DUMP_TX_RING(tx_ring) qlge_dump_tx_ring(tx_ring)
+#define QLGE_DUMP_CQICB(cqicb) qlge_dump_cqicb(cqicb)
+#define QLGE_DUMP_RX_RING(rx_ring) qlge_dump_rx_ring(rx_ring)
+#define QLGE_DUMP_HW_CB(qdev, size, bit, q_id) \
+		qlge_dump_hw_cb(qdev, size, bit, q_id)
 #else
-#define QL_DUMP_RICB(ricb)
-#define QL_DUMP_WQICB(wqicb)
-#define QL_DUMP_TX_RING(tx_ring)
-#define QL_DUMP_CQICB(cqicb)
-#define QL_DUMP_RX_RING(rx_ring)
-#define QL_DUMP_HW_CB(qdev, size, bit, q_id)
+#define QLGE_DUMP_RICB(ricb)
+#define QLGE_DUMP_WQICB(wqicb)
+#define QLGE_DUMP_TX_RING(tx_ring)
+#define QLGE_DUMP_CQICB(cqicb)
+#define QLGE_DUMP_RX_RING(rx_ring)
+#define QLGE_DUMP_HW_CB(qdev, size, bit, q_id)
 #endif
 
-#ifdef QL_OB_DUMP
-void ql_dump_tx_desc(struct tx_buf_desc *tbd);
-void ql_dump_ob_mac_iocb(struct ob_mac_iocb_req *ob_mac_iocb);
-void ql_dump_ob_mac_rsp(struct ob_mac_iocb_rsp *ob_mac_rsp);
-#define QL_DUMP_OB_MAC_IOCB(ob_mac_iocb) ql_dump_ob_mac_iocb(ob_mac_iocb)
-#define QL_DUMP_OB_MAC_RSP(ob_mac_rsp) ql_dump_ob_mac_rsp(ob_mac_rsp)
+#ifdef QLGE_OB_DUMP
+void qlge_dump_tx_desc(struct tx_buf_desc *tbd);
+void qlge_dump_ob_mac_iocb(struct qlge_ob_mac_iocb_req *ob_mac_iocb);
+void qlge_dump_ob_mac_rsp(struct qlge_ob_mac_iocb_rsp *ob_mac_rsp);
+#define QLGE_DUMP_OB_MAC_IOCB(ob_mac_iocb) qlge_dump_ob_mac_iocb(ob_mac_iocb)
+#define QLGE_DUMP_OB_MAC_RSP(ob_mac_rsp) qlge_dump_ob_mac_rsp(ob_mac_rsp)
 #else
-#define QL_DUMP_OB_MAC_IOCB(ob_mac_iocb)
-#define QL_DUMP_OB_MAC_RSP(ob_mac_rsp)
+#define QLGE_DUMP_OB_MAC_IOCB(ob_mac_iocb)
+#define QLGE_DUMP_OB_MAC_RSP(ob_mac_rsp)
 #endif
 
-#ifdef QL_IB_DUMP
-void ql_dump_ib_mac_rsp(struct ib_mac_iocb_rsp *ib_mac_rsp);
-#define QL_DUMP_IB_MAC_RSP(ib_mac_rsp) ql_dump_ib_mac_rsp(ib_mac_rsp)
+#ifdef QLGE_IB_DUMP
+void qlge_dump_ib_mac_rsp(struct qlge_ib_mac_iocb_rsp *ib_mac_rsp);
+#define QLGE_DUMP_IB_MAC_RSP(ib_mac_rsp) qlge_dump_ib_mac_rsp(ib_mac_rsp)
 #else
-#define QL_DUMP_IB_MAC_RSP(ib_mac_rsp)
+#define QLGE_DUMP_IB_MAC_RSP(ib_mac_rsp)
 #endif
 
-#ifdef	QL_ALL_DUMP
-void ql_dump_all(struct ql_adapter *qdev);
-#define QL_DUMP_ALL(qdev) ql_dump_all(qdev)
+#ifdef	QLGE_ALL_DUMP
+void qlge_dump_all(struct qlge_adapter *qdev);
+#define QLGE_DUMP_ALL(qdev) qlge_dump_all(qdev)
 #else
-#define QL_DUMP_ALL(qdev)
+#define QLGE_DUMP_ALL(qdev)
 #endif
 
 #endif /* _QLGE_H_ */
diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index 1795533cbd3a..aba9933baad5 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -6,7 +6,7 @@
 #include "qlge.h"
 
 /* Read a NIC register from the alternate function. */
-static u32 ql_read_other_func_reg(struct ql_adapter *qdev,
+static u32 qlge_read_other_func_reg(struct qlge_adapter *qdev,
 				  u32 reg)
 {
 	u32 register_to_read;
@@ -17,7 +17,7 @@ static u32 ql_read_other_func_reg(struct ql_adapter *qdev,
 				| MPI_NIC_READ
 				| (qdev->alt_func << MPI_NIC_FUNCTION_SHIFT)
 				| reg;
-	status = ql_read_mpi_reg(qdev, register_to_read, &reg_val);
+	status = qlge_read_mpi_reg(qdev, register_to_read, &reg_val);
 	if (status != 0)
 		return 0xffffffff;
 
@@ -25,7 +25,7 @@ static u32 ql_read_other_func_reg(struct ql_adapter *qdev,
 }
 
 /* Write a NIC register from the alternate function. */
-static int ql_write_other_func_reg(struct ql_adapter *qdev,
+static int qlge_write_other_func_reg(struct qlge_adapter *qdev,
 				   u32 reg, u32 reg_val)
 {
 	u32 register_to_read;
@@ -35,17 +35,17 @@ static int ql_write_other_func_reg(struct ql_adapter *qdev,
 				| (qdev->alt_func << MPI_NIC_FUNCTION_SHIFT)
 				| reg;
 
-	return ql_write_mpi_reg(qdev, register_to_read, reg_val);
+	return qlge_write_mpi_reg(qdev, register_to_read, reg_val);
 }
 
-static int ql_wait_other_func_reg_rdy(struct ql_adapter *qdev, u32 reg,
+static int qlge_wait_other_func_reg_rdy(struct qlge_adapter *qdev, u32 reg,
 				      u32 bit, u32 err_bit)
 {
 	u32 temp;
 	int count = 10;
 
 	while (count) {
-		temp = ql_read_other_func_reg(qdev, reg);
+		temp = qlge_read_other_func_reg(qdev, reg);
 
 		/* check for errors */
 		if (temp & err_bit)
@@ -58,57 +58,57 @@ static int ql_wait_other_func_reg_rdy(struct ql_adapter *qdev, u32 reg,
 	return -1;
 }
 
-static int ql_read_other_func_serdes_reg(struct ql_adapter *qdev, u32 reg,
+static int qlge_read_other_func_serdes_reg(struct qlge_adapter *qdev, u32 reg,
 					 u32 *data)
 {
 	int status;
 
 	/* wait for reg to come ready */
-	status = ql_wait_other_func_reg_rdy(qdev, XG_SERDES_ADDR / 4,
+	status = qlge_wait_other_func_reg_rdy(qdev, XG_SERDES_ADDR / 4,
 					    XG_SERDES_ADDR_RDY, 0);
 	if (status)
 		goto exit;
 
 	/* set up for reg read */
-	ql_write_other_func_reg(qdev, XG_SERDES_ADDR / 4, reg | PROC_ADDR_R);
+	qlge_write_other_func_reg(qdev, XG_SERDES_ADDR / 4, reg | PROC_ADDR_R);
 
 	/* wait for reg to come ready */
-	status = ql_wait_other_func_reg_rdy(qdev, XG_SERDES_ADDR / 4,
+	status = qlge_wait_other_func_reg_rdy(qdev, XG_SERDES_ADDR / 4,
 					    XG_SERDES_ADDR_RDY, 0);
 	if (status)
 		goto exit;
 
 	/* get the data */
-	*data = ql_read_other_func_reg(qdev, (XG_SERDES_DATA / 4));
+	*data = qlge_read_other_func_reg(qdev, (XG_SERDES_DATA / 4));
 exit:
 	return status;
 }
 
 /* Read out the SERDES registers */
-static int ql_read_serdes_reg(struct ql_adapter *qdev, u32 reg, u32 *data)
+static int qlge_read_serdes_reg(struct qlge_adapter *qdev, u32 reg, u32 *data)
 {
 	int status;
 
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev, XG_SERDES_ADDR, XG_SERDES_ADDR_RDY, 0);
+	status = qlge_wait_reg_rdy(qdev, XG_SERDES_ADDR, XG_SERDES_ADDR_RDY, 0);
 	if (status)
 		goto exit;
 
 	/* set up for reg read */
-	ql_write32(qdev, XG_SERDES_ADDR, reg | PROC_ADDR_R);
+	qlge_write32(qdev, XG_SERDES_ADDR, reg | PROC_ADDR_R);
 
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev, XG_SERDES_ADDR, XG_SERDES_ADDR_RDY, 0);
+	status = qlge_wait_reg_rdy(qdev, XG_SERDES_ADDR, XG_SERDES_ADDR_RDY, 0);
 	if (status)
 		goto exit;
 
 	/* get the data */
-	*data = ql_read32(qdev, XG_SERDES_DATA);
+	*data = qlge_read32(qdev, XG_SERDES_DATA);
 exit:
 	return status;
 }
 
-static void ql_get_both_serdes(struct ql_adapter *qdev, u32 addr,
+static void qlge_get_both_serdes(struct qlge_adapter *qdev, u32 addr,
 			       u32 *direct_ptr, u32 *indirect_ptr,
 			       bool direct_valid, bool indirect_valid)
 {
@@ -116,22 +116,22 @@ static void ql_get_both_serdes(struct ql_adapter *qdev, u32 addr,
 
 	status = 1;
 	if (direct_valid)
-		status = ql_read_serdes_reg(qdev, addr, direct_ptr);
+		status = qlge_read_serdes_reg(qdev, addr, direct_ptr);
 	/* Dead fill any failures or invalids. */
 	if (status)
 		*direct_ptr = 0xDEADBEEF;
 
 	status = 1;
 	if (indirect_valid)
-		status = ql_read_other_func_serdes_reg(
+		status = qlge_read_other_func_serdes_reg(
 						qdev, addr, indirect_ptr);
 	/* Dead fill any failures or invalids. */
 	if (status)
 		*indirect_ptr = 0xDEADBEEF;
 }
 
-static int ql_get_serdes_regs(struct ql_adapter *qdev,
-			      struct ql_mpi_coredump *mpi_coredump)
+static int qlge_get_serdes_regs(struct qlge_adapter *qdev,
+			      struct qlge_mpi_coredump *mpi_coredump)
 {
 	int status;
 	bool xfi_direct_valid = false, xfi_indirect_valid = false;
@@ -141,7 +141,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 	u32 *indirect_ptr;
 
 	/* The XAUI needs to be read out per port */
-	status = ql_read_other_func_serdes_reg(qdev,
+	status = qlge_read_other_func_serdes_reg(qdev,
 					       XG_SERDES_XAUI_HSS_PCS_START,
 					       &temp);
 	if (status)
@@ -151,7 +151,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 				XG_SERDES_ADDR_XAUI_PWR_DOWN)
 		xaui_indirect_valid = false;
 
-	status = ql_read_serdes_reg(qdev, XG_SERDES_XAUI_HSS_PCS_START, &temp);
+	status = qlge_read_serdes_reg(qdev, XG_SERDES_XAUI_HSS_PCS_START, &temp);
 
 	if (status)
 		temp = XG_SERDES_ADDR_XAUI_PWR_DOWN;
@@ -164,7 +164,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 	 * XFI register is shared so only need to read one
 	 * functions and then check the bits.
 	 */
-	status = ql_read_serdes_reg(qdev, XG_SERDES_ADDR_STS, &temp);
+	status = qlge_read_serdes_reg(qdev, XG_SERDES_ADDR_STS, &temp);
 	if (status)
 		temp = 0;
 
@@ -199,7 +199,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 	}
 
 	for (i = 0; i <= 0x000000034; i += 4, direct_ptr++, indirect_ptr++)
-		ql_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
 				   xaui_direct_valid, xaui_indirect_valid);
 
 	/* Get XAUI_HSS_PCS register block. */
@@ -216,7 +216,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 	}
 
 	for (i = 0x800; i <= 0x880; i += 4, direct_ptr++, indirect_ptr++)
-		ql_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
 				   xaui_direct_valid, xaui_indirect_valid);
 
 	/* Get XAUI_XFI_AN register block. */
@@ -229,7 +229,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 	}
 
 	for (i = 0x1000; i <= 0x1034; i += 4, direct_ptr++, indirect_ptr++)
-		ql_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
 				   xfi_direct_valid, xfi_indirect_valid);
 
 	/* Get XAUI_XFI_TRAIN register block. */
@@ -244,7 +244,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 	}
 
 	for (i = 0x1050; i <= 0x107c; i += 4, direct_ptr++, indirect_ptr++)
-		ql_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
 				   xfi_direct_valid, xfi_indirect_valid);
 
 	/* Get XAUI_XFI_HSS_PCS register block. */
@@ -261,7 +261,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 	}
 
 	for (i = 0x1800; i <= 0x1838; i += 4, direct_ptr++, indirect_ptr++)
-		ql_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
 				   xfi_direct_valid, xfi_indirect_valid);
 
 	/* Get XAUI_XFI_HSS_TX register block. */
@@ -276,7 +276,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 			mpi_coredump->serdes2_xfi_hss_tx;
 	}
 	for (i = 0x1c00; i <= 0x1c1f; i++, direct_ptr++, indirect_ptr++)
-		ql_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
 				   xfi_direct_valid, xfi_indirect_valid);
 
 	/* Get XAUI_XFI_HSS_RX register block. */
@@ -292,7 +292,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 	}
 
 	for (i = 0x1c40; i <= 0x1c5f; i++, direct_ptr++, indirect_ptr++)
-		ql_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
 				   xfi_direct_valid, xfi_indirect_valid);
 
 	/* Get XAUI_XFI_HSS_PLL register block. */
@@ -308,33 +308,33 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 			mpi_coredump->serdes2_xfi_hss_pll;
 	}
 	for (i = 0x1e00; i <= 0x1e1f; i++, direct_ptr++, indirect_ptr++)
-		ql_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
+		qlge_get_both_serdes(qdev, i, direct_ptr, indirect_ptr,
 				   xfi_direct_valid, xfi_indirect_valid);
 	return 0;
 }
 
-static int ql_read_other_func_xgmac_reg(struct ql_adapter *qdev, u32 reg,
+static int qlge_read_other_func_xgmac_reg(struct qlge_adapter *qdev, u32 reg,
 					u32 *data)
 {
 	int status = 0;
 
 	/* wait for reg to come ready */
-	status = ql_wait_other_func_reg_rdy(qdev, XGMAC_ADDR / 4,
+	status = qlge_wait_other_func_reg_rdy(qdev, XGMAC_ADDR / 4,
 					    XGMAC_ADDR_RDY, XGMAC_ADDR_XME);
 	if (status)
 		goto exit;
 
 	/* set up for reg read */
-	ql_write_other_func_reg(qdev, XGMAC_ADDR / 4, reg | XGMAC_ADDR_R);
+	qlge_write_other_func_reg(qdev, XGMAC_ADDR / 4, reg | XGMAC_ADDR_R);
 
 	/* wait for reg to come ready */
-	status = ql_wait_other_func_reg_rdy(qdev, XGMAC_ADDR / 4,
+	status = qlge_wait_other_func_reg_rdy(qdev, XGMAC_ADDR / 4,
 					    XGMAC_ADDR_RDY, XGMAC_ADDR_XME);
 	if (status)
 		goto exit;
 
 	/* get the data */
-	*data = ql_read_other_func_reg(qdev, XGMAC_DATA / 4);
+	*data = qlge_read_other_func_reg(qdev, XGMAC_DATA / 4);
 exit:
 	return status;
 }
@@ -342,7 +342,7 @@ static int ql_read_other_func_xgmac_reg(struct ql_adapter *qdev, u32 reg,
 /* Read the 400 xgmac control/statistics registers
  * skipping unused locations.
  */
-static int ql_get_xgmac_regs(struct ql_adapter *qdev, u32 *buf,
+static int qlge_get_xgmac_regs(struct qlge_adapter *qdev, u32 *buf,
 			     unsigned int other_function)
 {
 	int status = 0;
@@ -371,9 +371,9 @@ static int ql_get_xgmac_regs(struct ql_adapter *qdev, u32 *buf,
 			(i > 0x000005c8 && i < 0x00000600)) {
 			if (other_function)
 				status =
-				ql_read_other_func_xgmac_reg(qdev, i, buf);
+				qlge_read_other_func_xgmac_reg(qdev, i, buf);
 			else
-				status = ql_read_xgmac_reg(qdev, i, buf);
+				status = qlge_read_xgmac_reg(qdev, i, buf);
 
 			if (status)
 				*buf = 0xdeadbeef;
@@ -383,45 +383,45 @@ static int ql_get_xgmac_regs(struct ql_adapter *qdev, u32 *buf,
 	return status;
 }
 
-static int ql_get_ets_regs(struct ql_adapter *qdev, u32 *buf)
+static int qlge_get_ets_regs(struct qlge_adapter *qdev, u32 *buf)
 {
 	int i;
 
 	for (i = 0; i < 8; i++, buf++) {
-		ql_write32(qdev, NIC_ETS, i << 29 | 0x08000000);
-		*buf = ql_read32(qdev, NIC_ETS);
+		qlge_write32(qdev, NIC_ETS, i << 29 | 0x08000000);
+		*buf = qlge_read32(qdev, NIC_ETS);
 	}
 
 	for (i = 0; i < 2; i++, buf++) {
-		ql_write32(qdev, CNA_ETS, i << 29 | 0x08000000);
-		*buf = ql_read32(qdev, CNA_ETS);
+		qlge_write32(qdev, CNA_ETS, i << 29 | 0x08000000);
+		*buf = qlge_read32(qdev, CNA_ETS);
 	}
 
 	return 0;
 }
 
-static void ql_get_intr_states(struct ql_adapter *qdev, u32 *buf)
+static void qlge_get_intr_states(struct qlge_adapter *qdev, u32 *buf)
 {
 	int i;
 
 	for (i = 0; i < qdev->rx_ring_count; i++, buf++) {
-		ql_write32(qdev, INTR_EN,
+		qlge_write32(qdev, INTR_EN,
 			   qdev->intr_context[i].intr_read_mask);
-		*buf = ql_read32(qdev, INTR_EN);
+		*buf = qlge_read32(qdev, INTR_EN);
 	}
 }
 
-static int ql_get_cam_entries(struct ql_adapter *qdev, u32 *buf)
+static int qlge_get_cam_entries(struct qlge_adapter *qdev, u32 *buf)
 {
 	int i, status;
 	u32 value[3];
 
-	status = ql_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
 	if (status)
 		return status;
 
 	for (i = 0; i < 16; i++) {
-		status = ql_get_mac_addr_reg(qdev,
+		status = qlge_get_mac_addr_reg(qdev,
 					     MAC_ADDR_TYPE_CAM_MAC, i, value);
 		if (status) {
 			netif_err(qdev, drv, qdev->ndev,
@@ -433,7 +433,7 @@ static int ql_get_cam_entries(struct ql_adapter *qdev, u32 *buf)
 		*buf++ = value[2];	/* output */
 	}
 	for (i = 0; i < 32; i++) {
-		status = ql_get_mac_addr_reg(qdev,
+		status = qlge_get_mac_addr_reg(qdev,
 					     MAC_ADDR_TYPE_MULTI_MAC, i, value);
 		if (status) {
 			netif_err(qdev, drv, qdev->ndev,
@@ -444,21 +444,21 @@ static int ql_get_cam_entries(struct ql_adapter *qdev, u32 *buf)
 		*buf++ = value[1];	/* upper Mcast address */
 	}
 err:
-	ql_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
 	return status;
 }
 
-static int ql_get_routing_entries(struct ql_adapter *qdev, u32 *buf)
+static int qlge_get_routing_entries(struct qlge_adapter *qdev, u32 *buf)
 {
 	int status;
 	u32 value, i;
 
-	status = ql_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
 	if (status)
 		return status;
 
 	for (i = 0; i < 16; i++) {
-		status = ql_get_routing_reg(qdev, i, &value);
+		status = qlge_get_routing_reg(qdev, i, &value);
 		if (status) {
 			netif_err(qdev, drv, qdev->ndev,
 				  "Failed read of routing index register\n");
@@ -468,23 +468,23 @@ static int ql_get_routing_entries(struct ql_adapter *qdev, u32 *buf)
 		}
 	}
 err:
-	ql_sem_unlock(qdev, SEM_RT_IDX_MASK);
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
 	return status;
 }
 
 /* Read the MPI Processor shadow registers */
-static int ql_get_mpi_shadow_regs(struct ql_adapter *qdev, u32 *buf)
+static int qlge_get_mpi_shadow_regs(struct qlge_adapter *qdev, u32 *buf)
 {
 	u32 i;
 	int status;
 
 	for (i = 0; i < MPI_CORE_SH_REGS_CNT; i++, buf++) {
-		status = ql_write_mpi_reg(qdev,
+		status = qlge_write_mpi_reg(qdev,
 					  RISC_124,
 				(SHADOW_OFFSET | i << SHADOW_REG_SHIFT));
 		if (status)
 			goto end;
-		status = ql_read_mpi_reg(qdev, RISC_127, buf);
+		status = qlge_read_mpi_reg(qdev, RISC_127, buf);
 		if (status)
 			goto end;
 	}
@@ -493,13 +493,13 @@ static int ql_get_mpi_shadow_regs(struct ql_adapter *qdev, u32 *buf)
 }
 
 /* Read the MPI Processor core registers */
-static int ql_get_mpi_regs(struct ql_adapter *qdev, u32 *buf,
+static int qlge_get_mpi_regs(struct qlge_adapter *qdev, u32 *buf,
 			   u32 offset, u32 count)
 {
 	int i, status = 0;
 
 	for (i = 0; i < count; i++, buf++) {
-		status = ql_read_mpi_reg(qdev, offset + i, buf);
+		status = qlge_read_mpi_reg(qdev, offset + i, buf);
 		if (status)
 			return status;
 	}
@@ -507,7 +507,7 @@ static int ql_get_mpi_regs(struct ql_adapter *qdev, u32 *buf,
 }
 
 /* Read the ASIC probe dump */
-static unsigned int *ql_get_probe(struct ql_adapter *qdev, u32 clock,
+static unsigned int *qlge_get_probe(struct qlge_adapter *qdev, u32 clock,
 				  u32 valid, u32 *buf)
 {
 	u32 module, mux_sel, probe, lo_val, hi_val;
@@ -520,15 +520,15 @@ static unsigned int *ql_get_probe(struct ql_adapter *qdev, u32 clock,
 				| PRB_MX_ADDR_ARE
 				| mux_sel
 				| (module << PRB_MX_ADDR_MOD_SEL_SHIFT);
-			ql_write32(qdev, PRB_MX_ADDR, probe);
-			lo_val = ql_read32(qdev, PRB_MX_DATA);
+			qlge_write32(qdev, PRB_MX_ADDR, probe);
+			lo_val = qlge_read32(qdev, PRB_MX_DATA);
 			if (mux_sel == 0) {
 				*buf = probe;
 				buf++;
 			}
 			probe |= PRB_MX_ADDR_UP;
-			ql_write32(qdev, PRB_MX_ADDR, probe);
-			hi_val = ql_read32(qdev, PRB_MX_DATA);
+			qlge_write32(qdev, PRB_MX_ADDR, probe);
+			hi_val = qlge_read32(qdev, PRB_MX_DATA);
 			*buf = lo_val;
 			buf++;
 			*buf = hi_val;
@@ -538,23 +538,23 @@ static unsigned int *ql_get_probe(struct ql_adapter *qdev, u32 clock,
 	return buf;
 }
 
-static int ql_get_probe_dump(struct ql_adapter *qdev, unsigned int *buf)
+static int qlge_get_probe_dump(struct qlge_adapter *qdev, unsigned int *buf)
 {
 	/* First we have to enable the probe mux */
-	ql_write_mpi_reg(qdev, MPI_TEST_FUNC_PRB_CTL, MPI_TEST_FUNC_PRB_EN);
-	buf = ql_get_probe(qdev, PRB_MX_ADDR_SYS_CLOCK,
+	qlge_write_mpi_reg(qdev, MPI_TEST_FUNC_PRB_CTL, MPI_TEST_FUNC_PRB_EN);
+	buf = qlge_get_probe(qdev, PRB_MX_ADDR_SYS_CLOCK,
 			   PRB_MX_ADDR_VALID_SYS_MOD, buf);
-	buf = ql_get_probe(qdev, PRB_MX_ADDR_PCI_CLOCK,
+	buf = qlge_get_probe(qdev, PRB_MX_ADDR_PCI_CLOCK,
 			   PRB_MX_ADDR_VALID_PCI_MOD, buf);
-	buf = ql_get_probe(qdev, PRB_MX_ADDR_XGM_CLOCK,
+	buf = qlge_get_probe(qdev, PRB_MX_ADDR_XGM_CLOCK,
 			   PRB_MX_ADDR_VALID_XGM_MOD, buf);
-	buf = ql_get_probe(qdev, PRB_MX_ADDR_FC_CLOCK,
+	buf = qlge_get_probe(qdev, PRB_MX_ADDR_FC_CLOCK,
 			   PRB_MX_ADDR_VALID_FC_MOD, buf);
 	return 0;
 }
 
 /* Read out the routing index registers */
-static int ql_get_routing_index_registers(struct ql_adapter *qdev, u32 *buf)
+static int qlge_get_routing_index_registers(struct qlge_adapter *qdev, u32 *buf)
 {
 	int status;
 	u32 type, index, index_max;
@@ -562,7 +562,7 @@ static int ql_get_routing_index_registers(struct ql_adapter *qdev, u32 *buf)
 	u32 result_data;
 	u32 val;
 
-	status = ql_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
 	if (status)
 		return status;
 
@@ -575,11 +575,11 @@ static int ql_get_routing_index_registers(struct ql_adapter *qdev, u32 *buf)
 			val = RT_IDX_RS
 				| (type << RT_IDX_TYPE_SHIFT)
 				| (index << RT_IDX_IDX_SHIFT);
-			ql_write32(qdev, RT_IDX, val);
+			qlge_write32(qdev, RT_IDX, val);
 			result_index = 0;
 			while ((result_index & RT_IDX_MR) == 0)
-				result_index = ql_read32(qdev, RT_IDX);
-			result_data = ql_read32(qdev, RT_DATA);
+				result_index = qlge_read32(qdev, RT_IDX);
+			result_data = qlge_read32(qdev, RT_DATA);
 			*buf = type;
 			buf++;
 			*buf = index;
@@ -590,12 +590,12 @@ static int ql_get_routing_index_registers(struct ql_adapter *qdev, u32 *buf)
 			buf++;
 		}
 	}
-	ql_sem_unlock(qdev, SEM_RT_IDX_MASK);
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
 	return status;
 }
 
 /* Read out the MAC protocol registers */
-static void ql_get_mac_protocol_registers(struct ql_adapter *qdev, u32 *buf)
+static void qlge_get_mac_protocol_registers(struct qlge_adapter *qdev, u32 *buf)
 {
 	u32 result_index, result_data;
 	u32 type;
@@ -658,13 +658,13 @@ static void ql_get_mac_protocol_registers(struct ql_adapter *qdev, u32 *buf)
 					| (type << MAC_ADDR_TYPE_SHIFT)
 					| (index << MAC_ADDR_IDX_SHIFT)
 					| (offset);
-				ql_write32(qdev, MAC_ADDR_IDX, val);
+				qlge_write32(qdev, MAC_ADDR_IDX, val);
 				result_index = 0;
 				while ((result_index & MAC_ADDR_MR) == 0) {
-					result_index = ql_read32(qdev,
+					result_index = qlge_read32(qdev,
 								 MAC_ADDR_IDX);
 				}
-				result_data = ql_read32(qdev, MAC_ADDR_DATA);
+				result_data = qlge_read32(qdev, MAC_ADDR_DATA);
 				*buf = result_index;
 				buf++;
 				*buf = result_data;
@@ -674,7 +674,7 @@ static void ql_get_mac_protocol_registers(struct ql_adapter *qdev, u32 *buf)
 	}
 }
 
-static void ql_get_sem_registers(struct ql_adapter *qdev, u32 *buf)
+static void qlge_get_sem_registers(struct qlge_adapter *qdev, u32 *buf)
 {
 	u32 func_num, reg, reg_val;
 	int status;
@@ -683,7 +683,7 @@ static void ql_get_sem_registers(struct ql_adapter *qdev, u32 *buf)
 		reg = MPI_NIC_REG_BLOCK
 			| (func_num << MPI_NIC_FUNCTION_SHIFT)
 			| (SEM / 4);
-		status = ql_read_mpi_reg(qdev, reg, &reg_val);
+		status = qlge_read_mpi_reg(qdev, reg, &reg_val);
 		*buf = reg_val;
 		/* if the read failed then dead fill the element. */
 		if (!status)
@@ -693,11 +693,11 @@ static void ql_get_sem_registers(struct ql_adapter *qdev, u32 *buf)
 }
 
 /* Create a coredump segment header */
-static void ql_build_coredump_seg_header(
-		struct mpi_coredump_segment_header *seg_hdr,
+static void qlge_build_coredump_seg_header(
+		struct qlge_mpi_coredump_segment_header *seg_hdr,
 		u32 seg_number, u32 seg_size, u8 *desc)
 {
-	memset(seg_hdr, 0, sizeof(struct mpi_coredump_segment_header));
+	memset(seg_hdr, 0, sizeof(struct qlge_mpi_coredump_segment_header));
 	seg_hdr->cookie = MPI_COREDUMP_COOKIE;
 	seg_hdr->seg_num = seg_number;
 	seg_hdr->seg_size = seg_size;
@@ -711,7 +711,7 @@ static void ql_build_coredump_seg_header(
  * space for this function as well as a coredump structure that
  * will contain the dump.
  */
-int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi_coredump *mpi_coredump)
+int qlge_core_dump(struct qlge_adapter *qdev, struct qlge_mpi_coredump *mpi_coredump)
 {
 	int status;
 	int i;
@@ -725,9 +725,9 @@ int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi_coredump *mpi_coredump)
 	 * it isn't available.  If the firmware died it
 	 * might be holding the sem.
 	 */
-	ql_sem_spinlock(qdev, SEM_PROC_REG_MASK);
+	qlge_sem_spinlock(qdev, SEM_PROC_REG_MASK);
 
-	status = ql_pause_mpi_risc(qdev);
+	status = qlge_pause_mpi_risc(qdev);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Failed RISC pause. Status = 0x%.08x\n", status);
@@ -736,160 +736,160 @@ int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi_coredump *mpi_coredump)
 
 	/* Insert the global header */
 	memset(&(mpi_coredump->mpi_global_header), 0,
-	       sizeof(struct mpi_coredump_global_header));
+	       sizeof(struct qlge_mpi_coredump_global_header));
 	mpi_coredump->mpi_global_header.cookie = MPI_COREDUMP_COOKIE;
 	mpi_coredump->mpi_global_header.header_size =
-		sizeof(struct mpi_coredump_global_header);
+		sizeof(struct qlge_mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.image_size =
-		sizeof(struct ql_mpi_coredump);
+		sizeof(struct qlge_mpi_coredump);
 	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.id_string));
 
 	/* Get generic NIC reg dump */
-	ql_build_coredump_seg_header(&mpi_coredump->nic_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->nic_regs_seg_hdr,
 				     NIC1_CONTROL_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->nic_regs), "NIC1 Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->nic2_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->nic2_regs_seg_hdr,
 				     NIC2_CONTROL_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->nic2_regs), "NIC2 Registers");
 
 	/* Get XGMac registers. (Segment 18, Rev C. step 21) */
-	ql_build_coredump_seg_header(&mpi_coredump->xgmac1_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xgmac1_seg_hdr,
 				     NIC1_XGMAC_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->xgmac1), "NIC1 XGMac Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xgmac2_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xgmac2_seg_hdr,
 				     NIC2_XGMAC_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->xgmac2), "NIC2 XGMac Registers");
 
 	if (qdev->func & 1) {
 		/* Odd means our function is NIC 2 */
 		for (i = 0; i < NIC_REGS_DUMP_WORD_COUNT; i++)
 			mpi_coredump->nic2_regs[i] =
-					 ql_read32(qdev, i * sizeof(u32));
+					 qlge_read32(qdev, i * sizeof(u32));
 
 		for (i = 0; i < NIC_REGS_DUMP_WORD_COUNT; i++)
 			mpi_coredump->nic_regs[i] =
-			ql_read_other_func_reg(qdev, (i * sizeof(u32)) / 4);
+			qlge_read_other_func_reg(qdev, (i * sizeof(u32)) / 4);
 
-		ql_get_xgmac_regs(qdev, &mpi_coredump->xgmac2[0], 0);
-		ql_get_xgmac_regs(qdev, &mpi_coredump->xgmac1[0], 1);
+		qlge_get_xgmac_regs(qdev, &mpi_coredump->xgmac2[0], 0);
+		qlge_get_xgmac_regs(qdev, &mpi_coredump->xgmac1[0], 1);
 	} else {
 		/* Even means our function is NIC 1 */
 		for (i = 0; i < NIC_REGS_DUMP_WORD_COUNT; i++)
 			mpi_coredump->nic_regs[i] =
-					ql_read32(qdev, i * sizeof(u32));
+					qlge_read32(qdev, i * sizeof(u32));
 		for (i = 0; i < NIC_REGS_DUMP_WORD_COUNT; i++)
 			mpi_coredump->nic2_regs[i] =
-			ql_read_other_func_reg(qdev, (i * sizeof(u32)) / 4);
+			qlge_read_other_func_reg(qdev, (i * sizeof(u32)) / 4);
 
-		ql_get_xgmac_regs(qdev, &mpi_coredump->xgmac1[0], 0);
-		ql_get_xgmac_regs(qdev, &mpi_coredump->xgmac2[0], 1);
+		qlge_get_xgmac_regs(qdev, &mpi_coredump->xgmac1[0], 0);
+		qlge_get_xgmac_regs(qdev, &mpi_coredump->xgmac2[0], 1);
 	}
 
 	/* Rev C. Step 20a */
-	ql_build_coredump_seg_header(&mpi_coredump->xaui_an_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xaui_an_hdr,
 				     XAUI_AN_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes_xaui_an),
 			"XAUI AN Registers");
 
 	/* Rev C. Step 20b */
-	ql_build_coredump_seg_header(&mpi_coredump->xaui_hss_pcs_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xaui_hss_pcs_hdr,
 				     XAUI_HSS_PCS_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes_xaui_hss_pcs),
 			"XAUI HSS PCS Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi_an_hdr, XFI_AN_SEG_NUM,
-				     sizeof(struct mpi_coredump_segment_header) +
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_an_hdr, XFI_AN_SEG_NUM,
+				     sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes_xfi_an),
 			"XFI AN Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi_train_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_train_hdr,
 				     XFI_TRAIN_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes_xfi_train),
 			"XFI TRAIN Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi_hss_pcs_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_hss_pcs_hdr,
 				     XFI_HSS_PCS_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes_xfi_hss_pcs),
 			"XFI HSS PCS Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi_hss_tx_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_hss_tx_hdr,
 				     XFI_HSS_TX_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes_xfi_hss_tx),
 			"XFI HSS TX Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi_hss_rx_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_hss_rx_hdr,
 				     XFI_HSS_RX_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes_xfi_hss_rx),
 			"XFI HSS RX Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi_hss_pll_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi_hss_pll_hdr,
 				     XFI_HSS_PLL_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes_xfi_hss_pll),
 			"XFI HSS PLL Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xaui2_an_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xaui2_an_hdr,
 				     XAUI2_AN_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes2_xaui_an),
 			"XAUI2 AN Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xaui2_hss_pcs_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xaui2_hss_pcs_hdr,
 				     XAUI2_HSS_PCS_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes2_xaui_hss_pcs),
 			"XAUI2 HSS PCS Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi2_an_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_an_hdr,
 				     XFI2_AN_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes2_xfi_an),
 			"XFI2 AN Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi2_train_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_train_hdr,
 				     XFI2_TRAIN_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes2_xfi_train),
 			"XFI2 TRAIN Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi2_hss_pcs_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_hss_pcs_hdr,
 				     XFI2_HSS_PCS_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes2_xfi_hss_pcs),
 			"XFI2 HSS PCS Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi2_hss_tx_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_hss_tx_hdr,
 				     XFI2_HSS_TX_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes2_xfi_hss_tx),
 			"XFI2 HSS TX Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi2_hss_rx_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_hss_rx_hdr,
 				     XFI2_HSS_RX_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes2_xfi_hss_rx),
 			"XFI2 HSS RX Registers");
 
-	ql_build_coredump_seg_header(&mpi_coredump->xfi2_hss_pll_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->xfi2_hss_pll_hdr,
 				     XFI2_HSS_PLL_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->serdes2_xfi_hss_pll),
 			"XFI2 HSS PLL Registers");
 
-	status = ql_get_serdes_regs(qdev, mpi_coredump);
+	status = qlge_get_serdes_regs(qdev, mpi_coredump);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Failed Dump of Serdes Registers. Status = 0x%.08x\n",
@@ -897,7 +897,7 @@ int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi_coredump *mpi_coredump)
 		goto err;
 	}
 
-	ql_build_coredump_seg_header(&mpi_coredump->core_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->core_regs_seg_hdr,
 				     CORE_SEG_NUM,
 				sizeof(mpi_coredump->core_regs_seg_hdr) +
 				sizeof(mpi_coredump->mpi_core_regs) +
@@ -905,175 +905,175 @@ int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi_coredump *mpi_coredump)
 				"Core Registers");
 
 	/* Get the MPI Core Registers */
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->mpi_core_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->mpi_core_regs[0],
 				 MPI_CORE_REGS_ADDR, MPI_CORE_REGS_CNT);
 	if (status)
 		goto err;
 	/* Get the 16 MPI shadow registers */
-	status = ql_get_mpi_shadow_regs(qdev,
+	status = qlge_get_mpi_shadow_regs(qdev,
 					&mpi_coredump->mpi_core_sh_regs[0]);
 	if (status)
 		goto err;
 
 	/* Get the Test Logic Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->test_logic_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->test_logic_regs_seg_hdr,
 				     TEST_LOGIC_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->test_logic_regs),
 				"Test Logic Regs");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->test_logic_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->test_logic_regs[0],
 				 TEST_REGS_ADDR, TEST_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the RMII Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->rmii_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->rmii_regs_seg_hdr,
 				     RMII_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->rmii_regs),
 				"RMII Registers");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->rmii_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->rmii_regs[0],
 				 RMII_REGS_ADDR, RMII_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the FCMAC1 Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->fcmac1_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->fcmac1_regs_seg_hdr,
 				     FCMAC1_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->fcmac1_regs),
 				"FCMAC1 Registers");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->fcmac1_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->fcmac1_regs[0],
 				 FCMAC1_REGS_ADDR, FCMAC_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the FCMAC2 Registers */
 
-	ql_build_coredump_seg_header(&mpi_coredump->fcmac2_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->fcmac2_regs_seg_hdr,
 				     FCMAC2_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->fcmac2_regs),
 				"FCMAC2 Registers");
 
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->fcmac2_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->fcmac2_regs[0],
 				 FCMAC2_REGS_ADDR, FCMAC_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the FC1 MBX Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->fc1_mbx_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->fc1_mbx_regs_seg_hdr,
 				     FC1_MBOX_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->fc1_mbx_regs),
 				"FC1 MBox Regs");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->fc1_mbx_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->fc1_mbx_regs[0],
 				 FC1_MBX_REGS_ADDR, FC_MBX_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the IDE Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->ide_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->ide_regs_seg_hdr,
 				     IDE_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->ide_regs),
 				"IDE Registers");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->ide_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->ide_regs[0],
 				 IDE_REGS_ADDR, IDE_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the NIC1 MBX Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->nic1_mbx_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->nic1_mbx_regs_seg_hdr,
 				     NIC1_MBOX_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->nic1_mbx_regs),
 				"NIC1 MBox Regs");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->nic1_mbx_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->nic1_mbx_regs[0],
 				 NIC1_MBX_REGS_ADDR, NIC_MBX_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the SMBus Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->smbus_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->smbus_regs_seg_hdr,
 				     SMBUS_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->smbus_regs),
 				"SMBus Registers");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->smbus_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->smbus_regs[0],
 				 SMBUS_REGS_ADDR, SMBUS_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the FC2 MBX Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->fc2_mbx_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->fc2_mbx_regs_seg_hdr,
 				     FC2_MBOX_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->fc2_mbx_regs),
 				"FC2 MBox Regs");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->fc2_mbx_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->fc2_mbx_regs[0],
 				 FC2_MBX_REGS_ADDR, FC_MBX_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the NIC2 MBX Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->nic2_mbx_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->nic2_mbx_regs_seg_hdr,
 				     NIC2_MBOX_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->nic2_mbx_regs),
 				"NIC2 MBox Regs");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->nic2_mbx_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->nic2_mbx_regs[0],
 				 NIC2_MBX_REGS_ADDR, NIC_MBX_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the I2C Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->i2c_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->i2c_regs_seg_hdr,
 				     I2C_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->i2c_regs),
 				"I2C Registers");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->i2c_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->i2c_regs[0],
 				 I2C_REGS_ADDR, I2C_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the MEMC Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->memc_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->memc_regs_seg_hdr,
 				     MEMC_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->memc_regs),
 				"MEMC Registers");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->memc_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->memc_regs[0],
 				 MEMC_REGS_ADDR, MEMC_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the PBus Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->pbus_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->pbus_regs_seg_hdr,
 				     PBUS_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->pbus_regs),
 				"PBUS Registers");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->pbus_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->pbus_regs[0],
 				 PBUS_REGS_ADDR, PBUS_REGS_CNT);
 	if (status)
 		goto err;
 
 	/* Get the MDE Registers */
-	ql_build_coredump_seg_header(&mpi_coredump->mde_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->mde_regs_seg_hdr,
 				     MDE_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->mde_regs),
 				"MDE Registers");
-	status = ql_get_mpi_regs(qdev, &mpi_coredump->mde_regs[0],
+	status = qlge_get_mpi_regs(qdev, &mpi_coredump->mde_regs[0],
 				 MDE_REGS_ADDR, MDE_REGS_CNT);
 	if (status)
 		goto err;
 
-	ql_build_coredump_seg_header(&mpi_coredump->misc_nic_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->misc_nic_seg_hdr,
 				     MISC_NIC_INFO_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->misc_nic_info),
 				"MISC NIC INFO");
 	mpi_coredump->misc_nic_info.rx_ring_count = qdev->rx_ring_count;
@@ -1083,79 +1083,79 @@ int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi_coredump *mpi_coredump)
 
 	/* Segment 31 */
 	/* Get indexed register values. */
-	ql_build_coredump_seg_header(&mpi_coredump->intr_states_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->intr_states_seg_hdr,
 				     INTR_STATES_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->intr_states),
 				"INTR States");
-	ql_get_intr_states(qdev, &mpi_coredump->intr_states[0]);
+	qlge_get_intr_states(qdev, &mpi_coredump->intr_states[0]);
 
-	ql_build_coredump_seg_header(&mpi_coredump->cam_entries_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->cam_entries_seg_hdr,
 				     CAM_ENTRIES_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->cam_entries),
 				"CAM Entries");
-	status = ql_get_cam_entries(qdev, &mpi_coredump->cam_entries[0]);
+	status = qlge_get_cam_entries(qdev, &mpi_coredump->cam_entries[0]);
 	if (status)
 		goto err;
 
-	ql_build_coredump_seg_header(&mpi_coredump->nic_routing_words_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->nic_routing_words_seg_hdr,
 				     ROUTING_WORDS_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->nic_routing_words),
 				"Routing Words");
-	status = ql_get_routing_entries(qdev,
+	status = qlge_get_routing_entries(qdev,
 					&mpi_coredump->nic_routing_words[0]);
 	if (status)
 		goto err;
 
 	/* Segment 34 (Rev C. step 23) */
-	ql_build_coredump_seg_header(&mpi_coredump->ets_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->ets_seg_hdr,
 				     ETS_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->ets),
 				"ETS Registers");
-	status = ql_get_ets_regs(qdev, &mpi_coredump->ets[0]);
+	status = qlge_get_ets_regs(qdev, &mpi_coredump->ets[0]);
 	if (status)
 		goto err;
 
-	ql_build_coredump_seg_header(&mpi_coredump->probe_dump_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->probe_dump_seg_hdr,
 				     PROBE_DUMP_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->probe_dump),
 				"Probe Dump");
-	ql_get_probe_dump(qdev, &mpi_coredump->probe_dump[0]);
+	qlge_get_probe_dump(qdev, &mpi_coredump->probe_dump[0]);
 
-	ql_build_coredump_seg_header(&mpi_coredump->routing_reg_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->routing_reg_seg_hdr,
 				     ROUTING_INDEX_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->routing_regs),
 				"Routing Regs");
-	status = ql_get_routing_index_registers(qdev,
+	status = qlge_get_routing_index_registers(qdev,
 						&mpi_coredump->routing_regs[0]);
 	if (status)
 		goto err;
 
-	ql_build_coredump_seg_header(&mpi_coredump->mac_prot_reg_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->mac_prot_reg_seg_hdr,
 				     MAC_PROTOCOL_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->mac_prot_regs),
 				"MAC Prot Regs");
-	ql_get_mac_protocol_registers(qdev, &mpi_coredump->mac_prot_regs[0]);
+	qlge_get_mac_protocol_registers(qdev, &mpi_coredump->mac_prot_regs[0]);
 
 	/* Get the semaphore registers for all 5 functions */
-	ql_build_coredump_seg_header(&mpi_coredump->sem_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->sem_regs_seg_hdr,
 				     SEM_REGS_SEG_NUM,
-			sizeof(struct mpi_coredump_segment_header) +
+			sizeof(struct qlge_mpi_coredump_segment_header) +
 			sizeof(mpi_coredump->sem_regs),	"Sem Registers");
 
-	ql_get_sem_registers(qdev, &mpi_coredump->sem_regs[0]);
+	qlge_get_sem_registers(qdev, &mpi_coredump->sem_regs[0]);
 
 	/* Prevent the mpi restarting while we dump the memory.*/
-	ql_write_mpi_reg(qdev, MPI_TEST_FUNC_RST_STS, MPI_TEST_FUNC_RST_FRC);
+	qlge_write_mpi_reg(qdev, MPI_TEST_FUNC_RST_STS, MPI_TEST_FUNC_RST_FRC);
 
 	/* clear the pause */
-	status = ql_unpause_mpi_risc(qdev);
+	status = qlge_unpause_mpi_risc(qdev);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Failed RISC unpause. Status = 0x%.08x\n", status);
@@ -1163,19 +1163,19 @@ int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi_coredump *mpi_coredump)
 	}
 
 	/* Reset the RISC so we can dump RAM */
-	status = ql_hard_reset_mpi_risc(qdev);
+	status = qlge_hard_reset_mpi_risc(qdev);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Failed RISC reset. Status = 0x%.08x\n", status);
 		goto err;
 	}
 
-	ql_build_coredump_seg_header(&mpi_coredump->code_ram_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->code_ram_seg_hdr,
 				     WCS_RAM_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->code_ram),
 				"WCS RAM");
-	status = ql_dump_risc_ram_area(qdev, &mpi_coredump->code_ram[0],
+	status = qlge_dump_risc_ram_area(qdev, &mpi_coredump->code_ram[0],
 				       CODE_RAM_ADDR, CODE_RAM_CNT);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
@@ -1185,12 +1185,12 @@ int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi_coredump *mpi_coredump)
 	}
 
 	/* Insert the segment header */
-	ql_build_coredump_seg_header(&mpi_coredump->memc_ram_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->memc_ram_seg_hdr,
 				     MEMC_RAM_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->memc_ram),
 				"MEMC RAM");
-	status = ql_dump_risc_ram_area(qdev, &mpi_coredump->memc_ram[0],
+	status = qlge_dump_risc_ram_area(qdev, &mpi_coredump->memc_ram[0],
 				       MEMC_RAM_ADDR, MEMC_RAM_CNT);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
@@ -1199,13 +1199,13 @@ int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi_coredump *mpi_coredump)
 		goto err;
 	}
 err:
-	ql_sem_unlock(qdev, SEM_PROC_REG_MASK); /* does flush too */
+	qlge_sem_unlock(qdev, SEM_PROC_REG_MASK); /* does flush too */
 	return status;
 }
 
-static void ql_get_core_dump(struct ql_adapter *qdev)
+static void qlge_get_core_dump(struct qlge_adapter *qdev)
 {
-	if (!ql_own_firmware(qdev)) {
+	if (!qlge_own_firmware(qdev)) {
 		netif_err(qdev, drv, qdev->ndev, "Don't own firmware!\n");
 		return;
 	}
@@ -1215,28 +1215,28 @@ static void ql_get_core_dump(struct ql_adapter *qdev)
 			  "Force Coredump can only be done from interface that is up\n");
 		return;
 	}
-	ql_queue_fw_error(qdev);
+	qlge_queue_fw_error(qdev);
 }
 
-static void ql_gen_reg_dump(struct ql_adapter *qdev,
-			    struct ql_reg_dump *mpi_coredump)
+static void qlge_gen_reg_dump(struct qlge_adapter *qdev,
+			    struct qlge_reg_dump *mpi_coredump)
 {
 	int i, status;
 
 	memset(&(mpi_coredump->mpi_global_header), 0,
-	       sizeof(struct mpi_coredump_global_header));
+	       sizeof(struct qlge_mpi_coredump_global_header));
 	mpi_coredump->mpi_global_header.cookie = MPI_COREDUMP_COOKIE;
 	mpi_coredump->mpi_global_header.header_size =
-		sizeof(struct mpi_coredump_global_header);
+		sizeof(struct qlge_mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.image_size =
-		sizeof(struct ql_reg_dump);
+		sizeof(struct qlge_reg_dump);
 	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.id_string));
 
 	/* segment 16 */
-	ql_build_coredump_seg_header(&mpi_coredump->misc_nic_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->misc_nic_seg_hdr,
 				     MISC_NIC_INFO_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->misc_nic_info),
 				"MISC NIC INFO");
 	mpi_coredump->misc_nic_info.rx_ring_count = qdev->rx_ring_count;
@@ -1245,55 +1245,55 @@ static void ql_gen_reg_dump(struct ql_adapter *qdev,
 	mpi_coredump->misc_nic_info.function = qdev->func;
 
 	/* Segment 16, Rev C. Step 18 */
-	ql_build_coredump_seg_header(&mpi_coredump->nic_regs_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->nic_regs_seg_hdr,
 				     NIC1_CONTROL_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->nic_regs),
 				"NIC Registers");
 	/* Get generic reg dump */
 	for (i = 0; i < 64; i++)
-		mpi_coredump->nic_regs[i] = ql_read32(qdev, i * sizeof(u32));
+		mpi_coredump->nic_regs[i] = qlge_read32(qdev, i * sizeof(u32));
 
 	/* Segment 31 */
 	/* Get indexed register values. */
-	ql_build_coredump_seg_header(&mpi_coredump->intr_states_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->intr_states_seg_hdr,
 				     INTR_STATES_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->intr_states),
 				"INTR States");
-	ql_get_intr_states(qdev, &mpi_coredump->intr_states[0]);
+	qlge_get_intr_states(qdev, &mpi_coredump->intr_states[0]);
 
-	ql_build_coredump_seg_header(&mpi_coredump->cam_entries_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->cam_entries_seg_hdr,
 				     CAM_ENTRIES_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->cam_entries),
 				"CAM Entries");
-	status = ql_get_cam_entries(qdev, &mpi_coredump->cam_entries[0]);
+	status = qlge_get_cam_entries(qdev, &mpi_coredump->cam_entries[0]);
 	if (status)
 		return;
 
-	ql_build_coredump_seg_header(&mpi_coredump->nic_routing_words_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->nic_routing_words_seg_hdr,
 				     ROUTING_WORDS_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->nic_routing_words),
 				"Routing Words");
-	status = ql_get_routing_entries(qdev,
+	status = qlge_get_routing_entries(qdev,
 					&mpi_coredump->nic_routing_words[0]);
 	if (status)
 		return;
 
 	/* Segment 34 (Rev C. step 23) */
-	ql_build_coredump_seg_header(&mpi_coredump->ets_seg_hdr,
+	qlge_build_coredump_seg_header(&mpi_coredump->ets_seg_hdr,
 				     ETS_SEG_NUM,
-				sizeof(struct mpi_coredump_segment_header)
+				sizeof(struct qlge_mpi_coredump_segment_header)
 				+ sizeof(mpi_coredump->ets),
 				"ETS Registers");
-	status = ql_get_ets_regs(qdev, &mpi_coredump->ets[0]);
+	status = qlge_get_ets_regs(qdev, &mpi_coredump->ets[0]);
 	if (status)
 		return;
 }
 
-void ql_get_dump(struct ql_adapter *qdev, void *buff)
+void qlge_get_dump(struct qlge_adapter *qdev, void *buff)
 {
 	/*
 	 * If the dump has already been taken and is stored
@@ -1304,37 +1304,37 @@ void ql_get_dump(struct ql_adapter *qdev, void *buff)
 	 * to the user's buffer if force is not set.
 	 */
 
-	if (!test_bit(QL_FRC_COREDUMP, &qdev->flags)) {
-		if (!ql_core_dump(qdev, buff))
-			ql_soft_reset_mpi_risc(qdev);
+	if (!test_bit(QLGE_FRC_COREDUMP, &qdev->flags)) {
+		if (!qlge_core_dump(qdev, buff))
+			qlge_soft_reset_mpi_risc(qdev);
 		else
 			netif_err(qdev, drv, qdev->ndev, "coredump failed!\n");
 	} else {
-		ql_gen_reg_dump(qdev, buff);
-		ql_get_core_dump(qdev);
+		qlge_gen_reg_dump(qdev, buff);
+		qlge_get_core_dump(qdev);
 	}
 }
 
 /* Coredump to messages log file using separate worker thread */
-void ql_mpi_core_to_log(struct work_struct *work)
+void qlge_mpi_core_to_log(struct work_struct *work)
 {
-	struct ql_adapter *qdev =
-		container_of(work, struct ql_adapter, mpi_core_to_log.work);
+	struct qlge_adapter *qdev =
+		container_of(work, struct qlge_adapter, mpi_core_to_log.work);
 
 	print_hex_dump(KERN_DEBUG, "Core is dumping to log file!\n",
 		       DUMP_PREFIX_OFFSET, 32, 4, qdev->mpi_coredump,
 		       sizeof(*qdev->mpi_coredump), false);
 }
 
-#ifdef QL_REG_DUMP
-static void ql_dump_intr_states(struct ql_adapter *qdev)
+#ifdef QLGE_REG_DUMP
+static void qlge_dump_intr_states(struct qlge_adapter *qdev)
 {
 	int i;
 	u32 value;
 
 	for (i = 0; i < qdev->intr_count; i++) {
-		ql_write32(qdev, INTR_EN, qdev->intr_context[i].intr_read_mask);
-		value = ql_read32(qdev, INTR_EN);
+		qlge_write32(qdev, INTR_EN, qdev->intr_context[i].intr_read_mask);
+		value = qlge_read32(qdev, INTR_EN);
 		pr_err("%s: Interrupt %d is %s\n",
 		       qdev->ndev->name, i,
 		       (value & INTR_EN_EN ? "enabled" : "disabled"));
@@ -1344,13 +1344,13 @@ static void ql_dump_intr_states(struct ql_adapter *qdev)
 #define DUMP_XGMAC(qdev, reg)					\
 do {								\
 	u32 data;						\
-	ql_read_xgmac_reg(qdev, reg, &data);			\
+	qlge_read_xgmac_reg(qdev, reg, &data);			\
 	pr_err("%s: %s = 0x%.08x\n", qdev->ndev->name, #reg, data); \
 } while (0)
 
-void ql_dump_xgmac_control_regs(struct ql_adapter *qdev)
+void qlge_dump_xgmac_control_regs(struct qlge_adapter *qdev)
 {
-	if (ql_sem_spinlock(qdev, qdev->xg_sem_mask)) {
+	if (qlge_sem_spinlock(qdev, qdev->xg_sem_mask)) {
 		pr_err("%s: Couldn't get xgmac sem\n", __func__);
 		return;
 	}
@@ -1371,23 +1371,23 @@ void ql_dump_xgmac_control_regs(struct ql_adapter *qdev)
 	DUMP_XGMAC(qdev, MAC_MGMT_INT);
 	DUMP_XGMAC(qdev, MAC_MGMT_IN_MASK);
 	DUMP_XGMAC(qdev, EXT_ARB_MODE);
-	ql_sem_unlock(qdev, qdev->xg_sem_mask);
+	qlge_sem_unlock(qdev, qdev->xg_sem_mask);
 }
 
-static void ql_dump_ets_regs(struct ql_adapter *qdev)
+static void qlge_dump_ets_regs(struct qlge_adapter *qdev)
 {
 }
 
-static void ql_dump_cam_entries(struct ql_adapter *qdev)
+static void qlge_dump_cam_entries(struct qlge_adapter *qdev)
 {
 	int i;
 	u32 value[3];
 
-	i = ql_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	i = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
 	if (i)
 		return;
 	for (i = 0; i < 4; i++) {
-		if (ql_get_mac_addr_reg(qdev, MAC_ADDR_TYPE_CAM_MAC, i, value)) {
+		if (qlge_get_mac_addr_reg(qdev, MAC_ADDR_TYPE_CAM_MAC, i, value)) {
 			pr_err("%s: Failed read of mac index register\n",
 			       __func__);
 			return;
@@ -1399,7 +1399,7 @@ static void ql_dump_cam_entries(struct ql_adapter *qdev)
 		}
 	}
 	for (i = 0; i < 32; i++) {
-		if (ql_get_mac_addr_reg
+		if (qlge_get_mac_addr_reg
 		    (qdev, MAC_ADDR_TYPE_MULTI_MAC, i, value)) {
 			pr_err("%s: Failed read of mac index register\n",
 			       __func__);
@@ -1410,20 +1410,20 @@ static void ql_dump_cam_entries(struct ql_adapter *qdev)
 				       qdev->ndev->name, i, value[1], value[0]);
 		}
 	}
-	ql_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
 }
 
-void ql_dump_routing_entries(struct ql_adapter *qdev)
+void qlge_dump_routing_entries(struct qlge_adapter *qdev)
 {
 	int i;
 	u32 value;
 
-	i = ql_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	i = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
 	if (i)
 		return;
 	for (i = 0; i < 16; i++) {
 		value = 0;
-		if (ql_get_routing_reg(qdev, i, &value)) {
+		if (qlge_get_routing_reg(qdev, i, &value)) {
 			pr_err("%s: Failed read of routing index register\n",
 			       __func__);
 			return;
@@ -1433,13 +1433,13 @@ void ql_dump_routing_entries(struct ql_adapter *qdev)
 				       qdev->ndev->name, i, value);
 		}
 	}
-	ql_sem_unlock(qdev, SEM_RT_IDX_MASK);
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
 }
 
 #define DUMP_REG(qdev, reg)			\
-	pr_err("%-32s= 0x%x\n", #reg, ql_read32(qdev, reg))
+	pr_err("%-32s= 0x%x\n", #reg, qlge_read32(qdev, reg))
 
-void ql_dump_regs(struct ql_adapter *qdev)
+void qlge_dump_regs(struct qlge_adapter *qdev)
 {
 	pr_err("reg dump for function #%d\n", qdev->func);
 	DUMP_REG(qdev, SYS);
@@ -1495,20 +1495,20 @@ void ql_dump_regs(struct ql_adapter *qdev)
 	DUMP_REG(qdev, XG_SERDES_DATA);
 	DUMP_REG(qdev, PRB_MX_ADDR);
 	DUMP_REG(qdev, PRB_MX_DATA);
-	ql_dump_intr_states(qdev);
-	ql_dump_xgmac_control_regs(qdev);
-	ql_dump_ets_regs(qdev);
-	ql_dump_cam_entries(qdev);
-	ql_dump_routing_entries(qdev);
+	qlge_dump_intr_states(qdev);
+	qlge_dump_xgmac_control_regs(qdev);
+	qlge_dump_ets_regs(qdev);
+	qlge_dump_cam_entries(qdev);
+	qlge_dump_routing_entries(qdev);
 }
 #endif
 
-#ifdef QL_STAT_DUMP
+#ifdef QLGE_STAT_DUMP
 
 #define DUMP_STAT(qdev, stat)	\
 	pr_err("%s = %ld\n", #stat, (unsigned long)(qdev)->nic_stats.stat)
 
-void ql_dump_stat(struct ql_adapter *qdev)
+void qlge_dump_stat(struct qlge_adapter *qdev)
 {
 	pr_err("%s: Enter\n", __func__);
 	DUMP_STAT(qdev, tx_pkts);
@@ -1556,7 +1556,7 @@ void ql_dump_stat(struct ql_adapter *qdev)
 };
 #endif
 
-#ifdef QL_DEV_DUMP
+#ifdef QLGE_DEV_DUMP
 
 #define DUMP_QDEV_FIELD(qdev, type, field)		\
 	pr_err("qdev->%-24s = " type "\n", #field, (qdev)->(field))
@@ -1565,7 +1565,7 @@ void ql_dump_stat(struct ql_adapter *qdev)
 #define DUMP_QDEV_ARRAY(qdev, type, array, index, field) \
 	pr_err("%s[%d].%s = " type "\n",		 \
 	       #array, index, #field, (qdev)->array[index].field);
-void ql_dump_qdev(struct ql_adapter *qdev)
+void qlge_dump_qdev(struct qlge_adapter *qdev)
 {
 	int i;
 
@@ -1612,8 +1612,8 @@ void ql_dump_qdev(struct ql_adapter *qdev)
 }
 #endif
 
-#ifdef QL_CB_DUMP
-void ql_dump_wqicb(struct wqicb *wqicb)
+#ifdef QLGE_CB_DUMP
+void qlge_dump_wqicb(struct wqicb *wqicb)
 {
 	pr_err("Dumping wqicb stuff...\n");
 	pr_err("wqicb->len = 0x%x\n", le16_to_cpu(wqicb->len));
@@ -1627,7 +1627,7 @@ void ql_dump_wqicb(struct wqicb *wqicb)
 	       (unsigned long long)le64_to_cpu(wqicb->cnsmr_idx_addr));
 }
 
-void ql_dump_tx_ring(struct tx_ring *tx_ring)
+void qlge_dump_tx_ring(struct qlge_tx_ring *tx_ring)
 {
 	if (!tx_ring)
 		return;
@@ -1639,7 +1639,7 @@ void ql_dump_tx_ring(struct tx_ring *tx_ring)
 	pr_err("tx_ring->cnsmr_idx_sh_reg, addr = 0x%p, value = %d\n",
 	       tx_ring->cnsmr_idx_sh_reg,
 	       tx_ring->cnsmr_idx_sh_reg
-			? ql_read_sh_reg(tx_ring->cnsmr_idx_sh_reg) : 0);
+			? qlge_read_sh_reg(tx_ring->cnsmr_idx_sh_reg) : 0);
 	pr_err("tx_ring->size = %d\n", tx_ring->wq_size);
 	pr_err("tx_ring->len = %d\n", tx_ring->wq_len);
 	pr_err("tx_ring->prod_idx_db_reg = %p\n", tx_ring->prod_idx_db_reg);
@@ -1651,7 +1651,7 @@ void ql_dump_tx_ring(struct tx_ring *tx_ring)
 	pr_err("tx_ring->tx_count = %d\n", atomic_read(&tx_ring->tx_count));
 }
 
-void ql_dump_ricb(struct ricb *ricb)
+void qlge_dump_ricb(struct qlge_ricb *ricb)
 {
 	int i;
 
@@ -1681,7 +1681,7 @@ void ql_dump_ricb(struct ricb *ricb)
 		       le32_to_cpu(ricb->ipv4_hash_key[i]));
 }
 
-void ql_dump_cqicb(struct cqicb *cqicb)
+void qlge_dump_cqicb(struct qlge_cqicb *cqicb)
 {
 	pr_err("Dumping cqicb stuff...\n");
 
@@ -1710,9 +1710,9 @@ void ql_dump_cqicb(struct cqicb *cqicb)
 	       le16_to_cpu(cqicb->sbq_len));
 }
 
-static const char *qlge_rx_ring_type_name(struct rx_ring *rx_ring)
+static const char *qlge_rx_ring_type_name(struct qlge_rx_ring *rx_ring)
 {
-	struct ql_adapter *qdev = rx_ring->qdev;
+	struct qlge_adapter *qdev = rx_ring->qdev;
 
 	if (rx_ring->cq_id < qdev->rss_ring_count)
 		return "RX COMPLETION";
@@ -1720,7 +1720,7 @@ static const char *qlge_rx_ring_type_name(struct rx_ring *rx_ring)
 		return "TX COMPLETION";
 };
 
-void ql_dump_rx_ring(struct rx_ring *rx_ring)
+void qlge_dump_rx_ring(struct qlge_rx_ring *rx_ring)
 {
 	if (!rx_ring)
 		return;
@@ -1737,7 +1737,7 @@ void ql_dump_rx_ring(struct rx_ring *rx_ring)
 	pr_err("rx_ring->prod_idx_sh_reg, addr = 0x%p, value = %d\n",
 	       rx_ring->prod_idx_sh_reg,
 	       rx_ring->prod_idx_sh_reg
-			? ql_read_sh_reg(rx_ring->prod_idx_sh_reg) : 0);
+			? qlge_read_sh_reg(rx_ring->prod_idx_sh_reg) : 0);
 	pr_err("rx_ring->prod_idx_sh_reg_dma = %llx\n",
 	       (unsigned long long)rx_ring->prod_idx_sh_reg_dma);
 	pr_err("rx_ring->cnsmr_idx_db_reg = %p\n",
@@ -1779,7 +1779,7 @@ void ql_dump_rx_ring(struct rx_ring *rx_ring)
 	pr_err("rx_ring->qdev = %p\n", rx_ring->qdev);
 }
 
-void ql_dump_hw_cb(struct ql_adapter *qdev, int size, u32 bit, u16 q_id)
+void qlge_dump_hw_cb(struct qlge_adapter *qdev, int size, u32 bit, u16 q_id)
 {
 	void *ptr;
 
@@ -1789,19 +1789,19 @@ void ql_dump_hw_cb(struct ql_adapter *qdev, int size, u32 bit, u16 q_id)
 	if (!ptr)
 		return;
 
-	if (ql_write_cfg(qdev, ptr, size, bit, q_id)) {
+	if (qlge_write_cfg(qdev, ptr, size, bit, q_id)) {
 		pr_err("%s: Failed to upload control block!\n", __func__);
 		goto fail_it;
 	}
 	switch (bit) {
 	case CFG_DRQ:
-		ql_dump_wqicb((struct wqicb *)ptr);
+		qlge_dump_wqicb((struct wqicb *)ptr);
 		break;
 	case CFG_DCQ:
-		ql_dump_cqicb((struct cqicb *)ptr);
+		qlge_dump_cqicb((struct qlge_cqicb *)ptr);
 		break;
 	case CFG_DR:
-		ql_dump_ricb((struct ricb *)ptr);
+		qlge_dump_ricb((struct qlge_ricb *)ptr);
 		break;
 	default:
 		pr_err("%s: Invalid bit value = %x\n", __func__, bit);
@@ -1812,8 +1812,8 @@ void ql_dump_hw_cb(struct ql_adapter *qdev, int size, u32 bit, u16 q_id)
 }
 #endif
 
-#ifdef QL_OB_DUMP
-void ql_dump_tx_desc(struct tx_buf_desc *tbd)
+#ifdef QLGE_OB_DUMP
+void qlge_dump_tx_desc(struct tx_buf_desc *tbd)
 {
 	pr_err("tbd->addr  = 0x%llx\n",
 	       le64_to_cpu((u64) tbd->addr));
@@ -1840,10 +1840,10 @@ void ql_dump_tx_desc(struct tx_buf_desc *tbd)
 	       tbd->len & TX_DESC_E ? "E" : ".");
 }
 
-void ql_dump_ob_mac_iocb(struct ob_mac_iocb_req *ob_mac_iocb)
+void qlge_dump_ob_mac_iocb(struct qlge_ob_mac_iocb_req *ob_mac_iocb)
 {
-	struct ob_mac_tso_iocb_req *ob_mac_tso_iocb =
-	    (struct ob_mac_tso_iocb_req *)ob_mac_iocb;
+	struct qlge_ob_mac_tso_iocb_req *ob_mac_tso_iocb =
+	    (struct qlge_ob_mac_tso_iocb_req *)ob_mac_iocb;
 	struct tx_buf_desc *tbd;
 	u16 frame_len;
 
@@ -1883,10 +1883,10 @@ void ql_dump_ob_mac_iocb(struct ob_mac_iocb_req *ob_mac_iocb)
 		frame_len = le16_to_cpu(ob_mac_iocb->frame_len);
 	}
 	tbd = &ob_mac_iocb->tbd[0];
-	ql_dump_tx_desc(tbd);
+	qlge_dump_tx_desc(tbd);
 }
 
-void ql_dump_ob_mac_rsp(struct ob_mac_iocb_rsp *ob_mac_rsp)
+void qlge_dump_ob_mac_rsp(struct qlge_ob_mac_iocb_rsp *ob_mac_rsp)
 {
 	pr_err("%s\n", __func__);
 	pr_err("opcode         = %d\n", ob_mac_rsp->opcode);
@@ -1902,8 +1902,8 @@ void ql_dump_ob_mac_rsp(struct ob_mac_iocb_rsp *ob_mac_rsp)
 }
 #endif
 
-#ifdef QL_IB_DUMP
-void ql_dump_ib_mac_rsp(struct ib_mac_iocb_rsp *ib_mac_rsp)
+#ifdef QLGE_IB_DUMP
+void qlge_dump_ib_mac_rsp(struct qlge_ib_mac_iocb_rsp *ib_mac_rsp)
 {
 	pr_err("%s\n", __func__);
 	pr_err("opcode         = 0x%x\n", ib_mac_rsp->opcode);
@@ -1984,20 +1984,20 @@ void ql_dump_ib_mac_rsp(struct ib_mac_iocb_rsp *ib_mac_rsp)
 }
 #endif
 
-#ifdef QL_ALL_DUMP
-void ql_dump_all(struct ql_adapter *qdev)
+#ifdef QLGE_ALL_DUMP
+void qlge_dump_all(struct qlge_adapter *qdev)
 {
 	int i;
 
-	QL_DUMP_REGS(qdev);
-	QL_DUMP_QDEV(qdev);
+	QLGE_DUMP_REGS(qdev);
+	QLGE_DUMP_QDEV(qdev);
 	for (i = 0; i < qdev->tx_ring_count; i++) {
-		QL_DUMP_TX_RING(&qdev->tx_ring[i]);
-		QL_DUMP_WQICB((struct wqicb *)&qdev->tx_ring[i]);
+		QLGE_DUMP_TX_RING(&qdev->tx_ring[i]);
+		QLGE_DUMP_WQICB((struct wqicb *)&qdev->tx_ring[i]);
 	}
 	for (i = 0; i < qdev->rx_ring_count; i++) {
-		QL_DUMP_RX_RING(&qdev->rx_ring[i]);
-		QL_DUMP_CQICB((struct cqicb *)&qdev->rx_ring[i]);
+		QLGE_DUMP_RX_RING(&qdev->rx_ring[i]);
+		QLGE_DUMP_CQICB((struct qlge_cqicb *)&qdev->rx_ring[i]);
 	}
 }
 #endif
diff --git a/drivers/staging/qlge/qlge_ethtool.c b/drivers/staging/qlge/qlge_ethtool.c
index 949abd53a7a9..0b521fdccdb9 100644
--- a/drivers/staging/qlge/qlge_ethtool.c
+++ b/drivers/staging/qlge/qlge_ethtool.c
@@ -34,159 +34,159 @@
 
 #include "qlge.h"
 
-struct ql_stats {
+struct qlge_stats {
 	char stat_string[ETH_GSTRING_LEN];
 	int sizeof_stat;
 	int stat_offset;
 };
 
-#define QL_SIZEOF(m) sizeof_field(struct ql_adapter, m)
-#define QL_OFF(m) offsetof(struct ql_adapter, m)
-
-static const struct ql_stats ql_gstrings_stats[] = {
-	{"tx_pkts", QL_SIZEOF(nic_stats.tx_pkts), QL_OFF(nic_stats.tx_pkts)},
-	{"tx_bytes", QL_SIZEOF(nic_stats.tx_bytes), QL_OFF(nic_stats.tx_bytes)},
-	{"tx_mcast_pkts", QL_SIZEOF(nic_stats.tx_mcast_pkts),
-					QL_OFF(nic_stats.tx_mcast_pkts)},
-	{"tx_bcast_pkts", QL_SIZEOF(nic_stats.tx_bcast_pkts),
-					QL_OFF(nic_stats.tx_bcast_pkts)},
-	{"tx_ucast_pkts", QL_SIZEOF(nic_stats.tx_ucast_pkts),
-					QL_OFF(nic_stats.tx_ucast_pkts)},
-	{"tx_ctl_pkts", QL_SIZEOF(nic_stats.tx_ctl_pkts),
-					QL_OFF(nic_stats.tx_ctl_pkts)},
-	{"tx_pause_pkts", QL_SIZEOF(nic_stats.tx_pause_pkts),
-					QL_OFF(nic_stats.tx_pause_pkts)},
-	{"tx_64_pkts", QL_SIZEOF(nic_stats.tx_64_pkt),
-					QL_OFF(nic_stats.tx_64_pkt)},
-	{"tx_65_to_127_pkts", QL_SIZEOF(nic_stats.tx_65_to_127_pkt),
-					QL_OFF(nic_stats.tx_65_to_127_pkt)},
-	{"tx_128_to_255_pkts", QL_SIZEOF(nic_stats.tx_128_to_255_pkt),
-					QL_OFF(nic_stats.tx_128_to_255_pkt)},
-	{"tx_256_511_pkts", QL_SIZEOF(nic_stats.tx_256_511_pkt),
-					QL_OFF(nic_stats.tx_256_511_pkt)},
-	{"tx_512_to_1023_pkts",	QL_SIZEOF(nic_stats.tx_512_to_1023_pkt),
-					QL_OFF(nic_stats.tx_512_to_1023_pkt)},
-	{"tx_1024_to_1518_pkts", QL_SIZEOF(nic_stats.tx_1024_to_1518_pkt),
-					QL_OFF(nic_stats.tx_1024_to_1518_pkt)},
-	{"tx_1519_to_max_pkts",	QL_SIZEOF(nic_stats.tx_1519_to_max_pkt),
-					QL_OFF(nic_stats.tx_1519_to_max_pkt)},
-	{"tx_undersize_pkts", QL_SIZEOF(nic_stats.tx_undersize_pkt),
-					QL_OFF(nic_stats.tx_undersize_pkt)},
-	{"tx_oversize_pkts", QL_SIZEOF(nic_stats.tx_oversize_pkt),
-					QL_OFF(nic_stats.tx_oversize_pkt)},
-	{"rx_bytes", QL_SIZEOF(nic_stats.rx_bytes), QL_OFF(nic_stats.rx_bytes)},
-	{"rx_bytes_ok",	QL_SIZEOF(nic_stats.rx_bytes_ok),
-					QL_OFF(nic_stats.rx_bytes_ok)},
-	{"rx_pkts", QL_SIZEOF(nic_stats.rx_pkts), QL_OFF(nic_stats.rx_pkts)},
-	{"rx_pkts_ok", QL_SIZEOF(nic_stats.rx_pkts_ok),
-					QL_OFF(nic_stats.rx_pkts_ok)},
-	{"rx_bcast_pkts", QL_SIZEOF(nic_stats.rx_bcast_pkts),
-					QL_OFF(nic_stats.rx_bcast_pkts)},
-	{"rx_mcast_pkts", QL_SIZEOF(nic_stats.rx_mcast_pkts),
-					QL_OFF(nic_stats.rx_mcast_pkts)},
-	{"rx_ucast_pkts", QL_SIZEOF(nic_stats.rx_ucast_pkts),
-					QL_OFF(nic_stats.rx_ucast_pkts)},
-	{"rx_undersize_pkts", QL_SIZEOF(nic_stats.rx_undersize_pkts),
-					QL_OFF(nic_stats.rx_undersize_pkts)},
-	{"rx_oversize_pkts", QL_SIZEOF(nic_stats.rx_oversize_pkts),
-					QL_OFF(nic_stats.rx_oversize_pkts)},
-	{"rx_jabber_pkts", QL_SIZEOF(nic_stats.rx_jabber_pkts),
-					QL_OFF(nic_stats.rx_jabber_pkts)},
+#define QLGE_SIZEOF(m) sizeof_field(struct qlge_adapter, m)
+#define QLGE_OFF(m) offsetof(struct qlge_adapter, m)
+
+static const struct qlge_stats qlge_gstrings_stats[] = {
+	{"tx_pkts", QLGE_SIZEOF(nic_stats.tx_pkts), QLGE_OFF(nic_stats.tx_pkts)},
+	{"tx_bytes", QLGE_SIZEOF(nic_stats.tx_bytes), QLGE_OFF(nic_stats.tx_bytes)},
+	{"tx_mcast_pkts", QLGE_SIZEOF(nic_stats.tx_mcast_pkts),
+					QLGE_OFF(nic_stats.tx_mcast_pkts)},
+	{"tx_bcast_pkts", QLGE_SIZEOF(nic_stats.tx_bcast_pkts),
+					QLGE_OFF(nic_stats.tx_bcast_pkts)},
+	{"tx_ucast_pkts", QLGE_SIZEOF(nic_stats.tx_ucast_pkts),
+					QLGE_OFF(nic_stats.tx_ucast_pkts)},
+	{"tx_ctl_pkts", QLGE_SIZEOF(nic_stats.tx_ctl_pkts),
+					QLGE_OFF(nic_stats.tx_ctl_pkts)},
+	{"tx_pause_pkts", QLGE_SIZEOF(nic_stats.tx_pause_pkts),
+					QLGE_OFF(nic_stats.tx_pause_pkts)},
+	{"tx_64_pkts", QLGE_SIZEOF(nic_stats.tx_64_pkt),
+					QLGE_OFF(nic_stats.tx_64_pkt)},
+	{"tx_65_to_127_pkts", QLGE_SIZEOF(nic_stats.tx_65_to_127_pkt),
+					QLGE_OFF(nic_stats.tx_65_to_127_pkt)},
+	{"tx_128_to_255_pkts", QLGE_SIZEOF(nic_stats.tx_128_to_255_pkt),
+					QLGE_OFF(nic_stats.tx_128_to_255_pkt)},
+	{"tx_256_511_pkts", QLGE_SIZEOF(nic_stats.tx_256_511_pkt),
+					QLGE_OFF(nic_stats.tx_256_511_pkt)},
+	{"tx_512_to_1023_pkts",	QLGE_SIZEOF(nic_stats.tx_512_to_1023_pkt),
+					QLGE_OFF(nic_stats.tx_512_to_1023_pkt)},
+	{"tx_1024_to_1518_pkts", QLGE_SIZEOF(nic_stats.tx_1024_to_1518_pkt),
+					QLGE_OFF(nic_stats.tx_1024_to_1518_pkt)},
+	{"tx_1519_to_max_pkts",	QLGE_SIZEOF(nic_stats.tx_1519_to_max_pkt),
+					QLGE_OFF(nic_stats.tx_1519_to_max_pkt)},
+	{"tx_undersize_pkts", QLGE_SIZEOF(nic_stats.tx_undersize_pkt),
+					QLGE_OFF(nic_stats.tx_undersize_pkt)},
+	{"tx_oversize_pkts", QLGE_SIZEOF(nic_stats.tx_oversize_pkt),
+					QLGE_OFF(nic_stats.tx_oversize_pkt)},
+	{"rx_bytes", QLGE_SIZEOF(nic_stats.rx_bytes), QLGE_OFF(nic_stats.rx_bytes)},
+	{"rx_bytes_ok",	QLGE_SIZEOF(nic_stats.rx_bytes_ok),
+					QLGE_OFF(nic_stats.rx_bytes_ok)},
+	{"rx_pkts", QLGE_SIZEOF(nic_stats.rx_pkts), QLGE_OFF(nic_stats.rx_pkts)},
+	{"rx_pkts_ok", QLGE_SIZEOF(nic_stats.rx_pkts_ok),
+					QLGE_OFF(nic_stats.rx_pkts_ok)},
+	{"rx_bcast_pkts", QLGE_SIZEOF(nic_stats.rx_bcast_pkts),
+					QLGE_OFF(nic_stats.rx_bcast_pkts)},
+	{"rx_mcast_pkts", QLGE_SIZEOF(nic_stats.rx_mcast_pkts),
+					QLGE_OFF(nic_stats.rx_mcast_pkts)},
+	{"rx_ucast_pkts", QLGE_SIZEOF(nic_stats.rx_ucast_pkts),
+					QLGE_OFF(nic_stats.rx_ucast_pkts)},
+	{"rx_undersize_pkts", QLGE_SIZEOF(nic_stats.rx_undersize_pkts),
+					QLGE_OFF(nic_stats.rx_undersize_pkts)},
+	{"rx_oversize_pkts", QLGE_SIZEOF(nic_stats.rx_oversize_pkts),
+					QLGE_OFF(nic_stats.rx_oversize_pkts)},
+	{"rx_jabber_pkts", QLGE_SIZEOF(nic_stats.rx_jabber_pkts),
+					QLGE_OFF(nic_stats.rx_jabber_pkts)},
 	{"rx_undersize_fcerr_pkts",
-		QL_SIZEOF(nic_stats.rx_undersize_fcerr_pkts),
-				QL_OFF(nic_stats.rx_undersize_fcerr_pkts)},
-	{"rx_drop_events", QL_SIZEOF(nic_stats.rx_drop_events),
-					QL_OFF(nic_stats.rx_drop_events)},
-	{"rx_fcerr_pkts", QL_SIZEOF(nic_stats.rx_fcerr_pkts),
-					QL_OFF(nic_stats.rx_fcerr_pkts)},
-	{"rx_align_err", QL_SIZEOF(nic_stats.rx_align_err),
-					QL_OFF(nic_stats.rx_align_err)},
-	{"rx_symbol_err", QL_SIZEOF(nic_stats.rx_symbol_err),
-					QL_OFF(nic_stats.rx_symbol_err)},
-	{"rx_mac_err", QL_SIZEOF(nic_stats.rx_mac_err),
-					QL_OFF(nic_stats.rx_mac_err)},
-	{"rx_ctl_pkts",	QL_SIZEOF(nic_stats.rx_ctl_pkts),
-					QL_OFF(nic_stats.rx_ctl_pkts)},
-	{"rx_pause_pkts", QL_SIZEOF(nic_stats.rx_pause_pkts),
-					QL_OFF(nic_stats.rx_pause_pkts)},
-	{"rx_64_pkts", QL_SIZEOF(nic_stats.rx_64_pkts),
-					QL_OFF(nic_stats.rx_64_pkts)},
-	{"rx_65_to_127_pkts", QL_SIZEOF(nic_stats.rx_65_to_127_pkts),
-					QL_OFF(nic_stats.rx_65_to_127_pkts)},
-	{"rx_128_255_pkts", QL_SIZEOF(nic_stats.rx_128_255_pkts),
-					QL_OFF(nic_stats.rx_128_255_pkts)},
-	{"rx_256_511_pkts", QL_SIZEOF(nic_stats.rx_256_511_pkts),
-					QL_OFF(nic_stats.rx_256_511_pkts)},
-	{"rx_512_to_1023_pkts",	QL_SIZEOF(nic_stats.rx_512_to_1023_pkts),
-					QL_OFF(nic_stats.rx_512_to_1023_pkts)},
-	{"rx_1024_to_1518_pkts", QL_SIZEOF(nic_stats.rx_1024_to_1518_pkts),
-					QL_OFF(nic_stats.rx_1024_to_1518_pkts)},
-	{"rx_1519_to_max_pkts",	QL_SIZEOF(nic_stats.rx_1519_to_max_pkts),
-					QL_OFF(nic_stats.rx_1519_to_max_pkts)},
-	{"rx_len_err_pkts", QL_SIZEOF(nic_stats.rx_len_err_pkts),
-					QL_OFF(nic_stats.rx_len_err_pkts)},
-	{"rx_code_err",	QL_SIZEOF(nic_stats.rx_code_err),
-					QL_OFF(nic_stats.rx_code_err)},
-	{"rx_oversize_err", QL_SIZEOF(nic_stats.rx_oversize_err),
-					QL_OFF(nic_stats.rx_oversize_err)},
-	{"rx_undersize_err", QL_SIZEOF(nic_stats.rx_undersize_err),
-					QL_OFF(nic_stats.rx_undersize_err)},
-	{"rx_preamble_err", QL_SIZEOF(nic_stats.rx_preamble_err),
-					QL_OFF(nic_stats.rx_preamble_err)},
-	{"rx_frame_len_err", QL_SIZEOF(nic_stats.rx_frame_len_err),
-					QL_OFF(nic_stats.rx_frame_len_err)},
-	{"rx_crc_err", QL_SIZEOF(nic_stats.rx_crc_err),
-					QL_OFF(nic_stats.rx_crc_err)},
-	{"rx_err_count", QL_SIZEOF(nic_stats.rx_err_count),
-					QL_OFF(nic_stats.rx_err_count)},
-	{"tx_cbfc_pause_frames0", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames0),
-				QL_OFF(nic_stats.tx_cbfc_pause_frames0)},
-	{"tx_cbfc_pause_frames1", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames1),
-				QL_OFF(nic_stats.tx_cbfc_pause_frames1)},
-	{"tx_cbfc_pause_frames2", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames2),
-				QL_OFF(nic_stats.tx_cbfc_pause_frames2)},
-	{"tx_cbfc_pause_frames3", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames3),
-				QL_OFF(nic_stats.tx_cbfc_pause_frames3)},
-	{"tx_cbfc_pause_frames4", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames4),
-				QL_OFF(nic_stats.tx_cbfc_pause_frames4)},
-	{"tx_cbfc_pause_frames5", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames5),
-				QL_OFF(nic_stats.tx_cbfc_pause_frames5)},
-	{"tx_cbfc_pause_frames6", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames6),
-				QL_OFF(nic_stats.tx_cbfc_pause_frames6)},
-	{"tx_cbfc_pause_frames7", QL_SIZEOF(nic_stats.tx_cbfc_pause_frames7),
-				QL_OFF(nic_stats.tx_cbfc_pause_frames7)},
-	{"rx_cbfc_pause_frames0", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames0),
-				QL_OFF(nic_stats.rx_cbfc_pause_frames0)},
-	{"rx_cbfc_pause_frames1", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames1),
-				QL_OFF(nic_stats.rx_cbfc_pause_frames1)},
-	{"rx_cbfc_pause_frames2", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames2),
-				QL_OFF(nic_stats.rx_cbfc_pause_frames2)},
-	{"rx_cbfc_pause_frames3", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames3),
-				QL_OFF(nic_stats.rx_cbfc_pause_frames3)},
-	{"rx_cbfc_pause_frames4", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames4),
-				QL_OFF(nic_stats.rx_cbfc_pause_frames4)},
-	{"rx_cbfc_pause_frames5", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames5),
-				QL_OFF(nic_stats.rx_cbfc_pause_frames5)},
-	{"rx_cbfc_pause_frames6", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames6),
-				QL_OFF(nic_stats.rx_cbfc_pause_frames6)},
-	{"rx_cbfc_pause_frames7", QL_SIZEOF(nic_stats.rx_cbfc_pause_frames7),
-				QL_OFF(nic_stats.rx_cbfc_pause_frames7)},
-	{"rx_nic_fifo_drop", QL_SIZEOF(nic_stats.rx_nic_fifo_drop),
-					QL_OFF(nic_stats.rx_nic_fifo_drop)},
+		QLGE_SIZEOF(nic_stats.rx_undersize_fcerr_pkts),
+				QLGE_OFF(nic_stats.rx_undersize_fcerr_pkts)},
+	{"rx_drop_events", QLGE_SIZEOF(nic_stats.rx_drop_events),
+					QLGE_OFF(nic_stats.rx_drop_events)},
+	{"rx_fcerr_pkts", QLGE_SIZEOF(nic_stats.rx_fcerr_pkts),
+					QLGE_OFF(nic_stats.rx_fcerr_pkts)},
+	{"rx_align_err", QLGE_SIZEOF(nic_stats.rx_align_err),
+					QLGE_OFF(nic_stats.rx_align_err)},
+	{"rx_symbol_err", QLGE_SIZEOF(nic_stats.rx_symbol_err),
+					QLGE_OFF(nic_stats.rx_symbol_err)},
+	{"rx_mac_err", QLGE_SIZEOF(nic_stats.rx_mac_err),
+					QLGE_OFF(nic_stats.rx_mac_err)},
+	{"rx_ctl_pkts",	QLGE_SIZEOF(nic_stats.rx_ctl_pkts),
+					QLGE_OFF(nic_stats.rx_ctl_pkts)},
+	{"rx_pause_pkts", QLGE_SIZEOF(nic_stats.rx_pause_pkts),
+					QLGE_OFF(nic_stats.rx_pause_pkts)},
+	{"rx_64_pkts", QLGE_SIZEOF(nic_stats.rx_64_pkts),
+					QLGE_OFF(nic_stats.rx_64_pkts)},
+	{"rx_65_to_127_pkts", QLGE_SIZEOF(nic_stats.rx_65_to_127_pkts),
+					QLGE_OFF(nic_stats.rx_65_to_127_pkts)},
+	{"rx_128_255_pkts", QLGE_SIZEOF(nic_stats.rx_128_255_pkts),
+					QLGE_OFF(nic_stats.rx_128_255_pkts)},
+	{"rx_256_511_pkts", QLGE_SIZEOF(nic_stats.rx_256_511_pkts),
+					QLGE_OFF(nic_stats.rx_256_511_pkts)},
+	{"rx_512_to_1023_pkts",	QLGE_SIZEOF(nic_stats.rx_512_to_1023_pkts),
+					QLGE_OFF(nic_stats.rx_512_to_1023_pkts)},
+	{"rx_1024_to_1518_pkts", QLGE_SIZEOF(nic_stats.rx_1024_to_1518_pkts),
+					QLGE_OFF(nic_stats.rx_1024_to_1518_pkts)},
+	{"rx_1519_to_max_pkts",	QLGE_SIZEOF(nic_stats.rx_1519_to_max_pkts),
+					QLGE_OFF(nic_stats.rx_1519_to_max_pkts)},
+	{"rx_len_err_pkts", QLGE_SIZEOF(nic_stats.rx_len_err_pkts),
+					QLGE_OFF(nic_stats.rx_len_err_pkts)},
+	{"rx_code_err",	QLGE_SIZEOF(nic_stats.rx_code_err),
+					QLGE_OFF(nic_stats.rx_code_err)},
+	{"rx_oversize_err", QLGE_SIZEOF(nic_stats.rx_oversize_err),
+					QLGE_OFF(nic_stats.rx_oversize_err)},
+	{"rx_undersize_err", QLGE_SIZEOF(nic_stats.rx_undersize_err),
+					QLGE_OFF(nic_stats.rx_undersize_err)},
+	{"rx_preamble_err", QLGE_SIZEOF(nic_stats.rx_preamble_err),
+					QLGE_OFF(nic_stats.rx_preamble_err)},
+	{"rx_frame_len_err", QLGE_SIZEOF(nic_stats.rx_frame_len_err),
+					QLGE_OFF(nic_stats.rx_frame_len_err)},
+	{"rx_crc_err", QLGE_SIZEOF(nic_stats.rx_crc_err),
+					QLGE_OFF(nic_stats.rx_crc_err)},
+	{"rx_err_count", QLGE_SIZEOF(nic_stats.rx_err_count),
+					QLGE_OFF(nic_stats.rx_err_count)},
+	{"tx_cbfc_pause_frames0", QLGE_SIZEOF(nic_stats.tx_cbfc_pause_frames0),
+				QLGE_OFF(nic_stats.tx_cbfc_pause_frames0)},
+	{"tx_cbfc_pause_frames1", QLGE_SIZEOF(nic_stats.tx_cbfc_pause_frames1),
+				QLGE_OFF(nic_stats.tx_cbfc_pause_frames1)},
+	{"tx_cbfc_pause_frames2", QLGE_SIZEOF(nic_stats.tx_cbfc_pause_frames2),
+				QLGE_OFF(nic_stats.tx_cbfc_pause_frames2)},
+	{"tx_cbfc_pause_frames3", QLGE_SIZEOF(nic_stats.tx_cbfc_pause_frames3),
+				QLGE_OFF(nic_stats.tx_cbfc_pause_frames3)},
+	{"tx_cbfc_pause_frames4", QLGE_SIZEOF(nic_stats.tx_cbfc_pause_frames4),
+				QLGE_OFF(nic_stats.tx_cbfc_pause_frames4)},
+	{"tx_cbfc_pause_frames5", QLGE_SIZEOF(nic_stats.tx_cbfc_pause_frames5),
+				QLGE_OFF(nic_stats.tx_cbfc_pause_frames5)},
+	{"tx_cbfc_pause_frames6", QLGE_SIZEOF(nic_stats.tx_cbfc_pause_frames6),
+				QLGE_OFF(nic_stats.tx_cbfc_pause_frames6)},
+	{"tx_cbfc_pause_frames7", QLGE_SIZEOF(nic_stats.tx_cbfc_pause_frames7),
+				QLGE_OFF(nic_stats.tx_cbfc_pause_frames7)},
+	{"rx_cbfc_pause_frames0", QLGE_SIZEOF(nic_stats.rx_cbfc_pause_frames0),
+				QLGE_OFF(nic_stats.rx_cbfc_pause_frames0)},
+	{"rx_cbfc_pause_frames1", QLGE_SIZEOF(nic_stats.rx_cbfc_pause_frames1),
+				QLGE_OFF(nic_stats.rx_cbfc_pause_frames1)},
+	{"rx_cbfc_pause_frames2", QLGE_SIZEOF(nic_stats.rx_cbfc_pause_frames2),
+				QLGE_OFF(nic_stats.rx_cbfc_pause_frames2)},
+	{"rx_cbfc_pause_frames3", QLGE_SIZEOF(nic_stats.rx_cbfc_pause_frames3),
+				QLGE_OFF(nic_stats.rx_cbfc_pause_frames3)},
+	{"rx_cbfc_pause_frames4", QLGE_SIZEOF(nic_stats.rx_cbfc_pause_frames4),
+				QLGE_OFF(nic_stats.rx_cbfc_pause_frames4)},
+	{"rx_cbfc_pause_frames5", QLGE_SIZEOF(nic_stats.rx_cbfc_pause_frames5),
+				QLGE_OFF(nic_stats.rx_cbfc_pause_frames5)},
+	{"rx_cbfc_pause_frames6", QLGE_SIZEOF(nic_stats.rx_cbfc_pause_frames6),
+				QLGE_OFF(nic_stats.rx_cbfc_pause_frames6)},
+	{"rx_cbfc_pause_frames7", QLGE_SIZEOF(nic_stats.rx_cbfc_pause_frames7),
+				QLGE_OFF(nic_stats.rx_cbfc_pause_frames7)},
+	{"rx_nic_fifo_drop", QLGE_SIZEOF(nic_stats.rx_nic_fifo_drop),
+					QLGE_OFF(nic_stats.rx_nic_fifo_drop)},
 };
 
-static const char ql_gstrings_test[][ETH_GSTRING_LEN] = {
+static const char qlge_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Loopback test  (offline)"
 };
-#define QLGE_TEST_LEN (sizeof(ql_gstrings_test) / ETH_GSTRING_LEN)
-#define QLGE_STATS_LEN ARRAY_SIZE(ql_gstrings_stats)
+#define QLGE_TEST_LEN (sizeof(qlge_gstrings_test) / ETH_GSTRING_LEN)
+#define QLGE_STATS_LEN ARRAY_SIZE(qlge_gstrings_stats)
 #define QLGE_RCV_MAC_ERR_STATS	7
 
-static int ql_update_ring_coalescing(struct ql_adapter *qdev)
+static int qlge_update_ring_coalescing(struct qlge_adapter *qdev)
 {
 	int i, status = 0;
-	struct rx_ring *rx_ring;
-	struct cqicb *cqicb;
+	struct qlge_rx_ring *rx_ring;
+	struct qlge_cqicb *cqicb;
 
 	if (!netif_running(qdev->ndev))
 		return status;
@@ -194,17 +194,17 @@ static int ql_update_ring_coalescing(struct ql_adapter *qdev)
 	/* Skip the default queue, and update the outbound handler
 	 * queues if they changed.
 	 */
-	cqicb = (struct cqicb *)&qdev->rx_ring[qdev->rss_ring_count];
+	cqicb = (struct qlge_cqicb *)&qdev->rx_ring[qdev->rss_ring_count];
 	if (le16_to_cpu(cqicb->irq_delay) != qdev->tx_coalesce_usecs ||
 	    le16_to_cpu(cqicb->pkt_delay) != qdev->tx_max_coalesced_frames) {
 		for (i = qdev->rss_ring_count; i < qdev->rx_ring_count; i++) {
 			rx_ring = &qdev->rx_ring[i];
-			cqicb = (struct cqicb *)rx_ring;
+			cqicb = (struct qlge_cqicb *)rx_ring;
 			cqicb->irq_delay = cpu_to_le16(qdev->tx_coalesce_usecs);
 			cqicb->pkt_delay =
 			    cpu_to_le16(qdev->tx_max_coalesced_frames);
 			cqicb->flags = FLAGS_LI;
-			status = ql_write_cfg(qdev, cqicb, sizeof(*cqicb),
+			status = qlge_write_cfg(qdev, cqicb, sizeof(*cqicb),
 					      CFG_LCQ, rx_ring->cq_id);
 			if (status) {
 				netif_err(qdev, ifup, qdev->ndev,
@@ -215,17 +215,17 @@ static int ql_update_ring_coalescing(struct ql_adapter *qdev)
 	}
 
 	/* Update the inbound (RSS) handler queues if they changed. */
-	cqicb = (struct cqicb *)&qdev->rx_ring[0];
+	cqicb = (struct qlge_cqicb *)&qdev->rx_ring[0];
 	if (le16_to_cpu(cqicb->irq_delay) != qdev->rx_coalesce_usecs ||
 	    le16_to_cpu(cqicb->pkt_delay) != qdev->rx_max_coalesced_frames) {
 		for (i = 0; i < qdev->rss_ring_count; i++, rx_ring++) {
 			rx_ring = &qdev->rx_ring[i];
-			cqicb = (struct cqicb *)rx_ring;
+			cqicb = (struct qlge_cqicb *)rx_ring;
 			cqicb->irq_delay = cpu_to_le16(qdev->rx_coalesce_usecs);
 			cqicb->pkt_delay =
 			    cpu_to_le16(qdev->rx_max_coalesced_frames);
 			cqicb->flags = FLAGS_LI;
-			status = ql_write_cfg(qdev, cqicb, sizeof(*cqicb),
+			status = qlge_write_cfg(qdev, cqicb, sizeof(*cqicb),
 					      CFG_LCQ, rx_ring->cq_id);
 			if (status) {
 				netif_err(qdev, ifup, qdev->ndev,
@@ -238,14 +238,14 @@ static int ql_update_ring_coalescing(struct ql_adapter *qdev)
 	return status;
 }
 
-static void ql_update_stats(struct ql_adapter *qdev)
+static void qlge_update_stats(struct qlge_adapter *qdev)
 {
 	u32 i;
 	u64 data;
 	u64 *iter = &qdev->nic_stats.tx_pkts;
 
 	spin_lock(&qdev->stats_lock);
-	if (ql_sem_spinlock(qdev, qdev->xg_sem_mask)) {
+	if (qlge_sem_spinlock(qdev, qdev->xg_sem_mask)) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Couldn't get xgmac sem.\n");
 		goto quit;
@@ -254,7 +254,7 @@ static void ql_update_stats(struct ql_adapter *qdev)
 	 * Get TX statistics.
 	 */
 	for (i = 0x200; i < 0x280; i += 8) {
-		if (ql_read_xgmac_reg64(qdev, i, &data)) {
+		if (qlge_read_xgmac_reg64(qdev, i, &data)) {
 			netif_err(qdev, drv, qdev->ndev,
 				  "Error reading status register 0x%.04x.\n",
 				  i);
@@ -269,7 +269,7 @@ static void ql_update_stats(struct ql_adapter *qdev)
 	 * Get RX statistics.
 	 */
 	for (i = 0x300; i < 0x3d0; i += 8) {
-		if (ql_read_xgmac_reg64(qdev, i, &data)) {
+		if (qlge_read_xgmac_reg64(qdev, i, &data)) {
 			netif_err(qdev, drv, qdev->ndev,
 				  "Error reading status register 0x%.04x.\n",
 				  i);
@@ -287,7 +287,7 @@ static void ql_update_stats(struct ql_adapter *qdev)
 	 * Get Per-priority TX pause frame counter statistics.
 	 */
 	for (i = 0x500; i < 0x540; i += 8) {
-		if (ql_read_xgmac_reg64(qdev, i, &data)) {
+		if (qlge_read_xgmac_reg64(qdev, i, &data)) {
 			netif_err(qdev, drv, qdev->ndev,
 				  "Error reading status register 0x%.04x.\n",
 				  i);
@@ -302,7 +302,7 @@ static void ql_update_stats(struct ql_adapter *qdev)
 	 * Get Per-priority RX pause frame counter statistics.
 	 */
 	for (i = 0x568; i < 0x5a8; i += 8) {
-		if (ql_read_xgmac_reg64(qdev, i, &data)) {
+		if (qlge_read_xgmac_reg64(qdev, i, &data)) {
 			netif_err(qdev, drv, qdev->ndev,
 				  "Error reading status register 0x%.04x.\n",
 				  i);
@@ -316,7 +316,7 @@ static void ql_update_stats(struct ql_adapter *qdev)
 	/*
 	 * Get RX NIC FIFO DROP statistics.
 	 */
-	if (ql_read_xgmac_reg64(qdev, 0x5b8, &data)) {
+	if (qlge_read_xgmac_reg64(qdev, 0x5b8, &data)) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Error reading status register 0x%.04x.\n", i);
 		goto end;
@@ -324,32 +324,32 @@ static void ql_update_stats(struct ql_adapter *qdev)
 		*iter = data;
 	}
 end:
-	ql_sem_unlock(qdev, qdev->xg_sem_mask);
+	qlge_sem_unlock(qdev, qdev->xg_sem_mask);
 quit:
 	spin_unlock(&qdev->stats_lock);
 
-	QL_DUMP_STAT(qdev);
+	QLGE_DUMP_STAT(qdev);
 }
 
-static void ql_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
+static void qlge_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 {
 	int index;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(buf, *ql_gstrings_test, QLGE_TEST_LEN * ETH_GSTRING_LEN);
+		memcpy(buf, *qlge_gstrings_test, QLGE_TEST_LEN * ETH_GSTRING_LEN);
 		break;
 	case ETH_SS_STATS:
 		for (index = 0; index < QLGE_STATS_LEN; index++) {
 			memcpy(buf + index * ETH_GSTRING_LEN,
-			       ql_gstrings_stats[index].stat_string,
+			       qlge_gstrings_stats[index].stat_string,
 			       ETH_GSTRING_LEN);
 		}
 		break;
 	}
 }
 
-static int ql_get_sset_count(struct net_device *dev, int sset)
+static int qlge_get_sset_count(struct net_device *dev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_TEST:
@@ -362,27 +362,27 @@ static int ql_get_sset_count(struct net_device *dev, int sset)
 }
 
 static void
-ql_get_ethtool_stats(struct net_device *ndev,
+qlge_get_ethtool_stats(struct net_device *ndev,
 		     struct ethtool_stats *stats, u64 *data)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int index, length;
 
 	length = QLGE_STATS_LEN;
-	ql_update_stats(qdev);
+	qlge_update_stats(qdev);
 
 	for (index = 0; index < length; index++) {
 		char *p = (char *)qdev +
-			ql_gstrings_stats[index].stat_offset;
-		*data++ = (ql_gstrings_stats[index].sizeof_stat ==
+			qlge_gstrings_stats[index].stat_offset;
+		*data++ = (qlge_gstrings_stats[index].sizeof_stat ==
 			sizeof(u64)) ? *(u64 *)p : (*(u32 *)p);
 	}
 }
 
-static int ql_get_link_ksettings(struct net_device *ndev,
+static int qlge_get_link_ksettings(struct net_device *ndev,
 				 struct ethtool_link_ksettings *ecmd)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	u32 supported, advertising;
 
 	supported = SUPPORTED_10000baseT_Full;
@@ -411,10 +411,10 @@ static int ql_get_link_ksettings(struct net_device *ndev,
 	return 0;
 }
 
-static void ql_get_drvinfo(struct net_device *ndev,
+static void qlge_get_drvinfo(struct net_device *ndev,
 			   struct ethtool_drvinfo *drvinfo)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	strlcpy(drvinfo->driver, qlge_driver_name, sizeof(drvinfo->driver));
 	strlcpy(drvinfo->version, qlge_driver_version,
@@ -428,9 +428,9 @@ static void ql_get_drvinfo(struct net_device *ndev,
 		sizeof(drvinfo->bus_info));
 }
 
-static void ql_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
+static void qlge_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	unsigned short ssys_dev = qdev->pdev->subsystem_device;
 
 	/* WOL is only supported for mezz card. */
@@ -441,9 +441,9 @@ static void ql_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
 	}
 }
 
-static int ql_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
+static int qlge_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	unsigned short ssys_dev = qdev->pdev->subsystem_device;
 
 	/* WOL is only supported for mezz card. */
@@ -461,25 +461,25 @@ static int ql_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
 	return 0;
 }
 
-static int ql_set_phys_id(struct net_device *ndev,
+static int qlge_set_phys_id(struct net_device *ndev,
 			  enum ethtool_phys_id_state state)
 
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	switch (state) {
 	case ETHTOOL_ID_ACTIVE:
 		/* Save the current LED settings */
-		if (ql_mb_get_led_cfg(qdev))
+		if (qlge_mb_get_led_cfg(qdev))
 			return -EIO;
 
 		/* Start blinking */
-		ql_mb_set_led_cfg(qdev, QL_LED_BLINK);
+		qlge_mb_set_led_cfg(qdev, QLGE_LED_BLINK);
 		return 0;
 
 	case ETHTOOL_ID_INACTIVE:
 		/* Restore LED settings */
-		if (ql_mb_set_led_cfg(qdev, qdev->led_config))
+		if (qlge_mb_set_led_cfg(qdev, qdev->led_config))
 			return -EIO;
 		return 0;
 
@@ -488,29 +488,29 @@ static int ql_set_phys_id(struct net_device *ndev,
 	}
 }
 
-static int ql_start_loopback(struct ql_adapter *qdev)
+static int qlge_start_loopback(struct qlge_adapter *qdev)
 {
 	if (netif_carrier_ok(qdev->ndev)) {
-		set_bit(QL_LB_LINK_UP, &qdev->flags);
+		set_bit(QLGE_LB_LINK_UP, &qdev->flags);
 		netif_carrier_off(qdev->ndev);
 	} else {
-		clear_bit(QL_LB_LINK_UP, &qdev->flags);
+		clear_bit(QLGE_LB_LINK_UP, &qdev->flags);
 	}
 	qdev->link_config |= CFG_LOOPBACK_PCS;
-	return ql_mb_set_port_cfg(qdev);
+	return qlge_mb_set_port_cfg(qdev);
 }
 
-static void ql_stop_loopback(struct ql_adapter *qdev)
+static void qlge_stop_loopback(struct qlge_adapter *qdev)
 {
 	qdev->link_config &= ~CFG_LOOPBACK_PCS;
-	ql_mb_set_port_cfg(qdev);
-	if (test_bit(QL_LB_LINK_UP, &qdev->flags)) {
+	qlge_mb_set_port_cfg(qdev);
+	if (test_bit(QLGE_LB_LINK_UP, &qdev->flags)) {
 		netif_carrier_on(qdev->ndev);
-		clear_bit(QL_LB_LINK_UP, &qdev->flags);
+		clear_bit(QLGE_LB_LINK_UP, &qdev->flags);
 	}
 }
 
-static void ql_create_lb_frame(struct sk_buff *skb,
+static void qlge_create_lb_frame(struct sk_buff *skb,
 			       unsigned int frame_size)
 {
 	memset(skb->data, 0xFF, frame_size);
@@ -520,7 +520,7 @@ static void ql_create_lb_frame(struct sk_buff *skb,
 	memset(&skb->data[frame_size / 2 + 12], 0xAF, 1);
 }
 
-void ql_check_lb_frame(struct ql_adapter *qdev,
+void qlge_check_lb_frame(struct qlge_adapter *qdev,
 		       struct sk_buff *skb)
 {
 	unsigned int frame_size = skb->len;
@@ -533,7 +533,7 @@ void ql_check_lb_frame(struct ql_adapter *qdev,
 	}
 }
 
-static int ql_run_loopback_test(struct ql_adapter *qdev)
+static int qlge_run_loopback_test(struct qlge_adapter *qdev)
 {
 	int i;
 	netdev_tx_t rc;
@@ -547,48 +547,48 @@ static int ql_run_loopback_test(struct ql_adapter *qdev)
 
 		skb->queue_mapping = 0;
 		skb_put(skb, size);
-		ql_create_lb_frame(skb, size);
-		rc = ql_lb_send(skb, qdev->ndev);
+		qlge_create_lb_frame(skb, size);
+		rc = qlge_lb_send(skb, qdev->ndev);
 		if (rc != NETDEV_TX_OK)
 			return -EPIPE;
 		atomic_inc(&qdev->lb_count);
 	}
 	/* Give queue time to settle before testing results. */
 	msleep(2);
-	ql_clean_lb_rx_ring(&qdev->rx_ring[0], 128);
+	qlge_clean_lb_rx_ring(&qdev->rx_ring[0], 128);
 	return atomic_read(&qdev->lb_count) ? -EIO : 0;
 }
 
-static int ql_loopback_test(struct ql_adapter *qdev, u64 *data)
+static int qlge_loopback_test(struct qlge_adapter *qdev, u64 *data)
 {
-	*data = ql_start_loopback(qdev);
+	*data = qlge_start_loopback(qdev);
 	if (*data)
 		goto out;
-	*data = ql_run_loopback_test(qdev);
+	*data = qlge_run_loopback_test(qdev);
 out:
-	ql_stop_loopback(qdev);
+	qlge_stop_loopback(qdev);
 	return *data;
 }
 
-static void ql_self_test(struct net_device *ndev,
+static void qlge_self_test(struct net_device *ndev,
 			 struct ethtool_test *eth_test, u64 *data)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	memset(data, 0, sizeof(u64) * QLGE_TEST_LEN);
 
 	if (netif_running(ndev)) {
-		set_bit(QL_SELFTEST, &qdev->flags);
+		set_bit(QLGE_SELFTEST, &qdev->flags);
 		if (eth_test->flags == ETH_TEST_FL_OFFLINE) {
 			/* Offline tests */
-			if (ql_loopback_test(qdev, &data[0]))
+			if (qlge_loopback_test(qdev, &data[0]))
 				eth_test->flags |= ETH_TEST_FL_FAILED;
 
 		} else {
 			/* Online tests */
 			data[0] = 0;
 		}
-		clear_bit(QL_SELFTEST, &qdev->flags);
+		clear_bit(QLGE_SELFTEST, &qdev->flags);
 		/* Give link time to come up after
 		 * port configuration changes.
 		 */
@@ -600,32 +600,32 @@ static void ql_self_test(struct net_device *ndev,
 	}
 }
 
-static int ql_get_regs_len(struct net_device *ndev)
+static int qlge_get_regs_len(struct net_device *ndev)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
-	if (!test_bit(QL_FRC_COREDUMP, &qdev->flags))
-		return sizeof(struct ql_mpi_coredump);
+	if (!test_bit(QLGE_FRC_COREDUMP, &qdev->flags))
+		return sizeof(struct qlge_mpi_coredump);
 	else
-		return sizeof(struct ql_reg_dump);
+		return sizeof(struct qlge_reg_dump);
 }
 
-static void ql_get_regs(struct net_device *ndev,
+static void qlge_get_regs(struct net_device *ndev,
 			struct ethtool_regs *regs, void *p)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
-	ql_get_dump(qdev, p);
+	qlge_get_dump(qdev, p);
 	qdev->core_is_dumped = 0;
-	if (!test_bit(QL_FRC_COREDUMP, &qdev->flags))
-		regs->len = sizeof(struct ql_mpi_coredump);
+	if (!test_bit(QLGE_FRC_COREDUMP, &qdev->flags))
+		regs->len = sizeof(struct qlge_mpi_coredump);
 	else
-		regs->len = sizeof(struct ql_reg_dump);
+		regs->len = sizeof(struct qlge_reg_dump);
 }
 
-static int ql_get_coalesce(struct net_device *dev, struct ethtool_coalesce *c)
+static int qlge_get_coalesce(struct net_device *dev, struct ethtool_coalesce *c)
 {
-	struct ql_adapter *qdev = netdev_priv(dev);
+	struct qlge_adapter *qdev = netdev_priv(dev);
 
 	c->rx_coalesce_usecs = qdev->rx_coalesce_usecs;
 	c->tx_coalesce_usecs = qdev->tx_coalesce_usecs;
@@ -646,9 +646,9 @@ static int ql_get_coalesce(struct net_device *dev, struct ethtool_coalesce *c)
 	return 0;
 }
 
-static int ql_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *c)
+static int qlge_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *c)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	/* Validate user parameters. */
 	if (c->rx_coalesce_usecs > qdev->rx_ring_size / 2)
@@ -673,25 +673,25 @@ static int ql_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *c)
 	qdev->rx_max_coalesced_frames = c->rx_max_coalesced_frames;
 	qdev->tx_max_coalesced_frames = c->tx_max_coalesced_frames;
 
-	return ql_update_ring_coalescing(qdev);
+	return qlge_update_ring_coalescing(qdev);
 }
 
-static void ql_get_pauseparam(struct net_device *netdev,
+static void qlge_get_pauseparam(struct net_device *netdev,
 			      struct ethtool_pauseparam *pause)
 {
-	struct ql_adapter *qdev = netdev_priv(netdev);
+	struct qlge_adapter *qdev = netdev_priv(netdev);
 
-	ql_mb_get_port_cfg(qdev);
+	qlge_mb_get_port_cfg(qdev);
 	if (qdev->link_config & CFG_PAUSE_STD) {
 		pause->rx_pause = 1;
 		pause->tx_pause = 1;
 	}
 }
 
-static int ql_set_pauseparam(struct net_device *netdev,
+static int qlge_set_pauseparam(struct net_device *netdev,
 			     struct ethtool_pauseparam *pause)
 {
-	struct ql_adapter *qdev = netdev_priv(netdev);
+	struct qlge_adapter *qdev = netdev_priv(netdev);
 
 	if ((pause->rx_pause) && (pause->tx_pause))
 		qdev->link_config |= CFG_PAUSE_STD;
@@ -700,19 +700,19 @@ static int ql_set_pauseparam(struct net_device *netdev,
 	else
 		return -EINVAL;
 
-	return ql_mb_set_port_cfg(qdev);
+	return qlge_mb_set_port_cfg(qdev);
 }
 
-static u32 ql_get_msglevel(struct net_device *ndev)
+static u32 qlge_get_msglevel(struct net_device *ndev)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	return qdev->msg_enable;
 }
 
-static void ql_set_msglevel(struct net_device *ndev, u32 value)
+static void qlge_set_msglevel(struct net_device *ndev, u32 value)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	qdev->msg_enable = value;
 }
@@ -720,23 +720,23 @@ static void ql_set_msglevel(struct net_device *ndev, u32 value)
 const struct ethtool_ops qlge_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
-	.get_drvinfo = ql_get_drvinfo,
-	.get_wol = ql_get_wol,
-	.set_wol = ql_set_wol,
-	.get_regs_len	= ql_get_regs_len,
-	.get_regs = ql_get_regs,
-	.get_msglevel = ql_get_msglevel,
-	.set_msglevel = ql_set_msglevel,
+	.get_drvinfo = qlge_get_drvinfo,
+	.get_wol = qlge_get_wol,
+	.set_wol = qlge_set_wol,
+	.get_regs_len	= qlge_get_regs_len,
+	.get_regs = qlge_get_regs,
+	.get_msglevel = qlge_get_msglevel,
+	.set_msglevel = qlge_set_msglevel,
 	.get_link = ethtool_op_get_link,
-	.set_phys_id		 = ql_set_phys_id,
-	.self_test		 = ql_self_test,
-	.get_pauseparam		 = ql_get_pauseparam,
-	.set_pauseparam		 = ql_set_pauseparam,
-	.get_coalesce = ql_get_coalesce,
-	.set_coalesce = ql_set_coalesce,
-	.get_sset_count = ql_get_sset_count,
-	.get_strings = ql_get_strings,
-	.get_ethtool_stats = ql_get_ethtool_stats,
-	.get_link_ksettings = ql_get_link_ksettings,
+	.set_phys_id		 = qlge_set_phys_id,
+	.self_test		 = qlge_self_test,
+	.get_pauseparam		 = qlge_get_pauseparam,
+	.set_pauseparam		 = qlge_set_pauseparam,
+	.get_coalesce = qlge_get_coalesce,
+	.set_coalesce = qlge_set_coalesce,
+	.get_sset_count = qlge_get_sset_count,
+	.get_strings = qlge_get_strings,
+	.get_ethtool_stats = qlge_get_ethtool_stats,
+	.get_link_ksettings = qlge_get_link_ksettings,
 };
 
diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index 3351dd5155bc..252ff36e8880 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -89,16 +89,16 @@ static const struct pci_device_id qlge_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, qlge_pci_tbl);
 
-static int ql_wol(struct ql_adapter *);
+static int qlge_wol(struct qlge_adapter *);
 static void qlge_set_multicast_list(struct net_device *);
-static int ql_adapter_down(struct ql_adapter *);
-static int ql_adapter_up(struct ql_adapter *);
+static int qlge_adapter_down(struct qlge_adapter *);
+static int qlge_adapter_up(struct qlge_adapter *);
 
 /* This hardware semaphore causes exclusive access to
  * resources shared between the NIC driver, MPI firmware,
  * FCOE firmware and the FC driver.
  */
-static int ql_sem_trylock(struct ql_adapter *qdev, u32 sem_mask)
+static int qlge_sem_trylock(struct qlge_adapter *qdev, u32 sem_mask)
 {
 	u32 sem_bits = 0;
 
@@ -132,26 +132,26 @@ static int ql_sem_trylock(struct ql_adapter *qdev, u32 sem_mask)
 		return -EINVAL;
 	}
 
-	ql_write32(qdev, SEM, sem_bits | sem_mask);
-	return !(ql_read32(qdev, SEM) & sem_bits);
+	qlge_write32(qdev, SEM, sem_bits | sem_mask);
+	return !(qlge_read32(qdev, SEM) & sem_bits);
 }
 
-int ql_sem_spinlock(struct ql_adapter *qdev, u32 sem_mask)
+int qlge_sem_spinlock(struct qlge_adapter *qdev, u32 sem_mask)
 {
 	unsigned int wait_count = 30;
 
 	do {
-		if (!ql_sem_trylock(qdev, sem_mask))
+		if (!qlge_sem_trylock(qdev, sem_mask))
 			return 0;
 		udelay(100);
 	} while (--wait_count);
 	return -ETIMEDOUT;
 }
 
-void ql_sem_unlock(struct ql_adapter *qdev, u32 sem_mask)
+void qlge_sem_unlock(struct qlge_adapter *qdev, u32 sem_mask)
 {
-	ql_write32(qdev, SEM, sem_mask);
-	ql_read32(qdev, SEM);	/* flush */
+	qlge_write32(qdev, SEM, sem_mask);
+	qlge_read32(qdev, SEM);	/* flush */
 }
 
 /* This function waits for a specific bit to come ready
@@ -159,13 +159,13 @@ void ql_sem_unlock(struct ql_adapter *qdev, u32 sem_mask)
  * process, but is also used in kernel thread API such as
  * netdev->set_multi, netdev->set_mac_address, netdev->vlan_rx_add_vid.
  */
-int ql_wait_reg_rdy(struct ql_adapter *qdev, u32 reg, u32 bit, u32 err_bit)
+int qlge_wait_reg_rdy(struct qlge_adapter *qdev, u32 reg, u32 bit, u32 err_bit)
 {
 	u32 temp;
 	int count;
 
 	for (count = 0; count < UDELAY_COUNT; count++) {
-		temp = ql_read32(qdev, reg);
+		temp = qlge_read32(qdev, reg);
 
 		/* check for errors */
 		if (temp & err_bit) {
@@ -186,13 +186,13 @@ int ql_wait_reg_rdy(struct ql_adapter *qdev, u32 reg, u32 bit, u32 err_bit)
 /* The CFG register is used to download TX and RX control blocks
  * to the chip. This function waits for an operation to complete.
  */
-static int ql_wait_cfg(struct ql_adapter *qdev, u32 bit)
+static int qlge_wait_cfg(struct qlge_adapter *qdev, u32 bit)
 {
 	int count;
 	u32 temp;
 
 	for (count = 0; count < UDELAY_COUNT; count++) {
-		temp = ql_read32(qdev, CFG);
+		temp = qlge_read32(qdev, CFG);
 		if (temp & CFG_LE)
 			return -EIO;
 		if (!(temp & bit))
@@ -205,7 +205,7 @@ static int ql_wait_cfg(struct ql_adapter *qdev, u32 bit)
 /* Used to issue init control blocks to hw. Maps control block,
  * sets address, triggers download, waits for completion.
  */
-int ql_write_cfg(struct ql_adapter *qdev, void *ptr, int size, u32 bit,
+int qlge_write_cfg(struct qlge_adapter *qdev, void *ptr, int size, u32 bit,
 		 u16 q_id)
 {
 	u64 map;
@@ -225,36 +225,36 @@ int ql_write_cfg(struct ql_adapter *qdev, void *ptr, int size, u32 bit,
 		return -ENOMEM;
 	}
 
-	status = ql_sem_spinlock(qdev, SEM_ICB_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_ICB_MASK);
 	if (status)
 		return status;
 
-	status = ql_wait_cfg(qdev, bit);
+	status = qlge_wait_cfg(qdev, bit);
 	if (status) {
 		netif_err(qdev, ifup, qdev->ndev,
 			  "Timed out waiting for CFG to come ready.\n");
 		goto exit;
 	}
 
-	ql_write32(qdev, ICB_L, (u32) map);
-	ql_write32(qdev, ICB_H, (u32) (map >> 32));
+	qlge_write32(qdev, ICB_L, (u32) map);
+	qlge_write32(qdev, ICB_H, (u32) (map >> 32));
 
 	mask = CFG_Q_MASK | (bit << 16);
 	value = bit | (q_id << CFG_Q_SHIFT);
-	ql_write32(qdev, CFG, (mask | value));
+	qlge_write32(qdev, CFG, (mask | value));
 
 	/*
 	 * Wait for the bit to clear after signaling hw.
 	 */
-	status = ql_wait_cfg(qdev, bit);
+	status = qlge_wait_cfg(qdev, bit);
 exit:
-	ql_sem_unlock(qdev, SEM_ICB_MASK);	/* does flush too */
+	qlge_sem_unlock(qdev, SEM_ICB_MASK);	/* does flush too */
 	dma_unmap_single(&qdev->pdev->dev, map, size, direction);
 	return status;
 }
 
 /* Get a specific MAC address from the CAM.  Used for debug and reg dump. */
-int ql_get_mac_addr_reg(struct ql_adapter *qdev, u32 type, u16 index,
+int qlge_get_mac_addr_reg(struct qlge_adapter *qdev, u32 type, u16 index,
 			u32 *value)
 {
 	u32 offset = 0;
@@ -265,46 +265,46 @@ int ql_get_mac_addr_reg(struct ql_adapter *qdev, u32 type, u16 index,
 	case MAC_ADDR_TYPE_CAM_MAC:
 		{
 			status =
-			    ql_wait_reg_rdy(qdev,
+			    qlge_wait_reg_rdy(qdev,
 					    MAC_ADDR_IDX, MAC_ADDR_MW, 0);
 			if (status)
 				goto exit;
-			ql_write32(qdev, MAC_ADDR_IDX, (offset++) | /* offset */
+			qlge_write32(qdev, MAC_ADDR_IDX, (offset++) | /* offset */
 				   (index << MAC_ADDR_IDX_SHIFT) | /* index */
 				   MAC_ADDR_ADR | MAC_ADDR_RS | type); /* type */
 			status =
-			    ql_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MR, 0);
+			    qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MR, 0);
 			if (status)
 				goto exit;
-			*value++ = ql_read32(qdev, MAC_ADDR_DATA);
+			*value++ = qlge_read32(qdev, MAC_ADDR_DATA);
 			status =
-			    ql_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+			    qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
 			if (status)
 				goto exit;
-			ql_write32(qdev, MAC_ADDR_IDX, (offset++) | /* offset */
+			qlge_write32(qdev, MAC_ADDR_IDX, (offset++) | /* offset */
 				   (index << MAC_ADDR_IDX_SHIFT) | /* index */
 				   MAC_ADDR_ADR | MAC_ADDR_RS | type); /* type */
 			status =
-			    ql_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MR, 0);
+			    qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MR, 0);
 			if (status)
 				goto exit;
-			*value++ = ql_read32(qdev, MAC_ADDR_DATA);
+			*value++ = qlge_read32(qdev, MAC_ADDR_DATA);
 			if (type == MAC_ADDR_TYPE_CAM_MAC) {
 				status =
-				    ql_wait_reg_rdy(qdev,
+				    qlge_wait_reg_rdy(qdev,
 						    MAC_ADDR_IDX, MAC_ADDR_MW,
 						    0);
 				if (status)
 					goto exit;
-				ql_write32(qdev, MAC_ADDR_IDX, (offset++) | /* offset */
+				qlge_write32(qdev, MAC_ADDR_IDX, (offset++) | /* offset */
 					   (index << MAC_ADDR_IDX_SHIFT) | /* index */
 					   MAC_ADDR_ADR | MAC_ADDR_RS | type); /* type */
 				status =
-				    ql_wait_reg_rdy(qdev, MAC_ADDR_IDX,
+				    qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX,
 						    MAC_ADDR_MR, 0);
 				if (status)
 					goto exit;
-				*value++ = ql_read32(qdev, MAC_ADDR_DATA);
+				*value++ = qlge_read32(qdev, MAC_ADDR_DATA);
 			}
 			break;
 		}
@@ -322,7 +322,7 @@ int ql_get_mac_addr_reg(struct ql_adapter *qdev, u32 type, u16 index,
 /* Set up a MAC, multicast or VLAN address for the
  * inbound frame matching.
  */
-static int ql_set_mac_addr_reg(struct ql_adapter *qdev, u8 *addr, u32 type,
+static int qlge_set_mac_addr_reg(struct qlge_adapter *qdev, u8 *addr, u32 type,
 			       u16 index)
 {
 	u32 offset = 0;
@@ -336,26 +336,26 @@ static int ql_set_mac_addr_reg(struct ql_adapter *qdev, u8 *addr, u32 type,
 					(addr[4] << 8) | (addr[5]);
 
 			status =
-				ql_wait_reg_rdy(qdev,
+				qlge_wait_reg_rdy(qdev,
 						MAC_ADDR_IDX, MAC_ADDR_MW, 0);
 			if (status)
 				goto exit;
-			ql_write32(qdev, MAC_ADDR_IDX, (offset++) |
+			qlge_write32(qdev, MAC_ADDR_IDX, (offset++) |
 				(index << MAC_ADDR_IDX_SHIFT) |
 				type | MAC_ADDR_E);
-			ql_write32(qdev, MAC_ADDR_DATA, lower);
+			qlge_write32(qdev, MAC_ADDR_DATA, lower);
 			status =
-				ql_wait_reg_rdy(qdev,
+				qlge_wait_reg_rdy(qdev,
 						MAC_ADDR_IDX, MAC_ADDR_MW, 0);
 			if (status)
 				goto exit;
-			ql_write32(qdev, MAC_ADDR_IDX, (offset++) |
+			qlge_write32(qdev, MAC_ADDR_IDX, (offset++) |
 				(index << MAC_ADDR_IDX_SHIFT) |
 				type | MAC_ADDR_E);
 
-			ql_write32(qdev, MAC_ADDR_DATA, upper);
+			qlge_write32(qdev, MAC_ADDR_DATA, upper);
 			status =
-				ql_wait_reg_rdy(qdev,
+				qlge_wait_reg_rdy(qdev,
 						MAC_ADDR_IDX, MAC_ADDR_MW, 0);
 			if (status)
 				goto exit;
@@ -369,26 +369,26 @@ static int ql_set_mac_addr_reg(struct ql_adapter *qdev, u8 *addr, u32 type,
 			    (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) |
 			    (addr[5]);
 			status =
-			    ql_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+			    qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
 			if (status)
 				goto exit;
-			ql_write32(qdev, MAC_ADDR_IDX, (offset++) | /* offset */
+			qlge_write32(qdev, MAC_ADDR_IDX, (offset++) | /* offset */
 				   (index << MAC_ADDR_IDX_SHIFT) | /* index */
 				   type);	/* type */
-			ql_write32(qdev, MAC_ADDR_DATA, lower);
+			qlge_write32(qdev, MAC_ADDR_DATA, lower);
 			status =
-			    ql_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+			    qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
 			if (status)
 				goto exit;
-			ql_write32(qdev, MAC_ADDR_IDX, (offset++) | /* offset */
+			qlge_write32(qdev, MAC_ADDR_IDX, (offset++) | /* offset */
 				   (index << MAC_ADDR_IDX_SHIFT) | /* index */
 				   type);	/* type */
-			ql_write32(qdev, MAC_ADDR_DATA, upper);
+			qlge_write32(qdev, MAC_ADDR_DATA, upper);
 			status =
-			    ql_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+			    qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
 			if (status)
 				goto exit;
-			ql_write32(qdev, MAC_ADDR_IDX, (offset) |	/* offset */
+			qlge_write32(qdev, MAC_ADDR_IDX, (offset) |	/* offset */
 				   (index << MAC_ADDR_IDX_SHIFT) |	/* index */
 				   type);	/* type */
 			/* This field should also include the queue id
@@ -402,7 +402,7 @@ static int ql_set_mac_addr_reg(struct ql_adapter *qdev, u8 *addr, u32 type,
 			if (qdev->ndev->features & NETIF_F_HW_VLAN_CTAG_RX)
 				cam_output |= CAM_OUT_RV;
 			/* route to NIC core */
-			ql_write32(qdev, MAC_ADDR_DATA, cam_output);
+			qlge_write32(qdev, MAC_ADDR_DATA, cam_output);
 			break;
 		}
 	case MAC_ADDR_TYPE_VLAN:
@@ -414,10 +414,10 @@ static int ql_set_mac_addr_reg(struct ql_adapter *qdev, u8 *addr, u32 type,
 			 * That's bit-27 we're talking about.
 			 */
 			status =
-			    ql_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
+			    qlge_wait_reg_rdy(qdev, MAC_ADDR_IDX, MAC_ADDR_MW, 0);
 			if (status)
 				goto exit;
-			ql_write32(qdev, MAC_ADDR_IDX, offset |	/* offset */
+			qlge_write32(qdev, MAC_ADDR_IDX, offset |	/* offset */
 				   (index << MAC_ADDR_IDX_SHIFT) |	/* index */
 				   type |	/* type */
 				   enable_bit);	/* enable/disable */
@@ -437,7 +437,7 @@ static int ql_set_mac_addr_reg(struct ql_adapter *qdev, u8 *addr, u32 type,
  * have to clear it to prevent wrong frame routing
  * especially in a bonding environment.
  */
-static int ql_set_mac_addr(struct ql_adapter *qdev, int set)
+static int qlge_set_mac_addr(struct qlge_adapter *qdev, int set)
 {
 	int status;
 	char zero_mac_addr[ETH_ALEN];
@@ -453,50 +453,50 @@ static int ql_set_mac_addr(struct ql_adapter *qdev, int set)
 		netif_printk(qdev, ifup, KERN_DEBUG, qdev->ndev,
 			     "Clearing MAC address\n");
 	}
-	status = ql_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
 	if (status)
 		return status;
-	status = ql_set_mac_addr_reg(qdev, (u8 *) addr,
+	status = qlge_set_mac_addr_reg(qdev, (u8 *) addr,
 				     MAC_ADDR_TYPE_CAM_MAC,
 				     qdev->func * MAX_CQ);
-	ql_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
 	if (status)
 		netif_err(qdev, ifup, qdev->ndev,
 			  "Failed to init mac address.\n");
 	return status;
 }
 
-void ql_link_on(struct ql_adapter *qdev)
+void qlge_link_on(struct qlge_adapter *qdev)
 {
 	netif_err(qdev, link, qdev->ndev, "Link is up.\n");
 	netif_carrier_on(qdev->ndev);
-	ql_set_mac_addr(qdev, 1);
+	qlge_set_mac_addr(qdev, 1);
 }
 
-void ql_link_off(struct ql_adapter *qdev)
+void qlge_link_off(struct qlge_adapter *qdev)
 {
 	netif_err(qdev, link, qdev->ndev, "Link is down.\n");
 	netif_carrier_off(qdev->ndev);
-	ql_set_mac_addr(qdev, 0);
+	qlge_set_mac_addr(qdev, 0);
 }
 
 /* Get a specific frame routing value from the CAM.
  * Used for debug and reg dump.
  */
-int ql_get_routing_reg(struct ql_adapter *qdev, u32 index, u32 *value)
+int qlge_get_routing_reg(struct qlge_adapter *qdev, u32 index, u32 *value)
 {
 	int status = 0;
 
-	status = ql_wait_reg_rdy(qdev, RT_IDX, RT_IDX_MW, 0);
+	status = qlge_wait_reg_rdy(qdev, RT_IDX, RT_IDX_MW, 0);
 	if (status)
 		goto exit;
 
-	ql_write32(qdev, RT_IDX,
+	qlge_write32(qdev, RT_IDX,
 		   RT_IDX_TYPE_NICQ | RT_IDX_RS | (index << RT_IDX_IDX_SHIFT));
-	status = ql_wait_reg_rdy(qdev, RT_IDX, RT_IDX_MR, 0);
+	status = qlge_wait_reg_rdy(qdev, RT_IDX, RT_IDX_MR, 0);
 	if (status)
 		goto exit;
-	*value = ql_read32(qdev, RT_DATA);
+	*value = qlge_read32(qdev, RT_DATA);
 exit:
 	return status;
 }
@@ -506,7 +506,7 @@ int ql_get_routing_reg(struct ql_adapter *qdev, u32 index, u32 *value)
  * multicast/error frames to the default queue for slow handling,
  * and CAM hit/RSS frames to the fast handling queues.
  */
-static int ql_set_routing_reg(struct ql_adapter *qdev, u32 index, u32 mask,
+static int qlge_set_routing_reg(struct qlge_adapter *qdev, u32 index, u32 mask,
 			      int enable)
 {
 	int status = -EINVAL; /* Return error if no mask match. */
@@ -593,50 +593,50 @@ static int ql_set_routing_reg(struct ql_adapter *qdev, u32 index, u32 mask,
 	}
 
 	if (value) {
-		status = ql_wait_reg_rdy(qdev, RT_IDX, RT_IDX_MW, 0);
+		status = qlge_wait_reg_rdy(qdev, RT_IDX, RT_IDX_MW, 0);
 		if (status)
 			goto exit;
 		value |= (enable ? RT_IDX_E : 0);
-		ql_write32(qdev, RT_IDX, value);
-		ql_write32(qdev, RT_DATA, enable ? mask : 0);
+		qlge_write32(qdev, RT_IDX, value);
+		qlge_write32(qdev, RT_DATA, enable ? mask : 0);
 	}
 exit:
 	return status;
 }
 
-static void ql_enable_interrupts(struct ql_adapter *qdev)
+static void qlge_enable_interrupts(struct qlge_adapter *qdev)
 {
-	ql_write32(qdev, INTR_EN, (INTR_EN_EI << 16) | INTR_EN_EI);
+	qlge_write32(qdev, INTR_EN, (INTR_EN_EI << 16) | INTR_EN_EI);
 }
 
-static void ql_disable_interrupts(struct ql_adapter *qdev)
+static void qlge_disable_interrupts(struct qlge_adapter *qdev)
 {
-	ql_write32(qdev, INTR_EN, (INTR_EN_EI << 16));
+	qlge_write32(qdev, INTR_EN, (INTR_EN_EI << 16));
 }
 
-static void ql_enable_completion_interrupt(struct ql_adapter *qdev, u32 intr)
+static void qlge_enable_completion_interrupt(struct qlge_adapter *qdev, u32 intr)
 {
-	struct intr_context *ctx = &qdev->intr_context[intr];
+	struct qlge_intr_context *ctx = &qdev->intr_context[intr];
 
-	ql_write32(qdev, INTR_EN, ctx->intr_en_mask);
+	qlge_write32(qdev, INTR_EN, ctx->intr_en_mask);
 }
 
-static void ql_disable_completion_interrupt(struct ql_adapter *qdev, u32 intr)
+static void qlge_disable_completion_interrupt(struct qlge_adapter *qdev, u32 intr)
 {
-	struct intr_context *ctx = &qdev->intr_context[intr];
+	struct qlge_intr_context *ctx = &qdev->intr_context[intr];
 
-	ql_write32(qdev, INTR_EN, ctx->intr_dis_mask);
+	qlge_write32(qdev, INTR_EN, ctx->intr_dis_mask);
 }
 
-static void ql_enable_all_completion_interrupts(struct ql_adapter *qdev)
+static void qlge_enable_all_completion_interrupts(struct qlge_adapter *qdev)
 {
 	int i;
 
 	for (i = 0; i < qdev->intr_count; i++)
-		ql_enable_completion_interrupt(qdev, i);
+		qlge_enable_completion_interrupt(qdev, i);
 }
 
-static int ql_validate_flash(struct ql_adapter *qdev, u32 size, const char *str)
+static int qlge_validate_flash(struct qlge_adapter *qdev, u32 size, const char *str)
 {
 	int status, i;
 	u16 csum = 0;
@@ -658,31 +658,31 @@ static int ql_validate_flash(struct ql_adapter *qdev, u32 size, const char *str)
 	return csum;
 }
 
-static int ql_read_flash_word(struct ql_adapter *qdev, int offset, __le32 *data)
+static int qlge_read_flash_word(struct qlge_adapter *qdev, int offset, __le32 *data)
 {
 	int status = 0;
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev,
+	status = qlge_wait_reg_rdy(qdev,
 				 FLASH_ADDR, FLASH_ADDR_RDY, FLASH_ADDR_ERR);
 	if (status)
 		goto exit;
 	/* set up for reg read */
-	ql_write32(qdev, FLASH_ADDR, FLASH_ADDR_R | offset);
+	qlge_write32(qdev, FLASH_ADDR, FLASH_ADDR_R | offset);
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev,
+	status = qlge_wait_reg_rdy(qdev,
 				 FLASH_ADDR, FLASH_ADDR_RDY, FLASH_ADDR_ERR);
 	if (status)
 		goto exit;
 	/* This data is stored on flash as an array of
-	 * __le32.  Since ql_read32() returns cpu endian
+	 * __le32.  Since qlge_read32() returns cpu endian
 	 * we need to swap it back.
 	 */
-	*data = cpu_to_le32(ql_read32(qdev, FLASH_DATA));
+	*data = cpu_to_le32(qlge_read32(qdev, FLASH_DATA));
 exit:
 	return status;
 }
 
-static int ql_get_8000_flash_params(struct ql_adapter *qdev)
+static int qlge_get_8000_flash_params(struct qlge_adapter *qdev)
 {
 	u32 i, size;
 	int status;
@@ -698,12 +698,12 @@ static int ql_get_8000_flash_params(struct ql_adapter *qdev)
 	else
 		offset = FUNC1_FLASH_OFFSET / sizeof(u32);
 
-	if (ql_sem_spinlock(qdev, SEM_FLASH_MASK))
+	if (qlge_sem_spinlock(qdev, SEM_FLASH_MASK))
 		return -ETIMEDOUT;
 
-	size = sizeof(struct flash_params_8000) / sizeof(u32);
+	size = sizeof(struct qlge_flash_params_8000) / sizeof(u32);
 	for (i = 0; i < size; i++, p++) {
-		status = ql_read_flash_word(qdev, i+offset, p);
+		status = qlge_read_flash_word(qdev, i+offset, p);
 		if (status) {
 			netif_err(qdev, ifup, qdev->ndev,
 				  "Error reading flash.\n");
@@ -711,8 +711,8 @@ static int ql_get_8000_flash_params(struct ql_adapter *qdev)
 		}
 	}
 
-	status = ql_validate_flash(qdev,
-				   sizeof(struct flash_params_8000) /
+	status = qlge_validate_flash(qdev,
+				   sizeof(struct qlge_flash_params_8000) /
 				   sizeof(u16),
 				   "8000");
 	if (status) {
@@ -744,17 +744,17 @@ static int ql_get_8000_flash_params(struct ql_adapter *qdev)
 	       qdev->ndev->addr_len);
 
 exit:
-	ql_sem_unlock(qdev, SEM_FLASH_MASK);
+	qlge_sem_unlock(qdev, SEM_FLASH_MASK);
 	return status;
 }
 
-static int ql_get_8012_flash_params(struct ql_adapter *qdev)
+static int qlge_get_8012_flash_params(struct qlge_adapter *qdev)
 {
 	int i;
 	int status;
 	__le32 *p = (__le32 *)&qdev->flash;
 	u32 offset = 0;
-	u32 size = sizeof(struct flash_params_8012) / sizeof(u32);
+	u32 size = sizeof(struct qlge_flash_params_8012) / sizeof(u32);
 
 	/* Second function's parameters follow the first
 	 * function's.
@@ -762,11 +762,11 @@ static int ql_get_8012_flash_params(struct ql_adapter *qdev)
 	if (qdev->port)
 		offset = size;
 
-	if (ql_sem_spinlock(qdev, SEM_FLASH_MASK))
+	if (qlge_sem_spinlock(qdev, SEM_FLASH_MASK))
 		return -ETIMEDOUT;
 
 	for (i = 0; i < size; i++, p++) {
-		status = ql_read_flash_word(qdev, i+offset, p);
+		status = qlge_read_flash_word(qdev, i+offset, p);
 		if (status) {
 			netif_err(qdev, ifup, qdev->ndev,
 				  "Error reading flash.\n");
@@ -775,8 +775,8 @@ static int ql_get_8012_flash_params(struct ql_adapter *qdev)
 
 	}
 
-	status = ql_validate_flash(qdev,
-				   sizeof(struct flash_params_8012) /
+	status = qlge_validate_flash(qdev,
+				   sizeof(struct qlge_flash_params_8012) /
 				   sizeof(u16),
 				   "8012");
 	if (status) {
@@ -795,7 +795,7 @@ static int ql_get_8012_flash_params(struct ql_adapter *qdev)
 	       qdev->ndev->addr_len);
 
 exit:
-	ql_sem_unlock(qdev, SEM_FLASH_MASK);
+	qlge_sem_unlock(qdev, SEM_FLASH_MASK);
 	return status;
 }
 
@@ -803,18 +803,18 @@ static int ql_get_8012_flash_params(struct ql_adapter *qdev)
  * register pair.  Each read/write requires us to wait for the ready
  * bit before reading/writing the data.
  */
-static int ql_write_xgmac_reg(struct ql_adapter *qdev, u32 reg, u32 data)
+static int qlge_write_xgmac_reg(struct qlge_adapter *qdev, u32 reg, u32 data)
 {
 	int status;
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev,
+	status = qlge_wait_reg_rdy(qdev,
 				 XGMAC_ADDR, XGMAC_ADDR_RDY, XGMAC_ADDR_XME);
 	if (status)
 		return status;
 	/* write the data to the data reg */
-	ql_write32(qdev, XGMAC_DATA, data);
+	qlge_write32(qdev, XGMAC_DATA, data);
 	/* trigger the write */
-	ql_write32(qdev, XGMAC_ADDR, reg);
+	qlge_write32(qdev, XGMAC_ADDR, reg);
 	return status;
 }
 
@@ -822,39 +822,39 @@ static int ql_write_xgmac_reg(struct ql_adapter *qdev, u32 reg, u32 data)
  * register pair.  Each read/write requires us to wait for the ready
  * bit before reading/writing the data.
  */
-int ql_read_xgmac_reg(struct ql_adapter *qdev, u32 reg, u32 *data)
+int qlge_read_xgmac_reg(struct qlge_adapter *qdev, u32 reg, u32 *data)
 {
 	int status = 0;
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev,
+	status = qlge_wait_reg_rdy(qdev,
 				 XGMAC_ADDR, XGMAC_ADDR_RDY, XGMAC_ADDR_XME);
 	if (status)
 		goto exit;
 	/* set up for reg read */
-	ql_write32(qdev, XGMAC_ADDR, reg | XGMAC_ADDR_R);
+	qlge_write32(qdev, XGMAC_ADDR, reg | XGMAC_ADDR_R);
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev,
+	status = qlge_wait_reg_rdy(qdev,
 				 XGMAC_ADDR, XGMAC_ADDR_RDY, XGMAC_ADDR_XME);
 	if (status)
 		goto exit;
 	/* get the data */
-	*data = ql_read32(qdev, XGMAC_DATA);
+	*data = qlge_read32(qdev, XGMAC_DATA);
 exit:
 	return status;
 }
 
 /* This is used for reading the 64-bit statistics regs. */
-int ql_read_xgmac_reg64(struct ql_adapter *qdev, u32 reg, u64 *data)
+int qlge_read_xgmac_reg64(struct qlge_adapter *qdev, u32 reg, u64 *data)
 {
 	int status = 0;
 	u32 hi = 0;
 	u32 lo = 0;
 
-	status = ql_read_xgmac_reg(qdev, reg, &lo);
+	status = qlge_read_xgmac_reg(qdev, reg, &lo);
 	if (status)
 		goto exit;
 
-	status = ql_read_xgmac_reg(qdev, reg + 4, &hi);
+	status = qlge_read_xgmac_reg(qdev, reg + 4, &hi);
 	if (status)
 		goto exit;
 
@@ -864,17 +864,17 @@ int ql_read_xgmac_reg64(struct ql_adapter *qdev, u32 reg, u64 *data)
 	return status;
 }
 
-static int ql_8000_port_initialize(struct ql_adapter *qdev)
+static int qlge_8000_port_initialize(struct qlge_adapter *qdev)
 {
 	int status;
 	/*
 	 * Get MPI firmware version for driver banner
 	 * and ethool info.
 	 */
-	status = ql_mb_about_fw(qdev);
+	status = qlge_mb_about_fw(qdev);
 	if (status)
 		goto exit;
-	status = ql_mb_get_fw_state(qdev);
+	status = qlge_mb_get_fw_state(qdev);
 	if (status)
 		goto exit;
 	/* Wake up a worker to get/set the TX/RX frame sizes. */
@@ -889,18 +889,18 @@ static int ql_8000_port_initialize(struct ql_adapter *qdev)
  * This functionality may be done in the MPI firmware at a
  * later date.
  */
-static int ql_8012_port_initialize(struct ql_adapter *qdev)
+static int qlge_8012_port_initialize(struct qlge_adapter *qdev)
 {
 	int status = 0;
 	u32 data;
 
-	if (ql_sem_trylock(qdev, qdev->xg_sem_mask)) {
+	if (qlge_sem_trylock(qdev, qdev->xg_sem_mask)) {
 		/* Another function has the semaphore, so
 		 * wait for the port init bit to come ready.
 		 */
 		netif_info(qdev, link, qdev->ndev,
 			   "Another function has the semaphore, so wait for the port init bit to come ready.\n");
-		status = ql_wait_reg_rdy(qdev, STS, qdev->port_init, 0);
+		status = qlge_wait_reg_rdy(qdev, STS, qdev->port_init, 0);
 		if (status) {
 			netif_crit(qdev, link, qdev->ndev,
 				   "Port initialize timed out.\n");
@@ -910,11 +910,11 @@ static int ql_8012_port_initialize(struct ql_adapter *qdev)
 
 	netif_info(qdev, link, qdev->ndev, "Got xgmac semaphore!.\n");
 	/* Set the core reset. */
-	status = ql_read_xgmac_reg(qdev, GLOBAL_CFG, &data);
+	status = qlge_read_xgmac_reg(qdev, GLOBAL_CFG, &data);
 	if (status)
 		goto end;
 	data |= GLOBAL_CFG_RESET;
-	status = ql_write_xgmac_reg(qdev, GLOBAL_CFG, data);
+	status = qlge_write_xgmac_reg(qdev, GLOBAL_CFG, data);
 	if (status)
 		goto end;
 
@@ -923,48 +923,48 @@ static int ql_8012_port_initialize(struct ql_adapter *qdev)
 	data |= GLOBAL_CFG_JUMBO;	/* Turn on jumbo. */
 	data |= GLOBAL_CFG_TX_STAT_EN;
 	data |= GLOBAL_CFG_RX_STAT_EN;
-	status = ql_write_xgmac_reg(qdev, GLOBAL_CFG, data);
+	status = qlge_write_xgmac_reg(qdev, GLOBAL_CFG, data);
 	if (status)
 		goto end;
 
 	/* Enable transmitter, and clear it's reset. */
-	status = ql_read_xgmac_reg(qdev, TX_CFG, &data);
+	status = qlge_read_xgmac_reg(qdev, TX_CFG, &data);
 	if (status)
 		goto end;
 	data &= ~TX_CFG_RESET;	/* Clear the TX MAC reset. */
 	data |= TX_CFG_EN;	/* Enable the transmitter. */
-	status = ql_write_xgmac_reg(qdev, TX_CFG, data);
+	status = qlge_write_xgmac_reg(qdev, TX_CFG, data);
 	if (status)
 		goto end;
 
 	/* Enable receiver and clear it's reset. */
-	status = ql_read_xgmac_reg(qdev, RX_CFG, &data);
+	status = qlge_read_xgmac_reg(qdev, RX_CFG, &data);
 	if (status)
 		goto end;
 	data &= ~RX_CFG_RESET;	/* Clear the RX MAC reset. */
 	data |= RX_CFG_EN;	/* Enable the receiver. */
-	status = ql_write_xgmac_reg(qdev, RX_CFG, data);
+	status = qlge_write_xgmac_reg(qdev, RX_CFG, data);
 	if (status)
 		goto end;
 
 	/* Turn on jumbo. */
 	status =
-	    ql_write_xgmac_reg(qdev, MAC_TX_PARAMS, MAC_TX_PARAMS_JUMBO | (0x2580 << 16));
+	    qlge_write_xgmac_reg(qdev, MAC_TX_PARAMS, MAC_TX_PARAMS_JUMBO | (0x2580 << 16));
 	if (status)
 		goto end;
 	status =
-	    ql_write_xgmac_reg(qdev, MAC_RX_PARAMS, 0x2580);
+	    qlge_write_xgmac_reg(qdev, MAC_RX_PARAMS, 0x2580);
 	if (status)
 		goto end;
 
 	/* Signal to the world that the port is enabled.        */
-	ql_write32(qdev, STS, ((qdev->port_init << 16) | qdev->port_init));
+	qlge_write32(qdev, STS, ((qdev->port_init << 16) | qdev->port_init));
 end:
-	ql_sem_unlock(qdev, qdev->xg_sem_mask);
+	qlge_sem_unlock(qdev, qdev->xg_sem_mask);
 	return status;
 }
 
-static inline unsigned int ql_lbq_block_size(struct ql_adapter *qdev)
+static inline unsigned int qlge_lbq_block_size(struct qlge_adapter *qdev)
 {
 	return PAGE_SIZE << qdev->lbq_buf_order;
 }
@@ -979,8 +979,8 @@ static struct qlge_bq_desc *qlge_get_curr_buf(struct qlge_bq *bq)
 	return bq_desc;
 }
 
-static struct qlge_bq_desc *ql_get_curr_lchunk(struct ql_adapter *qdev,
-					       struct rx_ring *rx_ring)
+static struct qlge_bq_desc *qlge_get_curr_lchunk(struct qlge_adapter *qdev,
+					       struct qlge_rx_ring *rx_ring)
 {
 	struct qlge_bq_desc *lbq_desc = qlge_get_curr_buf(&rx_ring->lbq);
 
@@ -988,17 +988,17 @@ static struct qlge_bq_desc *ql_get_curr_lchunk(struct ql_adapter *qdev,
 				qdev->lbq_buf_size, DMA_FROM_DEVICE);
 
 	if ((lbq_desc->p.pg_chunk.offset + qdev->lbq_buf_size) ==
-	    ql_lbq_block_size(qdev)) {
+	    qlge_lbq_block_size(qdev)) {
 		/* last chunk of the master page */
 		dma_unmap_page(&qdev->pdev->dev, lbq_desc->dma_addr,
-			       ql_lbq_block_size(qdev), DMA_FROM_DEVICE);
+			       qlge_lbq_block_size(qdev), DMA_FROM_DEVICE);
 	}
 
 	return lbq_desc;
 }
 
 /* Update an rx ring index. */
-static void ql_update_cq(struct rx_ring *rx_ring)
+static void qlge_update_cq(struct qlge_rx_ring *rx_ring)
 {
 	rx_ring->cnsmr_idx++;
 	rx_ring->curr_entry++;
@@ -1008,9 +1008,9 @@ static void ql_update_cq(struct rx_ring *rx_ring)
 	}
 }
 
-static void ql_write_cq_idx(struct rx_ring *rx_ring)
+static void qlge_write_cq_idx(struct qlge_rx_ring *rx_ring)
 {
-	ql_write_db_reg(rx_ring->cnsmr_idx, rx_ring->cnsmr_idx_db_reg);
+	qlge_write_db_reg(rx_ring->cnsmr_idx, rx_ring->cnsmr_idx_db_reg);
 }
 
 static const char * const bq_type_name[] = {
@@ -1019,10 +1019,10 @@ static const char * const bq_type_name[] = {
 };
 
 /* return 0 or negative error */
-static int qlge_refill_sb(struct rx_ring *rx_ring,
+static int qlge_refill_sb(struct qlge_rx_ring *rx_ring,
 			  struct qlge_bq_desc *sbq_desc, gfp_t gfp)
 {
-	struct ql_adapter *qdev = rx_ring->qdev;
+	struct qlge_adapter *qdev = rx_ring->qdev;
 	struct sk_buff *skb;
 
 	if (sbq_desc->p.skb)
@@ -1052,10 +1052,10 @@ static int qlge_refill_sb(struct rx_ring *rx_ring,
 }
 
 /* return 0 or negative error */
-static int qlge_refill_lb(struct rx_ring *rx_ring,
+static int qlge_refill_lb(struct qlge_rx_ring *rx_ring,
 			  struct qlge_bq_desc *lbq_desc, gfp_t gfp)
 {
-	struct ql_adapter *qdev = rx_ring->qdev;
+	struct qlge_adapter *qdev = rx_ring->qdev;
 	struct qlge_page_chunk *master_chunk = &rx_ring->master_chunk;
 
 	if (!master_chunk->page) {
@@ -1066,7 +1066,7 @@ static int qlge_refill_lb(struct rx_ring *rx_ring,
 		if (unlikely(!page))
 			return -ENOMEM;
 		dma_addr = dma_map_page(&qdev->pdev->dev, page, 0,
-					ql_lbq_block_size(qdev),
+					qlge_lbq_block_size(qdev),
 					DMA_FROM_DEVICE);
 		if (dma_mapping_error(&qdev->pdev->dev, dma_addr)) {
 			__free_pages(page, qdev->lbq_buf_order);
@@ -1089,7 +1089,7 @@ static int qlge_refill_lb(struct rx_ring *rx_ring,
 	 * buffer get.
 	 */
 	master_chunk->offset += qdev->lbq_buf_size;
-	if (master_chunk->offset == ql_lbq_block_size(qdev)) {
+	if (master_chunk->offset == qlge_lbq_block_size(qdev)) {
 		master_chunk->page = NULL;
 	} else {
 		master_chunk->va += qdev->lbq_buf_size;
@@ -1102,8 +1102,8 @@ static int qlge_refill_lb(struct rx_ring *rx_ring,
 /* return 0 or negative error */
 static int qlge_refill_bq(struct qlge_bq *bq, gfp_t gfp)
 {
-	struct rx_ring *rx_ring = QLGE_BQ_CONTAINER(bq);
-	struct ql_adapter *qdev = rx_ring->qdev;
+	struct qlge_rx_ring *rx_ring = QLGE_BQ_CONTAINER(bq);
+	struct qlge_adapter *qdev = rx_ring->qdev;
 	struct qlge_bq_desc *bq_desc;
 	int refill_count;
 	int retval;
@@ -1149,7 +1149,7 @@ static int qlge_refill_bq(struct qlge_bq *bq, gfp_t gfp)
 				     "ring %u %s: updating prod idx = %d.\n",
 				     rx_ring->cq_id, bq_type_name[bq->type],
 				     i);
-			ql_write_db_reg(i, bq->prod_idx_db_reg);
+			qlge_write_db_reg(i, bq->prod_idx_db_reg);
 		}
 		bq->next_to_use = i;
 	}
@@ -1157,7 +1157,7 @@ static int qlge_refill_bq(struct qlge_bq *bq, gfp_t gfp)
 	return retval;
 }
 
-static void ql_update_buffer_queues(struct rx_ring *rx_ring, gfp_t gfp,
+static void qlge_update_buffer_queues(struct qlge_rx_ring *rx_ring, gfp_t gfp,
 				    unsigned long delay)
 {
 	bool sbq_fail, lbq_fail;
@@ -1184,12 +1184,12 @@ static void ql_update_buffer_queues(struct rx_ring *rx_ring, gfp_t gfp,
 
 static void qlge_slow_refill(struct work_struct *work)
 {
-	struct rx_ring *rx_ring = container_of(work, struct rx_ring,
+	struct qlge_rx_ring *rx_ring = container_of(work, struct qlge_rx_ring,
 					       refill_work.work);
 	struct napi_struct *napi = &rx_ring->napi;
 
 	napi_disable(napi);
-	ql_update_buffer_queues(rx_ring, GFP_KERNEL, HZ / 2);
+	qlge_update_buffer_queues(rx_ring, GFP_KERNEL, HZ / 2);
 	napi_enable(napi);
 
 	local_bh_disable();
@@ -1204,8 +1204,8 @@ static void qlge_slow_refill(struct work_struct *work)
 /* Unmaps tx buffers.  Can be called from send() if a pci mapping
  * fails at some stage, or from the interrupt when a tx completes.
  */
-static void ql_unmap_send(struct ql_adapter *qdev,
-			  struct tx_ring_desc *tx_ring_desc, int mapped)
+static void qlge_unmap_send(struct qlge_adapter *qdev,
+			  struct qlge_tx_ring_desc *tx_ring_desc, int mapped)
 {
 	int i;
 
@@ -1247,14 +1247,14 @@ static void ql_unmap_send(struct ql_adapter *qdev,
 /* Map the buffers for this transmit.  This will return
  * NETDEV_TX_BUSY or NETDEV_TX_OK based on success.
  */
-static int ql_map_send(struct ql_adapter *qdev,
-		       struct ob_mac_iocb_req *mac_iocb_ptr,
-		       struct sk_buff *skb, struct tx_ring_desc *tx_ring_desc)
+static int qlge_map_send(struct qlge_adapter *qdev,
+		       struct qlge_ob_mac_iocb_req *mac_iocb_ptr,
+		       struct sk_buff *skb, struct qlge_tx_ring_desc *tx_ring_desc)
 {
 	int len = skb_headlen(skb);
 	dma_addr_t map;
 	int frag_idx, err, map_idx = 0;
-	struct tx_buf_desc *tbd = mac_iocb_ptr->tbd;
+	struct qlge_tx_buf_desc *tbd = mac_iocb_ptr->tbd;
 	int frag_cnt = skb_shinfo(skb)->nr_frags;
 
 	if (frag_cnt) {
@@ -1312,7 +1312,7 @@ static int ql_map_send(struct ql_adapter *qdev,
 			 */
 			/* Tack on the OAL in the eighth segment of IOCB. */
 			map = dma_map_single(&qdev->pdev->dev, &tx_ring_desc->oal,
-					     sizeof(struct oal),
+					     sizeof(struct qlge_oal),
 					     DMA_TO_DEVICE);
 			err = dma_mapping_error(&qdev->pdev->dev, map);
 			if (err) {
@@ -1329,13 +1329,13 @@ static int ql_map_send(struct ql_adapter *qdev,
 			 * of our sglist (OAL).
 			 */
 			tbd->len =
-			    cpu_to_le32((sizeof(struct tx_buf_desc) *
+			    cpu_to_le32((sizeof(struct qlge_tx_buf_desc) *
 					 (frag_cnt - frag_idx)) | TX_DESC_C);
 			dma_unmap_addr_set(&tx_ring_desc->map[map_idx], mapaddr,
 					   map);
 			dma_unmap_len_set(&tx_ring_desc->map[map_idx], maplen,
-					  sizeof(struct oal));
-			tbd = (struct tx_buf_desc *)&tx_ring_desc->oal;
+					  sizeof(struct qlge_oal));
+			tbd = (struct qlge_tx_buf_desc *)&tx_ring_desc->oal;
 			map_idx++;
 		}
 
@@ -1370,15 +1370,15 @@ static int ql_map_send(struct ql_adapter *qdev,
 	 * we pass in the number of frags that mapped successfully
 	 * so they can be umapped.
 	 */
-	ql_unmap_send(qdev, tx_ring_desc, map_idx);
+	qlge_unmap_send(qdev, tx_ring_desc, map_idx);
 	return NETDEV_TX_BUSY;
 }
 
 /* Categorizing receive firmware frame errors */
-static void ql_categorize_rx_err(struct ql_adapter *qdev, u8 rx_err,
-				 struct rx_ring *rx_ring)
+static void qlge_categorize_rx_err(struct qlge_adapter *qdev, u8 rx_err,
+				 struct qlge_rx_ring *rx_ring)
 {
-	struct nic_stats *stats = &qdev->nic_stats;
+	struct qlge_nic_stats *stats = &qdev->nic_stats;
 
 	stats->rx_err_count++;
 	rx_ring->rx_errors++;
@@ -1407,11 +1407,11 @@ static void ql_categorize_rx_err(struct ql_adapter *qdev, u8 rx_err,
 }
 
 /**
- * ql_update_mac_hdr_len - helper routine to update the mac header length
+ * qlge_update_mac_hdr_len - helper routine to update the mac header length
  * based on vlan tags if present
  */
-static void ql_update_mac_hdr_len(struct ql_adapter *qdev,
-				  struct ib_mac_iocb_rsp *ib_mac_rsp,
+static void qlge_update_mac_hdr_len(struct qlge_adapter *qdev,
+				  struct qlge_ib_mac_iocb_rsp *ib_mac_rsp,
 				  void *page, size_t *len)
 {
 	u16 *tags;
@@ -1430,18 +1430,18 @@ static void ql_update_mac_hdr_len(struct ql_adapter *qdev,
 }
 
 /* Process an inbound completion from an rx ring. */
-static void ql_process_mac_rx_gro_page(struct ql_adapter *qdev,
-				       struct rx_ring *rx_ring,
-				       struct ib_mac_iocb_rsp *ib_mac_rsp,
+static void qlge_process_mac_rx_gro_page(struct qlge_adapter *qdev,
+				       struct qlge_rx_ring *rx_ring,
+				       struct qlge_ib_mac_iocb_rsp *ib_mac_rsp,
 				       u32 length, u16 vlan_id)
 {
 	struct sk_buff *skb;
-	struct qlge_bq_desc *lbq_desc = ql_get_curr_lchunk(qdev, rx_ring);
+	struct qlge_bq_desc *lbq_desc = qlge_get_curr_lchunk(qdev, rx_ring);
 	struct napi_struct *napi = &rx_ring->napi;
 
 	/* Frame error, so drop the packet. */
 	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_ERR_MASK) {
-		ql_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
+		qlge_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
 		put_page(lbq_desc->p.pg_chunk.page);
 		return;
 	}
@@ -1476,15 +1476,15 @@ static void ql_process_mac_rx_gro_page(struct ql_adapter *qdev,
 }
 
 /* Process an inbound completion from an rx ring. */
-static void ql_process_mac_rx_page(struct ql_adapter *qdev,
-				   struct rx_ring *rx_ring,
-				   struct ib_mac_iocb_rsp *ib_mac_rsp,
+static void qlge_process_mac_rx_page(struct qlge_adapter *qdev,
+				   struct qlge_rx_ring *rx_ring,
+				   struct qlge_ib_mac_iocb_rsp *ib_mac_rsp,
 				   u32 length, u16 vlan_id)
 {
 	struct net_device *ndev = qdev->ndev;
 	struct sk_buff *skb = NULL;
 	void *addr;
-	struct qlge_bq_desc *lbq_desc = ql_get_curr_lchunk(qdev, rx_ring);
+	struct qlge_bq_desc *lbq_desc = qlge_get_curr_lchunk(qdev, rx_ring);
 	struct napi_struct *napi = &rx_ring->napi;
 	size_t hlen = ETH_HLEN;
 
@@ -1500,12 +1500,12 @@ static void ql_process_mac_rx_page(struct ql_adapter *qdev,
 
 	/* Frame error, so drop the packet. */
 	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_ERR_MASK) {
-		ql_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
+		qlge_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
 		goto err_out;
 	}
 
 	/* Update the MAC header length*/
-	ql_update_mac_hdr_len(qdev, ib_mac_rsp, addr, &hlen);
+	qlge_update_mac_hdr_len(qdev, ib_mac_rsp, addr, &hlen);
 
 	/* The max framesize filter on this chip is set higher than
 	 * MTU since FCoE uses 2k frames.
@@ -1567,9 +1567,9 @@ static void ql_process_mac_rx_page(struct ql_adapter *qdev,
 }
 
 /* Process an inbound completion from an rx ring. */
-static void ql_process_mac_rx_skb(struct ql_adapter *qdev,
-				  struct rx_ring *rx_ring,
-				  struct ib_mac_iocb_rsp *ib_mac_rsp,
+static void qlge_process_mac_rx_skb(struct qlge_adapter *qdev,
+				  struct qlge_rx_ring *rx_ring,
+				  struct qlge_ib_mac_iocb_rsp *ib_mac_rsp,
 				  u32 length, u16 vlan_id)
 {
 	struct qlge_bq_desc *sbq_desc = qlge_get_curr_buf(&rx_ring->sbq);
@@ -1594,14 +1594,14 @@ static void ql_process_mac_rx_skb(struct ql_adapter *qdev,
 
 	/* Frame error, so drop the packet. */
 	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_ERR_MASK) {
-		ql_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
+		qlge_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
 		dev_kfree_skb_any(skb);
 		return;
 	}
 
 	/* loopback self test for ethtool */
-	if (test_bit(QL_SELFTEST, &qdev->flags)) {
-		ql_check_lb_frame(qdev, skb);
+	if (test_bit(QLGE_SELFTEST, &qdev->flags)) {
+		qlge_check_lb_frame(qdev, skb);
 		dev_kfree_skb_any(skb);
 		return;
 	}
@@ -1669,7 +1669,7 @@ static void ql_process_mac_rx_skb(struct ql_adapter *qdev,
 		netif_receive_skb(skb);
 }
 
-static void ql_realign_skb(struct sk_buff *skb, int len)
+static void qlge_realign_skb(struct sk_buff *skb, int len)
 {
 	void *temp_addr = skb->data;
 
@@ -1687,9 +1687,9 @@ static void ql_realign_skb(struct sk_buff *skb, int len)
  * completion.  It will be rewritten for readability in the near
  * future, but for not it works well.
  */
-static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
-				       struct rx_ring *rx_ring,
-				       struct ib_mac_iocb_rsp *ib_mac_rsp)
+static struct sk_buff *qlge_build_rx_skb(struct qlge_adapter *qdev,
+				       struct qlge_rx_ring *rx_ring,
+				       struct qlge_ib_mac_iocb_rsp *ib_mac_rsp)
 {
 	u32 length = le32_to_cpu(ib_mac_rsp->data_len);
 	u32 hdr_len = le32_to_cpu(ib_mac_rsp->hdr_len);
@@ -1711,7 +1711,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 		dma_unmap_single(&qdev->pdev->dev, sbq_desc->dma_addr,
 				 SMALL_BUF_MAP_SIZE, DMA_FROM_DEVICE);
 		skb = sbq_desc->p.skb;
-		ql_realign_skb(skb, hdr_len);
+		qlge_realign_skb(skb, hdr_len);
 		skb_put(skb, hdr_len);
 		sbq_desc->p.skb = NULL;
 	}
@@ -1749,7 +1749,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 				     length);
 			sbq_desc = qlge_get_curr_buf(&rx_ring->sbq);
 			skb = sbq_desc->p.skb;
-			ql_realign_skb(skb, length);
+			qlge_realign_skb(skb, length);
 			skb_put(skb, length);
 			dma_unmap_single(&qdev->pdev->dev, sbq_desc->dma_addr,
 					 SMALL_BUF_MAP_SIZE,
@@ -1766,7 +1766,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 			 * chain it to the header buffer's skb and let
 			 * it rip.
 			 */
-			lbq_desc = ql_get_curr_lchunk(qdev, rx_ring);
+			lbq_desc = qlge_get_curr_lchunk(qdev, rx_ring);
 			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
 				     "Chaining page at offset = %d, for %d bytes  to skb.\n",
 				     lbq_desc->p.pg_chunk.offset, length);
@@ -1781,7 +1781,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 			 * copy it to a new skb and let it go. This can happen with
 			 * jumbo mtu on a non-TCP/UDP frame.
 			 */
-			lbq_desc = ql_get_curr_lchunk(qdev, rx_ring);
+			lbq_desc = qlge_get_curr_lchunk(qdev, rx_ring);
 			skb = netdev_alloc_skb(qdev->ndev, length);
 			if (!skb) {
 				netif_printk(qdev, probe, KERN_DEBUG, qdev->ndev,
@@ -1801,7 +1801,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 			skb->len += length;
 			skb->data_len += length;
 			skb->truesize += length;
-			ql_update_mac_hdr_len(qdev, ib_mac_rsp,
+			qlge_update_mac_hdr_len(qdev, ib_mac_rsp,
 					      lbq_desc->p.pg_chunk.va,
 					      &hlen);
 			__pskb_pull_tail(skb, hlen);
@@ -1841,7 +1841,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 			skb_reserve(skb, NET_IP_ALIGN);
 		}
 		do {
-			lbq_desc = ql_get_curr_lchunk(qdev, rx_ring);
+			lbq_desc = qlge_get_curr_lchunk(qdev, rx_ring);
 			size = min(length, qdev->lbq_buf_size);
 
 			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
@@ -1856,7 +1856,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 			length -= size;
 			i++;
 		} while (length > 0);
-		ql_update_mac_hdr_len(qdev, ib_mac_rsp, lbq_desc->p.pg_chunk.va,
+		qlge_update_mac_hdr_len(qdev, ib_mac_rsp, lbq_desc->p.pg_chunk.va,
 				      &hlen);
 		__pskb_pull_tail(skb, hlen);
 	}
@@ -1864,17 +1864,17 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 }
 
 /* Process an inbound completion from an rx ring. */
-static void ql_process_mac_split_rx_intr(struct ql_adapter *qdev,
-					 struct rx_ring *rx_ring,
-					 struct ib_mac_iocb_rsp *ib_mac_rsp,
+static void qlge_process_mac_split_rx_intr(struct qlge_adapter *qdev,
+					 struct qlge_rx_ring *rx_ring,
+					 struct qlge_ib_mac_iocb_rsp *ib_mac_rsp,
 					 u16 vlan_id)
 {
 	struct net_device *ndev = qdev->ndev;
 	struct sk_buff *skb = NULL;
 
-	QL_DUMP_IB_MAC_RSP(ib_mac_rsp);
+	QLGE_DUMP_IB_MAC_RSP(ib_mac_rsp);
 
-	skb = ql_build_rx_skb(qdev, rx_ring, ib_mac_rsp);
+	skb = qlge_build_rx_skb(qdev, rx_ring, ib_mac_rsp);
 	if (unlikely(!skb)) {
 		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
 			     "No skb available, drop packet.\n");
@@ -1884,7 +1884,7 @@ static void ql_process_mac_split_rx_intr(struct ql_adapter *qdev,
 
 	/* Frame error, so drop the packet. */
 	if (ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_ERR_MASK) {
-		ql_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
+		qlge_categorize_rx_err(qdev, ib_mac_rsp->flags2, rx_ring);
 		dev_kfree_skb_any(skb);
 		return;
 	}
@@ -1899,8 +1899,8 @@ static void ql_process_mac_split_rx_intr(struct ql_adapter *qdev,
 	}
 
 	/* loopback self test for ethtool */
-	if (test_bit(QL_SELFTEST, &qdev->flags)) {
-		ql_check_lb_frame(qdev, skb);
+	if (test_bit(QLGE_SELFTEST, &qdev->flags)) {
+		qlge_check_lb_frame(qdev, skb);
 		dev_kfree_skb_any(skb);
 		return;
 	}
@@ -1960,9 +1960,9 @@ static void ql_process_mac_split_rx_intr(struct ql_adapter *qdev,
 }
 
 /* Process an inbound completion from an rx ring. */
-static unsigned long ql_process_mac_rx_intr(struct ql_adapter *qdev,
-					    struct rx_ring *rx_ring,
-					    struct ib_mac_iocb_rsp *ib_mac_rsp)
+static unsigned long qlge_process_mac_rx_intr(struct qlge_adapter *qdev,
+					    struct qlge_rx_ring *rx_ring,
+					    struct qlge_ib_mac_iocb_rsp *ib_mac_rsp)
 {
 	u32 length = le32_to_cpu(ib_mac_rsp->data_len);
 	u16 vlan_id = ((ib_mac_rsp->flags2 & IB_MAC_IOCB_RSP_V) &&
@@ -1970,20 +1970,20 @@ static unsigned long ql_process_mac_rx_intr(struct ql_adapter *qdev,
 			((le16_to_cpu(ib_mac_rsp->vlan_id) &
 			IB_MAC_IOCB_RSP_VLAN_MASK)) : 0xffff;
 
-	QL_DUMP_IB_MAC_RSP(ib_mac_rsp);
+	QLGE_DUMP_IB_MAC_RSP(ib_mac_rsp);
 
 	if (ib_mac_rsp->flags4 & IB_MAC_IOCB_RSP_HV) {
 		/* The data and headers are split into
 		 * separate buffers.
 		 */
-		ql_process_mac_split_rx_intr(qdev, rx_ring, ib_mac_rsp,
+		qlge_process_mac_split_rx_intr(qdev, rx_ring, ib_mac_rsp,
 					     vlan_id);
 	} else if (ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_DS) {
 		/* The data fit in a single small buffer.
 		 * Allocate a new skb, copy the data and
 		 * return the buffer to the free pool.
 		 */
-		ql_process_mac_rx_skb(qdev, rx_ring, ib_mac_rsp, length,
+		qlge_process_mac_rx_skb(qdev, rx_ring, ib_mac_rsp, length,
 				      vlan_id);
 	} else if ((ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_DL) &&
 		!(ib_mac_rsp->flags1 & IB_MAC_CSUM_ERR_MASK) &&
@@ -1991,19 +1991,19 @@ static unsigned long ql_process_mac_rx_intr(struct ql_adapter *qdev,
 		/* TCP packet in a page chunk that's been checksummed.
 		 * Tack it on to our GRO skb and let it go.
 		 */
-		ql_process_mac_rx_gro_page(qdev, rx_ring, ib_mac_rsp, length,
+		qlge_process_mac_rx_gro_page(qdev, rx_ring, ib_mac_rsp, length,
 					   vlan_id);
 	} else if (ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_DL) {
 		/* Non-TCP packet in a page chunk. Allocate an
 		 * skb, tack it on frags, and send it up.
 		 */
-		ql_process_mac_rx_page(qdev, rx_ring, ib_mac_rsp, length,
+		qlge_process_mac_rx_page(qdev, rx_ring, ib_mac_rsp, length,
 				       vlan_id);
 	} else {
 		/* Non-TCP/UDP large frames that span multiple buffers
 		 * can be processed corrrectly by the split frame logic.
 		 */
-		ql_process_mac_split_rx_intr(qdev, rx_ring, ib_mac_rsp,
+		qlge_process_mac_split_rx_intr(qdev, rx_ring, ib_mac_rsp,
 					     vlan_id);
 	}
 
@@ -2011,16 +2011,16 @@ static unsigned long ql_process_mac_rx_intr(struct ql_adapter *qdev,
 }
 
 /* Process an outbound completion from an rx ring. */
-static void ql_process_mac_tx_intr(struct ql_adapter *qdev,
-				   struct ob_mac_iocb_rsp *mac_rsp)
+static void qlge_process_mac_tx_intr(struct qlge_adapter *qdev,
+				   struct qlge_ob_mac_iocb_rsp *mac_rsp)
 {
-	struct tx_ring *tx_ring;
-	struct tx_ring_desc *tx_ring_desc;
+	struct qlge_tx_ring *tx_ring;
+	struct qlge_tx_ring_desc *tx_ring_desc;
 
-	QL_DUMP_OB_MAC_RSP(mac_rsp);
+	QLGE_DUMP_OB_MAC_RSP(mac_rsp);
 	tx_ring = &qdev->tx_ring[mac_rsp->txq_idx];
 	tx_ring_desc = &tx_ring->q[mac_rsp->tid];
-	ql_unmap_send(qdev, tx_ring_desc, tx_ring_desc->map_cnt);
+	qlge_unmap_send(qdev, tx_ring_desc, tx_ring_desc->map_cnt);
 	tx_ring->tx_bytes += (tx_ring_desc->skb)->len;
 	tx_ring->tx_packets++;
 	dev_kfree_skb(tx_ring_desc->skb);
@@ -2051,72 +2051,72 @@ static void ql_process_mac_tx_intr(struct ql_adapter *qdev,
 }
 
 /* Fire up a handler to reset the MPI processor. */
-void ql_queue_fw_error(struct ql_adapter *qdev)
+void qlge_queue_fw_error(struct qlge_adapter *qdev)
 {
-	ql_link_off(qdev);
+	qlge_link_off(qdev);
 	queue_delayed_work(qdev->workqueue, &qdev->mpi_reset_work, 0);
 }
 
-void ql_queue_asic_error(struct ql_adapter *qdev)
+void qlge_queue_asic_error(struct qlge_adapter *qdev)
 {
-	ql_link_off(qdev);
-	ql_disable_interrupts(qdev);
+	qlge_link_off(qdev);
+	qlge_disable_interrupts(qdev);
 	/* Clear adapter up bit to signal the recovery
 	 * process that it shouldn't kill the reset worker
 	 * thread
 	 */
-	clear_bit(QL_ADAPTER_UP, &qdev->flags);
+	clear_bit(QLGE_ADAPTER_UP, &qdev->flags);
 	/* Set asic recovery bit to indicate reset process that we are
 	 * in fatal error recovery process rather than normal close
 	 */
-	set_bit(QL_ASIC_RECOVERY, &qdev->flags);
+	set_bit(QLGE_ASIC_RECOVERY, &qdev->flags);
 	queue_delayed_work(qdev->workqueue, &qdev->asic_reset_work, 0);
 }
 
-static void ql_process_chip_ae_intr(struct ql_adapter *qdev,
-				    struct ib_ae_iocb_rsp *ib_ae_rsp)
+static void qlge_process_chip_ae_intr(struct qlge_adapter *qdev,
+				    struct qlge_ib_ae_iocb_rsp *ib_ae_rsp)
 {
 	switch (ib_ae_rsp->event) {
 	case MGMT_ERR_EVENT:
 		netif_err(qdev, rx_err, qdev->ndev,
 			  "Management Processor Fatal Error.\n");
-		ql_queue_fw_error(qdev);
+		qlge_queue_fw_error(qdev);
 		return;
 
 	case CAM_LOOKUP_ERR_EVENT:
 		netdev_err(qdev->ndev, "Multiple CAM hits lookup occurred.\n");
 		netdev_err(qdev->ndev, "This event shouldn't occur.\n");
-		ql_queue_asic_error(qdev);
+		qlge_queue_asic_error(qdev);
 		return;
 
 	case SOFT_ECC_ERROR_EVENT:
 		netdev_err(qdev->ndev, "Soft ECC error detected.\n");
-		ql_queue_asic_error(qdev);
+		qlge_queue_asic_error(qdev);
 		break;
 
 	case PCI_ERR_ANON_BUF_RD:
 		netdev_err(qdev->ndev, "PCI error occurred when reading "
 					"anonymous buffers from rx_ring %d.\n",
 					ib_ae_rsp->q_id);
-		ql_queue_asic_error(qdev);
+		qlge_queue_asic_error(qdev);
 		break;
 
 	default:
 		netif_err(qdev, drv, qdev->ndev, "Unexpected event %d.\n",
 			  ib_ae_rsp->event);
-		ql_queue_asic_error(qdev);
+		qlge_queue_asic_error(qdev);
 		break;
 	}
 }
 
-static int ql_clean_outbound_rx_ring(struct rx_ring *rx_ring)
+static int qlge_clean_outbound_rx_ring(struct qlge_rx_ring *rx_ring)
 {
-	struct ql_adapter *qdev = rx_ring->qdev;
-	u32 prod = ql_read_sh_reg(rx_ring->prod_idx_sh_reg);
-	struct ob_mac_iocb_rsp *net_rsp = NULL;
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	u32 prod = qlge_read_sh_reg(rx_ring->prod_idx_sh_reg);
+	struct qlge_ob_mac_iocb_rsp *net_rsp = NULL;
 	int count = 0;
 
-	struct tx_ring *tx_ring;
+	struct qlge_tx_ring *tx_ring;
 	/* While there are entries in the completion queue. */
 	while (prod != rx_ring->cnsmr_idx) {
 
@@ -2124,13 +2124,13 @@ static int ql_clean_outbound_rx_ring(struct rx_ring *rx_ring)
 			     "cq_id = %d, prod = %d, cnsmr = %d\n",
 			     rx_ring->cq_id, prod, rx_ring->cnsmr_idx);
 
-		net_rsp = (struct ob_mac_iocb_rsp *)rx_ring->curr_entry;
+		net_rsp = (struct qlge_ob_mac_iocb_rsp *)rx_ring->curr_entry;
 		rmb();
 		switch (net_rsp->opcode) {
 
 		case OPCODE_OB_MAC_TSO_IOCB:
 		case OPCODE_OB_MAC_IOCB:
-			ql_process_mac_tx_intr(qdev, net_rsp);
+			qlge_process_mac_tx_intr(qdev, net_rsp);
 			break;
 		default:
 			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
@@ -2138,12 +2138,12 @@ static int ql_clean_outbound_rx_ring(struct rx_ring *rx_ring)
 				     net_rsp->opcode);
 		}
 		count++;
-		ql_update_cq(rx_ring);
-		prod = ql_read_sh_reg(rx_ring->prod_idx_sh_reg);
+		qlge_update_cq(rx_ring);
+		prod = qlge_read_sh_reg(rx_ring->prod_idx_sh_reg);
 	}
 	if (!net_rsp)
 		return 0;
-	ql_write_cq_idx(rx_ring);
+	qlge_write_cq_idx(rx_ring);
 	tx_ring = &qdev->tx_ring[net_rsp->txq_idx];
 	if (__netif_subqueue_stopped(qdev->ndev, tx_ring->wq_id)) {
 		if ((atomic_read(&tx_ring->tx_count) > (tx_ring->wq_len / 4)))
@@ -2157,11 +2157,11 @@ static int ql_clean_outbound_rx_ring(struct rx_ring *rx_ring)
 	return count;
 }
 
-static int ql_clean_inbound_rx_ring(struct rx_ring *rx_ring, int budget)
+static int qlge_clean_inbound_rx_ring(struct qlge_rx_ring *rx_ring, int budget)
 {
-	struct ql_adapter *qdev = rx_ring->qdev;
-	u32 prod = ql_read_sh_reg(rx_ring->prod_idx_sh_reg);
-	struct ql_net_rsp_iocb *net_rsp;
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	u32 prod = qlge_read_sh_reg(rx_ring->prod_idx_sh_reg);
+	struct qlge_net_rsp_iocb *net_rsp;
 	int count = 0;
 
 	/* While there are entries in the completion queue. */
@@ -2175,13 +2175,13 @@ static int ql_clean_inbound_rx_ring(struct rx_ring *rx_ring, int budget)
 		rmb();
 		switch (net_rsp->opcode) {
 		case OPCODE_IB_MAC_IOCB:
-			ql_process_mac_rx_intr(qdev, rx_ring,
-					       (struct ib_mac_iocb_rsp *)
+			qlge_process_mac_rx_intr(qdev, rx_ring,
+					       (struct qlge_ib_mac_iocb_rsp *)
 					       net_rsp);
 			break;
 
 		case OPCODE_IB_AE_IOCB:
-			ql_process_chip_ae_intr(qdev, (struct ib_ae_iocb_rsp *)
+			qlge_process_chip_ae_intr(qdev, (struct qlge_ib_ae_iocb_rsp *)
 						net_rsp);
 			break;
 		default:
@@ -2191,23 +2191,23 @@ static int ql_clean_inbound_rx_ring(struct rx_ring *rx_ring, int budget)
 			break;
 		}
 		count++;
-		ql_update_cq(rx_ring);
-		prod = ql_read_sh_reg(rx_ring->prod_idx_sh_reg);
+		qlge_update_cq(rx_ring);
+		prod = qlge_read_sh_reg(rx_ring->prod_idx_sh_reg);
 		if (count == budget)
 			break;
 	}
-	ql_update_buffer_queues(rx_ring, GFP_ATOMIC, 0);
-	ql_write_cq_idx(rx_ring);
+	qlge_update_buffer_queues(rx_ring, GFP_ATOMIC, 0);
+	qlge_write_cq_idx(rx_ring);
 	return count;
 }
 
-static int ql_napi_poll_msix(struct napi_struct *napi, int budget)
+static int qlge_napi_poll_msix(struct napi_struct *napi, int budget)
 {
-	struct rx_ring *rx_ring = container_of(napi, struct rx_ring, napi);
-	struct ql_adapter *qdev = rx_ring->qdev;
-	struct rx_ring *trx_ring;
+	struct qlge_rx_ring *rx_ring = container_of(napi, struct qlge_rx_ring, napi);
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	struct qlge_rx_ring *trx_ring;
 	int i, work_done = 0;
-	struct intr_context *ctx = &qdev->intr_context[rx_ring->cq_id];
+	struct qlge_intr_context *ctx = &qdev->intr_context[rx_ring->cq_id];
 
 	netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
 		     "Enter, NAPI POLL cq_id = %d.\n", rx_ring->cq_id);
@@ -2221,42 +2221,42 @@ static int ql_napi_poll_msix(struct napi_struct *napi, int budget)
 		 * it's not empty then service it.
 		 */
 		if ((ctx->irq_mask & (1 << trx_ring->cq_id)) &&
-		    (ql_read_sh_reg(trx_ring->prod_idx_sh_reg) !=
+		    (qlge_read_sh_reg(trx_ring->prod_idx_sh_reg) !=
 		     trx_ring->cnsmr_idx)) {
 			netif_printk(qdev, intr, KERN_DEBUG, qdev->ndev,
 				     "%s: Servicing TX completion ring %d.\n",
 				     __func__, trx_ring->cq_id);
-			ql_clean_outbound_rx_ring(trx_ring);
+			qlge_clean_outbound_rx_ring(trx_ring);
 		}
 	}
 
 	/*
 	 * Now service the RSS ring if it's active.
 	 */
-	if (ql_read_sh_reg(rx_ring->prod_idx_sh_reg) !=
+	if (qlge_read_sh_reg(rx_ring->prod_idx_sh_reg) !=
 					rx_ring->cnsmr_idx) {
 		netif_printk(qdev, intr, KERN_DEBUG, qdev->ndev,
 			     "%s: Servicing RX completion ring %d.\n",
 			     __func__, rx_ring->cq_id);
-		work_done = ql_clean_inbound_rx_ring(rx_ring, budget);
+		work_done = qlge_clean_inbound_rx_ring(rx_ring, budget);
 	}
 
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
-		ql_enable_completion_interrupt(qdev, rx_ring->irq);
+		qlge_enable_completion_interrupt(qdev, rx_ring->irq);
 	}
 	return work_done;
 }
 
 static void qlge_vlan_mode(struct net_device *ndev, netdev_features_t features)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	if (features & NETIF_F_HW_VLAN_CTAG_RX) {
-		ql_write32(qdev, NIC_RCV_CFG, NIC_RCV_CFG_VLAN_MASK |
+		qlge_write32(qdev, NIC_RCV_CFG, NIC_RCV_CFG_VLAN_MASK |
 				 NIC_RCV_CFG_VLAN_MATCH_AND_NON);
 	} else {
-		ql_write32(qdev, NIC_RCV_CFG, NIC_RCV_CFG_VLAN_MASK);
+		qlge_write32(qdev, NIC_RCV_CFG, NIC_RCV_CFG_VLAN_MASK);
 	}
 }
 
@@ -2267,12 +2267,12 @@ static void qlge_vlan_mode(struct net_device *ndev, netdev_features_t features)
 static int qlge_update_hw_vlan_features(struct net_device *ndev,
 					netdev_features_t features)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int status = 0;
 	bool need_restart = netif_running(ndev);
 
 	if (need_restart) {
-		status = ql_adapter_down(qdev);
+		status = qlge_adapter_down(qdev);
 		if (status) {
 			netif_err(qdev, link, qdev->ndev,
 				  "Failed to bring down the adapter\n");
@@ -2284,7 +2284,7 @@ static int qlge_update_hw_vlan_features(struct net_device *ndev,
 	ndev->features = features;
 
 	if (need_restart) {
-		status = ql_adapter_up(qdev);
+		status = qlge_adapter_up(qdev);
 		if (status) {
 			netif_err(qdev, link, qdev->ndev,
 				  "Failed to bring up the adapter\n");
@@ -2313,12 +2313,12 @@ static int qlge_set_features(struct net_device *ndev,
 	return 0;
 }
 
-static int __qlge_vlan_rx_add_vid(struct ql_adapter *qdev, u16 vid)
+static int __qlge_vlan_rx_add_vid(struct qlge_adapter *qdev, u16 vid)
 {
 	u32 enable_bit = MAC_ADDR_E;
 	int err;
 
-	err = ql_set_mac_addr_reg(qdev, (u8 *) &enable_bit,
+	err = qlge_set_mac_addr_reg(qdev, (u8 *) &enable_bit,
 				  MAC_ADDR_TYPE_VLAN, vid);
 	if (err)
 		netif_err(qdev, ifup, qdev->ndev,
@@ -2328,28 +2328,28 @@ static int __qlge_vlan_rx_add_vid(struct ql_adapter *qdev, u16 vid)
 
 static int qlge_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int status;
 	int err;
 
-	status = ql_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
 	if (status)
 		return status;
 
 	err = __qlge_vlan_rx_add_vid(qdev, vid);
 	set_bit(vid, qdev->active_vlans);
 
-	ql_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
 
 	return err;
 }
 
-static int __qlge_vlan_rx_kill_vid(struct ql_adapter *qdev, u16 vid)
+static int __qlge_vlan_rx_kill_vid(struct qlge_adapter *qdev, u16 vid)
 {
 	u32 enable_bit = 0;
 	int err;
 
-	err = ql_set_mac_addr_reg(qdev, (u8 *) &enable_bit,
+	err = qlge_set_mac_addr_reg(qdev, (u8 *) &enable_bit,
 				  MAC_ADDR_TYPE_VLAN, vid);
 	if (err)
 		netif_err(qdev, ifup, qdev->ndev,
@@ -2359,41 +2359,41 @@ static int __qlge_vlan_rx_kill_vid(struct ql_adapter *qdev, u16 vid)
 
 static int qlge_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int status;
 	int err;
 
-	status = ql_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
 	if (status)
 		return status;
 
 	err = __qlge_vlan_rx_kill_vid(qdev, vid);
 	clear_bit(vid, qdev->active_vlans);
 
-	ql_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
 
 	return err;
 }
 
-static void qlge_restore_vlan(struct ql_adapter *qdev)
+static void qlge_restore_vlan(struct qlge_adapter *qdev)
 {
 	int status;
 	u16 vid;
 
-	status = ql_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
 	if (status)
 		return;
 
 	for_each_set_bit(vid, qdev->active_vlans, VLAN_N_VID)
 		__qlge_vlan_rx_add_vid(qdev, vid);
 
-	ql_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
 }
 
 /* MSI-X Multiple Vector Interrupt Handler for inbound completions. */
 static irqreturn_t qlge_msix_rx_isr(int irq, void *dev_id)
 {
-	struct rx_ring *rx_ring = dev_id;
+	struct qlge_rx_ring *rx_ring = dev_id;
 
 	napi_schedule(&rx_ring->napi);
 	return IRQ_HANDLED;
@@ -2406,9 +2406,9 @@ static irqreturn_t qlge_msix_rx_isr(int irq, void *dev_id)
  */
 static irqreturn_t qlge_isr(int irq, void *dev_id)
 {
-	struct rx_ring *rx_ring = dev_id;
-	struct ql_adapter *qdev = rx_ring->qdev;
-	struct intr_context *intr_context = &qdev->intr_context[0];
+	struct qlge_rx_ring *rx_ring = dev_id;
+	struct qlge_adapter *qdev = rx_ring->qdev;
+	struct qlge_intr_context *intr_context = &qdev->intr_context[0];
 	u32 var;
 	int work_done = 0;
 
@@ -2418,19 +2418,19 @@ static irqreturn_t qlge_isr(int irq, void *dev_id)
 	 * (even though it is auto-masked), otherwise a later command to
 	 * enable it is not effective.
 	 */
-	if (!test_bit(QL_MSIX_ENABLED, &qdev->flags))
-		ql_disable_completion_interrupt(qdev, 0);
+	if (!test_bit(QLGE_MSIX_ENABLED, &qdev->flags))
+		qlge_disable_completion_interrupt(qdev, 0);
 
-	var = ql_read32(qdev, STS);
+	var = qlge_read32(qdev, STS);
 
 	/*
 	 * Check for fatal error.
 	 */
 	if (var & STS_FE) {
-		ql_disable_completion_interrupt(qdev, 0);
-		ql_queue_asic_error(qdev);
+		qlge_disable_completion_interrupt(qdev, 0);
+		qlge_queue_asic_error(qdev);
 		netdev_err(qdev->ndev, "Got fatal error, STS = %x.\n", var);
-		var = ql_read32(qdev, ERR_STS);
+		var = qlge_read32(qdev, ERR_STS);
 		netdev_err(qdev->ndev, "Resetting chip. "
 					"Error Status Register = 0x%x\n", var);
 		return IRQ_HANDLED;
@@ -2440,14 +2440,14 @@ static irqreturn_t qlge_isr(int irq, void *dev_id)
 	 * Check MPI processor activity.
 	 */
 	if ((var & STS_PI) &&
-	    (ql_read32(qdev, INTR_MASK) & INTR_MASK_PI)) {
+	    (qlge_read32(qdev, INTR_MASK) & INTR_MASK_PI)) {
 		/*
 		 * We've got an async event or mailbox completion.
 		 * Handle it and clear the source of the interrupt.
 		 */
 		netif_err(qdev, intr, qdev->ndev,
 			  "Got MPI processor interrupt.\n");
-		ql_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
+		qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
 		queue_delayed_work_on(smp_processor_id(),
 				      qdev->workqueue, &qdev->mpi_work, 0);
 		work_done++;
@@ -2458,7 +2458,7 @@ static irqreturn_t qlge_isr(int irq, void *dev_id)
 	 * pass.  Compare it to the queues that this irq services
 	 * and call napi if there's a match.
 	 */
-	var = ql_read32(qdev, ISR1);
+	var = qlge_read32(qdev, ISR1);
 	if (var & intr_context->irq_mask) {
 		netif_info(qdev, intr, qdev->ndev,
 			   "Waking handler for rx_ring[0].\n");
@@ -2471,13 +2471,13 @@ static irqreturn_t qlge_isr(int irq, void *dev_id)
 		 * systematically re-enable the interrupt if we didn't
 		 * schedule napi.
 		 */
-		ql_enable_completion_interrupt(qdev, 0);
+		qlge_enable_completion_interrupt(qdev, 0);
 	}
 
 	return work_done ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int ql_tso(struct sk_buff *skb, struct ob_mac_tso_iocb_req *mac_iocb_ptr)
+static int qlge_tso(struct sk_buff *skb, struct qlge_ob_mac_tso_iocb_req *mac_iocb_ptr)
 {
 
 	if (skb_is_gso(skb)) {
@@ -2520,8 +2520,8 @@ static int ql_tso(struct sk_buff *skb, struct ob_mac_tso_iocb_req *mac_iocb_ptr)
 	return 0;
 }
 
-static void ql_hw_csum_setup(struct sk_buff *skb,
-			     struct ob_mac_tso_iocb_req *mac_iocb_ptr)
+static void qlge_hw_csum_setup(struct sk_buff *skb,
+			     struct qlge_ob_mac_tso_iocb_req *mac_iocb_ptr)
 {
 	int len;
 	struct iphdr *iph = ip_hdr(skb);
@@ -2554,11 +2554,11 @@ static void ql_hw_csum_setup(struct sk_buff *skb,
 
 static netdev_tx_t qlge_send(struct sk_buff *skb, struct net_device *ndev)
 {
-	struct tx_ring_desc *tx_ring_desc;
-	struct ob_mac_iocb_req *mac_iocb_ptr;
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_tx_ring_desc *tx_ring_desc;
+	struct qlge_ob_mac_iocb_req *mac_iocb_ptr;
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int tso;
-	struct tx_ring *tx_ring;
+	struct qlge_tx_ring *tx_ring;
 	u32 tx_ring_idx = (u32) skb->queue_mapping;
 
 	tx_ring = &qdev->tx_ring[tx_ring_idx];
@@ -2594,28 +2594,28 @@ static netdev_tx_t qlge_send(struct sk_buff *skb, struct net_device *ndev)
 		mac_iocb_ptr->flags3 |= OB_MAC_IOCB_V;
 		mac_iocb_ptr->vlan_tci = cpu_to_le16(skb_vlan_tag_get(skb));
 	}
-	tso = ql_tso(skb, (struct ob_mac_tso_iocb_req *)mac_iocb_ptr);
+	tso = qlge_tso(skb, (struct qlge_ob_mac_tso_iocb_req *)mac_iocb_ptr);
 	if (tso < 0) {
 		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	} else if (unlikely(!tso) && (skb->ip_summed == CHECKSUM_PARTIAL)) {
-		ql_hw_csum_setup(skb,
-				 (struct ob_mac_tso_iocb_req *)mac_iocb_ptr);
+		qlge_hw_csum_setup(skb,
+				 (struct qlge_ob_mac_tso_iocb_req *)mac_iocb_ptr);
 	}
-	if (ql_map_send(qdev, mac_iocb_ptr, skb, tx_ring_desc) !=
+	if (qlge_map_send(qdev, mac_iocb_ptr, skb, tx_ring_desc) !=
 			NETDEV_TX_OK) {
 		netif_err(qdev, tx_queued, qdev->ndev,
 			  "Could not map the segments.\n");
 		tx_ring->tx_errors++;
 		return NETDEV_TX_BUSY;
 	}
-	QL_DUMP_OB_MAC_IOCB(mac_iocb_ptr);
+	QLGE_DUMP_OB_MAC_IOCB(mac_iocb_ptr);
 	tx_ring->prod_idx++;
 	if (tx_ring->prod_idx == tx_ring->wq_len)
 		tx_ring->prod_idx = 0;
 	wmb();
 
-	ql_write_db_reg_relaxed(tx_ring->prod_idx, tx_ring->prod_idx_db_reg);
+	qlge_write_db_reg_relaxed(tx_ring->prod_idx, tx_ring->prod_idx_db_reg);
 	netif_printk(qdev, tx_queued, KERN_DEBUG, qdev->ndev,
 		     "tx queued, slot %d, len %d\n",
 		     tx_ring->prod_idx, skb->len);
@@ -2634,7 +2634,7 @@ static netdev_tx_t qlge_send(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
-static void ql_free_shadow_space(struct ql_adapter *qdev)
+static void qlge_free_shadow_space(struct qlge_adapter *qdev)
 {
 	if (qdev->rx_ring_shadow_reg_area) {
 		dma_free_coherent(&qdev->pdev->dev,
@@ -2652,7 +2652,7 @@ static void ql_free_shadow_space(struct ql_adapter *qdev)
 	}
 }
 
-static int ql_alloc_shadow_space(struct ql_adapter *qdev)
+static int qlge_alloc_shadow_space(struct qlge_adapter *qdev)
 {
 	qdev->rx_ring_shadow_reg_area =
 		dma_alloc_coherent(&qdev->pdev->dev, PAGE_SIZE,
@@ -2681,11 +2681,11 @@ static int ql_alloc_shadow_space(struct ql_adapter *qdev)
 	return -ENOMEM;
 }
 
-static void ql_init_tx_ring(struct ql_adapter *qdev, struct tx_ring *tx_ring)
+static void qlge_init_tx_ring(struct qlge_adapter *qdev, struct qlge_tx_ring *tx_ring)
 {
-	struct tx_ring_desc *tx_ring_desc;
+	struct qlge_tx_ring_desc *tx_ring_desc;
 	int i;
-	struct ob_mac_iocb_req *mac_iocb_ptr;
+	struct qlge_ob_mac_iocb_req *mac_iocb_ptr;
 
 	mac_iocb_ptr = tx_ring->wq_base;
 	tx_ring_desc = tx_ring->q;
@@ -2699,8 +2699,8 @@ static void ql_init_tx_ring(struct ql_adapter *qdev, struct tx_ring *tx_ring)
 	atomic_set(&tx_ring->tx_count, tx_ring->wq_len);
 }
 
-static void ql_free_tx_resources(struct ql_adapter *qdev,
-				 struct tx_ring *tx_ring)
+static void qlge_free_tx_resources(struct qlge_adapter *qdev,
+				 struct qlge_tx_ring *tx_ring)
 {
 	if (tx_ring->wq_base) {
 		dma_free_coherent(&qdev->pdev->dev, tx_ring->wq_size,
@@ -2711,8 +2711,8 @@ static void ql_free_tx_resources(struct ql_adapter *qdev,
 	tx_ring->q = NULL;
 }
 
-static int ql_alloc_tx_resources(struct ql_adapter *qdev,
-				 struct tx_ring *tx_ring)
+static int qlge_alloc_tx_resources(struct qlge_adapter *qdev,
+				 struct qlge_tx_ring *tx_ring)
 {
 	tx_ring->wq_base =
 	    dma_alloc_coherent(&qdev->pdev->dev, tx_ring->wq_size,
@@ -2723,7 +2723,7 @@ static int ql_alloc_tx_resources(struct ql_adapter *qdev,
 		goto pci_alloc_err;
 
 	tx_ring->q =
-	    kmalloc_array(tx_ring->wq_len, sizeof(struct tx_ring_desc),
+	    kmalloc_array(tx_ring->wq_len, sizeof(struct qlge_tx_ring_desc),
 			  GFP_KERNEL);
 	if (!tx_ring->q)
 		goto err;
@@ -2738,19 +2738,19 @@ static int ql_alloc_tx_resources(struct ql_adapter *qdev,
 	return -ENOMEM;
 }
 
-static void ql_free_lbq_buffers(struct ql_adapter *qdev, struct rx_ring *rx_ring)
+static void qlge_free_lbq_buffers(struct qlge_adapter *qdev, struct qlge_rx_ring *rx_ring)
 {
 	struct qlge_bq *lbq = &rx_ring->lbq;
 	unsigned int last_offset;
 
-	last_offset = ql_lbq_block_size(qdev) - qdev->lbq_buf_size;
+	last_offset = qlge_lbq_block_size(qdev) - qdev->lbq_buf_size;
 	while (lbq->next_to_clean != lbq->next_to_use) {
 		struct qlge_bq_desc *lbq_desc =
 			&lbq->queue[lbq->next_to_clean];
 
 		if (lbq_desc->p.pg_chunk.offset == last_offset)
 			dma_unmap_page(&qdev->pdev->dev, lbq_desc->dma_addr,
-				       ql_lbq_block_size(qdev),
+				       qlge_lbq_block_size(qdev),
 				       DMA_FROM_DEVICE);
 		put_page(lbq_desc->p.pg_chunk.page);
 
@@ -2759,13 +2759,13 @@ static void ql_free_lbq_buffers(struct ql_adapter *qdev, struct rx_ring *rx_ring
 
 	if (rx_ring->master_chunk.page) {
 		dma_unmap_page(&qdev->pdev->dev, rx_ring->chunk_dma_addr,
-			       ql_lbq_block_size(qdev), DMA_FROM_DEVICE);
+			       qlge_lbq_block_size(qdev), DMA_FROM_DEVICE);
 		put_page(rx_ring->master_chunk.page);
 		rx_ring->master_chunk.page = NULL;
 	}
 }
 
-static void ql_free_sbq_buffers(struct ql_adapter *qdev, struct rx_ring *rx_ring)
+static void qlge_free_sbq_buffers(struct qlge_adapter *qdev, struct qlge_rx_ring *rx_ring)
 {
 	int i;
 
@@ -2790,33 +2790,33 @@ static void ql_free_sbq_buffers(struct ql_adapter *qdev, struct rx_ring *rx_ring
 /* Free all large and small rx buffers associated
  * with the completion queues for this device.
  */
-static void ql_free_rx_buffers(struct ql_adapter *qdev)
+static void qlge_free_rx_buffers(struct qlge_adapter *qdev)
 {
 	int i;
 
 	for (i = 0; i < qdev->rx_ring_count; i++) {
-		struct rx_ring *rx_ring = &qdev->rx_ring[i];
+		struct qlge_rx_ring *rx_ring = &qdev->rx_ring[i];
 
 		if (rx_ring->lbq.queue)
-			ql_free_lbq_buffers(qdev, rx_ring);
+			qlge_free_lbq_buffers(qdev, rx_ring);
 		if (rx_ring->sbq.queue)
-			ql_free_sbq_buffers(qdev, rx_ring);
+			qlge_free_sbq_buffers(qdev, rx_ring);
 	}
 }
 
-static void ql_alloc_rx_buffers(struct ql_adapter *qdev)
+static void qlge_alloc_rx_buffers(struct qlge_adapter *qdev)
 {
 	int i;
 
 	for (i = 0; i < qdev->rss_ring_count; i++)
-		ql_update_buffer_queues(&qdev->rx_ring[i], GFP_KERNEL,
+		qlge_update_buffer_queues(&qdev->rx_ring[i], GFP_KERNEL,
 					HZ / 2);
 }
 
 static int qlge_init_bq(struct qlge_bq *bq)
 {
-	struct rx_ring *rx_ring = QLGE_BQ_CONTAINER(bq);
-	struct ql_adapter *qdev = rx_ring->qdev;
+	struct qlge_rx_ring *rx_ring = QLGE_BQ_CONTAINER(bq);
+	struct qlge_adapter *qdev = rx_ring->qdev;
 	struct qlge_bq_desc *bq_desc;
 	__le64 *buf_ptr;
 	int i;
@@ -2846,8 +2846,8 @@ static int qlge_init_bq(struct qlge_bq *bq)
 	return 0;
 }
 
-static void ql_free_rx_resources(struct ql_adapter *qdev,
-				 struct rx_ring *rx_ring)
+static void qlge_free_rx_resources(struct qlge_adapter *qdev,
+				 struct qlge_rx_ring *rx_ring)
 {
 	/* Free the small buffer queue. */
 	if (rx_ring->sbq.base) {
@@ -2883,8 +2883,8 @@ static void ql_free_rx_resources(struct ql_adapter *qdev,
 /* Allocate queues and buffers for this completions queue based
  * on the values in the parameter structure.
  */
-static int ql_alloc_rx_resources(struct ql_adapter *qdev,
-				 struct rx_ring *rx_ring)
+static int qlge_alloc_rx_resources(struct qlge_adapter *qdev,
+				 struct qlge_rx_ring *rx_ring)
 {
 
 	/*
@@ -2901,17 +2901,17 @@ static int ql_alloc_rx_resources(struct ql_adapter *qdev,
 
 	if (rx_ring->cq_id < qdev->rss_ring_count &&
 	    (qlge_init_bq(&rx_ring->sbq) || qlge_init_bq(&rx_ring->lbq))) {
-		ql_free_rx_resources(qdev, rx_ring);
+		qlge_free_rx_resources(qdev, rx_ring);
 		return -ENOMEM;
 	}
 
 	return 0;
 }
 
-static void ql_tx_ring_clean(struct ql_adapter *qdev)
+static void qlge_tx_ring_clean(struct qlge_adapter *qdev)
 {
-	struct tx_ring *tx_ring;
-	struct tx_ring_desc *tx_ring_desc;
+	struct qlge_tx_ring *tx_ring;
+	struct qlge_tx_ring_desc *tx_ring_desc;
 	int i, j;
 
 	/*
@@ -2927,7 +2927,7 @@ static void ql_tx_ring_clean(struct ql_adapter *qdev)
 					  "Freeing lost SKB %p, from queue %d, index %d.\n",
 					  tx_ring_desc->skb, j,
 					  tx_ring_desc->index);
-				ql_unmap_send(qdev, tx_ring_desc,
+				qlge_unmap_send(qdev, tx_ring_desc,
 					      tx_ring_desc->map_cnt);
 				dev_kfree_skb(tx_ring_desc->skb);
 				tx_ring_desc->skb = NULL;
@@ -2936,27 +2936,27 @@ static void ql_tx_ring_clean(struct ql_adapter *qdev)
 	}
 }
 
-static void ql_free_mem_resources(struct ql_adapter *qdev)
+static void qlge_free_mem_resources(struct qlge_adapter *qdev)
 {
 	int i;
 
 	for (i = 0; i < qdev->tx_ring_count; i++)
-		ql_free_tx_resources(qdev, &qdev->tx_ring[i]);
+		qlge_free_tx_resources(qdev, &qdev->tx_ring[i]);
 	for (i = 0; i < qdev->rx_ring_count; i++)
-		ql_free_rx_resources(qdev, &qdev->rx_ring[i]);
-	ql_free_shadow_space(qdev);
+		qlge_free_rx_resources(qdev, &qdev->rx_ring[i]);
+	qlge_free_shadow_space(qdev);
 }
 
-static int ql_alloc_mem_resources(struct ql_adapter *qdev)
+static int qlge_alloc_mem_resources(struct qlge_adapter *qdev)
 {
 	int i;
 
 	/* Allocate space for our shadow registers and such. */
-	if (ql_alloc_shadow_space(qdev))
+	if (qlge_alloc_shadow_space(qdev))
 		return -ENOMEM;
 
 	for (i = 0; i < qdev->rx_ring_count; i++) {
-		if (ql_alloc_rx_resources(qdev, &qdev->rx_ring[i]) != 0) {
+		if (qlge_alloc_rx_resources(qdev, &qdev->rx_ring[i]) != 0) {
 			netif_err(qdev, ifup, qdev->ndev,
 				  "RX resource allocation failed.\n");
 			goto err_mem;
@@ -2964,7 +2964,7 @@ static int ql_alloc_mem_resources(struct ql_adapter *qdev)
 	}
 	/* Allocate tx queue resources */
 	for (i = 0; i < qdev->tx_ring_count; i++) {
-		if (ql_alloc_tx_resources(qdev, &qdev->tx_ring[i]) != 0) {
+		if (qlge_alloc_tx_resources(qdev, &qdev->tx_ring[i]) != 0) {
 			netif_err(qdev, ifup, qdev->ndev,
 				  "TX resource allocation failed.\n");
 			goto err_mem;
@@ -2973,7 +2973,7 @@ static int ql_alloc_mem_resources(struct ql_adapter *qdev)
 	return 0;
 
 err_mem:
-	ql_free_mem_resources(qdev);
+	qlge_free_mem_resources(qdev);
 	return -ENOMEM;
 }
 
@@ -2981,9 +2981,9 @@ static int ql_alloc_mem_resources(struct ql_adapter *qdev)
  * The control block is defined as
  * "Completion Queue Initialization Control Block", or cqicb.
  */
-static int ql_start_rx_ring(struct ql_adapter *qdev, struct rx_ring *rx_ring)
+static int qlge_start_rx_ring(struct qlge_adapter *qdev, struct qlge_rx_ring *rx_ring)
 {
-	struct cqicb *cqicb = &rx_ring->cqicb;
+	struct qlge_cqicb *cqicb = &rx_ring->cqicb;
 	void *shadow_reg = qdev->rx_ring_shadow_reg_area +
 		(rx_ring->cq_id * RX_RING_SHADOW_SPACE);
 	u64 shadow_reg_dma = qdev->rx_ring_shadow_reg_dma +
@@ -3022,7 +3022,7 @@ static int ql_start_rx_ring(struct ql_adapter *qdev, struct rx_ring *rx_ring)
 	/* PCI doorbell mem area + 0x1c */
 	rx_ring->sbq.prod_idx_db_reg = (u32 __iomem *)(doorbell_area + 0x1c);
 
-	memset((void *)cqicb, 0, sizeof(struct cqicb));
+	memset((void *)cqicb, 0, sizeof(struct qlge_cqicb));
 	cqicb->msix_vect = rx_ring->irq;
 
 	cqicb->len = cpu_to_le16(QLGE_FIT16(rx_ring->cq_len) | LEN_V |
@@ -3077,7 +3077,7 @@ static int ql_start_rx_ring(struct ql_adapter *qdev, struct rx_ring *rx_ring)
 		/* Inbound completion handling rx_rings run in
 		 * separate NAPI contexts.
 		 */
-		netif_napi_add(qdev->ndev, &rx_ring->napi, ql_napi_poll_msix,
+		netif_napi_add(qdev->ndev, &rx_ring->napi, qlge_napi_poll_msix,
 			       64);
 		cqicb->irq_delay = cpu_to_le16(qdev->rx_coalesce_usecs);
 		cqicb->pkt_delay = cpu_to_le16(qdev->rx_max_coalesced_frames);
@@ -3085,7 +3085,7 @@ static int ql_start_rx_ring(struct ql_adapter *qdev, struct rx_ring *rx_ring)
 		cqicb->irq_delay = cpu_to_le16(qdev->tx_coalesce_usecs);
 		cqicb->pkt_delay = cpu_to_le16(qdev->tx_max_coalesced_frames);
 	}
-	err = ql_write_cfg(qdev, cqicb, sizeof(struct cqicb),
+	err = qlge_write_cfg(qdev, cqicb, sizeof(struct qlge_cqicb),
 			   CFG_LCQ, rx_ring->cq_id);
 	if (err) {
 		netif_err(qdev, ifup, qdev->ndev, "Failed to load CQICB.\n");
@@ -3094,9 +3094,9 @@ static int ql_start_rx_ring(struct ql_adapter *qdev, struct rx_ring *rx_ring)
 	return err;
 }
 
-static int ql_start_tx_ring(struct ql_adapter *qdev, struct tx_ring *tx_ring)
+static int qlge_start_tx_ring(struct qlge_adapter *qdev, struct qlge_tx_ring *tx_ring)
 {
-	struct wqicb *wqicb = (struct wqicb *)tx_ring;
+	struct qlge_wqicb *wqicb = (struct qlge_wqicb *)tx_ring;
 	void __iomem *doorbell_area =
 	    qdev->doorbell_area + (DB_PAGE_SIZE * tx_ring->wq_id);
 	void *shadow_reg = qdev->tx_ring_shadow_reg_area +
@@ -3129,9 +3129,9 @@ static int ql_start_tx_ring(struct ql_adapter *qdev, struct tx_ring *tx_ring)
 
 	wqicb->cnsmr_idx_addr = cpu_to_le64(tx_ring->cnsmr_idx_sh_reg_dma);
 
-	ql_init_tx_ring(qdev, tx_ring);
+	qlge_init_tx_ring(qdev, tx_ring);
 
-	err = ql_write_cfg(qdev, wqicb, sizeof(*wqicb), CFG_LRQ,
+	err = qlge_write_cfg(qdev, wqicb, sizeof(*wqicb), CFG_LRQ,
 			   (u16) tx_ring->wq_id);
 	if (err) {
 		netif_err(qdev, ifup, qdev->ndev, "Failed to load tx_ring.\n");
@@ -3140,16 +3140,16 @@ static int ql_start_tx_ring(struct ql_adapter *qdev, struct tx_ring *tx_ring)
 	return err;
 }
 
-static void ql_disable_msix(struct ql_adapter *qdev)
+static void qlge_disable_msix(struct qlge_adapter *qdev)
 {
-	if (test_bit(QL_MSIX_ENABLED, &qdev->flags)) {
+	if (test_bit(QLGE_MSIX_ENABLED, &qdev->flags)) {
 		pci_disable_msix(qdev->pdev);
-		clear_bit(QL_MSIX_ENABLED, &qdev->flags);
+		clear_bit(QLGE_MSIX_ENABLED, &qdev->flags);
 		kfree(qdev->msi_x_entry);
 		qdev->msi_x_entry = NULL;
-	} else if (test_bit(QL_MSI_ENABLED, &qdev->flags)) {
+	} else if (test_bit(QLGE_MSI_ENABLED, &qdev->flags)) {
 		pci_disable_msi(qdev->pdev);
-		clear_bit(QL_MSI_ENABLED, &qdev->flags);
+		clear_bit(QLGE_MSI_ENABLED, &qdev->flags);
 	}
 }
 
@@ -3157,7 +3157,7 @@ static void ql_disable_msix(struct ql_adapter *qdev)
  * stored in qdev->intr_count. If we don't get that
  * many then we reduce the count and try again.
  */
-static void ql_enable_msix(struct ql_adapter *qdev)
+static void qlge_enable_msix(struct qlge_adapter *qdev)
 {
 	int i, err;
 
@@ -3187,7 +3187,7 @@ static void ql_enable_msix(struct ql_adapter *qdev)
 			qlge_irq_type = MSI_IRQ;
 		} else {
 			qdev->intr_count = err;
-			set_bit(QL_MSIX_ENABLED, &qdev->flags);
+			set_bit(QLGE_MSIX_ENABLED, &qdev->flags);
 			netif_info(qdev, ifup, qdev->ndev,
 				   "MSI-X Enabled, got %d vectors.\n",
 				   qdev->intr_count);
@@ -3198,14 +3198,14 @@ static void ql_enable_msix(struct ql_adapter *qdev)
 	qdev->intr_count = 1;
 	if (qlge_irq_type == MSI_IRQ) {
 		if (!pci_enable_msi(qdev->pdev)) {
-			set_bit(QL_MSI_ENABLED, &qdev->flags);
+			set_bit(QLGE_MSI_ENABLED, &qdev->flags);
 			netif_info(qdev, ifup, qdev->ndev,
 				   "Running with MSI interrupts.\n");
 			return;
 		}
 	}
 	qlge_irq_type = LEG_IRQ;
-	set_bit(QL_LEGACY_ENABLED, &qdev->flags);
+	set_bit(QLGE_LEGACY_ENABLED, &qdev->flags);
 	netif_printk(qdev, ifup, KERN_DEBUG, qdev->ndev,
 		     "Running with legacy interrupts.\n");
 }
@@ -3219,12 +3219,12 @@ static void ql_enable_msix(struct ql_adapter *qdev)
  * and TX completion rings 0,1,2 and 3.  Vector 1 would
  * service RSS ring 1 and TX completion rings 4,5,6 and 7.
  */
-static void ql_set_tx_vect(struct ql_adapter *qdev)
+static void qlge_set_tx_vect(struct qlge_adapter *qdev)
 {
 	int i, j, vect;
 	u32 tx_rings_per_vector = qdev->tx_ring_count / qdev->intr_count;
 
-	if (likely(test_bit(QL_MSIX_ENABLED, &qdev->flags))) {
+	if (likely(test_bit(QLGE_MSIX_ENABLED, &qdev->flags))) {
 		/* Assign irq vectors to TX rx_rings.*/
 		for (vect = 0, j = 0, i = qdev->rss_ring_count;
 					 i < qdev->rx_ring_count; i++) {
@@ -3249,12 +3249,12 @@ static void ql_set_tx_vect(struct ql_adapter *qdev)
  * rings.  This function sets up a bit mask per vector
  * that indicates which rings it services.
  */
-static void ql_set_irq_mask(struct ql_adapter *qdev, struct intr_context *ctx)
+static void qlge_set_irq_mask(struct qlge_adapter *qdev, struct qlge_intr_context *ctx)
 {
 	int j, vect = ctx->intr;
 	u32 tx_rings_per_vector = qdev->tx_ring_count / qdev->intr_count;
 
-	if (likely(test_bit(QL_MSIX_ENABLED, &qdev->flags))) {
+	if (likely(test_bit(QLGE_MSIX_ENABLED, &qdev->flags))) {
 		/* Add the RSS ring serviced by this vector
 		 * to the mask.
 		 */
@@ -3281,12 +3281,12 @@ static void ql_set_irq_mask(struct ql_adapter *qdev, struct intr_context *ctx)
  * The intr_context structure is used to hook each vector
  * to possibly different handlers.
  */
-static void ql_resolve_queues_to_irqs(struct ql_adapter *qdev)
+static void qlge_resolve_queues_to_irqs(struct qlge_adapter *qdev)
 {
 	int i = 0;
-	struct intr_context *intr_context = &qdev->intr_context[0];
+	struct qlge_intr_context *intr_context = &qdev->intr_context[0];
 
-	if (likely(test_bit(QL_MSIX_ENABLED, &qdev->flags))) {
+	if (likely(test_bit(QLGE_MSIX_ENABLED, &qdev->flags))) {
 		/* Each rx_ring has it's
 		 * own intr_context since we have separate
 		 * vectors for each queue.
@@ -3298,7 +3298,7 @@ static void ql_resolve_queues_to_irqs(struct ql_adapter *qdev)
 			/* Set up this vector's bit-mask that indicates
 			 * which queues it services.
 			 */
-			ql_set_irq_mask(qdev, intr_context);
+			qlge_set_irq_mask(qdev, intr_context);
 			/*
 			 * We set up each vectors enable/disable/read bits so
 			 * there's no bit/mask calculations in the critical path.
@@ -3349,7 +3349,7 @@ static void ql_resolve_queues_to_irqs(struct ql_adapter *qdev)
 		intr_context->intr_dis_mask =
 		    INTR_EN_TYPE_MASK | INTR_EN_INTR_MASK |
 		    INTR_EN_TYPE_DISABLE;
-		if (test_bit(QL_LEGACY_ENABLED, &qdev->flags)) {
+		if (test_bit(QLGE_LEGACY_ENABLED, &qdev->flags)) {
 			/* Experience shows that when using INTx interrupts,
 			 * the device does not always auto-mask INTR_EN_EN.
 			 * Moreover, masking INTR_EN_EN manually does not
@@ -3371,22 +3371,22 @@ static void ql_resolve_queues_to_irqs(struct ql_adapter *qdev)
 		 * a single vector so it will service all RSS and
 		 * TX completion rings.
 		 */
-		ql_set_irq_mask(qdev, intr_context);
+		qlge_set_irq_mask(qdev, intr_context);
 	}
 	/* Tell the TX completion rings which MSIx vector
 	 * they will be using.
 	 */
-	ql_set_tx_vect(qdev);
+	qlge_set_tx_vect(qdev);
 }
 
-static void ql_free_irq(struct ql_adapter *qdev)
+static void qlge_free_irq(struct qlge_adapter *qdev)
 {
 	int i;
-	struct intr_context *intr_context = &qdev->intr_context[0];
+	struct qlge_intr_context *intr_context = &qdev->intr_context[0];
 
 	for (i = 0; i < qdev->intr_count; i++, intr_context++) {
 		if (intr_context->hooked) {
-			if (test_bit(QL_MSIX_ENABLED, &qdev->flags)) {
+			if (test_bit(QLGE_MSIX_ENABLED, &qdev->flags)) {
 				free_irq(qdev->msi_x_entry[i].vector,
 					 &qdev->rx_ring[i]);
 			} else {
@@ -3394,20 +3394,20 @@ static void ql_free_irq(struct ql_adapter *qdev)
 			}
 		}
 	}
-	ql_disable_msix(qdev);
+	qlge_disable_msix(qdev);
 }
 
-static int ql_request_irq(struct ql_adapter *qdev)
+static int qlge_request_irq(struct qlge_adapter *qdev)
 {
 	int i;
 	int status = 0;
 	struct pci_dev *pdev = qdev->pdev;
-	struct intr_context *intr_context = &qdev->intr_context[0];
+	struct qlge_intr_context *intr_context = &qdev->intr_context[0];
 
-	ql_resolve_queues_to_irqs(qdev);
+	qlge_resolve_queues_to_irqs(qdev);
 
 	for (i = 0; i < qdev->intr_count; i++, intr_context++) {
-		if (test_bit(QL_MSIX_ENABLED, &qdev->flags)) {
+		if (test_bit(QLGE_MSIX_ENABLED, &qdev->flags)) {
 			status = request_irq(qdev->msi_x_entry[i].vector,
 					     intr_context->handler,
 					     0,
@@ -3432,7 +3432,7 @@ static int ql_request_irq(struct ql_adapter *qdev)
 				     &qdev->rx_ring[0]);
 			status =
 			    request_irq(pdev->irq, qlge_isr,
-					test_bit(QL_MSI_ENABLED,
+					test_bit(QLGE_MSI_ENABLED,
 						 &qdev->
 						 flags) ? 0 : IRQF_SHARED,
 					intr_context->name, &qdev->rx_ring[0]);
@@ -3448,11 +3448,11 @@ static int ql_request_irq(struct ql_adapter *qdev)
 	return status;
 err_irq:
 	netif_err(qdev, ifup, qdev->ndev, "Failed to get the interrupts!!!\n");
-	ql_free_irq(qdev);
+	qlge_free_irq(qdev);
 	return status;
 }
 
-static int ql_start_rss(struct ql_adapter *qdev)
+static int qlge_start_rss(struct qlge_adapter *qdev)
 {
 	static const u8 init_hash_seed[] = {
 		0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
@@ -3461,7 +3461,7 @@ static int ql_start_rss(struct ql_adapter *qdev)
 		0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
 		0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa
 	};
-	struct ricb *ricb = &qdev->ricb;
+	struct qlge_ricb *ricb = &qdev->ricb;
 	int status = 0;
 	int i;
 	u8 *hash_id = (u8 *) ricb->hash_cq_id;
@@ -3482,7 +3482,7 @@ static int ql_start_rss(struct ql_adapter *qdev)
 	memcpy((void *)&ricb->ipv6_hash_key[0], init_hash_seed, 40);
 	memcpy((void *)&ricb->ipv4_hash_key[0], init_hash_seed, 16);
 
-	status = ql_write_cfg(qdev, ricb, sizeof(*ricb), CFG_LR, 0);
+	status = qlge_write_cfg(qdev, ricb, sizeof(*ricb), CFG_LR, 0);
 	if (status) {
 		netif_err(qdev, ifup, qdev->ndev, "Failed to load RICB.\n");
 		return status;
@@ -3490,55 +3490,55 @@ static int ql_start_rss(struct ql_adapter *qdev)
 	return status;
 }
 
-static int ql_clear_routing_entries(struct ql_adapter *qdev)
+static int qlge_clear_routing_entries(struct qlge_adapter *qdev)
 {
 	int i, status = 0;
 
-	status = ql_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
 	if (status)
 		return status;
 	/* Clear all the entries in the routing table. */
 	for (i = 0; i < 16; i++) {
-		status = ql_set_routing_reg(qdev, i, 0, 0);
+		status = qlge_set_routing_reg(qdev, i, 0, 0);
 		if (status) {
 			netif_err(qdev, ifup, qdev->ndev,
 				  "Failed to init routing register for CAM packets.\n");
 			break;
 		}
 	}
-	ql_sem_unlock(qdev, SEM_RT_IDX_MASK);
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
 	return status;
 }
 
 /* Initialize the frame-to-queue routing. */
-static int ql_route_initialize(struct ql_adapter *qdev)
+static int qlge_route_initialize(struct qlge_adapter *qdev)
 {
 	int status = 0;
 
 	/* Clear all the entries in the routing table. */
-	status = ql_clear_routing_entries(qdev);
+	status = qlge_clear_routing_entries(qdev);
 	if (status)
 		return status;
 
-	status = ql_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
 	if (status)
 		return status;
 
-	status = ql_set_routing_reg(qdev, RT_IDX_IP_CSUM_ERR_SLOT,
+	status = qlge_set_routing_reg(qdev, RT_IDX_IP_CSUM_ERR_SLOT,
 				    RT_IDX_IP_CSUM_ERR, 1);
 	if (status) {
 		netif_err(qdev, ifup, qdev->ndev,
 			  "Failed to init routing register for IP CSUM error packets.\n");
 		goto exit;
 	}
-	status = ql_set_routing_reg(qdev, RT_IDX_TCP_UDP_CSUM_ERR_SLOT,
+	status = qlge_set_routing_reg(qdev, RT_IDX_TCP_UDP_CSUM_ERR_SLOT,
 				    RT_IDX_TU_CSUM_ERR, 1);
 	if (status) {
 		netif_err(qdev, ifup, qdev->ndev,
 			  "Failed to init routing register for TCP/UDP CSUM error packets.\n");
 		goto exit;
 	}
-	status = ql_set_routing_reg(qdev, RT_IDX_BCAST_SLOT, RT_IDX_BCAST, 1);
+	status = qlge_set_routing_reg(qdev, RT_IDX_BCAST_SLOT, RT_IDX_BCAST, 1);
 	if (status) {
 		netif_err(qdev, ifup, qdev->ndev,
 			  "Failed to init routing register for broadcast packets.\n");
@@ -3548,7 +3548,7 @@ static int ql_route_initialize(struct ql_adapter *qdev)
 	 * routing block.
 	 */
 	if (qdev->rss_ring_count > 1) {
-		status = ql_set_routing_reg(qdev, RT_IDX_RSS_MATCH_SLOT,
+		status = qlge_set_routing_reg(qdev, RT_IDX_RSS_MATCH_SLOT,
 					    RT_IDX_RSS_MATCH, 1);
 		if (status) {
 			netif_err(qdev, ifup, qdev->ndev,
@@ -3557,17 +3557,17 @@ static int ql_route_initialize(struct ql_adapter *qdev)
 		}
 	}
 
-	status = ql_set_routing_reg(qdev, RT_IDX_CAM_HIT_SLOT,
+	status = qlge_set_routing_reg(qdev, RT_IDX_CAM_HIT_SLOT,
 				    RT_IDX_CAM_HIT, 1);
 	if (status)
 		netif_err(qdev, ifup, qdev->ndev,
 			  "Failed to init routing register for CAM packets.\n");
 exit:
-	ql_sem_unlock(qdev, SEM_RT_IDX_MASK);
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
 	return status;
 }
 
-int ql_cam_route_initialize(struct ql_adapter *qdev)
+int qlge_cam_route_initialize(struct qlge_adapter *qdev)
 {
 	int status, set;
 
@@ -3575,22 +3575,22 @@ int ql_cam_route_initialize(struct ql_adapter *qdev)
 	 * determine if we are setting or clearing
 	 * the MAC address in the CAM.
 	 */
-	set = ql_read32(qdev, STS);
+	set = qlge_read32(qdev, STS);
 	set &= qdev->port_link_up;
-	status = ql_set_mac_addr(qdev, set);
+	status = qlge_set_mac_addr(qdev, set);
 	if (status) {
 		netif_err(qdev, ifup, qdev->ndev, "Failed to init mac address.\n");
 		return status;
 	}
 
-	status = ql_route_initialize(qdev);
+	status = qlge_route_initialize(qdev);
 	if (status)
 		netif_err(qdev, ifup, qdev->ndev, "Failed to init routing table.\n");
 
 	return status;
 }
 
-static int ql_adapter_initialize(struct ql_adapter *qdev)
+static int qlge_adapter_initialize(struct qlge_adapter *qdev)
 {
 	u32 value, mask;
 	int i;
@@ -3601,7 +3601,7 @@ static int ql_adapter_initialize(struct ql_adapter *qdev)
 	 */
 	value = SYS_EFE | SYS_FAE;
 	mask = value << 16;
-	ql_write32(qdev, SYS, mask | value);
+	qlge_write32(qdev, SYS, mask | value);
 
 	/* Set the default queue, and VLAN behavior. */
 	value = NIC_RCV_CFG_DFQ;
@@ -3610,10 +3610,10 @@ static int ql_adapter_initialize(struct ql_adapter *qdev)
 		value |= NIC_RCV_CFG_RV;
 		mask |= (NIC_RCV_CFG_RV << 16);
 	}
-	ql_write32(qdev, NIC_RCV_CFG, (mask | value));
+	qlge_write32(qdev, NIC_RCV_CFG, (mask | value));
 
 	/* Set the MPI interrupt to enabled. */
-	ql_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16) | INTR_MASK_PI);
+	qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16) | INTR_MASK_PI);
 
 	/* Enable the function, set pagesize, enable error checking. */
 	value = FSC_FE | FSC_EPC_INBOUND | FSC_EPC_OUTBOUND |
@@ -3623,27 +3623,27 @@ static int ql_adapter_initialize(struct ql_adapter *qdev)
 	/* Set/clear header splitting. */
 	mask = FSC_VM_PAGESIZE_MASK |
 	    FSC_DBL_MASK | FSC_DBRST_MASK | (value << 16);
-	ql_write32(qdev, FSC, mask | value);
+	qlge_write32(qdev, FSC, mask | value);
 
-	ql_write32(qdev, SPLT_HDR, SPLT_LEN);
+	qlge_write32(qdev, SPLT_HDR, SPLT_LEN);
 
 	/* Set RX packet routing to use port/pci function on which the
 	 * packet arrived on in addition to usual frame routing.
 	 * This is helpful on bonding where both interfaces can have
 	 * the same MAC address.
 	 */
-	ql_write32(qdev, RST_FO, RST_FO_RR_MASK | RST_FO_RR_RCV_FUNC_CQ);
+	qlge_write32(qdev, RST_FO, RST_FO_RR_MASK | RST_FO_RR_RCV_FUNC_CQ);
 	/* Reroute all packets to our Interface.
 	 * They may have been routed to MPI firmware
 	 * due to WOL.
 	 */
-	value = ql_read32(qdev, MGMT_RCV_CFG);
+	value = qlge_read32(qdev, MGMT_RCV_CFG);
 	value &= ~MGMT_RCV_CFG_RM;
 	mask = 0xffff0000;
 
 	/* Sticky reg needs clearing due to WOL. */
-	ql_write32(qdev, MGMT_RCV_CFG, mask);
-	ql_write32(qdev, MGMT_RCV_CFG, mask | value);
+	qlge_write32(qdev, MGMT_RCV_CFG, mask);
+	qlge_write32(qdev, MGMT_RCV_CFG, mask | value);
 
 	/* Default WOL is enable on Mezz cards */
 	if (qdev->pdev->subsystem_device == 0x0068 ||
@@ -3652,7 +3652,7 @@ static int ql_adapter_initialize(struct ql_adapter *qdev)
 
 	/* Start up the rx queues. */
 	for (i = 0; i < qdev->rx_ring_count; i++) {
-		status = ql_start_rx_ring(qdev, &qdev->rx_ring[i]);
+		status = qlge_start_rx_ring(qdev, &qdev->rx_ring[i]);
 		if (status) {
 			netif_err(qdev, ifup, qdev->ndev,
 				  "Failed to start rx ring[%d].\n", i);
@@ -3664,7 +3664,7 @@ static int ql_adapter_initialize(struct ql_adapter *qdev)
 	 * then download a RICB to configure RSS.
 	 */
 	if (qdev->rss_ring_count > 1) {
-		status = ql_start_rss(qdev);
+		status = qlge_start_rss(qdev);
 		if (status) {
 			netif_err(qdev, ifup, qdev->ndev, "Failed to start RSS.\n");
 			return status;
@@ -3673,7 +3673,7 @@ static int ql_adapter_initialize(struct ql_adapter *qdev)
 
 	/* Start up the tx queues. */
 	for (i = 0; i < qdev->tx_ring_count; i++) {
-		status = ql_start_tx_ring(qdev, &qdev->tx_ring[i]);
+		status = qlge_start_tx_ring(qdev, &qdev->tx_ring[i]);
 		if (status) {
 			netif_err(qdev, ifup, qdev->ndev,
 				  "Failed to start tx ring[%d].\n", i);
@@ -3687,7 +3687,7 @@ static int ql_adapter_initialize(struct ql_adapter *qdev)
 		netif_err(qdev, ifup, qdev->ndev, "Failed to start port.\n");
 
 	/* Set up the MAC address and frame routing filter. */
-	status = ql_cam_route_initialize(qdev);
+	status = qlge_cam_route_initialize(qdev);
 	if (status) {
 		netif_err(qdev, ifup, qdev->ndev,
 			  "Failed to init CAM/Routing tables.\n");
@@ -3702,14 +3702,14 @@ static int ql_adapter_initialize(struct ql_adapter *qdev)
 }
 
 /* Issue soft reset to chip. */
-static int ql_adapter_reset(struct ql_adapter *qdev)
+static int qlge_adapter_reset(struct qlge_adapter *qdev)
 {
 	u32 value;
 	int status = 0;
 	unsigned long end_jiffies;
 
 	/* Clear all the entries in the routing table. */
-	status = ql_clear_routing_entries(qdev);
+	status = qlge_clear_routing_entries(qdev);
 	if (status) {
 		netif_err(qdev, ifup, qdev->ndev, "Failed to clear routing bits.\n");
 		return status;
@@ -3718,21 +3718,21 @@ static int ql_adapter_reset(struct ql_adapter *qdev)
 	/* Check if bit is set then skip the mailbox command and
 	 * clear the bit, else we are in normal reset process.
 	 */
-	if (!test_bit(QL_ASIC_RECOVERY, &qdev->flags)) {
+	if (!test_bit(QLGE_ASIC_RECOVERY, &qdev->flags)) {
 		/* Stop management traffic. */
-		ql_mb_set_mgmnt_traffic_ctl(qdev, MB_SET_MPI_TFK_STOP);
+		qlge_mb_set_mgmnt_traffic_ctl(qdev, MB_SET_MPI_TFK_STOP);
 
 		/* Wait for the NIC and MGMNT FIFOs to empty. */
-		ql_wait_fifo_empty(qdev);
+		qlge_wait_fifo_empty(qdev);
 	} else {
-		clear_bit(QL_ASIC_RECOVERY, &qdev->flags);
+		clear_bit(QLGE_ASIC_RECOVERY, &qdev->flags);
 	}
 
-	ql_write32(qdev, RST_FO, (RST_FO_FR << 16) | RST_FO_FR);
+	qlge_write32(qdev, RST_FO, (RST_FO_FR << 16) | RST_FO_FR);
 
 	end_jiffies = jiffies + usecs_to_jiffies(30);
 	do {
-		value = ql_read32(qdev, RST_FO);
+		value = qlge_read32(qdev, RST_FO);
 		if ((value & RST_FO_FR) == 0)
 			break;
 		cpu_relax();
@@ -3745,13 +3745,13 @@ static int ql_adapter_reset(struct ql_adapter *qdev)
 	}
 
 	/* Resume management traffic. */
-	ql_mb_set_mgmnt_traffic_ctl(qdev, MB_SET_MPI_TFK_RESUME);
+	qlge_mb_set_mgmnt_traffic_ctl(qdev, MB_SET_MPI_TFK_RESUME);
 	return status;
 }
 
-static void ql_display_dev_info(struct net_device *ndev)
+static void qlge_display_dev_info(struct net_device *ndev)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	netif_info(qdev, probe, qdev->ndev,
 		   "Function #%d, Port %d, NIC Roll %d, NIC Rev = %d, "
@@ -3766,7 +3766,7 @@ static void ql_display_dev_info(struct net_device *ndev)
 		   "MAC address %pM\n", ndev->dev_addr);
 }
 
-static int ql_wol(struct ql_adapter *qdev)
+static int qlge_wol(struct qlge_adapter *qdev)
 {
 	int status = 0;
 	u32 wol = MB_WOL_DISABLE;
@@ -3787,7 +3787,7 @@ static int ql_wol(struct ql_adapter *qdev)
 	}
 
 	if (qdev->wol & WAKE_MAGIC) {
-		status = ql_mb_wol_set_magic(qdev, 1);
+		status = qlge_mb_wol_set_magic(qdev, 1);
 		if (status) {
 			netif_err(qdev, ifdown, qdev->ndev,
 				  "Failed to set magic packet on %s.\n",
@@ -3803,7 +3803,7 @@ static int ql_wol(struct ql_adapter *qdev)
 
 	if (qdev->wol) {
 		wol |= MB_WOL_MODE_ON;
-		status = ql_mb_wol_mode(qdev, wol);
+		status = qlge_mb_wol_mode(qdev, wol);
 		netif_err(qdev, drv, qdev->ndev,
 			  "WOL %s (wol code 0x%x) on %s\n",
 			  (status == 0) ? "Successfully set" : "Failed",
@@ -3813,13 +3813,13 @@ static int ql_wol(struct ql_adapter *qdev)
 	return status;
 }
 
-static void ql_cancel_all_work_sync(struct ql_adapter *qdev)
+static void qlge_cancel_all_work_sync(struct qlge_adapter *qdev)
 {
 
 	/* Don't kill the reset worker thread if we
 	 * are in the process of recovery.
 	 */
-	if (test_bit(QL_ADAPTER_UP, &qdev->flags))
+	if (test_bit(QLGE_ADAPTER_UP, &qdev->flags))
 		cancel_delayed_work_sync(&qdev->asic_reset_work);
 	cancel_delayed_work_sync(&qdev->mpi_reset_work);
 	cancel_delayed_work_sync(&qdev->mpi_work);
@@ -3828,99 +3828,99 @@ static void ql_cancel_all_work_sync(struct ql_adapter *qdev)
 	cancel_delayed_work_sync(&qdev->mpi_port_cfg_work);
 }
 
-static int ql_adapter_down(struct ql_adapter *qdev)
+static int qlge_adapter_down(struct qlge_adapter *qdev)
 {
 	int i, status = 0;
 
-	ql_link_off(qdev);
+	qlge_link_off(qdev);
 
-	ql_cancel_all_work_sync(qdev);
+	qlge_cancel_all_work_sync(qdev);
 
 	for (i = 0; i < qdev->rss_ring_count; i++)
 		napi_disable(&qdev->rx_ring[i].napi);
 
-	clear_bit(QL_ADAPTER_UP, &qdev->flags);
+	clear_bit(QLGE_ADAPTER_UP, &qdev->flags);
 
-	ql_disable_interrupts(qdev);
+	qlge_disable_interrupts(qdev);
 
-	ql_tx_ring_clean(qdev);
+	qlge_tx_ring_clean(qdev);
 
 	/* Call netif_napi_del() from common point.
 	 */
 	for (i = 0; i < qdev->rss_ring_count; i++)
 		netif_napi_del(&qdev->rx_ring[i].napi);
 
-	status = ql_adapter_reset(qdev);
+	status = qlge_adapter_reset(qdev);
 	if (status)
 		netif_err(qdev, ifdown, qdev->ndev, "reset(func #%d) FAILED!\n",
 			  qdev->func);
-	ql_free_rx_buffers(qdev);
+	qlge_free_rx_buffers(qdev);
 
 	return status;
 }
 
-static int ql_adapter_up(struct ql_adapter *qdev)
+static int qlge_adapter_up(struct qlge_adapter *qdev)
 {
 	int err = 0;
 
-	err = ql_adapter_initialize(qdev);
+	err = qlge_adapter_initialize(qdev);
 	if (err) {
 		netif_info(qdev, ifup, qdev->ndev, "Unable to initialize adapter.\n");
 		goto err_init;
 	}
-	set_bit(QL_ADAPTER_UP, &qdev->flags);
-	ql_alloc_rx_buffers(qdev);
+	set_bit(QLGE_ADAPTER_UP, &qdev->flags);
+	qlge_alloc_rx_buffers(qdev);
 	/* If the port is initialized and the
 	 * link is up the turn on the carrier.
 	 */
-	if ((ql_read32(qdev, STS) & qdev->port_init) &&
-	    (ql_read32(qdev, STS) & qdev->port_link_up))
-		ql_link_on(qdev);
+	if ((qlge_read32(qdev, STS) & qdev->port_init) &&
+	    (qlge_read32(qdev, STS) & qdev->port_link_up))
+		qlge_link_on(qdev);
 	/* Restore rx mode. */
-	clear_bit(QL_ALLMULTI, &qdev->flags);
-	clear_bit(QL_PROMISCUOUS, &qdev->flags);
+	clear_bit(QLGE_ALLMULTI, &qdev->flags);
+	clear_bit(QLGE_PROMISCUOUS, &qdev->flags);
 	qlge_set_multicast_list(qdev->ndev);
 
 	/* Restore vlan setting. */
 	qlge_restore_vlan(qdev);
 
-	ql_enable_interrupts(qdev);
-	ql_enable_all_completion_interrupts(qdev);
+	qlge_enable_interrupts(qdev);
+	qlge_enable_all_completion_interrupts(qdev);
 	netif_tx_start_all_queues(qdev->ndev);
 
 	return 0;
 err_init:
-	ql_adapter_reset(qdev);
+	qlge_adapter_reset(qdev);
 	return err;
 }
 
-static void ql_release_adapter_resources(struct ql_adapter *qdev)
+static void qlge_release_adapter_resources(struct qlge_adapter *qdev)
 {
-	ql_free_mem_resources(qdev);
-	ql_free_irq(qdev);
+	qlge_free_mem_resources(qdev);
+	qlge_free_irq(qdev);
 }
 
-static int ql_get_adapter_resources(struct ql_adapter *qdev)
+static int qlge_get_adapter_resources(struct qlge_adapter *qdev)
 {
-	if (ql_alloc_mem_resources(qdev)) {
+	if (qlge_alloc_mem_resources(qdev)) {
 		netif_err(qdev, ifup, qdev->ndev, "Unable to  allocate memory.\n");
 		return -ENOMEM;
 	}
-	return ql_request_irq(qdev);
+	return qlge_request_irq(qdev);
 }
 
 static int qlge_close(struct net_device *ndev)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int i;
 
 	/* If we hit pci_channel_io_perm_failure
 	 * failure condition, then we already
 	 * brought the adapter down.
 	 */
-	if (test_bit(QL_EEH_FATAL, &qdev->flags)) {
+	if (test_bit(QLGE_EEH_FATAL, &qdev->flags)) {
 		netif_err(qdev, drv, qdev->ndev, "EEH fatal did unload.\n");
-		clear_bit(QL_EEH_FATAL, &qdev->flags);
+		clear_bit(QLGE_EEH_FATAL, &qdev->flags);
 		return 0;
 	}
 
@@ -3928,19 +3928,19 @@ static int qlge_close(struct net_device *ndev)
 	 * Wait for device to recover from a reset.
 	 * (Rarely happens, but possible.)
 	 */
-	while (!test_bit(QL_ADAPTER_UP, &qdev->flags))
+	while (!test_bit(QLGE_ADAPTER_UP, &qdev->flags))
 		msleep(1);
 
 	/* Make sure refill_work doesn't re-enable napi */
 	for (i = 0; i < qdev->rss_ring_count; i++)
 		cancel_delayed_work_sync(&qdev->rx_ring[i].refill_work);
 
-	ql_adapter_down(qdev);
-	ql_release_adapter_resources(qdev);
+	qlge_adapter_down(qdev);
+	qlge_release_adapter_resources(qdev);
 	return 0;
 }
 
-static void qlge_set_lb_size(struct ql_adapter *qdev)
+static void qlge_set_lb_size(struct qlge_adapter *qdev)
 {
 	if (qdev->ndev->mtu <= 1500)
 		qdev->lbq_buf_size = LARGE_BUFFER_MIN_SIZE;
@@ -3949,22 +3949,22 @@ static void qlge_set_lb_size(struct ql_adapter *qdev)
 	qdev->lbq_buf_order = get_order(qdev->lbq_buf_size);
 }
 
-static int ql_configure_rings(struct ql_adapter *qdev)
+static int qlge_configure_rings(struct qlge_adapter *qdev)
 {
 	int i;
-	struct rx_ring *rx_ring;
-	struct tx_ring *tx_ring;
+	struct qlge_rx_ring *rx_ring;
+	struct qlge_tx_ring *tx_ring;
 	int cpu_cnt = min(MAX_CPUS, (int)num_online_cpus());
 
 	/* In a perfect world we have one RSS ring for each CPU
 	 * and each has it's own vector.  To do that we ask for
-	 * cpu_cnt vectors.  ql_enable_msix() will adjust the
+	 * cpu_cnt vectors.  qlge_enable_msix() will adjust the
 	 * vector count to what we actually get.  We then
 	 * allocate an RSS ring for each.
 	 * Essentially, we are doing min(cpu_count, msix_vector_count).
 	 */
 	qdev->intr_count = cpu_cnt;
-	ql_enable_msix(qdev);
+	qlge_enable_msix(qdev);
 	/* Adjust the RSS ring count to the actual vector count. */
 	qdev->rss_ring_count = qdev->intr_count;
 	qdev->tx_ring_count = cpu_cnt;
@@ -3977,7 +3977,7 @@ static int ql_configure_rings(struct ql_adapter *qdev)
 		tx_ring->wq_id = i;
 		tx_ring->wq_len = qdev->tx_ring_size;
 		tx_ring->wq_size =
-		    tx_ring->wq_len * sizeof(struct ob_mac_iocb_req);
+		    tx_ring->wq_len * sizeof(struct qlge_ob_mac_iocb_req);
 
 		/*
 		 * The completion queue ID for the tx rings start
@@ -3998,7 +3998,7 @@ static int ql_configure_rings(struct ql_adapter *qdev)
 			 */
 			rx_ring->cq_len = qdev->rx_ring_size;
 			rx_ring->cq_size =
-			    rx_ring->cq_len * sizeof(struct ql_net_rsp_iocb);
+			    rx_ring->cq_len * sizeof(struct qlge_net_rsp_iocb);
 			rx_ring->lbq.type = QLGE_LB;
 			rx_ring->sbq.type = QLGE_SB;
 			INIT_DELAYED_WORK(&rx_ring->refill_work,
@@ -4010,7 +4010,7 @@ static int ql_configure_rings(struct ql_adapter *qdev)
 			/* outbound cq is same size as tx_ring it services. */
 			rx_ring->cq_len = qdev->tx_ring_size;
 			rx_ring->cq_size =
-			    rx_ring->cq_len * sizeof(struct ql_net_rsp_iocb);
+			    rx_ring->cq_len * sizeof(struct qlge_net_rsp_iocb);
 		}
 	}
 	return 0;
@@ -4019,41 +4019,41 @@ static int ql_configure_rings(struct ql_adapter *qdev)
 static int qlge_open(struct net_device *ndev)
 {
 	int err = 0;
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
-	err = ql_adapter_reset(qdev);
+	err = qlge_adapter_reset(qdev);
 	if (err)
 		return err;
 
 	qlge_set_lb_size(qdev);
-	err = ql_configure_rings(qdev);
+	err = qlge_configure_rings(qdev);
 	if (err)
 		return err;
 
-	err = ql_get_adapter_resources(qdev);
+	err = qlge_get_adapter_resources(qdev);
 	if (err)
 		goto error_up;
 
-	err = ql_adapter_up(qdev);
+	err = qlge_adapter_up(qdev);
 	if (err)
 		goto error_up;
 
 	return err;
 
 error_up:
-	ql_release_adapter_resources(qdev);
+	qlge_release_adapter_resources(qdev);
 	return err;
 }
 
-static int ql_change_rx_buffers(struct ql_adapter *qdev)
+static int qlge_change_rx_buffers(struct qlge_adapter *qdev)
 {
 	int status;
 
 	/* Wait for an outstanding reset to complete. */
-	if (!test_bit(QL_ADAPTER_UP, &qdev->flags)) {
+	if (!test_bit(QLGE_ADAPTER_UP, &qdev->flags)) {
 		int i = 4;
 
-		while (--i && !test_bit(QL_ADAPTER_UP, &qdev->flags)) {
+		while (--i && !test_bit(QLGE_ADAPTER_UP, &qdev->flags)) {
 			netif_err(qdev, ifup, qdev->ndev,
 				  "Waiting for adapter UP...\n");
 			ssleep(1);
@@ -4066,13 +4066,13 @@ static int ql_change_rx_buffers(struct ql_adapter *qdev)
 		}
 	}
 
-	status = ql_adapter_down(qdev);
+	status = qlge_adapter_down(qdev);
 	if (status)
 		goto error;
 
 	qlge_set_lb_size(qdev);
 
-	status = ql_adapter_up(qdev);
+	status = qlge_adapter_up(qdev);
 	if (status)
 		goto error;
 
@@ -4080,14 +4080,14 @@ static int ql_change_rx_buffers(struct ql_adapter *qdev)
 error:
 	netif_alert(qdev, ifup, qdev->ndev,
 		    "Driver up/down cycle failed, closing device.\n");
-	set_bit(QL_ADAPTER_UP, &qdev->flags);
+	set_bit(QLGE_ADAPTER_UP, &qdev->flags);
 	dev_close(qdev->ndev);
 	return status;
 }
 
 static int qlge_change_mtu(struct net_device *ndev, int new_mtu)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int status;
 
 	if (ndev->mtu == 1500 && new_mtu == 9000)
@@ -4105,7 +4105,7 @@ static int qlge_change_mtu(struct net_device *ndev, int new_mtu)
 	if (!netif_running(qdev->ndev))
 		return 0;
 
-	status = ql_change_rx_buffers(qdev);
+	status = qlge_change_rx_buffers(qdev);
 	if (status) {
 		netif_err(qdev, ifup, qdev->ndev,
 			  "Changing MTU failed.\n");
@@ -4117,9 +4117,9 @@ static int qlge_change_mtu(struct net_device *ndev, int new_mtu)
 static struct net_device_stats *qlge_get_stats(struct net_device
 					       *ndev)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
-	struct rx_ring *rx_ring = &qdev->rx_ring[0];
-	struct tx_ring *tx_ring = &qdev->tx_ring[0];
+	struct qlge_adapter *qdev = netdev_priv(ndev);
+	struct qlge_rx_ring *rx_ring = &qdev->rx_ring[0];
+	struct qlge_tx_ring *tx_ring = &qdev->tx_ring[0];
 	unsigned long pkts, mcast, dropped, errors, bytes;
 	int i;
 
@@ -4153,11 +4153,11 @@ static struct net_device_stats *qlge_get_stats(struct net_device
 
 static void qlge_set_multicast_list(struct net_device *ndev)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	struct netdev_hw_addr *ha;
 	int i, status;
 
-	status = ql_sem_spinlock(qdev, SEM_RT_IDX_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_RT_IDX_MASK);
 	if (status)
 		return;
 	/*
@@ -4165,23 +4165,23 @@ static void qlge_set_multicast_list(struct net_device *ndev)
 	 * transition is taking place.
 	 */
 	if (ndev->flags & IFF_PROMISC) {
-		if (!test_bit(QL_PROMISCUOUS, &qdev->flags)) {
-			if (ql_set_routing_reg
+		if (!test_bit(QLGE_PROMISCUOUS, &qdev->flags)) {
+			if (qlge_set_routing_reg
 			    (qdev, RT_IDX_PROMISCUOUS_SLOT, RT_IDX_VALID, 1)) {
 				netif_err(qdev, hw, qdev->ndev,
 					  "Failed to set promiscuous mode.\n");
 			} else {
-				set_bit(QL_PROMISCUOUS, &qdev->flags);
+				set_bit(QLGE_PROMISCUOUS, &qdev->flags);
 			}
 		}
 	} else {
-		if (test_bit(QL_PROMISCUOUS, &qdev->flags)) {
-			if (ql_set_routing_reg
+		if (test_bit(QLGE_PROMISCUOUS, &qdev->flags)) {
+			if (qlge_set_routing_reg
 			    (qdev, RT_IDX_PROMISCUOUS_SLOT, RT_IDX_VALID, 0)) {
 				netif_err(qdev, hw, qdev->ndev,
 					  "Failed to clear promiscuous mode.\n");
 			} else {
-				clear_bit(QL_PROMISCUOUS, &qdev->flags);
+				clear_bit(QLGE_PROMISCUOUS, &qdev->flags);
 			}
 		}
 	}
@@ -4192,58 +4192,58 @@ static void qlge_set_multicast_list(struct net_device *ndev)
 	 */
 	if ((ndev->flags & IFF_ALLMULTI) ||
 	    (netdev_mc_count(ndev) > MAX_MULTICAST_ENTRIES)) {
-		if (!test_bit(QL_ALLMULTI, &qdev->flags)) {
-			if (ql_set_routing_reg
+		if (!test_bit(QLGE_ALLMULTI, &qdev->flags)) {
+			if (qlge_set_routing_reg
 			    (qdev, RT_IDX_ALLMULTI_SLOT, RT_IDX_MCAST, 1)) {
 				netif_err(qdev, hw, qdev->ndev,
 					  "Failed to set all-multi mode.\n");
 			} else {
-				set_bit(QL_ALLMULTI, &qdev->flags);
+				set_bit(QLGE_ALLMULTI, &qdev->flags);
 			}
 		}
 	} else {
-		if (test_bit(QL_ALLMULTI, &qdev->flags)) {
-			if (ql_set_routing_reg
+		if (test_bit(QLGE_ALLMULTI, &qdev->flags)) {
+			if (qlge_set_routing_reg
 			    (qdev, RT_IDX_ALLMULTI_SLOT, RT_IDX_MCAST, 0)) {
 				netif_err(qdev, hw, qdev->ndev,
 					  "Failed to clear all-multi mode.\n");
 			} else {
-				clear_bit(QL_ALLMULTI, &qdev->flags);
+				clear_bit(QLGE_ALLMULTI, &qdev->flags);
 			}
 		}
 	}
 
 	if (!netdev_mc_empty(ndev)) {
-		status = ql_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+		status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
 		if (status)
 			goto exit;
 		i = 0;
 		netdev_for_each_mc_addr(ha, ndev) {
-			if (ql_set_mac_addr_reg(qdev, (u8 *) ha->addr,
+			if (qlge_set_mac_addr_reg(qdev, (u8 *) ha->addr,
 						MAC_ADDR_TYPE_MULTI_MAC, i)) {
 				netif_err(qdev, hw, qdev->ndev,
 					  "Failed to loadmulticast address.\n");
-				ql_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+				qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
 				goto exit;
 			}
 			i++;
 		}
-		ql_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
-		if (ql_set_routing_reg
+		qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+		if (qlge_set_routing_reg
 		    (qdev, RT_IDX_MCAST_MATCH_SLOT, RT_IDX_MCAST_MATCH, 1)) {
 			netif_err(qdev, hw, qdev->ndev,
 				  "Failed to set multicast match mode.\n");
 		} else {
-			set_bit(QL_ALLMULTI, &qdev->flags);
+			set_bit(QLGE_ALLMULTI, &qdev->flags);
 		}
 	}
 exit:
-	ql_sem_unlock(qdev, SEM_RT_IDX_MASK);
+	qlge_sem_unlock(qdev, SEM_RT_IDX_MASK);
 }
 
 static int qlge_set_mac_address(struct net_device *ndev, void *p)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	struct sockaddr *addr = p;
 	int status;
 
@@ -4253,43 +4253,43 @@ static int qlge_set_mac_address(struct net_device *ndev, void *p)
 	/* Update local copy of current mac address. */
 	memcpy(qdev->current_mac_addr, ndev->dev_addr, ndev->addr_len);
 
-	status = ql_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_MAC_ADDR_MASK);
 	if (status)
 		return status;
-	status = ql_set_mac_addr_reg(qdev, (u8 *) ndev->dev_addr,
+	status = qlge_set_mac_addr_reg(qdev, (u8 *) ndev->dev_addr,
 				     MAC_ADDR_TYPE_CAM_MAC,
 				     qdev->func * MAX_CQ);
 	if (status)
 		netif_err(qdev, hw, qdev->ndev, "Failed to load MAC address.\n");
-	ql_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
+	qlge_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
 	return status;
 }
 
 static void qlge_tx_timeout(struct net_device *ndev, unsigned int txqueue)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
-	ql_queue_asic_error(qdev);
+	qlge_queue_asic_error(qdev);
 }
 
-static void ql_asic_reset_work(struct work_struct *work)
+static void qlge_asic_reset_work(struct work_struct *work)
 {
-	struct ql_adapter *qdev =
-	    container_of(work, struct ql_adapter, asic_reset_work.work);
+	struct qlge_adapter *qdev =
+	    container_of(work, struct qlge_adapter, asic_reset_work.work);
 	int status;
 
 	rtnl_lock();
-	status = ql_adapter_down(qdev);
+	status = qlge_adapter_down(qdev);
 	if (status)
 		goto error;
 
-	status = ql_adapter_up(qdev);
+	status = qlge_adapter_up(qdev);
 	if (status)
 		goto error;
 
 	/* Restore rx mode. */
-	clear_bit(QL_ALLMULTI, &qdev->flags);
-	clear_bit(QL_PROMISCUOUS, &qdev->flags);
+	clear_bit(QLGE_ALLMULTI, &qdev->flags);
+	clear_bit(QLGE_PROMISCUOUS, &qdev->flags);
 	qlge_set_multicast_list(qdev->ndev);
 
 	rtnl_unlock();
@@ -4298,19 +4298,19 @@ static void ql_asic_reset_work(struct work_struct *work)
 	netif_alert(qdev, ifup, qdev->ndev,
 		    "Driver up/down cycle failed, closing device\n");
 
-	set_bit(QL_ADAPTER_UP, &qdev->flags);
+	set_bit(QLGE_ADAPTER_UP, &qdev->flags);
 	dev_close(qdev->ndev);
 	rtnl_unlock();
 }
 
-static const struct nic_operations qla8012_nic_ops = {
-	.get_flash		= ql_get_8012_flash_params,
-	.port_initialize	= ql_8012_port_initialize,
+static const struct qlge_nic_operations qla8012_nic_ops = {
+	.get_flash		= qlge_get_8012_flash_params,
+	.port_initialize	= qlge_8012_port_initialize,
 };
 
-static const struct nic_operations qla8000_nic_ops = {
-	.get_flash		= ql_get_8000_flash_params,
-	.port_initialize	= ql_8000_port_initialize,
+static const struct qlge_nic_operations qla8000_nic_ops = {
+	.get_flash		= qlge_get_8000_flash_params,
+	.port_initialize	= qlge_8000_port_initialize,
 };
 
 /* Find the pcie function number for the other NIC
@@ -4320,13 +4320,13 @@ static const struct nic_operations qla8000_nic_ops = {
  * after a fatal firmware error, or doing a firmware
  * coredump.
  */
-static int ql_get_alt_pcie_func(struct ql_adapter *qdev)
+static int qlge_get_alt_pcie_func(struct qlge_adapter *qdev)
 {
 	int status = 0;
 	u32 temp;
 	u32 nic_func1, nic_func2;
 
-	status = ql_read_mpi_reg(qdev, MPI_TEST_FUNC_PORT_CFG,
+	status = qlge_read_mpi_reg(qdev, MPI_TEST_FUNC_PORT_CFG,
 				 &temp);
 	if (status)
 		return status;
@@ -4346,16 +4346,16 @@ static int ql_get_alt_pcie_func(struct ql_adapter *qdev)
 	return status;
 }
 
-static int ql_get_board_info(struct ql_adapter *qdev)
+static int qlge_get_board_info(struct qlge_adapter *qdev)
 {
 	int status;
 
 	qdev->func =
-	    (ql_read32(qdev, STS) & STS_FUNC_ID_MASK) >> STS_FUNC_ID_SHIFT;
+	    (qlge_read32(qdev, STS) & STS_FUNC_ID_MASK) >> STS_FUNC_ID_SHIFT;
 	if (qdev->func > 3)
 		return -EIO;
 
-	status = ql_get_alt_pcie_func(qdev);
+	status = qlge_get_alt_pcie_func(qdev);
 	if (status)
 		return status;
 
@@ -4373,7 +4373,7 @@ static int ql_get_board_info(struct ql_adapter *qdev)
 		qdev->mailbox_in = PROC_ADDR_MPI_RISC | PROC_ADDR_FUNC0_MBI;
 		qdev->mailbox_out = PROC_ADDR_MPI_RISC | PROC_ADDR_FUNC0_MBO;
 	}
-	qdev->chip_rev_id = ql_read32(qdev, REV_ID);
+	qdev->chip_rev_id = qlge_read32(qdev, REV_ID);
 	qdev->device_id = qdev->pdev->device;
 	if (qdev->device_id == QLGE_DEVICE_ID_8012)
 		qdev->nic_ops = &qla8012_nic_ops;
@@ -4382,10 +4382,10 @@ static int ql_get_board_info(struct ql_adapter *qdev)
 	return status;
 }
 
-static void ql_release_all(struct pci_dev *pdev)
+static void qlge_release_all(struct pci_dev *pdev)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	if (qdev->workqueue) {
 		destroy_workqueue(qdev->workqueue);
@@ -4400,10 +4400,10 @@ static void ql_release_all(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 }
 
-static int ql_init_device(struct pci_dev *pdev, struct net_device *ndev,
+static int qlge_init_device(struct pci_dev *pdev, struct net_device *ndev,
 			  int cards_found)
 {
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int err = 0;
 
 	memset((void *)qdev, 0, sizeof(*qdev));
@@ -4432,7 +4432,7 @@ static int ql_init_device(struct pci_dev *pdev, struct net_device *ndev,
 
 	pci_set_master(pdev);
 	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
-		set_bit(QL_DMA64, &qdev->flags);
+		set_bit(QLGE_DMA64, &qdev->flags);
 		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
 	} else {
 		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
@@ -4467,7 +4467,7 @@ static int ql_init_device(struct pci_dev *pdev, struct net_device *ndev,
 		goto err_out2;
 	}
 
-	err = ql_get_board_info(qdev);
+	err = qlge_get_board_info(qdev);
 	if (err) {
 		dev_err(&pdev->dev, "Register access failed.\n");
 		err = -EIO;
@@ -4478,13 +4478,13 @@ static int ql_init_device(struct pci_dev *pdev, struct net_device *ndev,
 
 	if (qlge_mpi_coredump) {
 		qdev->mpi_coredump =
-			vmalloc(sizeof(struct ql_mpi_coredump));
+			vmalloc(sizeof(struct qlge_mpi_coredump));
 		if (!qdev->mpi_coredump) {
 			err = -ENOMEM;
 			goto err_out2;
 		}
 		if (qlge_force_coredump)
-			set_bit(QL_FRC_COREDUMP, &qdev->flags);
+			set_bit(QLGE_FRC_COREDUMP, &qdev->flags);
 	}
 	/* make sure the EEPROM is good */
 	err = qdev->nic_ops->get_flash(qdev);
@@ -4516,12 +4516,12 @@ static int ql_init_device(struct pci_dev *pdev, struct net_device *ndev,
 		goto err_out2;
 	}
 
-	INIT_DELAYED_WORK(&qdev->asic_reset_work, ql_asic_reset_work);
-	INIT_DELAYED_WORK(&qdev->mpi_reset_work, ql_mpi_reset_work);
-	INIT_DELAYED_WORK(&qdev->mpi_work, ql_mpi_work);
-	INIT_DELAYED_WORK(&qdev->mpi_port_cfg_work, ql_mpi_port_cfg_work);
-	INIT_DELAYED_WORK(&qdev->mpi_idc_work, ql_mpi_idc_work);
-	INIT_DELAYED_WORK(&qdev->mpi_core_to_log, ql_mpi_core_to_log);
+	INIT_DELAYED_WORK(&qdev->asic_reset_work, qlge_asic_reset_work);
+	INIT_DELAYED_WORK(&qdev->mpi_reset_work, qlge_mpi_reset_work);
+	INIT_DELAYED_WORK(&qdev->mpi_work, qlge_mpi_work);
+	INIT_DELAYED_WORK(&qdev->mpi_port_cfg_work, qlge_mpi_port_cfg_work);
+	INIT_DELAYED_WORK(&qdev->mpi_idc_work, qlge_mpi_idc_work);
+	INIT_DELAYED_WORK(&qdev->mpi_core_to_log, qlge_mpi_core_to_log);
 	init_completion(&qdev->ide_completion);
 	mutex_init(&qdev->mpi_mutex);
 
@@ -4532,7 +4532,7 @@ static int ql_init_device(struct pci_dev *pdev, struct net_device *ndev,
 	}
 	return 0;
 err_out2:
-	ql_release_all(pdev);
+	qlge_release_all(pdev);
 err_out1:
 	pci_disable_device(pdev);
 	return err;
@@ -4553,12 +4553,12 @@ static const struct net_device_ops qlge_netdev_ops = {
 	.ndo_vlan_rx_kill_vid	= qlge_vlan_rx_kill_vid,
 };
 
-static void ql_timer(struct timer_list *t)
+static void qlge_timer(struct timer_list *t)
 {
-	struct ql_adapter *qdev = from_timer(qdev, t, timer);
+	struct qlge_adapter *qdev = from_timer(qdev, t, timer);
 	u32 var = 0;
 
-	var = ql_read32(qdev, STS);
+	var = qlge_read32(qdev, STS);
 	if (pci_channel_offline(qdev->pdev)) {
 		netif_err(qdev, ifup, qdev->ndev, "EEH STS = 0x%.08x.\n", var);
 		return;
@@ -4571,17 +4571,17 @@ static int qlge_probe(struct pci_dev *pdev,
 		      const struct pci_device_id *pci_entry)
 {
 	struct net_device *ndev = NULL;
-	struct ql_adapter *qdev = NULL;
+	struct qlge_adapter *qdev = NULL;
 	static int cards_found;
 	int err = 0;
 
-	ndev = alloc_etherdev_mq(sizeof(struct ql_adapter),
+	ndev = alloc_etherdev_mq(sizeof(struct qlge_adapter),
 				 min(MAX_CPUS,
 				     netif_get_num_default_rss_queues()));
 	if (!ndev)
 		return -ENOMEM;
 
-	err = ql_init_device(pdev, ndev, cards_found);
+	err = qlge_init_device(pdev, ndev, cards_found);
 	if (err < 0) {
 		free_netdev(ndev);
 		return err;
@@ -4604,7 +4604,7 @@ static int qlge_probe(struct pci_dev *pdev,
 				 NETIF_F_HW_VLAN_CTAG_TX |
 				 NETIF_F_HW_VLAN_CTAG_RX);
 
-	if (test_bit(QL_DMA64, &qdev->flags))
+	if (test_bit(QLGE_DMA64, &qdev->flags))
 		ndev->features |= NETIF_F_HIGHDMA;
 
 	/*
@@ -4627,7 +4627,7 @@ static int qlge_probe(struct pci_dev *pdev,
 	err = register_netdev(ndev);
 	if (err) {
 		dev_err(&pdev->dev, "net device registration failed.\n");
-		ql_release_all(pdev);
+		qlge_release_all(pdev);
 		pci_disable_device(pdev);
 		free_netdev(ndev);
 		return err;
@@ -4635,43 +4635,43 @@ static int qlge_probe(struct pci_dev *pdev,
 	/* Start up the timer to trigger EEH if
 	 * the bus goes dead
 	 */
-	timer_setup(&qdev->timer, ql_timer, TIMER_DEFERRABLE);
+	timer_setup(&qdev->timer, qlge_timer, TIMER_DEFERRABLE);
 	mod_timer(&qdev->timer, jiffies + (5*HZ));
-	ql_link_off(qdev);
-	ql_display_dev_info(ndev);
+	qlge_link_off(qdev);
+	qlge_display_dev_info(ndev);
 	atomic_set(&qdev->lb_count, 0);
 	cards_found++;
 	return 0;
 }
 
-netdev_tx_t ql_lb_send(struct sk_buff *skb, struct net_device *ndev)
+netdev_tx_t qlge_lb_send(struct sk_buff *skb, struct net_device *ndev)
 {
 	return qlge_send(skb, ndev);
 }
 
-int ql_clean_lb_rx_ring(struct rx_ring *rx_ring, int budget)
+int qlge_clean_lb_rx_ring(struct qlge_rx_ring *rx_ring, int budget)
 {
-	return ql_clean_inbound_rx_ring(rx_ring, budget);
+	return qlge_clean_inbound_rx_ring(rx_ring, budget);
 }
 
 static void qlge_remove(struct pci_dev *pdev)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	del_timer_sync(&qdev->timer);
-	ql_cancel_all_work_sync(qdev);
+	qlge_cancel_all_work_sync(qdev);
 	unregister_netdev(ndev);
-	ql_release_all(pdev);
+	qlge_release_all(pdev);
 	pci_disable_device(pdev);
 	free_netdev(ndev);
 }
 
 /* Clean up resources without touching hardware. */
-static void ql_eeh_close(struct net_device *ndev)
+static void qlge_eeh_close(struct net_device *ndev)
 {
 	int i;
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	if (netif_carrier_ok(ndev)) {
 		netif_carrier_off(ndev);
@@ -4679,15 +4679,15 @@ static void ql_eeh_close(struct net_device *ndev)
 	}
 
 	/* Disabling the timer */
-	ql_cancel_all_work_sync(qdev);
+	qlge_cancel_all_work_sync(qdev);
 
 	for (i = 0; i < qdev->rss_ring_count; i++)
 		netif_napi_del(&qdev->rx_ring[i].napi);
 
-	clear_bit(QL_ADAPTER_UP, &qdev->flags);
-	ql_tx_ring_clean(qdev);
-	ql_free_rx_buffers(qdev);
-	ql_release_adapter_resources(qdev);
+	clear_bit(QLGE_ADAPTER_UP, &qdev->flags);
+	qlge_tx_ring_clean(qdev);
+	qlge_free_rx_buffers(qdev);
+	qlge_release_adapter_resources(qdev);
 }
 
 /*
@@ -4698,7 +4698,7 @@ static pci_ers_result_t qlge_io_error_detected(struct pci_dev *pdev,
 					       enum pci_channel_state state)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	switch (state) {
 	case pci_channel_io_normal:
@@ -4707,15 +4707,15 @@ static pci_ers_result_t qlge_io_error_detected(struct pci_dev *pdev,
 		netif_device_detach(ndev);
 		del_timer_sync(&qdev->timer);
 		if (netif_running(ndev))
-			ql_eeh_close(ndev);
+			qlge_eeh_close(ndev);
 		pci_disable_device(pdev);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_err(&pdev->dev,
 			"%s: pci_channel_io_perm_failure.\n", __func__);
 		del_timer_sync(&qdev->timer);
-		ql_eeh_close(ndev);
-		set_bit(QL_EEH_FATAL, &qdev->flags);
+		qlge_eeh_close(ndev);
+		set_bit(QLGE_EEH_FATAL, &qdev->flags);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -4732,7 +4732,7 @@ static pci_ers_result_t qlge_io_error_detected(struct pci_dev *pdev,
 static pci_ers_result_t qlge_io_slot_reset(struct pci_dev *pdev)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 
 	pdev->error_state = pci_channel_io_normal;
 
@@ -4744,9 +4744,9 @@ static pci_ers_result_t qlge_io_slot_reset(struct pci_dev *pdev)
 	}
 	pci_set_master(pdev);
 
-	if (ql_adapter_reset(qdev)) {
+	if (qlge_adapter_reset(qdev)) {
 		netif_err(qdev, drv, qdev->ndev, "reset FAILED!\n");
-		set_bit(QL_EEH_FATAL, &qdev->flags);
+		set_bit(QLGE_EEH_FATAL, &qdev->flags);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -4756,7 +4756,7 @@ static pci_ers_result_t qlge_io_slot_reset(struct pci_dev *pdev)
 static void qlge_io_resume(struct pci_dev *pdev)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int err = 0;
 
 	if (netif_running(ndev)) {
@@ -4783,19 +4783,19 @@ static const struct pci_error_handlers qlge_err_handler = {
 static int qlge_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int err;
 
 	netif_device_detach(ndev);
 	del_timer_sync(&qdev->timer);
 
 	if (netif_running(ndev)) {
-		err = ql_adapter_down(qdev);
+		err = qlge_adapter_down(qdev);
 		if (!err)
 			return err;
 	}
 
-	ql_wol(qdev);
+	qlge_wol(qdev);
 	err = pci_save_state(pdev);
 	if (err)
 		return err;
@@ -4811,7 +4811,7 @@ static int qlge_suspend(struct pci_dev *pdev, pm_message_t state)
 static int qlge_resume(struct pci_dev *pdev)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
-	struct ql_adapter *qdev = netdev_priv(ndev);
+	struct qlge_adapter *qdev = netdev_priv(ndev);
 	int err;
 
 	pci_set_power_state(pdev, PCI_D0);
@@ -4827,7 +4827,7 @@ static int qlge_resume(struct pci_dev *pdev)
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
 	if (netif_running(ndev)) {
-		err = ql_adapter_up(qdev);
+		err = qlge_adapter_up(qdev);
 		if (err)
 			return err;
 	}
diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
index 60c08d9cc034..12665c508e2b 100644
--- a/drivers/staging/qlge/qlge_mpi.c
+++ b/drivers/staging/qlge/qlge_mpi.c
@@ -1,28 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qlge.h"
 
-int ql_unpause_mpi_risc(struct ql_adapter *qdev)
+int qlge_unpause_mpi_risc(struct qlge_adapter *qdev)
 {
 	u32 tmp;
 
 	/* Un-pause the RISC */
-	tmp = ql_read32(qdev, CSR);
+	tmp = qlge_read32(qdev, CSR);
 	if (!(tmp & CSR_RP))
 		return -EIO;
 
-	ql_write32(qdev, CSR, CSR_CMD_CLR_PAUSE);
+	qlge_write32(qdev, CSR, CSR_CMD_CLR_PAUSE);
 	return 0;
 }
 
-int ql_pause_mpi_risc(struct ql_adapter *qdev)
+int qlge_pause_mpi_risc(struct qlge_adapter *qdev)
 {
 	u32 tmp;
 	int count = UDELAY_COUNT;
 
 	/* Pause the RISC */
-	ql_write32(qdev, CSR, CSR_CMD_SET_PAUSE);
+	qlge_write32(qdev, CSR, CSR_CMD_SET_PAUSE);
 	do {
-		tmp = ql_read32(qdev, CSR);
+		tmp = qlge_read32(qdev, CSR);
 		if (tmp & CSR_RP)
 			break;
 		mdelay(UDELAY_DELAY);
@@ -31,17 +31,17 @@ int ql_pause_mpi_risc(struct ql_adapter *qdev)
 	return (count == 0) ? -ETIMEDOUT : 0;
 }
 
-int ql_hard_reset_mpi_risc(struct ql_adapter *qdev)
+int qlge_hard_reset_mpi_risc(struct qlge_adapter *qdev)
 {
 	u32 tmp;
 	int count = UDELAY_COUNT;
 
 	/* Reset the RISC */
-	ql_write32(qdev, CSR, CSR_CMD_SET_RST);
+	qlge_write32(qdev, CSR, CSR_CMD_SET_RST);
 	do {
-		tmp = ql_read32(qdev, CSR);
+		tmp = qlge_read32(qdev, CSR);
 		if (tmp & CSR_RR) {
-			ql_write32(qdev, CSR, CSR_CMD_CLR_RST);
+			qlge_write32(qdev, CSR, CSR_CMD_CLR_RST);
 			break;
 		}
 		mdelay(UDELAY_DELAY);
@@ -50,47 +50,47 @@ int ql_hard_reset_mpi_risc(struct ql_adapter *qdev)
 	return (count == 0) ? -ETIMEDOUT : 0;
 }
 
-int ql_read_mpi_reg(struct ql_adapter *qdev, u32 reg, u32 *data)
+int qlge_read_mpi_reg(struct qlge_adapter *qdev, u32 reg, u32 *data)
 {
 	int status;
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
+	status = qlge_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
 	if (status)
 		goto exit;
 	/* set up for reg read */
-	ql_write32(qdev, PROC_ADDR, reg | PROC_ADDR_R);
+	qlge_write32(qdev, PROC_ADDR, reg | PROC_ADDR_R);
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
+	status = qlge_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
 	if (status)
 		goto exit;
 	/* get the data */
-	*data = ql_read32(qdev, PROC_DATA);
+	*data = qlge_read32(qdev, PROC_DATA);
 exit:
 	return status;
 }
 
-int ql_write_mpi_reg(struct ql_adapter *qdev, u32 reg, u32 data)
+int qlge_write_mpi_reg(struct qlge_adapter *qdev, u32 reg, u32 data)
 {
 	int status = 0;
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
+	status = qlge_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
 	if (status)
 		goto exit;
 	/* write the data to the data reg */
-	ql_write32(qdev, PROC_DATA, data);
+	qlge_write32(qdev, PROC_DATA, data);
 	/* trigger the write */
-	ql_write32(qdev, PROC_ADDR, reg);
+	qlge_write32(qdev, PROC_ADDR, reg);
 	/* wait for reg to come ready */
-	status = ql_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
+	status = qlge_wait_reg_rdy(qdev, PROC_ADDR, PROC_ADDR_RDY, PROC_ADDR_ERR);
 	if (status)
 		goto exit;
 exit:
 	return status;
 }
 
-int ql_soft_reset_mpi_risc(struct ql_adapter *qdev)
+int qlge_soft_reset_mpi_risc(struct qlge_adapter *qdev)
 {
-	return ql_write_mpi_reg(qdev, 0x00001010, 1);
+	return qlge_write_mpi_reg(qdev, 0x00001010, 1);
 }
 
 /* Determine if we are in charge of the firwmare. If
@@ -98,7 +98,7 @@ int ql_soft_reset_mpi_risc(struct ql_adapter *qdev)
  * we are the higher function and the lower function
  * is not enabled.
  */
-int ql_own_firmware(struct ql_adapter *qdev)
+int qlge_own_firmware(struct qlge_adapter *qdev)
 {
 	u32 temp;
 
@@ -114,7 +114,7 @@ int ql_own_firmware(struct ql_adapter *qdev)
 	 * enabled, then we are responsible for
 	 * core dump and firmware reset after an error.
 	 */
-	temp =  ql_read32(qdev, STS);
+	temp =  qlge_read32(qdev, STS);
 	if (!(temp & (1 << (8 + qdev->alt_func))))
 		return 1;
 
@@ -122,36 +122,36 @@ int ql_own_firmware(struct ql_adapter *qdev)
 
 }
 
-static int ql_get_mb_sts(struct ql_adapter *qdev, struct mbox_params *mbcp)
+static int qlge_get_mb_sts(struct qlge_adapter *qdev, struct qlge_mbox_params *mbcp)
 {
 	int i, status;
 
-	status = ql_sem_spinlock(qdev, SEM_PROC_REG_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_PROC_REG_MASK);
 	if (status)
 		return -EBUSY;
 	for (i = 0; i < mbcp->out_count; i++) {
 		status =
-		    ql_read_mpi_reg(qdev, qdev->mailbox_out + i,
+		    qlge_read_mpi_reg(qdev, qdev->mailbox_out + i,
 				    &mbcp->mbox_out[i]);
 		if (status) {
 			netif_err(qdev, drv, qdev->ndev, "Failed mailbox read.\n");
 			break;
 		}
 	}
-	ql_sem_unlock(qdev, SEM_PROC_REG_MASK);	/* does flush too */
+	qlge_sem_unlock(qdev, SEM_PROC_REG_MASK);	/* does flush too */
 	return status;
 }
 
 /* Wait for a single mailbox command to complete.
  * Returns zero on success.
  */
-static int ql_wait_mbx_cmd_cmplt(struct ql_adapter *qdev)
+static int qlge_wait_mbx_cmd_cmplt(struct qlge_adapter *qdev)
 {
 	int count = 100;
 	u32 value;
 
 	do {
-		value = ql_read32(qdev, STS);
+		value = qlge_read32(qdev, STS);
 		if (value & STS_PI)
 			return 0;
 		mdelay(UDELAY_DELAY); /* 100ms */
@@ -162,7 +162,7 @@ static int ql_wait_mbx_cmd_cmplt(struct ql_adapter *qdev)
 /* Execute a single mailbox command.
  * Caller must hold PROC_ADDR semaphore.
  */
-static int ql_exec_mb_cmd(struct ql_adapter *qdev, struct mbox_params *mbcp)
+static int qlge_exec_mb_cmd(struct qlge_adapter *qdev, struct qlge_mbox_params *mbcp)
 {
 	int i, status;
 
@@ -170,10 +170,10 @@ static int ql_exec_mb_cmd(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	 * Make sure there's nothing pending.
 	 * This shouldn't happen.
 	 */
-	if (ql_read32(qdev, CSR) & CSR_HRI)
+	if (qlge_read32(qdev, CSR) & CSR_HRI)
 		return -EIO;
 
-	status = ql_sem_spinlock(qdev, SEM_PROC_REG_MASK);
+	status = qlge_sem_spinlock(qdev, SEM_PROC_REG_MASK);
 	if (status)
 		return status;
 
@@ -181,7 +181,7 @@ static int ql_exec_mb_cmd(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	 * Fill the outbound mailboxes.
 	 */
 	for (i = 0; i < mbcp->in_count; i++) {
-		status = ql_write_mpi_reg(qdev, qdev->mailbox_in + i,
+		status = qlge_write_mpi_reg(qdev, qdev->mailbox_in + i,
 					  mbcp->mbox_in[i]);
 		if (status)
 			goto end;
@@ -189,9 +189,9 @@ static int ql_exec_mb_cmd(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	/*
 	 * Wake up the MPI firmware.
 	 */
-	ql_write32(qdev, CSR, CSR_CMD_SET_H2R_INT);
+	qlge_write32(qdev, CSR, CSR_CMD_SET_H2R_INT);
 end:
-	ql_sem_unlock(qdev, SEM_PROC_REG_MASK);
+	qlge_sem_unlock(qdev, SEM_PROC_REG_MASK);
 	return status;
 }
 
@@ -202,27 +202,27 @@ static int ql_exec_mb_cmd(struct ql_adapter *qdev, struct mbox_params *mbcp)
  * to handler processing this since a mailbox command
  * will need to be sent to ACK the request.
  */
-static int ql_idc_req_aen(struct ql_adapter *qdev)
+static int qlge_idc_req_aen(struct qlge_adapter *qdev)
 {
 	int status;
-	struct mbox_params *mbcp = &qdev->idc_mbc;
+	struct qlge_mbox_params *mbcp = &qdev->idc_mbc;
 
 	netif_err(qdev, drv, qdev->ndev, "Enter!\n");
 	/* Get the status data and start up a thread to
 	 * handle the request.
 	 */
 	mbcp->out_count = 4;
-	status = ql_get_mb_sts(qdev, mbcp);
+	status = qlge_get_mb_sts(qdev, mbcp);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Could not read MPI, resetting ASIC!\n");
-		ql_queue_asic_error(qdev);
+		qlge_queue_asic_error(qdev);
 	} else	{
 		/* Begin polled mode early so
 		 * we don't get another interrupt
 		 * when we leave mpi_worker.
 		 */
-		ql_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
+		qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
 		queue_delayed_work(qdev->workqueue, &qdev->mpi_idc_work, 0);
 	}
 	return status;
@@ -231,17 +231,17 @@ static int ql_idc_req_aen(struct ql_adapter *qdev)
 /* Process an inter-device event completion.
  * If good, signal the caller's completion.
  */
-static int ql_idc_cmplt_aen(struct ql_adapter *qdev)
+static int qlge_idc_cmplt_aen(struct qlge_adapter *qdev)
 {
 	int status;
-	struct mbox_params *mbcp = &qdev->idc_mbc;
+	struct qlge_mbox_params *mbcp = &qdev->idc_mbc;
 
 	mbcp->out_count = 4;
-	status = ql_get_mb_sts(qdev, mbcp);
+	status = qlge_get_mb_sts(qdev, mbcp);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Could not read MPI, resetting RISC!\n");
-		ql_queue_fw_error(qdev);
+		qlge_queue_fw_error(qdev);
 	} else
 		/* Wake up the sleeping mpi_idc_work thread that is
 		 * waiting for this event.
@@ -251,13 +251,13 @@ static int ql_idc_cmplt_aen(struct ql_adapter *qdev)
 	return status;
 }
 
-static void ql_link_up(struct ql_adapter *qdev, struct mbox_params *mbcp)
+static void qlge_link_up(struct qlge_adapter *qdev, struct qlge_mbox_params *mbcp)
 {
 	int status;
 
 	mbcp->out_count = 2;
 
-	status = ql_get_mb_sts(qdev, mbcp);
+	status = qlge_get_mb_sts(qdev, mbcp);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "%s: Could not get mailbox status.\n", __func__);
@@ -270,55 +270,55 @@ static void ql_link_up(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	/* If we're coming back from an IDC event
 	 * then set up the CAM and frame routing.
 	 */
-	if (test_bit(QL_CAM_RT_SET, &qdev->flags)) {
-		status = ql_cam_route_initialize(qdev);
+	if (test_bit(QLGE_CAM_RT_SET, &qdev->flags)) {
+		status = qlge_cam_route_initialize(qdev);
 		if (status) {
 			netif_err(qdev, ifup, qdev->ndev,
 				  "Failed to init CAM/Routing tables.\n");
 			return;
 		} else
-			clear_bit(QL_CAM_RT_SET, &qdev->flags);
+			clear_bit(QLGE_CAM_RT_SET, &qdev->flags);
 	}
 
 	/* Queue up a worker to check the frame
 	 * size information, and fix it if it's not
 	 * to our liking.
 	 */
-	if (!test_bit(QL_PORT_CFG, &qdev->flags)) {
+	if (!test_bit(QLGE_PORT_CFG, &qdev->flags)) {
 		netif_err(qdev, drv, qdev->ndev, "Queue Port Config Worker!\n");
-		set_bit(QL_PORT_CFG, &qdev->flags);
+		set_bit(QLGE_PORT_CFG, &qdev->flags);
 		/* Begin polled mode early so
 		 * we don't get another interrupt
 		 * when we leave mpi_worker dpc.
 		 */
-		ql_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
+		qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
 		queue_delayed_work(qdev->workqueue,
 				   &qdev->mpi_port_cfg_work, 0);
 	}
 
-	ql_link_on(qdev);
+	qlge_link_on(qdev);
 }
 
-static void ql_link_down(struct ql_adapter *qdev, struct mbox_params *mbcp)
+static void qlge_link_down(struct qlge_adapter *qdev, struct qlge_mbox_params *mbcp)
 {
 	int status;
 
 	mbcp->out_count = 3;
 
-	status = ql_get_mb_sts(qdev, mbcp);
+	status = qlge_get_mb_sts(qdev, mbcp);
 	if (status)
 		netif_err(qdev, drv, qdev->ndev, "Link down AEN broken!\n");
 
-	ql_link_off(qdev);
+	qlge_link_off(qdev);
 }
 
-static int ql_sfp_in(struct ql_adapter *qdev, struct mbox_params *mbcp)
+static int qlge_sfp_in(struct qlge_adapter *qdev, struct qlge_mbox_params *mbcp)
 {
 	int status;
 
 	mbcp->out_count = 5;
 
-	status = ql_get_mb_sts(qdev, mbcp);
+	status = qlge_get_mb_sts(qdev, mbcp);
 	if (status)
 		netif_err(qdev, drv, qdev->ndev, "SFP in AEN broken!\n");
 	else
@@ -327,13 +327,13 @@ static int ql_sfp_in(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	return status;
 }
 
-static int ql_sfp_out(struct ql_adapter *qdev, struct mbox_params *mbcp)
+static int qlge_sfp_out(struct qlge_adapter *qdev, struct qlge_mbox_params *mbcp)
 {
 	int status;
 
 	mbcp->out_count = 1;
 
-	status = ql_get_mb_sts(qdev, mbcp);
+	status = qlge_get_mb_sts(qdev, mbcp);
 	if (status)
 		netif_err(qdev, drv, qdev->ndev, "SFP out AEN broken!\n");
 	else
@@ -342,13 +342,13 @@ static int ql_sfp_out(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	return status;
 }
 
-static int ql_aen_lost(struct ql_adapter *qdev, struct mbox_params *mbcp)
+static int qlge_aen_lost(struct qlge_adapter *qdev, struct qlge_mbox_params *mbcp)
 {
 	int status;
 
 	mbcp->out_count = 6;
 
-	status = ql_get_mb_sts(qdev, mbcp);
+	status = qlge_get_mb_sts(qdev, mbcp);
 	if (status)
 		netif_err(qdev, drv, qdev->ndev, "Lost AEN broken!\n");
 	else {
@@ -364,20 +364,20 @@ static int ql_aen_lost(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	return status;
 }
 
-static void ql_init_fw_done(struct ql_adapter *qdev, struct mbox_params *mbcp)
+static void qlge_init_fw_done(struct qlge_adapter *qdev, struct qlge_mbox_params *mbcp)
 {
 	int status;
 
 	mbcp->out_count = 2;
 
-	status = ql_get_mb_sts(qdev, mbcp);
+	status = qlge_get_mb_sts(qdev, mbcp);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev, "Firmware did not initialize!\n");
 	} else {
 		netif_err(qdev, drv, qdev->ndev, "Firmware Revision  = 0x%.08x.\n",
 			  mbcp->mbox_out[1]);
 		qdev->fw_rev_id = mbcp->mbox_out[1];
-		status = ql_cam_route_initialize(qdev);
+		status = qlge_cam_route_initialize(qdev);
 		if (status)
 			netif_err(qdev, ifup, qdev->ndev,
 				  "Failed to init CAM/Routing tables.\n");
@@ -390,18 +390,18 @@ static void ql_init_fw_done(struct ql_adapter *qdev, struct mbox_params *mbcp)
  *  when events arrive via an interrupt.
  *  It also gets called when a mailbox command is polling for
  *  it's completion. */
-static int ql_mpi_handler(struct ql_adapter *qdev, struct mbox_params *mbcp)
+static int qlge_mpi_handler(struct qlge_adapter *qdev, struct qlge_mbox_params *mbcp)
 {
 	int status;
 	int orig_count = mbcp->out_count;
 
 	/* Just get mailbox zero for now. */
 	mbcp->out_count = 1;
-	status = ql_get_mb_sts(qdev, mbcp);
+	status = qlge_get_mb_sts(qdev, mbcp);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Could not read MPI, resetting ASIC!\n");
-		ql_queue_asic_error(qdev);
+		qlge_queue_asic_error(qdev);
 		goto end;
 	}
 
@@ -425,7 +425,7 @@ static int ql_mpi_handler(struct ql_adapter *qdev, struct mbox_params *mbcp)
 		 * command completion.
 		 */
 		mbcp->out_count = orig_count;
-		status = ql_get_mb_sts(qdev, mbcp);
+		status = qlge_get_mb_sts(qdev, mbcp);
 		return status;
 
 	/* We are being asked by firmware to accept
@@ -434,7 +434,7 @@ static int ql_mpi_handler(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	 * parameters, or loopback mode.
 	 */
 	case AEN_IDC_REQ:
-		status = ql_idc_req_aen(qdev);
+		status = qlge_idc_req_aen(qdev);
 		break;
 
 	/* Process and inbound IDC event.
@@ -444,15 +444,15 @@ static int ql_mpi_handler(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	 */
 	case AEN_IDC_CMPLT:
 	case AEN_IDC_EXT:
-		status = ql_idc_cmplt_aen(qdev);
+		status = qlge_idc_cmplt_aen(qdev);
 		break;
 
 	case AEN_LINK_UP:
-		ql_link_up(qdev, mbcp);
+		qlge_link_up(qdev, mbcp);
 		break;
 
 	case AEN_LINK_DOWN:
-		ql_link_down(qdev, mbcp);
+		qlge_link_down(qdev, mbcp);
 		break;
 
 	case AEN_FW_INIT_DONE:
@@ -461,19 +461,19 @@ static int ql_mpi_handler(struct ql_adapter *qdev, struct mbox_params *mbcp)
 		 */
 		if (mbcp->mbox_in[0] == MB_CMD_EX_FW) {
 			mbcp->out_count = orig_count;
-			status = ql_get_mb_sts(qdev, mbcp);
+			status = qlge_get_mb_sts(qdev, mbcp);
 			mbcp->mbox_out[0] = MB_CMD_STS_GOOD;
 			return status;
 		}
-		ql_init_fw_done(qdev, mbcp);
+		qlge_init_fw_done(qdev, mbcp);
 		break;
 
 	case AEN_AEN_SFP_IN:
-		ql_sfp_in(qdev, mbcp);
+		qlge_sfp_in(qdev, mbcp);
 		break;
 
 	case AEN_AEN_SFP_OUT:
-		ql_sfp_out(qdev, mbcp);
+		qlge_sfp_out(qdev, mbcp);
 		break;
 
 	/* This event can arrive at boot time or after an
@@ -485,24 +485,24 @@ static int ql_mpi_handler(struct ql_adapter *qdev, struct mbox_params *mbcp)
 		 */
 		if (mbcp->mbox_in[0] == MB_CMD_EX_FW) {
 			mbcp->out_count = orig_count;
-			status = ql_get_mb_sts(qdev, mbcp);
+			status = qlge_get_mb_sts(qdev, mbcp);
 			mbcp->mbox_out[0] = MB_CMD_STS_ERR;
 			return status;
 		}
 		netif_err(qdev, drv, qdev->ndev,
 			  "Firmware initialization failed.\n");
 		status = -EIO;
-		ql_queue_fw_error(qdev);
+		qlge_queue_fw_error(qdev);
 		break;
 
 	case AEN_SYS_ERR:
 		netif_err(qdev, drv, qdev->ndev, "System Error.\n");
-		ql_queue_fw_error(qdev);
+		qlge_queue_fw_error(qdev);
 		status = -EIO;
 		break;
 
 	case AEN_AEN_LOST:
-		ql_aen_lost(qdev, mbcp);
+		qlge_aen_lost(qdev, mbcp);
 		break;
 
 	case AEN_DCBX_CHG:
@@ -514,7 +514,7 @@ static int ql_mpi_handler(struct ql_adapter *qdev, struct mbox_params *mbcp)
 		/* Clear the MPI firmware status. */
 	}
 end:
-	ql_write32(qdev, CSR, CSR_CMD_CLR_R2PCI_INT);
+	qlge_write32(qdev, CSR, CSR_CMD_CLR_R2PCI_INT);
 	/* Restore the original mailbox count to
 	 * what the caller asked for.  This can get
 	 * changed when a mailbox command is waiting
@@ -530,7 +530,7 @@ static int ql_mpi_handler(struct ql_adapter *qdev, struct mbox_params *mbcp)
  * element in the array contains the value for it's
  * respective mailbox register.
  */
-static int ql_mailbox_command(struct ql_adapter *qdev, struct mbox_params *mbcp)
+static int qlge_mailbox_command(struct qlge_adapter *qdev, struct qlge_mbox_params *mbcp)
 {
 	int status;
 	unsigned long count;
@@ -538,10 +538,10 @@ static int ql_mailbox_command(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	mutex_lock(&qdev->mpi_mutex);
 
 	/* Begin polled mode for MPI */
-	ql_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
+	qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
 
 	/* Load the mailbox registers and wake up MPI RISC. */
-	status = ql_exec_mb_cmd(qdev, mbcp);
+	status = qlge_exec_mb_cmd(qdev, mbcp);
 	if (status)
 		goto end;
 
@@ -559,7 +559,7 @@ static int ql_mailbox_command(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	count = jiffies + HZ * MAILBOX_TIMEOUT;
 	do {
 		/* Wait for the interrupt to come in. */
-		status = ql_wait_mbx_cmd_cmplt(qdev);
+		status = qlge_wait_mbx_cmd_cmplt(qdev);
 		if (status)
 			continue;
 
@@ -568,7 +568,7 @@ static int ql_mailbox_command(struct ql_adapter *qdev, struct mbox_params *mbcp)
 		 * will be spawned. If it's our completion
 		 * we will catch it below.
 		 */
-		status = ql_mpi_handler(qdev, mbcp);
+		status = qlge_mpi_handler(qdev, mbcp);
 		if (status)
 			goto end;
 
@@ -593,7 +593,7 @@ static int ql_mailbox_command(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	/* Now we can clear the interrupt condition
 	 * and look at our status.
 	 */
-	ql_write32(qdev, CSR, CSR_CMD_CLR_R2PCI_INT);
+	qlge_write32(qdev, CSR, CSR_CMD_CLR_R2PCI_INT);
 
 	if (((mbcp->mbox_out[0] & 0x0000f000) !=
 					MB_CMD_STS_GOOD) &&
@@ -603,7 +603,7 @@ static int ql_mailbox_command(struct ql_adapter *qdev, struct mbox_params *mbcp)
 	}
 end:
 	/* End polled mode for MPI */
-	ql_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16) | INTR_MASK_PI);
+	qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16) | INTR_MASK_PI);
 	mutex_unlock(&qdev->mpi_mutex);
 	return status;
 }
@@ -612,20 +612,20 @@ static int ql_mailbox_command(struct ql_adapter *qdev, struct mbox_params *mbcp)
  * driver banner and for ethtool info.
  * Returns zero on success.
  */
-int ql_mb_about_fw(struct ql_adapter *qdev)
+int qlge_mb_about_fw(struct qlge_adapter *qdev)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status = 0;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 1;
 	mbcp->out_count = 3;
 
 	mbcp->mbox_in[0] = MB_CMD_ABOUT_FW;
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -644,20 +644,20 @@ int ql_mb_about_fw(struct ql_adapter *qdev)
 /* Get functional state for MPI firmware.
  * Returns zero on success.
  */
-int ql_mb_get_fw_state(struct ql_adapter *qdev)
+int qlge_mb_get_fw_state(struct qlge_adapter *qdev)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status = 0;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 1;
 	mbcp->out_count = 2;
 
 	mbcp->mbox_in[0] = MB_CMD_GET_FW_STATE;
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -683,13 +683,13 @@ int ql_mb_get_fw_state(struct ql_adapter *qdev)
 /* Send and ACK mailbox command to the firmware to
  * let it continue with the change.
  */
-static int ql_mb_idc_ack(struct ql_adapter *qdev)
+static int qlge_mb_idc_ack(struct qlge_adapter *qdev)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status = 0;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 5;
 	mbcp->out_count = 1;
@@ -700,7 +700,7 @@ static int ql_mb_idc_ack(struct ql_adapter *qdev)
 	mbcp->mbox_in[3] = qdev->idc_mbc.mbox_out[3];
 	mbcp->mbox_in[4] = qdev->idc_mbc.mbox_out[4];
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -715,13 +715,13 @@ static int ql_mb_idc_ack(struct ql_adapter *qdev)
  * for the current port.
  * Most likely will block.
  */
-int ql_mb_set_port_cfg(struct ql_adapter *qdev)
+int qlge_mb_set_port_cfg(struct qlge_adapter *qdev)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status = 0;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 3;
 	mbcp->out_count = 1;
@@ -730,7 +730,7 @@ int ql_mb_set_port_cfg(struct ql_adapter *qdev)
 	mbcp->mbox_in[1] = qdev->link_config;
 	mbcp->mbox_in[2] = qdev->max_frame_size;
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -745,14 +745,14 @@ int ql_mb_set_port_cfg(struct ql_adapter *qdev)
 	return status;
 }
 
-static int ql_mb_dump_ram(struct ql_adapter *qdev, u64 req_dma, u32 addr,
+static int qlge_mb_dump_ram(struct qlge_adapter *qdev, u64 req_dma, u32 addr,
 			  u32 size)
 {
 	int status = 0;
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 9;
 	mbcp->out_count = 1;
@@ -767,7 +767,7 @@ static int ql_mb_dump_ram(struct ql_adapter *qdev, u64 req_dma, u32 addr,
 	mbcp->mbox_in[7] = LSW(MSD(req_dma));
 	mbcp->mbox_in[8] = MSW(addr);
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -779,7 +779,7 @@ static int ql_mb_dump_ram(struct ql_adapter *qdev, u64 req_dma, u32 addr,
 }
 
 /* Issue a mailbox command to dump RISC RAM. */
-int ql_dump_risc_ram_area(struct ql_adapter *qdev, void *buf,
+int qlge_dump_risc_ram_area(struct qlge_adapter *qdev, void *buf,
 			  u32 ram_addr, int word_count)
 {
 	int status;
@@ -791,7 +791,7 @@ int ql_dump_risc_ram_area(struct ql_adapter *qdev, void *buf,
 	if (!my_buf)
 		return -EIO;
 
-	status = ql_mb_dump_ram(qdev, buf_dma, ram_addr, word_count);
+	status = qlge_mb_dump_ram(qdev, buf_dma, ram_addr, word_count);
 	if (!status)
 		memcpy(buf, my_buf, word_count * sizeof(u32));
 
@@ -804,20 +804,20 @@ int ql_dump_risc_ram_area(struct ql_adapter *qdev, void *buf,
  * for the current port.
  * Most likely will block.
  */
-int ql_mb_get_port_cfg(struct ql_adapter *qdev)
+int qlge_mb_get_port_cfg(struct qlge_adapter *qdev)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status = 0;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 1;
 	mbcp->out_count = 3;
 
 	mbcp->mbox_in[0] = MB_CMD_GET_PORT_CFG;
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -834,13 +834,13 @@ int ql_mb_get_port_cfg(struct ql_adapter *qdev)
 	return status;
 }
 
-int ql_mb_wol_mode(struct ql_adapter *qdev, u32 wol)
+int qlge_mb_wol_mode(struct qlge_adapter *qdev, u32 wol)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 2;
 	mbcp->out_count = 1;
@@ -848,7 +848,7 @@ int ql_mb_wol_mode(struct ql_adapter *qdev, u32 wol)
 	mbcp->mbox_in[0] = MB_CMD_SET_WOL_MODE;
 	mbcp->mbox_in[1] = wol;
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -859,14 +859,14 @@ int ql_mb_wol_mode(struct ql_adapter *qdev, u32 wol)
 	return status;
 }
 
-int ql_mb_wol_set_magic(struct ql_adapter *qdev, u32 enable_wol)
+int qlge_mb_wol_set_magic(struct qlge_adapter *qdev, u32 enable_wol)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status;
 	u8 *addr = qdev->ndev->dev_addr;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 8;
 	mbcp->out_count = 1;
@@ -890,7 +890,7 @@ int ql_mb_wol_set_magic(struct ql_adapter *qdev, u32 enable_wol)
 		mbcp->mbox_in[7] = 0;
 	}
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -908,11 +908,11 @@ int ql_mb_wol_set_magic(struct ql_adapter *qdev, u32 enable_wol)
  * The firmware will complete the request if the other
  * function doesn't respond.
  */
-static int ql_idc_wait(struct ql_adapter *qdev)
+static int qlge_idc_wait(struct qlge_adapter *qdev)
 {
 	int status = -ETIMEDOUT;
 	long wait_time = 1 * HZ;
-	struct mbox_params *mbcp = &qdev->idc_mbc;
+	struct qlge_mbox_params *mbcp = &qdev->idc_mbc;
 
 	do {
 		/* Wait here for the command to complete
@@ -949,13 +949,13 @@ static int ql_idc_wait(struct ql_adapter *qdev)
 	return status;
 }
 
-int ql_mb_set_led_cfg(struct ql_adapter *qdev, u32 led_config)
+int qlge_mb_set_led_cfg(struct qlge_adapter *qdev, u32 led_config)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 2;
 	mbcp->out_count = 1;
@@ -963,7 +963,7 @@ int ql_mb_set_led_cfg(struct ql_adapter *qdev, u32 led_config)
 	mbcp->mbox_in[0] = MB_CMD_SET_LED_CFG;
 	mbcp->mbox_in[1] = led_config;
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -976,20 +976,20 @@ int ql_mb_set_led_cfg(struct ql_adapter *qdev, u32 led_config)
 	return status;
 }
 
-int ql_mb_get_led_cfg(struct ql_adapter *qdev)
+int qlge_mb_get_led_cfg(struct qlge_adapter *qdev)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 1;
 	mbcp->out_count = 2;
 
 	mbcp->mbox_in[0] = MB_CMD_GET_LED_CFG;
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -1003,13 +1003,13 @@ int ql_mb_get_led_cfg(struct ql_adapter *qdev)
 	return status;
 }
 
-int ql_mb_set_mgmnt_traffic_ctl(struct ql_adapter *qdev, u32 control)
+int qlge_mb_set_mgmnt_traffic_ctl(struct qlge_adapter *qdev, u32 control)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 
 	mbcp->in_count = 1;
 	mbcp->out_count = 2;
@@ -1017,7 +1017,7 @@ int ql_mb_set_mgmnt_traffic_ctl(struct ql_adapter *qdev, u32 control)
 	mbcp->mbox_in[0] = MB_CMD_SET_MGMNT_TFK_CTL;
 	mbcp->mbox_in[1] = control;
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -1040,13 +1040,13 @@ int ql_mb_set_mgmnt_traffic_ctl(struct ql_adapter *qdev, u32 control)
 }
 
 /* Returns a negative error code or the mailbox command status. */
-static int ql_mb_get_mgmnt_traffic_ctl(struct ql_adapter *qdev, u32 *control)
+static int qlge_mb_get_mgmnt_traffic_ctl(struct qlge_adapter *qdev, u32 *control)
 {
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int status;
 
-	memset(mbcp, 0, sizeof(struct mbox_params));
+	memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 	*control = 0;
 
 	mbcp->in_count = 1;
@@ -1054,7 +1054,7 @@ static int ql_mb_get_mgmnt_traffic_ctl(struct ql_adapter *qdev, u32 *control)
 
 	mbcp->mbox_in[0] = MB_CMD_GET_MGMNT_TFK_CTL;
 
-	status = ql_mailbox_command(qdev, mbcp);
+	status = qlge_mailbox_command(qdev, mbcp);
 	if (status)
 		return status;
 
@@ -1075,15 +1075,15 @@ static int ql_mb_get_mgmnt_traffic_ctl(struct ql_adapter *qdev, u32 *control)
 	return status;
 }
 
-int ql_wait_fifo_empty(struct ql_adapter *qdev)
+int qlge_wait_fifo_empty(struct qlge_adapter *qdev)
 {
 	int count = 5;
 	u32 mgmnt_fifo_empty;
 	u32 nic_fifo_empty;
 
 	do {
-		nic_fifo_empty = ql_read32(qdev, STS) & STS_NFE;
-		ql_mb_get_mgmnt_traffic_ctl(qdev, &mgmnt_fifo_empty);
+		nic_fifo_empty = qlge_read32(qdev, STS) & STS_NFE;
+		qlge_mb_get_mgmnt_traffic_ctl(qdev, &mgmnt_fifo_empty);
 		mgmnt_fifo_empty &= MB_GET_MPI_TFK_FIFO_EMPTY;
 		if (nic_fifo_empty && mgmnt_fifo_empty)
 			return 0;
@@ -1095,14 +1095,14 @@ int ql_wait_fifo_empty(struct ql_adapter *qdev)
 /* API called in work thread context to set new TX/RX
  * maximum frame size values to match MTU.
  */
-static int ql_set_port_cfg(struct ql_adapter *qdev)
+static int qlge_set_port_cfg(struct qlge_adapter *qdev)
 {
 	int status;
 
-	status = ql_mb_set_port_cfg(qdev);
+	status = qlge_mb_set_port_cfg(qdev);
 	if (status)
 		return status;
-	status = ql_idc_wait(qdev);
+	status = qlge_idc_wait(qdev);
 	return status;
 }
 
@@ -1114,13 +1114,13 @@ static int ql_set_port_cfg(struct ql_adapter *qdev)
  * from the firmware and, if necessary, changes them to match
  * the MTU setting.
  */
-void ql_mpi_port_cfg_work(struct work_struct *work)
+void qlge_mpi_port_cfg_work(struct work_struct *work)
 {
-	struct ql_adapter *qdev =
-	    container_of(work, struct ql_adapter, mpi_port_cfg_work.work);
+	struct qlge_adapter *qdev =
+	    container_of(work, struct qlge_adapter, mpi_port_cfg_work.work);
 	int status;
 
-	status = ql_mb_get_port_cfg(qdev);
+	status = qlge_mb_get_port_cfg(qdev);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Bug: Failed to get port config data.\n");
@@ -1133,17 +1133,17 @@ void ql_mpi_port_cfg_work(struct work_struct *work)
 
 	qdev->link_config |=	CFG_JUMBO_FRAME_SIZE;
 	qdev->max_frame_size = CFG_DEFAULT_MAX_FRAME_SIZE;
-	status = ql_set_port_cfg(qdev);
+	status = qlge_set_port_cfg(qdev);
 	if (status) {
 		netif_err(qdev, drv, qdev->ndev,
 			  "Bug: Failed to set port config data.\n");
 		goto err;
 	}
 end:
-	clear_bit(QL_PORT_CFG, &qdev->flags);
+	clear_bit(QLGE_PORT_CFG, &qdev->flags);
 	return;
 err:
-	ql_queue_fw_error(qdev);
+	qlge_queue_fw_error(qdev);
 	goto end;
 }
 
@@ -1153,12 +1153,12 @@ void ql_mpi_port_cfg_work(struct work_struct *work)
  * has been made and then send a mailbox command ACKing
  * the change request.
  */
-void ql_mpi_idc_work(struct work_struct *work)
+void qlge_mpi_idc_work(struct work_struct *work)
 {
-	struct ql_adapter *qdev =
-	    container_of(work, struct ql_adapter, mpi_idc_work.work);
+	struct qlge_adapter *qdev =
+	    container_of(work, struct qlge_adapter, mpi_idc_work.work);
 	int status;
-	struct mbox_params *mbcp = &qdev->idc_mbc;
+	struct qlge_mbox_params *mbcp = &qdev->idc_mbc;
 	u32 aen;
 	int timeout;
 
@@ -1172,17 +1172,17 @@ void ql_mpi_idc_work(struct work_struct *work)
 		break;
 	case MB_CMD_PORT_RESET:
 	case MB_CMD_STOP_FW:
-		ql_link_off(qdev);
+		qlge_link_off(qdev);
 		/* Fall through */
 	case MB_CMD_SET_PORT_CFG:
 		/* Signal the resulting link up AEN
 		 * that the frame routing and mac addr
 		 * needs to be set.
 		 * */
-		set_bit(QL_CAM_RT_SET, &qdev->flags);
+		set_bit(QLGE_CAM_RT_SET, &qdev->flags);
 		/* Do ACK if required */
 		if (timeout) {
-			status = ql_mb_idc_ack(qdev);
+			status = qlge_mb_idc_ack(qdev);
 			if (status)
 				netif_err(qdev, drv, qdev->ndev,
 					  "Bug: No pending IDC!\n");
@@ -1204,8 +1204,8 @@ void ql_mpi_idc_work(struct work_struct *work)
 		/* Drop the link, reload the routing
 		 * table when link comes up.
 		 */
-		ql_link_off(qdev);
-		set_bit(QL_CAM_RT_SET, &qdev->flags);
+		qlge_link_off(qdev);
+		set_bit(QLGE_CAM_RT_SET, &qdev->flags);
 		/* Fall through. */
 	case MB_CMD_IOP_DVR_START:
 	case MB_CMD_IOP_FLASH_ACC:
@@ -1215,7 +1215,7 @@ void ql_mpi_idc_work(struct work_struct *work)
 	case MB_CMD_IOP_NONE:	/*  an IDC without params */
 		/* Do ACK if required */
 		if (timeout) {
-			status = ql_mb_idc_ack(qdev);
+			status = qlge_mb_idc_ack(qdev);
 			if (status)
 				netif_err(qdev, drv, qdev->ndev,
 					  "Bug: No pending IDC!\n");
@@ -1228,54 +1228,54 @@ void ql_mpi_idc_work(struct work_struct *work)
 	}
 }
 
-void ql_mpi_work(struct work_struct *work)
+void qlge_mpi_work(struct work_struct *work)
 {
-	struct ql_adapter *qdev =
-	    container_of(work, struct ql_adapter, mpi_work.work);
-	struct mbox_params mbc;
-	struct mbox_params *mbcp = &mbc;
+	struct qlge_adapter *qdev =
+	    container_of(work, struct qlge_adapter, mpi_work.work);
+	struct qlge_mbox_params mbc;
+	struct qlge_mbox_params *mbcp = &mbc;
 	int err = 0;
 
 	mutex_lock(&qdev->mpi_mutex);
 	/* Begin polled mode for MPI */
-	ql_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
+	qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16));
 
-	while (ql_read32(qdev, STS) & STS_PI) {
-		memset(mbcp, 0, sizeof(struct mbox_params));
+	while (qlge_read32(qdev, STS) & STS_PI) {
+		memset(mbcp, 0, sizeof(struct qlge_mbox_params));
 		mbcp->out_count = 1;
 		/* Don't continue if an async event
 		 * did not complete properly.
 		 */
-		err = ql_mpi_handler(qdev, mbcp);
+		err = qlge_mpi_handler(qdev, mbcp);
 		if (err)
 			break;
 	}
 
 	/* End polled mode for MPI */
-	ql_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16) | INTR_MASK_PI);
+	qlge_write32(qdev, INTR_MASK, (INTR_MASK_PI << 16) | INTR_MASK_PI);
 	mutex_unlock(&qdev->mpi_mutex);
 }
 
-void ql_mpi_reset_work(struct work_struct *work)
+void qlge_mpi_reset_work(struct work_struct *work)
 {
-	struct ql_adapter *qdev =
-	    container_of(work, struct ql_adapter, mpi_reset_work.work);
+	struct qlge_adapter *qdev =
+	    container_of(work, struct qlge_adapter, mpi_reset_work.work);
 	cancel_delayed_work_sync(&qdev->mpi_work);
 	cancel_delayed_work_sync(&qdev->mpi_port_cfg_work);
 	cancel_delayed_work_sync(&qdev->mpi_idc_work);
 	/* If we're not the dominant NIC function,
 	 * then there is nothing to do.
 	 */
-	if (!ql_own_firmware(qdev)) {
+	if (!qlge_own_firmware(qdev)) {
 		netif_err(qdev, drv, qdev->ndev, "Don't own firmware!\n");
 		return;
 	}
 
-	if (qdev->mpi_coredump && !ql_core_dump(qdev, qdev->mpi_coredump)) {
+	if (qdev->mpi_coredump && !qlge_core_dump(qdev, qdev->mpi_coredump)) {
 		netif_err(qdev, drv, qdev->ndev, "Core is dumped!\n");
 		qdev->core_is_dumped = 1;
 		queue_delayed_work(qdev->workqueue,
 				   &qdev->mpi_core_to_log, 5 * HZ);
 	}
-	ql_soft_reset_mpi_risc(qdev);
+	qlge_soft_reset_mpi_risc(qdev);
 }
-- 
2.17.1

