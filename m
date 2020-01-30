Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B647AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FE120708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eNckr7wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgA3Uf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:35:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46822 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgA3Uf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:35:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so1771853pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OnHhTHan7oXdBJ9lqN5U957YaigDfCk8zR+rMkIC7QI=;
        b=eNckr7wvYrCJtQnD8laGiWme1n3OUA3V6nQ5tAz1cGMsJ/4PGzqGhDkGmhEZVVv0wZ
         xSIheJ5Gb5dQXt4S+sjnHwNxpbKAVTbUUgNAvyHRCSZzlPGQQeT+kThcYgVPNMyUKEmC
         48DpTGhGGmJRUpSiPLb+5QSRAoLi9Ia0uUjIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnHhTHan7oXdBJ9lqN5U957YaigDfCk8zR+rMkIC7QI=;
        b=frOOhOyFVdoqhonych3Rt0JTEdvfH6GnU53jxy1wrwc6V7XdcmBMWLnMl5z3g+Zcg+
         JMmCb6vHOlhYI6ZBAGDq+eNi2ts2Yf2m36zGwe3pIBZtKw1jjcrXJin3CEz2cd+cci/y
         qPfqusMNpNnTlndR/JX8jc3d26CsF1Ny+FcvobUsg8xK9M8yZshe0RHPWCwqrypWM0xW
         E1jWKofNil7LVjA6r5+v/QMZxOA/2ss4y/0SO/eaEDxmkKhBQUXYgthBiS1LaFQ7kzLn
         M3CxaS+BydFNDjv8Nshd+XOTB7HUvRVDzAeJUXv7xzL2LHLQ8Kun4F3qa8eO7mqEpAbJ
         ToEg==
X-Gm-Message-State: APjAAAUhYrMntltT/U2/iEQhWEK4fUdu7XI8GRFl5dHQIZE4PHMe2fKA
        BH3PkmCsIBczNLdKEInC9HogssumW2kBWA==
X-Google-Smtp-Source: APXvYqypoOtJu0y9ma5MfFUcOlcLTGslbB96H/UYOfUM4gaW0ymEaZMWsyyqCyszJQTCxbR+hOxhZg==
X-Received: by 2002:a17:90a:628c:: with SMTP id d12mr8051348pjj.59.1580416528241;
        Thu, 30 Jan 2020 12:35:28 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:35:27 -0800 (PST)
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
Subject: [PATCH 13/17] pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
Date:   Thu, 30 Jan 2020 12:31:01 -0800
Message-Id: <20200130203106.201894-14-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert one existing usage of cros_ec_cmd_xfer_status() to
cros_ec_send_cmd_msg(), which accomplishes the same thing but also does
the EC message struct setup,and is defined in platform/chrome and is
accessible by other modules.

For the other usage, switch it to using cros_ec_cmd_xfer(), since the
calling functions rely on the result field of the struct cros_ec_command
struct that is used.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/pwm/pwm-cros-ec.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 89497448d21775..8bf610a6529e7e 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -32,25 +32,14 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
 
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
+	struct ec_params_pwm_set_duty params = {0};
 
-	msg->version = 0;
-	msg->command = EC_CMD_PWM_SET_DUTY;
-	msg->insize = 0;
-	msg->outsize = sizeof(*params);
-
-	params->duty = duty;
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
+	params.duty = duty;
+	params.pwm_type = EC_PWM_TYPE_GENERIC;
+	params.index = index;
 
-	return cros_ec_cmd_xfer_status(ec, msg);
+	return cros_ec_send_cmd_msg(ec, 0, EC_CMD_PWM_SET_DUTY, &params,
+				    sizeof(params), NULL, 0);
 }
 
 static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
@@ -78,11 +67,13 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
 	params->pwm_type = EC_PWM_TYPE_GENERIC;
 	params->index = index;
 
-	ret = cros_ec_cmd_xfer_status(ec, msg);
+	ret = cros_ec_cmd_xfer(ec, msg);
 	if (result)
 		*result = msg->result;
 	if (ret < 0)
 		return ret;
+	else if (msg->result != EC_RES_SUCCESS)
+		return -EPROTO;
 
 	return resp->duty;
 }
-- 
2.25.0.341.g760bfbb309-goog

