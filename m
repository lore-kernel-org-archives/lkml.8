Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C637DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B599208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229771;
	bh=tpwiFonkVii08Wax+QRh0gYMppP9Z3QZFEwANTYrstU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n8z0Q7v22Ip9wxzcCb2SeOXo++RKWHN/4X3+8xTfasNn1g3GL+FMf2Q8YhDAQUi/J
	 JVhSCiADkQnTUSqrn9/9WCYfk28H9/BT6XQQBatGyi3/ZsiXB7a7WL8zCq+td5UieX
	 ZQrFlM+2bC44rIsCXc2w3o0TptcRPB+pkzBEE+4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgEKUmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731845AbgEKUms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:48 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A5C920661;
        Mon, 11 May 2020 20:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229767;
        bh=tpwiFonkVii08Wax+QRh0gYMppP9Z3QZFEwANTYrstU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZVwBbiXz8kJHZ9kzAeBBlFcac9l8eIeNc1Fex6FAlOi9trBR3AE7TC/gL17puZP4
         DHywMoKT8YOMzxr8zLoCN4ytT58gL8M9laHXMkriydGhdTWSea40Asx4rFro624iKy
         2ieWVS2OWPepoBLfsLGJiRM3imwJnt/6tr1vD2iY=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 09/18] arm64: csum: Disable KASAN for do_csum()
Date:   Mon, 11 May 2020 21:41:41 +0100
Message-Id: <20200511204150.27858-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_csum() over-reads the source buffer and therefore abuses
READ_ONCE_NOCHECK() on a 128-bit type to avoid tripping up KASAN. In
preparation for READ_ONCE_NOCHECK() requiring an atomic access, and
therefore failing to build when fed a '__uint128_t', annotate do_csum()
explicitly with '__no_sanitize_address' and fall back to normal loads.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/lib/csum.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/lib/csum.c b/arch/arm64/lib/csum.c
index 60eccae2abad..78b87a64ca0a 100644
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
-- 
2.26.2.645.ge9eca65c58-goog

