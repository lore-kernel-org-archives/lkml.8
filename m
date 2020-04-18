Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E292C38A30
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4892821974
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8KltfH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgDRWok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 18:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDRWok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:44:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB72C061A0C;
        Sat, 18 Apr 2020 15:44:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so7427780wrx.4;
        Sat, 18 Apr 2020 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wutgCaF9Zt/dkeWGofK0wxzxUn+L+6837DjwQz9y1UY=;
        b=S8KltfH+/O56KBksVXD14TzKEOLFfEQyo4KgSjFu66oO3Uk5cwNWg5nBnLAjoS5ztX
         4xjow8fTnW0ns/pNDHxBa5a5+HshR5W40o9c/ct5OZrf1o1ZG4g/xKmOfwpk1WBfCTQ0
         ojGBTITEANi7ER1oclt1vO3TzETC08kH/nIk2fi7a9QfgpGFae5VLrbgydJdH1SHsDAX
         o1rZrKERoVYwEZEV+PLbbMA7oMVaXf7LID9r6dRhyaPDcSslUQfQlZglgE/ClFrKpR80
         syrlPCDBugz7YHcQpyH8KXBE/bZOSNAz4isuXF2RD/fSJPp3i54pYPc9E2Bpl5wTZwIC
         fKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wutgCaF9Zt/dkeWGofK0wxzxUn+L+6837DjwQz9y1UY=;
        b=b8+IBnH0oHgCjm0Fg8L4LiDkuW29vbI+rUW7tCNtsTqZzpokjlpwWredQ3FGFmqySR
         pnhNLCxnhVdBkGH0R/a5kfKSz0AAFRccmo0sF78ybry/m8mTm4z4uT7AZrApbOuWAA50
         DnpniLVr46zz0EogJep/kMLe6b12As5Ta6Kk2rRaMQiwvJJ04RQqkGLCMRXwVsyyEdcf
         jLZcNxvQrQQIBqCdDW3olfdWsLx9ddnJlLWePt3F3VYb1WY3Igy/A09Zovb04PZx9EP7
         5IFPGvr6eH9w7lQKnOtWqI7+mTniEfwd4EgsCuJt9JfVnD/Nb76sWcnIHdAAE1C6dB+1
         xF9A==
X-Gm-Message-State: AGi0PuYznXECg5wd4trssVqTdIVFBKJ7JWRF7OjRWPK+GNswzkoLdP2+
        33wwwpy5I+UecfSKQJI/byOFCkSlJAA=
X-Google-Smtp-Source: APiQypLOwYrHCgIWndZgkcTL4l0O4nIwWLNdaqPiGUU1qxzWWClq+DqLkuqfQGwqt4juRRHwGPellQ==
X-Received: by 2002:adf:dd07:: with SMTP id a7mr10688193wrm.349.1587249878341;
        Sat, 18 Apr 2020 15:44:38 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id t16sm13371559wmi.27.2020.04.18.15.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:44:37 -0700 (PDT)
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
Subject: [PATCH v2 0/7] Add H6 I2S support
Date:   Sun, 19 Apr 2020 00:44:28 +0200
Message-Id: <20200418224435.23672-1-peron.clem@gmail.com>
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

Changes since v1:
 - Fix missing header in set sign extend sample

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
 sound/soc/sunxi/sun4i-i2s.c                   | 292 ++++++++++++++++--
 3 files changed, 301 insertions(+), 24 deletions(-)

-- 
2.20.1

