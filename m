Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF1DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89EC20767
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd/kZlQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgEPIIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgEPIIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 04:08:22 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96817C061A0C;
        Sat, 16 May 2020 01:08:22 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id v128so4461234oia.7;
        Sat, 16 May 2020 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2Go5PJBGLNL35dW9/nW12LRtHjLfeR0GNx6XNTzagY=;
        b=gd/kZlQykgSo2Yoj7hmLVUzgnCh3a4ZuBeaASI6HdHwFURgVEGOCre9xkQLznmYHg4
         D6Z1rG3K8PqEOj9D78Oki/Pxwd/vhLAkRfFYTABYzA2FEdDdj9PwnHPnW/pE1/E8pckK
         YqZ+y784b9pO3ji6Ut789+WsJrvfbreWVX92uitd1MEx9psYRNv6Q9NJxEMo8a+vcoab
         H3WOV24XnCH3a6ksU1UYdRRijIZe6PXxz9iGiBbXYEsG8HHI5VHhNOQynvI68OlPfhRi
         O8oeofO1kqXpABdN8+ePlBeGvDn66xKh4Oe8o7rjy3sujxqY66mKIdHGVtYD6Ha0wSzh
         bt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2Go5PJBGLNL35dW9/nW12LRtHjLfeR0GNx6XNTzagY=;
        b=GOEzXoFCb+AY2+tzaSpWOGdSCRldLhLAOCIlD1/ZJXxADlGTiKvg8T+lIk+kaa1nA1
         zdhghk3eSFEUCsWXlZqRLrgwmXYSCu+mblk7SZNysioFsprAqrBX/wcQfG6100qykWRf
         WLVuH/OtjhDjZtuVLHOhwafHRDtEXvgPB2Y+SCPDQHC3N5aF2oUoOe1b27CbpMqtxWI0
         g04UYffSJrZ4VJf4FNTtp6WtAor755K+rcdTTR723f6tofWr1CJDUfZC14AogAKr41OB
         kTsjPDU1h++KdjlRiaVr7mKctRnFeOfCdNZj49C2QfxGBgVVydGsa5AR7SjyUCSNK60F
         oauw==
X-Gm-Message-State: AOAM533hGu/T457W3YkBWxwSkD/sVPMXJebhEkfoKh+l3Rgb3RJIY5RH
        HG9+ibOHpfg/Xc0hN924QEs=
X-Google-Smtp-Source: ABdhPJxXp4FpR4igNipixvMQjn1gF5IGHZADBHYxDiXQFbZ0HCYB4Ah2rBJpdW9a5MlPmQvjL2toOw==
X-Received: by 2002:aca:c142:: with SMTP id r63mr4562254oif.84.1589616501578;
        Sat, 16 May 2020 01:08:21 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id n11sm1321064oij.21.2020.05.16.01.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 01:08:21 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 2/2] clk: bcm2835: Remove casting to bcm2835_clk_register
Date:   Sat, 16 May 2020 01:08:07 -0700
Message-Id: <20200516080806.1459784-2-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516080806.1459784-1-natechancellor@gmail.com>
References: <20200516080806.1459784-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four different callback functions that are used for the
clk_register callback that all have different second parameter types.

bcm2835_register_pll -> struct bcm2835_pll_data
bcm2835_register_pll_divider -> struct bcm2835_pll_divider_data
bcm2835_register_clock -> struct bcm2835_clock_data
bcm2835_register_date -> struct bcm2835_gate_data

These callbacks are cast to bcm2835_clk_register so that there is no
error about incompatible pointer types. Unfortunately, this is a control
flow integrity violation, which verifies that the callback function's
types match the prototypes exactly before jumping.

