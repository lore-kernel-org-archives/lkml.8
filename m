Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12972C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB06720639
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgIIQBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:01:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11327 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730315AbgIIP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:59:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 94AA83FBFB2294DE67E2;
        Wed,  9 Sep 2020 21:58:05 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:57:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <yuehaibing@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/19] ALSA: pcm: Remove unused inline function snd_mask_sizeof
Date:   Wed, 9 Sep 2020 21:57:44 +0800
Message-ID: <20200909135744.33464-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/sound/pcm_params.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index 36f94735d23d..ba184f49f7e1 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -23,11 +23,6 @@ int snd_pcm_hw_param_value(const struct snd_pcm_hw_params *params,
 #define MASK_OFS(i)	((i) >> 5)
 #define MASK_BIT(i)	(1U << ((i) & 31))
 
-static inline size_t snd_mask_sizeof(void)
-{
-	return sizeof(struct snd_mask);
-}
-
 static inline void snd_mask_none(struct snd_mask *mask)
 {
 	memset(mask, 0, sizeof(*mask));
-- 
2.17.1


