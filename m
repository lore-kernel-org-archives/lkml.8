Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8878AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1581C22CA1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blhGSTKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgHCTn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgHCTn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:43:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CD2C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:43:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so18786461pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tRoceZFR+R7WQeMxLt51T/sCR/+liKbS1TQN704Jmbk=;
        b=blhGSTKBArcUeWwaDTxLgqI4lD/qMs3pnGl+783Y0+Hq5QAlugucHT/7EPAWoEMhMh
         pTweaWIsBfnX/6gfozsg0ieOgb81BGw7M+jBgAdEs8XQnh/sX65zrdhMZa0/aNW2x/yk
         Ilq7zXhbnLUV4PMhIkRpoA5RbT7guSeN4YJKFcRTqWC3ZOgNau5NILKVqqyh6zxSgxfp
         ejD2m3Da1xk96/FI+6p6NvytkdzkM/SD+KTqZXluUPxF9yzQvrMv0Bef0cizNczuLGfE
         Vn4qtg7j68wHfJpqCeZHMmGgGc1/hulHdAjAyCFN0KbOyCUJonmpMzHmeUIMPOg5RalL
         GJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tRoceZFR+R7WQeMxLt51T/sCR/+liKbS1TQN704Jmbk=;
        b=lcM/FrRHfNiWrX/m6LT5eoQH6riRca42mT4nWKzPh9tz49a3OZLRZ3J00iNYLz8+o9
         sYGF0QDQFsiyayVZHDbK6mf+R+4YUZXdm+srOg7rF9fumyIzhxp+9tO1gRbHWQDzSg5N
         syE199gte7ClF7u4bEFNKN9Pvk1iqzrIqxz/x2O3Z9IXW+hAGxlo6+kKWEYUwE2ONKPN
         dqU6IQfXg7Z6OvsvoBC7TLSVr1+yT0Yva5Znes63DpURm4wtiNcraQALG8DUH7FFoemf
         OYERYxmTGHSqlaVWdl7gHrsrxn4rg5+5ZuJ5CcSw+sKHaGyuDF3vdckJgKgtC7l5stVp
         36xQ==
X-Gm-Message-State: AOAM531bIkKG0KxlQp4tfb4ekrSblUVywKHpYMwyYvwmnxjFaj2ZqWrW
        teKSCv/8FK52GquDzq+YHg4=
X-Google-Smtp-Source: ABdhPJz+aqmBdwcY4/UXuSdnabGORf3cI0sjeNBG3V/6zDgOzsAkvGXjQn/E/NSq+/G/cArEBMdoHA==
X-Received: by 2002:aa7:8a4d:: with SMTP id n13mr15538714pfa.143.1596483806583;
        Mon, 03 Aug 2020 12:43:26 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id v77sm18073035pfc.137.2020.08.03.12.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:43:25 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] lz4: Fix kernel decompression speed
Date:   Mon,  3 Aug 2020 12:40:22 -0700
Message-Id: <20200803194022.2966806-1-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

This patch replaces all memcpy() calls with LZ4_memcpy() which calls
__builtin_memcpy() so the compiler can inline it.

LZ4 relies heavily on memcpy() with a constant size being inlined. In
x86 and i386 pre-boot environments memcpy() cannot be inlined because
memcpy() doesn't get defined as __builtin_memcpy().

An equivalent patch has been applied upstream so that the next import
won't lose this change [1].

I've measured the kernel decompression speed using QEMU before and after
this patch for the x86_64 and i386 architectures. The speed-up is about
10x as shown below.

Code	Arch	Kernel Size	Time	Speed
v5.8	x86_64	11504832 B	148 ms	 79 MB/s
patch	x86_64	11503872 B	 13 ms	885 MB/s
v5.8	i386	 9621216 B	 91 ms	106 MB/s
patch	i386	 9620224 B	 10 ms	962 MB/s

I also measured the time to decompress the initramfs on x86_64, i386,
and arm. All three show the same decompression speed before and after,
as expected.

[1] https://github.com/lz4/lz4/pull/890

Signed-off-by: Nick Terrell <terrelln@fb.com>
Cc: Yann Collet <yann.collet.73@gmail.com>
Cc: Gao Xiang <gaoxiang25@huawei.com>
Cc: Sven Schmidt <4sschmid@informatik.uni-hamburg.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 lib/lz4/lz4_compress.c   |  4 ++--
 lib/lz4/lz4_decompress.c | 18 +++++++++---------
 lib/lz4/lz4defs.h        | 10 ++++++++++
 lib/lz4/lz4hc_compress.c |  2 +-
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/lib/lz4/lz4_compress.c b/lib/lz4/lz4_compress.c
index cc7b6d4cc7c7..90bb67994688 100644
--- a/lib/lz4/lz4_compress.c
+++ b/lib/lz4/lz4_compress.c
@@ -446,7 +446,7 @@ static FORCE_INLINE int LZ4_compress_generic(
 			*op++ = (BYTE)(lastRun << ML_BITS);
 		}
 
