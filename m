Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3869C35676
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88942208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="agoHeIJB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wMBMws10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgBWDpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:45:44 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60769 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgBWDph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:45:37 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id EFD236A2F;
        Sat, 22 Feb 2020 22:45:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 22:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=4ICm2QiFFrbgz
        aDEtX2KVwTyX394xQzW/xM+H9iBcqc=; b=agoHeIJBkFE8vM94ydHTpyvjB0qFM
        A1aev+Pi8n9nMYjxLGXQ8iDyzOiC78x+wn+GGx8bsoTBZgo6HFsZwWapTJP0qyMC
        d3Abr2s/bjgxDfDCSkett3ede2X1EDKkEy/eAY/81KOc+MLkd5R3ML5Hp8/WmClv
        8AOQbJtEGqVdqVGJllDo291TytjBkGKmaeWrZMOtEOcTupzzvG0ENZDbxrDjXCln
        4hsq7CHtUitYTv8aSw+4N8fj3PVCCkO/N9iA3DlW8T0Oh6Zz9kegtLlaHAiRRntm
        RerTMI4ZSN+lfHajI8UvgXjZZLG1jUEVZ9xLVeaiu5bDC/AbjW9bh3OKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4ICm2QiFFrbgzaDEtX2KVwTyX394xQzW/xM+H9iBcqc=; b=wMBMws10
        Ui0bo5OH5A12RmpyiDmmKuvRD+LID9AY1Nh3UlT5gbxz3QecDa6K3QyBpspb8uPZ
        6XQQMceuurNnNKqnViNatEjjaVFX9LDi8RCcJvo8Re8q01JvsOZWTZCnJm3wYaDw
        EGBc1MdPOn+kw7zA5R/5aktN1pb0fArKLMgQpVE29IroiKSjv1GKDEHy7iCiUC2D
        vnof129FN904ItAhaUTJ+trJE3t5jTXFx9qmquKiwbWOXzOlYhde5MfS9aj0eh8H
        n4XMA+Ovd36OD3xOwK1mk0CTKFh7haqtXeFG+5qo6y4ONxxBv/FFd9BtIe04e53Q
        odY5tYWt8SMg5w==
X-ME-Sender: <xms:X_VRXgn8aeoKZE50Ng_InK50I28l8xaYg78eezvHXUqtUKB95GW0fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:X_VRXsJSh-_Xp4KYzi3-OayVKioWZvt8DzXLcVhki34Uggvppzlm_w>
    <xmx:X_VRXhaSzyYnVEZCLJydXyRn5fZFVSKcQ2m9qDLco6IB3pY3Uu8pxw>
    <xmx:X_VRXuaWfJzW42Ckaf-qWfVnCgeracm8-yZHTygKEIEH_HE3xsJ_ww>
    <xmx:X_VRXt0GR8nimMRxItRqt9DqUWcD-c7x7BsXaoVI7CBTNDXPPhgVag>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F4303060FD3;
        Sat, 22 Feb 2020 22:45:35 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 3/3] ASoC: simple-card: Add support for codec2codec DAI links
Date:   Sat, 22 Feb 2020 21:45:33 -0600
Message-Id: <20200223034533.1035-4-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223034533.1035-1-samuel@sholland.org>
References: <20200223034533.1035-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the example in cb2cf0de1174 ("ASoC: soc-core: care Codec <->
Codec case by non_legacy_dai_naming"), determine if a DAI link contains
only codec DAIs by examining the non_legacy_dai_naming flag in each
DAI's component.

For now, we assume there is only one or a small set of valid PCM stream
parameters, so num_params == 1 is good enough. We also assume that the
same params are valid for all supported streams. params is set to the
subset of parameters common among all DAIs, and then the existing code
automatically chooses the highest quality of the remaining values when
the link is brought up.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 Documentation/sound/soc/codec-to-codec.rst |  9 +++-
 sound/soc/generic/simple-card-utils.c      | 49 ++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/soc/codec-to-codec.rst b/Documentation/sound/soc/codec-to-codec.rst
index 810109d7500d..4eaa9a0c41fc 100644
--- a/Documentation/sound/soc/codec-to-codec.rst
+++ b/Documentation/sound/soc/codec-to-codec.rst
@@ -104,5 +104,10 @@ Make sure to name your corresponding cpu and codec playback and capture
 dai names ending with "Playback" and "Capture" respectively as dapm core
 will link and power those dais based on the name.
 
-Note that in current device tree there is no way to mark a dai_link
-as codec to codec. However, it may change in future.
+A dai_link in a "simple-audio-card" will automatically be detected as
+codec to codec when all DAIs on the link belong to codec components.
+The dai_link will be initialized with the subset of stream parameters
+(channels, format, sample rate) supported by all DAIs on the link. Since
+there is no way to provide these parameters in the device tree, this is
+mostly useful for communication with simple fixed-function codecs, such
+as a Bluetooth controller or cellular modem.
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 9b794775df53..54294367a40f 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -331,6 +331,51 @@ static int asoc_simple_init_dai(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int asoc_simple_init_dai_link_params(struct snd_soc_pcm_runtime *rtd,
+					    struct simple_dai_props *dai_props)
+{
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+	struct snd_soc_component *component;
+	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_pcm_stream *params;
+	struct snd_pcm_hardware hw;
+	int i, ret, stream;
+
+	/* Only codecs should have non_legacy_dai_naming set. */
+	for_each_rtd_components(rtd, i, component) {
+		if (!component->driver->non_legacy_dai_naming)
+			return 0;
+	}
+
+	/* Assumes the capabilities are the same for all supported streams */
+	for (stream = 0; stream < 2; stream++) {
+		ret = snd_soc_runtime_calc_hw(rtd, &hw, stream);
+		if (ret == 0)
+			break;
+	}
+
+	if (ret < 0) {
+		dev_err(rtd->dev, "simple-card: no valid dai_link params\n");
+		return ret;
+	}
+
+	params = devm_kzalloc(rtd->dev, sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+
+	params->formats = hw.formats;
+	params->rates = hw.rates;
+	params->rate_min = hw.rate_min;
+	params->rate_max = hw.rate_max;
+	params->channels_min = hw.channels_min;
+	params->channels_max = hw.channels_max;
+
+	dai_link->params = params;
+	dai_link->num_params = 1;
+
+	return 0;
+}
+
 int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
@@ -347,6 +392,10 @@ int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret < 0)
 		return ret;
 
+	ret = asoc_simple_init_dai_link_params(rtd, dai_props);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_dai_init);
-- 
2.24.1

