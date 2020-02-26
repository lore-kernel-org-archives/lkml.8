Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F39C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA5324680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eTS74HdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBZNxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:53:03 -0500
Received: from mx1.tq-group.com ([62.157.118.193]:59174 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgBZNxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:53:03 -0500
IronPort-SDR: NoHTmXF7OPsSM64RgzKJfYsKu6u5yJk9JrK5e27hWb7/oHVoGI1rzjI+vvS/iBXt2UuycE8pmw
 iLtKWvg6HL7JmxotpQ23aFoLHQw1gQ8b8aaarpEq30+0CLsQWSGNde9F6cWjjygNjDMS486AR8
 PvCzykd2iRC0F0Cz75GQCbNUzWUJ2QsaYOsx6KAp3vpMbhN6tGYpHlmlPFrqYsKs4Qe0gdEBKZ
 OjYmUOI3BK77UHHT7iks1wMITRtcgGoJYa7DlJC8ka+BU6xPAuh80SvgZvi/hdAayklOHC3blq
 bAI=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11120522"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Feb 2020 14:53:01 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Feb 2020 14:53:01 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Feb 2020 14:53:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1582725181; x=1614261181;
  h=from:to:cc:subject:date:message-id;
  bh=ADeNmlQQz72Eo2Cr7Fb7beMzpsaJivTmWRGwQL9Jh2U=;
  b=eTS74HdJrs0fD0l5c2s3ySODoTEw0Wn1ing/x1/fHvU5oMDKayqM+Vzc
   TYkjGNtmUH+Xy2C6jSAnB111p4cAoM2MdMQ+hMaBztm0JFBTRi2gOncog
   txYVCzGYq1S3zGRblr9GIj0zQ7I0wSJZ81quAhgLI7qU59GYUV0VOsWQ8
   jss9FER6gjYyRk+XQcXtMEWiLbb7laGWBS1mP3DJIGA5rnImgfQ/ZU587
   7g/hVjvolARy+52w3bR1Y/4PMhAyM+OYMUvQvOniEc+02uA/Qtxs/YMSJ
   yk8QiJmyMxw1tdB5NQSRo7MXPHi+VN01H4FuAUkmsltrL18r17YbpLI6l
   A==;
IronPort-SDR: KcHs2IJtWkqLaGm13nJsPY5nilMfQOsfBp88f3vMT6jVKDWpLM8PMPMDXTOo5HzvHbMvR0iN01
 HyaBYrZl17ZNUCuICYkO17BaVU11jm+Vni3SZWFip305rHyIMgQUGLMlTYpbMU9sR/U9A9SeIF
 lkrpgpvpT+SHcDosD1qAFQMaV0nGt2Dhgf1uEsuGHOCacDqY7Te1jI4RM5cl78ul9ZEezFrpTM
 0DfiWAKz9uyh1avoiD4oq7YvJ/UsIZ8BNznnu7O3vNYstYGXrot3CsEKTCOopwHYfqCvRH6Lbo
 xjo=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11120521"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Feb 2020 14:53:01 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 178FB280065;
        Wed, 26 Feb 2020 14:53:08 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Date:   Wed, 26 Feb 2020 14:52:26 +0100
Message-Id: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

duty_cycle was only set, never read.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/pwm/pwm-pca9685.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index b07bdca3d510..19ac97108a64 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -69,7 +69,6 @@
 struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
-	int duty_ns;
 	int period_ns;
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
@@ -272,8 +271,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	pca->duty_ns = duty_ns;
-
 	if (duty_ns < 1) {
 		if (pwm->hwpwm >= PCA9685_MAXCHAN)
 			reg = PCA9685_ALL_LED_OFF_H;
@@ -449,7 +446,6 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 			ret);
 		return ret;
 	}
-	pca->duty_ns = 0;
 	pca->period_ns = PCA9685_DEFAULT_PERIOD;
 
 	i2c_set_clientdata(client, pca);
-- 
2.17.1

