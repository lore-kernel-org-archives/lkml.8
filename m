Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C083C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BF620672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PG4Iie45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgF3G17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbgF3G1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:27:55 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C166C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:27:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q90so8254739pjh.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2pO4L1a3ERIETLNInBHqYAlx7Y/nJKu8b0lmcLiwBY=;
        b=PG4Iie451m7kdRRNoADr+68T27E1VRuuDU/UvbYf+T2hdaDn2AN07VwQT0hVmHZOW+
         z0cD/gwUe5pnimNGKbBF5/XBcOpuJPBexzz3fWyx2xn+KWKQuOruBEYaDA6+QcDCoCAY
         Q8VLN+ba93w8te3eMs9BAocU3+2iRe3r+Z7Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2pO4L1a3ERIETLNInBHqYAlx7Y/nJKu8b0lmcLiwBY=;
        b=N4MuY58ceaCyXRcRlnt3tnTTXg01o61weVCyZzhZh4vF8xISYimc/ogkhiON6FD2UP
         Sf7LDTJX9GtRVo4l3CHObymodoOkLbZLNiC/vNhv+hb5xeX9L08aopsYg292zJIWoY/J
         JYWV0kC1akfCVhS7pRkeyqqUkmUcHdP/sny3oNfknfPKdwRs3GS3fzgTo6MrESglPy+W
         PaA+ZOph80GUZzvNTUZqbTALev2rtrLwTtKBCBGXRYrxGYYA8l6bVHWqAWoeMa9THnXR
         lfFlnE64t12jPoiXmdICRUIZGEBFF4tXYrEhQnmow2IUtdC7LHjkFbVk7+LvoWeILtNl
         GG7Q==
X-Gm-Message-State: AOAM531uSXcgSB1rZRklTBnGjT2/0PnCgR1hRIMd/aPsQt/XNUOXBBts
        wOLHSNj3jbqGJZ+KTRNj2kHmVg==
X-Google-Smtp-Source: ABdhPJzW56aq6cC2dMDiHiI8jMvBTwnwOkR07rO4mTv5K+dFHI3zdIubNtowt84OUK+ljiTgIvT4kg==
X-Received: by 2002:a17:90b:102:: with SMTP id p2mr21406114pjz.227.1593498474783;
        Mon, 29 Jun 2020 23:27:54 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id d1sm1463366pfq.113.2020.06.29.23.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 23:27:53 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH 3/9] media: mtk-vcodec: support version 2 of decoder firmware ABI
