Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB535C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A621A246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjhnHUAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCBJ2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:28:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39367 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgCBJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:28:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so11593626wrn.6;
        Mon, 02 Mar 2020 01:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JT9LGJ3nprOFd57YdHFTo6kmk4rD0oOGffgTW8cRvZI=;
        b=GjhnHUAs17IpwhpIp4EZFaFCjGdIMvqXOl3gcf0RMYe3UkTvWSpAM2NPK9wbb7+qzg
         +ru36XkESaCNdY3Po6JQvG2rFJssKOi1GQYirmXNjKqntHvOAdLzqoqsMPJVASt2mY0L
         Gk3yHOlg6JZXifIic6opV9dIFOimFgGi/YT1tW4+UxB9DgRrUIE/9SH4KAp2tGfR/HXO
         MfFXTMG2DFuLXzDQn6kFdf1GUcM6EpEkbRJZnvuj8/6SC1uSr6w2TDs2b1gl6JeHaw6i
         v2wowbsg+sPT5wAmlWnpwbxKEaG0kDPJgNszXWP0roOi9K+H95ibCVtCeqWjO8LGHLc5
         D2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JT9LGJ3nprOFd57YdHFTo6kmk4rD0oOGffgTW8cRvZI=;
        b=MvOEK6PZltNpJQmKgFym7zs/TGyToK11xefnivCuUuqwFAOsDx34nPSjtWj/ChnGYn
         IeugxqT3Eg5dgUQlLDW0EzN22Dq+NQxz8ZgVf3dGgW9CrkC2L0gwNq1ZB5LOLiksMXoO
         Y7AGWYb5WGdU02FcTDzzoFfLeFcl2NckfWC1toOmbJX6qSRw2skUFf566w0Dwk/zNtFz
         0wn6FVM11cTPDz+O6AYwpnCqh3rrvAz4VdWErZD302Azd924/DHju7mzNqbWKFf+3sHr
         ShFHKveMSanWrcnjXcl3AgD1StVfci9rs2W0QtVTpzwp3mc6hw0hD6Wj9k65CERwI6X3
         4jxA==
X-Gm-Message-State: APjAAAWv3JZ2YO2nfMpQ6GPzEogyW1TGMtSM+V+tf8GY0bfYvgelzZoS
        MI96W+iwGwGz807O56s+wgs=
X-Google-Smtp-Source: APXvYqzL+2Y04yOkKtalVlUtycPgO8/i1gUbA2dSLsaEONtKnP6nRDz3qDuKl9EaY2YE+bZHdqN2KA==
X-Received: by 2002:adf:dd05:: with SMTP id a5mr21467583wrm.108.1583141289113;
        Mon, 02 Mar 2020 01:28:09 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m3sm6409586wrx.9.2020.03.02.01.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 01:28:08 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: fix compatible property for rk3399-evb
Date:   Mon,  2 Mar 2020 10:27:59 +0100
Message-Id: <20200302092759.3291-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200302092759.3291-1-jbx6244@gmail.com>
References: <20200302092759.3291-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: /: compatible:
['rockchip,rk3399-evb', 'rockchip,rk3399', 'google,rk3399evb-rev2']
is not valid under any of the given schemas

'google,rk3399evb-rev2' was a no longer used variant for Google.
The binding only mentions 'rockchip,rk3399-evb', 'rockchip,rk3399',
so fix this error by removing 'google,rk3399evb-rev2' from
the compatible property in rk3399-evb.dts and change it into
generic rk3399-evb support only.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 77008dca4..d1afd1e1d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -9,8 +9,7 @@
 
 / {
 	model = "Rockchip RK3399 Evaluation Board";
-	compatible = "rockchip,rk3399-evb", "rockchip,rk3399",
-		     "google,rk3399evb-rev2";
+	compatible = "rockchip,rk3399-evb", "rockchip,rk3399";
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-- 
2.11.0

