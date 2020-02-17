Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93440C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5104B208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ebSOobPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgBQPlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:41:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33681 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgBQPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:41:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so176780wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=556jZPK8Ln3qyMHoFnra5q+K0qfU/YwU5Nw6Aae+qSY=;
        b=ebSOobPAYTfm2SFuYNP5SBLHSOZxKMF0XUXrOnV6s6UX7fzQNW7s1ZFIPs/qhlDMKA
         aPLGSHIUH0720Ztqotj6iPs6Yme49UDIXnaup04lUoweD4a24uE2garU5w5KE1CS1DA4
         MZxD3AjAENeWCdA9LtpaNTtSrkwHpNspFMPQdEfZolIw6WD8MvM5qMltMrTFg4CwTAAa
         aP4JZjwnJqu0hFALewUWR2bCfDoGr69gP4UYaLe80B5CYgLcNxb0acndzHMcMm6phCSZ
         gBVWlzhHWdoH3FFmhmPXqzG/25RPG3awBC7oyA7Ga66em9xIsonwI5MfVZo86I70CnGd
         anAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=556jZPK8Ln3qyMHoFnra5q+K0qfU/YwU5Nw6Aae+qSY=;
        b=ucUgBDFBwKHVU3R1Bg5ymRhg1+KUBK4rYhtLhZY36cBGfKDrjD3eT3O1JnFDob52y4
         VL0ynGTrbPTbJH4LsZ/JFMNePqwMiQmh8QDLykrHeOQHa9xWGsCc9jsMN4x+M/vU9rVy
         ahHWSb1sQ+BmHT1KDFN0BvwnF2P22eEoNaL9UErnAOE3ZU6h7JBTOqRQERrfHl8z8LYh
         oH/1T7EFQ2I2k2vzmjYs7DFQbv6A2WoZGK/k550z/+ptT27XIvfNWwSN92oKf2wlxW/T
         Zz1ZabgfHiFZ/rQrkZRrqBHxHHOgK+bYbKEBo93LyOJ+yM5Q4qUSa1DuQNposBPCjDC2
         kpQA==
X-Gm-Message-State: APjAAAVv67S6w11uduZejpfeKQFSKQ/Y/KX5Fskaru4qZkAhx6mGaLf0
        GsEtRdaqaXrXKYuRbhShYHQ/Cw==
X-Google-Smtp-Source: APXvYqwp9OHTWaAU+Fqq1Q9B0XP8Yhr13ODlIppYq+8Cyk59QWRoG10yzWaBn5eWZeCNm23S6aj0iA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr22849920wmk.172.1581954074099;
        Mon, 17 Feb 2020 07:41:14 -0800 (PST)
Received: from jamesh-VirtualBox.pitowers.org ([2a00:1098:3142:14:9260:684f:13fd:35ee])
        by smtp.gmail.com with ESMTPSA id h2sm1546370wrt.45.2020.02.17.07.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 07:41:13 -0800 (PST)
From:   James Hughes <james.hughes@raspberrypi.com>
To:     eric@anholt.net, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     James Hughes <james.hughes@raspberrypi.com>
Subject: [PATCH] GPU: DRM: VC4/V3D Replace wait_for macros in to remove use of msleep
Date:   Mon, 17 Feb 2020 15:31:45 +0000
Message-Id: <20200217153145.13780-1-james.hughes@raspberrypi.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wait_for macro's for Broadcom VC4 and V3D drivers used msleep
which is inappropriate due to its inaccuracy at low values (minimum
wait time is about 30ms on the Raspberry Pi).

This patch replaces the macro with the one from the Intel i915 version
which uses usleep_range to provide more accurate waits.

Signed-off-by: James Hughes <james.hughes@raspberrypi.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h | 41 ++++++++++++++++++++++-----------
 drivers/gpu/drm/vc4/vc4_drv.h | 43 +++++++++++++++++++++--------------
 2 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 7b4f3b5a086e..069fefe16d28 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -267,27 +267,42 @@ struct v3d_csd_job {
 };
 
 /**
- * _wait_for - magic (register) wait macro
+ * __wait_for - magic wait macro
  *
- * Does the right thing for modeset paths when run under kdgb or similar atomic
- * contexts. Note that it's important that we check the condition again after
- * having timed out, since the timeout could be due to preemption or similar and
- * we've never had a chance to check the condition before the timeout.
+ * Macro to help avoid open coding check/wait/timeout patterns. Note that it's
+ * important that we check the condition again after having timed out, since the
+ * timeout could be due to preemption or similar and we've never had a chance to
+ * check the condition before the timeout.
  */
