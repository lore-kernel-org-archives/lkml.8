Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D972C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107B4206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgDTOXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:23:45 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3509 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgDTOXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:23:44 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15e9db059e8a-d6ef1; Mon, 20 Apr 2020 22:23:21 +0800 (CST)
X-RM-TRANSID: 2ee15e9db059e8a-d6ef1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.173.179])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25e9db056663-c7edf;
        Mon, 20 Apr 2020 22:23:21 +0800 (CST)
X-RM-TRANSID: 2ee25e9db056663-c7edf
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: mxs-saif: Avoid unnecessary check
Date:   Mon, 20 Apr 2020 22:25:09 +0800
Message-Id: <20200420142509.9728-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function mxs_saif_probe() is only called with an
openfirmware platform device. Therefore there is no
need to check that it has an openfirmware node.

Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/mxs/mxs-saif.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 1e38ce858..64c095b91 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -736,9 +736,6 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	int irq, ret = 0;
 	struct device_node *master;
 
-	if (!np)
-		return -EINVAL;
-
 	saif = devm_kzalloc(&pdev->dev, sizeof(*saif), GFP_KERNEL);
 	if (!saif)
 		return -ENOMEM;
-- 
2.20.1.windows.1



