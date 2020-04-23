Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC249C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAAA208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587627728;
	bh=MCdlm1Cwbqqdk9PJI2Rc/okv5yFGjb65OVcf97+CElA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a4iaDFbLyVaEBGKL1UKoOPyJ6LLWrH2QhIIGRRvq3c+XnwYg9JNfYQ4/n875zqwPD
	 PJ+EC4OzF2OTzLRjEI45Bmz0kQtA0MxltLJjC3qORRrCWagH9fDxweVUSPbcRK06wb
	 Q3deUyLNFHC9KdIB3hUhdKQD6uOlens+MFCwnZ7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgDWHmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:42:07 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:31737 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:40:31 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9W000368;
        Thu, 23 Apr 2020 16:39:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9W000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627584;
        bh=IOtkXOaBmjWxmjZkP0pk5es2tQnZPFsfxI9iU204lI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAGrgZED1hzAxkrN0HQzkWFMT2ex9n2vQ8G8+5UfudJnj7te6r8Aj7cegBNmyLjZb
         fWpTYOdDoJ2oOWSjz++TiBdrNdnY0to9blRllHBjAulb/8ccmeRZFcBBt4KwkZxxGg
         noYGrF3KItotaHsTdaN3HoCzIS+PbII5XO9/1QuZ3ncJP317qbKJwCH0vdfFWlsicJ
         3SP7mL4X/LR6NUI1fOmhfCJKR5AwnyHmHR4wORaVomu+deg9nnnQltF/TAOn1kU8fc
         AkIEVqUwz4piWFHpY+ju8kZ6Cndi5v93nnz1IJ1yAiiKiNDHWwqT6USzg5F/O9e0kA
         uyu4zvzUx9G5A==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/16] samples: vfs: build sample programs for target architecture
Date:   Thu, 23 Apr 2020 16:39:24 +0900
Message-Id: <20200423073929.127521-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423073929.127521-1-masahiroy@kernel.org>
References: <20200423073929.127521-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These userspace programs include UAPI headers exported to usr/include/.
'make headers' always works for the target architecture (i.e. the same
architecture as the kernel), so the sample programs must be built for
the target as well. Kbuild now supports the 'userprogs' syntax to
describe it cleanly.

I also guarded the CONFIG option by 'depends on CC_CAN_LINK' because
$(CC) may not necessarily provide libc.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 samples/Kconfig      |  2 +-
 samples/vfs/Makefile | 11 +++--------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 2e0ef2cc1aa8..b8beb6fd75b4 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -184,7 +184,7 @@ config SAMPLE_ANDROID_BINDERFS
 
 config SAMPLE_VFS
 	bool "Build example programs that use new VFS system calls"
-	depends on HEADERS_INSTALL
+	depends on CC_CAN_LINK && HEADERS_INSTALL
 	help
 	  Build example userspace programs that use new VFS system calls such
 	  as mount API and statx().  Note that this is restricted to the x86
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 65acdde5c117..f3831466c1bb 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,10 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# List of programs to build
-hostprogs := \
-	test-fsmount \
-	test-statx
+userprogs := test-fsmount test-statx
+always-y := $(userprogs)
 
-always-y := $(hostprogs)
-
-HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
-HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
+user-ccflags += -I usr/include
-- 
2.25.1

