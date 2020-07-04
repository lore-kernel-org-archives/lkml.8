Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D82C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4A9208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLSRDPJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgGDLkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgGDLjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A019C061794;
        Sat,  4 Jul 2020 04:39:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so32999596wrp.10;
        Sat, 04 Jul 2020 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wM8K//a3jkdseqCAX2c7vevYvjhQJoc1FelDz72tbrA=;
        b=uLSRDPJxTFQXZeoHyKDe5jl2kj0U+TGby3zgXWBnikqtT6iWF2HlxK66opO7RAlSaT
         PlGtaqTqdSRH5fxRrcNbVqNexyGLLvRP60i+KX6k1qhMSGGY9dsvNC3LEVf1INfUi/p5
         ye6D6sD2UHAIpmmf7aM/z87jqs1s877OgEWe+asl/0NtltxFcZb4Sbqp/TRmiSXAxSWb
         hMeWglCBdNY1hf+OTXKA/zPoeoMreUO9Cj7gPjk+gsAYGUQruNFh3K4ZhxTXVI2CmmeP
         adiQel92MTrYxYZqyyWgHE54DkcHH5zUbFyOnnofBty/t4XfBv/3DRt0FhdYIAMuHikg
         RxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wM8K//a3jkdseqCAX2c7vevYvjhQJoc1FelDz72tbrA=;
        b=PnapFxM00MgsCD45ymZzt6bfD3bz1qQrzNpcECG5BhrFOztq5Fv/3ktulxSwF9OsDp
         F9cwqv43SIHYVhXHcbBC8HQfe4YwpMHnaqfMod7x8fU4w3C5m1ehXX9KblOy2SwqkPAF
         6Qy4XRvu5SNK14nVVgVueiDCUitIEZ7Zc4ts1niE9+JXlUp7iQq0LctEjbqNRfYEQNbf
         hgtVwL2BeeWb9fxdAxqcinhgicMGjpjnF+EXNVmsPmpC+Cj8IFfn7DS+3XtBSTxF20In
         P1MorLesjQX1FD8t0Mtz5MV2ipN0iXS/Dg2yqvs2tSZH6ZrX8RFipXszgcxnChRq7SUi
         X7AQ==
X-Gm-Message-State: AOAM532ZpjaKB67qyAvVy62QCWz3NakvooDBdp4Ktub5NwCY2bGfbS7d
        tOIrXtiJEpgqJztQZp6vnl8=
X-Google-Smtp-Source: ABdhPJwuek4INGNtBBLyn1Xm7fiys3LCOLkRgtyoQjhb5oZz83S7qN2/HUPVrbJchM+9xFxxHAwRKA==
X-Received: by 2002:adf:ea06:: with SMTP id q6mr39049381wrm.69.1593862748290;
        Sat, 04 Jul 2020 04:39:08 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:07 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 02/16] ASoC: sun4i-i2s: Adjust LRCLK width
Date:   Sat,  4 Jul 2020 13:38:48 +0200
Message-Id: <20200704113902.336911-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704113902.336911-1-peron.clem@gmail.com>
References: <20200704113902.336911-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Some codecs such as i2s based HDMI audio and the Pine64 DAC require
a different amount of bit clocks per frame than what is calculated
by the sample width. Use the values obtained by the tdm slot bindings
to adjust the LRCLK width accordingly.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <maxime@cerno.tech>
---
 sound/soc/sunxi/sun4i-i2s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9690389cb68e..8bae97efea30 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -470,6 +470,9 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 		return -EINVAL;
 	}
 
+	if (i2s->slot_width)
+		lrck_period = i2s->slot_width;
+
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
-- 
2.25.1