[    0.857913] CFI failure (target: 0xffffff9334a81820):
[    0.857977] WARNING: CPU: 3 PID: 35 at kernel/cfi.c:29 __cfi_check_fail+0x50/0x58
[    0.857985] Modules linked in:
[    0.858007] CPU: 3 PID: 35 Comm: kworker/3:1 Not tainted 4.19.123-v8-01301-gdbb48f16956e4-dirty #1
[    0.858015] Hardware name: Raspberry Pi 3 Model B Rev 1.2 (DT)
[    0.858031] Workqueue: events 0xffffff9334a925c8
[    0.858046] pstate: 60000005 (nZCv daif -PAN -UAO)
[    0.858058] pc : __cfi_check_fail+0x50/0x58
[    0.858070] lr : __cfi_check_fail+0x50/0x58
[    0.858078] sp : ffffff800814ba90
[    0.858086] x29: ffffff800814ba90 x28: 000fffffffdfff3d
[    0.858101] x27: 00000000002000c2 x26: ffffff93355fdb18
[    0.858116] x25: 0000000000000000 x24: ffffff9334a81820
[    0.858131] x23: ffffff93357f3580 x22: ffffff9334af1000
[    0.858146] x21: a79b57e88f8ebc81 x20: ffffff93357f3580
[    0.858161] x19: ffffff9334a81820 x18: fffffff679769070
[    0.858175] x17: 0000000000000000 x16: 0000000000000000
[    0.858190] x15: 0000000000000004 x14: 000000000000003c
[    0.858205] x13: 0000000000003044 x12: 0000000000000000
[    0.858220] x11: b57e91cd641bae00 x10: b57e91cd641bae00
[    0.858235] x9 : b57e91cd641bae00 x8 : b57e91cd641bae00
[    0.858250] x7 : 0000000000000000 x6 : ffffff933591d4e5
[    0.858264] x5 : 0000000000000000 x4 : 0000000000000000
[    0.858279] x3 : ffffff800814b718 x2 : ffffff9334a84818
[    0.858293] x1 : ffffff9334bba66c x0 : 0000000000000029
[    0.858308] Call trace:
[    0.858321]  __cfi_check_fail+0x50/0x58
[    0.858337]  __cfi_check+0x3ab3c/0x4467c
[    0.858351]  bcm2835_clk_probe+0x210/0x2dc
[    0.858369]  platform_drv_probe+0xb0/0xfc
[    0.858380]  really_probe+0x4a0/0x5a8
[    0.858391]  driver_probe_device+0x68/0x104
[    0.858403]  __device_attach_driver+0x100/0x148
[    0.858418]  bus_for_each_drv+0xb0/0x12c
[    0.858431]  __device_attach.llvm.17225159516306086099+0xc0/0x168
[    0.858443]  bus_probe_device+0x44/0xfc
[    0.858455]  deferred_probe_work_func+0xa0/0xe0
[    0.858472]  process_one_work+0x210/0x538
[    0.858485]  worker_thread+0x2e8/0x478
[    0.858500]  kthread+0x154/0x164
[    0.858515]  ret_from_fork+0x10/0x18

To fix this, change the second parameter of all functions void * and use
a local variable with the correct type so that everything works
properly. With this, the only use of bcm2835_clk_register is in struct
bcm2835_clk_desc so we can just remove it and use the type directly.

