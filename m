Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9382BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E30220738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgFDItu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:49:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbgFDItu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:49:50 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 100E8CF62E65406A1F6D;
        Thu,  4 Jun 2020 16:49:48 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 4 Jun 2020 16:49:37 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <steves.lee@maximintegrated.com>
CC:     <nixiaoming@huawei.com>, <alex.huangjianhui@huawei.com>,
        <dylix.dailei@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: max98390: fix build warning detected by -Wformat
Date:   Thu, 4 Jun 2020 16:49:34 +0800
Message-ID: <1591260574-12717-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warning:
	sound/soc/codecs/max98390.c:781:3: warning: format '%ld' expects
	argument of type 'long int', but argument 4 has type 'size_t {aka
	const unsigned int}' [-Wformat=]

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 sound/soc/codecs/max98390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index b9ce44d..884ee55 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -778,7 +778,7 @@ static int max98390_dsm_init(struct snd_soc_component *component)
 	}
 
 	dev_dbg(component->dev,
-		"max98390: param fw size %ld\n",
+		"max98390: param fw size %zu\n",
 		fw->size);
 	dsm_param = (char *)fw->data;
 	dsm_param += MAX98390_DSM_PAYLOAD_OFFSET;
-- 
1.8.5.6

