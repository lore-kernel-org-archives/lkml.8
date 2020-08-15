Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C76C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E952053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcfBisNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgHOWD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgHOVvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:11 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2351DC02B8DE;
        Sat, 15 Aug 2020 04:24:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m22so12532900eje.10;
        Sat, 15 Aug 2020 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vsYRcSKJo5heCkEhByxTesr3qnuVqbFBvI7V/761LSM=;
        b=RcfBisNl6UXEMchW7A5g1HzcineDtMdGJxg8pSBUgnHND0LmggU7y/FoNRZZeVV6LN
         kNoLIXGm2vsaptDdsioIb7Q1olsgv5yc9DZ7ZGWYs84pZGUEaSrkLHHsauzmBWiliNLJ
         80chWYLTncWt/Jn7133ZQq7xz08lJlaVVQg+nbfazl1Bn44rEMsKTlSa9ycZI25VWsv4
         3tKh/FXwvsoemyuyw7up/EWnbpZvXB84YUjxwzz5HccfgU5N+sgEKI25flqUq8EgAKmH
         Ot8Ll9fuLtHmGErjcgq0T57ZyaLQZta4Af5awtIVFZs5UMtVIg5YEQBNcaGl3mzJNPTP
         4uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vsYRcSKJo5heCkEhByxTesr3qnuVqbFBvI7V/761LSM=;
        b=AegSicRr+MwK7FTSe/hOJYPJHoXzsRdHLaeTJlE1BxS6hpDzRKPHYwS/ClRuPuaImY
         XB5oJeJn4j/7OMBEAhWYB+oXJlB5pmJWqVUYONK78w1vq5fjguu6Eu5Gz1Wlkr60LdaR
         je3j7G1Lgnyt2WYvUSZ9Ebf9uxs9Hbkq7Dla7iqGJhvcIaiFPBFu1utZ2FjVPDlnFX5u
         2mUNbFCnXZE+gWa1la53gv8yjoqU6ZSjvfMyiD1K1LorPBeBl76s9eDumSN+5B4QJaln
         t40z4eQMig0BvF0sfSs3QF4Uv5LyZdGT5l4tX+x9YxRN4tlotDExYm4E727bXaFTKUaM
         E4sQ==
X-Gm-Message-State: AOAM533mHRsHzGSh2K4CmO48DD+o27/Lu6/T/tGk8wvbd4Uf7aItzWzw
        mPJA/88nm1FCSsbni4fi5v0=
X-Google-Smtp-Source: ABdhPJyxOEsEOhMyUIA4+Iz32TqEEjVTsSegFwkW+dd6LEVTbpRkB7b+vARNNelBhUeQw25VyZM0Rg==
X-Received: by 2002:a17:906:dd5:: with SMTP id p21mr6862906eji.416.1597490686713;
        Sat, 15 Aug 2020 04:24:46 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g19sm9106505ejz.5.2020.08.15.04.24.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 04:24:46 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        sugar.zhang@rock-chips.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/2] arm64: dts: rockchip: change fallback string rockchip,rk3308-spdif
Date:   Sat, 15 Aug 2020 13:24:37 +0200
Message-Id: <20200815112437.6662-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200815112437.6662-1-jbx6244@gmail.com>
References: <20200815112437.6662-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below shows that the compatible string

"rockchip,rk3308-spdif", "rockchip,rk3328-spdif"

is already in use, but is not added to a document.
The current fallback string "rockchip,rk3328-spdif" points to a data
set enum RK_SPDIF_RK3366 in rockchip_spdif.c that is not used both
in the mainline as in the manufacturer kernel.
(Of the enum only RK_SPDIF_RK3288 is used.)
So if the properties don't change we might as well use the first SoC
in line as fallback string and add the description for rk3308 as:

"rockchip,rk3308-spdif", "rockchip,rk3066-spdif"

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-spdif.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
enum rk_spdif_type {
	RK_SPDIF_RK3066,
	RK_SPDIF_RK3188,
	RK_SPDIF_RK3288,
	RK_SPDIF_RK3366,
};

static const struct of_device_id rk_spdif_match[] = {
	{ .compatible = "rockchip,rk3066-spdif",
	  .data = (void *)RK_SPDIF_RK3066 },
	{ .compatible = "rockchip,rk3188-spdif",
	  .data = (void *)RK_SPDIF_RK3188 },
	{ .compatible = "rockchip,rk3228-spdif",
	  .data = (void *)RK_SPDIF_RK3366 },
	{ .compatible = "rockchip,rk3288-spdif",
	  .data = (void *)RK_SPDIF_RK3288 },
	{ .compatible = "rockchip,rk3328-spdif",
	  .data = (void *)RK_SPDIF_RK3366 },
	{ .compatible = "rockchip,rk3366-spdif",
	  .data = (void *)RK_SPDIF_RK3366 },
	{ .compatible = "rockchip,rk3368-spdif",
	  .data = (void *)RK_SPDIF_RK3366 },
	{ .compatible = "rockchip,rk3399-spdif",
	  .data = (void *)RK_SPDIF_RK3366 },
	{},
};
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index e8b754d41..2560b9877 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -574,7 +574,7 @@
 	};
 
 	spdif_tx: spdif-tx@ff3a0000 {
-		compatible = "rockchip,rk3308-spdif", "rockchip,rk3328-spdif";
+		compatible = "rockchip,rk3308-spdif", "rockchip,rk3066-spdif";
 		reg = <0x0 0xff3a0000 0x0 0x1000>;
 		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_SPDIF_TX>, <&cru HCLK_SPDIFTX>;
-- 
2.11.0