Fixes: 56eb3a2ed972 ("clk: bcm2835: remove use of BCM2835_CLOCK_COUNT in driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1028
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/clk/bcm/clk-bcm2835.c | 68 +++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 7c845c293af0..0d0eeb3b0dd5 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1296,8 +1296,9 @@ static const struct clk_ops bcm2835_vpu_clock_clk_ops = {
 };
 
 static struct clk_hw *bcm2835_register_pll(struct bcm2835_cprman *cprman,
-					   const struct bcm2835_pll_data *data)
+					   const void *data)
 {
+	const struct bcm2835_pll_data *pll_data = data;
 	struct bcm2835_pll *pll;
 	struct clk_init_data init;
 	int ret;
@@ -1307,7 +1308,7 @@ static struct clk_hw *bcm2835_register_pll(struct bcm2835_cprman *cprman,
 	/* All of the PLLs derive from the external oscillator. */
 	init.parent_names = &cprman->real_parent_names[0];
 	init.num_parents = 1;
-	init.name = data->name;
+	init.name = pll_data->name;
 	init.ops = &bcm2835_pll_clk_ops;
 	init.flags = CLK_IGNORE_UNUSED;
 
@@ -1316,7 +1317,7 @@ static struct clk_hw *bcm2835_register_pll(struct bcm2835_cprman *cprman,
 		return NULL;
 
 	pll->cprman = cprman;
-	pll->data = data;
+	pll->data = pll_data;
 	pll->hw.init = &init;
 
 	ret = devm_clk_hw_register(cprman->dev, &pll->hw);
@@ -1327,35 +1328,36 @@ static struct clk_hw *bcm2835_register_pll(struct bcm2835_cprman *cprman,
 
 static struct clk_hw *
 bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
-			     const struct bcm2835_pll_divider_data *data)
+			     const void *data)
 {
+	const struct bcm2835_pll_divider_data *divider_data = data;
 	struct bcm2835_pll_divider *divider;
 	struct clk_init_data init;
 	const char *divider_name;
 	int ret;
 
-	if (data->fixed_divider != 1) {
+	if (divider_data->fixed_divider != 1) {
 		divider_name = devm_kasprintf(cprman->dev, GFP_KERNEL,
-					      "%s_prediv", data->name);
+					      "%s_prediv", divider_data->name);
 		if (!divider_name)
 			return NULL;
 	} else {
-		divider_name = data->name;
+		divider_name = divider_data->name;
 	}
 
 	memset(&init, 0, sizeof(init));
 
-	init.parent_names = &data->source_pll;
+	init.parent_names = &divider_data->source_pll;
 	init.num_parents = 1;
 	init.name = divider_name;
 	init.ops = &bcm2835_pll_divider_clk_ops;
-	init.flags = data->flags | CLK_IGNORE_UNUSED;
+	init.flags = divider_data->flags | CLK_IGNORE_UNUSED;
 
 	divider = devm_kzalloc(cprman->dev, sizeof(*divider), GFP_KERNEL);
 	if (!divider)
 		return NULL;
 
-	divider->div.reg = cprman->regs + data->a2w_reg;
+	divider->div.reg = cprman->regs + divider_data->a2w_reg;
 	divider->div.shift = A2W_PLL_DIV_SHIFT;
 	divider->div.width = A2W_PLL_DIV_BITS;
 	divider->div.flags = CLK_DIVIDER_MAX_AT_ZERO;
@@ -1364,7 +1366,7 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
 	divider->div.table = NULL;
 
 	divider->cprman = cprman;
-	divider->data = data;
+	divider->data = divider_data;
 
 	ret = devm_clk_hw_register(cprman->dev, &divider->div.hw);
 	if (ret)
@@ -1374,20 +1376,22 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
 	 * PLLH's channels have a fixed divide by 10 afterwards, which
 	 * is what our consumers are actually using.
 	 */
-	if (data->fixed_divider != 1) {
-		return clk_hw_register_fixed_factor(cprman->dev, data->name,
+	if (divider_data->fixed_divider != 1) {
+		return clk_hw_register_fixed_factor(cprman->dev,
+						    divider_data->name,
 						    divider_name,
 						    CLK_SET_RATE_PARENT,
 						    1,
-						    data->fixed_divider);
+						    divider_data->fixed_divider);
 	}
 
 	return &divider->div.hw;
 }
 
 static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
-					  const struct bcm2835_clock_data *data)
+					     const void *data)
 {
+	const struct bcm2835_clock_data *clock_data = data;
 	struct bcm2835_clock *clock;
 	struct clk_init_data init;
 	const char *parents[1 << CM_SRC_BITS];
@@ -1398,8 +1402,8 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	 * Replace our strings referencing parent clocks with the
 	 * actual clock-output-name of the parent.
 	 */
-	for (i = 0; i < data->num_mux_parents; i++) {
-		parents[i] = data->parents[i];
+	for (i = 0; i < clock_data->num_mux_parents; i++) {
+		parents[i] = clock_data->parents[i];
 
 		ret = match_string(cprman_parent_names,
 				   ARRAY_SIZE(cprman_parent_names),
@@ -1410,18 +1414,18 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 
 	memset(&init, 0, sizeof(init));
 	init.parent_names = parents;
-	init.num_parents = data->num_mux_parents;
-	init.name = data->name;
-	init.flags = data->flags | CLK_IGNORE_UNUSED;
+	init.num_parents = clock_data->num_mux_parents;
+	init.name = clock_data->name;
+	init.flags = clock_data->flags | CLK_IGNORE_UNUSED;
 
 	/*
 	 * Pass the CLK_SET_RATE_PARENT flag if we are allowed to propagate
 	 * rate changes on at least of the parents.
 	 */
-	if (data->set_rate_parent)
+	if (clock_data->set_rate_parent)
 		init.flags |= CLK_SET_RATE_PARENT;
 
-	if (data->is_vpu_clock) {
+	if (clock_data->is_vpu_clock) {
 		init.ops = &bcm2835_vpu_clock_clk_ops;
 	} else {
 		init.ops = &bcm2835_clock_clk_ops;
@@ -1430,7 +1434,7 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 		/* If the clock wasn't actually enabled at boot, it's not
 		 * critical.
 		 */
-		if (!(cprman_read(cprman, data->ctl_reg) & CM_ENABLE))
+		if (!(cprman_read(cprman, clock_data->ctl_reg) & CM_ENABLE))
 			init.flags &= ~CLK_IS_CRITICAL;
 	}
 
@@ -1439,7 +1443,7 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 		return NULL;
 
 	clock->cprman = cprman;
-	clock->data = data;
+	clock->data = clock_data;
 	clock->hw.init = &init;
 
 	ret = devm_clk_hw_register(cprman->dev, &clock->hw);
@@ -1449,24 +1453,26 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 }
 
 static struct clk_hw *bcm2835_register_gate(struct bcm2835_cprman *cprman,
-					 const struct bcm2835_gate_data *data)
+					    const void *data)
 {
-	return clk_hw_register_gate(cprman->dev, data->name, data->parent,
+	const struct bcm2835_gate_data *gate_data = data;
+
+	return clk_hw_register_gate(cprman->dev, gate_data->name,
+				    gate_data->parent,
 				    CLK_IGNORE_UNUSED | CLK_SET_RATE_GATE,
-				    cprman->regs + data->ctl_reg,
+				    cprman->regs + gate_data->ctl_reg,
 				    CM_GATE_BIT, 0, &cprman->regs_lock);
 }
 
-typedef struct clk_hw *(*bcm2835_clk_register)(struct bcm2835_cprman *cprman,
-					       const void *data);
 struct bcm2835_clk_desc {
-	bcm2835_clk_register clk_register;
+	struct clk_hw *(*clk_register)(struct bcm2835_cprman *cprman,
+				       const void *data);
 	unsigned int supported;
 	const void *data;
 };
 
 /* assignment helper macros for different clock types */
-#define _REGISTER(f, s, ...) { .clk_register = (bcm2835_clk_register)f, \
+#define _REGISTER(f, s, ...) { .clk_register = f, \
 			       .supported = s,				\
 			       .data = __VA_ARGS__ }
 #define REGISTER_PLL(s, ...)	_REGISTER(&bcm2835_register_pll,	\
-- 
2.26.2

