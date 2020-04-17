Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8404FC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671D820780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qn2RXZm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgDQSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729029AbgDQSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:41:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FE1C061A0F;
        Fri, 17 Apr 2020 11:41:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so4058408wml.2;
        Fri, 17 Apr 2020 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIYf6yLD6cGcNKPjnKZPwHWTMLSS0PgTGD6+kLZWz24=;
        b=qn2RXZm7CQEK2b7CVa5xl9uSvLy65ZGWZ0dZZyISbrsJb0LQXt9eCD5+2BKd5jWT68
         VCDk+2Q/hdoCN14v015Es9d2FxTKYVxbwNVCpE/Qq+Gi/PdgvV+E2s4jGLDOLZFZvmD6
         Y86H7Ly/R5lc8w1vv95JqOXTMV0Z68GhtE14x2IL9owKM9Fbki6GTH3M/aS69WUB9in7
         Yl/Elgwq0qrwv+nOpwN9fZIB3ZQJ6+egCW1+yuD+qCod6igLfPrTHd8OR2aRCiFZGzgU
         lXuZDJCZ5/VBQMHUj2vxUKZLeXkEdTPvjLR3L3gTzks39bsVsBlhOVZzvhH6vPVoWT+s
         uh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIYf6yLD6cGcNKPjnKZPwHWTMLSS0PgTGD6+kLZWz24=;
        b=nDNPE/IVcWXF4pBm/G0tCYb0dMP8uwWtTneNAlJ7Yf7cS3nPLSCLlZddPYCR+ZbCnv
         NJ+3x+V0rBE04yqqIj8d3f84KqdyuyW2TWAYFLJMWOHKIi2+HDOYX8eZucFgnFjjqM+/
         luOI0O4uPrPksVtHEnfXxVE9LEQorVbC6UtOCv60pl/KoyiHy1W0FkN44MBqvQckD/4+
         P73V6va6s8ySu559evJnrKJA0da1Ya/UVbUZIntWRUozI60qs/viaFl8Bi6mHX8ELoUu
         AjMLPo7jmxFeN+388g7eL/KtBG2vwx0uxKN74WA1ku+7LQWtF7fYZVgTFaEcEMZxuA9A
         tfqA==
X-Gm-Message-State: AGi0PuaqsKq7Ue9Aspp2Kt1axYvrNilvI87/9mrtwduF047Ch3uUpuN9
        zo5R0GN67qlKvvFHyDP41mw=
X-Google-Smtp-Source: APiQypJiOSadIsSFqxeGifhueVFxB5KQwrbt+IM4+8elJn17pL0qORQex4+o6XKw8z/L7S4uNIk+Cw==
X-Received: by 2002:a1c:98c2:: with SMTP id a185mr4892260wme.85.1587148902117;
        Fri, 17 Apr 2020 11:41:42 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c17sm33237391wrp.28.2020.04.17.11.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 11:41:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/4] clk: meson: meson8b: Fix the vclk_div{1,2,4,6,12}_en gate bits
Date:   Fri, 17 Apr 2020 20:41:26 +0200
Message-Id: <20200417184127.1319871-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
References: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DIV{1,2,4,6,12}_EN bits are actually located in HHI_VID_CLK_CNTL
register:
- HHI_VID_CLK_CNTL[0] = DIV1_EN
- HHI_VID_CLK_CNTL[1] = DIV2_EN
- HHI_VID_CLK_CNTL[2] = DIV4_EN
- HHI_VID_CLK_CNTL[3] = DIV6_EN
- HHI_VID_CLK_CNTL[4] = DIV12_EN

Update the bits accordingly so we will enable the bits in the correct
register once we switch these clocks to be mutable.

Fixes: 6cb57c678bb70e ("clk: meson: meson8b: add the read-only video clock trees")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 1dec8d5404a1..6d1727e62b55 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1213,7 +1213,7 @@ static struct clk_regmap meson8b_vclk_in_en = {
 
 static struct clk_regmap meson8b_vclk_div1_gate = {
 	.data = &(struct clk_regmap_gate_data){
-		.offset = HHI_VID_CLK_DIV,
+		.offset = HHI_VID_CLK_CNTL,
 		.bit_idx = 0,
 	},
 	.hw.init = &(struct clk_init_data){
@@ -1243,7 +1243,7 @@ static struct clk_fixed_factor meson8b_vclk_div2_div = {
 
 static struct clk_regmap meson8b_vclk_div2_div_gate = {
 	.data = &(struct clk_regmap_gate_data){
-		.offset = HHI_VID_CLK_DIV,
+		.offset = HHI_VID_CLK_CNTL,
 		.bit_idx = 1,
 	},
 	.hw.init = &(struct clk_init_data){
@@ -1273,7 +1273,7 @@ static struct clk_fixed_factor meson8b_vclk_div4_div = {
 
 static struct clk_regmap meson8b_vclk_div4_div_gate = {
 	.data = &(struct clk_regmap_gate_data){
-		.offset = HHI_VID_CLK_DIV,
+		.offset = HHI_VID_CLK_CNTL,
 		.bit_idx = 2,
 	},
 	.hw.init = &(struct clk_init_data){
@@ -1303,7 +1303,7 @@ static struct clk_fixed_factor meson8b_vclk_div6_div = {
 
 static struct clk_regmap meson8b_vclk_div6_div_gate = {
 	.data = &(struct clk_regmap_gate_data){
-		.offset = HHI_VID_CLK_DIV,
+		.offset = HHI_VID_CLK_CNTL,
 		.bit_idx = 3,
 	},
 	.hw.init = &(struct clk_init_data){
@@ -1333,7 +1333,7 @@ static struct clk_fixed_factor meson8b_vclk_div12_div = {
 
 static struct clk_regmap meson8b_vclk_div12_div_gate = {
 	.data = &(struct clk_regmap_gate_data){
-		.offset = HHI_VID_CLK_DIV,
+		.offset = HHI_VID_CLK_CNTL,
 		.bit_idx = 4,
 	},
 	.hw.init = &(struct clk_init_data){
-- 
2.26.1

