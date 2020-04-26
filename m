Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA13C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09A32070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJTyWott"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgDZKlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgDZKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:41:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441A9C061A0C;
        Sun, 26 Apr 2020 03:41:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x17so16227518wrt.5;
        Sun, 26 Apr 2020 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t36awUAxBdURHa0pPaeUAx2wGUximeZMbTRyNuoxFJQ=;
        b=DJTyWottTMVyc6z8QE28iZUq89K4lfUqv7E0bZ5i00aryQAtf8IQhI6iOj+qjELeIL
         Mai5Ks/HBGmUe3f7su0WhujgOQzyX4MjfVB3gYYAVGu3i46Yl2RLQFhZtHu/Vrt+vQpa
         AYOYXLSc9siKKV81KymabDWHdPxvIN30C3zeirXkQ2lIIfkuf1KRIlrwmLJzK8mTevax
         yWqeX7zL5XPo8nnlZE0SJR/6piBu4vwO/zoSeRNcPPe64a7zzSfbj2tPy05R9xal7yRH
         w/tso/JEplt8R4PEiwW2rxUX/GnjzdVNJbsk5lQMSOy1xeEReNkWKcIW1m5HTC4I93Yg
         xG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t36awUAxBdURHa0pPaeUAx2wGUximeZMbTRyNuoxFJQ=;
        b=MGtz1wfB8F2YxaU73yRwcowIDFfJ1DHWdzL9svBxHBEoEG8u8xDS4tycTJURayWbI+
         HoOobpMmeSQdr/J0AC5Cwxr1cjuH+l8n1FXNVyfUND6oU2TrQZ0/l1GykzInQu8Ip3kv
         dVE+sNC8LaX+hW4ACBeU/Ym9wEFnLsgU9vIu0Rmw/VWWioq+Jhb6i63eNjz39tVu/p9L
         A0Tn1Zc0iRmIejRaUG9I3Dce/usa/4LqSYHdGChQl3+yTnKTsgqW0FaIn/xPu6lJyMub
         BF5+SS41AZ3S4By8Qd311TdEQjIIu0rVvFoRKdrE+jidWeGUGqCMRO9/2hRL6xjQfPMk
         TAWA==
X-Gm-Message-State: AGi0PubOnYUiahuOWQj2tEUVMdk9LuZFje3znnwp4LW04zzqC9uf9enB
        8H3ZhJAi36vVtdaXKiIJamWlS2+Jo+Q=
X-Google-Smtp-Source: APiQypKFE6ZvIpfTdcTCsjnX6lRWOkKiGHpgutcqgs8f5RsTU7gCLlhGaKzJPimh6XbZNz2/ILqSwA==
X-Received: by 2002:a5d:4e12:: with SMTP id p18mr22033146wrt.148.1587897678658;
        Sun, 26 Apr 2020 03:41:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id y10sm10491793wma.5.2020.04.26.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 03:41:18 -0700 (PDT)
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
Subject: [PATCH v3 0/7] Add H6 I2S support
Date:   Sun, 26 Apr 2020 12:41:08 +0200
Message-Id: <20200426104115.22630-1-peron.clem@gmail.com>
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

Changes since v2 (thanks Maxime):
 - Add details in commit log about sign extend sample
 - Only set FIFO regs as volatile in regmap
 - Missing a space (detected by checkpatch)

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
 sound/soc/sunxi/sun4i-i2s.c                   | 265 +++++++++++++++++-
 3 files changed, 296 insertions(+), 2 deletions(-)

-- 
2.20.1

