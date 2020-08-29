Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D11FC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 02:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F34020838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 02:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgH2CIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 22:08:18 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:32043 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgH2CIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 22:08:17 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.125])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 4B918481954;
        Sat, 29 Aug 2020 10:08:14 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] gpu/ipu-v3:reduce protected code area in ipu idmac get/put
Date:   Fri, 28 Aug 2020 19:08:07 -0700
Message-Id: <20200829020807.6568-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTBkfQx1OSx9CTEhOVkpOQkNNTU1DQk9PSE1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzY6Fio5Gj8qEipDGQkXEixJ
        GglPFBdVSlVKTkJDTU1NQ0JPQ0hDVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSU5CSzcG
X-HM-Tid: 0a7437f8ec2f93bakuws4b918481954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will speed-up a bit these ipu_idmac_get &
ipu_idmac_put processing and there is no need to protect
kzalloc & kfree.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index b3dae9ec1a38..8b3a57864c2e 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -267,29 +267,30 @@ EXPORT_SYMBOL_GPL(ipu_rot_mode_to_degrees);
 struct ipuv3_channel *ipu_idmac_get(struct ipu_soc *ipu, unsigned num)
 {
 	struct ipuv3_channel *channel;
+	struct ipuv3_channel *entry;
 
 	dev_dbg(ipu->dev, "%s %d\n", __func__, num);
 
 	if (num > 63)
 		return ERR_PTR(-ENODEV);
 
+	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
+	if (!channel)
+		return ERR_PTR(-ENOMEM);
+
+	channel->num = num;
+	channel->ipu = ipu;
+
 	mutex_lock(&ipu->channel_lock);
 
-	list_for_each_entry(channel, &ipu->channels, list) {
-		if (channel->num == num) {
+	list_for_each_entry(entry, &ipu->channels, list) {
+		if (entry->num == num) {
+			kfree(channel);
 			channel = ERR_PTR(-EBUSY);
 			goto out;
 		}
 	}
 
-	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
-	if (!channel) {
-		channel = ERR_PTR(-ENOMEM);
-		goto out;
-	}
-
-	channel->num = num;
-	channel->ipu = ipu;
 	list_add(&channel->list, &ipu->channels);
 
 out:
@@ -308,9 +309,10 @@ void ipu_idmac_put(struct ipuv3_channel *channel)
 	mutex_lock(&ipu->channel_lock);
 
 	list_del(&channel->list);
-	kfree(channel);
 
 	mutex_unlock(&ipu->channel_lock);
+
+	kfree(channel);
 }
 EXPORT_SYMBOL_GPL(ipu_idmac_put);
 
-- 
2.28.0

