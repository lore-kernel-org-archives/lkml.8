Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1934FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E6520658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594969;
	bh=IEa2006O3n8PmfNmAyzY7CaL01uzQV8tXZR6GUr7JOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TIBZpxh2DeLUYcQDlrBnmnwGQl8OYvRNHeZfQO5pn35myCYqnlitvf1mP/56hM6xt
	 37PZBkBUH76+yJgpTYm/ZCtz+8wX2+MOFPO3CLTxyon+GXM0d2GgzHZJV2ZkwQ6bfM
	 IYZn9+m6HVg84pLwSJeOpykTLtC4opUloQzUj8jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbgIHT4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:32818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbgIHPgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:36:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A8C22955;
        Tue,  8 Sep 2020 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579322;
        bh=IEa2006O3n8PmfNmAyzY7CaL01uzQV8tXZR6GUr7JOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Br4/KT5N7U4CUju87NdQjxNMZdafgqSgEHPZxsTOgFjteBxNUfjbiBSq0A9y41E8m
         UJISDbRR3/BVzbQMRLhECg1JRpoNSbUejzERQrGGDv8j79z8milEKx8xmmk3vbOxBV
         odSJxSZLbDD8ujdCrNrWkhX8gFCSKy3Wv++9V6aY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ofir Bitton <obitton@habana.ai>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 012/186] habanalabs: validate packet id during CB parse
Date:   Tue,  8 Sep 2020 17:22:34 +0200
Message-Id: <20200908152242.249775040@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

[ Upstream commit bc75be24fa88ef10eecaff2b2a9ada8189e5ab5d ]

During command buffer parsing, driver extracts packet id
from user buffer. Driver must validate this packet id, since it is
being used in order to extract information from internal structures.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 35 +++++++++++++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c   | 31 ++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 637a9d608707f..0261f60df5633 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -154,6 +154,29 @@ static const u16 gaudi_packet_sizes[MAX_PACKET_ID] = {
 	[PACKET_LOAD_AND_EXE]	= sizeof(struct packet_load_and_exe)
 };
 
+static inline bool validate_packet_id(enum packet_id id)
+{
+	switch (id) {
+	case PACKET_WREG_32:
+	case PACKET_WREG_BULK:
+	case PACKET_MSG_LONG:
+	case PACKET_MSG_SHORT:
+	case PACKET_CP_DMA:
+	case PACKET_REPEAT:
+	case PACKET_MSG_PROT:
+	case PACKET_FENCE:
+	case PACKET_LIN_DMA:
+	case PACKET_NOP:
+	case PACKET_STOP:
+	case PACKET_ARB_POINT:
+	case PACKET_WAIT:
+	case PACKET_LOAD_AND_EXE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const char * const
 gaudi_tpc_interrupts_cause[GAUDI_NUM_OF_TPC_INTR_CAUSE] = {
 	"tpc_address_exceed_slm",
@@ -3859,6 +3882,12 @@ static int gaudi_validate_cb(struct hl_device *hdev,
 				PACKET_HEADER_PACKET_ID_MASK) >>
 					PACKET_HEADER_PACKET_ID_SHIFT);
 
+		if (!validate_packet_id(pkt_id)) {
+			dev_err(hdev->dev, "Invalid packet id %u\n", pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
 		pkt_size = gaudi_packet_sizes[pkt_id];
 		cb_parsed_length += pkt_size;
 		if (cb_parsed_length > parser->user_cb_size) {
@@ -4082,6 +4111,12 @@ static int gaudi_patch_cb(struct hl_device *hdev,
 				PACKET_HEADER_PACKET_ID_MASK) >>
 					PACKET_HEADER_PACKET_ID_SHIFT);
 
+		if (!validate_packet_id(pkt_id)) {
+			dev_err(hdev->dev, "Invalid packet id %u\n", pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
 		pkt_size = gaudi_packet_sizes[pkt_id];
 		cb_parsed_length += pkt_size;
 		if (cb_parsed_length > parser->user_cb_size) {
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 88460b2138d88..c179085ced7b8 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -139,6 +139,25 @@ static u16 goya_packet_sizes[MAX_PACKET_ID] = {
 	[PACKET_STOP]		= sizeof(struct packet_stop)
 };
 
+static inline bool validate_packet_id(enum packet_id id)
+{
+	switch (id) {
+	case PACKET_WREG_32:
+	case PACKET_WREG_BULK:
+	case PACKET_MSG_LONG:
+	case PACKET_MSG_SHORT:
+	case PACKET_CP_DMA:
+	case PACKET_MSG_PROT:
+	case PACKET_FENCE:
+	case PACKET_LIN_DMA:
+	case PACKET_NOP:
+	case PACKET_STOP:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static u64 goya_mmu_regs[GOYA_MMU_REGS_NUM] = {
 	mmDMA_QM_0_GLBL_NON_SECURE_PROPS,
 	mmDMA_QM_1_GLBL_NON_SECURE_PROPS,
@@ -3381,6 +3400,12 @@ static int goya_validate_cb(struct hl_device *hdev,
 				PACKET_HEADER_PACKET_ID_MASK) >>
 					PACKET_HEADER_PACKET_ID_SHIFT);
 
+		if (!validate_packet_id(pkt_id)) {
+			dev_err(hdev->dev, "Invalid packet id %u\n", pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
 		pkt_size = goya_packet_sizes[pkt_id];
 		cb_parsed_length += pkt_size;
 		if (cb_parsed_length > parser->user_cb_size) {
@@ -3616,6 +3641,12 @@ static int goya_patch_cb(struct hl_device *hdev,
 				PACKET_HEADER_PACKET_ID_MASK) >>
 					PACKET_HEADER_PACKET_ID_SHIFT);
 
+		if (!validate_packet_id(pkt_id)) {
+			dev_err(hdev->dev, "Invalid packet id %u\n", pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
 		pkt_size = goya_packet_sizes[pkt_id];
 		cb_parsed_length += pkt_size;
 		if (cb_parsed_length > parser->user_cb_size) {
-- 
2.25.1



