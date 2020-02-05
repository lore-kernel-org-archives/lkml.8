Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC699C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68FE222D9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMa4T+ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgBEPz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38826 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgBEPzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so1417963pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=u1cAZL9ccoEDbLGWKB9jm2v64PDcsO++iTOy4WtzRP0=;
        b=JMa4T+ws8shCNHx16TbsTbxZdnfu6YF6Hr1qBsRuiJcG4E2w8tb83QNFiMB5ko4bmN
         vWZmMPWd6qzApH/icfsGl3/SL2ydxP3ojwATyV3A6L2ny+34xCSKPU+gcWrVyVnBJwDN
         G3ktq46rIRps0ME9X2ZkwLr7G1uv1yLsXQobc4qoTxn2fQk7YD9PtY2Qgk9aYM94St+1
         qeIjxlnuwzK56ocUWckheya9aNWYaS0pQsCtT1aWZJVon5CvWP3yTvecyzpAimF2J2v8
         bbxBEDjmjLwTfZF1m1rgKbkOk9MkHCjpwBUSg52fQiZxrNak3SMIj4GREuT6BvSpoE+E
         Ux7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=u1cAZL9ccoEDbLGWKB9jm2v64PDcsO++iTOy4WtzRP0=;
        b=htFJ4imELbrlyOT1DPfL+e9vqd6HHam5k6mAAD+mG0+m9+1qvE7+SNQF0qJgbq8I9N
         +38psF2q8Gaqa6z4DZojIHgSMa0uv5tiHH5TZdJ3k13RcdyfHE8ZYDmX/pk6YAziUYfy
         c6vJeyHYC5jKUyI8N4lV1QeOAj/HT1bnPVh4x2+J3GXcVYXxvWcqB7OD3SlmckMwrYk+
         Sl4MsUuxMuxUu3b0gJKl/jucV5BJ9wuGIbaOI0UO5gzWMbB5zb6gZ4+H7ShizS9vC8tR
         fyo4km2CYtfo4qqD4kxg10Cs7unxN/g5LEqX5944JTRbwzb49v2Zt9c8OGvWCTsRlSBm
         zJcw==
X-Gm-Message-State: APjAAAXpax0vbmhTtG0b/EAF0SE6HmiT2ttNHkU0YkkoBHqP0Ag07WCC
        azEw6cO60GIND9HRPa+GcrI=
X-Google-Smtp-Source: APXvYqynanJ+h0dRTwIrai7J6nOrCslS9StZirKZFUoAmsRGUvNaja7q5WSrrY6r3EXrteefNv57gA==
X-Received: by 2002:aa7:8149:: with SMTP id d9mr35921404pfn.170.1580918124265;
        Wed, 05 Feb 2020 07:55:24 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:23 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 12/15] NTB: return link up status correctly for PRI and SEC
Date:   Wed,  5 Feb 2020 21:24:29 +0530
Message-Id: <542aee58e6c78f240da80b3de84f8fa0b88ae6ad.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since NTB connects two physically separate systems,
there can be scenarios where one system goes down
while the other one remains active. In case of NTB
primary, if the NTB secondary goes down, a Link-Down
event is received. For the NTB secondary, if the
NTB primary goes down, the PCIe hotplug mechanism
ensures that the driver on the secondary side is also
unloaded.

But there are other scenarios to consider as well,
when suppose the physical link remains active, but
the driver on primary or secondary side is loaded
or un-loaded.

When the driver is loaded, on either side, it sets
SIDE_READY bit(bit-1) of SIDE_INFO register. Similarly,
when the driver is un-loaded, it resets the same bit.

We consider the NTB link to be up and operational
only when the driver on both sides of link are loaded
and ready. But we also need to take account of
Link Up and Down events which signify the physical
link status. So amd_link_is_up() is modified to take
care of the above scenarios.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 64 ++++++++++++++++++++++++++++++---
 drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d4029d531466..8a9852343de6 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -245,12 +245,66 @@ static int amd_ntb_get_link_status(struct amd_ntb_dev *ndev)
 
 static int amd_link_is_up(struct amd_ntb_dev *ndev)
 {
-	if (!ndev->peer_sta)
-		return ndev->cntl_sta;
+	int ret;
+
+	/*
+	 * We consider the link to be up under two conditions:
+	 *
+	 *   - When a link-up event is received. This is indicated by
+	 *     AMD_LINK_UP_EVENT set in peer_sta.
+	 *   - When driver on both sides of the link have been loaded.
+	 *     This is indicated by bit 1 being set in the peer
+	 *     SIDEINFO register.
+	 *
+	 * This function should return 1 when the latter of the above
+	 * two conditions is true.
+	 *
+	 * Now consider the sequence of events - Link-Up event occurs,
+	 * then the peer side driver loads. In this case, we would have
+	 * received LINK_UP event and bit 1 of peer SIDEINFO is also
+	 * set. What happens now if the link goes down? Bit 1 of
+	 * peer SIDEINFO remains set, but LINK_DOWN bit is set in
+	 * peer_sta. So we should return 0 from this function. Not only
+	 * that, we clear bit 1 of peer SIDEINFO to 0, since the peer
+	 * side driver did not even get a chance to clear it before
+	 * the link went down. This can be the case of surprise link
+	 * removal.
+	 *
+	 * LINK_UP event will always occur before the peer side driver
+	 * gets loaded the very first time. So there can be a case when
+	 * the LINK_UP event has occurred, but the peer side driver hasn't
+	 * yet loaded. We return 0 in that case.
+	 *
+	 * There is also a special case when the primary side driver is
+	 * unloaded and then loaded again. Since there is no change in
+	 * the status of NTB secondary in this case, there is no Link-Up
+	 * or Link-Down notification received. We recognize this condition
+	 * with peer_sta being set to 0.
+	 *
+	 * If bit 1 of peer SIDEINFO register is not set, then we
+	 * simply return 0 irrespective of the link up or down status
+	 * set in peer_sta.
+	 */
+	ret = amd_poll_link(ndev);
+	if (ret) {
+		/*
+		 * We need to check the below only for NTB primary. For NTB
+		 * secondary, simply checking the result of PSIDE_INFO
+		 * register will suffice.
+		 */
+		if (ndev->ntb.topo == NTB_TOPO_PRI) {
+			if ((ndev->peer_sta & AMD_LINK_UP_EVENT) ||
+			    (ndev->peer_sta == 0))
+				return ret;
+			else if (ndev->peer_sta & AMD_LINK_DOWN_EVENT) {
+				/* Clear peer sideinfo register */
+				amd_clear_side_info_reg(ndev, true);
 
-	if (ndev->peer_sta & AMD_LINK_UP_EVENT) {
-		ndev->peer_sta = 0;
-		return 1;
+				return 0;
+			}
+		} else { /* NTB_TOPO_SEC */
+			return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 62ffdf35b683..73959c0b9972 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -217,5 +217,6 @@ struct amd_ntb_dev {
 
 static void amd_set_side_info_reg(struct amd_ntb_dev *ndev, bool peer);
 static void amd_clear_side_info_reg(struct amd_ntb_dev *ndev, bool peer);
+static int amd_poll_link(struct amd_ntb_dev *ndev);
 
 #endif
-- 
2.17.1

