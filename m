Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E38C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8193D206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="sVLlHdMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgGGLBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgGGLBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:01:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E44C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:01:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so19839955pgk.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAMYwt59LkqLrwNKFzr4bzymX1Cf2qes9pBL1ueiJsw=;
        b=sVLlHdMUd8rpWhgiQiLbWBdoAxrVOLLuGkJyTbwkwNnfnestrgIC/Eh7rGZDqrouF/
         Vx7uhpmmhReZUbK7jt0UwQiXKhDytDqQYJZCcVPHc/LBboJrs5UjJzwt9BLJ2iSA+MU1
         8ItartpECjVNe28EQAlhwU3T2aLuiOh9AY6dzImJ8m8PlURTK8EdPgCLvx5z9wPsV9r5
         mLVgv85Ias4NN48SW/HUv0CGVojbV2QiKTjDRBLZvn05BkYgboxIbicO1gKRw/mWxI84
         r0aHp7txAt5K6ypaIuOOxvDHSrWI0FK26LYlGnUUh2mk65G3l/Tz4E9kkXdQUvMLvHar
         sSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAMYwt59LkqLrwNKFzr4bzymX1Cf2qes9pBL1ueiJsw=;
        b=qHHcHPzIiB0WZt1310Ri1QE4i7gHOYz6CQAlJco1SPN3WAAkj0lO0niHuussnasSzE
         1R2yo7bqfMVIn9OYQAVPjtsmnZwyFyqoW2m0LCpQjUAFKUDUc5iRztZd8pAL/64OAYOp
         9g66uYX6Qg4CcxAiNH/6L6Ah5qUXfxfBWMrAPtPXOC/7+Bt5yuaMFuSCJ3+ftOVjonTx
         T5GO3D8YkPUM8b0+eiwCHYA/4hFAKE8JpUD9rXhMuup4IrlB2KZjbm2u+Utrh6WbcSFg
         6Ow3Soirjm+LdvFL1WGBDARxY9PLqc/HAu0aaMF/PAfGHJ9MckiVrfuNdxfBQp4PJC7p
         8TGw==
X-Gm-Message-State: AOAM530AYkZXdVw3gQS+tU1yrixjVItmD59cy6TQSSYFzPhn+qB4dkSq
        fcQhweBsbiFcn1Au/OP+J0aDCQ==
X-Google-Smtp-Source: ABdhPJw63aAiU5OimGX+Q6ywEfE3uOzW82MXV5UIsx4a8uxSy+Tww3NfCJ7K5weY+joU3K5TNmpHEA==
X-Received: by 2002:a63:135b:: with SMTP id 27mr36576925pgt.37.1594119668943;
        Tue, 07 Jul 2020 04:01:08 -0700 (PDT)
Received: from localhost.localdomain (36-239-210-101.dynamic-ip.hinet.net. [36.239.210.101])
        by smtp.gmail.com with ESMTPSA id w1sm22211314pfq.53.2020.07.07.04.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:01:08 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mfd/axp20x-i2c: Fix "CONFIG_ACPI" is not defined warning
Date:   Tue,  7 Jul 2020 19:00:58 +0800
Message-Id: <20200707110058.976371-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below build warning:

drivers/mfd/axp20x-i2c.c:82:5: warning: "CONFIG_ACPI" is not defined, evaluates to 0 [-Wundef]
   82 | #if CONFIG_ACPI
      |     ^~~~~~~~~~~

Fixes: 20f359cb236b ("mfd: axp20x-i2c: Do not define 'struct acpi_device_id' when !CONFIG_ACPI")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mfd/axp20x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index bd271fbe1ec1..3c930316d48b 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -79,7 +79,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
 
-#if CONFIG_ACPI
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
 	{
 		.id = "INT33F4",
-- 
2.25.1

