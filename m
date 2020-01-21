Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4517C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C2A21835
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="egYkuTZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAUTsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:48:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45967 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgAUTsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:48:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so2039312pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KVUuHS8j8qP6vbkik8K3geWbDTbCR+aoBmPYq95z0cM=;
        b=egYkuTZL1depEEQib24k5h3ddHSXD1ZZlZmsByYcjmpeWtPWJKRCsfkAigbW3ZrMH5
         cxHgbl5tkBkXSRSjmZN1foxKsA8XvXIbNX4MuIz7PCENX+gBaQatGtQXEpg5RJP0wsvK
         H/Vdf/2gwENuZw8QwAgUzXGsF0je1NpoMOikQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KVUuHS8j8qP6vbkik8K3geWbDTbCR+aoBmPYq95z0cM=;
        b=QbgQA3uOVQ0EbW6zvjCGjUIHbS8MQukKc8B+V+cRWFOoTg/KmM9TQfzHx9+30gkScx
         ReWHC6vIV57pZBJAawDxC12JYBUIU9L+u869dRrlG4HPt4ORxrfNgIsi+gY6ee5rfwCy
         knZGUCxdZ5G1wjrVx0S//NZLD1R99FHn+5XWhn0BasctGkUPBs3j76Zfz+cmPh4M86Oy
         iz9MU60idTFNI4BkhC/S6pPfu1k3joJsXCxaKOz8vK+bj20fcgHxMlZG0/9JceZO4FAF
         QjaOj183uY4KlJGoLUOCN0jwTvZzUO6a6kWYxBA3HuvEOBydtd69wmz3yCaGLJ+GKHhZ
         siDA==
X-Gm-Message-State: APjAAAWXyuuBrH43T9z1aTuIjZXJ+cv8j+RvHRtlqvscRoU/VHenqx3W
        IbsaFYp3hOtKFCQNfhSybgPEQS/9c7R7/A==
X-Google-Smtp-Source: APXvYqzO+XtZ0RlmgKs9cHH7F+QWjjr+y7ahjfy+81ySWmFPSkrAtbzOuIa/bjlCqD9Xq8MhxSvKTw==
X-Received: by 2002:a63:d411:: with SMTP id a17mr7532269pgh.333.1579636094783;
        Tue, 21 Jan 2020 11:48:14 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u7sm44004674pfh.128.2020.01.21.11.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 11:48:14 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 3/3] alarmtimer: Always export alarmtimer_get_rtcdev() and update docs
Date:   Tue, 21 Jan 2020 11:48:11 -0800
Message-Id: <20200121194811.145644-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200121194811.145644-1-swboyd@chromium.org>
References: <20200121194811.145644-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The export isn't there for the stubbed version of
alarmtimer_get_rtcdev(), so move the export outside of the ifdef. And
rtcdev isn't used outside of this ifdef so we don't need to redefine it
as NULL.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/time/alarmtimer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 0c9e97054da8..6ea08fa62c46 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -67,8 +67,6 @@ static DEFINE_SPINLOCK(rtcdev_lock);
  * alarmtimer_get_rtcdev - Return selected rtcdevice
  *
  * This function returns the rtc device to use for wakealarms.
- * If one has not already been chosen, it checks to see if a
- * functional rtc device is available.
  */
 struct rtc_device *alarmtimer_get_rtcdev(void)
 {
@@ -81,7 +79,6 @@ struct rtc_device *alarmtimer_get_rtcdev(void)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
 
 static int alarmtimer_rtc_add_device(struct device *dev,
 				struct class_interface *class_intf)
@@ -149,11 +146,11 @@ struct rtc_device *alarmtimer_get_rtcdev(void)
 {
 	return NULL;
 }
-#define rtcdev (NULL)
 static inline int alarmtimer_rtc_interface_setup(void) { return 0; }
 static inline void alarmtimer_rtc_interface_remove(void) { }
 static inline void alarmtimer_rtc_timer_init(void) { }
 #endif
+EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
 
 /**
  * alarmtimer_enqueue - Adds an alarm timer to an alarm_base timerqueue
-- 
Sent by a computer, using git, on the internet

