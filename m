Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEE8C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7E12053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="T3NVoYc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgHOWCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgHOVvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:22 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD0C061378
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 62so10193588qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ropbXLmQVQLM4HRBV4KUOHOQ9FtvbqlRpYjRFgviYHA=;
        b=T3NVoYc8bWCtji6Ke4d8PuhZQgU5UXRz3E6yI6gJyHrCwafzlXCwOvFqlh6KWH2Sfc
         mYWnDwj+LJkamj9/sjoaEp+OI5vvIjOpev6t1S+yYDtIaag/kFvOvDWHHKASOgzOrDCq
         Fh7NbNuXyUHB+qoMVL2G1g+c6KsDjdaPBaI0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ropbXLmQVQLM4HRBV4KUOHOQ9FtvbqlRpYjRFgviYHA=;
        b=G5pJOsgMqeI+7KghjqUnekK9BZ6c6S9KuWyz/ID9nd2HamiJMD7dAdH9dwF+dXOW+X
         CvvNQjdD4EyTO5AeLP6vQ7Wnn6cnFltpIbAWb7dIfSSqGk1N9/rq12l7dMfKk1VzFiuD
         Cm9lDgA1ghLhpMICxOI/FT0xKnBOSMLqqKcu7gOV9ERLeZZlsFz1LWrqsOm9l+gO9sZ+
         UV0ZVdwi20S5wVhOBchWDI5V3jLeiy2B4RtDkxMbLCzvXsvbYr9U7ABP2BaQV64ipdQn
         ArBvJzb0dQTEaJ5663U9L36H8Pk6sd7bMu7mY7qOhWuj7qHzNQJClKM2QPWzkL6nusFo
         j1ew==
X-Gm-Message-State: AOAM5307gFBfAgWSCIg9wkEhZGFrMVwCiPeoIBzRELAM2BL9OOrErpoL
        PZJrsSzRB+hvkyB8uKUuqBTFmxXdsLuxjw==
X-Google-Smtp-Source: ABdhPJwjPW9fxFWSLRpBGwiHQHtdcW4BU3aoBD+vhjMsZgIL9oGfFRmbWCxzCNaLbobeUfrelvxysw==
X-Received: by 2002:a05:620a:1424:: with SMTP id k4mr4772841qkj.2.1597461570404;
        Fri, 14 Aug 2020 20:19:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:30 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RFC 07/12] bitops: Introduce find_next_or_bit
Date:   Fri, 14 Aug 2020 23:19:03 -0400
Message-Id: <20200815031908.1015049-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

Hotplug fixes to core-scheduling require a new bitops API.

Introduce a new API find_next_or_bit() which returns the bit number of
the next set bit in OR-ed bit masks of the given bit masks.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/asm-generic/bitops/find.h | 16 +++++++++
 lib/find_bit.c                    | 56 +++++++++++++++++++++++++------
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 9fdf21302fdf..0b476ca0d665 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -32,6 +32,22 @@ extern unsigned long find_next_and_bit(const unsigned long *addr1,
 		unsigned long offset);
 #endif
 
+#ifndef find_next_or_bit
+/**
+ * find_next_or_bit - find the next set bit in any memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+extern unsigned long find_next_or_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset);
+#endif
+
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 49f875f1baf7..2eca8e2b16b1 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -19,7 +19,14 @@
 
 #if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
 	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
-	!defined(find_next_and_bit)
+	!defined(find_next_and_bit) || !defined(find_next_or_bit)
+
+typedef enum {
+	FNB_AND = 0,
+	FNB_OR  = 1,
+	FNB_MAX = 2
+} fnb_bwops_t;
+
 /*
  * This is a common helper function for find_next_bit, find_next_zero_bit, and
  * find_next_and_bit. The differences are:
@@ -29,7 +36,8 @@
  */
 static unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
+		unsigned long start, unsigned long invert,
+		fnb_bwops_t type, unsigned long le)
 {
 	unsigned long tmp, mask;
 
@@ -37,8 +45,16 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
 		return nbits;
 
 	tmp = addr1[start / BITS_PER_LONG];
-	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
+	if (addr2) {
+		switch (type) {
+		case FNB_AND:
+			tmp &= addr2[start / BITS_PER_LONG];
+			break;
+		case FNB_OR:
+			tmp |= addr2[start / BITS_PER_LONG];
+			break;
+		}
+	}
 	tmp ^= invert;
 
 	/* Handle 1st word. */
@@ -56,8 +72,16 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
 			return nbits;
 
 		tmp = addr1[start / BITS_PER_LONG];
-		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
+		if (addr2) {
+			switch (type) {
+			case FNB_AND:
+				tmp &= addr2[start / BITS_PER_LONG];
+				break;
+			case FNB_OR:
+				tmp |= addr2[start / BITS_PER_LONG];
+				break;
+			}
+		}
 		tmp ^= invert;
 	}
 
@@ -75,7 +99,7 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, FNB_AND, 0);
 }
 EXPORT_SYMBOL(find_next_bit);
 #endif
@@ -84,7 +108,7 @@ EXPORT_SYMBOL(find_next_bit);
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, FNB_AND, 0);
 }
 EXPORT_SYMBOL(find_next_zero_bit);
 #endif
@@ -94,11 +118,21 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
 {
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, FNB_AND, 0);
 }
 EXPORT_SYMBOL(find_next_and_bit);
 #endif
 
+#if !defined(find_next_or_bit)
+unsigned long find_next_or_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, FNB_OR, 0);
+}
+EXPORT_SYMBOL(find_next_or_bit);
+#endif
+
 #ifndef find_first_bit
 /*
  * Find the first set bit in a memory region.
@@ -161,7 +195,7 @@ EXPORT_SYMBOL(find_last_bit);
 unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, FNB_AND, 1);
 }
 EXPORT_SYMBOL(find_next_zero_bit_le);
 #endif
@@ -170,7 +204,7 @@ EXPORT_SYMBOL(find_next_zero_bit_le);
 unsigned long find_next_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, FNB_AND, 1);
 }
 EXPORT_SYMBOL(find_next_bit_le);
 #endif
-- 
2.28.0.220.ged08abb693-goog

