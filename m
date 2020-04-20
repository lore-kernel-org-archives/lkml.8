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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AF9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7875420857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMpvQ8rf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgDTNrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728700AbgDTNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:47:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF8C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:47:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so3975063plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqScG+BXKtQJhW4TX1nkkxZN9LafUmgEzd1adCi/2tc=;
        b=ZMpvQ8rf98UNqU8Cn6FswuUbu+1rV+dOyCH/w0/Pr/qjGmIQCmbkzTJ+Z79VtQ7o64
         b52x2OGcVBD0Q1lJzPzhh0UQbwf1d1C6tZPI1oDohY1ZrznYeCmEf2YB3aLJI0oufe7u
         97C02eLRWWmClKGvZjAgplz11PsskKLt5Z9C9KANt8ehgFJB7L/yoYDkxYawp2q2RctT
         WnPOzWFyrlzy2MCwQ9qYlqm3GskOJ0j0kGos2u2Wt/TuKeUHeYHIKMZqaSjEtRjU8Fy0
         mjWTvxex+rAfG7zXJcOu5xsBjsDb/IG7rIZsODLyr9tCw2oKYQKkumO9vAP9NOYnf97p
         aRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqScG+BXKtQJhW4TX1nkkxZN9LafUmgEzd1adCi/2tc=;
        b=kUTer66S6Pn6LE9IQO0fBOXftO76yMHI1dScUyfAZUfH1X5oGPE4/lWBiNzBAYQOta
         fGQTZq5u9sRaccnKhw02KRzFvBSkqdHEa96AH4P2FsqtkrgDB+rvLy1bA9RS2Wzjt/XG
         tFhnZOizbMSD0OwR6/TtBHarHy2I4y+X5WfQMDvU98DkgYkoa1Uavb0OOaFUYH64IWsy
         qnbEz0H04+znjsDzxrkc6frgjwHKw3qf1rVE6CJVgYsvznWHGV26F2KJIN0nG0BSouBt
         Ur/+DQZnKwIa5338OrUQBw5MlTi3GSvVAeAx/TUVjH72lscEV4WqJu3tRVINY/DthXd6
         nwRA==
X-Gm-Message-State: AGi0PuYqt8ADDwWwcVlClb8JEVNg7ic9B300uphZwuVUXAl9uVohe3/p
        PFBpW1zLmylV/fj6Ayt82qY=
X-Google-Smtp-Source: APiQypJUfrqKjyg0yehiSqaR9Wab6FClM7I/XABuD9X4NZFOgwaA+sNuh7pYZKDS+aFKMtdeM6rclA==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr4440925plt.125.1587390424127;
        Mon, 20 Apr 2020 06:47:04 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
        by smtp.gmail.com with ESMTPSA id g43sm1204584pje.22.2020.04.20.06.47.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 06:47:03 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     broonie@kernel.org
Cc:     Markus.Elfring@web.de, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2 2/2] regmap: Simplify implementation of the regmap_field_read_poll_timeout() macro
Date:   Mon, 20 Apr 2020 21:46:47 +0800
Message-Id: <20200420134647.9121-3-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200420134647.9121-1-zhengdejin5@gmail.com>
References: <20200420134647.9121-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the implementation of the macro regmap_field_read_poll_timeout()
by using the macro read_poll_timeout().

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v1 -> v2:
	- modify the commit comments by Markus's suggestion .

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

