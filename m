Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E98C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7F22075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtQOx7in"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgGMOtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgGMOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D7DC08C5DE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so13592265wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vd2sj2C+/BCAJxR/LaESZDmFFOuWK440rmdqEyE8mPM=;
        b=XtQOx7in9ZZo01xvUwtPb71cD03LuqUg5mjxFCU8fVtsM9wgJaGzymWPTCk6RAAosp
         ESWRw35FOp86sTVMJwxSp+XrILjPVNaKm5eCK2pxO2YBb6xZ9H+ZLaT2vHvITumQzbXA
         e0xswYA716id0G4VTOndgM3E07J1+apu69twfPsO9ideH7JTLI24InIpLwGzS4rOXSku
         iX53kFdsr7ZTu3NI1ma4fddkk7UOmVlsaKTdkRDJvVngDCOaNBReUbBp7Vl1d+PWdMPt
         PhJ6s5Y+oUQR9YgEpQ4OFI9JYtM+nmya6l2zMAY7SOR3HlHAA0h9rqw1J/HhR4buc3eO
         nfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vd2sj2C+/BCAJxR/LaESZDmFFOuWK440rmdqEyE8mPM=;
        b=kXSo4W3YvGN3k1ntaeqZCJaKT81qmzZQFmpfvmgpe93EFzD1ag3Yy6ww/x5akw16lW
         x7ToZAhdnceasn3p+bqAvMIs72hVBzdmwoDZdqWVoWJECjn0hZ2T1QlvB3X8fRhL/Jgo
         KWz8AOojErb6o9UCWkA6WnEtAO8cKEprgRUaZl9arOVTuxLcy/lYPkAzQk1vau1MjpK8
         6nTixDPLEdDjRT51jyVxTEwTnqQltmgXX5yf+8Q1OoQ9LFSn5kpu/nJCqJNOWG4SawoF
         LUMzLX6sl4Ot9ismdf1gQ0ZowwTf3+M9F1OPQ3jO5pEgHjp1L43m/6qhagxm3Q0Bg5yD
         vUEg==
X-Gm-Message-State: AOAM531jyNTOoh6mNeedKFRegBFUuPlk4wE3Ors09oiINyYy2YpUv0M4
        CEtfnNGUgpSy4dwq5FDHPGFaVzx75y4=
X-Google-Smtp-Source: ABdhPJxZi7VY+XJomfZXlPnVlWacGDuJlQRdZkRS5KZ1z4wQpmgQAq+kQ5+pdP3A3wbPRVY3KfuHDg==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr288300wmj.63.1594651785916;
        Mon, 13 Jul 2020 07:49:45 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 12/25] pinctrl: pinmux: Add some missing parameter descriptions
Date:   Mon, 13 Jul 2020 15:49:17 +0100
Message-Id: <20200713144930.1034632-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And rename another which has probably bitrotted.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/pinmux.c:83: warning: Function parameter or member 'pctldev' not described in 'pinmux_can_be_used_for_gpio'
 drivers/pinctrl/pinmux.c:108: warning: Function parameter or member 'pctldev' not described in 'pin_request'
 drivers/pinctrl/pinmux.c:261: warning: Function parameter or member 'gpio' not described in 'pinmux_request_gpio'
 drivers/pinctrl/pinmux.c:751: warning: Function parameter or member 'selector' not described in 'pinmux_generic_get_function'
 drivers/pinctrl/pinmux.c:751: warning: Excess function parameter 'group_selector' description in 'pinmux_generic_get_function'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinmux.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 9503ddf2edc76..bab888fe3f8e3 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -74,6 +74,7 @@ int pinmux_validate_map(const struct pinctrl_map *map, int i)
  * pinmux_can_be_used_for_gpio() - check if a specific pin
  *	is either muxed to a different function or used as gpio.
  *
+ * @pctldev: the associated pin controller device
  * @pin: the pin number in the global pin space
  *
  * Controllers not defined as strict will always return true,
@@ -96,6 +97,7 @@ bool pinmux_can_be_used_for_gpio(struct pinctrl_dev *pctldev, unsigned pin)
 
 /**
  * pin_request() - request a single pin to be muxed in, typically for GPIO
+ * @pctldev: the associated pin controller device
  * @pin: the pin number in the global pin space
  * @owner: a representation of the owner of this pin; typically the device
  *	name that controls its mux function, or the requested GPIO name
@@ -254,6 +256,7 @@ static const char *pin_free(struct pinctrl_dev *pctldev, int pin,
  * @pctldev: pin controller device affected
  * @pin: the pin to mux in for GPIO
  * @range: the applicable GPIO range
+ * @gpio: number of requested GPIO
  */
 int pinmux_request_gpio(struct pinctrl_dev *pctldev,
 			struct pinctrl_gpio_range *range,
@@ -744,7 +747,7 @@ EXPORT_SYMBOL_GPL(pinmux_generic_get_function_groups);
 /**
  * pinmux_generic_get_function() - returns a function based on the number
  * @pctldev: pin controller device
- * @group_selector: function number
+ * @selector: function number
  */
 struct function_desc *pinmux_generic_get_function(struct pinctrl_dev *pctldev,
 						  unsigned int selector)
-- 
2.25.1

