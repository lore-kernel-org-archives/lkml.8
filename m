Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1931C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19DC206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467955;
	bh=skab10pUnxwFQjJua5piPQQtoGTRAnUvIp1ssSV1OBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f9wMVYc7/SKZxbBG3Fyt4hmA6E3nT4ebHcswQnfOyu9OzBbxgtEyQCT4xO5bOWq5H
	 rqT9AKjYohIrsCzdCoPd4EyI2UH1iM7s7zOcQt0avTKF3f0gftUqcbyLzFI5y47OH0
	 zL9DKWqlASg9OQS9NT3Df4akDy3oPRz7O8ZFJ1M8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404491AbgF2V7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgF2Sf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 700F824722;
        Mon, 29 Jun 2020 15:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444045;
        bh=skab10pUnxwFQjJua5piPQQtoGTRAnUvIp1ssSV1OBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1PWhyfViwi9ihM6dDaKFAn1zM0S5t2M8e4DIaNcNXUUF8M0ME8kc6pr7c/bJGzU4
         Z841QAPFV3VcTvWfdUGhigtfmounydVwumy6dqNhWakMZlL7CV7rmOgpO3zjwsuwcF
         LAfoZJzj+2WtvFu7ZyKaJAYZVgZTayFY6aPwrSLQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Lobakin <alobakin@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 152/265] net: qede: fix PTP initialization on recovery
Date:   Mon, 29 Jun 2020 11:16:25 -0400
Message-Id: <20200629151818.2493727-153-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@marvell.com>

[ Upstream commit 1c85f394c2206ea3835f43534d5675f0574e1b70 ]

Currently PTP cyclecounter and timecounter are initialized only on
the first probing and are cleaned up during removal. This means that
PTP becomes non-functional after device recovery.
Fix this by unconditional PTP initialization on probing and clearing
Tx pending bit on exiting.

Fixes: ccc67ef50b90 ("qede: Error recovery process")
Signed-off-by: Alexander Lobakin <alobakin@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c  | 31 ++++++++------------
 drivers/net/ethernet/qlogic/qede/qede_ptp.h  |  2 +-
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 1a83d1fd8ccd6..51bb5866a212c 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -1158,7 +1158,7 @@ static int __qede_probe(struct pci_dev *pdev, u32 dp_module, u8 dp_level,
 
 	/* PTP not supported on VFs */
 	if (!is_vf)
-		qede_ptp_enable(edev, (mode == QEDE_PROBE_NORMAL));
+		qede_ptp_enable(edev);
 
 	edev->ops->register_ops(cdev, &qede_ll_ops, edev);
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ptp.c b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
index 4c7f7a7fc1515..cd5841a9415ef 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
@@ -412,6 +412,7 @@ void qede_ptp_disable(struct qede_dev *edev)
 	if (ptp->tx_skb) {
 		dev_kfree_skb_any(ptp->tx_skb);
 		ptp->tx_skb = NULL;
+		clear_bit_unlock(QEDE_FLAGS_PTP_TX_IN_PRORGESS, &edev->flags);
 	}
 
 	/* Disable PTP in HW */
@@ -423,7 +424,7 @@ void qede_ptp_disable(struct qede_dev *edev)
 	edev->ptp = NULL;
 }
 
-static int qede_ptp_init(struct qede_dev *edev, bool init_tc)
+static int qede_ptp_init(struct qede_dev *edev)
 {
 	struct qede_ptp *ptp;
 	int rc;
@@ -444,25 +445,19 @@ static int qede_ptp_init(struct qede_dev *edev, bool init_tc)
 	/* Init work queue for Tx timestamping */
 	INIT_WORK(&ptp->work, qede_ptp_task);
 
-	/* Init cyclecounter and timecounter. This is done only in the first
-	 * load. If done in every load, PTP application will fail when doing
-	 * unload / load (e.g. MTU change) while it is running.
-	 */
-	if (init_tc) {
-		memset(&ptp->cc, 0, sizeof(ptp->cc));
-		ptp->cc.read = qede_ptp_read_cc;
-		ptp->cc.mask = CYCLECOUNTER_MASK(64);
-		ptp->cc.shift = 0;
-		ptp->cc.mult = 1;
-
-		timecounter_init(&ptp->tc, &ptp->cc,
-				 ktime_to_ns(ktime_get_real()));
-	}
+	/* Init cyclecounter and timecounter */
+	memset(&ptp->cc, 0, sizeof(ptp->cc));
+	ptp->cc.read = qede_ptp_read_cc;
+	ptp->cc.mask = CYCLECOUNTER_MASK(64);
+	ptp->cc.shift = 0;
+	ptp->cc.mult = 1;
 
-	return rc;
+	timecounter_init(&ptp->tc, &ptp->cc, ktime_to_ns(ktime_get_real()));
+
+	return 0;
 }
 
-int qede_ptp_enable(struct qede_dev *edev, bool init_tc)
+int qede_ptp_enable(struct qede_dev *edev)
 {
 	struct qede_ptp *ptp;
 	int rc;
@@ -483,7 +478,7 @@ int qede_ptp_enable(struct qede_dev *edev, bool init_tc)
 
 	edev->ptp = ptp;
 
-	rc = qede_ptp_init(edev, init_tc);
+	rc = qede_ptp_init(edev);
 	if (rc)
 		goto err1;
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ptp.h b/drivers/net/ethernet/qlogic/qede/qede_ptp.h
index 691a14c4b2c5a..89c7f3cf3ee28 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.h
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.h
@@ -41,7 +41,7 @@ void qede_ptp_rx_ts(struct qede_dev *edev, struct sk_buff *skb);
 void qede_ptp_tx_ts(struct qede_dev *edev, struct sk_buff *skb);
 int qede_ptp_hw_ts(struct qede_dev *edev, struct ifreq *req);
 void qede_ptp_disable(struct qede_dev *edev);
-int qede_ptp_enable(struct qede_dev *edev, bool init_tc);
+int qede_ptp_enable(struct qede_dev *edev);
 int qede_ptp_get_ts_info(struct qede_dev *edev, struct ethtool_ts_info *ts);
 
 static inline void qede_ptp_record_rx_ts(struct qede_dev *edev,
-- 
2.25.1

