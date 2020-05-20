Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0D4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A928207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NLqxSrFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgETTgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:36:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD1C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 12:36:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y8so2837956ybn.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AVVfiQR/7pisBCGTKoQl1KucA/6VNUwh3DKASPprRvc=;
        b=NLqxSrFnKkZcAGnV8zbrPjaSqtdTtqC6WvnCQ6SzwmjdO1Y1A4F8KO5jePbf4Ld4vU
         28TZNpeQFNkATsX+wqdm37YvRNjMEIJWOynydl7FMOR9zWc2pJMGJ/dm0ByXmA3wOy6f
         jEyGYA4c992ndf4FDE2XNOvJHqfNQkgp29X6JoGzCqYzfY6kPRseR8x89YXJLR67lkNi
         tb/oT6vlfiQs/gPcIri5IW4wS0mr2Ln1pssXe77Az1wxZw93TVFzUCSWqhO0oeLFPAfe
         dYcLUAA/fVV0ZOQy7v/R+8oS99/oCi9P0XhQli9FNC18szcQtd/4G7ZjiZx+ArvXOIfe
         ejJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AVVfiQR/7pisBCGTKoQl1KucA/6VNUwh3DKASPprRvc=;
        b=Dzw9Jd7BucWlCR53MCJSxeqx+0KH5OGmQ0OBJzpznDsjFaW+BBgL6Fz1gJTwUG9ZS2
         lNK9TpFefqVCvpAlihSW9ZGY/+mR4e7bjSNktEC2HCIU0TSlqeU4T7o42lZqrvWjUg2W
         IUCPs4iY98W4SLqgAFmBVeDyc8/AYme+jKdumzdXo5tcjb1+ol4tkfWOxtOF2IBL/mpc
         /rqlYdHs7Zzf/G5mph82x0mX93DMrVpCssBDR9HlaRu/wM+pMHmFAZguunLUG6DiABEu
         eOWBlkWLGrCFWO4iu7K0wPasEQhIlUjECfv5ZGUCqnYvxj2aQCR3LDfVz5hwB8nwiMfO
         OfUw==
X-Gm-Message-State: AOAM5339YBd0iJk3wiG4l7cf92TO4wyrCEmquJhQjN292wKt/vbwFDG4
        4joKGMbiQT7z2Rf2ObRIuaUUJ3x1eh/WYSSLjpE=
X-Google-Smtp-Source: ABdhPJwbmZUSDN6st0s//rLv1KZNYKNcyqaF9cXBCgx9X5BHJdWUMRAcv2Kb8IflvnhjGtC0I4kw9o2KKivp+wgPlNc=
X-Received: by 2002:a25:73d2:: with SMTP id o201mr8570814ybc.490.1590003402844;
 Wed, 20 May 2020 12:36:42 -0700 (PDT)
Date:   Wed, 20 May 2020 12:36:36 -0700
In-Reply-To: <10f4fb0b-1012-b0e6-af05-0aa5a906de21@redhat.com>
Message-Id: <20200520193637.6015-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <10f4fb0b-1012-b0e6-af05-0aa5a906de21@redhat.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v2] Makefile: support compressed debug info
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Nick Clifton <nickc@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Blaikie <blakie@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As debug information gets larger and larger, it helps significantly save
the size of vmlinux images to compress the information in the debug
information sections. Note: this debug info is typically split off from
the final compressed kernel image, which is why vmlinux is what's used
in conjunction with GDB. Minimizing the debug info size should have no
impact on boot times, or final compressed kernel image size.

All of the debug sections will have a `C` flag set.
$ readelf -S <object file>

