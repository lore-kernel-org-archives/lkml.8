Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ED8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C40207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbgGASYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:24:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:9410 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732900AbgGASYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:24:37 -0400
IronPort-SDR: MZ+9ZLxOuyI5lygwEOayl5P3oUMxLDcE2dKiWiUG8CRHn9lxLROzFjp0awnw+FYQN9XbWOmyUc
 MZhSJrhUmmHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144841726"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="144841726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:36 -0700
IronPort-SDR: Teb3TbgeImWbsSgIi/cT+IGF9K7mjlsrAU5Z/Q5gfZS/xZeWA+2nZbAsqZcITUIL6DSpGOYA76
 7zu97vMAW4Nw==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="425679560"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:35 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/11] ASoC: codecs: da7219: fix 'defined but not used' warning
Date:   Wed,  1 Jul 2020 13:24:15 -0500
Message-Id: <20200701182422.81496-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
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

