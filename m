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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F3DC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106E8206F9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOanMSm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgDSNwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDSNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:52:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A42C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:52:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a32so3350816pje.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhTS4tSvEeXvCLcgGfGf9aL3CMO3Qt9fZyLFwhxCOiU=;
        b=fOanMSm4AgQ22mXAc6DFchfc3BNTM6NWPcbni7P3DuXg5x/ziJkh7IiD4X5JvPxwg7
         f0QYdVge00ir/soYAMPRUSgXEq87TdpLojVq52f5YCMt8d3bqA0W1Z0ypGYce5EmJN6i
         heiAhRMgHaqFfAm0b5GZtFqBrFDh7gkLWZ8fErMV6GduA4WoNyBIGM9wGxqgB/XjKgms
         x/NfrROozqFpN44bwDR1GlKEWM11ulF/pz89w0YWVzOgXuc276OQJuWqJ+8Ca2rS4YdQ
         Pu4xE405KLgHSjMwP8YnMgwXZmazFN/pECaVMonlW1CKTYPHMxAYh/d+T2LBUUhwdsGD
         7wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhTS4tSvEeXvCLcgGfGf9aL3CMO3Qt9fZyLFwhxCOiU=;
        b=LPmLTrHikbIu//4eeqhbpewTZc2a+q1N55GnKQGosgAuTmFlD/cHIConSG23Ue+eVd
         lRqZ8TpOZ6nZXYzxBThVtAtFCL1+SQuBoz5w3LoPJjuGCR+Er3Lz70XhXGi9HspVjdBb
         oclrT5UuCYPSliiUqP6TiWQqs+byTlSNIbnPph6kLNiqzz9PdlPy6Vqs7v/Ai2i6a5mR
         /xFCJYp9eYkvlx9L6ABVEWuDOE00w4LOJFugx+HkTzlwbYbLoer/k44PMHkUwnO+AjDJ
         7iEo214DjcZvUgD4HQSaAnVGzpbL0OyyevFzyx15qfbvHv0TStkqVehlERgfLoMar1Qe
         gELQ==
X-Gm-Message-State: AGi0PuZz+aKGQ8cXv/mH6V98LEkHWELwyT2rlaK5EuJ4AiD7aOgikMQi
        05/k34vCNhg34S9EdwoFpoY=
X-Google-Smtp-Source: APiQypJidWox50JWLdcpowaQ0SYcZ7yYEH/C1sgQPKIYOaweKdbnCExPHXo53EvLxT2oMo+I4jHodQ==
X-Received: by 2002:a17:90b:4c45:: with SMTP id np5mr15845394pjb.19.1587304342812;
        Sun, 19 Apr 2020 06:52:22 -0700 (PDT)
Received: from localhost ([89.208.244.140])
        by smtp.gmail.com with ESMTPSA id gv7sm7488007pjb.16.2020.04.19.06.52.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 06:52:22 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1 1/2] regmap: redefined regmap_read_poll_timeout to simplify code
Date:   Sun, 19 Apr 2020 21:51:49 +0800
Message-Id: <20200419135150.14741-2-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200419135150.14741-1-zhengdejin5@gmail.com>
References: <20200419135150.14741-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use read_poll_timeout macro to redefined regmap_read_poll_timeout
and also remove the duplicate code.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 include/linux/regmap.h | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 40b07168fd8e..299c1f6a03b4 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/bug.h>
 #include <linux/lockdep.h>
+#include <linux/iopoll.h>
 
 struct module;
 struct clk;
@@ -122,26 +123,10 @@ struct reg_sequence {
  */
 #define regmap_read_poll_timeout(map, addr, val, cond, sleep_us, timeout_us) \
 ({ \
-	u64 __timeout_us = (timeout_us); \
-	unsigned long __sleep_us = (sleep_us); \
-	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
-	int __ret; \
-	might_sleep_if(__sleep_us); \
-	for (;;) { \
-		__ret = regmap_read((map), (addr), &(val)); \
-		if (__ret) \
-			break; \
-		if (cond) \
-			break; \
-		if ((__timeout_us) && \
-		    ktime_compare(ktime_get(), __timeout) > 0) { \
-			__ret = regmap_read((map), (addr), &(val)); \
-			break; \
-		} \
-		if (__sleep_us) \
-			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
-	} \
-	__ret ?: ((cond) ? 0 : -ETIMEDOUT); \
+	int __ret, __tmp; \
+	__tmp = read_poll_timeout(regmap_read, __ret, __ret || (cond), \
+			sleep_us, timeout_us, false, (map), (addr), &(val)); \
+	__ret ?: __tmp; \
 })
 
 /**
-- 
2.25.0

