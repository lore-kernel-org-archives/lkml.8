Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A5C35240
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 07:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CA0206E6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 07:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgBBHox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 02:44:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbgBBHox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 02:44:53 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF867CAA9F20E8809C09;
        Sun,  2 Feb 2020 15:44:50 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Sun, 2 Feb 2020 15:44:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Jeff Chang <jeff_chang@richtek.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: Remove unused including <linux/version.h>
Date:   Sun, 2 Feb 2020 07:39:17 +0000
Message-ID: <20200202073917.195880-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/mt6660.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/mt6660.c b/sound/soc/codecs/mt6660.c
index a36c416caad4..1a3515df1764 100644
--- a/sound/soc/codecs/mt6660.c
+++ b/sound/soc/codecs/mt6660.c
@@ -4,7 +4,6 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/pm_runtime.h>





