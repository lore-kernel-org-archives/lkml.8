Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A2AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4228521473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOHqZG5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgDTNrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728633AbgDTNrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:47:00 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AEBC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:46:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id g30so4965178pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2ye63/S6Lz/zFEjTlSZ5tXRcsKe+oxNcP2htE8RYF4=;
        b=EOHqZG5HDsWj1pX7eAu15S+Na0C0+2gIjJ3Gqh44ASXY86SITSXxPYdXl3f5lMHFYb
         vRUcuEBDYyNpVAbkTYz/pb42HnoUdjmeUgPi4uCESD0+QNOxqsk6Yx+oBAm6HOlTsI5/
         xQkHqi82zMX4MQjWdhcEqm1fJpABIpOIYgu+Y1xYiZUHNnQRHQIZQb7G3DFo/DJu/PxX
         8N8giBAk/FDhukW4jCruQD909i/pkrZPTCC263Yw4VAIWqoqWWF71ferxhO9WGbNUkYO
         3JsnXQsYI9PNQr0Aw7hHJEAjh/VBYnQUHomVNKCRqlcOBEBIbSqdM4rCAkpBhQ++A1Jc
         k9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2ye63/S6Lz/zFEjTlSZ5tXRcsKe+oxNcP2htE8RYF4=;
        b=R8INdLzBQS19bsCLWrwDALmqzChJU2niwJDoLLrSUmIMH0oose+V5KuccJT1oCpW0M
         Y/oJOmtq8LzWfw67hQoVRoqzPr/EvgaG59wveIeCifmM85bVQwpp5FF4M5dknwJre2v+
         0ufqocpboH3nAcBS9fNnoMWTKezW4BLhFBG4OP+xMujZl+m/+3Ybz+/Jutv5YcQV9GPp
         oSXxilsVbEwmGo/kceWi5WE7tS8ff61eDJg93mmosloWD8T614dJbHf+WT15J6lP7c2M
         a9m/y9+XzKJA7IAyYU62PhketFq64BsCSMwovkxvmwo63rEzPmRnhBhJivFvlXLl2qdo
         Bp0A==
X-Gm-Message-State: AGi0PuZFv0aLenfb4Bgqw973y8ITuNXsUSU7xksgcotM0apWTKhCFFhe
        Wuv9O+sp5ujk8JoozRdKs8Q=
X-Google-Smtp-Source: APiQypLnHRU5ZOxZJIoEbGVKMX+6LC/FekS9VzSNqMtEtlFWpWc9c4S55BBJnxwdnhUQfJ71Dx6Ixg==
X-Received: by 2002:a62:1950:: with SMTP id 77mr16774806pfz.326.1587390419535;
        Mon, 20 Apr 2020 06:46:59 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
        by smtp.gmail.com with ESMTPSA id e135sm1117203pfh.37.2020.04.20.06.46.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 06:46:59 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     broonie@kernel.org
Cc:     Markus.Elfring@web.de, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2 1/2] regmap: Simplify implementation of the regmap_read_poll_timeout() macro
Date:   Mon, 20 Apr 2020 21:46:46 +0800
Message-Id: <20200420134647.9121-2-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200420134647.9121-1-zhengdejin5@gmail.com>
References: <20200420134647.9121-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the implementation of the macro regmap_read_poll_timeout()
by using the macro read_poll_timeout().

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v1 -> v2:
	- modify the commit comments by Markus's suggestion .

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

