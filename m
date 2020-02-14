Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26984C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03A4222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w3o4ZhHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgBNNrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:47:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33699 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgBNNrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:47:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so11019304wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yy4ilqVvhrLATx+0bmuWhKxlR9fkmOJTJ4xxA2l5XEc=;
        b=w3o4ZhHSe+S9GbxnicHhG7v2B4byeFaiG8qzWZR8jY1reW8h2VWxZiQCjC3gyhDEKC
         wujXg/FXhgNxc6CSPRB0F3dBX5nSkBndE9V5RLoXGGiGYdfNr9LIXsJP5O0l4A6JqDYV
         WhfQdgqzmEZKHoIUbwtS+dIcm4BFtSVJ/I944JFkT0mROjQlYqZwavz0gkevpkZ3TMOU
         Lo7W17uCAVFSjuyFn56t9vrZejtKIl0Z17lfHZ7uZ20CnnjMbqbO7d8qtoIf6IybXnT9
         GRFo4OnK/BVj7HTRbnLVn3K7fQRJgJhp6FFUfcKe+44NW9LIR07Xbo/ogQuR0z54cx1i
         ja1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yy4ilqVvhrLATx+0bmuWhKxlR9fkmOJTJ4xxA2l5XEc=;
        b=Ahg8rfS04pBAFvfNuVSUeG0gpBCjjzs3GzT2q2sgHJcf9gzMO/me2JHIoEAdGZc1t7
         vamT1YcBrx9lE+uXyhnFEpbUP3unFEfbGMW5SZF3pwSHmJe2hz8WkAOQtzQ8kHuPHCG+
         R8ahGui3LmqEGie/lZwm+hfFsU8Nk17lYfFGne+VLyFcPtv5M0NRQ063JZAzJW5zN0el
         puAKrCTIfyHZm4KtW+tHMszabYcDN4DaWYxRggiN0x9qaJEJo8pGRUhyvj0qhUQpWEu+
         oXadwzbzoAqDmu77AWlmC93shnyfvtUQziw+Wvvk9xzY0AI8NfSp/+ybXsmkE1RNoMlR
         qdng==
X-Gm-Message-State: APjAAAXL6uPllb208cmlXjQItVZzFddCkBek4Zv4fxbxpGvXAjfi00f2
        nthehHtSxQCe2koglPNwXryC88BwKH0=
X-Google-Smtp-Source: APXvYqxSrnmmkWxl7FjTG6YfB4kuBeJrO7YMKoS/fI/OjITSVCPGMdawDS0oXNepNvV/XESe/FhCVw==
X-Received: by 2002:adf:ea48:: with SMTP id j8mr4359656wrn.363.1581688035426;
        Fri, 14 Feb 2020 05:47:15 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h13sm8286238wrw.54.2020.02.14.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:47:14 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] ASoC: core: ensure component names are unique
Date:   Fri, 14 Feb 2020 14:47:04 +0100
Message-Id: <20200214134704.342501-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure each ASoC component is registered with a unique name.
The component is derived from the device name. If a device registers more
than one component, the component names will be the same.

This usually brings up a warning about the debugfs directory creation of
the component since directory already exists.

In such case, start numbering the component of the device so the names
don't collide anymore.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

* Here is an example of /sys/kernel/debug/asoc/components before the change:
hdmi-audio-codec.3.auto
c1105400.audio-controller
c1105400.audio-controller
c1105400.audio-controller
c8832000.audio-controller
analog-amplifier
snd-soc-dummy
snd-soc-dummy

* and after:
hdmi-audio-codec.3.auto
c1105400.audio-controller-2
c1105400.audio-controller-1
c1105400.audio-controller
c8832000.audio-controller
analog-amplifier
snd-soc-dummy-1
snd-soc-dummy

I wanted to keep the name as they were for the devices registering
only one component but we could also start the numbering from the first
component instead of the second.

 sound/soc/soc-core.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 03b87427faa7..6a58a8f6e3c4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2446,6 +2446,33 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 	return ret;
 }
 
+static char *snd_soc_component_unique_name(struct device *dev,
+					   struct snd_soc_component *component)
+{
+	struct snd_soc_component *pos;
+	int count = 0;
+	char *name, *unique;
+
+	name = fmt_single_name(dev, &component->id);
+	if (!name)
+		return name;
+
+	/* Count the number of components registred by the device */
+	for_each_component(pos) {
+		if (dev == pos->dev)
+			count++;
+	}
+
+	/* Keep naming as it is for the 1st component */
+	if (!count)
+		return name;
+
+	unique = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", name, count);
+	devm_kfree(dev, name);
+
+	return unique;
+}
+
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
@@ -2454,7 +2481,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->card_list);
 	mutex_init(&component->io_mutex);
 
-	component->name = fmt_single_name(dev, &component->id);
+	component->name = snd_soc_component_unique_name(dev, component);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.24.1

