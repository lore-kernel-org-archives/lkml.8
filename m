Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDFAC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6224C217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHIyAKDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBETRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:17:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41079 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBETRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:17:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so1695332pfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0ykAx11fuyygrc+KyLwJgAkg4nrOamvVmCqDKRLdio=;
        b=SHIyAKDm+/TnelUmd18Oh98yrnaRJfqfwihlr+xRCOEuwSbwyCetq8quyA73ZpItjm
         L3aiKxG2wEYjOqo12SAfFVQD1fRJo2P+P5n0FHatV5njQYriQeUGS+7JpMunDOL2ECk5
         Z+33q2SdK7436ghVG1a+4KwauIYncVhTJx47Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0ykAx11fuyygrc+KyLwJgAkg4nrOamvVmCqDKRLdio=;
        b=SWZFF9jJ+/pA40rVAXYv1Rd3y2Lsee+DV8Cf439Am3/MnkrOdBjfEaS5UGiUc8lFwV
         MFJAUJsAgT/6q1hEgC6wMnRwdf6m4QZjgI9en70W2oh6Q+lSafPLQ6DtfbQi74/RW99F
         FsPzAGAo1HKyYtbRfRvnLz65nmnUY/8OIXWmVCkVQWDrqamVteb3LZOhT7VnF+i1omad
         4B/qv4wGLaB7PS43RUxPtjxn5ktReqBmS8NThra5K2c63iESgIQTU3sL4ROayFFbyKmV
         17KkVZqSzWIoYcqM82+ZY7YQpMg3OPaj3w5kX9bfbw5TNF/a0KwAlinacfm2MegZdIOJ
         14aA==
X-Gm-Message-State: APjAAAUuNJQy17yQLuO3B5Q0Cfhdw1l1TJuUUQ+7Ygv0V8Cr40C19+Mj
        2rSUasaoJ+6bHGT9R/mYGodnkOg6moY=
X-Google-Smtp-Source: APXvYqx6JwtfFVIKJ/jVZbqnS5l6rVzWM8Q30saJVdPfKjYGL9FBpxZfY1c8WznVEe5B8pJYFhC9SA==
X-Received: by 2002:aa7:9a42:: with SMTP id x2mr34667912pfj.71.1580930222078;
        Wed, 05 Feb 2020 11:17:02 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:17:01 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM)
Subject: [PATCH v2 13/17] pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
Date:   Wed,  5 Feb 2020 11:00:20 -0800
Message-Id: <20200205190028.183069-14-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert existing usages of cros_ec_cmd_xfer_status() to cros_ec_cmd(),
which accomplishes the same thing but also does the EC message struct
setup, is defined in platform/chrome and is accessible by other
modules.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.
- Use C99 element setting for struct initialization.

 drivers/pwm/pwm-cros-ec.c | 59 +++++++++++----------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 89497448d21775..57a1cab4cfacad 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -32,59 +32,32 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
 
 static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
 {
-	struct {
-		struct cros_ec_command msg;
-		struct ec_params_pwm_set_duty params;
-	} __packed buf;
-	struct ec_params_pwm_set_duty *params = &buf.params;
-	struct cros_ec_command *msg = &buf.msg;
-
-	memset(&buf, 0, sizeof(buf));
-
-	msg->version = 0;
-	msg->command = EC_CMD_PWM_SET_DUTY;
-	msg->insize = 0;
-	msg->outsize = sizeof(*params);
-
-	params->duty = duty;
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
-
-	return cros_ec_cmd_xfer_status(ec, msg);
+	struct ec_params_pwm_set_duty params = {
+		.duty = duty,
+		.pwm_type = EC_PWM_TYPE_GENERIC,
+		.index = index,
+	};
+
+	return cros_ec_cmd(ec, 0, EC_CMD_PWM_SET_DUTY, &params,
+			   sizeof(params), NULL, 0, NULL);
 }
 
 static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
 				  u32 *result)
 {
-	struct {
-		struct cros_ec_command msg;
-		union {
-			struct ec_params_pwm_get_duty params;
-			struct ec_response_pwm_get_duty resp;
-		};
-	} __packed buf;
-	struct ec_params_pwm_get_duty *params = &buf.params;
-	struct ec_response_pwm_get_duty *resp = &buf.resp;
-	struct cros_ec_command *msg = &buf.msg;
+	struct ec_params_pwm_get_duty params = {
+		.pwm_type = EC_PWM_TYPE_GENERIC,
+		.index = index,
+	};
+	struct ec_response_pwm_get_duty resp = {0};
 	int ret;
 
-	memset(&buf, 0, sizeof(buf));
-
-	msg->version = 0;
-	msg->command = EC_CMD_PWM_GET_DUTY;
-	msg->insize = sizeof(*resp);
-	msg->outsize = sizeof(*params);
-
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
-
-	ret = cros_ec_cmd_xfer_status(ec, msg);
-	if (result)
-		*result = msg->result;
+	ret = cros_ec_cmd(ec, 0, EC_CMD_PWM_GET_DUTY, &params, sizeof(params),
+			  &resp, sizeof(resp), result);
 	if (ret < 0)
 		return ret;
 
-	return resp->duty;
+	return resp.duty;
 }
 
 static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
-- 
2.25.0.341.g760bfbb309-goog

