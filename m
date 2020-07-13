Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B15C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0412075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoRSkBxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgGMOtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgGMOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA72C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so13576941wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDQo0AmW/wRqsDL2beQj5GgZo90S5+xYNYVa82ZvelY=;
        b=GoRSkBxS/tnbpEU8KW8mepOxP/TVgSZbKxeDQfb1oEnG4csHx4qgPKtw1Dpch1UzMu
         6g6z3ry4DE6sORZjwGWlJ1wuPVGeu0GlPBSTfXy2Ikx2dr3U54PkfYnhJnY8jAi1ZE1N
         j+Oeczc9kTqHziWxpVqMo6x/pdMF9PFXB/K6zJh9dQ5CmyyPITOmzo+win3AbA2SmG/A
         rKbhrZ1lpGQwKRiKrKyxkIJmluCboFzEbi02fEDhmuaZQWcQ67BOwHPpTljpSLqQTeq7
         si2L97FkbLl1Q10+xLOD2nS+7mOQeM/04ztAslVRuYKXnSSaoTpulqjXSZhXR4/L93j0
         ZDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDQo0AmW/wRqsDL2beQj5GgZo90S5+xYNYVa82ZvelY=;
        b=ix3sYX5IHC2MLvVt/gMtULVzVqIJFGD9lrxahzufpNRvqhYv/TwXPw+lQFjKvKlBQv
         aJ7hehAWM1HtZO/SM4eIKgTg1iAkNkxhANu0GaYu+EvDWlNkx/nYQ1Hx7KEQZM//pknU
         ujV/NNh4TkqUPLHCWMDZfocvlhpSnZrDH/LGm8U2V+BXSOIij0rXAU5zZ0K77DFmuHnb
         skvNpUE/ZkVTyoVP50mS9LNgOBxNQ5gUX7NlYH9a6H25Tczsw2kYNIcvj+3uMZVtHBYI
         JrrSLTKErITb2Qcxn/owEVADcCvl1tolzMfXMKOldxARPYuXOB3MH3vGkTyc0OsuYd3j
         9h6g==
X-Gm-Message-State: AOAM532r9WXhJQij90knUHG0XE01bcqvWGWwjd9zPs+6v3EJtxLRe4EM
        SMnaSUQwEkzgzBVRiZaLsxL5ww==
X-Google-Smtp-Source: ABdhPJyxjPXyrITvonbGSDpgcAIA2SxE1HKmSbCG/9Vl4N/MI4NmSZ7my4z4TL/3FhV7XwfdjkOjzA==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr329431wma.102.1594651775115;
        Mon, 13 Jul 2020 07:49:35 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 02/25] pinctrl: sirf: pinctrl-atlas7: Fix a bunch of documentation misdemeanours
Date:   Mon, 13 Jul 2020 15:49:07 +0100
Message-Id: <20200713144930.1034632-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From ill formatted kerneldoc, to incomplete *and* incorrect struct headers,
through to formatting issues and missing attribute descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/sirf/pinctrl-atlas7.c:197: warning: Function parameter or member 'id' not described in 'atlas7_pad_config'
 drivers/pinctrl/sirf/pinctrl-atlas7.c:221: warning: Function parameter or member 'func' not described in 'atlas7_pad_status'
 drivers/pinctrl/sirf/pinctrl-atlas7.c:221: warning: Function parameter or member 'pull' not described in 'atlas7_pad_status'
 drivers/pinctrl/sirf/pinctrl-atlas7.c:221: warning: Function parameter or member 'dstr' not described in 'atlas7_pad_status'
 drivers/pinctrl/sirf/pinctrl-atlas7.c:221: warning: Function parameter or member 'reserved' not described in 'atlas7_pad_status'
 drivers/pinctrl/sirf/pinctrl-atlas7.c:359: warning: Cannot understand  * @dev: a pointer back to containing device
 on line 359 - I thought it was a doc line
 drivers/pinctrl/sirf/pinctrl-atlas7.c:4794: warning: Function parameter or member 'pad_type' not described in 'atlas7_pull_info'
 drivers/pinctrl/sirf/pinctrl-atlas7.c:4917: warning: Function parameter or member 'reserved' not described in 'atlas7_ds_info'
 drivers/pinctrl/sirf/pinctrl-atlas7.c:5617: warning: Function parameter or member 'a7gc' not described in 'atlas7_gpio_to_bank'
 drivers/pinctrl/sirf/pinctrl-atlas7.c:5617: warning: Function parameter or member 'gpio' not described in 'atlas7_gpio_to_bank'

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/sirf/pinctrl-atlas7.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index 50df9e0844142..e54a6e3cafd23 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -169,7 +169,7 @@ struct dt_params {
 
 /**
  * struct atlas7_pad_conf - Atlas7 Pad Configuration
- * @id			The ID of this Pad.
+ * @id:			The ID of this Pad.
  * @type:		The type of this Pad.
  * @mux_reg:		The mux register offset.
  *			This register contains the mux.
@@ -210,7 +210,7 @@ struct atlas7_pad_config {
 		.ad_ctrl_bit = adb,				\
 	}
 
-/**
+/*
  * struct atlas7_pad_status - Atlas7 Pad status
  */
 struct atlas7_pad_status {
@@ -355,10 +355,6 @@ struct atlas7_gpio_chip {
 	struct atlas7_gpio_bank banks[];
 };
 
-/**
- * @dev: a pointer back to containing device
- * @virtbase: the offset to the controller in virtual memory
- */
 struct atlas7_pmx {
 	struct device *dev;
 	struct pinctrl_dev *pctl;
@@ -376,7 +372,7 @@ struct atlas7_pmx {
  * refer to A7DA IO Summary - CS-314158-DD-4E.xls
  */
 
-/*Pads in IOC RTC & TOP */
+/* Pads in IOC RTC & TOP */
 static const struct pinctrl_pin_desc atlas7_ioc_pads[] = {
 	/* RTC PADs */
 	PINCTRL_PIN(0, "rtc_gpio_0"),
@@ -4781,10 +4777,10 @@ struct map_data {
 
 /**
  * struct atlas7_pull_info - Atlas7 Pad pull info
- * @type:The type of this Pad.
- * @mask:The mas value of this pin's pull bits.
- * @v2s: The map of pull register value to pull status.
- * @s2v: The map of pull status to pull register value.
+ * @pad_type:	The type of this Pad.
+ * @mask:	The mas value of this pin's pull bits.
+ * @v2s:	The map of pull register value to pull status.
+ * @s2v:	The map of pull status to pull register value.
  */
 struct atlas7_pull_info {
 	u8 pad_type;
@@ -4908,6 +4904,7 @@ static const struct atlas7_ds_ma_info atlas7_ma2ds_map[] = {
  * @type:		The type of this Pad.
  * @mask:		The mask value of this pin's pull bits.
  * @imval:		The immediate value of drives trength register.
+ * @reserved:		Reserved space
  */
 struct atlas7_ds_info {
 	u8 type;
@@ -5609,7 +5606,7 @@ static int __init atlas7_pinmux_init(void)
 arch_initcall(atlas7_pinmux_init);
 
 
-/**
+/*
  * The Following is GPIO Code
  */
 static inline struct
-- 
2.25.1

