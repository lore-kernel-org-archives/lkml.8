Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C65C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F42F20724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H63+etA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgDTLpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:45:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87C9C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:45:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so2585835wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ncP3J/qEg/xypRpjtJqFD+RT7/yjhZOFPm/IKzFyAyk=;
        b=H63+etA+aBJlMVl9xXpa86QHXb9a5dX32vkn2AEsYOB2Lr39BmuXB9GZNtuMJLMEio
         F53gZCaOUDJ9+0KKUFKultag1E9Pa9jDIFNz1e7t1UJu3JLjq24zZripnzQjBRDGmSF9
         Tz5s/Ougfco1mti4PclNrUptOOMomFy+9D52yQI+aAlnCNA9VO9iMMbcShgbNWy1jH1w
         tvb5CpgD4H2+MLjYLlhSdpDX/DFYnzbVpndTRT5ipifwYaB9crfOlT8QUByVkQ1STmqu
         /FbzVWAhCaKUXnZCaJUQml4fQ8rRIY8Rzlc1Ky/A3LuYEKp8jS16VQjRt+cIcgZ3obsq
         HyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncP3J/qEg/xypRpjtJqFD+RT7/yjhZOFPm/IKzFyAyk=;
        b=WhjRVZ/VjVoDtUP6kI6LxyVjd7d1vjul0ddcbGf7NO8VUuzRkJs5T64KhrsbJXrILs
         ogow0wmmpCvceKs1QOeKsNPWQ2SOIcuSiUNru4Cbq6ZNrhYFZEDviW/C3tg3pceCKDkW
         OzkAlstZgkefCscFrO50m6jK/vvECURYwsA6y5dMqFEd/0+uCkqC1u8iObjJWaW57dku
         9bUHpiipAh1mgbbqF59C68znDgdSPORCECd5U035m2lrJWolkrwGWWFS8wMVH++l2zjZ
         qq9vSpk83x2ICSyQcLHL9ZKUpSpifg+rYXbscrqXwTQMGK/egudZw35aVW6jW10WKmFh
         cV/Q==
X-Gm-Message-State: AGi0PuYa14dbPhceJjZPwJyd2mvW8gaxpklkPFQVH5KM3mQvizxX3ILP
        eiJl5RJZ9Tv3Hl0Nvhs+10OIng==
X-Google-Smtp-Source: APiQypJtZQCS5Jcc+6Wrcet51tOZw+iTZukm4wlAyWIuiJnqxjolLoYFCVIQCmLUUeNj3EDTq5gHsg==
X-Received: by 2002:adf:bb0d:: with SMTP id r13mr19633300wrg.251.1587383118410;
        Mon, 20 Apr 2020 04:45:18 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id k6sm1079182wma.19.2020.04.20.04.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 04:45:17 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/2] ASoC: meson: gx-card: fix codec-to-codec link setup
Date:   Mon, 20 Apr 2020 13:45:11 +0200
Message-Id: <20200420114511.450560-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200420114511.450560-1-jbrunet@baylibre.com>
References: <20200420114511.450560-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the addition of commit 9b5db059366a ("ASoC: soc-pcm: dpcm: Only allow
playback/capture if supported"), meson-axg cards which have codec-to-codec
links fail to init and Oops.

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000128
  Internal error: Oops: 96000044 [#1] PREEMPT SMP
  CPU: 3 PID: 1582 Comm: arecord Not tainted 5.7.0-rc1
  pc : invalidate_paths_ep+0x30/0xe0
  lr : snd_soc_dapm_dai_get_connected_widgets+0x170/0x1a8
  Call trace:
   invalidate_paths_ep+0x30/0xe0
   snd_soc_dapm_dai_get_connected_widgets+0x170/0x1a8
   dpcm_path_get+0x38/0xd0
   dpcm_fe_dai_open+0x70/0x920
   snd_pcm_open_substream+0x564/0x840
   snd_pcm_open+0xfc/0x228
   snd_pcm_capture_open+0x4c/0x78
   snd_open+0xac/0x1a8
   ...

While this error was initially reported the axg-card type, it also applies
to the gx-card type.

While initiliazing the links, ASoC treats the codec-to-codec links of this
card type as a DPCM backend. This error eventually leads to the Oops.

Most of the card driver code is shared between DPCM backends and
codec-to-codec links. The property "no_pcm" marking DCPM BE was left set on
codec-to-codec links, leading to this problem. This commit fixes that.

Fixes: e37a0c313a0f ("ASoC: meson: gx: add sound card support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/gx-card.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/meson/gx-card.c b/sound/soc/meson/gx-card.c
index 7b01dcb73e5e..4abf7efb7eac 100644
--- a/sound/soc/meson/gx-card.c
+++ b/sound/soc/meson/gx-card.c
@@ -108,8 +108,10 @@ static int gx_card_add_link(struct snd_soc_card *card, struct device_node *np,
 		ret = gx_card_parse_i2s(card, np, index);
 
 	/* Or apply codec to codec params if necessary */
-	else if (gx_card_cpu_identify(dai_link->cpus, "CODEC CTRL"))
+	else if (gx_card_cpu_identify(dai_link->cpus, "CODEC CTRL")) {
 		dai_link->params = &codec_params;
+		dai_link->no_pcm = 0; /* link is not a DPCM BE */
+	}
 
 	return ret;
 }
-- 
2.25.2

