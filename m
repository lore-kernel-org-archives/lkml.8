Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7EEC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E952070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCYghVET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCYIZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:25:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34580 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCYIZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:25:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id a23so542380plm.1;
        Wed, 25 Mar 2020 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S+Dk0bFK1Q3svp1qfNTAarWkbHyCyaSYslWB9mx1I/A=;
        b=sCYghVETzCgeR8Ekhd48Y2EKedeDKHbepqjXlFowKwav4qnxR0KE7qwVm66xFWT1R4
         8qY8O7dNmemKZwZ/Noo3VFUuO0srvFGvPWMMV1P2m33+2EgeGlIkjbRiVIWHsQpeEZg0
         4nwSff0SXh3VbME347jGE3fb+e6GjfxLuesoxtjZxgFrdf+uFbkk027GTFNfWAmJwHIS
         jFDn8ktkc+hnmmSKNFNlov2wLpG33WONIWq5agayBMfFFAwmAMB84xOuHJOCa48fBrRt
         PP5OIDus152Cv3K1op8REDxObfdictqllcbpZ/+Ml747zcFL0RF+Yks8DiuMZJ5Oyyc+
         lQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S+Dk0bFK1Q3svp1qfNTAarWkbHyCyaSYslWB9mx1I/A=;
        b=eyAQtN3nvZRI+2zT3XGC7Zf5tDpMELknp3Vr7brHNLY4uOT7e1juOKofxRsB7agix4
         ubOg9heyyDey//GKokMtFh92FBmeyz+lVpaseF6TxP92CxWvXcTexz8NGsLmoNo3ybFz
         VFpkrswJ0GCZzUG+yEgr/QtkgOjG7Pr4aKAMdMU0wPUN9QUhQ83w2GHSrZfTlcMZfuky
         4SOP55CoKDldsMgaDox//G1SQiomp2qxjK2ch9E00N+bXXC7Dz26jLD8sMmY1eJL37mT
         MnNEoz+5GCnOdA6GcQZxiYy5JzmzlNg20LPIrIsdXN870aoYFuzB6Q3oUrAkwnq1Eeji
         F9yg==
X-Gm-Message-State: ANhLgQ3wHbtC+68yvueSw0Id0saZu+cLoI7yOoOOJEEbqoi0+/qATsmo
        FbH6xC0ZaFU8+w7LYllFAk4=
X-Google-Smtp-Source: ADFU+vu9LOA3Qlt4uhaTRkBua9S1W3O3kvat3zhrINu5MB/+MUxf0O/6OSSvvSHTrP6O+0CUb9sKhg==
X-Received: by 2002:a17:90a:9b06:: with SMTP id f6mr2376641pjp.76.1585124740675;
        Wed, 25 Mar 2020 01:25:40 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v123sm15764340pfv.41.2020.03.25.01.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 01:25:39 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linhua.xu@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: sprd: Use the correct pin output configuration
Date:   Wed, 25 Mar 2020 16:25:27 +0800
Message-Id: <8a6f91b49c17beb218e46b23084f59a7c7260f86.1585124562.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <linhua.xu@unisoc.com>

The Spreadtrum pin controller did not supply registers to set high level
or low level for output mode, instead we should let the pin controller
current configuration drive values on the line. So we should use the
PIN_CONFIG_OUTPUT_ENABLE configuration to enable or disable the output
mode.

[Baolin Wang changes the commit message]
Fixes: 41d32cfce1ae ("pinctrl: sprd: Add Spreadtrum pin control driver")
Signed-off-by: Linhua Xu <linhua.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index ea04bac..8e39610 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -464,7 +464,7 @@ static int sprd_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin_id,
 		case PIN_CONFIG_INPUT_ENABLE:
 			arg = (reg >> SLEEP_INPUT_SHIFT) & SLEEP_INPUT_MASK;
 			break;
-		case PIN_CONFIG_OUTPUT:
+		case PIN_CONFIG_OUTPUT_ENABLE:
 			arg = reg & SLEEP_OUTPUT_MASK;
 			break;
 		case PIN_CONFIG_DRIVE_STRENGTH:
@@ -635,9 +635,13 @@ static int sprd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin_id,
 					shift = SLEEP_INPUT_SHIFT;
 				}
 				break;
-			case PIN_CONFIG_OUTPUT:
+			case PIN_CONFIG_OUTPUT_ENABLE:
 				if (is_sleep_config == true) {
-					val |= SLEEP_OUTPUT;
+					if (arg > 0)
+						val |= SLEEP_OUTPUT;
+					else
+						val &= ~SLEEP_OUTPUT;
+
 					mask = SLEEP_OUTPUT_MASK;
 					shift = SLEEP_OUTPUT_SHIFT;
 				}
-- 
1.9.1

