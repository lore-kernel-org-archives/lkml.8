Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B180BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93931221FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGNL2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:28:05 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:51667 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgGNL2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:28:04 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35f0d96a6def-ebf3f; Tue, 14 Jul 2020 19:27:35 +0800 (CST)
X-RM-TRANSID: 2ee35f0d96a6def-ebf3f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25f0d96a30de-75649;
        Tue, 14 Jul 2020 19:27:34 +0800 (CST)
X-RM-TRANSID: 2ee25f0d96a30de-75649
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, tiwai@suse.com, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: qcom: qdsp6: Use IS_ERR() instead of IS_ERR_OR_NULL()
Date:   Tue, 14 Jul 2020 19:27:44 +0800
Message-Id: <20200714112744.20560-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function q6adm_open(), q6adm_alloc_copp() doesn't return 
NULL. Thus use IS_ERR() to validate the returned value instead 
of IS_ERR_OR_NULL(). And delete the extra line.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/qcom/qdsp6/q6adm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index d8069864b..44ac0728f 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -403,7 +403,7 @@ struct q6copp *q6adm_open(struct device *dev, int port_id, int path, int rate,
 
 	spin_lock_irqsave(&adm->copps_list_lock, flags);
 	copp = q6adm_alloc_copp(adm, port_id);
-	if (IS_ERR_OR_NULL(copp)) {
+	if (IS_ERR(copp)) {
 		spin_unlock_irqrestore(&adm->copps_list_lock, flags);
 		return ERR_CAST(copp);
 	}
@@ -419,7 +419,6 @@ struct q6copp *q6adm_open(struct device *dev, int port_id, int path, int rate,
 	copp->bit_width = bit_width;
 	copp->app_type = app_type;
 
-
 	ret = q6adm_device_open(adm, copp, port_id, path, topology,
 				channel_mode, bit_width, rate);
 	if (ret < 0) {
-- 
2.20.1.windows.1



