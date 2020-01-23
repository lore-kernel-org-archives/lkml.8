Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F7FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A03214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579793636;
	bh=CbL1aJ0UwkU97AqOSFgTSE6EmAKzy4J8APOtpuCZjCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l1TqD0kzuqFq0GyiWnPzpyyaHNi+HX5I24Qh+yuWAy26FvtEd2VgAsZ55QYC+gGtC
	 7JzHI6oG7a7/IgmdepDryUdIpIM/j2I4IPguChhRPxVSSgdxnHTMOYldUiLy9/V7YT
	 4VoZVJ/H6+91orD1xTF/6RE97SMrXDgUVTFsiDyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAWPdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWPdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:33:54 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C4A21D7D;
        Thu, 23 Jan 2020 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579793633;
        bh=CbL1aJ0UwkU97AqOSFgTSE6EmAKzy4J8APOtpuCZjCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXFFB+X+SSjeiz5f5JzyONAFNVXBbiLfiQj/kLw4ZaMP2Rbqd1JAGsO/T96Jh1LNC
         VbeHGTcVzNSriENLnYP6A/XByytHTbn++yflEp/QPPU+MfsbRtu8YJnEP+jJJvsKDm
         SoyXZDUDjiNO4aP4XOUmr6SCEw+NZj7jHrj2sCSU=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 01/10] compiler/gcc: Emit build-time warning for GCC prior to version 4.8
Date:   Thu, 23 Jan 2020 15:33:32 +0000
Message-Id: <20200123153341.19947-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
References: <20200123153341.19947-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
discarding the 'volatile' qualifier:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145

We've been working around this using some nasty hacks which make
READ_ONCE() both horribly complicated and also prevent us from enforcing
that it is only used on scalar types. Since GCC 4.8 is pretty old for
kernel builds now, emit a warning if we detect it during the build.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 init/Kconfig            | 4 ++--
 scripts/Kconfig.include | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a34064a031a5..bdc2f1b1667b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -10,11 +10,11 @@ config DEFCONFIG_LIST
 	default "arch/$(ARCH)/defconfig"
 
 config CC_IS_GCC
-	def_bool $(success,$(CC) --version | head -n 1 | grep -q gcc)
+	def_bool $(cc-is-gcc)
 
 config GCC_VERSION
 	int
-	default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
+	default $(gcc-version) if CC_IS_GCC
 	default 0
 
 config CC_IS_CLANG
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index d4adfbe42690..4e645a798b56 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -40,3 +40,9 @@ $(error-if,$(success, $(LD) -v | grep -q gold), gold linker '$(LD)' not supporte
 
 # gcc version including patch level
 gcc-version := $(shell,$(srctree)/scripts/gcc-version.sh $(CC))
+
+# Return y if the compiler is GCC, n otherwise
+cc-is-gcc := $(success,$(CC) --version | head -n 1 | grep -q gcc)
+
+# Warn if the compiler is GCC prior to 4.8
+$(warning-if,$(if-success,[ $(gcc-version) -lt 40800 ],$(cc-is-gcc),n),"Your compiler is old and may miscompile the kernel due to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 - please upgrade it.")
-- 
2.25.0.341.g760bfbb309-goog

