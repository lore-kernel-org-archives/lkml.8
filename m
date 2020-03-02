Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEEE246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe2NDbzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCBJ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:28:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54547 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCBJ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:28:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id z12so10207901wmi.4;
        Mon, 02 Mar 2020 01:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sR0FhEsXSKCCDrYRRwKUYpG9davzGH2FG45Vb4rPVY0=;
        b=pe2NDbzEDUeJVBuGPCC0zHwwRrT2VgikGLIph0jn/amj7jKusxj8bBgx6xhWEh6+ys
         Dln/FDJbTM2pAwgFnMu6mLaqxZhH0Yf5kWOKxv9iy+uma5UlYkOXrR22t6SwSiz9YmFV
         UE/qvfBMjf/GMqsq0UAB87X4ysYD5sCn6f7kLR8Wz+sJUEB7wB3a2kZsp4aVYOKe2Mx+
         p5t+Ma3TwPiW0J+Rm0rW6VJbOf5DkjNDnF31IJeIgEvLUjH9qjyl3oJad8gznYQCXP5i
         rBYftUrErtUSpYZCizAtnye+vXYI7TIWm/UMZe4G2vT6nC3rxFIUAa5fSrjSc0zuAqjg
         9s6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sR0FhEsXSKCCDrYRRwKUYpG9davzGH2FG45Vb4rPVY0=;
        b=g22vXuAdPhRlttJgSsf2Fqp7W3uTH2D6OrDoAlCuAGCqQ79W9c3Orw1QQJy4Oy7zqR
         0IHKnNz1Bg1/8jIYCbKgpRjmt9tHfxUJcyVoM2swcOjBGYsQLR6pYVwipCBix0VTH3OC
         +nbe3plNETaipCtL5zWUej0pRibmVfzQ3BBudEbjvvtd1hIiqj3f283dG0m5A1eQztHa
         ZyhBVVOUzv54b6u5Hq9UTHoACLkaSW2fpZHjkcH7vae3sXDb59/vwPj9Mn5voSC3y3Rt
         ncHe3CvXh5dngQMxDlPTjiq0tG9aXt2HCQvxphkUZgwqTvAxVPez/D7G4VBhb7xXBgnl
         dUyA==
X-Gm-Message-State: APjAAAUELGTFcacTPd12Rd1KrLulHu/3XnQd7K2AWSzFViPH2eM24Mii
        AL+ygGtP5WSdooOL9aZv4rM=
X-Google-Smtp-Source: APXvYqy8B+IgcMqy+8qba2hEueNLMFC5ir1xC35q040W4SL8MWxcVg98fLxouNiejPKaNx3J23vsNw==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr18094748wmc.129.1583141287239;
        Mon, 02 Mar 2020 01:28:07 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m3sm6409586wrx.9.2020.03.02.01.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 01:28:06 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: arm: fix Rockchip Kylin board bindings
Date:   Mon,  2 Mar 2020 10:27:57 +0100
Message-Id: <20200302092759.3291-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm/boot/dts/rk3036-kylin.dt.yaml: /: compatible:
['rockchip,rk3036-kylin', 'rockchip,rk3036']
is not valid under any of the given schemas

Normally the dt-binding is the authoritative part, so boards should follow
the binding, but in the kylin-case the compatible from the .dts is used for
years in the field now, so fix the binding, as otherwise
we would break old users.

Fix this error by changing 'rockchip,kylin-rk3036' to
'rockchip,rk3036-kylin' in rockchip.yaml.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 874b0eaa2..203158038 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -443,7 +443,7 @@ properties:
 
       - description: Rockchip Kylin
         items:
-          - const: rockchip,kylin-rk3036
+          - const: rockchip,rk3036-kylin
           - const: rockchip,rk3036
 
       - description: Rockchip PX3 Evaluation board
-- 
2.11.0

