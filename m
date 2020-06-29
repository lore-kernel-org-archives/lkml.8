Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758D9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4E320672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WstEQ0ZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbgF2Ujl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389573AbgF2UjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:39:14 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DDDC03E97A;
        Mon, 29 Jun 2020 13:39:13 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so7518216edz.12;
        Mon, 29 Jun 2020 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poNQke3TqFavrhIR2KmYnQgYp3/Q4PYYAnL3w2U1Fyc=;
        b=WstEQ0ZCFTe6AVwEY4lQ0ceOrnu4tWq6DDHc9L5hR/w3HA2u8AXMX8aZ+7Cba7Oh2F
         bbCJ5E9AoEAkyaYuRzcInUk6vH/qW/PpdGmIxKvd3iaMRkhGiVdajbDCI2kmej4+YdFl
         3+ts5h5zy/z3kuNWbUtgsp2xXgEwcdXpkYxCMJgXikO3XXcLpjGl0H5bcsN9w3uF96+N
         WfyNJyVsssHdPkeZb75igiOsQKOZv+GP5XtBIxclZcMXqtDl09hF0pd2PFiIR659cFnD
         UMR7/ZfKqxszh+XORN6c7v7EMe+4M80XN0CTATQYpbGrajIZNj4FvUCkBjIaN9RExDi7
         4agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poNQke3TqFavrhIR2KmYnQgYp3/Q4PYYAnL3w2U1Fyc=;
        b=ABN6qCB6lkSGWSXTnTEgZdI7oAlOLtlZO5Q+3PXdTCzqYp1c2FJ3XnP+hQjdsQFyD4
         DqegP0vMTUlOw0BN7pZvPHQ3tKZ1HNuPkeuWb8dEa2ENRa/NxasOLkTkbOR0nlUkcNDm
         d2gAD9CpwtxpA+zuRiJ706czjCfTA2pfyzLVcHe2pT9V26NvlzulJ4a/8SholLVfcKCs
         PSLlHqQgyK5h9HZ22AuqS4kdqnKqZ0Eq8NZBlkmWbmW8ooYbeeS8eeBRlzf+hYYQdRSA
         kevKhl3OJooRuwl5uIRM44Gx30Kh2vsReXZcNRr80KWc4891Vii3BN1x1CPcu6Uy3x+4
         lzpQ==
X-Gm-Message-State: AOAM533HcuZgU+VXEFcuXIW52Nw5cFOfyiF1ufzNO7XWz5waU6Q7Gz2m
        Ps87o0mGgbb+8pZVvrwfqsg=
X-Google-Smtp-Source: ABdhPJylC3E/Pdilit7Sb6j+7EWBbHVVpvb5Q/h2olQFs6bdxsOLf//7n2Nm0rT4KI1L1Mv8lw4Iyg==
X-Received: by 2002:aa7:c407:: with SMTP id j7mr19427153edq.96.1593463152277;
        Mon, 29 Jun 2020 13:39:12 -0700 (PDT)
Received: from localhost.localdomain (p200300f137396800428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3739:6800:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j24sm706741edp.22.2020.06.29.13.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:39:11 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] clk: meson: meson8b: add the vclk_en gate clock
Date:   Mon, 29 Jun 2020 22:39:03 +0200
Message-Id: <20200629203904.2989007-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629203904.2989007-1-martin.blumenstingl@googlemail.com>
References: <20200629203904.2989007-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HHI_VID_CLK_CNTL[19] is documented as CLK_EN0. This description is the
same in the public S912 datasheet and the GXBB driver calls this gate
"vclk". Add this gate clock to the Meson8/Meson8b/Meson8m2 clock
controller because it's needed to make the video output work.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 30 +++++++++++++++++++++++++-----
 drivers/clk/meson/meson8b.h |  3 ++-
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 3d826711c820..d5b90d61a530 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1204,6 +1204,22 @@ static struct clk_regmap meson8b_vclk_in_en = {
 	},
 };
 
