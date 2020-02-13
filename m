Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32120C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071F2222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LYTr/jwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgBMPwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:52:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35765 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbgBMPwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:52:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so7304319wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aB1AiCkdQEWl25o0CFyQmEuSLs3mwyleNLQ7q44t8HY=;
        b=LYTr/jwnIP7xB41uk/g/SVYjXm/Nywl7CqihGSb6gmVFQuEoDKE+M6yeLtXBuxzSDV
         WSSiblX+7cKEZrMWY2arxWYNZs2uanjtjOd+R/yUTEMfW9J33ZT633LPckPXELjES10Y
         Aw8ZBK7NcNiN9jxHEIKAUsv3sAXzaBPkttp4Zf6trbnjHLj5fnXmyXOrUZL45qj2ssGU
         GnuX/g7Hhi6cCKYgZwWfl0kXt6jC7LA9LBGTwFzOU3OSPGWRVbd3/jvNcy2c28hqmfKB
         nNEVuHcu1cXqvVGTIH5fetzbCx7zyvwiZMeRE4ET5ZeNlolaqQALDjFF+9l21K1IDFee
         UTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aB1AiCkdQEWl25o0CFyQmEuSLs3mwyleNLQ7q44t8HY=;
        b=or5Opo5xpBcLr4w7waDmALJiTW0RKzWAKbU5JwKZZARCs1JofF9vsBzouIApTKbBim
         TERM9tRPMPw1Vdr5QEX+WQ89EWLiVtGoD/EFFfIkhKJUMRQq4MnpX1RtsuzfDiVnbOgJ
         aLwih8dZEmmK6OC7gHwRUiN1WoBB/FcXfQiGwHxTeIJyvzR6qwUjAavZk5ZcqvlUMxli
         cblC59Bxvdr80F8DSLqrRt7HrVJwzNwA0YFUP4mhun0C0NypQP+IKmYCvTOp00q9ZjsE
         qNqU1hqbfseJ8MhamWnAMso/xq6fuSO0xd6lXIkq5PK8H4IgkSlguf6dLgNPMHAWambd
         Lhxw==
X-Gm-Message-State: APjAAAXRtkByeWad23b2xkMt8Eauic9zBLDeMXWWcUT9z75q24pgO2Nq
        pLeFoLz0X7X5a6uypapzK3+qDg==
X-Google-Smtp-Source: APXvYqyEvLneyxVeHuI/0pBQCYZi5+WLlVqFWpfGuTvBL5p6xmOWK7iqZ4/PQzBDgirZhGC884Aaew==
X-Received: by 2002:adf:f850:: with SMTP id d16mr21763639wrq.161.1581609128618;
        Thu, 13 Feb 2020 07:52:08 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e1sm3319814wrt.84.2020.02.13.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:52:07 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 1/9] ASoC: core: allow a dt node to provide several components
Date:   Thu, 13 Feb 2020 16:51:51 +0100
Message-Id: <20200213155159.3235792-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213155159.3235792-1-jbrunet@baylibre.com>
References: <20200213155159.3235792-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, querying the dai_name will stop of the first component
matching the dt node. This does not allow a device (single dt node) to
provide several ASoC components which could then be used through DT.

This change let the search go on if the xlate function of the component
returns an error, giving the possibility to another component to match
and return the dai_name.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 068d809c349a..03b87427faa7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3102,6 +3102,14 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 			*dai_name = dai->driver->name;
 			if (!*dai_name)
 				*dai_name = pos->name;
+		} else if (ret) {
+			/*
+			 * if another error than ENOTSUPP is returned go on and
+			 * check if another component is provided with the same
+			 * node. This may happen if a device provides several
+			 * components
+			 */
+			continue;
 		}
 
 		break;
-- 
2.24.1

