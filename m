Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C09C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A492098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2DziLIZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgFQMx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgFQMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:53:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 05:53:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so2191255wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OUb64193SWqYIql7DIKLMy9V1uabiBdxixXk3fqRnNs=;
        b=2DziLIZzTZeDGGUTlRaBxWRYbxmn6E+JLiHPzp1Mk53M3nNvoyxiNjIU+bIQV7aFI1
         rZzChTIg3GCeTEAockNd7uXAD8MYY45FStielAJqB8cueELLXv/Do3yJV6c6YH7/zCbs
         WPECD0nmen+IaZSwSZshVGFFTpN8AN677eCBYyZ9gZl/VVbsJUJjPbgbVh3K8AobF2Up
         Lsyj5SefZrKalz21AG0xcpF7mYIwUCXoN/0UJOfBXYdkb/aUoKmKSXIbEoMcHVYVKCr5
         F4BnAaM6p3OcGPizYpa1CfisBWhwy+3UZShh0O/n/bwEQ0EPAccE9+ZEk2C96/TwLKEc
         misg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OUb64193SWqYIql7DIKLMy9V1uabiBdxixXk3fqRnNs=;
        b=R9QiyL+MVyno/HhLFo0ytgWsBG4thJYrNkIb3/rfV2BiMiASB+Zw6POg3G/0qecoBn
         O3fsq7jbHhfDdgNaYtw6ziRKkIvkmocRWWvwO8I8D8OSs+vgVTuxZHHmhhRDZyyuTCWR
         NLJx162mylqyVkvjeYPjwf9SDkkZwfRverDjzmirRL4av0Rw34B3IF1eDr6vy+Co88FC
         7+NR93byHlO2zepuoa6yWmrrZMB12dxzauboDD+6KFVgXuadmxPspA5a4LGfhcGYgLBW
         MZM5V5BnyGJkxf8pRNjmxZsrWPR8Psl+U6GNgmLUlKK+ZVEQKuGGGRuTCj9EhhWupXzh
         5dUw==
X-Gm-Message-State: AOAM5303rBjyZmtUDQD/MtmLaoE3CLWGKmyGXsyScNyre3Fi9M0YD1/J
        mwxXZE3+2uL7NHhheX/9r/TKAA==
X-Google-Smtp-Source: ABdhPJw8wkqbz32oAgpEFT7agRATCW2IXTTcvN5ZJw5GOdwURx9gtNd8s4EpB21kZp+UwN5ZuB65FQ==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr9020528wrw.179.1592398433677;
        Wed, 17 Jun 2020 05:53:53 -0700 (PDT)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h29sm36233697wrc.78.2020.06.17.05.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 05:53:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: add missing gxl rng clock
Date:   Wed, 17 Jun 2020 14:53:46 +0200
Message-Id: <20200617125346.1163527-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The peripheral clock of the RNG is missing for gxl while it is present
for gxbb.

Fixes: 1b3f6d148692 ("ARM64: dts: meson-gx: add clock CLKID_RNG0 to hwrng node")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index fc59c8534c0f..6c8b189884ca 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -337,6 +337,11 @@ clkc: clock-controller {
 	};
 };
 
+&hwrng {
+	clocks = <&clkc CLKID_RNG0>;
+	clock-names = "core";
+};
+
 &i2c_A {
 	clocks = <&clkc CLKID_I2C>;
 };
-- 
2.25.4

