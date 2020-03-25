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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98D1C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB802070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9vBDhRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgCYIZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:25:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41099 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCYIZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:25:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id z65so697115pfz.8;
        Wed, 25 Mar 2020 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k5nOeJi4Mzd9odPDFONA/SAXJ8f92PxzBPduQMyeDMg=;
        b=T9vBDhRIuJ/D4GuLLWk1B2GH9o4nQUMiMvyO/DOEChiaJ6t/tuw7xmiLP+LlFMxIFM
         UvvL8XrqBw+azqnqS2sctnNXq1QuSOvU9PDaqF4IB3aLHn9zxRX68ANMOYqzjj/Mwn33
         vELG+OQBlWQd2ssSPgMw/PXWG+8jAfCMFQnbtlYmbQmMRRoirop9gjnqwXG/XNfVjxsi
         4OdgtDS9S6or25MDmw4Hl256Au0jUVvVy+Guf/HWSh4WdgsVIdVj+KyDuQHuKdgu3fKP
         MbBEcp5QDZg6F1ANonYaHSxQ5G/VEgEXfWwwSBlWHtwIMm8UsTQTaPQwxr+a2vEq+3Db
         IqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k5nOeJi4Mzd9odPDFONA/SAXJ8f92PxzBPduQMyeDMg=;
        b=Cg5EjHfLuqbCg8OjOdv6IYQZOzFh0azQzlGQGqKBUrN39VDHxNEgS8YLw3obkPEQsH
         QgtlcqwpuHErO7jdwVm0CCYRg92kt0cBqov9WCYmn1780hdc35f/cHkGBWLVZ0Xnvw1K
         nftiECnECMq+QqMsgKKBuJvFd6SNdKhDr4bur7oHJ7PyF8SvV4R7Nt36ze/T+CbS6IF9
         bxnuciIe6Fltv6lf5WTiLB2Mlz1R4AHKQzeYT6OJrjUG+9qFOS1mUtkNixsqBBUPgEwV
         76wp6dmkZ0NGdd0V7XrHMktA3hPF7WB6rwuPhAP/Kbew0InSeelL8MyBwGks/Wpiun1g
         7g6g==
X-Gm-Message-State: ANhLgQ1qkLU1IzBUAwBYw49XafFKoc5zsRZOY+T7LcIFGeQEYFBpleZE
        RNcLY8UufRS0YMjS4UERR+s=
X-Google-Smtp-Source: ADFU+vvNaXY1frNB5B6Wlr9zXp9E18HadbWvofvIBtet/xd8IHoM24/LYt9vgvOwHunuCwB7JHAEug==
X-Received: by 2002:a62:5a03:: with SMTP id o3mr2154368pfb.301.1585124743957;
        Wed, 25 Mar 2020 01:25:43 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v123sm15764340pfv.41.2020.03.25.01.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 01:25:43 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linhua.xu@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: sprd: Add pin high impedance mode support
Date:   Wed, 25 Mar 2020 16:25:28 +0800
Message-Id: <3bdac4c2673b54c940e511f3fa569ee33b87b8d5.1585124562.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8a6f91b49c17beb218e46b23084f59a7c7260f86.1585124562.git.baolin.wang7@gmail.com>
References: <8a6f91b49c17beb218e46b23084f59a7c7260f86.1585124562.git.baolin.wang7@gmail.com>
In-Reply-To: <8a6f91b49c17beb218e46b23084f59a7c7260f86.1585124562.git.baolin.wang7@gmail.com>
References: <8a6f91b49c17beb218e46b23084f59a7c7260f86.1585124562.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <linhua.xu@unisoc.com>

For Spreadtrum pin controller, it will be the high impedance
mode if disable input and output mode for a pin. Thus add
PIN_CONFIG_BIAS_HIGH_IMPEDANCE configuration to support it.

Signed-off-by: Linhua Xu <linhua.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index 8e39610..48cbf2a 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -467,6 +467,12 @@ static int sprd_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin_id,
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			arg = reg & SLEEP_OUTPUT_MASK;
 			break;
+		case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+			if ((reg & SLEEP_OUTPUT) || (reg & SLEEP_INPUT))
+				return -EINVAL;
+
+			arg = 1;
+			break;
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			arg = (reg >> DRIVE_STRENGTH_SHIFT) &
 				DRIVE_STRENGTH_MASK;
@@ -646,6 +652,12 @@ static int sprd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin_id,
 					shift = SLEEP_OUTPUT_SHIFT;
 				}
 				break;
+			case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+				if (is_sleep_config == true) {
+					val = shift = 0;
+					mask = SLEEP_OUTPUT | SLEEP_INPUT;
+				}
+				break;
 			case PIN_CONFIG_DRIVE_STRENGTH:
 				if (arg < 2 || arg > 60)
 					return -EINVAL;
-- 
1.9.1

