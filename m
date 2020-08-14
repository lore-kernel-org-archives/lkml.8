Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251EEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C3320708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpPdM4Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHNR3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgHNR2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:47 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6DC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:47 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id b8so3618834wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZNAU/quOyDd65Y8FbbPHdMn2fE8Roa22GmWzXnVDZak=;
        b=VpPdM4KjSqSmi15WeszefkGFIv0AyTX0aHnAZL6iexBFZD0v86l5iCux6uY1gkgnfs
         ClcC0AVbghTzetFwaDUUh+9i4JVbBqkuhu4WZ9khBNrrsUUITZMejQr9xUPp8ei9ASJY
         hzXxWtzTJSqOep3y4/sJXpo1rCCxpmSyQFHS499mnp9fq6JWyWYXZrBn+9atF2VwImqf
         5DinyUih8C2eUEjwXAtcahxIh0w0ll0zPTahMEeEY7SmvR59hNooOyoPEOkIS391v3Jx
         A8HU0xnEe5UoZ8Za37Ia0/M/z9+iYtsR6UANiQw6Sw7vzTXZ591Wf6i7Yc+fdbiCiEq+
         TfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZNAU/quOyDd65Y8FbbPHdMn2fE8Roa22GmWzXnVDZak=;
        b=XMJnsYvRdzVWFVaJkxZj/LmJQWpNdW8H8T61AQFr+DqSandb4nyUdMm1e4iykn+q16
         M742MwLhwtNQWoKk8jK/QHR/KNDlkt3RZi2ruY7arT3tfvVDGtdPIvUf687V0ibAwNDM
         INUE3Pui6pKIVUk0rDqN3W33FUSYCLiyDXCUqPPjNItdehCPWhMmh/ZoyQ9reZyIN8Xm
         9+z3Mw9v00bC17zehKkaKy0iFfsZN20MF5hm7frmOP40+Sv9ca/AvQCUqZ/ZOcZPYPUS
         vGOUwD/rfb9/PQYO1X/xWPMqmux4LjO3sPp4c6xYqRyipC1Mm0qgx/v+YXpgSo/gFxKF
         KgoA==
X-Gm-Message-State: AOAM531cMBH8S5433WPG49onAPa1n/Y7xNvghiI+d/RaroaYd2bGF0BP
        xEnvlG+5BAUehH66Gf9T4aqAKBIt/88dSIMZ
X-Google-Smtp-Source: ABdhPJwnoFj2TAGCyi9g4boF8m4IogDAYSFYwYDUR8UydD3LEC6RXiTNFFPR4QBOBXysmoVhu+Tx8c3QIXSNDMYM
X-Received: by 2002:a1c:f416:: with SMTP id z22mr3308371wma.62.1597426126049;
 Fri, 14 Aug 2020 10:28:46 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:17 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <5d0f3c0ee55c58ffa9f58bdea6fa6bf4f6f973a4.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 35/35] kasan: add documentation for hardware tag-based mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for hardware tag-based KASAN mode and also add some
clarifications for software tag-based mode.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 73 +++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index a3030fc6afe5..aeed89d6eaf5 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -5,12 +5,14 @@ Overview
 --------
 
 KernelAddressSANitizer (KASAN) is a dynamic memory error detector designed to
-find out-of-bound and use-after-free bugs. KASAN has two modes: generic KASAN
-(similar to userspace ASan) and software tag-based KASAN (similar to userspace
-HWASan).
+find out-of-bound and use-after-free bugs. KASAN has three modes:
+1. generic KASAN (similar to userspace ASan),
+2. software tag-based KASAN (similar to userspace HWASan),
+3. hardware tag-based KASAN (based on hardware memory tagging).
 
-KASAN uses compile-time instrumentation to insert validity checks before every
-memory access, and therefore requires a compiler version that supports that.
+Software KASAN modes (1 and 2) use compile-time instrumentation to insert
+validity checks before every memory access, and therefore require a compiler
+version that supports that.
 
 Generic KASAN is supported in both GCC and Clang. With GCC it requires version
 8.3.0 or later. With Clang it requires version 7.0.0 or later, but detection of
@@ -19,7 +21,7 @@ out-of-bounds accesses for global variables is only supported since Clang 11.
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
 Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
-riscv architectures, and tag-based KASAN is supported only for arm64.
+riscv architectures, and tag-based KASAN modes are supported only for arm64.
 
 Usage
 -----
