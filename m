Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7886AC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486AC24688
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hZX9mIAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAWNq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:46:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37741 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgAWNq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:46:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so1574160pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9msSGB05EOD+TA6th1Q6DasshXuxXMHpgfWWmoqkjG0=;
        b=hZX9mIAIy9GMqX4umkBL4JNLBU+ujofWPQPTjEzBxMgbIXIeaOfAKSsdtbeZnrdA0k
         F5BDTO12rEh1yXXRYUf5lsWCuv2k2ccVWkLwJj4BwoZR2KwX8X/ldOW/lMkvGcIDwI53
         0vwA/U7bw6xb90SZXS9aghijC1mR8gmMGzmqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9msSGB05EOD+TA6th1Q6DasshXuxXMHpgfWWmoqkjG0=;
        b=iSZMjtz3E484UkTnTlBvwbsB9uYkdWAarIWEZWIT//RCOBaiKpYo5MUGVwv49bbKSs
         VKeAfojpmYQZgyV6ie6tFuc4G4e9isZ0ZnzN68opgUTIWR0HXljaMblpf/zK0Hhh+JBK
         St/YUDZKtpbOrFXNBb8H4mJBpUXi37PYsV+6fQnhXXepYaW1POpjxc4mhpaNnh5WUVxb
         JKWDO7PWAv5dcmwdR6nq+VwQ1d9ZowpR1UtVp+4amzJvXkLwlcQhegFin//79PFY0esS
         64v/3SYb3dLStqxm6AQvC7QPltMq+U5mf5D0uNqNNtxD59IO+okY9A9bWarvamflFrdY
         cgGQ==
X-Gm-Message-State: APjAAAWm3m92Xca3274oK2IP3mEz1MBQCrynfKNtIi4d/FMFNnB3iAAk
        U6OcXbwohW8QFhn3JSqaj4Hc+Q==
X-Google-Smtp-Source: APXvYqwu4dqBx94o0ANFySalOciPvjf6FEO1N1R3Ni57uQ4X5UqK6ImkHDTPh2JeP71b7f82/fpnUw==
X-Received: by 2002:a65:645a:: with SMTP id s26mr3928042pgv.321.1579787215201;
        Thu, 23 Jan 2020 05:46:55 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.109])
        by smtp.gmail.com with ESMTPSA id a10sm3119275pgm.81.2020.01.23.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 05:46:54 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/3] ARM: dts: rockchip: Fix vcc10_lcd name and voltage for rk3288-vyasa
Date:   Thu, 23 Jan 2020 19:16:39 +0530
Message-Id: <20200123134641.30720-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to hardware schematics of Vyasa RK3288 the
actual name used for vcc10_lcd is vdd10_lcd.

regulator suspend voltage can rail upto 1.0V not 1.8V.

Fix the name and suspend voltage for vcc10_lcd regulator.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index ba06e9f97ddc..d2f79e5bee87 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -286,15 +286,15 @@
 				};
 			};
 
-			vcc10_lcd: LDO_REG6 {
-				regulator-name = "vcc10_lcd";
+			vdd10_lcd: LDO_REG6 {
+				regulator-name = "vdd10_lcd";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
+					regulator-suspend-microvolt = <1000000>;
 				};
 			};
 
-- 
2.18.0.321.gffc6fa0e3

