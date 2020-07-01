Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B21EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585BA20870
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbgGASYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:24:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:61635 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbgGASYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:24:47 -0400
IronPort-SDR: mRkEHYiJkiFjQ8eJghkhF4jej/qY/oPEEvtq1q7wNapdfmF4nvcKDC7l4fYChkdOHaHvKRU4Hy
 jiPGDYHDvQBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="148218884"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="148218884"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:46 -0700
IronPort-SDR: uNZGMcDa6uSQr0V+Q2M+Mdug7RsPQMAaWPGwA1OwhvOhGEkRJAqmwKxvXiYDp7ME9tHN2tA0CT
 YLAyXwjYxw1A==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="425679609"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:45 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Steve Lee <steves.lee@maximintegrated.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/11] ASoC: codecs: max98390: fix 'defined but not used' warning
Date:   Wed,  1 Jul 2020 13:24:17 -0500
Message-Id: <20200701182422.81496-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning and removed unused table. In this case this a
duplicate of

static const struct of_device_id max98390_of_match[] = {
	{ .compatible = "maxim,max98390", },
	{}
};
MODULE_DEVICE_TABLE(of, max98390_of_match);

already used in the rest of the code.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/max98390.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index b345e626956d..3e8094241645 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -944,14 +944,6 @@ static const struct regmap_config max98390_regmap = {
 	.cache_type       = REGCACHE_RBTREE,
 };
 
-#ifdef CONFIG_OF
-static const struct of_device_id max98390_dt_ids[] = {
-	{ .compatible = "maxim,max98390", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, max98390_dt_ids);
-#endif
-
 static int max98390_i2c_probe(struct i2c_client *i2c,
 		const struct i2c_device_id *id)
 {
-- 
2.25.1

