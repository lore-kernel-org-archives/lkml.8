Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A74C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910C3206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgGGTHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:07:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:39726 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgGGTHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:07:01 -0400
IronPort-SDR: chrUiILKVZQ1o9LtBr0KDkdvsP2H1cJCLAxmrYOcCo9pLqUlV8AhBtKbxL19I+5GqQfsblhMEg
 1U3nEr/6EDUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127274244"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="127274244"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:07:00 -0700
IronPort-SDR: VJ7a0EjZrd0ufWqwP6r+7r7ZDBvNZaOy27CX22Oi8MF0jjxIKqJyzFF5i4M00cgPeYkH0Y/toG
 L5xkKMK4h7SA==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="268278694"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:59 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Steve Lee <steves.lee@maximintegrated.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 12/13] ASoC: codecs: max98390: fix 'defined but not used' warning
Date:   Tue,  7 Jul 2020 14:06:11 -0500
Message-Id: <20200707190612.97799-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
References: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
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

