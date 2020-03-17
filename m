Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E05CC5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7D720754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgCQVzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgCQVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:55:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6E42073E;
        Tue, 17 Mar 2020 21:55:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jEKB6-000Eum-Ur; Tue, 17 Mar 2020 17:55:12 -0400
Message-Id: <20200317215512.831440685@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 17:54:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 3/5] bootconfig: Support O=<builddir> option
References: <20200317215455.885042360@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Support O=<builddir> option to build bootconfig tool in
the other directory. As same as other tools, if you specify
O=<builddir>, bootconfig command is build under <builddir>.

Link: http://lkml.kernel.org/r/158323468033.10560.14661631369326294355.stgit@devnote2

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/Makefile           | 27 +++++++++++++++++----------
 tools/bootconfig/test-bootconfig.sh | 14 ++++++++++----
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
-- 
2.25.1


