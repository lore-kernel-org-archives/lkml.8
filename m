Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94408C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648AC20724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587482164;
	bh=YVIscHMOrTaQHoHxqIyKIGGcJUXzpYR5yik6aJPF/Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IAOpOM0WcSnnp1ThQkuiQnUXjzmoYYUMktv468YjdbvJ/H5kA+Kx5aKsztFwWigPI
	 RtIDH4AtjR0+eWb0Spk7b08WzuQ4LughpLSJDtU+KyCO+ypCGBYjb811j5HpkHOOGZ
	 e9U92Ip8RjtU191ymFeBKwa0egg3p7PuPzmggiL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgDUPQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgDUPQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:16:01 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9071C2070B;
        Tue, 21 Apr 2020 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587482160;
        bh=YVIscHMOrTaQHoHxqIyKIGGcJUXzpYR5yik6aJPF/Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3FVW4+BW1V++0qO9DOErMnVGSt3t0xhN1WWDXKeeTzYQIIgbKQaQrT+RcFp89mdK
         JKpqrEtr6r/9FHjgPmvqfNy3tLdIvUaY/ICxW+VNSsBcRtIR0TpptndtMekxDVOhID
         SW0N+JBf2l/QIKf7X85xEdakm/5UdbmoRQ9zw4mE=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 05/11] arm64: csum: Disable KASAN for do_csum()
Date:   Tue, 21 Apr 2020 16:15:31 +0100
Message-Id: <20200421151537.19241-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
References: <20200421151537.19241-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_csum() over-reads the source buffer and therefore abuses
READ_ONCE_NOCHECK() to avoid tripping up KASAN. In preparation for
READ_ONCE_NOCHECK() becoming a macro, and therefore losing its
'__no_sanitize_address' annotation, just annotate do_csum() explicitly
and fall back to normal loads.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
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
2.26.1.301.g55bc3eb7cb9-goog

