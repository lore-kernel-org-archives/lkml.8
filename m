Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA390C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D9820709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgICSib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:38:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41183 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgICSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:38:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id y4so4938033ljk.8;
        Thu, 03 Sep 2020 11:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UMQxgjN8bL4lq+7DCXHcFAZlrs7ubK02JmdvhEBH8bA=;
        b=P0w9ciza/jiA0EjgQeNNXB4eGpI6IEZHFaLSNBK6nAiBWbe2wYh2M5ss1a7mnhTlnC
         E3aeycDK28kSva/HAaGNmMwsQ2EsI/BIr3bbNWWp1gQvKSP3fH7oEqyfSLPXFUG0D/Lt
         F567cGF5gF1FALy6MDNjRL6PgLTmVFVgKi0a8gegG1Pe6TomQ9BhzlfkDLRP74w96yIA
         N1v7kgppDLtrDp9TlckjOW7ghG4O+IRhvkuM4GFsEINS0MiOhhtaD6Fa400g9qXULHJP
         KS2B99xSMquFcWXCgjzG/twwzXWw+hS26DUlCt1lpw3j8+4IZXoJSTkVpfCh/iu4TAom
         F6lQ==
X-Gm-Message-State: AOAM533wTnvSHkh8dECcrs9FUlhOi2p/e4ze/PRQoR/I3e+ugxKCQqu2
        ldNBQ2FEs0pxVeO9lNNSCNY=
X-Google-Smtp-Source: ABdhPJwMhcVzHRsH3FduG5lYf9jM5llNrtlHpfF78ftbHPe60rJ3t1CCb2dLfJ23Q4TFnrbGnEjGWg==
X-Received: by 2002:a2e:8150:: with SMTP id t16mr1935227ljg.160.1599158307295;
        Thu, 03 Sep 2020 11:38:27 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id j4sm769013lja.31.2020.09.03.11.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:38:26 -0700 (PDT)
Date:   Thu, 3 Sep 2020 21:38:19 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH 1/4] regulator: bd718x7 initialize regulator config only once
Message-ID: <2d3e68c94d4813410da8c4c7eac3332d167d19a8.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BD718x7 driver initialized common configs for all regulators.
Simplify initialization by moving the initialization of common configs
out of the loop.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 7b311389f925..a72031595b9e 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1319,6 +1319,9 @@ static int bd718xx_probe(struct platform_device *pdev)
 		}
 	}
 
+	config.dev = pdev->dev.parent;
+	config.regmap = mfd->chip.regmap;
+
 	for (i = 0; i < num_reg_data; i++) {
 
 		const struct regulator_desc *desc;
@@ -1328,8 +1331,6 @@ static int bd718xx_probe(struct platform_device *pdev)
 		r = &reg_data[i];
 		desc = &r->desc;
 
-		config.dev = pdev->dev.parent;
-		config.regmap = mfd->chip.regmap;
 
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
