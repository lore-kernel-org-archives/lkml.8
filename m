Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9948EC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3CB2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSw3k9wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgCSQjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:39:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32769 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgCSQjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:39:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id g18so1299992plq.0;
        Thu, 19 Mar 2020 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIOrAz7GYY9BuUWfyHF9ZU9TNfY9N9kF9Mf7NlZDeIY=;
        b=aSw3k9wmhBSHFDOn9LsVwhHqjMRxYp8kV4MESuSFSPRnBTGkImpzoLiOlUfeHbe2bS
         VV0YET9VuTCx926Umm69jrhSJq3rV9jzdOxHd+FWTET8KZ27pklfMuNmHi06UnHLeMVd
         VmBqTKgtuxp9qUeh7KaxFsgWcfT5QOv+YOboMLdSLnbBVHkdY7oQnIY4zEuQXuaDzrEG
         VadX/FJ/6lHNxWiRNr1ngtOuf/u6VjVELWChKPpIyULGbSUt16zlNmiIh+oFDmYjzFVT
         ZdFnTuGgBUf5Rw4TDL7RdgJAL4ZUTebyEpcLuk6vGdN2D+SkLXxtdViM8w023XIjGFkW
         5dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIOrAz7GYY9BuUWfyHF9ZU9TNfY9N9kF9Mf7NlZDeIY=;
        b=jVG4/VqJo53RFOIEzJg4Jqpa6W6Ixl4xwbzMsXiEJP/aQSIMeMMMz+5Ste1oHjIw4d
         IVqxRq5qix6SlYme3Ffeaq9eKUwhvqzuXJibL38wW9EX3bKw2vIkDpy1QpWmwylKqd5R
         EUe8VMwvsFSJQAloz2EQDQL8f3scUBRg6zHsebGvMvbediAEvVA28Oi9ZLw8YnyQXBRx
         2K+A7NDCFn0zU1Yfsb8LMRT+3wDydMvcNsug0ZQHk3YS4AuKyVhZsCEvcovkMHbmoDvv
         0ACilhd3B3X7QdGCFueIWg7NuUqcLXJ/NrsRjoMQHbm/KsU6VzfB41Tmzb/r52f0AOWT
         FQ4A==
X-Gm-Message-State: ANhLgQ1NJZCJfpx8X9ZiCHqd5XfSDqvVJjPpiyslkfBBDiQ4cMoPWPXv
        ap08ikOJ+ZAY0HJm3nqG34M=
X-Google-Smtp-Source: ADFU+vs2WI3MCtHKvLLxzn/ayW/c2E1ZPoYet2xfUCmahTxR5QzZM7511S11ejkw4tNAeLoLQiTipw==
X-Received: by 2002:a17:90a:8d05:: with SMTP id c5mr4748358pjo.110.1584635990464;
        Thu, 19 Mar 2020 09:39:50 -0700 (PDT)
Received: from localhost (216.24.188.11.16clouds.com. [216.24.188.11])
        by smtp.gmail.com with ESMTPSA id u14sm2875267pgg.67.2020.03.19.09.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 09:39:50 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, tglx@linutronix.de,
        broonie@kernel.org, corbet@lwn.net, mchehab+samsung@kernel.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH net-next 2/7] iopoll: redefined readx_poll_timeout macro to simplify the code
Date:   Fri, 20 Mar 2020 00:39:05 +0800
Message-Id: <20200319163910.14733-3-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200319163910.14733-1-zhengdejin5@gmail.com>
References: <20200319163910.14733-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

redefined readx_poll_timeout macro by read_poll_timeout to
simplify the code.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 include/linux/iopoll.h | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 7d44a2e20267..29c016cd6249 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -72,25 +72,7 @@
  * macros defined below rather than this macro directly.
  */
 #define readx_poll_timeout(op, addr, val, cond, sleep_us, timeout_us)	\
-({ \
-	u64 __timeout_us = (timeout_us); \
-	unsigned long __sleep_us = (sleep_us); \
-	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
-	might_sleep_if((__sleep_us) != 0); \
-	for (;;) { \
-		(val) = op(addr); \
-		if (cond) \
-			break; \
-		if (__timeout_us && \
-		    ktime_compare(ktime_get(), __timeout) > 0) { \
-			(val) = op(addr); \
-			break; \
-		} \
-		if (__sleep_us) \
-			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
-	} \
-	(cond) ? 0 : -ETIMEDOUT; \
-})
+	read_poll_timeout(op, val, cond, sleep_us, timeout_us, addr)
 
 /**
  * readx_poll_timeout_atomic - Periodically poll an address until a condition is met or a timeout occurs
-- 
2.25.0

