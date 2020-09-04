Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1242AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79BC2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599250669;
	bh=m9FyUXeq66QX8+kmTq7cWkAwxG+nD78DPHWGeQytj6o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=s3SMc3pOfRzgQj7Nas0PA+accck+siF/7/aVYkXKkpnrh5fGpTxjLhNcBM/3ok3YT
	 iCnXB89dTjh7iNA2gAeAONZALgv6p1+3gwtTMLlLp/Tbf7q1ktA3ykGjN4gHdWf8HW
	 KKwGagBDqP1cNPchtxe//UqioRN8i6zm+ZwKo6U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIDURr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgIDURq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:17:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846B12084D;
        Fri,  4 Sep 2020 20:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599250666;
        bh=m9FyUXeq66QX8+kmTq7cWkAwxG+nD78DPHWGeQytj6o=;
        h=Date:From:To:Cc:Subject:From;
        b=HIRhNw30CnYP/CsyX/vW/aPY314339SUOfxt1Zffv8Gb1eXZ5yyU8vvJEAI2mRRxI
         TpqR8K+zfnx2GHBy8lhWffZSJF4o1N2Dwc8/JLh1OkosbmUpFuDoFh8GifEC+JadfG
         /BZS4rcmjvNwZ6JabLdoINS2zi/Y5YljrMhkN9Oc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E25CF40D3D; Fri,  4 Sep 2020 17:17:42 -0300 (-03)
Date:   Fri, 4 Sep 2020 17:17:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH/RFC] perf tools: Make GTK2 support opt-in
Message-ID: <20200904201742.GI3753976@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is bitrotting, nobody is stepping up to work on it, and since we
treat warnings as errors, feature detection is failing in its main,
faster test (tools/build/feature/test-all.c) because of the GTK+2
infobar check. So make this opt-in, at some point ditch this if nobody
volunteers to take care of this.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

---

Now to check the next test-all.c failure:

[acme@five perf]$ cat /tmp/build/perf/feature/test-all.make.output
/usr/bin/ld: /tmp/ccywyyOR.o: in function `main_test_libzstd':
/home/acme/git/perf/tools/build/feature/test-libzstd.c:8: undefined reference to `ZSTD_createCStream'
/usr/bin/ld: /home/acme/git/perf/tools/build/feature/test-libzstd.c:9: undefined reference to `ZSTD_freeCStream'
collect2: error: ld returned 1 exit status
[acme@five perf]$

Probably just a lack of -Lzstd to the test-all target...

---

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 8b381d8ec9ded098..d37e11732f44cec1 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -38,8 +38,6 @@ FEATURE_TESTS_BASIC :=                  \
         get_current_dir_name            \
         gettid				\
         glibc                           \
-        gtk2                            \
-        gtk2-infobar                    \
         libbfd                          \
         libbfd-buildid			\
         libcap                          \
@@ -82,6 +80,8 @@ FEATURE_TESTS_EXTRA :=                  \
          compile-32                     \
          compile-x32                    \
          cplus-demangle                 \
+         gtk2                           \
+         gtk2-infobar                   \
          hello                          \
          libbabeltrace                  \
          libbfd-liberty                 \
@@ -112,7 +112,6 @@ FEATURE_DISPLAY ?=              \
          dwarf                  \
          dwarf_getlocations     \
          glibc                  \
-         gtk2                   \
          libbfd                 \
          libbfd-buildid		\
          libcap                 \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 9e5f8db4a1689832..977067e34dff064d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -91,7 +91,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
 ###############################
 
 $(OUTPUT)test-all.bin:
-	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma
+	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma
 
 $(OUTPUT)test-hello.bin:
 	$(BUILD)
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 80c5795f324ba04f..2c955628fc1a702b 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -78,14 +78,6 @@
 # include "test-libslang.c"
 #undef main
 
-#define main main_test_gtk2
-# include "test-gtk2.c"
-#undef main
-
-#define main main_test_gtk2_infobar
-# include "test-gtk2-infobar.c"
-#undef main
-
 #define main main_test_libbfd
 # include "test-libbfd.c"
 #undef main
@@ -209,8 +201,6 @@ int main(int argc, char *argv[])
 	main_test_libelf_getshdrstrndx();
 	main_test_libunwind();
 	main_test_libslang();
-	main_test_gtk2(argc, argv);
-	main_test_gtk2_infobar(argc, argv);
 	main_test_libbfd();
 	main_test_libbfd_buildid();
 	main_test_backtrace();
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f73a85ea3e7fb20a..854da830b5ca2d98 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -724,12 +724,14 @@ ifndef NO_SLANG
   endif
 endif
 
-ifndef NO_GTK2
+ifdef GTK2
   FLAGS_GTK2=$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
+  $(call feature_check,gtk2)
   ifneq ($(feature-gtk2), 1)
     msg := $(warning GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev);
     NO_GTK2 := 1
   else
+    $(call feature_check,gtk2-infobar)
     ifeq ($(feature-gtk2-infobar), 1)
       GTK_CFLAGS := -DHAVE_GTK_INFO_BAR_SUPPORT
     endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b2a3f5b652fec7e5..920d8afb92387caf 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -48,7 +48,7 @@ include ../scripts/utilities.mak
 #
 # Define NO_SLANG if you do not want TUI support.
 #
-# Define NO_GTK2 if you do not want GTK+ GUI support.
+# Define GTK2 if you want GTK+ GUI support.
 #
 # Define NO_DEMANGLE if you do not want C++ symbol demangling.
 #
@@ -386,7 +386,7 @@ ifneq ($(OUTPUT),)
   CFLAGS += -I$(OUTPUT)
 endif
 
-ifndef NO_GTK2
+ifdef GTK2
   ALL_PROGRAMS += $(OUTPUT)libperf-gtk.so
   GTK_IN := $(OUTPUT)gtk-in.o
 endif
@@ -886,7 +886,7 @@ check: $(OUTPUT)common-cmds.h
 
 ### Installation rules
 
-ifndef NO_GTK2
+ifdef GTK2
 install-gtk: $(OUTPUT)libperf-gtk.so
 	$(call QUIET_INSTALL, 'GTK UI') \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(libdir_SQ)'; \
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 05cf2af9e2c27123..d09ec2f030719a39 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -60,7 +60,6 @@ static void library_status(void)
 	STATUS(HAVE_DWARF_SUPPORT, dwarf);
 	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
 	STATUS(HAVE_GLIBC_SUPPORT, glibc);
-	STATUS(HAVE_GTK2_SUPPORT, gtk2);
 #ifndef HAVE_SYSCALL_TABLE_SUPPORT
 	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
 #endif
