Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C141C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C6C206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI2J2PPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgFEUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgFEUWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:22:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F4C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 13:22:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r15so10254533wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LwkdnlZsS72dMN3D3Yk2W0lsTpgRSOfRaMK9TxqBRP0=;
        b=UI2J2PPtQSkxLtHhwnzS/+j6l7ksnzCRHY4/KN1+9iQ8YeA2gvzsbnbNdG4ZlqWolg
         JZrp0qxaDWGlYg5sGJxn30CaHgT5usgdkyieBSiQA9OU5ZSoC3LrrqpDzT1Gzr+se3Be
         MA3LawQ2u6UtEQjPxY8/DfkvJLm+/usf51oIQEz0wnnwNnhvQKD27uvrS/mlp/jJ4Xqn
         3rFR9ISeTWeWtsF6v2vivsxHljUyjLwCKgm2rK/10Xdc+Ea3VHIs47Br6RESQoJCauAn
         +EW9sF6PR5Z5Z/yLQiGRys1jYk0mobRs/51LutAk/RFPMhrnNtqkLz6ez/i8cr2w9Z/g
         zRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LwkdnlZsS72dMN3D3Yk2W0lsTpgRSOfRaMK9TxqBRP0=;
        b=SDzI1ODOh2eL77iucu0e6mZFamW72OOslo5ZzyyILDsvSH46CNrmgEP/0XqJiMCgd4
         BOl1pWMYiMR3uQ7pYVuk2/ImHBD4mXQPuvLQvuT5Y1hlCnxrOh8feMp0seI5wz5Guq42
         Lqn/KJak2dgtA6EZi38aBgqJTNsmk6VRm8P161juGa91k4/QE5KzOEiweQ1ZHQ76j0Ld
         V5QRJMQ0f8e1Set6N8YT/3Xh0/BKJk6RuWX/IG8BPKcLAwg6owz4kzmQbZZIFzATwi79
         S5F3orv0e4BhAcW2Q/DaSI+yFJy+D/P+vQGhJSVOST/gGDM6S+DwiOxD4/PWeTFiS8vN
         pC7g==
X-Gm-Message-State: AOAM532z8Ma6kC5vZtDCn/fJCFO6xlL88JEBV2Fz5Oy12kePQi5d0XH5
        Aur+qPGnDfgcrcK70b3GS3pwoqLb
X-Google-Smtp-Source: ABdhPJwJuL8IYB0F4zHpe1V8hPsoXash1CwSoo4vId6DbH4PFHChRZrtZOKj12Bxku9efcIw0D8bkg==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr4160635wmh.38.1591388561506;
        Fri, 05 Jun 2020 13:22:41 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id i10sm13160993wrw.51.2020.06.05.13.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 13:22:40 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/2] habanalabs: block scalar load_and_exe on external queue
Date:   Sat,  6 Jun 2020 00:28:41 +0300
Message-Id: <20200605212842.18424-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Gaudi, the user can't execute scalar load_and_exe on external queue
because it can be a security hole. The driver doesn't parse the commands
being loaded and it can be msg_prot, which the user isn't allowed to use.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 25 ++++++++++++++++++-
 .../habanalabs/include/gaudi/gaudi_packets.h  |  3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 61f88e9884ce..f34ac8d35a14 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3790,6 +3790,25 @@ static int gaudi_validate_dma_pkt_no_mmu(struct hl_device *hdev,
 						src_in_host);
 }
 
+static int gaudi_validate_load_and_exe_pkt(struct hl_device *hdev,
+					struct hl_cs_parser *parser,
+					struct packet_load_and_exe *user_pkt)
+{
+	u32 cfg;
+
+	cfg = le32_to_cpu(user_pkt->cfg);
+
+	if (cfg & GAUDI_PKT_LOAD_AND_EXE_CFG_DST_MASK) {
+		dev_err(hdev->dev,
+			"User not allowed to use Load and Execute\n");
+		return -EPERM;
+	}
+
+	parser->patched_cb_size += sizeof(struct packet_load_and_exe);
+
+	return 0;
+}
+
 static int gaudi_validate_cb(struct hl_device *hdev,
 			struct hl_cs_parser *parser, bool is_mmu)
 {
@@ -3838,6 +3857,11 @@ static int gaudi_validate_cb(struct hl_device *hdev,
 			rc = -EPERM;
 			break;
 
+		case PACKET_LOAD_AND_EXE:
+			rc = gaudi_validate_load_and_exe_pkt(hdev, parser,
+				(struct packet_load_and_exe *) user_pkt);
+			break;
+
 		case PACKET_LIN_DMA:
 			parser->contains_dma_pkt = true;
 			if (is_mmu)
@@ -3855,7 +3879,6 @@ static int gaudi_validate_cb(struct hl_device *hdev,
 		case PACKET_FENCE:
 		case PACKET_NOP:
 		case PACKET_ARB_POINT:
-		case PACKET_LOAD_AND_EXE:
 			parser->patched_cb_size += pkt_size;
 			break;
 
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h b/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
index 9a5800b0086b..0f0cd067bb43 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
@@ -197,6 +197,9 @@ struct packet_wait {
 	__le32 ctl;
 };
 
+#define GAUDI_PKT_LOAD_AND_EXE_CFG_DST_SHIFT	0
+#define GAUDI_PKT_LOAD_AND_EXE_CFG_DST_MASK	0x00000001
+
 struct packet_load_and_exe {
 	__le32 cfg;
 	__le32 ctl;
-- 
2.17.1

