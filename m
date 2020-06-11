Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F37FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE30C2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgFKWDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:03:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37058 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKWDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:03:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id b27so7191456qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ArGjVW4oQ7C5SwrlBjOLMgTUCNvN058wc3V7i+UWSxo=;
        b=hvNS/GrbsIHtDzvSneE134GQ3hF7Wid6M89QMBNx87JQBdDR/+03X4y9MKv8xy78L8
         2Qbw8MIHT95SLgDtBz97Ql0+3YrBtFqm1g31q2rUzcBPOTVXL61FkCrpb3UQVfhHFZdP
         PnVCKrgEfGCEG7RvCpa2vdAmc773+ZNakkDDPsCd7pocDzqfvyNBphmWK9Nyl8MBQ6gM
         w9E3d1kUfCAOOeX3wdBG3hcvXKMY5mgUCv5exXqVHIW8fE8221G/HdyNHzjbpE8GJdkl
         blisGxTpCSTwCpjLb1HDoz+Iwv/yioYDGb0RJoe+YnLzieQ4S7Os7nqG4Ujl4g8VDbxt
         aCfg==
X-Gm-Message-State: AOAM530iXDff3JT9HETil2V7GlKJn9Aj6RG7L3H6YYf9fFJz3SKeefCH
        K/RcrWC9L5/rZelDDE0YynI=
X-Google-Smtp-Source: ABdhPJzvypHTSukmK059GZC89FqO3omNdS/JEWIyl3RuWHVSgciuF5Vt8qSV5cZZrYPmdOxsFQX7yw==
X-Received: by 2002:a37:3d2:: with SMTP id 201mr138413qkd.64.1591913020455;
        Thu, 11 Jun 2020 15:03:40 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u25sm3411338qtc.11.2020.06.11.15.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 15:03:39 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] Makefile: Improve compressed debug info support detection
Date:   Thu, 11 Jun 2020 18:03:39 -0400
Message-Id: <20200611220339.3971675-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAKwvOdnddAjiXDKA8fp3n2NN+R=Syp2N5DHbp1j=VRzM1dNnRw@mail.gmail.com>
References: <CAKwvOdnddAjiXDKA8fp3n2NN+R=Syp2N5DHbp1j=VRzM1dNnRw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit
  10e68b02c861 ("Makefile: support compressed debug info")
added support for compressed debug sections.

Support is detected by checking
- does the compiler support -gz=zlib
- does the assembler support --compressed-debug-sections=zlib
- does the linker support --compressed-debug-sections=zlib

However, the gcc driver's support for this option is somewhat
convoluted. The driver's builtin specs are set based on the version of
binutils that it was configured with. It reports an error if the
configure-time linker/assembler (i.e., not necessarily the actual
assembler that will be run) do not support the option, but only if the
assembler (or linker) is actually invoked when -gz=zlib is passed.

The cc-option check in scripts/Kconfig.include does not invoke the
assembler, so the gcc driver reports success even if it does not support
the option being passed to the assembler.

Because the as-option check passes the option directly to the assembler
via -Wa,--compressed-debug-sections=zlib, the gcc driver does not see
this option and will never report an error.

Combined with an installed version of binutils that is more recent than
the one the compiler was built with, it is possible for all three tests
to succeed, yet an actual compilation with -gz=zlib to fail.

Moreover, it is unnecessary to explicitly pass
--compressed-debug-sections=zlib to the assembler via -Wa, since the
driver will do that automatically when it supports -gz=zlib.

Convert the as-option to just -gz=zlib, simplifying it as well as
performing a better test of the gcc driver's capabilities.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 Makefile          | 2 +-
 lib/Kconfig.debug | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 839f9fee22cb..cb29e56f227a 100644
--- a/Makefile
+++ b/Makefile
@@ -842,7 +842,7 @@ endif
 
 ifdef CONFIG_DEBUG_INFO_COMPRESSED
 DEBUG_CFLAGS	+= -gz=zlib
-KBUILD_AFLAGS	+= -Wa,--compress-debug-sections=zlib
+KBUILD_AFLAGS	+= -gz=zlib
 KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
 endif
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cb98741601bd..94ce36be470c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -229,7 +229,7 @@ config DEBUG_INFO_COMPRESSED
 	bool "Compressed debugging information"
 	depends on DEBUG_INFO
 	depends on $(cc-option,-gz=zlib)
-	depends on $(as-option,-Wa$(comma)--compress-debug-sections=zlib)
+	depends on $(as-option,-gz=zlib)
 	depends on $(ld-option,--compress-debug-sections=zlib)
 	help
 	  Compress the debug information using zlib.  Requires GCC 5.0+ or Clang
-- 
2.26.2