$ bloaty vmlinux.gcc75.compressed.dwarf4 -- \
    vmlinux.gcc75.uncompressed.dwarf4

    FILE SIZE        VM SIZE
 --------------  --------------
  +0.0%     +18  [ = ]       0    [Unmapped]
 -73.3%  -114Ki  [ = ]       0    .debug_aranges
 -76.2% -2.01Mi  [ = ]       0    .debug_frame
 -73.6% -2.89Mi  [ = ]       0    .debug_str
 -80.7% -4.66Mi  [ = ]       0    .debug_abbrev
 -82.9% -4.88Mi  [ = ]       0    .debug_ranges
 -70.5% -9.04Mi  [ = ]       0    .debug_line
 -79.3% -10.9Mi  [ = ]       0    .debug_loc
 -39.5% -88.6Mi  [ = ]       0    .debug_info
 -18.2%  -123Mi  [ = ]       0    TOTAL

$ bloaty vmlinux.clang11.compressed.dwarf4 -- \
    vmlinux.clang11.uncompressed.dwarf4

    FILE SIZE        VM SIZE
 --------------  --------------
  +0.0%     +23  [ = ]       0    [Unmapped]
 -65.6%    -871  [ = ]       0    .debug_aranges
 -77.4% -1.84Mi  [ = ]       0    .debug_frame
 -82.9% -2.33Mi  [ = ]       0    .debug_abbrev
 -73.1% -2.43Mi  [ = ]       0    .debug_str
 -84.8% -3.07Mi  [ = ]       0    .debug_ranges
 -65.9% -8.62Mi  [ = ]       0    .debug_line
 -86.2% -40.0Mi  [ = ]       0    .debug_loc
 -42.0% -64.1Mi  [ = ]       0    .debug_info
 -22.1%  -122Mi  [ = ]       0    TOTAL

For x86_64 defconfig + LLVM=1 (before):
Elapsed (wall clock) time (h:mm:ss or m:ss): 3:22.03
Maximum resident set size (kbytes): 43856

For x86_64 defconfig + LLVM=1 (after):
Elapsed (wall clock) time (h:mm:ss or m:ss): 3:32.52
Maximum resident set size (kbytes): 1566776

Suggested-by: David Blaikie <blakie@google.com>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Nick Clifton <nickc@redhat.com>
Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* rebase on linux-next.
* Add assembler flags as per Fangrui.
* Add note about KDEB_COMPRESS+scripts/package/builddeb
  as per Sedat and Masahiro.
* Add note about bintutils version requirements as per Nick C.
* Add note about measured increased build time and max RSS.

 Makefile          |  6 ++++++
 lib/Kconfig.debug | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Makefile b/Makefile
index 71687bfe1cd9..be8835296754 100644
--- a/Makefile
+++ b/Makefile
@@ -822,6 +822,12 @@ DEBUG_CFLAGS	+= $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
 endif
 
+ifdef CONFIG_DEBUG_INFO_COMPRESSED
+DEBUG_CFLAGS	+= -gz=zlib
+KBUILD_AFLAGS	+= -Wa,--compress-debug-sections=zlib
+KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
+endif
+
 KBUILD_CFLAGS += $(DEBUG_CFLAGS)
 export DEBUG_CFLAGS
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b8f023e054b9..5a423cbfaea4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -225,6 +225,21 @@ config DEBUG_INFO_REDUCED
 	  DEBUG_INFO build and compile times are reduced too.
 	  Only works with newer gcc versions.
 
+config DEBUG_INFO_COMPRESSED
+	bool "Compressed debugging information"
+	depends on DEBUG_INFO
+	depends on $(cc-option,-gz=zlib)
+	depends on $(as-option,-Wa,--compress-debug-sections=zlib)
+	depends on $(ld-option,--compress-debug-sections=zlib)
+	help
+	  Compress the debug information using zlib.  Requires GCC 5.0+ or Clang
+	  5.0+, binutils 2.26+, and zlib.
+
+	  Users of dpkg-deb via scripts/package/builddeb may
+	  wish to set the $KDEB_COMPRESS env var to "none" to avoid recompressing
+	  the debug info again with a different compression scheme, which can
+	  result in larger binaries.
+
 config DEBUG_INFO_SPLIT
 	bool "Produce split debuginfo in .dwo files"
 	depends on DEBUG_INFO
-- 
2.26.2.761.g0e0b3e54be-goog

