Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB5CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AEF222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ojr2smqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgBNNN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:13:56 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38410 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNNNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:13:55 -0500
Received: by mail-wm1-f50.google.com with SMTP id a9so10565197wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PW8/MFA25Yi0C3bZ2cfWgw/DrG/iUCeikTSgqslBDz4=;
        b=Ojr2smqtOcE2tiGWdkJkVrM8jprAy8ZrA45J7yJTTR0JYIlhUNuAjNTTgU7r9js9z5
         9nQvxeKuXjOuu0/zlcK0axQHQFev8E4ELS6Mayaiqq2FvjFCQduKkHEWJoyAj4eeMlYX
         JPKjYtYrG4/eyGS7cpUFK+aimGFrpvfKRUV3Wxl24NllRAS+KlME/o2RQt18uJrA3UUf
         ODUL/Mx8HvZBi5N5fRmIYr2yom0Qkigl/NKe/X6M2NGNaTvANIls34mf7yVlcOXPnv56
         BWn5HapyDaM8VZO9E2CP1k87jYzSIOsCUBeU7+QJqTWVb/Xk9FPODgYq9X9ECGqwT9SJ
         AhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PW8/MFA25Yi0C3bZ2cfWgw/DrG/iUCeikTSgqslBDz4=;
        b=SQ8D/7de3sblMQT+lNq1Rk4Q8eGm+5ncqxkm/3tpxT1L8pRB0fHoUqRrXinIWZWUrN
         cltrqSMItPzGm4Ig7ldM/44O11+fOZE5/4EloGTfjmmWUy2KtyVDmG2Ip0G3VHp7lqrF
         Rzrznfmw/7X491evgLEtuue4WxdKWTqjjTHYzPYNXDu7DCKruzrIWe9J27iWMjDEYe+j
         EsRwTXwVX+gHXe7FVLi2vS8Ox9oh9CmP7pp7kWCUsreEGKOEU+1d48azdDSRZP6vU5k+
         D3+i6+wENTeXMfZ3lRkcpnqcrwbJDzbItCXVt3fWKE1qLWhnzQb34HPenbfxzry0hZJ6
         QroQ==
X-Gm-Message-State: APjAAAWRA2DDF5+0GVOInhbryzq5JrTi8zOE19oVZL7NmHU2qoALarRa
        OFNEaY+FBNR9XpneaZQh+a4BXQ==
X-Google-Smtp-Source: APXvYqwx+bxS3TpNkZTl/KLprFFaUaOiA9hlk/SssmWwqsVF/2MHHrh1D96KkZ02p9gnpylN0HxuRQ==
X-Received: by 2002:a05:600c:21da:: with SMTP id x26mr4684621wmj.4.1581686033984;
        Fri, 14 Feb 2020 05:13:53 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm6760792wmi.9.2020.02.14.05.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:13:53 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/5] ASoC: meson: aiu: fixups
Date:   Fri, 14 Feb 2020 14:13:45 +0100
Message-Id: <20200214131350.337968-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some mistakes which slipped through my initial
submission.

Most of these issues have been reported by coccinelle and sparse.

Jerome Brunet (5):
  ASoC: meson: aiu: remove unused encoder structure
  ASoC: meson: aiu: fix clk bulk size allocation
  ASoC: meson: aiu: fix irq registration
  ASoC: meson: aiu: fix acodec dai input name init
  ASoC: meson: codec-glue: fix pcm format cast warning

 sound/soc/meson/aiu-acodec-ctrl.c  |  1 -
 sound/soc/meson/aiu-encoder-i2s.c  |  7 -------
 sound/soc/meson/aiu.c              | 10 +++-------
 sound/soc/meson/aiu.h              |  2 +-
 sound/soc/meson/meson-codec-glue.c |  2 +-
 5 files changed, 5 insertions(+), 17 deletions(-)

-- 
2.24.1

