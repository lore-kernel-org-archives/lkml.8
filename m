Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98364C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7012B2078C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660514;
	bh=49zfERSjk9j/+MtSTyS6zjJNybRRJ7SHS9cxP6Yyjng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vNkCCuam0u2cGxWaP15z4fJ+S+sggebDUZRhvSRVWj2i11yfQjuN78KAa1M/nLsw+
	 4eSlHmZbdMxbQTWbb6s6pY+ZeGmGQ3+OPKXquaL1ng85xYUVpVcSbf7RPXYwi0vESc
	 H9+CbLUdzluG02lpvJ92nWAaZKBnjqCxS5rBCtcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbgFHXzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731582AbgFHXYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:24:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FDB1208B3;
        Mon,  8 Jun 2020 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658647;
        bh=49zfERSjk9j/+MtSTyS6zjJNybRRJ7SHS9cxP6Yyjng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbHc/ynsYruc435t/sf93g0SrHmA36WnsPZkRqMBdD748jlOitWSxkkioo9McD5EA
         x5FeLv9Dg614/hJXffOMPIyn5XG9IJZUtoKoRSUp3sdTheYgVtz+rzINxpT67OS6Q0
         6WN+bmJh95YSp2ypO3qcIV3/jP0tTkqitySy2f/4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 067/106] nvme: refine the Qemu Identify CNS quirk
Date:   Mon,  8 Jun 2020 19:21:59 -0400
Message-Id: <20200608232238.3368589-67-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit b9a5c3d4c34d8bd9fd75f7f28d18a57cb68da237 ]

Add a helper to check if we can use Identify CNS values > 1, and refine
the Qemu quirk to not apply to reported versions larger than 1.1, as the
Qemu implementation had been fixed by then.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5359c7c811a..0d60f2f8f3ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -926,6 +926,19 @@ void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_stop_keep_alive);
 
+/*
+ * In NVMe 1.0 the CNS field was just a binary controller or namespace
+ * flag, thus sending any new CNS opcodes has a big chance of not working.
+ * Qemu unfortunately had that bug after reporting a 1.1 version compliance
+ * (but not for any later version).
+ */
+static bool nvme_ctrl_limited_cns(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)
+		return ctrl->vs < NVME_VS(1, 2, 0);
+	return ctrl->vs < NVME_VS(1, 1, 0);
+}
+
 static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 {
 	struct nvme_command c = { };
@@ -3368,8 +3381,7 @@ static void nvme_scan_work(struct work_struct *work)
 
 	mutex_lock(&ctrl->scan_lock);
 	nn = le32_to_cpu(id->nn);
-	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
-	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
+	if (!nvme_ctrl_limited_cns(ctrl)) {
 		if (!nvme_scan_ns_list(ctrl, nn))
 			goto out_free_id;
 	}
-- 
2.25.1

