Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8656AC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B51B2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H0/vrJJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgCWJYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:24:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39031 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgCWJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:24:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id b22so6900606pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A/0NRUsfnu7n/YoGxddH0xC1BSLSDDMn2mXtHQEsBCY=;
        b=H0/vrJJc4UTp4a1L7+UIrsXgbN2ZX+7FVzPetQZIdA9e76ziulDaDd2NAhYkIPjkxS
         YT987yydfco9sXyReNE47Uy1nFABe5RZIGH+tsYqgmg60OQudmltQHH7WVpP7G8VHogy
         +GLzGp5ZIudGxaUkMdcxKmubUoLfIMq6950kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A/0NRUsfnu7n/YoGxddH0xC1BSLSDDMn2mXtHQEsBCY=;
        b=GGocplhilwx0+121yoxRbtkoXbX6w73fLhm7kABvERkO6cCfi7qGuX46OVL/i5/1hR
         xrbMoAU4HFChdx3dxmr+9PNC1XKue33rHxmCKQLxiREGlPgqGZhUyIsLUxiPhjbgy7Ki
         NVyw5TVaTY1iltJmS8FCbvg2CFgyRs6vS19nD23npPAdJzccGtTh0bw6Bdj0dst9PuWn
         OT5XSFNbseVdR3PuZYVR5zoRQwgS5PmB4OPJd4+g+hjx3IBfmkRGOo+0Jxr+BKbH3aez
         FWnQTe1g7Et+tiC7e2Qc7nvGDcGpRCrqUOkuIcMoZJr4Ze1xiaJ4715DGjXJ4gaDltI7
         08kg==
X-Gm-Message-State: ANhLgQ3PyeD0uWnpFTRXhKc00qdBjL+14HDDSzbgslory3M6zttmi8Yq
        313pQP9GUHA7CrKkKvNLSLLAYw==
X-Google-Smtp-Source: ADFU+vsQVINq2XB12jFlGwrLlldGkGz/5WxUV8cQYnSGPxofZHvKAe+lIqQmXoaWxjTZF4JRtCVP8w==
X-Received: by 2002:a63:794d:: with SMTP id u74mr8709869pgc.15.1584955492897;
        Mon, 23 Mar 2020 02:24:52 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t186sm1093068pgd.43.2020.03.23.02.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 02:24:52 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 2/2] pwm: bcm-iproc: remove unnecessary check of 'duty'
Date:   Mon, 23 Mar 2020 14:54:24 +0530
Message-Id: <20200323092424.22664-3-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
References: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'duty' is u32 and IPROC_PWM_DUTY_CYCLE_MIN is zero.
Hence the less-than zero comparison is never true,remove the check.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/pwm/pwm-bcm-iproc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 8bbd2a04fead..1bb66721f985 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -149,8 +149,7 @@ static int iproc_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		value = rate * state->duty_cycle;
 		duty = div64_u64(value, div);
 
-		if (period < IPROC_PWM_PERIOD_MIN ||
-		    duty < IPROC_PWM_DUTY_CYCLE_MIN)
+		if (period < IPROC_PWM_PERIOD_MIN)
 			return -EINVAL;
 
 		if (period <= IPROC_PWM_PERIOD_MAX &&
-- 
2.17.1

