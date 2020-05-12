Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5936C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7A9206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgELOht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbgELOhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:37:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BADC061A0C;
        Tue, 12 May 2020 07:37:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1m-0005oT-Hm; Tue, 12 May 2020 16:37:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 28DED1C02FC;
        Tue, 12 May 2020 16:36:57 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:57 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] arm64: csum: Disable KASAN for do_csum()
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-10-will@kernel.org>
References: <20200511204150.27858-10-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421706.390.7180347611312601499.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     5a7d7f5d57f61d650619b89c1b7d4adcf4fdecfe
Gitweb:        https://git.kernel.org/tip/5a7d7f5d57f61d650619b89c1b7d4adcf4fdecfe
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:13 +02:00

arm64: csum: Disable KASAN for do_csum()

do_csum() over-reads the source buffer and therefore abuses
READ_ONCE_NOCHECK() on a 128-bit type to avoid tripping up KASAN. In
preparation for READ_ONCE_NOCHECK() requiring an atomic access, and
therefore failing to build when fed a '__uint128_t', annotate do_csum()
explicitly with '__no_sanitize_address' and fall back to normal loads.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/20200511204150.27858-10-will@kernel.org

---
 arch/arm64/lib/csum.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/lib/csum.c b/arch/arm64/lib/csum.c
index 60eccae..78b87a6 100644
--- a/arch/arm64/lib/csum.c
+++ b/arch/arm64/lib/csum.c
@@ -14,7 +14,11 @@ static u64 accumulate(u64 sum, u64 data)
 	return tmp + (tmp >> 64);
 }
 
-unsigned int do_csum(const unsigned char *buff, int len)
+/*
+ * We over-read the buffer and this makes KASAN unhappy. Instead, disable
+ * instrumentation and call kasan explicitly.
+ */
+unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
 {
 	unsigned int offset, shift, sum;
 	const u64 *ptr;
@@ -42,7 +46,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
 	 * odd/even alignment, and means we can ignore it until the very end.
 	 */
 	shift = offset * 8;
-	data = READ_ONCE_NOCHECK(*ptr++);
+	data = *ptr++;
 #ifdef __LITTLE_ENDIAN
 	data = (data >> shift) << shift;
 #else
@@ -58,10 +62,10 @@ unsigned int do_csum(const unsigned char *buff, int len)
 	while (unlikely(len > 64)) {
 		__uint128_t tmp1, tmp2, tmp3, tmp4;
 
-		tmp1 = READ_ONCE_NOCHECK(*(__uint128_t *)ptr);
-		tmp2 = READ_ONCE_NOCHECK(*(__uint128_t *)(ptr + 2));
-		tmp3 = READ_ONCE_NOCHECK(*(__uint128_t *)(ptr + 4));
-		tmp4 = READ_ONCE_NOCHECK(*(__uint128_t *)(ptr + 6));
+		tmp1 = *(__uint128_t *)ptr;
+		tmp2 = *(__uint128_t *)(ptr + 2);
+		tmp3 = *(__uint128_t *)(ptr + 4);
+		tmp4 = *(__uint128_t *)(ptr + 6);
 
 		len -= 64;
 		ptr += 8;
@@ -85,7 +89,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
 		__uint128_t tmp;
 
 		sum64 = accumulate(sum64, data);
-		tmp = READ_ONCE_NOCHECK(*(__uint128_t *)ptr);
+		tmp = *(__uint128_t *)ptr;
 
 		len -= 16;
 		ptr += 2;
@@ -100,7 +104,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
 	}
 	if (len > 0) {
 		sum64 = accumulate(sum64, data);
-		data = READ_ONCE_NOCHECK(*ptr);
+		data = *ptr;
 		len -= 8;
 	}
 	/*
