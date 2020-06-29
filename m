Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05FCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BB3206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk2ZKv/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbgF2T5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387620AbgF2T5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:57:32 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8850C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:57:31 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y13so9872686lfe.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXip5KwBZ4zG01jb8JoG5vDVesbu67fX4v/5SOWVsj4=;
        b=Lk2ZKv/8twm874ckZSIpONTn1wKHEBB2f/Q7LqsydREQ3t324cgr3ti8w4T35d2hqD
         stZeidGIKh7SFUlqSamSyI6bumqDuxvRhUR/GR3Ou4bbFVuEKvej60UDCiABSrNj82xS
         s6q8oULU2pm6FzX20VTkivj1emLaZoqjdOjg8gxUcikDWxMNQImO70ppQ/w+2wxP3prx
         aiBSTMMtSaQEiqS8jQd4JObvXwALmYxrLk/nwQ+Hh9mGPARJJ608+xOH3oGkSmpqrEJq
         OrnDXyWTDQkYZng/JBYDEqMgjpsOhJ8KHg6KdSVfVBlfaQJpYtsMdL69J6B9ytpAT0Te
         IsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXip5KwBZ4zG01jb8JoG5vDVesbu67fX4v/5SOWVsj4=;
        b=YcnjDtExLtssHgw8cQBma05JJt8vLgG7WJFH7NrrvTvIR8OaDlOtMot44yaRHTameg
         M4peexT3855H9ivK+URQ1Mz9Nx8FgLgYWY61Fw7onmeeHSx5jxilAWldRZw2gwA0R2YX
         qHKFnHXekPVHaxrmh9SLGxWuwLngff/SivSHW+wNUwNEwV2C0HG2Z9Oqipv7h6ffrJXU
         GYw6IN3x3QhrK7stoDEjBCEEL54NJpJS2xVLCtdtm9eitrvJ7ICzt9D8JE8tX7YlM0dc
         zcuw4azleT6djS5fZSlYsGnUd1JuVr0tWVko8VGnrA12NLWnPlcXvO/AjV6o64aGr5tL
         tN+Q==
X-Gm-Message-State: AOAM530V7J89LkGURqp8BiXKqwNHuy8aH2UlnX8kTa2vL+sbunZpXKbe
        7xlgIeKZFXEDnuFNGozqBfY=
X-Google-Smtp-Source: ABdhPJzyjzo4qb7j6DhvyjzqhExSDy157w8OBaZ64xKDwkrn8HkXTU6LDyhB2G94yoljtX3cTlmO2g==
X-Received: by 2002:a05:6512:31c5:: with SMTP id j5mr10255219lfe.26.1593460650455;
        Mon, 29 Jun 2020 12:57:30 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-147.NA.cust.bahnhof.se. [98.128.228.147])
        by smtp.gmail.com with ESMTPSA id y26sm166482ljk.26.2020.06.29.12.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 12:57:29 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     kishon@ti.com, vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] phy: allwinner: phy-sun6i-mipi-dphy: Constify structs
Date:   Mon, 29 Jun 2020 21:57:27 +0200
Message-Id: <20200629195727.9717-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sun6i_dphy_ops and sun6i_dphy_regmap_config are not modified so make them
const structs to allow the compiler to put them in read-only memory.

Before:
   text    data     bss     dec     hex filename
   4407    1944      64    6415    190f drivers/phy/allwinner/phy-sun6i-mipi-dphy.o

After:
   text    data     bss     dec     hex filename
   4835    1496      64    6395    18fb drivers/phy/allwinner/phy-sun6i-mipi-dphy.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 79c8af5c7c1d..1fa761ba6cbb 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -233,7 +233,7 @@ static int sun6i_dphy_exit(struct phy *phy)
 }
 
 
-static struct phy_ops sun6i_dphy_ops = {
+static const struct phy_ops sun6i_dphy_ops = {
 	.configure	= sun6i_dphy_configure,
 	.power_on	= sun6i_dphy_power_on,
 	.power_off	= sun6i_dphy_power_off,
@@ -241,7 +241,7 @@ static struct phy_ops sun6i_dphy_ops = {
 	.exit		= sun6i_dphy_exit,
 };
 
-static struct regmap_config sun6i_dphy_regmap_config = {
+static const struct regmap_config sun6i_dphy_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-- 
2.27.0

