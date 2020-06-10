Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87101C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D50B20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgFJTLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:11:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37130 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbgFJTLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:11:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id d27so2697388qtg.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3j3QD52Sz0eJ6/MX6ZISWLQZvQqqC+mplsNdztQPG8=;
        b=T/wK0+47LIE/TgO4GKyITEnqYUROM/i5rd6L9U22S59wJqjrR3Jg/d1PpwVcgyMysf
         YkfSwwlGAyWYWacxL4GzC2MaqYRx8I41gy2n3z/5Z0euPZ1smLyjKpYVAPaKrV20Cq/u
         yPN5kwtZxeXROAhH70vE+uH7ENYBE9NWez68hmD2dNU7GA07/IEJO4XcN+2F9do7nu3n
         LfvFjeZKM78JoF2iX022qhTCu63FJA6nRoQ37CP3vFpHFh/wsyIjSDpLX3L/5qZdrJkc
         9rmUmYdO0AY/agyEOusBpn5cGqw+7k2YDM6FDSAELrTVJlsbg1AllzDMs9yCbfPGJA0s
         ZHdw==
X-Gm-Message-State: AOAM532FAlJfb2M0IGkAMtB6f4FOPCI0XhMfNc5/JTEPo2KKMrrbqrW3
        cUsTAx+fU+opEDdnx428oG0=
X-Google-Smtp-Source: ABdhPJz6YgjzBZleOHq0Sak3aZCp6Aj2Zy+4OpeFrqurFblchvxljHKlHQQmJEEYOVUlvLfLlmGg3A==
X-Received: by 2002:ac8:4448:: with SMTP id m8mr5052027qtn.4.1591816268230;
        Wed, 10 Jun 2020 12:11:08 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d140sm496959qkc.22.2020.06.10.12.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 12:11:07 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Fangrui Song <maskray@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Makefile: Improve compressed debug info support detection
Date:   Wed, 10 Jun 2020 15:11:06 -0400
Message-Id: <20200610191106.2662548-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610063715.v2qrqvwtegdxdwzl@google.com>
References: <20200610063715.v2qrqvwtegdxdwzl@google.com>
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
binutils that it was configured with, and it reports an error only if
the assembler (or linker) is actually invoked.

The cc-option check in scripts/Kconfig.include does not invoke the
assembler, so the gcc driver reports success even if it does not support
the option being passed to the assembler. Combined with an installed
version of binutils that is more recent than the one the compiler was
built with, it is possible for all three tests to succeed, yet an actual
compilation with -gz=zlib to fail.

Moreover, it is unnecessary to explicitly pass
--compressed-debug-sections=zlib to the assembler via -Wa, since the
driver will do that automatically.

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

