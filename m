Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6662C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D5521739
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="IsVuaMki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgATHoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:44:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35722 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATHoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:44:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id i23so15427650pfo.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 23:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ceV5dzkz6HqCMW6fBoym4ypC/m9xh1QjTBMfyGPn8o=;
        b=IsVuaMkiPafyhTmbUmmKKq2zQ2knSaijf8xt11NZ6XL9Q4Hm1Cfdm8CztrO01x5ltK
         VnhPQHcNW2slNw6gRk8rL5iIUAbKO40Kuwiaqw1t/4WmuKa+tf45OOD70HBQ71fF1tLO
         +5Vv23deCqiMdkkxkLo3lvuCj1D8aE7yy6hs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ceV5dzkz6HqCMW6fBoym4ypC/m9xh1QjTBMfyGPn8o=;
        b=mcMnnnIJn5cSXMBEzLpx9hKoAAIcdrIJ98KfUWAtGJ4R8Rsg10W7uCQZfJqrphjh3o
         3MXKejqHF621/T1aqQJbenlW1GWyIN563MyJ0y+qqIlaHMvySLsjya0uFg94HrQ+C+t7
         iBqF3wkV3nAghOCS2rSPU4Uut2+lAtNFjVzrPfisfqavY5cpQAFobKRVOuhnCpDI++/d
         rcNe4F2cUbMu6Hjxn1q3aIOrUgJhxMNxx3rQUSp9YSnq8q74uVOGSt2W2x3/Rf8HOdan
         uLJ0lKbiHR1fW25k+uSSPxVnG89V3JLnU1F6yh9JFuaECV2enicn0fXCR5XgRbYyjNP3
         CyNA==
X-Gm-Message-State: APjAAAV5RDe+rdytxIVkrsV2inilmT4Vug0u7R8X8wayY9AyJkUyFS3e
        ZmLlHTgSM1NrsYDUTY16DOLIgQ==
X-Google-Smtp-Source: APXvYqxpn7k/Ufr5n0ApK06TsYbJxU+ior64MbZ5pNsKbxSZFpNAZBslVxeMWsQFy8/9nF92ZyhObQ==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr58040093pgi.241.1579506244663;
        Sun, 19 Jan 2020 23:44:04 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-4064-d910-a710-f29a.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4064:d910:a710:f29a])
        by smtp.gmail.com with ESMTPSA id y62sm40131883pfg.45.2020.01.19.23.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:44:04 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH 4/5] [VERY RFC] mm: kmalloc(_node): return NULL immediately for SIZE_MAX
Date:   Mon, 20 Jan 2020 18:43:43 +1100
Message-Id: <20200120074344.504-5-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120074344.504-1-dja@axtens.net>
References: <20200120074344.504-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc is sometimes compiled with an size that at compile time may be
equal to SIZE_MAX.

For example, struct_size(struct, array member, array elements) returns the
size of a structure that has an array as the last element, containing a
given number of elements, or SIZE_MAX on overflow.

However, struct_size operates in (arguably) unintuitive ways at compile time.
Consider the following snippet:

struct foo {
	int a;
	int b[0];
};

struct foo *alloc_foo(int elems)
{
	struct foo *result;
	size_t size = struct_size(result, b, elems);
	if (__builtin_constant_p(size)) {
		BUILD_BUG_ON(size == SIZE_MAX);
	}
	result = kmalloc(size, GFP_KERNEL);
	return result;
}

I expected that size would only be constant if alloc_foo() was called
within that translation unit with a constant number of elements, and the
compiler had decided to inline it. I'd therefore expect that 'size' is only
SIZE_MAX if the constant provided was a huge number.

However, instead, this function hits the BUILD_BUG_ON, even if never
called.

include/linux/compiler.h:394:38: error: call to ‘__compiletime_assert_32’ declared with attribute error: BUILD_BUG_ON failed: size == SIZE_MAX

This is with gcc 9.2.1, and I've also observed it with an gcc 8 series
compiler.

My best explanation of this is:

 - elems is a signed int, so a small negative number will become a very
   large unsigned number when cast to a size_t, leading to overflow.

 - Then, the only way in which size can be a constant is if we hit the
   overflow case, in which 'size' will be 'SIZE_MAX'.

 - So the compiler takes that value into the body of the if statement and
   blows up.

But I could be totally wrong.

Anyway, this is relevant to slab.h because kmalloc() and kmalloc_node()
check if the supplied size is a constant and take a faster path if so. A
number of callers of those functions use struct_size to determine the size
of a memory allocation. Therefore, at compile time, those functions will go
down the constant path, specialising for the overflow case.

When my next patch is applied, gcc will then throw a warning any time
kmalloc_large could be called with a SIZE_MAX size, as gcc deems SIZE_MAX
to be too big an allocation.

So, make functions that check __builtin_constant_p check also against
SIZE_MAX in the constant path, and immediately return NULL if we hit it.

This brings kmalloc() and kmalloc_node() into line with the array functions
kmalloc_array() and kmalloc_array_node() for the overflow case. The overall
compiled size change per bloat-o-meter is in the noise (a reduction of
<0.01%).

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/slab.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 03a389358562..8141c6b1882a 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -544,6 +544,9 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
 #ifndef CONFIG_SLOB
 		unsigned int index;
 #endif
+		if (unlikely(size == SIZE_MAX))
+			return NULL;
+
 		if (size > KMALLOC_MAX_CACHE_SIZE)
 			return kmalloc_large(size, flags);
 #ifndef CONFIG_SLOB
@@ -562,6 +565,9 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
 
 static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
+	if (__builtin_constant_p(size) && size == SIZE_MAX)
+		return NULL;
+
 #ifndef CONFIG_SLOB
 	if (__builtin_constant_p(size) &&
 		size <= KMALLOC_MAX_CACHE_SIZE) {
-- 
2.20.1

