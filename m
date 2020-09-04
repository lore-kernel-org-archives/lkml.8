Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7593CC2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4615A2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DHwiLfdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgIDPtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgIDPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:46:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90076C0611E9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l9so6513116wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+YZpX0q+mO37+kQBR4DVC/6zJd6Q2vMMFs8yeO9lM6k=;
        b=DHwiLfdYkiuvwGGyuQJVAWH5TI6urmfg9xYzHsNJZRaq+W2VOEzGuDZHADH8b43f72
         IdWm7NgZqeHyUMOex7xd1L+sKPbyTQU6bkDGKC+laJrmoA7AkcOWL7irwhKLtGgT8Sqf
         F8QMnwZ2j3f3Ev1NBQFKglsSE0ukhsx0DeGQmvPfA7s4XdmrdEBZCJLsDuZdy2py60av
         7ddrLxRGhrc5nQk/J7X0Rd3701tAIqugtMXJWgIrCfExr2MwqBB6KT7fKNh50zVYZgFr
         KhutLsEsf7K3xZSOrPpo6OUVFbEEAZGhgmuf6GDrIPY3Qah5PrJ+GtBed+JpjV2iCFmm
         akIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+YZpX0q+mO37+kQBR4DVC/6zJd6Q2vMMFs8yeO9lM6k=;
        b=mSSJ7fwCjTb1Y+o0wJfsIVT8jjpoACsheRyY2pFFkpTU9dCxKt5dhH8NK7YFl3xSjp
         9fMXwk/gcwHN0yNJksPewAsFHQCpavo32a0r7D4SJyXFFU2LMITNxYWM5fKh4nPNkhUC
         fRpv6/SgJIQrcnnkIUDoIrklCZrTdkfwLZWo9TKBmUVF89IG8Gw3wk20vXe1UOYwcl2S
         JC4jOYH2i3kSoxopafl7LuAuoO2pGffg4OgNU7tYcVWs0mhVCiXLYDAHrNHlkomNdl9D
         sB0dIiFC6xBWJzZqZ6vAiqYxtrwyI/JincXkR99FlFp0J7/gsno+vh+oAksQ74xaKdsz
         Eftg==
X-Gm-Message-State: AOAM531wQaGST6XMymFwTndY7Mcr+kNmcrRBay1o4J6pQ3yh8Of8TY9G
        1b8sDjheUxzKTy5GIVY/1+gMUg==
X-Google-Smtp-Source: ABdhPJxcZNGnXPvX9i5H6bEC8G5YKnDdSyG1Hc0LLO25M6dxNysSMjIVg6JhStAhJl/uVlArUPCUtg==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr7818256wmb.7.1599234403325;
        Fri, 04 Sep 2020 08:46:43 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 10/23] gpio: mockup: fix resource leak in error path
Date:   Fri,  4 Sep 2020 17:45:34 +0200
Message-Id: <20200904154547.3836-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

If the module init function fails after creating the debugs directory,
it's never removed. Add proper cleanup calls to avoid this resource
leak.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 78c97f7b6893..19c092f814fd 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -550,6 +550,7 @@ static int __init gpio_mockup_init(void)
 	err = platform_driver_register(&gpio_mockup_driver);
 	if (err) {
 		pr_err("error registering platform driver\n");
+		debugfs_remove_recursive(gpio_mockup_dbg_dir);
 		return err;
 	}
 
@@ -580,6 +581,7 @@ static int __init gpio_mockup_init(void)
 			pr_err("error registering device");
 			platform_driver_unregister(&gpio_mockup_driver);
 			gpio_mockup_unregister_pdevs();
+			debugfs_remove_recursive(gpio_mockup_dbg_dir);
 			return PTR_ERR(pdev);
 		}
 
-- 
2.26.1

