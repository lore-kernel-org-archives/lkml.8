Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91C6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5A321531
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="eah36o1+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyJJiwGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGCHtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:49:45 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:52089 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgGCHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:49:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id AACC8AF7;
        Fri,  3 Jul 2020 03:49:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 03 Jul 2020 03:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=fVX1MsqXg2Pw9MNdOtGBNsefR2
        zUW9dTgYxXjelLaUo=; b=eah36o1+1g4Q/Ss4ovV0FWa2RNRLjeXfvbngVOq6+/
        goslYrkNfbfRhh0/gMMwJvzbG8B6G7NNernPch9osqGCOqw13uQDrglYVD8e0MUu
        cpW52iOk3vIqPTwUg/espzpybz+LlDvXyG3bTb3CEe4gsbgc1REpoEN8mFSBONwU
        ts0NZcMAuVdFv8nVGANznD10ifjrMg3EOYXl26KSZLhCjoFAAcmJDwDUp6fdSace
        Tc6LA1f/zKxWbpdqO2U5HMrWQgl9GrSDgrKv8xRM6FsgcZh18AOMoWGEdRKuTsap
        +Qx3l8mrYagp1zPEVwT0VRw97GbbOd5XY90cQcH2V7UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fVX1MsqXg2Pw9MNdO
        tGBNsefR2zUW9dTgYxXjelLaUo=; b=dyJJiwGkTUk3WSVT4ClLIwSVvNqqe4Q40
        ScWiy7lCWSfWIGjjS1rcMwrV/dJesfFJNRv16t4Cuet9ojb+CL1nyyNlpVchswQv
        c4XJz3NZ6KrIdnbgAsPFAmRGs6CUkUIKAdja7amr01970++NNS3o6y9yM5n0e0yG
        VdXfOzGpH6s5H8g2IbvFWYpQrDJJRXS6oPanRW62OE/pMVkN0I2PwX+v2fF6+BAn
        pLDHCXa+jb0rvfQ9MP1YUo4XIqbUPm90k1vyh1hfh5NPw19pbxBX0S7LICWFWMZA
        hsrEM+E/+Ta1Tf4hZebKu4HqIKopmS2ui7wup5VTswoGrMHC3U//w==
X-ME-Sender: <xms:FOP-XswLp5JIiMrjiPS7YtG6tgQWqqYwvx6cNJ7dRUYdJUONjXTuJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdehgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcu
    tfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvg
    hrnhepjeffheduvddvvdelhfegleelfffgieejvdehgfeijedtieeuteejteefueekjeeg
    necukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:FOP-XgRqv5W8pWXW3CrDxruw-sCVE66hOhTfd3AIzOAJsacsACAE_A>
    <xmx:FOP-XuUT0ObNM0V5AEb11L1qHTeb-2jRws8uYYRgt8a7IxUPX6ezgg>
    <xmx:FOP-Xqiid2pYDBSYVDugLGHsa7ew0LOQKlxREx-dBsUEkMeD3St06A>
    <xmx:FeP-XkB9pwBK3AnWgr7tB5Zy__VkN-_D3NQj0oA7p5BuFMQgvg_SFtTiOQs>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E85E83280059;
        Fri,  3 Jul 2020 03:49:39 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH] ASoC: core: Remove only the registered component in devm functions
Date:   Fri,  3 Jul 2020 09:49:35 +0200
Message-Id: <20200703074935.884736-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASoC devm_ functions that register a component
(devm_snd_soc_register_component and devm_snd_dmaengine_pcm_register) will
clean their component by running snd_soc_unregister_component.

snd_soc_unregister_component will then remove all the components for the
device that was used to register the component in the first place.

However, some drivers register several components (such as a DAI and a
dmaengine PCM) on the same device, and if the dmaengine PCM is registered
first, then the DAI will be cleaned up first and
snd_dmaengine_pcm_unregister will be called next.

snd_dmaengine_pcm_unregister will then lookup the dmaengine PCM component
on the device, and if there's one unregister that component and release its
dmaengine channels. That doesn't happen in practice though since the first
call to snd_soc_unregister_component removed all the components, so we
never get the chance to release the dmaengine channels.

