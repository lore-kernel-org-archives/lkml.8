Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F98FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D76421508
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590767764;
	bh=ItjmT7nGukgJqnbHLVU7xi8Aihg6V6CcvZWmMMuotTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cXQj3MAIUmLyRt+j9DyDJUOeLfvbJxCkKP888zfSePaocmuNVERtaq302wnIPX+eQ
	 QmjoU2whms0GNGzYWQhp99mPUw83QUIJBTXhFmeI3ORzfv/VfYJTGB8Xivy2mUwqKf
	 D0Y8blaagroEsYJcJwKoRVFuewiSfqyj10qo+7KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgE2P4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgE2P4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:56:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C765F20814;
        Fri, 29 May 2020 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590767762;
        bh=ItjmT7nGukgJqnbHLVU7xi8Aihg6V6CcvZWmMMuotTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APT7OvdXZFWM+LukNDBEzC1CkzW6QOlnZBgPFmYFNpWWFcEB/hsSUebwjsAT0Hdpg
         IIz6HyFHZbueeRl+KBfCMc9ut3PeyzA2ujaWgD6gAKElCDVZHZ+DbxZ+PeZP0gH7Rj
         QC+ufI1iHeISOSea6ggVBoon9y+LPDQcA5nJbVDA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] perf build: Group the NO_SYSCALL_TABLE logic
Date:   Fri, 29 May 2020 12:55:51 -0300
Message-Id: <20200529155552.463-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200529155552.463-1-acme@kernel.org>
References: <20200529155552.463-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To help in allowing to disable it from the make command line.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ae325f79e598..93fb7510a9a9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -23,12 +23,26 @@ include $(srctree)/tools/scripts/Makefile.arch
 $(call detected_var,SRCARCH)
 
 NO_PERF_REGS := 1
+
 NO_SYSCALL_TABLE := 1
 
+ifeq ($(SRCARCH),x86)
+  ifeq (${IS_64_BIT}, 1)
+    NO_SYSCALL_TABLE := 0
+  endif
+else
+  ifneq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390))
+    NO_SYSCALL_TABLE := 0
+  endif
+endif
+
+ifneq ($(NO_SYSCALL_TABLE),1)
+  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
+endif
+
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
   NO_PERF_REGS := 0
-  NO_SYSCALL_TABLE := 0
   CFLAGS += -I$(OUTPUT)arch/powerpc/include/generated
   LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
 endif
@@ -37,7 +51,6 @@ endif
 ifeq ($(SRCARCH),x86)
   $(call detected,CONFIG_X86)
   ifeq (${IS_64_BIT}, 1)
-    NO_SYSCALL_TABLE := 0
     CFLAGS += -DHAVE_ARCH_X86_64_SUPPORT -I$(OUTPUT)arch/x86/include/generated
     ARCH_INCLUDE = ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/memset_64.S
     LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
@@ -55,7 +68,6 @@ endif
 
 ifeq ($(SRCARCH),arm64)
   NO_PERF_REGS := 0
-  NO_SYSCALL_TABLE := 0
   CFLAGS += -I$(OUTPUT)arch/arm64/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
 endif
@@ -70,7 +82,6 @@ endif
 
 ifeq ($(ARCH),s390)
   NO_PERF_REGS := 0
-  NO_SYSCALL_TABLE := 0
   CFLAGS += -fPIC -I$(OUTPUT)arch/s390/include/generated
 endif
 
@@ -78,10 +89,6 @@ ifeq ($(NO_PERF_REGS),0)
   $(call detected,CONFIG_PERF_REGS)
 endif
 
-ifneq ($(NO_SYSCALL_TABLE),1)
-  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
-endif
-
 # So far there's only x86 and arm libdw unwind support merged in perf.
 # Disable it on all other architectures in case libdw unwind
 # support is detected in system. Add supported architectures
-- 
2.25.3

