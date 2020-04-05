Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5C5C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58B520675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toTm0ALb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDELYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 07:24:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50670 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgDELYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:24:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id x25so659750wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SXrfjedrBYDlYytIqTbgN8ZqV8Q1N0fqqOl62QOS4Y=;
        b=toTm0ALbeEoKhLTH3MjSXrfmu+PMNqosEk7uOGmgAQstwGDY6LJpSZmpNrEiyyYSkL
         YGs+3evi0ON75+9vuRhTdbQvpUp8pxv2ENfg3X4V0oJg8VIweg52W3InQPMEG8e0I45o
         bA9zzI+cRL8+NGJVL41uO2oDM6+eTWp/UamDGDMp93VH4nMnk52cYX6QdIlQmqdkyKjb
         qoaHmdPb/D1vl6IgENO3LV/qxgTyaxZhWTwp50wcxGDwqRMPB8YW9Xecw36CUpOhff+s
         HGujmeHaDp9I7McqLyUgy6wupcCFhqfkOuFRftV6efAEypwP5pYOzXMceG0BZ13g7gvY
         mTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SXrfjedrBYDlYytIqTbgN8ZqV8Q1N0fqqOl62QOS4Y=;
        b=nyTdTtf1uVBZqaH47h6mtwPOEEBKClUlpNV/TO5San6j8IkcQOPZt+k5m8qaotlPaf
         DahvwhR/Dcnj7NKUmGHk02SKR0Ex1B25NRZBLU16j0ovkzTW7NT7Q5+XqBBxyqDX+O10
         hzipV8arBzUpJLv9t0rM07uL4KtNWFDPrlYIos4z/36N9xJ3DQ6Ndl2GhYtSEDhbrKeW
         cb24swZTIOcoKJjcurzyvIjaQNdNK3tjatr+UBRWBcIXAO0dsp51JVqrYLl0ilwskorn
         caA6J2orgsXR7/CcXWDAQYwnEKUJfG77fjxyJUCh5T31eB/Vg1O6sL9V/6lKIE/TsHlh
         ZH4g==
X-Gm-Message-State: AGi0PubHVAYhtCrkZ+/9cZrBWrgBWlRtJG0PnH7fdGwaRyf8pLBFs/Cw
        s+XNl764A7anU8vU4RysenI=
X-Google-Smtp-Source: APiQypK6AC/PctIX6tMyVU4FpT2zQjW+xLA6DSL/lKKxnGpzVZz8EIZ8mONdHmfyV5warNb46JCNFQ==
X-Received: by 2002:a05:600c:2106:: with SMTP id u6mr18681932wml.161.1586085852274;
        Sun, 05 Apr 2020 04:24:12 -0700 (PDT)
Received: from localhost.localdomain (dslb-002-204-143-158.002.204.pools.vodafone-ip.de. [2.204.143.158])
        by smtp.gmail.com with ESMTPSA id b15sm20365012wru.70.2020.04.05.04.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 04:24:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove unnecessary asignment
Date:   Sun,  5 Apr 2020 13:22:29 +0200
Message-Id: <20200405112230.31975-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary asignment in SwLedBlink1(). The code path with the
asignment 'pLed->BlinkTimes = 0' is only executed when
'pLed->BlinkTimes' is already zero and the value is not changed between
the test 'if (pLed->BlinkTimes == 0)' and the asignment.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index d1406cc99768..91b0029d1179 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -188,7 +188,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 			}
-			pLed->BlinkTimes = 0;
 			pLed->bLedBlinkInProgress = false;
 		} else {
 			if (pLed->bLedOn)
-- 
2.26.0

