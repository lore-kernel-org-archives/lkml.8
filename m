Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DACC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AB3206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgGGTGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:06:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:60202 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbgGGTGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:06:45 -0400
IronPort-SDR: erDf37fvV4QHYQsTwDS+eLLbzX+JzJJHy0YHkXBJ1OnDrUPMBZTAybCYR0S9PVf4na5eogLgic
 6WmS8XVcC68w==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145185246"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="145185246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:43 -0700
IronPort-SDR: DN4ldqLb/EoLMqXMt676LQSlB9MPbZE//nqOxXz/eIzQnXyoS4U+1DGvITBfXeHI62k/dHUhXJ
 LzIMIpsHATUg==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="268278596"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:42 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 07/13] ASoC: codecs: da7219: fix 'defined but not used' warning
Date:   Tue,  7 Jul 2020 14:06:06 -0500
Message-Id: <20200707190612.97799-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
References: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix W=1 warning

sound/soc/codecs/da7219.c:1711:36: warning: 'da7219_acpi_match'
defined but not used [-Wunused-const-variable=]
 1711 | static const struct acpi_device_id da7219_acpi_match[] = {
      |                                    ^~~~~~~~~~~~~~~~~

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/da7219.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index f2520a6c7875..153ea30b5a8f 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1708,11 +1708,13 @@ static const struct of_device_id da7219_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, da7219_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id da7219_acpi_match[] = {
 	{ .id = "DLGS7219", },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, da7219_acpi_match);
+#endif
 
 static enum da7219_micbias_voltage
 	da7219_fw_micbias_lvl(struct device *dev, u32 val)
-- 
2.25.1

