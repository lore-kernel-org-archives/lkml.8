Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913EEC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7E720735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3ubujsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEGMcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbgEGMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:32:06 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793AAC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 05:32:06 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a83so5564843qkc.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2g1BVX1QureuxU5m39XcOrra/dWoW6mkh/lhoFPB6pA=;
        b=Y3ubujsiCmzITFxYVhlZQ5+eEv7+RsbVuQRmvb67lIjfnH9hXgCJ6knTM3uMZxt5dJ
         vZpGKhO/18suUICuMh5InCm4NfB34W0snWFF1y2+c7JkZh3tESbLTIW1YAIgaBZ9nPll
         XuP4SRb5CwWPE4IE6tCkc1C+iEITqBI3aP3MKojgXUi9UEfLepDDXfUh2uHvLWOc7cOR
         AGENzNRejcz3PxcA6iu9SVpTpzdXRTwxwpMbKuWor/jfI+F0bkts4YQ0joGE1c4OFWSl
         LulmPFczOfaSe2H9W95d5ZgrjPXH7rlbgqwud8DnSwb1e4VgHab5OGMIkVYbULel8dHv
         /3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2g1BVX1QureuxU5m39XcOrra/dWoW6mkh/lhoFPB6pA=;
        b=WXaXS4eHclu8dP3g3KjC2botRgnoJnmN5Jo9cGbnOh+/wjGki+uy8072ZMc+liKrKq
         8BoWGMQQ+PpZxuNQR5b75YYsx44E1UQov4c47MTHBVsXQ7b/cgEHxEfXklS8h7eaUXs8
         MFnlUbfl1E2FoWIzS9wYt1wHOGBpaFEg8ciV75Qy32aumYjL+P0281sVuVUrpPy0J1d/
         MtK/OSo3I6b4SDTp+erQ15YdqnnmukfMg+3C90voWbQizdwhXOPxEKPAqnFsmJYcjdho
         XysCH+M8PjZDWR7shuoR57b0ggR6kio0ZK95Cg6bLk9uCV0TLb887HY9rcvmMRZJR8g2
         knng==
X-Gm-Message-State: AGi0PuZsp9b3RFoWbGZMY8/yhHIEYjpyyc6d6QKeTnsw3hDBmy0mW2rf
        QcwUzADG1FvV8E88ts1kc8/ZuT7XFw==
X-Google-Smtp-Source: APiQypJj76lQ9e4aCTpm2UwcuHoFCPtsD8io0gVZFOcrp02Z2Fk9sFtG1glrHPvfv9vT5A1sHuDpiYL2Rg==
X-Received: by 2002:a05:6214:9ce:: with SMTP id dp14mr13297157qvb.142.1588854725591;
 Thu, 07 May 2020 05:32:05 -0700 (PDT)
Date:   Thu,  7 May 2020 14:31:12 +0200
Message-Id: <20200507123112.252723-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] lib/zlib: Remove outdated and incorrect pre-increment optimization
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zlib inflate code has an old micro-optimization based on the assumption
that for pre-increment memory accesses, the compiler will generate code
that fits better into the processor's pipeline than what would be generated
for post-increment memory accesses.

This optimization was already removed in upstream zlib in 2016:
https://github.com/madler/zlib/commit/9aaec95e8211

This optimization causes UB according to C99, which says in section 6.5.6
"Additive operators": "If both the pointer operand and the result point to
elements of the same array object, or one past the last element of the
array object, the evaluation shall not produce an overflow; otherwise, the
behavior is undefined".
This UB is not only a theoretical concern, but can also cause trouble for
future work on compiler-based sanitizers.

According to the zlib commit, this optimization also is not optimal anymore
with modern compilers.

Replace uses of OFF, PUP and UP_UNALIGNED with their definitions in the
POSTINC case, and remove the macro definitions, just like in the upstream
patch.

(This patch lights up checkpatch like a christmas tree because spaces are
used for indentation; but almost the entire file uses four spaces to
indent, so I don't think there's anything I can reasonably do about that.)

Signed-off-by: Jann Horn <jannh@google.com>
---
 lib/zlib_inflate/inffast.c | 91 +++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 56 deletions(-)

diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index 2c13ecc5bb2c7..ed1f3df272602 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -10,17 +10,6 @@
 
 #ifndef ASMINF
 
-/* Allow machine dependent optimization for post-increment or pre-increment.
-   Based on testing to date,
-   Pre-increment preferred for:
-   - PowerPC G3 (Adler)
-   - MIPS R5000 (Randers-Pehrson)
-   Post-increment preferred for:
-   - none
-   No measurable difference:
-   - Pentium III (Anderson)
-   - M68060 (Nikl)
- */
 union uu {
 	unsigned short us;
 	unsigned char b[2];
@@ -38,16 +27,6 @@ get_unaligned16(const unsigned short *p)
 	return mm.us;
 }
 
-#ifdef POSTINC
-#  define OFF 0
-#  define PUP(a) *(a)++
-#  define UP_UNALIGNED(a) get_unaligned16((a)++)
-#else
-#  define OFF 1
-#  define PUP(a) *++(a)
-#  define UP_UNALIGNED(a) get_unaligned16(++(a))
-#endif
-
 /*
    Decode literal, length, and distance codes and write out the resulting
    literal and match bytes until either not enough input or output is
@@ -115,9 +94,9 @@ void inflate_fast(z_streamp strm, unsigned start)
 
     /* copy state to local variables */
     state = (struct inflate_state *)strm->state;
-    in = strm->next_in - OFF;
+    in = strm->next_in;
     last = in + (strm->avail_in - 5);
-    out = strm->next_out - OFF;
+    out = strm->next_out;
     beg = out - (start - strm->avail_out);
     end = out + (strm->avail_out - 257);
 #ifdef INFLATE_STRICT