+static struct clk_regmap meson8b_vclk_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL,
+		.bit_idx = 19,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&meson8b_vclk_in_en.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static struct clk_regmap meson8b_vclk_div1_gate = {
 	.data = &(struct clk_regmap_gate_data){
 		.offset = HHI_VID_CLK_CNTL,
@@ -1213,7 +1229,7 @@ static struct clk_regmap meson8b_vclk_div1_gate = {
 		.name = "vclk_div1_en",
 		.ops = &clk_regmap_gate_ro_ops,
 		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_vclk_in_en.hw
+			&meson8b_vclk_en.hw
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1227,7 +1243,7 @@ static struct clk_fixed_factor meson8b_vclk_div2_div = {
 		.name = "vclk_div2",
 		.ops = &clk_fixed_factor_ops,
 		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_vclk_in_en.hw
+			&meson8b_vclk_en.hw
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1257,7 +1273,7 @@ static struct clk_fixed_factor meson8b_vclk_div4_div = {
 		.name = "vclk_div4",
 		.ops = &clk_fixed_factor_ops,
 		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_vclk_in_en.hw
+			&meson8b_vclk_en.hw
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1287,7 +1303,7 @@ static struct clk_fixed_factor meson8b_vclk_div6_div = {
 		.name = "vclk_div6",
 		.ops = &clk_fixed_factor_ops,
 		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_vclk_in_en.hw
+			&meson8b_vclk_en.hw
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1317,7 +1333,7 @@ static struct clk_fixed_factor meson8b_vclk_div12_div = {
 		.name = "vclk_div12",
 		.ops = &clk_fixed_factor_ops,
 		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_vclk_in_en.hw
+			&meson8b_vclk_en.hw
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -2820,6 +2836,7 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 		[CLKID_VID_PLL_FINAL_DIV]   = &meson8b_vid_pll_final_div.hw,
 		[CLKID_VCLK_IN_SEL]	    = &meson8b_vclk_in_sel.hw,
 		[CLKID_VCLK_IN_EN]	    = &meson8b_vclk_in_en.hw,
+		[CLKID_VCLK_EN]		    = &meson8b_vclk_en.hw,
 		[CLKID_VCLK_DIV1]	    = &meson8b_vclk_div1_gate.hw,
 		[CLKID_VCLK_DIV2_DIV]	    = &meson8b_vclk_div2_div.hw,
 		[CLKID_VCLK_DIV2]	    = &meson8b_vclk_div2_div_gate.hw,
@@ -3025,6 +3042,7 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_VID_PLL_FINAL_DIV]   = &meson8b_vid_pll_final_div.hw,
 		[CLKID_VCLK_IN_SEL]	    = &meson8b_vclk_in_sel.hw,
 		[CLKID_VCLK_IN_EN]	    = &meson8b_vclk_in_en.hw,
+		[CLKID_VCLK_EN]		    = &meson8b_vclk_en.hw,
 		[CLKID_VCLK_DIV1]	    = &meson8b_vclk_div1_gate.hw,
 		[CLKID_VCLK_DIV2_DIV]	    = &meson8b_vclk_div2_div.hw,
 		[CLKID_VCLK_DIV2]	    = &meson8b_vclk_div2_div_gate.hw,
@@ -3241,6 +3259,7 @@ static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
 		[CLKID_VID_PLL_FINAL_DIV]   = &meson8b_vid_pll_final_div.hw,
 		[CLKID_VCLK_IN_SEL]	    = &meson8b_vclk_in_sel.hw,
 		[CLKID_VCLK_IN_EN]	    = &meson8b_vclk_in_en.hw,
+		[CLKID_VCLK_EN]		    = &meson8b_vclk_en.hw,
 		[CLKID_VCLK_DIV1]	    = &meson8b_vclk_div1_gate.hw,
 		[CLKID_VCLK_DIV2_DIV]	    = &meson8b_vclk_div2_div.hw,
 		[CLKID_VCLK_DIV2]	    = &meson8b_vclk_div2_div_gate.hw,
@@ -3443,6 +3462,7 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_vid_pll_final_div,
 	&meson8b_vclk_in_sel,
 	&meson8b_vclk_in_en,
+	&meson8b_vclk_en,
 	&meson8b_vclk_div1_gate,
 	&meson8b_vclk_div2_div_gate,
 	&meson8b_vclk_div4_div_gate,
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index cd38ae2a9cb5..c8ab2a632295 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -180,8 +180,9 @@
 #define CLKID_CTS_AMCLK_DIV	208
 #define CLKID_CTS_MCLK_I958_SEL	210
 #define CLKID_CTS_MCLK_I958_DIV	211
+#define CLKID_VCLK_EN		214
 
-#define CLK_NR_CLKS		214
+#define CLK_NR_CLKS		215
 
 /*
  * include the CLKID and RESETID that have
-- 
2.27.0

