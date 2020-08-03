Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1ABC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA3B2076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLFUj46j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgHCV5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCV5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:57:50 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65527C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 14:57:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so36647463qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9/CYFaXh8bThql6xS8bKAvJejb77mKP97Fn6eGg2abM=;
        b=XLFUj46jwBoJ1+zmfy7YEAh45GxdkUSQ/u/LZITjdY7/IFm0dF7RZp4jDemVhDodwC
         bV5Z4UrwnjUGV7ZdgLSqhWKqRYpwRpVmjaySXSJBAn4QDJLDqHX2JRENsAnNOoq5fXH2
         eA6aR16r01dagR20o+lLbrcKvQT1XlWre9f/nmSvQRN8+Ch8E0X4PCSN2n9gs/V/E7Sp
         +Q6j0i8J78/8QmN6XwW28lYKOqs8TDUM3mUlPce1h/2wUBUmS653skqqNG+pTnRG3bCi
         7HI6pjpxK8cWXmJIVbTgznf0Zhn9z8O9/jm62BnMHkefGZjsum0rU0V5TVt7eFBHeu6l
         eGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9/CYFaXh8bThql6xS8bKAvJejb77mKP97Fn6eGg2abM=;
        b=LR2cDElT5JaHQOexSAKF5h95i8gJjK1WlKrjY7gjsz8jQzjfC6x2gHMSP6Z2Ps2n7l
         gm6gWrMusBHg0W3ZUns5yKfBwx5uWWco7Jk63vlSEdNVJONJWrCbN947JzIuAz4J32g1
         NIeo2cuGDdX/YjF2zYU6c3yWqjaT4knQDkIsbsRkp3q5+129huo2X7/R5odsBxUT5k2s
         Dyx1ESPjUGZcyK4bt6z0vOGcL26mpwJ14P9ONotMMJ7UKtLzLa0T2Uyy6O175pRMOCzc
         jweHxKR4IR0Qn3JDP4qGzMH6NJ/ftWmj6+niKYqgZBHnSLBcC6hGJMDOscNmooQwAb36
         qBLg==
X-Gm-Message-State: AOAM5322mzVz/x0FqBPZc2IO4/3BAV3Z1ftFfIKFTXn6ofOlIDLsqTXx
        03mQdq+aLuIXR9i+fvK66vM=
X-Google-Smtp-Source: ABdhPJwV37QlUQs1FG4eRc7MmipSjvYmMeF0mjo820irwMko/BSuVbG3YgqCYO9HLStOIQikG3RBMw==
X-Received: by 2002:a37:7245:: with SMTP id n66mr7113938qkc.83.1596491869458;
        Mon, 03 Aug 2020 14:57:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm21724598qkm.117.2020.08.03.14.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:57:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 3 Aug 2020 17:57:47 -0400
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lz4: Fix kernel decompression speed
Message-ID: <20200803215747.GA1644409@rani.riverdale.lan>
References: <20200803194022.2966806-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803194022.2966806-1-nickrterrell@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 12:40:22PM -0700, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> This patch replaces all memcpy() calls with LZ4_memcpy() which calls
> __builtin_memcpy() so the compiler can inline it.
> 
> LZ4 relies heavily on memcpy() with a constant size being inlined. In
> x86 and i386 pre-boot environments memcpy() cannot be inlined because
> memcpy() doesn't get defined as __builtin_memcpy().
> 
> An equivalent patch has been applied upstream so that the next import
> won't lose this change [1].
> 
> I've measured the kernel decompression speed using QEMU before and after
> this patch for the x86_64 and i386 architectures. The speed-up is about
> 10x as shown below.
> 
> Code	Arch	Kernel Size	Time	Speed
> v5.8	x86_64	11504832 B	148 ms	 79 MB/s
> patch	x86_64	11503872 B	 13 ms	885 MB/s
> v5.8	i386	 9621216 B	 91 ms	106 MB/s
> patch	i386	 9620224 B	 10 ms	962 MB/s
> 
> I also measured the time to decompress the initramfs on x86_64, i386,
> and arm. All three show the same decompression speed before and after,
> as expected.
> 
> [1] https://github.com/lz4/lz4/pull/890
> 

Hi Nick, would you be able to test the below patch's performance to
verify it gives the same speedup? It removes the #undef in misc.c which
causes the decompressors to not use the builtin version. It should be
equivalent to yours except for applying it to all the decompressors.

Thanks.

From 10f8d939fc367e3127e2d72ba099678debcae422 Mon Sep 17 00:00:00 2001
From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Mon, 3 Aug 2020 17:07:37 -0400
Subject: [PATCH] x86/boot/compressed: Use builtin mem functions for decompressor

Since commits

  c041b5ad8640 ("x86, boot: Create a separate string.h file to provide standard string functions")
  fb4cac573ef6 ("x86, boot: Move memcmp() into string.h and string.c")

the decompressor stub has been using the compiler's builtin memcpy,
memset and memcmp functions, _except_ where it would likely have the
largest impact, in the decompression code itself.

Remove the #undef's of memcpy and memset in misc.c so that the
decompressor code also uses the compiler builtins.

The rationale given in the comment doesn't really apply: just because
some functions use the out-of-line version is no reason to not use the
builtin version in the rest.

Replace the comment with an explanation of why memzero and memmove are
being #define'd.

Drop the suggestion to #undef in boot/string.h as well: the out-of-line
versions are not really optimized versions, they're generic code that's
good enough for the preboot environment. The compiler will likely
generate better code for constant-size memcpy/memset/memcmp if it is
allowed to.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/misc.c | 7 ++-----
 arch/x86/boot/string.h          | 5 +----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 9652d5c2afda..0c74a6e526b6 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -30,12 +30,9 @@
 #define STATIC		static
 
 /*
- * Use normal definitions of mem*() from string.c. There are already
- * included header files which expect a definition of memset() and by
- * the time we define memset macro, it is too late.
+ * Provide definitions of memzero and memmove as some of the decompressors will
+ * try to define their own functions if these are not defined as macros.
  */
-#undef memcpy
-#undef memset
 #define memzero(s, n)	memset((s), 0, (n))
 #define memmove		memmove
 
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index 995f7b7ad512..a232da487cd2 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -11,10 +11,7 @@ void *memcpy(void *dst, const void *src, size_t len);
 void *memset(void *dst, int c, size_t len);
 int memcmp(const void *s1, const void *s2, size_t len);
 
-/*
- * Access builtin version by default. If one needs to use optimized version,
- * do "undef memcpy" in .c file and link against right string.c
- */
+/* Access builtin version by default. */
 #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
 #define memset(d,c,l) __builtin_memset(d,c,l)
 #define memcmp	__builtin_memcmp
-- 
2.26.2