@@ -138,9 +117,9 @@ void inflate_fast(z_streamp strm, unsigned start)
        input data or output space */
     do {
         if (bits < 15) {
-            hold += (unsigned long)(PUP(in)) << bits;
+            hold += (unsigned long)(*in++) << bits;
             bits += 8;
-            hold += (unsigned long)(PUP(in)) << bits;
+            hold += (unsigned long)(*in++) << bits;
             bits += 8;
         }
         this = lcode[hold & lmask];
@@ -150,14 +129,14 @@ void inflate_fast(z_streamp strm, unsigned start)
         bits -= op;
         op = (unsigned)(this.op);
         if (op == 0) {                          /* literal */
-            PUP(out) = (unsigned char)(this.val);
+            *out++ = (unsigned char)(this.val);
         }
         else if (op & 16) {                     /* length base */
             len = (unsigned)(this.val);
             op &= 15;                           /* number of extra bits */
             if (op) {
                 if (bits < op) {
-                    hold += (unsigned long)(PUP(in)) << bits;
+                    hold += (unsigned long)(*in++) << bits;
                     bits += 8;
                 }
                 len += (unsigned)hold & ((1U << op) - 1);
@@ -165,9 +144,9 @@ void inflate_fast(z_streamp strm, unsigned start)
                 bits -= op;
             }
             if (bits < 15) {
-                hold += (unsigned long)(PUP(in)) << bits;
+                hold += (unsigned long)(*in++) << bits;
                 bits += 8;
-                hold += (unsigned long)(PUP(in)) << bits;
+                hold += (unsigned long)(*in++) << bits;
                 bits += 8;
             }
             this = dcode[hold & dmask];
@@ -180,10 +159,10 @@ void inflate_fast(z_streamp strm, unsigned start)
                 dist = (unsigned)(this.val);
                 op &= 15;                       /* number of extra bits */
                 if (bits < op) {
-                    hold += (unsigned long)(PUP(in)) << bits;
+                    hold += (unsigned long)(*in++) << bits;
                     bits += 8;
                     if (bits < op) {
-                        hold += (unsigned long)(PUP(in)) << bits;
+                        hold += (unsigned long)(*in++) << bits;
                         bits += 8;
                     }
                 }
@@ -205,13 +184,13 @@ void inflate_fast(z_streamp strm, unsigned start)
                         state->mode = BAD;
                         break;
                     }
-                    from = window - OFF;
+                    from = window;
                     if (write == 0) {           /* very common case */
                         from += wsize - op;
                         if (op < len) {         /* some from window */
                             len -= op;
                             do {
-                                PUP(out) = PUP(from);
+                                *out++ = *from++;
                             } while (--op);
                             from = out - dist;  /* rest from output */
                         }
@@ -222,14 +201,14 @@ void inflate_fast(z_streamp strm, unsigned start)
                         if (op < len) {         /* some from end of window */
                             len -= op;
                             do {
-                                PUP(out) = PUP(from);
+                                *out++ = *from++;
                             } while (--op);
-                            from = window - OFF;
+                            from = window;
                             if (write < len) {  /* some from start of window */
                                 op = write;
                                 len -= op;
                                 do {
-                                    PUP(out) = PUP(from);
+                                    *out++ = *from++;
                                 } while (--op);
                                 from = out - dist;      /* rest from output */
                             }
@@ -240,21 +219,21 @@ void inflate_fast(z_streamp strm, unsigned start)
                         if (op < len) {         /* some from window */
                             len -= op;
                             do {
-                                PUP(out) = PUP(from);
+                                *out++ = *from++;
                             } while (--op);
                             from = out - dist;  /* rest from output */
                         }
                     }
                     while (len > 2) {
-                        PUP(out) = PUP(from);
-                        PUP(out) = PUP(from);
-                        PUP(out) = PUP(from);
+                        *out++ = *from++;
+                        *out++ = *from++;
+                        *out++ = *from++;
                         len -= 3;
                     }
                     if (len) {
-                        PUP(out) = PUP(from);
+                        *out++ = *from++;
                         if (len > 1)
-                            PUP(out) = PUP(from);
+                            *out++ = *from++;
                     }
                 }
                 else {
@@ -264,29 +243,29 @@ void inflate_fast(z_streamp strm, unsigned start)
                     from = out - dist;          /* copy direct from output */
 		    /* minimum length is three */
 		    /* Align out addr */
-		    if (!((long)(out - 1 + OFF) & 1)) {
-			PUP(out) = PUP(from);
+		    if (!((long)(out - 1) & 1)) {
+			*out++ = *from++;
 			len--;
 		    }
-		    sout = (unsigned short *)(out - OFF);
+		    sout = (unsigned short *)(out);
 		    if (dist > 2) {
 			unsigned short *sfrom;
 
-			sfrom = (unsigned short *)(from - OFF);
+			sfrom = (unsigned short *)(from);
 			loops = len >> 1;
 			do
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-			    PUP(sout) = PUP(sfrom);
+			    *sout++ = *sfrom++;
 #else
-			    PUP(sout) = UP_UNALIGNED(sfrom);
+			    *sout++ = get_unaligned16(sfrom++);
 #endif
 			while (--loops);
-			out = (unsigned char *)sout + OFF;
-			from = (unsigned char *)sfrom + OFF;
+			out = (unsigned char *)sout;
+			from = (unsigned char *)sfrom;
 		    } else { /* dist == 1 or dist == 2 */
 			unsigned short pat16;
 
-			pat16 = *(sout-1+OFF);
+			pat16 = *(sout-1);
 			if (dist == 1) {
 				union uu mm;
 				/* copy one char pattern to both bytes */
@@ -296,12 +275,12 @@ void inflate_fast(z_streamp strm, unsigned start)
 			}
 			loops = len >> 1;
 			do
-			    PUP(sout) = pat16;
+			    *sout++ = pat16;
 			while (--loops);
-			out = (unsigned char *)sout + OFF;
+			out = (unsigned char *)sout;
 		    }
 		    if (len & 1)
-			PUP(out) = PUP(from);
+			*out++ = *from++;
                 }
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
@@ -336,8 +315,8 @@ void inflate_fast(z_streamp strm, unsigned start)
     hold &= (1U << bits) - 1;
 
     /* update state and return */
-    strm->next_in = in + OFF;
-    strm->next_out = out + OFF;
+    strm->next_in = in;
+    strm->next_out = out;
     strm->avail_in = (unsigned)(in < last ? 5 + (last - in) : 5 - (in - last));
     strm->avail_out = (unsigned)(out < end ?
                                  257 + (end - out) : 257 - (out - end));

base-commit: a811c1fa0a02c062555b54651065899437bacdbe
-- 
2.26.2.526.g744177e7f7-goog