Date:   Tue, 30 Jun 2020 15:27:05 +0900
Message-Id: <20200630062711.4169601-4-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200630062711.4169601-1-acourbot@chromium.org>
References: <20200630062711.4169601-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for decoder firmware version 2, which makes the kernel
responsible for managing the VSI context and is used for stateless
codecs.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../media/platform/mtk-vcodec/vdec_ipi_msg.h  | 18 +++++++++---
 .../media/platform/mtk-vcodec/vdec_vpu_if.c   | 28 +++++++++++++++----
 .../media/platform/mtk-vcodec/vdec_vpu_if.h   |  5 ++++
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h b/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
index eb66729fda63..a0e773ae3ab3 100644
--- a/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
+++ b/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
@@ -29,11 +29,15 @@ enum vdec_ipi_msgid {
 /**
  * struct vdec_ap_ipi_cmd - generic AP to VPU ipi command format
  * @msg_id	: vdec_ipi_msgid
- * @vpu_inst_addr	: VPU decoder instance address
+ * @vpu_inst_addr : VPU decoder instance address. Used if ABI version < 2.
+ * @inst_id     : instance ID. Used if the ABI version >= 2.
  */
 struct vdec_ap_ipi_cmd {
 	uint32_t msg_id;
-	uint32_t vpu_inst_addr;
+	union {
+		uint32_t vpu_inst_addr;
+		uint32_t inst_id;
+	};
 };
 
 /**
@@ -63,7 +67,8 @@ struct vdec_ap_ipi_init {
 /**
  * struct vdec_ap_ipi_dec_start - for AP_IPIMSG_DEC_START
  * @msg_id	: AP_IPIMSG_DEC_START
- * @vpu_inst_addr	: VPU decoder instance address
+ * @vpu_inst_addr : VPU decoder instance address. Used if ABI version < 2.
+ * @inst_id     : instance ID. Used if the ABI version >= 2.
  * @data	: Header info
  *	H264 decoder [0]:buf_sz [1]:nal_start
  *	VP8 decoder  [0]:width/height
@@ -72,7 +77,10 @@ struct vdec_ap_ipi_init {
  */
 struct vdec_ap_ipi_dec_start {
 	uint32_t msg_id;
-	uint32_t vpu_inst_addr;
+	union {
+		uint32_t vpu_inst_addr;
+		uint32_t inst_id;
+	};
 	uint32_t data[3];
 	uint32_t reserved;
 };
@@ -87,6 +95,7 @@ struct vdec_ap_ipi_dec_start {
  *			ensure that it is compatible with the firmware.
  *			This field is not valid for MT8173 and must not be
  *			accessed for this chip.
+ * @inst_id     : instance ID. Valid only if the ABI version >= 2.
  */
 struct vdec_vpu_ipi_init_ack {
 	uint32_t msg_id;
@@ -94,6 +103,7 @@ struct vdec_vpu_ipi_init_ack {
 	uint64_t ap_inst_addr;
 	uint32_t vpu_inst_addr;
 	uint32_t vdec_abi_version;
+	uint32_t inst_id;
 };
 
 #endif
diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
index 203089213e67..5dffc459a33d 100644
--- a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
@@ -25,18 +25,30 @@ static void handle_init_ack_msg(const struct vdec_vpu_ipi_init_ack *msg)
 
 	mtk_vcodec_debug(vpu, "- vpu_inst_addr = 0x%x", vpu->inst_addr);
 
+	/* Set default ABI version if dealing with unversioned firmware. */
+	vpu->fw_abi_version = 0;
+	/*
+	 * Instance ID is only used if ABI version >= 2. Initialize it with
+	 * garbage by default.
+	 */
+	vpu->inst_id = 0xdeadbeef;
+
 	/* Firmware version field does not exist on MT8173. */
 	if (vpu->ctx->dev->vdec_pdata->chip == MTK_MT8173)
 		return;
 
 	/* Check firmware version. */
-	mtk_vcodec_debug(vpu, "firmware version 0x%x\n", msg->vdec_abi_version);
-	switch (msg->vdec_abi_version) {
+	vpu->fw_abi_version = msg->vdec_abi_version;
+	mtk_vcodec_debug(vpu, "firmware version 0x%x\n", vpu->fw_abi_version);
+	switch (vpu->fw_abi_version) {
 	case 1:
 		break;
+	case 2:
+		vpu->inst_id = msg->inst_id;
+		break;
 	default:
 		mtk_vcodec_err(vpu, "unhandled firmware version 0x%x\n",
-			       msg->vdec_abi_version);
+			       vpu->fw_abi_version);
 		vpu->failure = 1;
 		break;
 	}
@@ -113,7 +125,10 @@ static int vcodec_send_ap_ipi(struct vdec_vpu_inst *vpu, unsigned int msg_id)
 
 	memset(&msg, 0, sizeof(msg));
 	msg.msg_id = msg_id;
-	msg.vpu_inst_addr = vpu->inst_addr;
+	if (vpu->fw_abi_version < 2)
+		msg.vpu_inst_addr = vpu->inst_addr;
+	else
+		msg.inst_id = vpu->inst_id;
 
 	err = vcodec_vpu_send_msg(vpu, &msg, sizeof(msg));
 	mtk_vcodec_debug(vpu, "- id=%X ret=%d", msg_id, err);
@@ -163,7 +178,10 @@ int vpu_dec_start(struct vdec_vpu_inst *vpu, uint32_t *data, unsigned int len)
 
 	memset(&msg, 0, sizeof(msg));
 	msg.msg_id = AP_IPIMSG_DEC_START;
-	msg.vpu_inst_addr = vpu->inst_addr;
+	if (vpu->fw_abi_version < 2)
+		msg.vpu_inst_addr = vpu->inst_addr;
+	else
+		msg.inst_id = vpu->inst_id;
 
 	for (i = 0; i < len; i++)
 		msg.data[i] = data[i];
diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
index 85224eb7e34b..c2ed5b6cab8b 100644
--- a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
+++ b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
@@ -18,6 +18,9 @@ struct mtk_vcodec_ctx;
  *                for control and info share
  * @failure     : VPU execution result status, 0: success, others: fail
  * @inst_addr	: VPU decoder instance address
+ * @fw_abi_version : ABI version of the firmware.
+ * @inst_id	: if fw_abi_version >= 2, contains the instance ID to be given
+ *                in place of inst_addr in messages.
  * @signaled    : 1 - Host has received ack message from VPU, 0 - not received
  * @ctx         : context for v4l2 layer integration
  * @dev		: platform device of VPU
@@ -29,6 +32,8 @@ struct vdec_vpu_inst {
 	void *vsi;
 	int32_t failure;
 	uint32_t inst_addr;
+	uint32_t fw_abi_version;
+	uint32_t inst_id;
 	unsigned int signaled;
 	struct mtk_vcodec_ctx *ctx;
 	wait_queue_head_t wq;
-- 
2.27.0.212.ge8ba1cc988-goog

