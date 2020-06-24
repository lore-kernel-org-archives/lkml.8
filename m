Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AFA206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtZw33dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404376AbgFXPHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404276AbgFXPHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:07:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF57C061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h15so2631361wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kSPgE+bGgsMdGhCfRjJWoo3vTL9/vYYp2AF2KnCRX7A=;
        b=BtZw33dNk6XR2atGnsBkwFUuIxaaSCIFGdnyixfM0UlnYDV3zzT6lb6+aa5UD58UCe
         tElHor7dZl5GsAKmFmBg3dY+AfhyaoGNRDv2IttT/kiYEg0K6OEVNIX2BjsVMyL6D1Vh
         pl74LjR7qUunaQwqNmFvpQ8M5npMEODYp/0U4aA7dzfTv0oXX9GuIPNlYKwdGJulKZNC
         xK911HEq5deWXhRuEJqGaat8+7llFxgHSGLbdqhi18VSQhB6s0rrfYtB0yK78ppQSKlp
         1mdd1eqdW9hbgOZwIWTNEFDWEsKFNNT8+oTEHAvTj92jtOvOonh5b99Z7mXBqFc9znrQ
         7Bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kSPgE+bGgsMdGhCfRjJWoo3vTL9/vYYp2AF2KnCRX7A=;
        b=iB8fvjUGO4xjqTYC9PmIpF6awwX/pxx/uTxziuA2YHutxbvz0Y0/PKs6MnkxBwo6iQ
         M9gOsIQGGGYquBxHi9k36/Bf5FXR8j94k5o/giY6arW45znukHqFd3vUzs5MrVDvERug
         InWui8Nd5iMTPJ6qwDNeTvv9SraJ3JOvPwPC6zUa0Jy4ReMR3jlS6lHS9JpWbUHbMtWF
         jQjtL6log1tc+UaNWE8PL7XfWDFZ+2q+1c7J2rt2ceIjj8Au0njItzcNzWVLs1yque6H
         7mJ3XqwjzIBxRrHq/OXcllF6oJdmkgyP35L265FxE8Y+MRc+6tqLzezCrM0WcVk15bet
         uSbw==
X-Gm-Message-State: AOAM531KIaL9XeQYOWr9M1F6hhYzu95zw/NVR6e6oQ6iBSqSUsNjl8zA
        JidnHmZxBvS9S9C2yYAVDAjmhw==
X-Google-Smtp-Source: ABdhPJxdMcci8lbcX4ZJfwIvm45gJk47ZSdYDBO+zWr066+2R6dxBc4cWi4TqiTyAHdaGplxmjK/Kg==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr17817455wrr.364.1593011243632;
        Wed, 24 Jun 2020 08:07:23 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id h14sm11543361wrt.36.2020.06.24.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:07:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        patches@opensource.cirrus.com
Subject: [PATCH 10/10] mfd: wm831x-core: Supply description wm831x_reg_{un}lock args
Date:   Wed, 24 Jun 2020 16:07:04 +0100
Message-Id: <20200624150704.2729736-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624150704.2729736-1-lee.jones@linaro.org>
References: <20200624150704.2729736-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc syntax is used, but not complete.  Descriptions required.

Prevents warnings like:

 drivers/mfd/wm831x-core.c:119: warning: Function parameter or member 'wm831x' not described in 'wm831x_reg_lock'
 drivers/mfd/wm831x-core.c:145: warning: Function parameter or member 'wm831x' not described in 'wm831x_reg_unlock'

Cc: <stable@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: patches@opensource.cirrus.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/wm831x-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index 02f879b23d9f6..b0344e5353e4f 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -114,6 +114,8 @@ static int wm831x_reg_locked(struct wm831x *wm831x, unsigned short reg)
  * The WM831x has a user key preventing writes to particularly
  * critical registers.  This function locks those registers,
  * allowing writes to them.
+ *
+ * @wm831x: pointer to local driver data structure
  */
 void wm831x_reg_lock(struct wm831x *wm831x)
 {
@@ -140,6 +142,8 @@ EXPORT_SYMBOL_GPL(wm831x_reg_lock);
  * The WM831x has a user key preventing writes to particularly
  * critical registers.  This function locks those registers,
  * preventing spurious writes.
+ *
+ * @wm831x: pointer to local driver data structure
  */
 int wm831x_reg_unlock(struct wm831x *wm831x)
 {
-- 
2.25.1