-#define wait_for(COND, MS) ({ \
-	unsigned long timeout__ = jiffies + msecs_to_jiffies(MS) + 1;	\
-	int ret__ = 0;							\
-	while (!(COND)) {						\
-		if (time_after(jiffies, timeout__)) {			\
-			if (!(COND))					\
-				ret__ = -ETIMEDOUT;			\
+#define __wait_for(OP, COND, US, Wmin, Wmax) ({ \
+	const ktime_t end__ = ktime_add_ns(ktime_get_raw(), 1000ll * (US)); \
+	long wait__ = (Wmin); /* recommended min for usleep is 10 us */	\
+	int ret__;							\
+	might_sleep();							\
+	for (;;) {							\
+		const bool expired__ = ktime_after(ktime_get_raw(), end__); \
+		OP;							\
+		/* Guarantee COND check prior to timeout */		\
+		barrier();						\
+		if (COND) {						\
+			ret__ = 0;					\
 			break;						\
 		}							\
-		msleep(1);					\
+		if (expired__) {					\
+			ret__ = -ETIMEDOUT;				\
+			break;						\
+		}							\
+		usleep_range(wait__, wait__ * 2);			\
+		if (wait__ < (Wmax))					\
+			wait__ <<= 1;					\
 	}								\
 	ret__;								\
 })
 
+#define _wait_for(COND, US, Wmin, Wmax)	__wait_for(, (COND), (US), (Wmin), \
+						   (Wmax))
+#define wait_for(COND, MS)		_wait_for((COND), (MS) * 1000, 10, 1000)
+
 static inline unsigned long nsecs_to_jiffies_timeout(const u64 n)
 {
 	/* nsecs_to_jiffies64() does not guard against overflow */
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 7956f6ed9b6a..c59be5e1d52b 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -629,32 +629,41 @@ struct vc4_validated_shader_info {
 };
 
 /**
- * _wait_for - magic (register) wait macro
+ * __wait_for - magic wait macro
  *
- * Does the right thing for modeset paths when run under kdgb or similar atomic
- * contexts. Note that it's important that we check the condition again after
- * having timed out, since the timeout could be due to preemption or similar and
- * we've never had a chance to check the condition before the timeout.
+ * Macro to help avoid open coding check/wait/timeout patterns. Note that it's
+ * important that we check the condition again after having timed out, since the
+ * timeout could be due to preemption or similar and we've never had a chance to
+ * check the condition before the timeout.
  */
-#define _wait_for(COND, MS, W) ({ \
-	unsigned long timeout__ = jiffies + msecs_to_jiffies(MS) + 1;	\
-	int ret__ = 0;							\
-	while (!(COND)) {						\
-		if (time_after(jiffies, timeout__)) {			\
-			if (!(COND))					\
-				ret__ = -ETIMEDOUT;			\
+#define __wait_for(OP, COND, US, Wmin, Wmax) ({ \
+	const ktime_t end__ = ktime_add_ns(ktime_get_raw(), 1000ll * (US)); \
+	long wait__ = (Wmin); /* recommended min for usleep is 10 us */	\
+	int ret__;							\
+	might_sleep();							\
+	for (;;) {							\
+		const bool expired__ = ktime_after(ktime_get_raw(), end__); \
+		OP;							\
+		/* Guarantee COND check prior to timeout */		\
+		barrier();						\
+		if (COND) {						\
+			ret__ = 0;					\
 			break;						\
 		}							\
-		if (W && drm_can_sleep())  {				\
-			msleep(W);					\
-		} else {						\
-			cpu_relax();					\
+		if (expired__) {					\
+			ret__ = -ETIMEDOUT;				\
+			break;						\
 		}							\
+		usleep_range(wait__, wait__ * 2);			\
+		if (wait__ < (Wmax))					\
+			wait__ <<= 1;					\
 	}								\
 	ret__;								\
 })
 
-#define wait_for(COND, MS) _wait_for(COND, MS, 1)
+#define _wait_for(COND, US, Wmin, Wmax)	__wait_for(, (COND), (US), (Wmin), \
+						   (Wmax))
+#define wait_for(COND, MS)		_wait_for((COND), (MS) * 1000, 10, 1000)
 
 /* vc4_bo.c */
 struct drm_gem_object *vc4_create_object(struct drm_device *dev, size_t size);
-- 
2.17.1

