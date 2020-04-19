Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E1AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91ED21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRhthNtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgDSNw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDSNw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:52:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE444C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:52:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ng8so3359606pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KvwUGLTJsZkE+PS31HMvCAdmIiAd4FHl89Kgjxz2Vs=;
        b=WRhthNtV8KSgK3zWkw8KaxMpRJgypCyqPK4kd+aXeNMMY/hISM2ls2AF3BYGaViR1m
         UiZnnSSMTuGEJ1F033u+U4tqx4Z9c/X5/4uGefnHkxr9Scmq1nZXljOVV9f+au5wM1Fa
         yuvtb2ugwyZwFWquqqnTWlB9fogB5Qwj/tbAZSiO7O1fu+/u+WQNZlrxv3lAbhvsTbOt
         4USU+qAhwOu65Qaotuj6fyDQGkoM2ERNeIzrLw+3xoBokBKcYfKgpIMw5ju+S8+00Ae5
         uTSXRMeTIjqKwZYvAnXEMk5ptISWxKU4cQgzjL9s42AX1Q2gXRWfm4XsOc3PM3XWUmaG
         TmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KvwUGLTJsZkE+PS31HMvCAdmIiAd4FHl89Kgjxz2Vs=;
        b=Xj459OuKT+r0xYtP6B364AESwPxPEabA0bb3mOxWIXxnNh4c5lM5QnEVpRqagDYlmD
         b1nghA6zcFFg3XBEke+lca7EoQ2yHEyBUYFb8+byQ7HY82JYXH3xcVUqsFTy4swk7FUt
         UV7ONh7M+cwZ5cMvDXqgcvF3xzdea8MrZpVz5nZUcoz4VTYq6lSR8+3noUxGqUO26EoW
         7KjHRnCvoqtJefeHtvhGAamKPSAbDSUrdgWHaF3ByIYsjF+0EQs2wTSWTILr8OLfdNRS
         tFCEOgcvFD8ZRAzdImZnYV5P1pMVRyZjaOXGrYRWlT/5cXfYwSKhTjDUeTIkX50c8ApL
         0TGA==
X-Gm-Message-State: AGi0PuaNU4+INJ7nObTHdxriLvZ2BFu7NqnAV1oLM7tZim9kzuPnyWmJ
        AH6n5JK+JOt8r9dkNFQYrGM=
X-Google-Smtp-Source: APiQypK36DgxC21J2zuJAJN85JDNDyqQqSXoPekv2SgtOqL+EsKSRIXbzcL9Duf0PoUYC3o/DVttjQ==
X-Received: by 2002:a17:90a:f995:: with SMTP id cq21mr8731630pjb.56.1587304348552;
        Sun, 19 Apr 2020 06:52:28 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
        by smtp.gmail.com with ESMTPSA id r63sm25456526pfr.42.2020.04.19.06.52.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 06:52:28 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1 2/2] regmap: redefined regmap_field_read_poll_timeout to simplify code
Date:   Sun, 19 Apr 2020 21:51:50 +0800
Message-Id: <20200419135150.14741-3-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200419135150.14741-1-zhengdejin5@gmail.com>
References: <20200419135150.14741-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use read_poll_timeout macro to redefined regmap_field_read_poll_timeout
and also remove the duplicate code.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 include/linux/regmap.h | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 299c1f6a03b4..78ddf224f988 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -194,25 +194,10 @@ struct reg_sequence {
  */
 #define regmap_field_read_poll_timeout(field, val, cond, sleep_us, timeout_us) \
 ({ \
-	u64 __timeout_us = (timeout_us); \
-	unsigned long __sleep_us = (sleep_us); \
-	ktime_t timeout = ktime_add_us(ktime_get(), __timeout_us); \
-	int pollret; \
-	might_sleep_if(__sleep_us); \
-	for (;;) { \
-		pollret = regmap_field_read((field), &(val)); \
-		if (pollret) \
-			break; \
-		if (cond) \
-			break; \
-		if (__timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
-			pollret = regmap_field_read((field), &(val)); \
-			break; \
-		} \
-		if (__sleep_us) \
-			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
-	} \
-	pollret ?: ((cond) ? 0 : -ETIMEDOUT); \
+	int __ret, __tmp; \
+	__tmp = read_poll_timeout(regmap_field_read, __ret, __ret || (cond), \
+			sleep_us, timeout_us, false, (field), &(val)); \
+	__ret ?: __tmp; \
 })
 
 #ifdef CONFIG_REGMAP
-- 
2.25.0

