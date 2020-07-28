Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3CC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C5920663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XHy3Hkgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbgG1PO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbgG1PNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:13:18 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8AC0619D5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id g6so1538691ilc.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X77SPgqeRzIi7EPS0EuqxV7/IKv3AykZrtE724jPXxg=;
        b=XHy3HkgoBzyU7B0kjB5UebEtF+vf06VHhx0/jKsJcL5bugXvMSbqZpMi8LdXQsiAhs
         pA9Q4Mvy6EMrzMQqeo179qzEolOlL2P210L6mZPhKXNPHkK3jYFB+kyEovPurqDOskHe
         ruyA7I6IGIUfSEYtFOk+INJ51lS916hhvF6MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X77SPgqeRzIi7EPS0EuqxV7/IKv3AykZrtE724jPXxg=;
        b=pVcgqrRsAx+AzuQk/Irq5iJIhMGATNtxAgoPw+gipRt9+xIjPQvhZc9MXL4GXQO77E
         HWqPWfv1kSynTJA9bHfGA3ciySboO9xxynLFV2geyfm3OO1YoBl2YWBpJqTvBunz4y+R
         iaMSSHPBi3rL+b2x5hlO8inhdLYTzbKep5vzksQUkIIUIouQ7BrBX7ceVC6SY0lmLM+y
         bIX9sq+plRgAHCyeUdAKV9lS9b9qQglmVftXP480tYfBvjAFdn3wLgfp8dGZo4qXHHKM
         GTWpFcSfaJsurbUT7nwxs/xsWbc6lxopurGq1f3Noqew5q9yRy73Anog551mLqzlnUTz
         eEMQ==
X-Gm-Message-State: AOAM532QMchDRG8GlL12GH9JVWkH2wumAmirPKOJKmnqASy/6copezkx
        0Zijheurv/14/smSEsQn6lYxAQ==
X-Google-Smtp-Source: ABdhPJySXXN72bxVJJIeBDgnmesD5K+vdd8uvbwtfSploVLqeodEPgHI3v5z+I/kvRvKqA3xmgBA3Q==
X-Received: by 2002:a92:1b5b:: with SMTP id b88mr22688298ilb.104.1595949196575;
        Tue, 28 Jul 2020 08:13:16 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:16 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 04/15] iio: sx9310: Remove acpi and of table macros
Date:   Tue, 28 Jul 2020 09:12:47 -0600
Message-Id: <20200728091057.4.I33c50453845a8167969130d514af86e573b6ef31@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids unused warnings due to acpi/of table macros.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reported-by: kbuild test robot <lkp@intel.com>
---

 drivers/iio/proximity/sx9310.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 76b8bedebeef50..0fb88ad66f7342 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -16,7 +16,6 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -1051,8 +1050,8 @@ MODULE_DEVICE_TABLE(i2c, sx9310_id);
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
2.28.0.rc0.142.g3c755180ce-goog

