Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08074C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D940A20775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHGUg59+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGGOiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgGGOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B74C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so42987585wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qKCC8gwbOOqZ6yEPkGSkmGeka7mYOZ7iXEWMftP650=;
        b=MHGUg59+CIiFn+a4HTqUDEaC2OOzC3fBDNG+gmNZc5Lq9ga6wt3BgEtSO4rzK1gKON
         NN5LiJlHqnLYB1HB4rYnJh6GKCBxpjgG8h89hEH6g8xuCSdXT/X+luQoiJOLszEJ/io/
         oouYXSL7QPMn2mAU/9wE9JCbevJrGhq8fii5XwWGCb/lQfNDoEMkT4FRjq7IvkPcQ2GU
         Uz+cWLLyEM0fJHsdE2DuVaMkxw/M/1OSs1Rzm8rO5hmjJIZw9+SadAEK9JxOkYnBYF2z
         +/SldD0QP9BmkNSVD4HpW10ulLY9YmbObsFRymw2yL1n3cACA26WRz+yfbdB4KgVW6Jm
         cC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qKCC8gwbOOqZ6yEPkGSkmGeka7mYOZ7iXEWMftP650=;
        b=nYRFUUYAhOhHuRS+IKKddpaH/HBTNqOlFLgPriFw+U/kjDaxqsW3GSIy9srohzCMWZ
         6H1TsT/p8DlonoLwTop3Af/adVWRlybTTYd3kfOpE5V50CJDyTlqvZqaspH2Kl0RYxhT
         y+0D5UhVWp7F4bFIkZ/tHxYbQj79Zw6Uw6rswdct4yx8uXrTHXCg7MdDNJcR0ztZkPzW
         Y3Wt24O/thAsZoezSaDvKicx42Ii8caKbtLZDwWXvt6jFB518vHe1iUOuRqTL7+hJ4/x
         PQ1a22MSQbiALkRbPOlpaSMXFfG8IFzD5d1QaR4lnHkzMUq9JsInsMKnXakqj/QdF8ql
         fJCg==
X-Gm-Message-State: AOAM530v+A+pYT0kwjRdc1UFkXkqRaSddb4rMpbGdwUsyqRSjGXXQ3kN
        vIl4nnhGm8N1+lO4EyhI5nrc8Q==
X-Google-Smtp-Source: ABdhPJzaV/3UQ016kv4Ag7+B7phfs4pD1pKuxhbyntXYNoHYbkT+tFXMCA/jg3bjpvj9sjSTi1yKtQ==
X-Received: by 2002:adf:f784:: with SMTP id q4mr53880655wrp.397.1594132685030;
        Tue, 07 Jul 2020 07:38:05 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
        Mihai Serban <mihai.serban@nxp.com>
Subject: [PATCH v2 12/28] ASoC: codecs: ak4458: Remove set but never checked variable 'ret'
Date:   Tue,  7 Jul 2020 15:37:26 +0100
Message-Id: <20200707143742.2959960-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as though the result of snd_soc_update_bits() has never been checked.

Fixes the following W=1 kernel build warning(s):

 sound/soc/codecs/ak4458.c: In function ‘ak4458_set_dai_mute’:
 sound/soc/codecs/ak4458.c:408:16: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
Cc: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/ak4458.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index f180cb5dfe4f1..39ae089dcd1d8 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -405,7 +405,7 @@ static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
-	int nfs, ndt, ret, reg;
+	int nfs, ndt, reg;
 	int ats;
 
 	nfs = ak4458->fs;
@@ -416,14 +416,14 @@ static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 	ndt = att_speed[ats] / (nfs / 1000);
 
 	if (mute) {
-		ret = snd_soc_component_update_bits(component, AK4458_01_CONTROL2,  0x01, 1);
+		snd_soc_component_update_bits(component, AK4458_01_CONTROL2,  0x01, 1);
 		mdelay(ndt);
 		if (ak4458->mute_gpiod)
 			gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
 	} else {
 		if (ak4458->mute_gpiod)
 			gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
-		ret = snd_soc_component_update_bits(component, AK4458_01_CONTROL2, 0x01, 0);
+		snd_soc_component_update_bits(component, AK4458_01_CONTROL2, 0x01, 0);
 		mdelay(ndt);
 	}
 
-- 
2.25.1

