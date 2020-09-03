Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6784FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4408E20758
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjBFoeCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgICAy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 20:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgICAyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 20:54:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3FC06124F;
        Wed,  2 Sep 2020 17:54:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c2so1356295ljj.12;
        Wed, 02 Sep 2020 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3237sadmuAVzjAWSClmEC/vrTdnbMPIln63ICsZjrk=;
        b=GjBFoeCE/uetmIDjgdLwQLg5PViMMWK3sgnj8ePG/WhdrOIOukagB/OMUouH+XyEbH
         xB2gcIjEif08NFIniawau9Y6TlJUwmBAMoWxN6OQR8LogEsuyDos72wEuyY8qAFYO4NU
         SXi4qifqzv6N26EVNT6kUd1j1ns+58f83FEzZulYhXeYc+FmFNJITY7AIAFy8ANydIhG
         AaWPaxPGXQWMyMNzPkvK88yvyrwtlP7VP/sQBSuAxwSDhyvak7CmZbe4gFZDvlqcsEGc
         wniuMQ2OC8YIg8nB3ynAn6W+r/5/TS5zQ1FKSsA85i8YpCIKiFwjG/am1iEJ6lmG4RoP
         hIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3237sadmuAVzjAWSClmEC/vrTdnbMPIln63ICsZjrk=;
        b=q83LTcuc7RDIhvhzO5SchCeeYH2eBUrDLZ2WvFuolmbGALnv77Kx94qqUqdAldaw7p
         fUvKumgRA/wKk7cglfQFx07Zp2Pn1oj0U/lVxec7verTe8BgFW1xFkyheBkH/ozr76u+
         9drtGtUoXEoO06a1MGz3eAbvB72mTcQLtfVqhU0/MNpDOa0Hewt0l16gnmBdJBZPxilf
         kzWFbLUIEgDwhcLfEW/EsHEOEEAkCz5Ok1M7ffHsbTJCTdA9IxbvnTNeWMj+oywUBgys
         yPlmlFfQov+ELyoDcJAW8Re3SFWVjfZUr7ofdIiIQLaApSQgyRCM/5lAR9R0eucV2meJ
         diug==
X-Gm-Message-State: AOAM5309J/FRz5bBDKmMxAkVS1xs3fisfN7UqnnF0qHfN/+NnQb/fHll
        +T2zKRJb60KCRFPScEb67Sw=
X-Google-Smtp-Source: ABdhPJzNDHFUdn+oanCpXc9NrXtZmOXYYW2EW5+u0xIgmi/S9a8UXaSafQhq4E2ZIHErtYSYYfjqVA==
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr275074ljr.146.1599094447364;
        Wed, 02 Sep 2020 17:54:07 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id g1sm250321ljj.56.2020.09.02.17.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 17:54:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/22] i2c: tegra: Improve driver module description
Date:   Thu,  3 Sep 2020 03:52:55 +0300
Message-Id: <20200903005300.7894-18-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200903005300.7894-1-digetx@gmail.com>
References: <20200903005300.7894-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use proper spelling of "NVIDIA" and don't designate driver as Tegra2-only
since newer SoC generations are supported as well.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 67f2f4a0fe86..5b37435fa36d 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1993,6 +1993,6 @@ static struct platform_driver tegra_i2c_driver = {
 };
 module_platform_driver(tegra_i2c_driver);
 
-MODULE_DESCRIPTION("nVidia Tegra2 I2C Bus Controller driver");
+MODULE_DESCRIPTION("NVIDIA Tegra I2C Bus Controller driver");
 MODULE_AUTHOR("Colin Cross");
 MODULE_LICENSE("GPL v2");
-- 
2.27.0

