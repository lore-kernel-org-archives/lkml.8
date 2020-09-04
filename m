Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB323C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB2E20770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZEDEcIxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgIDPrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgIDPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:46:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5900C061246
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so7242069wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21luy6X7MDo33702JiSjX8+ptN78cMUdDvCAknmXlNw=;
        b=ZEDEcIxOclm9rkbYpejxrNIf2E5BaNtltbEx7kL2MmvTjXkaO6NcxogFQaPWUTVU90
         RQCLCwd/0LeBvBHib8CSLZ6t0N3QMb9pIjEGew+/3FUx7nmAv9U1jw1QGsifrgj7RZz/
         BvxCb7fT6vR8yVfjeZ1cK4bgxVds+FqqAq0SqwC1YeYbevfwSlBCI23wJCoMB61VVWI+
         OMMY4pKIa6QlNrAheHEoiU+ozpVA1RJj07hzk4oeA+31wZzEmN0aoQgAip9RFc0XjC7l
         wZbRPvzHN5/YFjUV8Y9Q9UX0mrRaDx5MfQwrYwVOKbAIytZjQyAsHR3o/g0JEjUNHJNG
         x79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21luy6X7MDo33702JiSjX8+ptN78cMUdDvCAknmXlNw=;
        b=Gr2w/j0BWfkNW546Gk/0Q6RhlTkX9VW4LMa7RJp85PeCHtIhaHH5ZxndhrAyNmlB06
         5g7rnoBJO6Z5I4C3qSlKNwBn5LH/qgTuwS90cJlWbq3LOCgdzQ0/63B300QYZ694phka
         jC3X64BGKgZn0sAeVgbJRPhyXWKBN4rgWnmSxe/0oGko85klua8GcET/rXCUtCxAVIyM
         03oXq6iXG3BgDZKrBgEY7SrbqBSOhQ6ZaCvqWxpIoLAmIdQi3Qny1ePzI06tSRwwX5mj
         Ho4IJYTFXcgeaKLhK+DQV9cAFBbrRO5Br3boT+x3Jdl81d/1JTlarcf2QqMw5VVhDOzC
         jUeA==
X-Gm-Message-State: AOAM532oRCvGFXU3bFDeOTVPacGvpym97XRp2VQjmyL7wdeEtiYx4hZK
        7hI62OvJ+olZZfR1u4OGgGwOVQ==
X-Google-Smtp-Source: ABdhPJwCyK6EASQNgZuAXwqjHkJs+DAdmBTT0auSRhh6ETOzmG9L8g4BM5hkjVixy9irlGFHNaRE7A==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr8773344wrn.394.1599234399347;
        Fri, 04 Sep 2020 08:46:39 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 07/23] gpio: mockup: drop unneeded includes
Date:   Fri,  4 Sep 2020 17:45:31 +0200
Message-Id: <20200904154547.3836-8-brgl@bgdev.pl>
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

This module doesn't need gpio/consumer.h - it's a provider. It also
doesn't use any symbols from init.h so let's remove both includes.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index bc345185db26..349782cdb4d7 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -8,9 +8,7 @@
  */
 
 #include <linux/debugfs.h>
-#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
-- 
2.26.1

