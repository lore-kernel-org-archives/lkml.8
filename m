Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801E3C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F35246AA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgB1H4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:56:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbgB1H4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:56:31 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2C76D39943DAE07629C6;
        Fri, 28 Feb 2020 15:56:27 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 28 Feb 2020
 15:56:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oder_chiou@realtek.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: rt5682: Make rt5682_clock_config static
Date:   Fri, 28 Feb 2020 15:56:09 +0800
Message-ID: <20200228075609.38236-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

sound/soc/codecs/rt5682-sdw.c:163:5: warning:
 symbol 'rt5682_clock_config' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/rt5682-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index fc31d04..1d6963d 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -160,7 +160,7 @@ static int rt5682_read_prop(struct sdw_slave *slave)
 #define RT5682_CLK_FREQ_2400000HZ 2400000
 #define RT5682_CLK_FREQ_12288000HZ 12288000
 
-int rt5682_clock_config(struct device *dev)
+static int rt5682_clock_config(struct device *dev)
 {
 	struct rt5682_priv *rt5682 = dev_get_drvdata(dev);
 	unsigned int clk_freq, value;
-- 
2.7.4


