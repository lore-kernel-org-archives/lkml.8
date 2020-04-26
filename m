Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787CC55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0526F2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfuva1sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDZMEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDZMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:04:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E2DC061A0E;
        Sun, 26 Apr 2020 05:04:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so17075434wmc.5;
        Sun, 26 Apr 2020 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJJgAhfk7oMElKUFRIFXFOYn/qywwEUjFDBuFThEtAQ=;
        b=sfuva1sxBAzZHPvMiK3XuIgAyvFBdMlVYiBHcD57MfQ6+50qw2HX4NmbS1P1I8eKKZ
         /aMgB6u6q36iOGdnSL+BiS0R0gtIYIwuTng8Aqz8O66NHAfRaTAdCEAg01mQBr9SrKWf
         0OckZWSg/C0ujFHCTQzzYIZ1NB/kinnelZK9nPLzlowzGZLn/qqnhxYB9MEWY5L5boJW
         a3BnY5WcUie1SWiCN40liJeF42CZR3g0F/J76siR9kwYFzvaeYOzbaGtU2JyeBT8VG/T
         B1JCreV3F0iK4bHSFNsHtrSCEzoe2s3Ub/em30d6/p3ZKWec8gpRhsGuit6HksSHc9Ub
         C+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJJgAhfk7oMElKUFRIFXFOYn/qywwEUjFDBuFThEtAQ=;
        b=hFjqGoLgpdXmeAZCBCU4PbS2aWBWqQzcv8sTGcJN40UMpvwZSlX793CJa/Mn4h/cRe
         9zKUoFTf8SAtHVq81SIyYE4DyfzKg+55yJ5UCxEC3DlIyZb/VHoieJDE54aJqRsM8gJz
         qP5kEfdyNze76K9OCfw1J9lxZjyo1eg4XeMoGbbe6W+6HKMNkhJp+FMcUZyduYZDL6B5
         oinFoFgadqHrwu2kBZzlBY6fVfLVewJG6R2earGbWff6e8uSCoB+DcLRE/QatEGd8PsR
         Fy0VKG93/MwgcnyiAhJe26UnRtwWaSkeY+pwufoyY2vsl6y++2F+eUrjoPFfaLfzCut5
         k9gA==
X-Gm-Message-State: AGi0PuZhoSMXh3zuw8lDkpIM7qizhpu/1hXeGmASa9BsSNDZcSW0aJX7
        vinCo5dIk7eByHloAXdrm1o=
X-Google-Smtp-Source: APiQypJpOD8D5Q3WlZ2OFG6gGKUKug+LlEpJrzk93HqNzrSsg2E8ZE0xp0/y6N/oThQlA3vs6r+5eA==
X-Received: by 2002:a1c:1985:: with SMTP id 127mr22090541wmz.13.1587902686745;
        Sun, 26 Apr 2020 05:04:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id s24sm11120026wmj.28.2020.04.26.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:04:45 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [RFT PATCH 0/7] Add Allwinner H3/H5/A64 HDMI audio
Date:   Sun, 26 Apr 2020 14:04:35 +0200
Message-Id: <20200426120442.11560-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is some work done by Marcus Cooper and Jernej Škrabec.
These patches are present in LibreElec kernel and have been
tested by LE users.

I have rework them to follow kernel rules but I can't test
them as I don't have H3, H5 or A64 boards.

If some sunxi users could confirm they worked as expected!

This serie goes in top off "Add H6 I2S support"[0].
You can find a branch for testing here[1].

Thanks,
Clement

0: https://lwn.net/Articles/817914/
1: https://github.com/clementperon/linux/tree/allwinner_hdmi

Marcus Cooper (7):
  arm: dts: sunxi: h3/h5: Add DAI node for HDMI
  arm: dts: sunxi: h3/h5: Add HDMI audio
  arm64: dts: allwinner: a64: Add DAI node for HDMI
  arm64: dts: allwinner: a64: Add HDMI audio
  arm: sun8i: h3: Add HDMI audio to Orange Pi 2
  arm: sun8i: h3: Add HDMI audio to Beelink X2
  arm64: dts: allwinner: a64: Add HDMI audio to Pine64

 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts     |  8 +++++
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts     |  8 +++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            | 34 ++++++++++++++++++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  8 +++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 35 +++++++++++++++++++
 5 files changed, 93 insertions(+)

-- 
2.20.1