-		memcpy(op, anchor, lastRun);
+		LZ4_memcpy(op, anchor, lastRun);
 
 		op += lastRun;
 	}
@@ -708,7 +708,7 @@ static int LZ4_compress_destSize_generic(
 		} else {
 			*op++ = (BYTE)(lastRunSize<<ML_BITS);
 		}
-		memcpy(op, anchor, lastRunSize);
+		LZ4_memcpy(op, anchor, lastRunSize);
 		op += lastRunSize;
 	}
 
diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 5371dab6b481..00cb0d0b73e1 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -153,7 +153,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 		   && likely((endOnInput ? ip < shortiend : 1) &
 			     (op <= shortoend))) {
 			/* Copy the literals */
-			memcpy(op, ip, endOnInput ? 16 : 8);
+			LZ4_memcpy(op, ip, endOnInput ? 16 : 8);
 			op += length; ip += length;
 
 			/*
@@ -172,9 +172,9 @@ static FORCE_INLINE int LZ4_decompress_generic(
 			    (offset >= 8) &&
 			    (dict == withPrefix64k || match >= lowPrefix)) {
 				/* Copy the match. */
-				memcpy(op + 0, match + 0, 8);
-				memcpy(op + 8, match + 8, 8);
-				memcpy(op + 16, match + 16, 2);
+				LZ4_memcpy(op + 0, match + 0, 8);
+				LZ4_memcpy(op + 8, match + 8, 8);
+				LZ4_memcpy(op + 16, match + 16, 2);
 				op += length + MINMATCH;
 				/* Both stages worked, load the next token. */
 				continue;
@@ -263,7 +263,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 				}
 			}
 
-			memcpy(op, ip, length);
+			LZ4_memcpy(op, ip, length);
 			ip += length;
 			op += length;
 
@@ -350,7 +350,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 				size_t const copySize = (size_t)(lowPrefix - match);
 				size_t const restSize = length - copySize;
 
-				memcpy(op, dictEnd - copySize, copySize);
+				LZ4_memcpy(op, dictEnd - copySize, copySize);
 				op += copySize;
 				if (restSize > (size_t)(op - lowPrefix)) {
 					/* overlap copy */
@@ -360,7 +360,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 					while (op < endOfMatch)
 						*op++ = *copyFrom++;
 				} else {
-					memcpy(op, lowPrefix, restSize);
+					LZ4_memcpy(op, lowPrefix, restSize);
 					op += restSize;
 				}
 			}
@@ -386,7 +386,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 				while (op < copyEnd)
 					*op++ = *match++;
 			} else {
-				memcpy(op, match, mlen);
+				LZ4_memcpy(op, match, mlen);
 			}
 			op = copyEnd;
 			if (op == oend)
@@ -400,7 +400,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 			op[2] = match[2];
 			op[3] = match[3];
 			match += inc32table[offset];
-			memcpy(op + 4, match, 4);
+			LZ4_memcpy(op + 4, match, 4);
 			match -= dec64table[offset];
 		} else {
 			LZ4_copy8(op, match);
diff --git a/lib/lz4/lz4defs.h b/lib/lz4/lz4defs.h
index 1a7fa9d9170f..c91dd96ef629 100644
--- a/lib/lz4/lz4defs.h
+++ b/lib/lz4/lz4defs.h
@@ -137,6 +137,16 @@ static FORCE_INLINE void LZ4_writeLE16(void *memPtr, U16 value)
 	return put_unaligned_le16(value, memPtr);
 }
 
+/*
+ * LZ4 relies on memcpy with a constant size being inlined. In freestanding
+ * environments, the compiler can't assume the implementation of memcpy() is
+ * standard compliant, so apply its specialized memcpy() inlining logic. When
+ * possible, use __builtin_memcpy() to tell the compiler to analyze memcpy()
+ * as-if it were standard compliant, so it can inline it in freestanding
+ * environments. This is needed when decompressing the Linux Kernel, for example.
+ */
+#define LZ4_memcpy(dst, src, size) __builtin_memcpy(dst, src, size)
+
 static FORCE_INLINE void LZ4_copy8(void *dst, const void *src)
 {
 #if LZ4_ARCH64
diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
index 1b61d874e337..e7ac8694b797 100644
--- a/lib/lz4/lz4hc_compress.c
+++ b/lib/lz4/lz4hc_compress.c
@@ -570,7 +570,7 @@ static int LZ4HC_compress_generic(
 			*op++ = (BYTE) lastRun;
 		} else
 			*op++ = (BYTE)(lastRun<<ML_BITS);
-		memcpy(op, anchor, iend - anchor);
+		LZ4_memcpy(op, anchor, iend - anchor);
 		op += iend - anchor;
 	}
 
-- 
2.28.0

