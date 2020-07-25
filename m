Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746DEC433EC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535AD206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scXitFws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGYEVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 00:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGYEVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 00:21:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF78C0619D3;
        Fri, 24 Jul 2020 21:21:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so5593845pls.9;
        Fri, 24 Jul 2020 21:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LIS2X0aqIeHGnO0KXFcWLzbNNrnM6gwk3bHnxhAqVGI=;
        b=scXitFws281//g1SZXUXHejG/x2yuYdvnZrjoydlRDitrEElJsEGgE+6ifIGna1ZYJ
         48vDGzeDqo8UfQWp4XJPaXcBFAdUNq05I/iqXuoRdklvWaCupElIU+uPGCZlQPdMuNPW
         091BG9nPA1e1+dO33cAXV+LwFEAqzK+qTQ6cjyJH/jZFtwcGkvEmEbcS10TKWHdGos6C
         SCNAcf53jTA1VJdI+Qlog47Iiv0vY10B0I/UZ//H1uETMowuLHcVd9uD9bOpHAqxMPZU
         DpSXLJ4vVdkTRK1fdfqc5CZFJBha6INNefewRVW5pSTzUIsuDNT4h2lJcB8d7fJ1ruCN
         6BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LIS2X0aqIeHGnO0KXFcWLzbNNrnM6gwk3bHnxhAqVGI=;
        b=VgIxuSMoaZQUrHLx/vN2JQhxnjQxQdmATZjxMwzyzH4EwblkQ8A4Lj7kziJk5Q79QO
         crCIPUELeGeUCD/Xg4yiGGOZ8+Hh+laVAbTET212Tc+573dOCN/BgJYw8QcS+yPPU65n
         8caHiyZQ8jyd66DTMS+bX71bZFVoKWC4graAePkDaJ2yaWLJ2Cosc/IuxQefHpqoedAc
         uulMOL1bspu0GUyQBMpG/rJSj/1cG/YBwQ6KwvEeetCvpA6fPTRccja8UHpMBkscCps5
         iQOT0rV362rYkk76Kh5j0zcCcRUSN2g3XBmdTTsxw5guIWGi+QjYyT5jlEwDWQXS6hGJ
         B2ZA==
X-Gm-Message-State: AOAM530a14W+rwrLrpzThUFz+M4SXOyoHo36aKXkHosrrQBep2KM7jTo
        hU8COiEJXfJM4oCaaSxJ/KftuAZF
X-Google-Smtp-Source: ABdhPJzBoAKzFgedYSuvLcRgO+bkoQ7nfLRQ4B/S9ch3swGFAQcBjshR9wRoxcGGE0+LtCeevShzKw==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr10736355plr.246.1595650877491;
        Fri, 24 Jul 2020 21:21:17 -0700 (PDT)
Received: from sol.lan (106-69-185-93.dyn.iinet.net.au. [106.69.185.93])
        by smtp.gmail.com with ESMTPSA id p1sm885320pjp.10.2020.07.24.21.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 21:21:16 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 04/18] gpiolib: add build option for CDEV v1 ABI
Date:   Sat, 25 Jul 2020 12:19:41 +0800
Message-Id: <20200725041955.9985-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200725041955.9985-1-warthog618@gmail.com>
References: <20200725041955.9985-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a build option to allow the removal of the CDEV v1 ABI.

Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Kent Gibson <warthog618@gmail.com>
---

This patch is before the V2 implementation, and is non-functional until
that patch, as some parts of that patch would be written slightly
differently if removing V1 was not considered.
Adding this patch after that would necessitate revisiting the V2 changes,
so this ordering results in two simpler patches.

 drivers/gpio/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b5bb9efc1092..d9775998a997 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -81,6 +81,18 @@ config GPIO_CDEV
 
 	  If unsure, say Y.
 
+config GPIO_CDEV_V1
+	bool "Support GPIO ABI Version 1"
+	default y
+	depends on GPIO_CDEV
+	help
+	  Say Y here to support version 1 of the GPIO CDEV ABI.
+
+	  This ABI version is deprecated and will be removed in the future.
+	  Please use the latest ABI for new developments.
+
+	  If unsure, say Y.
+
 config GPIO_GENERIC
 	depends on HAS_IOMEM # Only for IOMEM drivers
 	tristate
-- 
2.27.0

