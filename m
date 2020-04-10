Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D40C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7B22084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXjvUDi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDJWM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:12:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37138 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDJWM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 18:12:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so3885162wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MKys+xvNKeKPRUcb2HO998a3NhFIcwMUY2eTd9ppffQ=;
        b=qXjvUDi0Oo02J0xpLK9p69eZhYSAdC+2b4LRN08ro/mgP/y+6t1d0OfO//s0S41D6v
         ZaSJZWFJh7EA7oedCGOfMZ5cw+NIJ/G2QltutVnKAC0aAm2ZdAMg875Z2CoR06EQTrCP
         NCqxWn7JZsko6R+pSoW3v8QTb034SPVyxMQwTnWtH4s7mS1ygA2HnnIRYaH71jause8M
         oMiV4MM0teK0GiB7rIAF5Fqgv+FnnfwEDSob9Xer1PWCuzuwtPejC9TxWRu3JSFROKbL
         l36nJAWsR3Q4DbfMUmwj08srJYV42coIh/U/lkoWmW+8pdKxCB/Pnl/5xO59Y8wzGDpk
         /0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKys+xvNKeKPRUcb2HO998a3NhFIcwMUY2eTd9ppffQ=;
        b=T1L8vSuQaVc4NBZFYcVPq5xAkrAqHFdnh5EmMDiSek/dMmkDvVc6BebGj4RCXIk9kM
         cp3jo0N6Ovh2wufXDSiysM/CLet23hu9BWxMkN9kEh9zZzYB8hpraXrrEjr4afKvsAxb
         UawAchxNQZ04x0lecaxwdwCQpUH20jEshCDyftjCQtU//cs83cMhSI3kpQUWpR7RIf8b
         JPRAjd+eXai4dpN38zVxh3cEdAMdcZXFmPJRMBHsKpL469+q1rQF5/f2efIQxKWb9GrW
         zxQ1NYh0NbQXFzlpHltGYrxQ3OOZtBpbuIIvm0FVvUWir1f/T9+R0MMi9pWfunNVNXF8
         URtQ==
X-Gm-Message-State: AGi0PuYDwBCg8PyZAPmfpxb+pOXKS4BOO2PzXBPeDPVph9io1Y9pne4G
        4bLJnw9gT3qx/3/ezsJU7jtSyw==
X-Google-Smtp-Source: APiQypKYCBdItdbr3Tpu5TCVop4Ux27Ilt6jkEovhskIFgF6iaOgzV8l9d8iN78TaJLfyOZP11ADnQ==
X-Received: by 2002:a5d:4a42:: with SMTP id v2mr6282015wrs.333.1586556777966;
        Fri, 10 Apr 2020 15:12:57 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id b14sm4687952wrw.83.2020.04.10.15.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:12:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org (open list:PWM FAN DRIVER)
Subject: [PATCH 1/6] thermal: hwmon: Replace the call the thermal_cdev_update()
Date:   Sat, 11 Apr 2020 00:12:30 +0200
Message-Id: <20200410221236.6484-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410221236.6484-1-daniel.lezcano@linaro.org>
References: <20200410221236.6484-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function thermal_cdev_upadte is called from the throttling
functions in the governors not from the cooling device itself.

The cooling device is set to its maximum state and then updated. Even
if I don't get the purpose of probing the pwm-fan to its maximum
cooling state, we can replace the thermal_cdev_update() call to the
internal set_cur_state() function directly.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/hwmon/pwm-fan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 30b7b3ea8836..a654ecdf21ab 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -372,7 +372,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
 	if (IS_ENABLED(CONFIG_THERMAL)) {
 		cdev = devm_thermal_of_cooling_device_register(dev,
 			dev->of_node, "pwm-fan", ctx, &pwm_fan_cooling_ops);
@@ -384,7 +383,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 			return ret;
 		}
 		ctx->cdev = cdev;
-		thermal_cdev_update(cdev);
+		pwm_fan_set_cur_state(cdev, ctx->pwm_fan_max_state);
 	}
 
 	return 0;
-- 
2.17.1

