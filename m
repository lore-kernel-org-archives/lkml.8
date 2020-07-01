Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3047C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920CD20870
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbgGASYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:24:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:9410 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbgGASYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:24:33 -0400
IronPort-SDR: V4PuJFpikouf6+gaBzWOmfWSii+dlGIZtlce+jhfmfEAZVsGdW/k4MwNauZPOuANxRnKTqn/qb
 qtAXD6MZmv1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144841723"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="144841723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:32 -0700
IronPort-SDR: NIIw/zf3C8OyfzjlujKT+eGzVitbSQdmGzUb5SHtDo5hNNeSBqUlKHH8ZNtmcsHEY66LToFgI9
 e3+HJun+yxEA==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="425679553"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:31 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/11] ASoC: codecs: cros_ec_codec: fix 'defined but not used' warning
Date:   Wed,  1 Jul 2020 13:24:13 -0500
Message-Id: <20200701182422.81496-3-pierre-louis.bossart@linux.intel.com>
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

sound/soc/codecs/cros_ec_codec.c:1056:36: warning:
'cros_ec_codec_acpi_id' defined but not used
[-Wunused-const-variable=]
 1056 | static const struct acpi_device_id cros_ec_codec_acpi_id[] = {
      |                                    ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/cros_ec_codec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 8d45c628e988..f23956cf4ed8 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -1053,11 +1053,13 @@ static const struct of_device_id cros_ec_codec_of_match[] = {
 MODULE_DEVICE_TABLE(of, cros_ec_codec_of_match);
 #endif
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id cros_ec_codec_acpi_id[] = {
 	{ "GOOG0013", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cros_ec_codec_acpi_id);
+#endif
 
 static struct platform_driver cros_ec_codec_platform_driver = {
 	.driver = {
-- 
2.25.1

