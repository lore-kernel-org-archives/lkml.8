Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5866AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E402071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NcxK8+6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgAXF64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 00:58:56 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37109 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbgAXF6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:58:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so586896pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 21:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wxR/qiYIDSom0PWV4vVrva6B084GXL6U/+zkJV3teo=;
        b=NcxK8+6MN3cUfobCnIfktbFLrST/L2HoA8CsczR38Si2UE+KxI1uaZF6zL63otCNMq
         S9+Sgl8hrkES2SQ3G0F17Yk6USOLnUzAmW7Ry1Uqxsv27c3ix8KBoIqJpQRmgJr98i0L
         M/WdMzTqxmLNHcvXsIcY5SzNvWO5QzGp5V0G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wxR/qiYIDSom0PWV4vVrva6B084GXL6U/+zkJV3teo=;
        b=m+fsExm7Qs9Bb742PpF7WeetAa4jA4AnF1oDGVmo1Kod0zwUvEAGfQfCarWgB3cGIJ
         9qU1rXNEFhag3RBRqKw2B/jT8d7H89YZrr5AxUPUKOLe7gq+lxGWhqScgfnTbBHIwsg0
         N64rzXM9p+RwY+zOoGTYXIA4YI/BUFCFXFWXNlszEM/q9dgeEo7Hk8xR1gCBLKhann5B
         /VO+/wfaSS7A+t5Y52YnX9LiH0FfNUu47THUU7R2I3F1FhsJcOb3FJPSV/v81HY4nmjI
         HNr+avGKrHIWmslZitsp/tQFime1VEDb82IuhKBcPm26XYBywzRiT3pU6yX4Asw6gv2L
         FQaQ==
X-Gm-Message-State: APjAAAXKVRvfji3ezT/TctauYVwfCl73TEZqaX6io8nHRVt2hUzluzoy
        Vo8WI1JnjlsnL8iQoMmOeBCbxQ==
X-Google-Smtp-Source: APXvYqznbulUOlgTHl/k+m45LcnDQc4gMiFHZPXNQmftF+uKvdJ7nzByHvE/hEDgzKdiq3UhId/+Ag==
X-Received: by 2002:a17:90b:8c6:: with SMTP id ds6mr1428654pjb.111.1579845533315;
        Thu, 23 Jan 2020 21:58:53 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c184sm4701457pfa.39.2020.01.23.21.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 21:58:52 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 3/4] alarmtimer: Make alarmtimer_get_rtcdev() a stub when CONFIG_RTC_CLASS=n
Date:   Thu, 23 Jan 2020 21:58:48 -0800
Message-Id: <20200124055849.154411-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124055849.154411-1-swboyd@chromium.org>
References: <20200124055849.154411-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The export isn't there for the stubbed version of
alarmtimer_get_rtcdev() so this won't work if someone tries to call this
function when CONFIG_RTC_CLASS=n. Export a stub function in the header
file so that callers don't have to worry about linking against this
symbol. And rtcdev isn't used outside of this ifdef so we don't need to
redefine it as NULL. Drop that because we're nearby.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/alarmtimer.h | 4 ++++
 kernel/time/alarmtimer.c   | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/alarmtimer.h b/include/linux/alarmtimer.h
index 74748e306f4b..05e758b8b894 100644
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -60,7 +60,11 @@ u64 alarm_forward(struct alarm *alarm, ktime_t now, ktime_t interval);
 u64 alarm_forward_now(struct alarm *alarm, ktime_t interval);
 ktime_t alarm_expires_remaining(const struct alarm *alarm);
 
+#ifdef CONFIG_RTC_CLASS
 /* Provide way to access the rtc device being used by alarmtimers */
 struct rtc_device *alarmtimer_get_rtcdev(void);
+#else
+static inline struct rtc_device *alarmtimer_get_rtcdev(void) { return NULL; }
+#endif
 
 #endif
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 395d4a6db1b2..36124aea8d6f 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -145,11 +145,6 @@ static void alarmtimer_rtc_interface_remove(void)
 	class_interface_unregister(&alarmtimer_rtc_interface);
 }
 #else
-struct rtc_device *alarmtimer_get_rtcdev(void)
-{
-	return NULL;
-}
-#define rtcdev (NULL)
 static inline int alarmtimer_rtc_interface_setup(void) { return 0; }
 static inline void alarmtimer_rtc_interface_remove(void) { }
 static inline void alarmtimer_rtc_timer_init(void) { }
-- 
Sent by a computer, using git, on the internet

