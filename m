Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B82C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B4E20753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDTWOYNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgELUxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELUxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:53:22 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45270C061A0C;
        Tue, 12 May 2020 13:53:22 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so15144653qke.13;
        Tue, 12 May 2020 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OyS6mmNv0q65u62hC5nV/TgLYdLkGis5cCl6PdzqkEw=;
        b=RDTWOYNZFw5NrEI6k34m0CvGM/VljYk9JpYUDU2JUU4ujF+SMcR/IG9rddtmv11V4M
         HhSKPLqzLJJ6pEGFDRODF5eN4gRdg88TKm2IZ337xqOgktJ9zkUb74ongeklO9XvKCva
         Sb49D79rmoDYGgCSPyWhgGW5i4R8VxUZgzURvXZTYkqJUlYc5NB24D24JkH2zCuqSYGa
         IDK9Iz3oU4rKsWoJqJDGM+BRVv83HL60erDVZXXKgCnblKn5xBdMCklFoHms0pyOJwY6
         RAauDIOzMG7F4YM0T8b9l+D+bDeJlZqh6TrP+u+zJhGglxmMmlCGXpfYXJsyt0QjDru/
         Th/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OyS6mmNv0q65u62hC5nV/TgLYdLkGis5cCl6PdzqkEw=;
        b=htgmLaXB8I+4szb7oRLl8WNwTwOqjh75xuXxs/G6xjFM1U4UAaZ9X9tsfkgN1kpPaX
         12V1+Vmp4KFZu0IrReuqmfOsuplT0vH/ZkLFbWf/Q/XCMaGLv2GRmSvILBdLLmRse/q3
         yShdSfnhOjr3qVKZEJAUKuAX3a1AdA9FPT/E5AyQ04AL4vKEUbNJGV5RfrFB7q2W2K0Q
         iOglSi+g/hgSkvDXBEfpt4hH+6EoxPkyRwWmgJtL8sJ82+E9J76yjf5DWFrRZh5kVo0p
         gutIdC+dw9zPg+BXbmebYW0OuQNVlL3DopQw6UuruH3EZNBSROqXuEgGwGwf1sA6SL2f
         0m5Q==
X-Gm-Message-State: AGi0PubI4wmC9lqdvmWfuW9R3MaNufEttOS4YLHJ+rMXdCxTZpZS9k5C
        D0aOii6+SQby1+xB+OxZCDXYF8VN/Sd+Cg==
X-Google-Smtp-Source: APiQypI82NkVBwdJGZemhVT0kn8euOjsBIY+zrqpnGJBxNXvrgVaMrsGokVs1ycgaD031Ugz8CCfEA==
X-Received: by 2002:a05:620a:662:: with SMTP id a2mr20537000qkh.304.1589316801088;
        Tue, 12 May 2020 13:53:21 -0700 (PDT)
Received: from sca.dev ([201.17.110.164])
        by smtp.gmail.com with ESMTPSA id h6sm9503374qkf.61.2020.05.12.13.53.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 13:53:20 -0700 (PDT)
From:   Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
To:     linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com,
        alencar.fmce@imbel.gov.br
Subject: [PATCH 3/3] video: fbdev: ssd1307fb: Switch to atomic PWM API
Date:   Tue, 12 May 2020 17:52:49 -0300
Message-Id: <1589316769-13277-3-git-send-email-alencar.fmce@imbel.gov.br>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
References: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
---
 drivers/video/fbdev/ssd1307fb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 748c21c0567b..b1cac4a3722f 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -303,7 +303,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 {
 	int ret;
 	u32 precharge, dclk, com_invdir, compins;
-	struct pwm_args pargs;
+	struct pwm_state pstate;
 
 	if (par->device_info->need_pwm) {
 		par->pwm = pwm_get(&par->client->dev, NULL);
@@ -312,18 +312,18 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 			return PTR_ERR(par->pwm);
 		}
 
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(par->pwm);
+		pwm_init_state(par->pwm, &pstate);
+		par->pwm_period = pstate.period;
 
-		pwm_get_args(par->pwm, &pargs);
-
-		par->pwm_period = pargs.period;
 		/* Enable the PWM */
-		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
-		pwm_enable(par->pwm);
+		pstate.enabled = true;
+		pstate.duty_cycle = pstate.period / 2;
+
+		ret = pwm_apply_state(par->pwm, &pstate);
+		if (ret) {
+			dev_err(&par->client->dev, "Failed to apply PWM state: %d\n", ret);
+			return ret;
+		}
 
 		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
 			par->pwm->pwm, par->pwm_period);
-- 
2.23.0.rc1

