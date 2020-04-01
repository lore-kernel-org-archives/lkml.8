Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73006C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1249F20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758866;
	bh=7QOQzZSJNdn6jehHqBbKqrU26W4MGHEWlsQRbBTn3WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WrAyj/IqzWgU6jG8EVu+SxYeiapOONf4Z1T0iVsJPyVM3VtBJvSEU0P6bQmgxKlIC
	 efUzHuI/MsAh69n/zzfAekRkSTRZR2tvWiCoQ1BF3ayVqWXb84QTYy+89wLMxa01gT
	 fN+7i3qJBdvm/RT4lGhd9HM0EY9Hs1SSlPbSsQrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbgDAQeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:32872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732532AbgDAQeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:34:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB22206F8;
        Wed,  1 Apr 2020 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758861;
        bh=7QOQzZSJNdn6jehHqBbKqrU26W4MGHEWlsQRbBTn3WU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivMCwP/68sdR174oO2cATQJqf6Doy3W/4C7JSEKfhVoXciQ5gqeH85q6H05/M+psg
         qrEAu8IwqHGEFUrwar9u+SLIXJ3d6WvCsEk4+uX9b9S3kfR7ADJcBk5xoKuR7LLLgU
         SfNuLLebBchkjuz6sC8IklcTIYq3y5mYgntJJpiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.4 66/91] tools: Let O= makes handle a relative path with -C option
Date:   Wed,  1 Apr 2020 18:18:02 +0200
Message-Id: <20200401161535.518867632@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit be40920fbf1003c38ccdc02b571e01a75d890c82 ]

When I tried to compile tools/perf from the top directory with the -C
option, the O= option didn't work correctly if I passed a relative path:

  $ make O=BUILD -C tools/perf/
  make: Entering directory '/home/mhiramat/ksrc/linux/tools/perf'
    BUILD:   Doing 'make -j8' parallel build
  ../scripts/Makefile.include:4: *** O=/home/mhiramat/ksrc/linux/tools/perf/BUILD does not exist.  Stop.
  make: *** [Makefile:70: all] Error 2
  make: Leaving directory '/home/mhiramat/ksrc/linux/tools/perf'

The O= directory existence check failed because the check script ran in
the build target directory instead of the directory where I ran the make
command.

To fix that, once change directory to $(PWD) and check O= directory,
since the PWD is set to where the make command runs.

Fixes: c883122acc0d ("perf tools: Let O= makes handle relative paths")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: stable@vger.kernel.org
Link: http://lore.kernel.org/lkml/158351957799.3363.15269768530697526765.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile            | 2 +-
 tools/scripts/Makefile.include | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 55933b2eb9324..a733e9cf343a3 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -34,7 +34,7 @@ endif
 # Only pass canonical directory names as the output directory:
 #
 ifneq ($(O),)
-  FULL_O := $(shell readlink -f $(O) || echo $(O))
+  FULL_O := $(shell cd $(PWD); readlink -f $(O) || echo $(O))
 endif
 
 #
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 7ea4438b801dd..882c18201c7c3 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -1,7 +1,7 @@
 ifneq ($(O),)
 ifeq ($(origin O), command line)
-	dummy := $(if $(shell test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
-	ABSOLUTE_O := $(shell cd $(O) ; pwd)
+	dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
+	ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
 	OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
 	COMMAND_O := O=$(ABSOLUTE_O)
 ifeq ($(objtree),)
-- 
2.20.1



