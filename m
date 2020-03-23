Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1224CC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D951020736
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TguF1o1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCWGxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:53:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33693 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgCWGxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:53:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id r7so12445835wmg.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 23:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DuqutkfVD4m7NtyrXjd1qFiuKaLZ6gnOOVtPX0RgVTY=;
        b=TguF1o1/qlgnZwU27lTm96jgi4/VmGaBU9Eea/Y1AGY4nm0JxN1hlQq8gngr0eXvRZ
         COkqUxmF+S78f7qM1i7WsXFrGqJBmuvAzIxi/Mx3KFXr2kUiPBQfEB7TEazWvWf1EJ8d
         kBhyfPSYv7fRe/9sVm6xPmpCcJzBLyo9FjBsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DuqutkfVD4m7NtyrXjd1qFiuKaLZ6gnOOVtPX0RgVTY=;
        b=Ta9I0saKn5kq31ar3R+gM0dTYZP8EEG6E+TNGq/io6RkyfcRINjJvgcWGU7P7rmzAp
         peIKkeeCmiaaN+T2nEMCc8H1Y9loJnI5xDu4T1upcjpQvXY5eXTbLNzuRQ8ngLe6BoTb
         ZE81X7EL3G0IOfRh8vLJi7yV30l+7dO6LMX9BTuhtW9OTsF9ixWRe+twU/l0Ksap50jb
         lSO7PeIRikVW250OXYMRCuzSIKMeocFslz0gj4MpvYTvXTKyTY3ngEHAD9n6TuvsAbjb
         d2t2jOVzINHKhPHd8uQJVT8SBkA73MawfGL0DjAYv6kQ6Z9grlcfdbBBJLqhbbhcmfDb
         h5JA==
X-Gm-Message-State: ANhLgQ3VJEP1xTPBVaWioMAuJJF0WRNgAMIardJYzqzgw7bSHlx7GUqJ
        JgE5Sf0ds2PDy/XlXT19Iea50w==
X-Google-Smtp-Source: ADFU+vvTcWQvI4pQ74ETn6iuJkGTxDPyFfqkWItYiIQQfNbGj4qUUZzKTb7JO1lqWDauafYBB0xF4g==
X-Received: by 2002:a1c:196:: with SMTP id 144mr26056577wmb.100.1584946424816;
        Sun, 22 Mar 2020 23:53:44 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g128sm21127453wmf.27.2020.03.22.23.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 23:53:44 -0700 (PDT)
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
Subject: [PATCH v1 2/2] pwm: bcm-iproc: remove unnecessary check of 'duty'
Date:   Mon, 23 Mar 2020 12:23:18 +0530
Message-Id: <20200323065318.16533-3-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'duty' is u32. Hence the less-than zero
comparison is never true, remove the check.

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

