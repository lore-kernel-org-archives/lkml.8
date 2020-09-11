Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFDFC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D0221D92
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ebqbjyKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgIKIQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:16:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35504 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgIKIQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:16:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08B87lQR003143;
        Fri, 11 Sep 2020 10:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=tIOlnbAKWQu2aJOslivWEU73AEic3d7q5RRGup+Q4RA=;
 b=ebqbjyKTK35dpUhKhRfw0A4aX24JhezA4xX5kLmgnbb9yjSTiIIbRh3tMV5lA3ouWqJA
 ftqQKc7gJ0rXVsu/Yr42sBlp+yxWsXNPJmABNeynOaDv1JGi/HUrrlTxgslPEaJmRAm4
 v98tTM2OR66tlbAb++E+Q2/sm3a74CNZcZBPnLLQv0OXeRjg5xCfF+zSxuHlOcdCzQ31
 chPAnA+7RnfdniITyrdiAcse5LNypec/Ykxsoiv7tsU+N62zyorNrU32DskQH/wbcZFA
 FppEieofoPPzpMhQPjwYL3V3PZcI0oT+zNbVhXtXItrF0mj3xQoVxop1C0yVTsxKNyH7 MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33c1jfg8ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 10:15:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7B1DA10002A;
        Fri, 11 Sep 2020 10:15:10 +0200 (CEST)
Received: from Webmail-eu.st.com (gpxdag6node5.st.com [10.75.127.81])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1F58A21E254;
        Fri, 11 Sep 2020 10:15:10 +0200 (CEST)
Received: from localhost (10.75.127.46) by GPXDAG6NODE5.st.com (10.75.127.81)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Sep 2020 10:15:09
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <arnaud.pouliquen@st.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: stm32: sai: add pm_runtime support
Date:   Fri, 11 Sep 2020 10:15:07 +0200
Message-ID: <20200911081507.7276-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To GPXDAG6NODE5.st.com
 (10.75.127.81)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_02:2020-09-10,2020-09-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support of pm_runtime on STM32 SAI driver to allow
SAI power state monitoring.
pm_runtime_put_autosuspend() is called from ASoC framework
on pcm device close.
The pmdown_time delay is available in runtime context, and may be set
in SAI driver to take into account shutdown delay on playback.
However, this shutdown delay is already handled in the DAPMs
of the audio codec linked to SAI CPU DAI.
So, the choice is made, not to support this delay on CPU DAI side.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 3fb9513cedb2..3aa1cf262402 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <sound/asoundef.h>
@@ -1559,10 +1560,14 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_component,
 					 &sai->cpu_dai_drv, 1);
-	if (ret)
+	if (ret) {
 		snd_dmaengine_pcm_unregister(&pdev->dev);
+		return ret;
+	}
 
-	return ret;
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
 }
 
 static int stm32_sai_sub_remove(struct platform_device *pdev)
@@ -1572,6 +1577,7 @@ static int stm32_sai_sub_remove(struct platform_device *pdev)
 	clk_unprepare(sai->pdata->pclk);
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.17.1

