Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10EBC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B54208CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u3e/2zoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCFN2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:28:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41080 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgCFN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:28:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id v4so2359070wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/SQlldbFSrcIJZeNdEsclD6jLNPj7ywOopnzdmGSlU=;
        b=u3e/2zoIl7mhZ3lQbVX5KBbT43kddGGfuCa7C28fLEjTPyz9pVH/wUFwT7+yTYy+vO
         sHmwmtkFfurb0BNw9LG1iQMVPMaI7pGbbaHPNqgZP9XekedDqeJ1H80iBE46zvsYr8A1
         3QCviLp59OCUSLHvQ2voHogs/u8ujsPewIujnP/CNtO6N/GWtztHBnpVNDwgwIqFkoWR
         edSKhlHP7xGS6j2jgROcopWlk2Ro8aej6MK7GKp70AgsyOk1u+KVK+3ycoILhNiQS9ue
         Pyp82fFJjj/pNR08moPIziLgsCHajEUvHnaO5lYjpq1xg2xIvJ+t5E+bKt46Tx9uI8d1
         VWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/SQlldbFSrcIJZeNdEsclD6jLNPj7ywOopnzdmGSlU=;
        b=kaDXltD/3QOJM0SyuROEZjD9t6dRBSpo9Sh33GGzitLx+Ix+IIuv2wwLJoqJ29rPc5
         4AgvObSLBVWCx6xmWe6eQIX3SPqWQeKcknzGK0xCtlUsZQJMH10A11Gz3H2EMxbzkT9F
         klKQoqrBISqFpmuGRt6rJfq8J5m+4c/qAlQqeHbeDXx4x5t75NBg7f7PFNFGdRWR3O2F
         JvD+MMqZAhqKGQBwmFymmGc5EgL3znUaZwVIe2+40czhSoC/dn7qCGmd/uv0HJPyoRUE
         kSnCNuHXIsmZY4O/ISwEW5Kz99PJJJEJwPYYrML6Q8CN8lqv+Nlv3P6nHBPoDgSUWAev
         wcwA==
X-Gm-Message-State: ANhLgQ1YR5ZONTKTL6d+JDQCTGs+LCe/CQt3dp4ELsAvnB+tPCFcJUJF
        6s/MIuXtz3kM15uhdvU92jM/wA==
X-Google-Smtp-Source: ADFU+vunxoHABI8TriMiol6gqaAZ/kpe93uiKeKsgXKfcON7DsYPrts1EuNrkty/P9eOmwfq9Ndi1Q==
X-Received: by 2002:a05:6000:189:: with SMTP id p9mr4094777wrx.391.1583501292341;
        Fri, 06 Mar 2020 05:28:12 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t1sm53349237wrs.41.2020.03.06.05.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:28:11 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: wcd934x: fix High Accuracy Buck enable
Date:   Fri,  6 Mar 2020 13:28:05 +0000
Message-Id: <20200306132806.19684-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200306132806.19684-1-srinivas.kandagatla@linaro.org>
References: <20200306132806.19684-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

High Accuracy buck is not applicable when we use RCO Band Gap source,
so move it back to correct place.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index aefaadfba8a1..83d643a07775 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1202,11 +1202,6 @@ static int wcd934x_set_sido_input_src(struct wcd934x_codec *wcd, int sido_src)
 		regmap_update_bits(wcd->regmap, WCD934X_ANA_RCO,
 				   WCD934X_ANA_RCO_BG_EN_MASK, 0);
 		usleep_range(100, 110);
-	} else if (sido_src == SIDO_SOURCE_RCO_BG) {
-		regmap_update_bits(wcd->regmap, WCD934X_ANA_RCO,
-				   WCD934X_ANA_RCO_BG_EN_MASK,
-				   WCD934X_ANA_RCO_BG_ENABLE);
-		usleep_range(100, 110);
 		regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
 				   WCD934X_ANA_BUCK_PRE_EN1_MASK,
 				   WCD934X_ANA_BUCK_PRE_EN1_ENABLE);
@@ -1219,6 +1214,11 @@ static int wcd934x_set_sido_input_src(struct wcd934x_codec *wcd, int sido_src)
 				   WCD934X_ANA_BUCK_HI_ACCU_EN_MASK,
 				   WCD934X_ANA_BUCK_HI_ACCU_ENABLE);
 		usleep_range(100, 110);
+	} else if (sido_src == SIDO_SOURCE_RCO_BG) {
+		regmap_update_bits(wcd->regmap, WCD934X_ANA_RCO,
+				   WCD934X_ANA_RCO_BG_EN_MASK,
+				   WCD934X_ANA_RCO_BG_ENABLE);
+		usleep_range(100, 110);
 	}
 	wcd->sido_input_src = sido_src;
 
-- 
2.21.0

