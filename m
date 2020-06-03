Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D1DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59DFB206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UdAJsijg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFCWk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgFCWk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:40:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EDFC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 15:40:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so2620642pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hfaVvEQXRU/NfnUqDeckNY3kMdmo4vte9DRkgTctMdo=;
        b=UdAJsijgBYMmdkz/7ucDwbwRbxZgfxsqQeUrLPgPU9MMs6qdFWwb5qCTrzjX7gF4dD
         ew8YtyGD6+F/DbF6a+ze43Yyx1EFIO+G/fGfLeqpxgvBiSmOC0rzFfJGgG6K86hksFpu
         2BEhkippRVb6I/7ddm/m7cFNBNjXhNC0KSnNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hfaVvEQXRU/NfnUqDeckNY3kMdmo4vte9DRkgTctMdo=;
        b=s2oApbvMokUoYbhmTUx4DghBH2AEwvKXSssEzhrbzSmT7stS6p9EH8oMZr36U6SEDa
         kNllaveigWqPBXv1W5bA29C5vQkV9NFB5H5/DI4LG0iM2HQ9tP9io9KLElYHLuOHmrn4
         s93RgS3uyPRQHnDDIqL6cOnjQlkmXViuU1sFwR/avXUwT9C/emfOANyfLS1roUj00rQn
         3wo1XR/I64rHa+xGbvoTrQttl4VPbeOHY/wbEqo7iavAGkvMkqnwZ0zGawYZpp2jB5vQ
         qT9RcvkuUaxKU0vbGZtvvlMi/KNr/JC/ezSd1dAGoQVVxQWRb94Esa/+N8yecUb9C3Cp
         ClRg==
X-Gm-Message-State: AOAM532r+kvdCqHEKjrGpMjP7MkR5HSDaxp8SnGRV4RCuiPh2LASjzFb
        4Cc6dMYrb7fdHN8h/ChREEwONQ==
X-Google-Smtp-Source: ABdhPJxySiM/Q8GchHlVngN81CEaDSJz0PjV6xqWSV7FrESFXDuOH11mdHLy95tXYyWivV5urxGGvw==
X-Received: by 2002:a05:6a00:1510:: with SMTP id q16mr1242439pfu.164.1591224057921;
        Wed, 03 Jun 2020 15:40:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p30sm2204424pgn.58.2020.06.03.15.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 15:40:57 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:40:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Add missing "CONFIG_" prefix
Message-ID: <202006031539.4198EA6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IS_ENABLED() use was missing the CONFIG_ prefix which would have
lead to skipping this code.

Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9973c442b455..6b3cbc0490c6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
 		trace_pwm_get(pwm, &pwm->state);
 
-		if (IS_ENABLED(PWM_DEBUG))
+		if (IS_ENABLED(CONFIG_PWM_DEBUG))
 			pwm->last = pwm->state;
 	}
 
-- 
2.25.1


-- 
Kees Cook
