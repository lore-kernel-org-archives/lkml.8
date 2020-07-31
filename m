Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3016C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5C321744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VDUylHw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbgGaQtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733036AbgGaQtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:49:02 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D66C06179E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:49:02 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e64so32265883iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgjKsJ/JPsYNKlD2x2wTWCtu2t/OkQtd2UQoMK7szBQ=;
        b=VDUylHw0pzeNeA046zmOyuq5ZQOKM31CadNiZObdUZTtHvoH9bEAKeuo16GU1elr/v
         UcvL3AY1CL26t9RCboBHSgPzIrgGIIZmUJU17QgLjQXEt6pDtS6fORMLnCJyRKevFmQo
         l0aFn8N7+fvQtNV5cKwQ7RjZFNWlMFE+YFFO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgjKsJ/JPsYNKlD2x2wTWCtu2t/OkQtd2UQoMK7szBQ=;
        b=sc14iFouD1uNQgM5wRnGHinsWenBqtF7j8eaoj/42kksoYesmSU6mAuErM39QmOU2P
         kn9g9m07cksfKJ8sjvB59yCvs8WMk1SNotMtl8Wo0JAjs7Nh/oBxgNykN8fofYOkxBqW
         YMYYXEu3sMOa2tGkIsJgB/0nqQsCPZB7wBziXfWC3fk5t9rksuvhXkfxjLfHe5RVamBN
         qUtd97hCb96EJt/M89upeZTgynKOlYx7VymH1ClFJTYCi4egx3mOddUXpsmhgj/p8Xav
         zlCwPVZQOMzGdmVE9b48S8T0JD/zLoKkKuqrawwQgTKMsmYTizcqImsmYGJu4Ymk0CpS
         b4fg==
X-Gm-Message-State: AOAM531MToserbzfnXwF3JmnwRzP9dK6NCfyU+4A/4DFpMbw7H2Qz8Ha
        jc1nOHFc0a1Fyx6Izur2/7VIYQ==
X-Google-Smtp-Source: ABdhPJwnfDE5+ese/5K+QCB69TQqRvvsEKhyp1n82sHzcFfQReen0AyMP7MmyprjNCRebh6tTj2a4g==
X-Received: by 2002:a6b:185:: with SMTP id 127mr4494397iob.153.1596214141677;
        Fri, 31 Jul 2020 09:49:01 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:01 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 04/15] iio: sx9310: Remove acpi and of table macros
Date:   Fri, 31 Jul 2020 10:48:41 -0600
Message-Id: <20200731104555.v3.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids unused warnings due to acpi/of table macros.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v3: None
Changes in v2:
 - Added #include <linux/mod_devicetable.h>

 drivers/iio/proximity/sx9310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index c7a27c21c20cd1..66f7050d63ae97 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -15,8 +15,8 @@
 #include <linux/i2c.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -1052,8 +1052,8 @@ MODULE_DEVICE_TABLE(i2c, sx9310_id);
 static struct i2c_driver sx9310_driver = {
 	.driver = {
 		.name	= "sx9310",
-		.acpi_match_table = ACPI_PTR(sx9310_acpi_match),
-		.of_match_table = of_match_ptr(sx9310_of_match),
+		.acpi_match_table = sx9310_acpi_match,
+		.of_match_table = sx9310_of_match,
 		.pm = &sx9310_pm_ops,
 	},
 	.probe		= sx9310_probe,
-- 
2.28.0.163.g6104cc2f0b6-goog

