Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71522C7619B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 23:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A6022522
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 23:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="n2bli2id";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOuAmCk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBPXVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 18:21:19 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48339 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgBPXVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 18:21:19 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 926583ED;
        Sun, 16 Feb 2020 18:21:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 16 Feb 2020 18:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=lg4xMnuc1aQMn
        CJVr5pn09+HdQOYg51ajabWpTDNX7k=; b=n2bli2ideoE4TeousfRQ7BNk2DVZ6
        B/5VgICZYjrwlTdWEs4h31BgJQjgWSpMz7qT4bcfzOHZiyJzv59uteMMB7yqy6Ce
        9d45zS6OY/dhoTwhye/Reu86ffDzPe34LIRoEcGll0ZSMt3xXMB43DzfSbwNGXoB
        X5K4OXH5hnLS/Qqo9MEiwH/AgG6eYEc/epAJsCYhu0nDnqpJDqJf57WxX4B90mZf
        hkzlSdKBam3t+bVCGDeNkU/UBVICpj5laMReKvkPcg4DaMI/kspTrCmZ4ssy+bdl
        lDH3P+rzZc2JwXKMjKm4H5/8x3eE2LviyByd1XNxRw/CHbNGTfNLwJa4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=lg4xMnuc1aQMnCJVr5pn09+HdQOYg51ajabWpTDNX7k=; b=OOuAmCk6
        GDRVBM18gSPL5uePw+HPhkkHgn3bKeSVwoEFnyBJ9sSFgTEHL93bceGqU2ThVrC9
        TDpErPOkEZxIuWyr59e9KHkBCoJljc/KUnYVAe2JLF4Ijd+VFa/XP71e3h8Ev5Db
        rAxhdTcNL+Ft3mGqvxRicSO3zwksfR9cMEDnOnLFkT+Z/pFls+CbAfiJxcyQeL8s
        QsDsF2OukBXsSFqEP87WFN7qmOsPdgyCiRzGNgXlRCmCo46sxtOZ+RoCjJ3rZqdV
        4ukl9WLoebLHmn4bd8a6kleOY2r9wDDz/cWwNxF7doaKGiW3bjftC2c6QwK1Fffq
        /n7RCPZ9I6Nt/A==
X-ME-Sender: <xms:bM5JXlmekSwgkn1UpGD-z3oV11Te2Y4ouvzAQJawdo2ennMY1S6kyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:bM5JXlFXdZcjcc0sqE0B6GQAyq3kT3_NuXxPNn7FF_390c50vkkOhQ>
    <xmx:bM5JXmrgv2cNSxPa7fLFgX33opSgUc9G0xzGswacMy2vbgHlcwKfjQ>
    <xmx:bM5JXp7SCG0NfBPfR45ZT4cKXChZIvsTBnVIH4NDCChTu8ZkVogadQ>
    <xmx:bc5JXgs2fvZVNxal1LPS6YspRbO-OMklAsQJDm9j15rAVMmVmUyOpg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB8293060C21;
        Sun, 16 Feb 2020 18:21:15 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 1/3] ALSA: pcm: Add a non-runtime version of snd_pcm_limit_hw_rates
Date:   Sun, 16 Feb 2020 17:21:12 -0600
Message-Id: <20200216232114.15742-2-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200216232114.15742-1-samuel@sholland.org>
References: <20200216232114.15742-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful to derive min/max rates of a snd_pcm_hardware without
having a snd_pcm_runtime, such as before constructing an ASoC DAI link.

Create a new helper that takes a pointer to a snd_pcm_hardware directly,
and refactor the original function as a wrapper around it, to avoid
needing to update any call sites.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 include/sound/pcm.h   |  9 ++++++++-
 sound/core/pcm_misc.c | 18 +++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 8a89fa6fdd5e..a05202cf9448 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1121,7 +1121,14 @@ snd_pcm_kernel_readv(struct snd_pcm_substream *substream,
 	return __snd_pcm_lib_xfer(substream, bufs, false, frames, true);
 }
 
-int snd_pcm_limit_hw_rates(struct snd_pcm_runtime *runtime);
+int snd_pcm_hw_limit_rates(struct snd_pcm_hardware *hw);
+
+static inline int
+snd_pcm_limit_hw_rates(struct snd_pcm_runtime *runtime)
+{
+	return snd_pcm_hw_limit_rates(&runtime->hw);
+}
+
 unsigned int snd_pcm_rate_to_rate_bit(unsigned int rate);
 unsigned int snd_pcm_rate_bit_to_rate(unsigned int rate_bit);
 unsigned int snd_pcm_rate_mask_intersect(unsigned int rates_a,
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index c4eb561d2008..ebcf820ab5ce 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -473,32 +473,32 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 EXPORT_SYMBOL(snd_pcm_format_set_silence);
 
 /**
- * snd_pcm_limit_hw_rates - determine rate_min/rate_max fields
- * @runtime: the runtime instance
+ * snd_pcm_hw_limit_rates - determine rate_min/rate_max fields
+ * @hw: the pcm hw instance
  *
  * Determines the rate_min and rate_max fields from the rates bits of
- * the given runtime->hw.
+ * the given hw.
  *
  * Return: Zero if successful.
  */
-int snd_pcm_limit_hw_rates(struct snd_pcm_runtime *runtime)
+int snd_pcm_hw_limit_rates(struct snd_pcm_hardware *hw)
 {
 	int i;
 	for (i = 0; i < (int)snd_pcm_known_rates.count; i++) {
-		if (runtime->hw.rates & (1 << i)) {
-			runtime->hw.rate_min = snd_pcm_known_rates.list[i];
+		if (hw->rates & (1 << i)) {
+			hw->rate_min = snd_pcm_known_rates.list[i];
 			break;
 		}
 	}
 	for (i = (int)snd_pcm_known_rates.count - 1; i >= 0; i--) {
-		if (runtime->hw.rates & (1 << i)) {
-			runtime->hw.rate_max = snd_pcm_known_rates.list[i];
+		if (hw->rates & (1 << i)) {
+			hw->rate_max = snd_pcm_known_rates.list[i];
 			break;
 		}
 	}
 	return 0;
 }
-EXPORT_SYMBOL(snd_pcm_limit_hw_rates);
+EXPORT_SYMBOL(snd_pcm_hw_limit_rates);
 
 /**
  * snd_pcm_rate_to_rate_bit - converts sample rate to SNDRV_PCM_RATE_xxx bit
-- 
2.24.1

