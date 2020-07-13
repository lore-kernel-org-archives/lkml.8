Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2BDC4345F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3192075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMhz0RnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgGMOus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgGMOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111CBC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so13445225wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIoZqzG9OLATQhyya2bqPTWvpUfxkuQVsRzQ1VQbwNE=;
        b=bMhz0RnA/3UZT7hU8Hmuz9lWKmBNqOVSGmyPyWBVANYCkg2p3Qyae9xDS5WenLUiDn
         8274PaEDUnifNdF6+9oklXnQalIg2pJ6Fk5ai0o+Y+Ew+yTjOWjE1X+Ei23ZlU2CHsL0
         EbYezapMR7f7I2JL81ySs9dkcV0rOcs/En3fnXmguJWpkm70yjei7Ov9UjIcU3vrG0Jv
         DFM0KS7YMJ+YUln5WmOprK0AsPpXluFIQCZrP2z4Vj91ZKfyJxhp+UEM3dcWQKgNBHpN
         RsC2xNZZjHKYyFujhG/0BS2rifc9dxAlOy7fnksfbL4qUJdKbZvo75qOhwr+CvW3q8/R
         M7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIoZqzG9OLATQhyya2bqPTWvpUfxkuQVsRzQ1VQbwNE=;
        b=iIAxgwD9JVNlfpcF26h+J3SLF72EpuxUfcvW/x/1RniSxfq5+/MEV9ykCLLphVU+SF
         NvYBlIA9LWKjovEk1pXvLEaPWmLw+WrX+rhfm4jKMokj1MMhjRc45rfVzRkROxUkdnec
         uJ++ND/et7MWe0T7Yy+7cnG2kdbe4l1SlsD9i8ib2tNtP0ko1loBjs7UulxWcafHgqhW
         cSVoWU344E0MkW0GWPHjS/YFDWx3p9fNaX/NveHNs+a9dm+HLhPdQf6oq+VJtlMqolmT
         lyvk015/xCBNmtVW6Zo93+8gGd3sqssKpxZnu2CTEo3yXLuHYSuNwu6I89Swo0dD6ibY
         7I7A==
X-Gm-Message-State: AOAM531YG+xgAUBYFmBi8m7tgvKeDOSe1pp/A4rtv/kok4/852y4e6+d
        Jj1hjC+55Zve+m69eiulc+eJNQ==
X-Google-Smtp-Source: ABdhPJxGvxtVyqe4voNXc32U+fuwwbPkvPKZ54NNIT7BqjecwQyJAfoVDmOAL7IsUckuXU9N3xD+vw==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr294500wmg.27.1594651784746;
        Mon, 13 Jul 2020 07:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 11/25] pinctrl: core: Fix a bunch of kerneldoc issues
Date:   Mon, 13 Jul 2020 15:49:16 +0100
Message-Id: <20200713144930.1034632-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most are likely due to bitrot/API slip.  Some are formatting issues.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/core.c:167: warning: Function parameter or member 'pin' not described in 'pin_get_name'
 drivers/pinctrl/core.c:167: warning: Excess function parameter 'name' description in 'pin_get_name'
 drivers/pinctrl/core.c:584: warning: Function parameter or member 'selector' not described in 'pinctrl_generic_get_group'
 drivers/pinctrl/core.c:584: warning: Excess function parameter 'gselector' description in 'pinctrl_generic_get_group'
 drivers/pinctrl/core.c:1356: error: Cannot parse struct or union!
 drivers/pinctrl/core.c:1458: warning: Function parameter or member 'map' not described in 'pinctrl_unregister_mappings'
 drivers/pinctrl/core.c:1458: warning: Excess function parameter 'maps' description in 'pinctrl_unregister_mappings'
 drivers/pinctrl/core.c:2239: warning: Function parameter or member 'pctldev' not described in 'devm_pinctrl_register_and_init'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 821242bb4b16a..3e8d1630d29ed 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -161,7 +161,7 @@ int pin_get_from_name(struct pinctrl_dev *pctldev, const char *name)
 /**
  * pin_get_name_from_id() - look up a pin name from a pin id
  * @pctldev: the pin control device to lookup the pin on
- * @name: the name of the pin to look up
+ * @pin: pin number/id to look up
  */
 const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned pin)
 {
@@ -577,7 +577,7 @@ EXPORT_SYMBOL_GPL(pinctrl_generic_get_group_pins);
 /**
  * pinctrl_generic_get_group() - returns a pin group based on the number
  * @pctldev: pin controller device
- * @gselector: group number
+ * @selector: group number
  */
 struct group_desc *pinctrl_generic_get_group(struct pinctrl_dev *pctldev,
 					     unsigned int selector)
@@ -1329,7 +1329,7 @@ static void devm_pinctrl_release(struct device *dev, void *res)
 }
 
 /**
- * struct devm_pinctrl_get() - Resource managed pinctrl_get()
+ * devm_pinctrl_get() - Resource managed pinctrl_get()
  * @dev: the device to obtain the handle for
  *
  * If there is a need to explicitly destroy the returned struct pinctrl,
@@ -1451,7 +1451,7 @@ EXPORT_SYMBOL_GPL(pinctrl_register_mappings);
 
 /**
  * pinctrl_unregister_mappings() - unregister a set of pin controller mappings
- * @maps: the pincontrol mappings table passed to pinctrl_register_mappings()
+ * @map: the pincontrol mappings table passed to pinctrl_register_mappings()
  *	when registering the mappings.
  */
 void pinctrl_unregister_mappings(const struct pinctrl_map *map)
@@ -2226,9 +2226,9 @@ EXPORT_SYMBOL_GPL(devm_pinctrl_register);
  * @dev: parent device for this pin controller
  * @pctldesc: descriptor for this pin controller
  * @driver_data: private pin controller data for this pin controller
+ * @pctldev: pin controller device
  *
- * Returns an error pointer if pincontrol register failed. Otherwise
- * it returns valid pinctrl handle.
+ * Returns zero on success or an error number on failure.
  *
  * The pinctrl device will be automatically released when the device is unbound.
  */
-- 
2.25.1