@@ -28,14 +30,16 @@ To enable KASAN configure kernel with::
 
 	  CONFIG_KASAN = y
 
-and choose between CONFIG_KASAN_GENERIC (to enable generic KASAN) and
-CONFIG_KASAN_SW_TAGS (to enable software tag-based KASAN).
+and choose between CONFIG_KASAN_GENERIC (to enable generic KASAN),
+CONFIG_KASAN_SW_TAGS (to enable software tag-based KASAN), and
+CONFIG_KASAN_HW_TAGS (to enable hardware tag-based KASAN).
 
-You also need to choose between CONFIG_KASAN_OUTLINE and CONFIG_KASAN_INLINE.
-Outline and inline are compiler instrumentation types. The former produces
-smaller binary while the latter is 1.1 - 2 times faster.
+For software modes, you also need to choose between CONFIG_KASAN_OUTLINE and
+CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
+The former produces smaller binary while the latter is 1.1 - 2 times faster.
 
-Both KASAN modes work with both SLUB and SLAB memory allocators.
+Both software KASAN modes work with both SLUB and SLAB memory allocators,
+hardware tag-based KASAN currently only support SLUB.
 For better bug detection and nicer reporting, enable CONFIG_STACKTRACE.
 
 To augment reports with last allocation and freeing stack of the physical page,
@@ -196,17 +200,20 @@ and the second to last.
 Software tag-based KASAN
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Tag-based KASAN uses the Top Byte Ignore (TBI) feature of modern arm64 CPUs to
-store a pointer tag in the top byte of kernel pointers. Like generic KASAN it
-uses shadow memory to store memory tags associated with each 16-byte memory
-cell (therefore it dedicates 1/16th of the kernel memory for shadow memory).
+Software tag-based KASAN uses the Top Byte Ignore (TBI) feature of modern arm64
+CPUs to store a pointer tag in the top byte of kernel pointers. Like generic
+KASAN it uses shadow memory to store memory tags associated with each 16-byte
+memory cell (therefore it dedicates 1/16th of the kernel memory for shadow
+memory).
+
+On each memory allocation software tag-based KASAN generates a random tag, tags
+the allocated memory with this tag, and embeds this tag into the returned
+pointer.
 
-On each memory allocation tag-based KASAN generates a random tag, tags the
-allocated memory with this tag, and embeds this tag into the returned pointer.
 Software tag-based KASAN uses compile-time instrumentation to insert checks
 before each memory access. These checks make sure that tag of the memory that
 is being accessed is equal to tag of the pointer that is used to access this
-memory. In case of a tag mismatch tag-based KASAN prints a bug report.
+memory. In case of a tag mismatch software tag-based KASAN prints a bug report.
 
 Software tag-based KASAN also has two instrumentation modes (outline, that
 emits callbacks to check memory accesses; and inline, that performs the shadow
@@ -215,9 +222,31 @@ simply printed from the function that performs the access check. With inline
 instrumentation a brk instruction is emitted by the compiler, and a dedicated
 brk handler is used to print bug reports.
 
-A potential expansion of this mode is a hardware tag-based mode, which would
-use hardware memory tagging support instead of compiler instrumentation and
-manual shadow memory manipulation.
+Software tag-based KASAN uses 0xFF as a match-all pointer tag (accesses aren't
+checked).
+
+Software tag-based KASAN currently only supports tagging of slab memory.
+
+Hardware tag-based KASAN
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Hardware tag-based KASAN is similar to the software mode in concept, but uses
+hardware memory tagging support instead of compiler instrumentation and
+shadow memory.
+
+Hardware tag-based KASAN is based on both arm64 Memory Tagging Extension (MTE)
+introduced in ARMv8.5 Instruction Set Architecture, and Top Byte Ignore (TBI).
+
+Special arm64 instructions are used to assign memory tags for each allocation.
+Same tags are assigned to pointers to those allocations. On every memory
+access, hardware makes sure that tag of the memory that is being accessed is
+equal to tag of the pointer that is used to access this memory. In case of a
+tag mismatch a fault is generated and a report is printed.
+
+Hardware tag-based KASAN uses 0xFF as a match-all pointer tag (accesses aren't
+checked).
+
+Hardware tag-based KASAN currently only supports tagging of slab memory.
 
 What memory accesses are sanitised by KASAN?
 --------------------------------------------
-- 
2.28.0.220.ged08abb693-goog

