Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E436C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233202075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="To85ij9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403979AbgE1O7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403835AbgE1O7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:59:24 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3072BC08C5C6;
        Thu, 28 May 2020 07:59:24 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 31F5C22FB3;
        Thu, 28 May 2020 16:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1590677961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZx0PwOCufBuSsd/KLo/gEta6eJr5Qra8yYCyBHbCHE=;
        b=To85ij9TkiKLY12JXWjsQp9K1Xk1lQ5XjdOjMNl/8NV5WIgVs+Vg/Vd3LOpHTAgxxa4Q4W
        SMnGbXWK38tn8df1Xb/DiCvM8bHVq/ynVr/akBZ4tDATTRMaG7KLLExQPwN7vis266moXl
        Jp1fjrw6yLc3FE2gmrsqiDpIL/SbbEU=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v6 3/3] MAINTAINERS: Add gpio regmap section
Date:   Thu, 28 May 2020 16:58:45 +0200
Message-Id: <20200528145845.31436-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200528145845.31436-1-michael@walle.cc>
References: <20200528145845.31436-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a reviewer for the gpio regmap.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a003f310574..f3458debb0c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7340,6 +7340,12 @@ S:	Maintained
 F:	drivers/gpio/gpio-mockup.c
 F:	tools/testing/selftests/gpio/
 
+GPIO REGMAP
+R:	Michael Walle <michael@walle.cc>
+S:	Maintained
+F:	drivers/gpio/gpio-regmap.c
+F:	include/linux/gpio/regmap.h
+
 GPIO SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
 M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
-- 
2.20.1

