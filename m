Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A101EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8701E2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgGQITa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:19:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8313 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbgGQIT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:19:29 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 536C352A645CA3F5BF09;
        Fri, 17 Jul 2020 16:19:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 16:19:02 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <jbrunet@baylibre.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <khilman@baylibre.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH v2] ASoC: meson: fixes the missed kfree() for axg_card_add_tdm_loopback
Date:   Fri, 17 Jul 2020 16:22:42 +0800
Message-ID: <20200717082242.130627-1-jingxiangfeng@huawei.com>
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

axg_card_add_tdm_loopback() misses to call kfree() in an error path. We
can use devm_kasprintf() to fix the issue, also improve maintainability.
So use it instead.

Fixes: c84836d7f650 ("ASoC: meson: axg-card: use modern dai_link style")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 sound/soc/meson/axg-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 89f7f64747cd..47f2d93224fe 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -116,7 +116,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 
 	lb = &card->dai_link[*index + 1];
 
-	lb->name = kasprintf(GFP_KERNEL, "%s-lb", pad->name);
+	lb->name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-lb", pad->name);
 	if (!lb->name)
 		return -ENOMEM;
 
-- 
2.17.1

