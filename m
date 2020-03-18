Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23455C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAECF2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yLuS9F0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCRP04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:26:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51380 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgCRP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:26:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id c187so2594141wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=fUfuRt6oxx3leUSmTuFPTrK4xKpBYnjQ93vBCHZXuX4=;
        b=yLuS9F0cGTZf9LZ1iiqPC6GpTTIeAz/SdSMaqzBeaoFjiZTkLhttnSF5/UX9uxO/s4
         zmXVfiQx3/3rL0NhiRvSYMHersb3dTK0dbQJza45dcefD1AYPZsJdteBj4/wKpBb6iNp
         he2QnvxW608PCtN1yMMSKi+eQKl8Q11uPgXYZhSpQ4AwJEnfofzf5gtcHGU/c1/GfFc5
         NNoCHiQr6YYwmIwVbd/pEAPyxSUgpIbSYeYdpNHBY3LzGB4O8S7lUFjkGdfzRlxn9kCG
         E4LxEPkyKxcc4LdEp9zylpgGly0tFMHCGlSdIQr+ZLV6x7wlrH2x5bbFcDoA8rqGGmz9
         lezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fUfuRt6oxx3leUSmTuFPTrK4xKpBYnjQ93vBCHZXuX4=;
        b=tq7U+Th7UGKFTfZjd5V9AlyVSciMtlNpt8cZwx+YfE0kLYJXM29t02Jq3Cm+pA9SKD
         koN3+uyAAnVL+3fYAe/M1W/LF+XwXMBLNSNc92cbn3Rv7v9G9o2vrHzFMMinS4jIP8Z5
         u7r/UWfHx5JvV3KlptGRfsP0iKm56xIBabJdcKHMlWNG3hsh3GyYYEkHSg+3CGQOSq2A
         cF9usyZG7paiFCt16VcVZBYd0AUPqVA4tDY+y4TlNEGzCmhf1y1ik7u8JzG00R1Ql4cw
         xHrekOoO3LVyRz30Mj1CIybK02jaWFHCdtvBgDhAlhYeDee1VR6lh1NvRhc2kOwF/kGd
         1m4Q==
X-Gm-Message-State: ANhLgQ1UuU/7PW4b3kSyJ0fWu/RFGO3xzPLxoF4+eBDHqaiq0MePSJUV
        IW0jp97w2gIdUaAkudD+IwoMVQ==
X-Google-Smtp-Source: ADFU+vuSq9fGIwkaFfnv935xJPaLgRcrUkBfhGJ7wvIjJMqb87bDFa+H+3A+EDj1ksKv7CDpms2YmQ==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr5622975wmg.52.1584545214448;
        Wed, 18 Mar 2020 08:26:54 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id h15sm9390552wrw.97.2020.03.18.08.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Mar 2020 08:26:53 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] rtc: max8907: add missing select REGMAP_IRQ
Date:   Wed, 18 Mar 2020 15:26:49 +0000
Message-Id: <1584545209-20433-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have hit the following build error:
armv7a-hardfloat-linux-gnueabi-ld: drivers/rtc/rtc-max8907.o: in function `max8907_rtc_probe':
rtc-max8907.c:(.text+0x400): undefined reference to `regmap_irq_get_virq'

max8907 should select REGMAP_IRQ

Fixes: 94c01ab6d7544 ("rtc: add MAX8907 RTC driver")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 7d6cb60ee010..6c99156cbe57 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -327,6 +327,7 @@ config RTC_DRV_MAX6900
 config RTC_DRV_MAX8907
 	tristate "Maxim MAX8907"
 	depends on MFD_MAX8907 || COMPILE_TEST
+	select REGMAP_IRQ
 	help
 	  If you say yes here you will get support for the
 	  RTC of Maxim MAX8907 PMIC.
-- 
2.24.1