In order to fix this, instead of removing all the components for a given
device, we can simply remove the component that was registered in the first
place. We should have the same number of component registration than we
have components, so it should work just fine.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---

This was observed on a RaspberryPi that uses the vc4_hdmi driver
(drivers/gpu/drm/vc4/vc4_hdmi.c). This driver will register a dmaengine PCM
and two components. If the MIPI-DSI controller is enabled, it will create
an EPROBE_DEFER across the entire display pipeline, leading to multiple
bind/unbind cycles in the other display drivers including vc4_hdmi, leading
to multiple warnings since we request the same dmaengine channels on the
same device without ever releasing them.

It's not really clear to me when that bug was introduced exactly, since it
can only be seen on a rather unusual setup, and with all the drivers
built-in (otherwise we probably wouldn't get an EPROBE_DEFER for DSI), but
it still looks like something that should probably go to stable?
---
 include/sound/soc.h                   |  2 ++
 sound/soc/soc-core.c                  | 27 +++++++++++++++++++++++++++
 sound/soc/soc-devres.c                |  8 +++++---
 sound/soc/soc-generic-dmaengine-pcm.c |  2 +-
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ef5dd28e10a9..0b3b31803678 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -444,6 +444,8 @@ int devm_snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *component_driver,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_component(struct device *dev);
+void snd_soc_unregister_component_by_driver(struct device *dev,
+			 const struct snd_soc_component_driver *component_driver);
 struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
 						   const char *driver_name);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7b387202c5db..9d24cbd9111f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2571,6 +2571,33 @@ int snd_soc_register_component(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_component);
 
+/**
+ * snd_soc_unregister_component_by_driver - Unregister component using a given driver
+ * from the ASoC core
+ *
+ * @dev: The device to unregister
+ * @component_driver: The component driver to unregister
+ */
+void snd_soc_unregister_component_by_driver(struct device *dev,
+					    const struct snd_soc_component_driver *component_driver)
+{
+	struct snd_soc_component *component;
+
+	if (!component_driver)
+		return;
+
+	mutex_lock(&client_mutex);
+	component = snd_soc_lookup_component_nolocked(dev, component_driver->name);
+	if (!component)
+		goto out;
+
+	snd_soc_del_component_unlocked(component);
+
+out:
+	mutex_unlock(&client_mutex);
+}
+EXPORT_SYMBOL_GPL(snd_soc_unregister_component_by_driver);
+
 /**
  * snd_soc_unregister_component - Unregister all related component
  * from the ASoC core
diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
index a9ea172a66a7..c6364caabc0e 100644
--- a/sound/soc/soc-devres.c
+++ b/sound/soc/soc-devres.c
@@ -11,7 +11,9 @@
 
 static void devm_component_release(struct device *dev, void *res)
 {
-	snd_soc_unregister_component(*(struct device **)res);
+	const struct snd_soc_component_driver **cmpnt_drv = res;
+
+	snd_soc_unregister_component_by_driver(dev, *cmpnt_drv);
 }
 
 /**
@@ -28,7 +30,7 @@ int devm_snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *cmpnt_drv,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai)
 {
-	struct device **ptr;
+	const struct snd_soc_component_driver **ptr;
 	int ret;
 
 	ptr = devres_alloc(devm_component_release, sizeof(*ptr), GFP_KERNEL);
@@ -37,7 +39,7 @@ int devm_snd_soc_register_component(struct device *dev,
 
 	ret = snd_soc_register_component(dev, cmpnt_drv, dai_drv, num_dai);
 	if (ret == 0) {
-		*ptr = dev;
+		*ptr = cmpnt_drv;
 		devres_add(dev, ptr);
 	} else {
 		devres_free(ptr);
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index f728309a0833..ab600be9e69f 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -490,7 +490,7 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 
 	pcm = soc_component_to_pcm(component);
 
-	snd_soc_unregister_component(dev);
+	snd_soc_unregister_component_by_driver(dev, component->driver);
 	dmaengine_pcm_release_chan(pcm);
 	kfree(pcm);
 }
-- 
2.26.2

