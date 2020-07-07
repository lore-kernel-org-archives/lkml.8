Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92042C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0CC207D0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgGGTGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:06:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:46557 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgGGTGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:06:51 -0400
IronPort-SDR: 0L/FNQWlBm07zOaCHedmWQR7RkfNhqOw7/c3GQolXwhdIyYQ+Lt+JoS1z2ILWU8A0LUlHxQ6w1
 uoV7ZbXpAWLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127764342"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="127764342"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:50 -0700
IronPort-SDR: Be2XIvFoWxf08RM7wO9zo0An2S9ds88sPy/HXI1/ivkRdiWTG8kehMYTvovW5VEO6ZgC++3BH0
 xP8SYOLcM/+A==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="268278638"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:49 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Daniel Drake <drake@endlessm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 11/13] ASoC: codecs: es8316: fix 'defined but not used' warning
Date:   Tue,  7 Jul 2020 14:06:10 -0500
Message-Id: <20200707190612.97799-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
References: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning

sound/soc/codecs/es8316.c:842:36: warning: 'es8316_acpi_match' defined
but not used [-Wunused-const-variable=]
  842 | static const struct acpi_device_id es8316_acpi_match[] = {
      |                                    ^~~~~~~~~~~~~~~~~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/es8316.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 36eef1fb3d18..70af35c5f727 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -839,11 +839,13 @@ static const struct of_device_id es8316_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, es8316_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id es8316_acpi_match[] = {
 	{"ESSX8316", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, es8316_acpi_match);
+#endif
 
 static struct i2c_driver es8316_i2c_driver = {
 	.driver = {
-- 
2.25.1

