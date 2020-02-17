Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B522C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 18:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D367F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 18:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FOth/oyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgBQSGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:06:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32870 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBQSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:06:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so20925468wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nIGgpR6dxPbUKvKu1GNRxbB1TO6afrCiGpP741rVUc=;
        b=FOth/oybwE6qAHw51eAfFYXowWJRP1oRU/FExfez93psv5Gj5qjfSN6kJfOSkyjz4V
         NVNb81QmvBTEFdlF29ucdGdDwgVnxRO0yXZD95TOIkMhnvkJNe8tG1rXjG+sAD75BCW2
         qwp0GQUrwiNg9YFERbyCbBi7ozKTd6DlUxquL96omY2Bjb2SjJFajgm+LzhL6FI8SxTE
         17wbUIuezRS5Wr99jkcYZwkNa51UY9c8CoIqFxeJccxr3QtNvmzryk/GD+Pe9FskEoMk
         1nGyeBFn19MZ/d0KecUtTsuqEuL820uKbYGtM6fzGegr2a8Gg5+Fpqp9sisr/UGzFTbW
         CvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nIGgpR6dxPbUKvKu1GNRxbB1TO6afrCiGpP741rVUc=;
        b=iqBCEjQefZ4lRCGf+QIAKOSiV3LSWJ8QgJaOfV1Ua7GYLB7w+vo5JC5+eIxiVxRnzo
         lgix82vmfSY5jkDFy/bH8Sn6MsjwqOehau54gIvuJYRZ4WfXdRPhjgpYND2WfwH7FwQR
         iqv3Gv2uCXZNNFUIpHjg8B2xmCJrhUPDoPlRxDa8Q3Yjrnm24M0maQijGsiVsTQDtlGe
         W1jLsC07BII/S6dG9Wtb+FjDqF0rVoyCoiuna5Pvy44GkOroFBnb3k+en/AR8tothgEW
         rNs8Ux8MmVgrJx2xgaExyNoFk7H+alAAGS6qlC8x+RSNMO3Noq+zvNX4BO3VmTD0jiLt
         kdUg==
X-Gm-Message-State: APjAAAXv9RO1G0EkjzRNF4858SEyystBfMkBJa+xLqd2MB7MxRH1+K5n
        3tQLFmQSk0E/hY8LSx8r2cHuDg==
X-Google-Smtp-Source: APXvYqyBEo4ZFXC6CR3RHyHS3MGnk6ZzfhtbpwNrhWU7GWupMw65B4+Li8NoPZ09CArtzdmLc4ueXw==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr23671245wrj.68.1581962794494;
        Mon, 17 Feb 2020 10:06:34 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d204sm254850wmd.30.2020.02.17.10.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 10:06:33 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Subject: [RFT/DONTMERGE] ASoC: devm_snd_soc_register_component fixup
Date:   Mon, 17 Feb 2020 19:06:26 +0100
Message-Id: <20200217180626.593909-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20557448-d6d2-7584-e2ac-c46d337e1778@samsung.com>
References: <20557448-d6d2-7584-e2ac-c46d337e1778@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek, would you mind trying the following patch. It should target the
component removal intead of removing them all. I'd like to comfirm this is
your problem before pushing in this direction. Thanks

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/sound/soc.h                   |  1 +
 sound/soc/soc-core.c                  |  8 +++++++
 sound/soc/soc-devres.c                | 32 ++++++++++++++++++---------
 sound/soc/soc-generic-dmaengine-pcm.c |  2 +-
 4 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f0e4f36f83bf..e5bfe2609110 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -442,6 +442,7 @@ int snd_soc_add_component(struct device *dev,
 		const struct snd_soc_component_driver *component_driver,
 		struct snd_soc_dai_driver *dai_drv,
 		int num_dai);
+void snd_soc_del_component(struct snd_soc_component *component);
 int snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *component_driver,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6a58a8f6e3c4..bf6a64fbfa52 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2599,6 +2599,14 @@ static void snd_soc_del_component_unlocked(struct snd_soc_component *component)
 	list_del(&component->list);
 }
 
+void snd_soc_del_component(struct snd_soc_component *component)
+{
+	mutex_lock(&client_mutex);
+	snd_soc_del_component_unlocked(component);
+	mutex_unlock(&client_mutex);
+}
+EXPORT_SYMBOL_GPL(snd_soc_del_component);
+
 int snd_soc_add_component(struct device *dev,
 			struct snd_soc_component *component,
 			const struct snd_soc_component_driver *component_driver,
diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
index a9ea172a66a7..d5e9e2bed2ce 100644
--- a/sound/soc/soc-devres.c
+++ b/sound/soc/soc-devres.c
@@ -11,7 +11,7 @@
 
 static void devm_component_release(struct device *dev, void *res)
 {
-	snd_soc_unregister_component(*(struct device **)res);
+	snd_soc_del_component(*(struct snd_soc_component **)res);
 }
 
 /**
@@ -28,21 +28,31 @@ int devm_snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *cmpnt_drv,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai)
 {
-	struct device **ptr;
-	int ret;
+	struct snd_soc_component *component;
+	struct snd_soc_component **ptr;
+	int ret = -ENOMEM;
+
+	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
 
 	ptr = devres_alloc(devm_component_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
-		return -ENOMEM;
+	        goto err_devres;
 
-	ret = snd_soc_register_component(dev, cmpnt_drv, dai_drv, num_dai);
-	if (ret == 0) {
-		*ptr = dev;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	ret = snd_soc_add_component(dev, component, cmpnt_drv, dai_drv,
+				    num_dai);
+	if (ret)
+		goto err_add;
+
+	*ptr = component;
+	devres_add(dev, ptr);
+	return 0;
 
+err_add:
+	devres_free(ptr);
+err_devres:
+	devm_kfree(dev, component);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(devm_snd_soc_register_component);
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 2cc25651661c..a33f21ce2d7a 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -474,7 +474,7 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 
 	pcm = soc_component_to_pcm(component);
 
-	snd_soc_unregister_component(dev);
+	snd_soc_del_component(component);
 	dmaengine_pcm_release_chan(pcm);
 	kfree(pcm);
 }
-- 
2.24.1

