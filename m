Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED422100A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bVyqlbjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFQPuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgFQPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:50:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D4C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:50:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l26so2330740wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gz0TiWBmw+aJjacnLXnbSuMlgOySP03BitSmuW5/pTg=;
        b=bVyqlbjOxknCYKDUBm2TKAn89gyvC0qZPTZc+AA89SQykLSHdAZRKlj9ZdaUj9wHmT
         RLp3tLreNr5mzSZs6X7pvHQexd7t8zr0JE7K73pFDBTJBa1fKMRWzns7cYHccZ246Xc+
         rIuhZaJJYEg3C4xUTt4U6/nu1r+oYuzHIvJlY0D5y/fR14Av74tmFTlDm7sld8elr94X
         UMAGtN20nYrKTx6OxZ1LzlWE5z1Ybvg/Tc+nQ+iyNrdHnrJgInLqL/oRGGtwy3xQ3GVo
         lLDk7pmHGU8/Hf3Omb/hL+0lsXobmy2QDxMm0AlvcN5HOmdm8EpwsyJBOEHOlkFrEq81
         AjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gz0TiWBmw+aJjacnLXnbSuMlgOySP03BitSmuW5/pTg=;
        b=JMgyQ5PmNe0T3VHkVuA4YAnIK53BBSAV7LiyIHLwRrom2qCoc2pwYmFufPt92PNDzd
         wvNOKrkPYJW6aCpjdnBzMCRbnPfI77/JS2s/WBr5e/tZQO7KVAi2fksmF3I9qg8EJUgW
         vTinWUSZUhb+hMHECT0BXrjX5rXFtg1PYnYWd6z8W0kiWwt6kCjl7/D+NhuVQo3oFTVt
         Dgb5XysHQmafp/yRyqqd6x8bPZ7kZFH9q3/jcxu/QYkOSXtVtS70l/7xe5xupbpgYT+s
         SaSoAWQ1vwDXL/ZZzmAD0gFPr7x3KKJaMVVoLbGThZzaEgfUQWJbILDMonacu1uvfVtE
         /X7w==
X-Gm-Message-State: AOAM532LJ2HYHo1E10TMxMENn7vZQ3YrMRt7hbhIvM41rIy0rXRRDcG7
        RRPY+n33zemCIi/gt75kNIPjDQ==
X-Google-Smtp-Source: ABdhPJxoFCcxZsYTJQxAd05X6iz1WmWLFZIak3GIqhWjq+mPPpM+Rj1kPj6E5du6HY1VHwaN1pd9Cg==
X-Received: by 2002:a7b:c090:: with SMTP id r16mr9732160wmh.105.1592409053716;
        Wed, 17 Jun 2020 08:50:53 -0700 (PDT)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id d24sm139646wmb.45.2020.06.17.08.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 08:50:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] ASoC: meson: imply acodec glue on axg sound card
Date:   Wed, 17 Jun 2020 17:50:47 +0200
Message-Id: <20200617155047.1187256-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When axg card driver support is enabled, lets enable the related
internal DAC glue by default.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 8b6295283989..363dc3b1bbe4 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -68,6 +68,7 @@ config SND_MESON_AXG_SOUND_CARD
 	imply SND_MESON_AXG_SPDIFOUT
 	imply SND_MESON_AXG_SPDIFIN
 	imply SND_MESON_AXG_PDM
+	imply SND_MESON_G12A_TOACODEC
 	imply SND_MESON_G12A_TOHDMITX if DRM_MESON_DW_HDMI
 	help
 	  Select Y or M to add support for the AXG SoC sound card
-- 
2.25.4

