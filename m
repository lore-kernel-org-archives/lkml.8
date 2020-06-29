Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C9EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59FD2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ml6IcAS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404092AbgF2Vpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgF2Shm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E089CC00F836
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:48:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so16424980wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FwP8JJPtcWzsdQkUuHadbU0oZNWmZu/tGYbst3cTQzw=;
        b=ml6IcAS0tlGAbS5Yi35OokE45RxF0PlZ3JGt98gnPLKHcCqHbUXqmS9PdkMcW8MEeD
         nAdpEJRjuEjU33LDGSs8mOeNqej9cQUUwV1oCjYWIHXAYFjc4hoa+NFfqLh2BrXsxGwU
         Aey8Ph72mumwG5PBRJkqa4N/anKJnrLqbygS9IIuId3q0EAMBtuaQiQXgQyF6j0tM5NJ
         JtVTP07i2EIYkDv2ZhkHbxs0BLIMjYw+V1AyJY+Fvv4337ZFXkSSEqBTG0yBYsjHR1+N
         KQfzuVk2r5gIZPDsYhj0V7yJQ2QsN/K2PUwgfx987ITORglch9ODjqGaZTYGtKkfKysx
         VoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwP8JJPtcWzsdQkUuHadbU0oZNWmZu/tGYbst3cTQzw=;
        b=a38cbfIyYWigE6geVJfMELlCIcyK/2cv+DDwUk4BRoaXpgSAzr0HGFsmBi/zItnnzd
         XF0TfvH2VCE/YD8lyNpNQ90bqU1/Z4JN6l1vn3BRmm3v3ZX3b6voE12a7HZ8ZmvNxVyX
         2ExFaIBihrr90f8GLU1khRDubUVXZJCsxiy9qWRGkJeqhfUWNMow5a9SW8hxiw1RB6Nm
         wMo9JddRx16h5ABekhMTu8UYFhKJ8PKgp8CBl0m/AbIe0+X6Mi/GlaG82eUiS/gxV5cG
         deHdXAMYFq+X4ol+f8sXX+kMkzocrivz/5BwvQLmzVGUFdbBpkoamlSUkLukoOU+AD18
         CuMw==
X-Gm-Message-State: AOAM533vnGArLsP9fsnfMjpx3QAi1LCh64nMt3I2IUqIf7/W7fej/0+v
        qoEoCHXrnAHOoeMm6gzP3JXBRg==
X-Google-Smtp-Source: ABdhPJyQbkunaPWZht+ebwYU90pHFsz7tFovsxHwg6ZqsdgLm+mjM/1dJO07LLGXW+vHYNN8S/XRew==
X-Received: by 2002:adf:f350:: with SMTP id e16mr16440164wrp.43.1593434879632;
        Mon, 29 Jun 2020 05:47:59 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id e17sm12995924wrr.88.2020.06.29.05.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:47:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Joachim Eastwood <manabian@gmail.com>,
        NeilBrown <neilb@suse.de>, Grant Erickson <marathon96@gmail.com>
Subject: [PATCH 4/4] pwm: omap-dmtimer: Repair pwm_omap_dmtimer_chip's broken kerneldoc header
Date:   Mon, 29 Jun 2020 13:47:52 +0100
Message-Id: <20200629124752.1018358-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629124752.1018358-1-lee.jones@linaro.org>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argument descriptions must be prepended with a '@' to be understood
by the kerneldoc tooling/parsers/validators.

Fixes the following W=1 warning:

  drivers/pwm/pwm-omap-dmtimer.c:70: warning: Function parameter or member 'dm_timer_pdev' not described in 'pwm_omap_dmtimer_chip'

Cc: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: NeilBrown <neilb@suse.de>
Cc: Grant Erickson <marathon96@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 0d31833db2e2c..75cea7f2aff5e 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -58,7 +58,7 @@
  * @mutex:		Mutex to protect pwm apply state
  * @dm_timer:		Pointer to omap dm timer.
  * @pdata:		Pointer to omap dm timer ops.
- * dm_timer_pdev:	Pointer to omap dm timer platform device
+ * @dm_timer_pdev:	Pointer to omap dm timer platform device
  */
 struct pwm_omap_dmtimer_chip {
 	struct pwm_chip chip;
-- 
2.25.1

