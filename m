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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8125DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8C3206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzvxEX87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgHOVzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgHOVwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:24 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADFC02B8DD;
        Sat, 15 Aug 2020 04:24:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t15so8665249edq.13;
        Sat, 15 Aug 2020 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/pYCqw4FJgQPrWvNgxirZK4mGQC6/Ct9Zlkxybe7NMM=;
        b=BzvxEX870Xh3lvpFQLGjz7Veu4ygb9dXO7nfFMPyo3sDsJRvTHw6edfND4yqselsR6
         URdlfuviGFFbRySestfN8PU7laLrFmG9iH1pfGTSdnXc1buyXBrCXETreK/M9kDopNRL
         WJVCQYEx4kOiyuYGPpSZqor0EFIDiuRi3/MTukfQc2pS2hP1YDgE2bIJtcPaiDIi01jL
         QPqZhDCVHMybZGVVBmfwQHHrGOI0OSwscrfWbmYsyGzHVVMqxiLtSfLKSqGFZsAisfLx
         tTVZWR8KsVBWy7Ia/VM6l+oBsSYy/3YIzmJgrrbDQR/h1yyH9KRorvdwgkPpPE2JDYVL
         C6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/pYCqw4FJgQPrWvNgxirZK4mGQC6/Ct9Zlkxybe7NMM=;
        b=OIffgJTBsjrC1GSboDDtIOVZjK5FD2mzhQxbDp0NlZE5olvh6Tit2kqmRPGd/98u+m
         klHuLeZofv4eEqWxqn0VbfN7jgcuFCp5tokk7GZ4xv7Ezbp4DIbhv/nymZddsnurTDTO
         V+JQG2LCM00sK+MAkUKyHeTxabho6FPTbLMrpIXhkUjZ3XTivBE6Anasq73RT4pl0W7+
         A57npQThcWfWTfF6WnxWRlNSTFuuAokC37CzkuuQ3AeItDwVwI7m9lI3hyTEdv/RJYSA
         1tec1sc6rX0BTI/1ijNXuikEqm1sxVBx8nbs9dZohMUGWGqLAOFSZ9/Py1GibDc+9t1b
         TDiQ==
X-Gm-Message-State: AOAM530rJxbLOoF+KvFb1C30t4U2f6dU8p/CADc6kSGvDJg3caOkfw6h
        Ok7/wEa/eSU71Jf0Ekt4VnQ=
X-Google-Smtp-Source: ABdhPJzNUtJSkcac39yHBPS5OxPmkL38Y++peDytppNuvWlZm5hLmWf+eQB4YO0lfG/9XEr/QYT7Gg==
X-Received: by 2002:a50:fd8d:: with SMTP id o13mr6673800edt.313.1597490685719;
        Sat, 15 Aug 2020 04:24:45 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g19sm9106505ejz.5.2020.08.15.04.24.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 04:24:45 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        sugar.zhang@rock-chips.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/2] ASoC: rockchip-spdif: add description for rk3308
Date:   Sat, 15 Aug 2020 13:24:36 +0200
Message-Id: <20200815112437.6662-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
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
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index c46715265..26e986097 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
             - rockchip,rk3188-spdif
             - rockchip,rk3288-spdif
+            - rockchip,rk3308-spdif
           - const: rockchip,rk3066-spdif
 
   reg:
-- 
2.11.0

