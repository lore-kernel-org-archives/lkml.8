Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2756C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1950206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460389;
	bh=O3Sl3Zmj13GtombGOkybZSX876YS3KMgO+6+2EF6B1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=znZxJlmPjt5hZloTvVoASzHzxDbhoiwbnasi11zsc/TzeMdC0nxnBCxtgPzOxOvzE
	 Vv7VkEdk1towA/muLKZ2z8hdC1oFH6QZaLgo+po+yI67Ba5Zfp1l+uAUbfYAG1gOaE
	 lcqOC70XeRQq6Yx0FRLubPO33zHJ7l2lek88sPmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbgF2TxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387690AbgF2Tk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D537C248C2;
        Mon, 29 Jun 2020 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444417;
        bh=O3Sl3Zmj13GtombGOkybZSX876YS3KMgO+6+2EF6B1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CN6cXVxv4UMRi7X1sQNKBt6Wi0esZS+0lrQ4HFEY19bvVSyboauTj5UfygSShkNKD
         vjiejswDzKpgXrgCp3fIQsAcDtMybQ7PIvMsIVs5dQqWyqaB3IgE3/H5YMVjgXMqp6
         1xsPd6b9rKvYNQuAYewBkjAZhhEfDLDrHNhupubk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Lobakin <alobakin@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 095/178] net: qed: fix NVMe login fails over VFs
Date:   Mon, 29 Jun 2020 11:24:00 -0400
Message-Id: <20200629152523.2494198-96-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@marvell.com>

[ Upstream commit ccd7c7ce167a21dbf2b698ffcf00f11d96d44f9b ]

25ms sleep cycles in waiting for PF response are excessive and may lead
to different timeout failures.

Start to wait with short udelays, and in most cases polling will end
here. If the time was not sufficient, switch to msleeps.
usleep_range() may go far beyond 100us depending on platform and tick
configuration, hence atomic udelays for consistency.

Also add explicit DMA barriers since 'done' always comes from a shared
request-response DMA pool, and note that in the comment nearby.

Fixes: 1408cc1fa48c ("qed: Introduce VFs")
Signed-off-by: Alexander Lobakin <alobakin@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index 856051f50eb75..adc2c8f3d48ef 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -81,12 +81,17 @@ static void qed_vf_pf_req_end(struct qed_hwfn *p_hwfn, int req_status)
 	mutex_unlock(&(p_hwfn->vf_iov_info->mutex));
 }
 
+#define QED_VF_CHANNEL_USLEEP_ITERATIONS	90
+#define QED_VF_CHANNEL_USLEEP_DELAY		100
+#define QED_VF_CHANNEL_MSLEEP_ITERATIONS	10
+#define QED_VF_CHANNEL_MSLEEP_DELAY		25
+
 static int qed_send_msg2pf(struct qed_hwfn *p_hwfn, u8 *done, u32 resp_size)
 {
 	union vfpf_tlvs *p_req = p_hwfn->vf_iov_info->vf2pf_request;
 	struct ustorm_trigger_vf_zone trigger;
 	struct ustorm_vf_zone *zone_data;
-	int rc = 0, time = 100;
+	int iter, rc = 0;
 
 	zone_data = (struct ustorm_vf_zone *)PXP_VF_BAR0_START_USDM_ZONE_B;
 
@@ -126,11 +131,19 @@ static int qed_send_msg2pf(struct qed_hwfn *p_hwfn, u8 *done, u32 resp_size)
 	REG_WR(p_hwfn, (uintptr_t)&zone_data->trigger, *((u32 *)&trigger));
 
 	/* When PF would be done with the response, it would write back to the
-	 * `done' address. Poll until then.
+	 * `done' address from a coherent DMA zone. Poll until then.
 	 */
-	while ((!*done) && time) {
-		msleep(25);
-		time--;
+
+	iter = QED_VF_CHANNEL_USLEEP_ITERATIONS;
+	while (!*done && iter--) {
+		udelay(QED_VF_CHANNEL_USLEEP_DELAY);
+		dma_rmb();
+	}
+
+	iter = QED_VF_CHANNEL_MSLEEP_ITERATIONS;
+	while (!*done && iter--) {
+		msleep(QED_VF_CHANNEL_MSLEEP_DELAY);
+		dma_rmb();
 	}
 
 	if (!*done) {
-- 
2.25.1

