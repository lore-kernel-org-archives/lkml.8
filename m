Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E16C54FD0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0977A2071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj/j+alN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgDZMFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgDZME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:04:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD759C09B04F;
        Sun, 26 Apr 2020 05:04:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x17so16372176wrt.5;
        Sun, 26 Apr 2020 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8FDkpOterxD+ozyNdLEoNF3qT9jBBj9bIEzb2R8YME=;
        b=fj/j+alN0ho486l2Xz+rdD9b30m8p8mXtuFuh2lwyX8YqLrZzmlPAFICA/fEmYP9up
         txwyM/no0xzoHKZv8vLBqLNm0L6ZjHdTJR567yserWGOboO5uoweSdKKhCu1O35jbgQw
         4/HD6uzHbX7eTVLyX7mZoqMK9hJYBOOs7EtR1EPQz+n08DG2hxoOxXKL4WTopWPRs+rk
         fcbglCm54D1DlxcBAm1/WtqtWXIqXUSvWylf2MtfJN9xnJs7FUqIxGqTdUX2JQNBKrNT
         gm9wqwGlHHvSd9dqp9grtSLZbWRl48ZqdQhVTvWrogeXsw5zHtGS050Fux8AsP3VCx/m
         Ec1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8FDkpOterxD+ozyNdLEoNF3qT9jBBj9bIEzb2R8YME=;
        b=tx7Y4IKPiNeIeUiF9AI3K67sX6RKHdVotx7xIgr5oZOv/VMoAyvNnhXDlugk+KGt7a
         LFiYKXEd1/MR01bwgs/awAT5a74TXEV107/SXO20bs3lyOjswc8syAcZlzmIQguRzbIV
         FQlyqpI47O5WQwwS9+7CwUkSUap7mTDsC7sQH1vrVM71XIGfnpbQO5lm+JvmmktPM7+m
         di3WbAnVNdQWKpullnty8pbEMDnUE7Ur+SfVCMa4EWVXkjiVt5Qc8eIoRioEbZH2sPn8
         h65qVQzpCnEPxILcwsLm4/0EzV0+vhHzbO6myiFGpFxEViklb6ZDGueoO1zv/SxZe6iT
         atJA==
X-Gm-Message-State: AGi0PuZ1aJsUuGlSTyw726TL52yP7HAMeawufAOgr6RLuGd5MTsgccHc
        NVOCW+x+g2Q44dpga9fDQXZRFEcINmAtWw==
X-Google-Smtp-Source: APiQypJX89nzq607NY5Wjke/a1jEcpgbysZ4fzF+10u5wlKe8WSHjdGr0Jt93SXlggAfwNVrkI4RBQ==
X-Received: by 2002:a5d:6ad1:: with SMTP id u17mr21231497wrw.170.1587902694276;
        Sun, 26 Apr 2020 05:04:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id s24sm11120026wmj.28.2020.04.26.05.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:04:53 -0700 (PDT)
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
        Marcus Cooper <codekipper@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 7/7] arm64: dts: allwinner: a64: Add HDMI audio to Pine64
Date:   Sun, 26 Apr 2020 14:04:42 +0200
Message-Id: <20200426120442.11560-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426120442.11560-1-peron.clem@gmail.com>
References: <20200426120442.11560-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Enable HDMI audio on Pine64.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 2165f238af13..c5939ba52f19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -99,6 +99,10 @@
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -107,6 +111,10 @@
 	bias-pull-up;
 };
 
+&i2s2 {
+	status = "okay";
+};
+
 &mdio {
 	ext_rmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.20.1

