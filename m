Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB38C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C6620797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgIEWXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:23:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39119 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgIEWX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:23:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id 92so7459557qtb.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 15:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfCbsJHJIpPjEZXsAp6VZMgqo72dfp1L92iresHikKM=;
        b=As4O+ga6noQaFH0NSgM3ItSlOTZXnAvmtQfz6+E+p7ZZ9uu0XnsdLdAn2XlrMhAgVD
         BCU68iv2jKjNl47+yIjgLotrEMgTffmnqmqsY9HRXgtQtwJBPbroqpxaIacWdEbptUmB
         VXNs2feINrMmOVquTxGxk65hXIWLidprE86lYQbh5D8YDHJnzjQpq/GwqSJkBk1Tk5NB
         8aijKglzZUq/MluBCF8K7Sk2lQsy29GDTPC8Wy0GS2t8W+3098EByTDVoXBuMj6jrlTF
         4GPYBSR168WjGIFI/JOIt5PwT8upnWvztYxXxmDPtlZ7BfSmTPpX86eNYP2RjjwirrIy
         RErg==
X-Gm-Message-State: AOAM530O0XoYe9zCSkzlk2wLH4PAntCj4SnCKTNLIi64KO+nT/IXNP7u
        1YSiaiTsykc3Psfc0xH4kiE=
X-Google-Smtp-Source: ABdhPJzVD81zxPO2UpAvs991SlxhYf4d3DKLnCV3tv4lDxedNfxUd5GkRlVjATyD6g3yJL/bF+hB1Q==
X-Received: by 2002:ac8:5b47:: with SMTP id n7mr15000945qtw.7.1599344605186;
        Sat, 05 Sep 2020 15:23:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n203sm7323886qke.66.2020.09.05.15.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 15:23:24 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, kasan-dev@googlegroups.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] lib/string: Disable instrumentation
Date:   Sat,  5 Sep 2020 18:23:22 -0400
Message-Id: <20200905222323.1408968-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905222323.1408968-1-nivedita@alum.mit.edu>
References: <20200905222323.1408968-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

String functions can be useful in early boot, but using instrumented
versions can be problematic: eg on x86, some of the early boot code is
executing out of an identity mapping rather than the kernel virtual
addresses. Accessing any global variables at this point will lead to a
crash.

Tracing and KCOV are already disabled, and CONFIG_AMD_MEM_ENCRYPT will
additionally disable KASAN and stack protector.

Additionally disable GCOV, UBSAN, KCSAN, STACKLEAK_PLUGIN and branch
profiling, and make it unconditional to allow safe use of string
functions.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 lib/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index a4a4c6864f51..5e421769bbc6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -8,7 +8,6 @@ ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 # These files are disabled because they produce lots of non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. For example,
 # rbtree can be global and individual rotations don't correlate with inputs.
-KCOV_INSTRUMENT_string.o := n
 KCOV_INSTRUMENT_rbtree.o := n
 KCOV_INSTRUMENT_list_debug.o := n
 KCOV_INSTRUMENT_debugobjects.o := n
@@ -20,12 +19,16 @@ KCOV_INSTRUMENT_fault-inject.o := n
 # them into calls to themselves.
 CFLAGS_string.o := -ffreestanding
 
-# Early boot use of cmdline, don't instrument it
-ifdef CONFIG_AMD_MEM_ENCRYPT
+# Early boot use of string functions, disable instrumentation
+GCOV_PROFILE_string.o := n
+KCOV_INSTRUMENT_string.o := n
 KASAN_SANITIZE_string.o := n
+UBSAN_SANITIZE_string.o := n
+KCSAN_SANITIZE_string.o := n
 
 CFLAGS_string.o += -fno-stack-protector
-endif
+CFLAGS_string.o += $(DISABLE_STACKLEAK_PLUGIN)
+CFLAGS_string.o += -DDISABLE_BRANCH_PROFILING
 
 # Used by KCSAN while enabled, avoid recursion.
 KCSAN_SANITIZE_random32.o := n
-- 
2.26.2

