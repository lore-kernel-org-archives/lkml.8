Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F57C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CA02220A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9cA2LGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgDROjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgDROjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:39:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDD1C061A0C;
        Sat, 18 Apr 2020 07:39:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v8so7074484wma.0;
        Sat, 18 Apr 2020 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stLQlVuh4P5IJ5M0lj4/6uAQgTyw/bQBI8ltWxyZDXo=;
        b=E9cA2LGcfpwjWkWL0LUCKY8rmu73mUw4/VIbbjYfLKPQwuWP9GEU6t7ShXY0UXKUmt
         Z8fXWZurPul5Q9s9FOLmzG8iSW+h9wQGvfq/Vay0WY8Wa7Tz8vb4B2JnsAmuQHQQIOzr
         jW2PHrACksVjQkQZd1h+cahQd+HTFKynZObqNlHA6BRUDaM/67kufXqd5vmEIFB3F5D+
         T9p3+9Gkb010F2QJ0jY8Z9vjeEEAtCmOftABQtUOWhaWfAQdnBRi/2pOiSBw4FqLeuFj
         Pr9VnRQ1cMPsoNr7KfX6BwqUkMOg1kFog4UDIjA0Qum20JgQHo2GbTunOfUK9YQa+HjZ
         yB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stLQlVuh4P5IJ5M0lj4/6uAQgTyw/bQBI8ltWxyZDXo=;
        b=iAtxmjmEZQ8W3oHtAST3O9aVMvY23WeKhGixAorKbSU9hLsa/BFjqMFTvQj04SDV8Y
         BIIMT8nvAmNcP0v3V3JcUbf/yinHTDxinsnFqGjVslA8ux/PuynrmxrcvfJ/GD5dzrRR
         u3t61QHBEjwiq3AC0/OvWjZgU4LoyZmgGry0hAVMvyca5y2yKdyb9fOcIG5q0sLpcek1
         oeo5YhgGlkfvi8IDXc62+Hhe3oFz83ibfP3bOsH6i09+yb/egC1bYWna/ZKLU3TWn3gg
         s3tpEsLUincJO1hJST0OZ3wE43JAdegQ682w+CuO3ZHNxVeEFfrwHh0IJOEk3EVebSZc
         V/Kg==
X-Gm-Message-State: AGi0PuZvo/SPF58/lZ5uEhqVhSCDPvYMPE8zpkizuLplLJM/PWg09w/d
        qkeXc8Ly7wvns3ppIZgosrA=
X-Google-Smtp-Source: APiQypJgp3beoqLe7KxcrcgO1iEb5Zi5/JPSvihpkv2bGufse5QTbKlcUIFXicuNuiKrgQXX+QJ18g==
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr8551841wmm.150.1587220767261;
        Sat, 18 Apr 2020 07:39:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id s9sm25375322wrg.27.2020.04.18.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 07:39:26 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 0/7] Add H6 I2S support
Date:   Sat, 18 Apr 2020 16:39:16 +0200
Message-Id: <20200418143923.19608-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a sequel of Marcus Cooper serie[0], where remarks made by Maxime
have been fixed.

I have tested it on my Beelink GS1 board.

Thanks,
Clement

0: https://lore.kernel.org/patchwork/cover/1139949/

Jernej Skrabec (3):
  dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
  ASoC: sun4i-i2s: Add support for H6 I2S
  arm64: dts: sun50i-h6: Add HDMI audio to H6 DTSI

Marcus Cooper (4):
  ASoC: sun4i-i2s: Adjust LRCLK width
  ASoC: sun4i-i2s: Set sign extend sample
  ASoc: sun4i-i2s: Add 20 and 24 bit support
  ASoC: sun4i-i2s: Adjust regmap settings

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   2 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  31 ++
 sound/soc/sunxi/sun4i-i2s.c                   | 286 ++++++++++++++++--
 3 files changed, 295 insertions(+), 24 deletions(-)

-- 
2.20.1

