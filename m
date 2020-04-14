Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807A5C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422E820767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QGvyIyBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505400AbgDNUBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505372AbgDNUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:00:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DBEC03C1A8;
        Tue, 14 Apr 2020 13:00:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a25so15998770wrd.0;
        Tue, 14 Apr 2020 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMEhVF0vYBD5wEL6NVXMDI0N17NccWqgaXC2pKCnVTY=;
        b=QGvyIyBCuE1RTz/U2bQ3ayAHyY5uM3WTq9YDCxbzqblnL6UwourmXshcxDsVSQZtHN
         noCl7QW2a8NgAUiQnZZ9tVNP5WGR7eAa0mSPnM1e8tFW/AjlgrIQkx3AlvlfRu4D3RRA
         IQFkdT5fBmD5Faznxp29nqmCExvK0n4/xk/7/0I/FMIS4d0lKKtIqcAiSitEdSl6zz4b
         toKYQ3bk2IY9FmCs7QgU7XYQgNUhLU3B+hmcKTq9K5zAYbBmX8W67YBo/IGc8NGgc4jB
         CRv5Pubpy5g/WfFMpePTgTqcVwKFNfpQYtqh/FOEhhdF/9WEpt/LZlDwithUp2jy0hEg
         CkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMEhVF0vYBD5wEL6NVXMDI0N17NccWqgaXC2pKCnVTY=;
        b=nG6iD6VZuVIF9G03TEOd7FBwaAHYDja7zULiGOJrxjywmyTsdb2Kh2Yx6zy+bxbbca
         6XmjNjs5HE/hO1RVwC96sC66XqmZDHOrGUQm9xIQIhet4XQcGGZ5Q+8BnzwYnDOWh0bk
         fhfseL+ia5G4hBmK1bhIkTPrzjQrV+KJDf/RWmuMDdWfgZVxv43XwGQJJ9HQBZ8UDz0y
         yDQSoz78m0TlyGUBU1qcj3hyNgU51ujhYCsXL+AXN30JmYh3NRegrj+HU+XvMRE7O+mH
         p20s6FtgjPu0avJrnn6C7Wc+cL1z+9nGSZdY6EKXq0n0haDi/9OsYXAIcghFRxTnvogS
         gq7w==
X-Gm-Message-State: AGi0PuaM28yBBwCD+LzPQ8eGGaiq9DGC759g5+7Vq0VruKv2JBiRUAqT
        HH113BkHN/6hxyXjnSOlroA=
X-Google-Smtp-Source: APiQypIDfgPSiABD+zZrvfyDeW6rwHrqLmm2ir7R3dKYG4NUN9dAEXxs8UO3T2OO4wpxzPEm6gNQ7g==
X-Received: by 2002:a5d:544f:: with SMTP id w15mr27129849wrv.77.1586894430412;
        Tue, 14 Apr 2020 13:00:30 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b4sm15540253wrv.42.2020.04.14.13.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:00:29 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/4] clk: meson: meson8b: Fix the vclk_div{1,2,4,6,12}_en gate bits
Date:   Tue, 14 Apr 2020 22:00:16 +0200
Message-Id: <20200414200017.226136-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414200017.226136-1-martin.blumenstingl@googlemail.com>
References: <20200414200017.226136-1-martin.blumenstingl@googlemail.com>
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
index fa251e45e208..ed4b70c2d4bd 100644
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
2.26.0

