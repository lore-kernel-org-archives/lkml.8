Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0979C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE602078E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCZGtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:49:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34342 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgCZGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:49:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10so5001377ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Qff2i+ym4gPPOxDRIQh2n3v3vk/CiXzDCHZe7pXja70=;
        b=B0bE+b2zub9Ed3e3JG/LOUjcK8vJWV6A8vAZEzG4VNYTrYdEkkjtpQFepRt7k0nfk+
         NedFMEqbx0FoYKBB7f5v1zn1wCebqrGMJFNGP3Eetu1xDu7aHOZK4HOsW3QlqGXs8yn/
         +LF2dIE3uCrgSHTCnt26IF63zdmfQ7j+jfptFQlXUuEEEfO+9k+kifLs+tD3VtCh0nYe
         oaY/wfcTuGyoQL/2u7lwGe+L1S7bOE3Rp7UQh0aELM8tKX2hfxFNR5YCRNUM/ZcWLlaR
         dT13eid23FeMvVS4ubmnERWvoXm/uAqQmWuHc9Mwoh0JSFWnIVkcUNaUu19u7oIjNlwV
         UIdw==
X-Gm-Message-State: AGi0Pua7aw2VAWsjSVnz1nqV6m0MN5yuDItEgJlcXp2EWFHAjbiL/jU+
        cFRVBg32r8Vd6UM4Oj3THYs=
X-Google-Smtp-Source: APiQypKKxRrK0zPIQAUsRUDBdyMW5BiKcxteWRsyZwoU7v2j5uIMayk8EvSsxhEjzSWaGXGXuvFmvA==
X-Received: by 2002:a2e:9706:: with SMTP id r6mr550239lji.183.1585205340626;
        Wed, 25 Mar 2020 23:49:00 -0700 (PDT)
Received: from localhost.localdomain (dc7t7ryyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16e1:b700::3])
        by smtp.gmail.com with ESMTPSA id x23sm854496ljd.23.2020.03.25.23.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 23:49:00 -0700 (PDT)
Date:   Thu, 26 Mar 2020 08:48:52 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: rohm-bdXXX - switch to use i2c probe_new
Message-ID: <20200326064852.GA23265@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD70528 and BD718x7 drivers do not utilize the I2C id.
Do the trivial conversion and make them to use probe_new
instead of probe.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/mfd/rohm-bd70528.c | 5 ++---
 drivers/mfd/rohm-bd718x7.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/rohm-bd70528.c b/drivers/mfd/rohm-bd70528.c
index 5c44d3b77b3e..179584d10109 100644
--- a/drivers/mfd/rohm-bd70528.c
+++ b/drivers/mfd/rohm-bd70528.c
@@ -216,8 +216,7 @@ static struct regmap_irq_chip bd70528_irq_chip = {
 	.irq_reg_stride = 1,
 };
 
-static int bd70528_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int bd70528_i2c_probe(struct i2c_client *i2c)
 {
 	struct bd70528_data *bd70528;
 	struct regmap_irq_chip_data *irq_data;
@@ -304,7 +303,7 @@ static struct i2c_driver bd70528_drv = {
 		.name = "rohm-bd70528",
 		.of_match_table = bd70528_of_match,
 	},
-	.probe = &bd70528_i2c_probe,
+	.probe_new = &bd70528_i2c_probe,
 };
 
 module_i2c_driver(bd70528_drv);
diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index c32c1b6c98fa..e621e1a82222 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -129,8 +129,7 @@ static int bd718xx_init_press_duration(struct bd718xx *bd718xx)
 	return 0;
 }
 
-static int bd718xx_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int bd718xx_i2c_probe(struct i2c_client *i2c)
 {
 	struct bd718xx *bd718xx;
 	int ret;
@@ -226,7 +225,7 @@ static struct i2c_driver bd718xx_i2c_driver = {
 		.name = "rohm-bd718x7",
 		.of_match_table = bd718xx_of_match,
 	},
-	.probe = bd718xx_i2c_probe,
+	.probe_new = bd718xx_i2c_probe,
 };
 
 static int __init bd718xx_i2c_init(void)

base-commit: 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e
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
