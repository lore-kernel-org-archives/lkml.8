Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA865C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E1C20825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="P26s+koN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgH1Tww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgH1Twb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:31 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E2C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:31 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j10so186342qvo.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tJ0gOBViXeVA8sneerLluYksnQAlUcTp8XjiIkCaKF8=;
        b=P26s+koNh3LKBTyjD8sSPvL5FtNHKf9A76YCuuu2WlWHv+F0KP0FuIencydiw0znzc
         UbhiD93Ocd6+FaVLa2wZX7cl2K9gCgdI66PSVk3+SElUhCS7qkzefRMYHL2mWSOt2RkL
         zAQnhw5qzzoVFR2bdDSxTLMs8bwfcKmPwBCSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tJ0gOBViXeVA8sneerLluYksnQAlUcTp8XjiIkCaKF8=;
        b=ptGyq4C64RmRUL9TNWQmg0Skv4a5s+jX8Buvg2xgcNvJLAErR6u8ZAsdrVYGAaHAlJ
         7Oeb53hZGvX6wkrj51ycGqVqvNHyCYt2w6Exx2HrKBo/T88ay5wZQ6rZ3GmqQykU/iax
         SEldafr6btAaLzm9Jb8QXgeS1hd9eLx1cLijpzTE+9DqNeuB9xBTPMv/UZnNKK1+684R
         2M64tVVapOKAki+9zNeKoZExBDYGx7JAXQukr8a9g2uaFU2ywjJPTcm3O4WHkRg6tvb6
         3i8ghzNIlzzE4bt+UgtSJiIsSawHu6D/F2fY1dqLVrnkjdzQCwwDb34OedOmsFZ3ntxN
         +UzQ==
X-Gm-Message-State: AOAM532chGkNZPsHbf007gb+07Btp/TxaiS2GGLHmIhjeN0Z0f8XcM42
        jnqNw6RZZG8Psts1o274uaoaxA==
X-Google-Smtp-Source: ABdhPJyhpcK8ScS2UQCS3CkaF/gV6e1AFM4S2nRrnfzzIIohVO43sdk9vN/Mgc5zRr/sM13U7xDYQg==
X-Received: by 2002:a0c:8b5d:: with SMTP id d29mr175687qvc.172.1598644349971;
        Fri, 28 Aug 2020 12:52:29 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:29 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 06/23] bitops: Introduce find_next_or_bit
Date:   Fri, 28 Aug 2020 15:51:07 -0400
Message-Id: <b802d1711231deb5cd00723a2c63eada71d8b5a3.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

Hotplug fixes to core-scheduling require a new bitops API.

Introduce a new API find_next_or_bit() which returns the
bit number of the next set bit in OR-ed bit masks of the
given bit masks.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/asm-generic/bitops/find.h | 16 +++++++++
 lib/find_bit.c                    | 58 +++++++++++++++++++++++++------
 2 files changed, 63 insertions(+), 11 deletions(-)

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
index 49f875f1baf7..e36257bb0701 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -19,7 +19,16 @@
 
 #if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
 	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
-	!defined(find_next_and_bit)
+	!defined(find_next_and_bit) || !defined(find_next_or_bit)
+
+/*
+ * find_next_bit bitwise operation types
+ */
+enum fnb_bwops_type {
+	FNB_AND = 0,
+	FNB_OR  = 1
+};
+
 /*
  * This is a common helper function for find_next_bit, find_next_zero_bit, and
  * find_next_and_bit. The differences are:
@@ -29,7 +38,8 @@
  */
 static unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
+		unsigned long start, unsigned long invert,
+		enum fnb_bwops_type type, unsigned long le)
 {
 	unsigned long tmp, mask;
 
@@ -37,8 +47,16 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
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
@@ -56,8 +74,16 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
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
 
@@ -75,7 +101,7 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, FNB_AND, 0);
 }
 EXPORT_SYMBOL(find_next_bit);
 #endif
@@ -84,7 +110,7 @@ EXPORT_SYMBOL(find_next_bit);
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, FNB_AND, 0);
 }
 EXPORT_SYMBOL(find_next_zero_bit);
 #endif
@@ -94,11 +120,21 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
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
@@ -161,7 +197,7 @@ EXPORT_SYMBOL(find_last_bit);
 unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, FNB_AND, 1);
 }
 EXPORT_SYMBOL(find_next_zero_bit_le);
 #endif
@@ -170,7 +206,7 @@ EXPORT_SYMBOL(find_next_zero_bit_le);
 unsigned long find_next_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, FNB_AND, 1);
 }
 EXPORT_SYMBOL(find_next_bit_le);
 #endif
-- 
2.17.1

