Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE2BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201F82075B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex7BaeD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGUBj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUBj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:39:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60485C061794;
        Mon, 20 Jul 2020 18:39:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so19566732wrv.9;
        Mon, 20 Jul 2020 18:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wPyZFYbVGDNxKTbgFo2yBi3mdzvRIZTG/NUZ4iCEIoM=;
        b=ex7BaeD/uu8dok4zVyE184lob8aIx0yhHpHCc9FSqnYnTTJZAqQ5isKAu2UJ3JQdsE
         +NT6bC7GwAzUVglCzcg152ZBC4z2u8qFNKO7Goj2SmpvkyWatmQnk9HvbAKfEQvYuuDO
         cyZ3bWExks8tFBZe2Blxn2LJfl1jF+JoOC36OS+6dIfrQBqoCzkwDt65b8tG4g8zf9vR
         ZW15NMzBAavHm6e7ALqE9qOt/81x1swcZWHN1OOLadnRbs4DdQHyiOMSEcGts/Ofbt2h
         5bhRsJZqYclW6Qg/D5DJKrYEiBDE0jMu3GtVt+JAKOicTvm3tvGNMz2KCyl+NE3uiojv
         J0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wPyZFYbVGDNxKTbgFo2yBi3mdzvRIZTG/NUZ4iCEIoM=;
        b=k3dI9Yyh5ZHvRYCGuXT6anIi1BeCjXQCINiDck74HntseCcazeevwXZmLXn3Z5iqjp
         /tKy7UOGKdTQ2JcjHqKhODh4q14Ca4MotJQqP0jznQuzjUF2R7ymbX6TPiYWFqYYZkXG
         B0ybRellSI0KXIaWmVXt+BFpj4ohXKI8RjbrUhNO+HXTCZ3gKhEw/6mrjxot1AZdg+3l
         /DnoSbtn4iSP26LCejssT9WprdGqcGGc7D4FuDuVm8zCkI4vzcKOmw9l88CQUHhJao9C
         s5fsYGQIvP2npVN9Xt971OiJVnLJFaZClL063nkha02Q4RrlJVL7kw68bqy0Hia7ASIp
         IWsw==
X-Gm-Message-State: AOAM5338PxZPr9wH6D8dfz3eu8xxhxbqvgvU8rS8xvE8S0r5XpaAZNHs
        s3GCXxSooYOfZl5xFiYcq5M=
X-Google-Smtp-Source: ABdhPJzGP1hvdnHZXIa1OJMmJl9E7yAdXFAB7oEqJrS4WAgSymgIGQtKMlbuahr4B77r524ys+lTaA==
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr2057699wrf.309.1595295597121;
        Mon, 20 Jul 2020 18:39:57 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m4sm1355023wmi.48.2020.07.20.18.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 18:39:56 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2] arm64: dts: meson: misc fixups for w400 dtsi
Date:   Tue, 21 Jul 2020 01:39:52 +0000
Message-Id: <20200721013952.11635-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current devices using the W400 dtsi show mmc tuning errors:

[12483.917391] mmc0: tuning execution failed: -5
[30535.551221] mmc0: tuning execution failed: -5
[35359.953671] mmc0: tuning execution failed: -5
[35561.875332] mmc0: tuning execution failed: -5
[61733.348709] mmc0: tuning execution failed: -5

Removing "sd-uhs-sdr50" from the SDIO node prevents this. We also add
keep-power-in-suspend to the SDIO node and fix an indentation.

Fixes: 3cb74db9b256 ("arm64: dts: meson: convert ugoos-am6 to common w400 dtsi")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
index 98b70d216a6f..2802ddbb83ac 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
@@ -336,9 +336,11 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	non-removable;
 	disable-wp;
 
@@ -398,7 +400,7 @@
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		max-speed = <2000000>;
 		clocks = <&wifi32k>;
-	clock-names = "lpo";
+		clock-names = "lpo";
 	};
 };
 
-- 
2.17.1

