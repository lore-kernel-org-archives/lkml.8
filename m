Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF93C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F2F204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgHSOI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:08:28 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43153 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgHSOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:08:20 -0400
Received: by mail-qv1-f66.google.com with SMTP id l13so11265696qvt.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 07:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RV6pBQZ9MRlDByHN1h5rkzmXbG7Gch7l2dQUZjdYLUM=;
        b=Ov5HisfNHCKHGzrQbjy3GkCQdMRAXFSCnIhK643itZsU6MV6I5S/YvTQmaJeP+fSxR
         ZqraXO6DLID8+dDGqNjApVaGEP+DJ0PN4FlVc9dn4JwkZhAiBpumc+hyUFeYDTAwwCp8
         IHaQeE+UIDcySa1yt3z+GE2ykOveCDBCa4XXxvY1fyIwTOrjheUPh5nJaCh2K0un34bt
         3xR4LQ4UtbjjVzeFc/Hsd9MbgoaA51FW5Vdd93d8N+7E5zcZUNEkpx4tLtKEYOMCyEfZ
         paI5JprgTPUJ+ixcsgpMPcyvV8MbqoUHlKkaZn6DydB+sni5KebH/Gj1v/O39IJAaA98
         cEoA==
X-Gm-Message-State: AOAM5324NI5MajSg8367Yy5NHZaQCasY7Droj7R0mZBkkoUgY3h6n0iV
        2iwlaOxt2vpFddF32cIqqRs=
X-Google-Smtp-Source: ABdhPJwuBxYUl/K6eoTWOrOwwpZw5p7Taymb/kYOVf3CCRNOP+SeWm5c+/06++FLVgAIcPfjJr389w==
X-Received: by 2002:ad4:4984:: with SMTP id t4mr24046002qvx.110.1597846098109;
        Wed, 19 Aug 2020 07:08:18 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v2sm26975641qte.25.2020.08.19.07.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 07:08:16 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v2] lib/string.c: Use freestanding environment
Date:   Wed, 19 Aug 2020 10:08:16 -0400
Message-Id: <20200819140816.3807604-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAHk-=wiJLvqS1_O+yAQSZr-Lj49HdJyLpt3J_nW=otHLfEN4RA@mail.gmail.com>
References: <CAHk-=wiJLvqS1_O+yAQSZr-Lj49HdJyLpt3J_nW=otHLfEN4RA@mail.gmail.com>
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

[0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=56888

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 lib/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index e290fc5707ea..a4a4c6864f51 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -15,11 +15,16 @@ KCOV_INSTRUMENT_debugobjects.o := n
 KCOV_INSTRUMENT_dynamic_debug.o := n
 KCOV_INSTRUMENT_fault-inject.o := n
 
+# string.o implements standard library functions like memset/memcpy etc.
+# Use -ffreestanding to ensure that the compiler does not try to "optimize"
+# them into calls to themselves.
+CFLAGS_string.o := -ffreestanding
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

