Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84AEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9F321582
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgGNIFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:05:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7849 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbgGNIFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:05:45 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5F5CE3D63C8E597CD903;
        Tue, 14 Jul 2020 16:05:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Jul 2020 16:05:31 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <cezary.rojewski@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <liam.r.girdwood@linux.intel.com>, <yang.jie@linux.intel.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <hdegoede@redhat.com>, <kuninori.morimoto.gx@renesas.com>,
        <paul@crapouillou.net>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Add missed put_device()
Date:   Tue, 14 Jul 2020 16:09:18 +0800
Message-ID: <20200714080918.148196-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_byt_cht_es8316_mc_probe() misses to call put_device() in an error
path. Add the missed function call to fix it.

Fixes: ba49cf6f8e4a ("ASoC: Intel: bytcht_es8316: Add quirk for inverted jack detect")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 9e5fc9430628..ecbc58e8a37f 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -543,8 +543,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 	if (cnt) {
 		ret = device_add_properties(codec_dev, props);
-		if (ret)
+		if (ret) {
+			put_device(codec_dev);
 			return ret;
+		}
 	}
 
 	devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
-- 
2.17.1

