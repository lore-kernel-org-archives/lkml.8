Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E11C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3655020857
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583234687;
	bh=+nisL3WkJoq2bdo0p9sfNAiw3XpbUL4JalkI9nbycXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jzfb3cCchFos2uyRR/A9UjyyCZ4vzFr4uqRyI+QIkrFKvHna0MJ6sKPYqeJZofYA1
	 K9H/rxnn3X3IzHKT3Ypgt/jMg0jYd9ZBqgHqTcHefOyYiUXTC8jbvB4BdfQTzeDzfN
	 urOP19KzzqnRQzZCozJfH0jhESCwlSKMM2ZDPYog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgCCLYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:24:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbgCCLYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:24:45 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B57E20848;
        Tue,  3 Mar 2020 11:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583234684;
        bh=+nisL3WkJoq2bdo0p9sfNAiw3XpbUL4JalkI9nbycXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaShO6zq1GhVFCEKpYY1q7sCxR0DWQCuDjKX2B5ETfjtp+i2UfqGbZZKR7dt6ALEA
         nwK1p9nTZ12BGZ3y3MFVLqNYBcSnCy8VZfef85xUVrM7JQlrJNk2Ston7RVYiZrwnR
         Ae81+hqvVtlIK/+stChYw9hbgxgOAQ36GBBio458=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] bootconfig: Support O=<builddir> option
Date:   Tue,  3 Mar 2020 20:24:40 +0900
Message-Id: <158323468033.10560.14661631369326294355.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158323467008.10560.4307464503748340855.stgit@devnote2>
References: <158323467008.10560.4307464503748340855.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support O=<builddir> option to build bootconfig tool in
the other directory. As same as other tools, if you specify
O=<builddir>, bootconfig command is build under <builddir>.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/Makefile           |   27 +++++++++++++++++----------
 tools/bootconfig/test-bootconfig.sh |   14 ++++++++++----
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
index a6146ac64458..da5975775337 100644
--- a/tools/bootconfig/Makefile
+++ b/tools/bootconfig/Makefile
@@ -1,23 +1,30 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for bootconfig command
+include ../scripts/Makefile.include
 
 bindir ?= /usr/bin
 
-HEADER = include/linux/bootconfig.h
-CFLAGS = -Wall -g -I./include
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
 
-PROGS = bootconfig
+LIBSRC = $(srctree)/lib/bootconfig.c $(srctree)/include/linux/bootconfig.h
+CFLAGS = -Wall -g -I$(CURDIR)/include
 
-all: $(PROGS)
+ALL_TARGETS := bootconfig
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
-bootconfig: ../../lib/bootconfig.c main.c $(HEADER)
+all: $(ALL_PROGRAMS)
+
+$(OUTPUT)bootconfig: main.c $(LIBSRC)
 	$(CC) $(filter %.c,$^) $(CFLAGS) -o $@
 
-install: $(PROGS)
-	install bootconfig $(DESTDIR)$(bindir)
+test: $(ALL_PROGRAMS) test-bootconfig.sh
+	./test-bootconfig.sh $(OUTPUT)
 
-test: bootconfig
-	./test-bootconfig.sh
+install: $(ALL_PROGRAMS)
+	install $(OUTPUT)bootconfig $(DESTDIR)$(bindir)
 
 clean:
-	$(RM) -f *.o bootconfig
+	$(RM) -f $(OUTPUT)*.o $(ALL_PROGRAMS)
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 1411f4c3454f..81b350ffd03f 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -3,9 +3,16 @@
 
 echo "Boot config test script"
 
-BOOTCONF=./bootconfig
-INITRD=`mktemp initrd-XXXX`
-TEMPCONF=`mktemp temp-XXXX.bconf`
+if [ -d "$1" ]; then
+  TESTDIR=$1
+else
+  TESTDIR=.
+fi
+BOOTCONF=${TESTDIR}/bootconfig
+
+INITRD=`mktemp ${TESTDIR}/initrd-XXXX`
+TEMPCONF=`mktemp ${TESTDIR}/temp-XXXX.bconf`
+OUTFILE=`mktemp ${TESTDIR}/tempout-XXXX`
 NG=0
 
 cleanup() {
@@ -65,7 +72,6 @@ new_size=$(stat -c %s $INITRD)
 xpass test $new_size -eq $initrd_size
 
 echo "No error messge while applying"
-OUTFILE=`mktemp tempout-XXXX`
 dd if=/dev/zero of=$INITRD bs=4096 count=1
 printf " \0\0\0 \0\0\0" >> $INITRD
 $BOOTCONF -a $TEMPCONF $INITRD > $OUTFILE 2>&1

