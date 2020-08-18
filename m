Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D545DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE34920772
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgHRXnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:43:11 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:32979 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHRXnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 19:43:10 -0400
Received: by mail-qv1-f68.google.com with SMTP id dd12so10476910qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 16:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bsP3WAK1pfI5NZ2U1r3gXjZrG4nRfJP8f387+vY6AgY=;
        b=CoMTETMzSqw8coTVvMQHeq7terG5H0ppDJaYXHN2kkasSC9OohGQ+AysA1zvgu6+h5
         djfIpT4THDABbgVLbtPG/gArNtnCEeewnrDTfXvpirQdhRQI0LaLAkRRXKYA/qg7RNGR
         afgpnRGgsRfgvo4tFkuj6CCi5NrjkGIDcWBljTjKde2c1/12NdOAZnQp5I8VTBJ89Zyg
         xIEa6aDy+/WcDdy0CDS6EVlFA8xqLiYpL3YVyNUBquV4Sfyq3WMlsaHcdJ5rCfvk1/4B
         QDjtfka2r0jihHAi/nEa/QLqdZGYN6I4MpwH5I+Im3cwjqKULoWrxM/SWT94tbXhF8Or
         A4og==
X-Gm-Message-State: AOAM531ulfMONR9ib6Gj7k4R97514q8hs/PhmumYSQQBVVqxAMekhRFd
        LpSjwzDhcX5unjURjkNj+qc=
X-Google-Smtp-Source: ABdhPJy+9YGnXHWLktpjXxPm4PgCr6fxzYJTVqUuSfeHM6qeAIlvoUjvHKYwb8m+XqYTlqFMwVGUDw==
X-Received: by 2002:a05:6214:1086:: with SMTP id o6mr20534054qvr.41.1597794189388;
        Tue, 18 Aug 2020 16:43:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 84sm21793627qkl.11.2020.08.18.16.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 16:43:08 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] lib/string.c: Disable tree-loop-distribute-patterns
Date:   Tue, 18 Aug 2020 19:43:07 -0400
Message-Id: <20200818234307.3382306-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc can transform the loop in a naive implementation of memset/memcpy
etc into a call to the function itself. This optimization is enabled by
-ftree-loop-distribute-patterns.

This has been the case for a while (see eg [0]), but gcc-10.x enables
this option at -O2 rather than -O3 as in previous versions.

Add -ffreestanding, which implicitly disables this optimization with
gcc. It is unclear whether clang performs such optimizations, but
hopefully it will also not do so in a freestanding environment.

This by itself is insufficient for gcc if the optimization was
explicitly enabled by CFLAGS, so also add a flag to explicitly disable
it.

[0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=56888

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 lib/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index e290fc5707ea..80edea49613f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -15,11 +15,18 @@ KCOV_INSTRUMENT_debugobjects.o := n
 KCOV_INSTRUMENT_dynamic_debug.o := n
 KCOV_INSTRUMENT_fault-inject.o := n
 
+# string.o implements standard library functions like memset/memcpy etc.
+# Use -ffreestanding to ensure that the compiler does not try to "optimize"
+# them into calls to themselves.
+# The optimization pass that does such transformations in gcc is
+# tree-loop-distribute-patterns. Explicitly disable it just in case.
+CFLAGS_string.o := -ffreestanding $(call cc-option,-fno-tree-loop-distribute-patterns)
+
 # Early boot use of cmdline, don't instrument it
 ifdef CONFIG_AMD_MEM_ENCRYPT
 KASAN_SANITIZE_string.o := n
 
-CFLAGS_string.o := -fno-stack-protector
+CFLAGS_string.o += -fno-stack-protector
 endif
 
 # Used by KCSAN while enabled, avoid recursion.
-- 
2.26.2

