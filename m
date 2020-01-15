Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6884CC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4629A24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgAOI3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:29:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43399 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgAOI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:29:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so17527088ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 00:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5VaUwHFGkRCCyYNnoRV3kcKDIqfO6FWnACxA4VSWTgQ=;
        b=VbLfD8OIPM3tlb81rz57pUA2b0yYMFjcBeOpRJjH2BobTmsF9hZ9X6GJudkXJoCQO4
         1i0oakj3dwkGBWDS+1XSuXM1dyx4NhbiPgcbc2daN6IIW1sINzwskikA3ZDfRs6r9uSQ
         dlFA8ob6yV38IvU96c0Sl3exwQWmRb+4aWoy5yCFjX6sPMFAl5kAbLST6QznPTu9bsOM
         PsaDfiuh7E2MDcgXR2ucnbz4ZytXyUvZQ8E53WZNIT3KoVbox2Uo5q2ITuvfAinn2zex
         Eqly8GvSkPR1GW1yAhErQbbFYbQpoGX8R2dLsrn/hbu6OLA4+Y0s/aEjy4Oa6wlIh4Cw
         AWmw==
X-Gm-Message-State: APjAAAW3J6GKYv8jY1kuScvJxGEGulffvDhrF9y6yQvI3vVL5PJrJdft
        kFp4IlVnMgCzTpP+2fYWzgU=
X-Google-Smtp-Source: APXvYqxSUY5emVtZALmKLDSpe3BApSwIzlIRMchObHzY0oi51jsfe+cKWvCnBZ5GSNVE8oDci5fABQ==
X-Received: by 2002:a05:651c:204f:: with SMTP id t15mr1076704ljo.240.1579076980224;
        Wed, 15 Jan 2020 00:29:40 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id l5sm8839600lje.1.2020.01.15.00.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 00:29:39 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:29:33 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: bd70528: Fix hour register mask
Message-ID: <20200115082933.GA29117@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RTC is used in 24H mode (and it is by this driver) the maximum
hour value is 24 in BCD. This occupies bits [5:0] - which means
correct mask for HOUR register is 0x3f not 0x1f. Fix the mask

Fixes: 32a4a4ebf768 ("rtc: bd70528: Initial support for ROHM bd70528 RTC")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

I just noticed this was never applied. I'd like to get this in as
we currently have bd70528 RTC not working in few exiting releases.
(Or it works as long as time is not set at the evening :/)

I think this once was in RTC tree but was dropped as Lee mentioned this
belongs to MFD. Thus I dared to add the Alexandre's acked-by - please
let me know if this is not Ok.

Lee, can you please pull this in so that we get the fix
in-tree? I guess the fixes tag helps this to be included in some
existing branches.

 include/linux/mfd/rohm-bd70528.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/rohm-bd70528.h b/include/linux/mfd/rohm-bd70528.h
index 1013e60c5b25..b0109ee6dae2 100644
--- a/include/linux/mfd/rohm-bd70528.h
+++ b/include/linux/mfd/rohm-bd70528.h
@@ -317,7 +317,7 @@ enum {
 #define BD70528_MASK_RTC_MINUTE		0x7f
 #define BD70528_MASK_RTC_HOUR_24H	0x80
 #define BD70528_MASK_RTC_HOUR_PM	0x20
-#define BD70528_MASK_RTC_HOUR		0x1f
+#define BD70528_MASK_RTC_HOUR		0x3f
 #define BD70528_MASK_RTC_DAY		0x3f
 #define BD70528_MASK_RTC_WEEK		0x07
 #define BD70528_MASK_RTC_MONTH		0x1f
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
