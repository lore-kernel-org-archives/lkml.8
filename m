Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2E4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E19221E8
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgIJUGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgIJUDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:03:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A68AC061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:03:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 426C529B6F0
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org
Cc:     tiwai@suse.com, enric.balletbo@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        linux-mediatek@lists.infradead.org,
        ranjani.sridharan@linux.intel.com, matthias.bgg@gmail.com,
        dmitry.baryshkov@linaro.org,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Subject: [PATCH] ASoC: core: Optionaly add the component driver name to the component name
Date:   Thu, 10 Sep 2020 22:03:08 +0200
Message-Id: <20200910200308.9125-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASoC platform driver for Mediatek MT8173 registers
several components with identical name. This cause an
error:
"Directory '11220000.audio-controller' with parent 'mtk-rt5650' already present!"
when adding debugfs directory for those components.
To fix this, the function 'fmt_single_name' can receive the name
of the component driver and concatenate it to the name of the debugfs
directory for the component.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 sound/soc/soc-core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 74df22486e30..f470e713b030 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2227,7 +2227,7 @@ EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
  * Simplify DAI link configuration by removing ".-1" from device names
  * and sanitizing names.
  */
-static char *fmt_single_name(struct device *dev, int *id)
+static char *fmt_single_name(struct device *dev, int *id, const char *component_driver_name)
 {
 	const char *devname = dev_name(dev);
 	char *found, *name;
@@ -2263,6 +2263,12 @@ static char *fmt_single_name(struct device *dev, int *id)
 		*id = 0;
 	}
 
+	if (component_driver_name) {
+		char *tmp = name;
+
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s-%s", name, component_driver_name);
+		devm_kfree(dev, tmp);
+	}
 	return name;
 }
 
@@ -2327,7 +2333,7 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 	 */
 	if (legacy_dai_naming &&
 	    (dai_drv->id == 0 || dai_drv->name == NULL)) {
-		dai->name = fmt_single_name(dev, &dai->id);
+		dai->name = fmt_single_name(dev, &dai->id, NULL);
 	} else {
 		dai->name = fmt_multiple_name(dev, dai_drv);
 		if (dai_drv->id)
@@ -2460,7 +2466,7 @@ int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->card_list);
 	mutex_init(&component->io_mutex);
 
-	component->name = fmt_single_name(dev, &component->id);
+	component->name = fmt_single_name(dev, &component->id, driver->name);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.17.1

