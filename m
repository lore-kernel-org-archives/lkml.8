Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F26C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D112207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgGASYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:24:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:61636 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731814AbgGASYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:24:48 -0400
IronPort-SDR: V1o/jiNt/Hg2kSbpfTtvmKBs2vFMlp3wBeyiZOIhwViyTETAcZMpP+7QOUdADI7WXeIgzRPd09
 6AZuN4C6tZow==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="148218888"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="148218888"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:47 -0700
IronPort-SDR: RKhoIapeEXbHUDtol/rc9p30Z59tFwBT0r+5FvQu69Zw2DYoUnpT4wNrMtSCsE/3B1DlmZYyc3
 ao3TUJ3wRblQ==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="425679612"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:47 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 07/11] ASoC: codecs: rt*: fix 'defined but not used' warning
Date:   Wed,  1 Jul 2020 13:24:18 -0500
Message-Id: <20200701182422.81496-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning when ACPI is not defined

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt274.c      | 2 ++
 sound/soc/codecs/rt286.c      | 2 ++
 sound/soc/codecs/rt298.c      | 2 ++
 sound/soc/codecs/rt5660.c     | 2 ++
 sound/soc/codecs/rt5677-spi.c | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index cbb5e176d11a..40a28fb4fd09 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1105,12 +1105,14 @@ static const struct i2c_device_id rt274_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt274_i2c_id);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt274_acpi_match[] = {
 	{ "10EC0274", 0 },
 	{ "INT34C2", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt274_acpi_match);
+#endif
 
 static int rt274_i2c_probe(struct i2c_client *i2c,
 			   const struct i2c_device_id *id)
diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 9593a9a27bf8..89b1c8b68004 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1079,11 +1079,13 @@ static const struct i2c_device_id rt286_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt286_i2c_id);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt286_acpi_match[] = {
 	{ "INT343A", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt286_acpi_match);
+#endif
 
 static const struct dmi_system_id force_combo_jack_table[] = {
 	{
diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 7fc7d6181630..dc0273a5a11f 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1145,11 +1145,13 @@ static const struct i2c_device_id rt298_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt298_i2c_id);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt298_acpi_match[] = {
 	{ "INT343A", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt298_acpi_match);
+#endif
 
 static const struct dmi_system_id force_combo_jack_table[] = {
 	{
diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 78371e51bc34..9e3813f7583d 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -1241,12 +1241,14 @@ static const struct of_device_id rt5660_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rt5660_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5660_acpi_match[] = {
 	{ "10EC5660", 0 },
 	{ "10EC3277", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5660_acpi_match);
+#endif
 
 static int rt5660_parse_dt(struct rt5660_priv *rt5660, struct device *dev)
 {
diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 7bfade8b3d6e..95ac12a5cc6b 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -614,11 +614,13 @@ static int rt5677_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5677_spi_acpi_id[] = {
 	{ "RT5677AA", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, rt5677_spi_acpi_id);
+#endif
 
 static struct spi_driver rt5677_spi_driver = {
 	.driver = {
-- 
2.25.1

