Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A52CC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D7F2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pxiG/15f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBSKZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:25:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36061 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBSKZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:25:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so6171367wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 02:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RejVam6fDIBD/171nva4YA9frryDk02n9j0DCZJ4htM=;
        b=pxiG/15fBub6+F881mK1MfCTN7rUOq+Hm4jea2zZdHSx0shyFznlZv0NXH31Bw/H0M
         /rT0ZsZbEnUTjIxyopaVx0iiXOGuKnCwfOPjHMY3md42nvjdpgPNR6qEsSbGP97BnDNK
         UPLZgYuWV0bk3aR8UPujgHOoxo2hXsJKOltOi2FwTqRfqDIXQuqSUAMRR6PV/awINDLb
         hB8hRkr75zSIVf6CWuQaJQ3MHBsJCvpqdJbvamXjRuFbo6q4VRvjweZu/0+0/8ACzOxI
         FHfT9tphxZTayrfS6uk2/B6ICtsxaO0t/FwZJD8weSuqkT1cTGjBsu+Fs12EBaF/6DPe
         uQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RejVam6fDIBD/171nva4YA9frryDk02n9j0DCZJ4htM=;
        b=GTZ80g7a0+T7hHrKacIpbOGSHmheR2h9Gg1KGRizZ7TMmjN6aDgHiuau+KB3nDsCik
         F8+h6kZItSu9GWmqiHrXC1ueFDezJMAnfk0mmhHDCwd4UW7FlA4M1lNwHCZcTtyX0dNG
         B8aK3aYhlCmziZCGgYAGvdv1wm5UxvDAyP0eni26uhWLikQ3BuE8Tm21gfbQ2R7x6Uog
         ORvRglfYKvymCFPnSWe5hzRm8u7S7QWi7keO4EVbcRBfb9L6gG4Nk0+JPk6j0dZ3TqUc
         H2FIDMm9kmMUmAeD53h3QIndtoouPZJtAcg1p50yBzgGI8YiOjioY/1OSMDmTJqKf+br
         EmcA==
X-Gm-Message-State: APjAAAWPCTRWtujwmDkuKyMuHnxu3iN0tB5rd2J36o7wSE1oYlTZINUH
        JN0ob4IKHxH+UeRRxiKjnMOpLQ==
X-Google-Smtp-Source: APXvYqw7/FkSHHxus/ih0u10TbKNOBGCz51zlpX/Ia7XtXiPnjDJYWOyfUo95tzExyHbfRKjRVF68Q==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr9323161wmb.150.1582107943441;
        Wed, 19 Feb 2020 02:25:43 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 133sm2678562wmd.5.2020.02.19.02.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 02:25:42 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] ASoC: fix card registration regression.
Date:   Wed, 19 Feb 2020 11:25:26 +0100
Message-Id: <20200219102526.692126-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b2354e4009a773c00054b964d937e1b81cb92078.

This change might have been desirable to ensure the uniqueness of
the component name. It would have helped to better support linux
devices which register multiple components, something is which more
common than initially thought.

However, some card driver are directly using dev_name() to fill the
component names of the dai_link which is a problem if want to change
the way ASoC generates the component names.

Until we figure out the appropriate way to deal with this, revert the
change and keep the names as they were. There might be a couple of warning
related to debugfs (which were already present before the change) but it
is still better than breaking working audio cards.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-core.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 30c17fde14ca..518b652cf872 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2442,33 +2442,6 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 	return ret;
 }
 
-static char *snd_soc_component_unique_name(struct device *dev,
-					   struct snd_soc_component *component)
-{
-	struct snd_soc_component *pos;
-	int count = 0;
-	char *name, *unique;
-
-	name = fmt_single_name(dev, &component->id);
-	if (!name)
-		return name;
-
-	/* Count the number of components registred by the device */
-	for_each_component(pos) {
-		if (dev == pos->dev)
-			count++;
-	}
-
-	/* Keep naming as it is for the 1st component */
-	if (!count)
-		return name;
-
-	unique = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", name, count);
-	devm_kfree(dev, name);
-
-	return unique;
-}
-
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
@@ -2477,7 +2450,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->card_list);
 	mutex_init(&component->io_mutex);
 
-	component->name = snd_soc_component_unique_name(dev, component);
+	component->name = fmt_single_name(dev, &component->id);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.24.1

