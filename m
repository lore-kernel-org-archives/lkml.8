Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB919C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E94120684
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599246228;
	bh=muFcJp8E1gbBcdaar0E+RCiRJK6ts1EbXJNqVBc7KNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hUR1GQ9pChoSjlI1kDhgCapEAW3Eqw535d+LgFy1KRQA6u7bTmMBVOgTAImFICeGO
	 g37vV79ZAYpAnhtlV+G6l8vTjGCcIhCAOvnzmuJp9C9yMgWAUawRZTtdkzuikdncMz
	 u3kGped+yZQMc4OCFncILyFitHYCU1IcUYsQeT64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgIDTDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgIDTDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:03:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE03B20684;
        Fri,  4 Sep 2020 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599246220;
        bh=muFcJp8E1gbBcdaar0E+RCiRJK6ts1EbXJNqVBc7KNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vtYI58PHGSOWLnQP5RQUP+Z49Xk32TwYMXp+K/O8wacfb0hOGRLdt++//aRjLzW9C
         QBwIWqsm4c5M1ZkphsebI9iJ2wThpa9DJDex7jYA/ZnpJqytmUZmlRAb649FdRx3Bg
         HcjBVsbNvYNLa8b06X+KqH/hdL5RqtorPsBPjJEU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6261240D3D; Fri,  4 Sep 2020 16:03:37 -0300 (-03)
Date:   Fri, 4 Sep 2020 16:03:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Remi Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: Re: [PATCH v3 1/3] perf dso: Use libbfd to read build_id and
 .gnu_debuglink section
Message-ID: <20200904190337.GB3753976@kernel.org>
References: <20200821165238.1340315-1-rbernon@codeweavers.com>
 <20200903002519.GA3487700@kernel.org>
 <20200903165132.GA3495158@kernel.org>
 <76cc6da5-bf1e-4de3-7b79-b9759dc6e5b9@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76cc6da5-bf1e-4de3-7b79-b9759dc6e5b9@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 04, 2020 at 09:57:33AM +0200, Remi Bernon escreveu:
> On 2020-09-03 18:51, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Sep 02, 2020 at 09:25:19PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Aug 21, 2020 at 06:52:36PM +0200, Remi Bernon escreveu:
> > > > Wine generates PE binaries for most of its modules and perf is unable
> > > > to parse these files to get build_id or .gnu_debuglink section.
> > > > 
> > > > Using libbfd when available, instead of libelf, makes it possible to
> > > > resolve debug file location regardless of the dso binary format.
> > > > 
> > > > Signed-off-by: Remi Bernon <rbernon@codeweavers.com>
> > > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Jacek Caban <jacek@codeweavers.com>
> > > > ---
> > > > 
> > > > v3: Rebase and small changes to PATCH 2/3 and and PATCH 3/3.
> > > > 
> > > >   tools/perf/util/symbol-elf.c | 80 ++++++++++++++++++++++++++++++++++--
> > > >   1 file changed, 77 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > > > index 8cc4b0059fb0..f7432c4a4154 100644
> > > > --- a/tools/perf/util/symbol-elf.c
> > > > +++ b/tools/perf/util/symbol-elf.c
> > > > @@ -50,6 +50,10 @@ typedef Elf64_Nhdr GElf_Nhdr;
> > > >   #define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
> > > >   #endif
> > > > +#ifdef HAVE_LIBBFD_SUPPORT
> > > 
> > > So, the feature test should also test for the buildid struct field, see
> > > below:
> > > 
> > > > +#define PACKAGE 'perf'
> > > > +#include <bfd.h>
> > > > +#else
> > > >   #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
> > > >   extern char *cplus_demangle(const char *, int);
> > > > @@ -65,9 +69,7 @@ static inline char *bfd_demangle(void __maybe_unused *v,
> > > >   {
> > > >   	return NULL;
> > > >   }
> > > > -#else
> > > > -#define PACKAGE 'perf'
> > > > -#include <bfd.h>
> > > > +#endif
> > > >   #endif
> > > >   #endif
> > > > @@ -530,6 +532,36 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
> > > >   	return err;
> > > >   }
> > > > +#ifdef HAVE_LIBBFD_SUPPORT
> > > > +
> > > > +int filename__read_build_id(const char *filename, void *bf, size_t size)
> > > > +{
> > > > +	int err = -1;
> > > > +	bfd *abfd;
> > > > +
> > > > +	abfd = bfd_openr(filename, NULL);
> > > > +	if (!abfd)
> > > > +		return -1;
> > > > +
> > > > +	if (!bfd_check_format(abfd, bfd_object)) {
> > > > +		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
> > > > +		goto out_close;
> > > > +	}
> > > > +
> > > > +	if (!abfd->build_id || abfd->build_id->size > size)
> > > > +		goto out_close;
> > > 
> > > amazonlinux:1, centos:6, debian:8, mageia:5, oraclelinux:6, ubuntu:14.04
> > > fail, its all old stuff, but adding a reference to abfd->build_id to the
> > > feature test that ends up defining HAVE_LIBBFD_SUPPORT will solve that,
> > > I'll do it tomorrow morning if you don't beat me to it.
> > > 
> > > util/symbol-elf.c: In function 'filename__read_build_id':
> > > util/symbol-elf.c:551:11: error: 'bfd {aka struct bfd}' has no member named 'build_id'
> > >    if (!abfd->build_id || abfd->build_id->size > size)
> > >             ^~
> > > util/symbol-elf.c:551:29: error: 'bfd {aka struct bfd}' has no member named 'build_id'
> > >    if (!abfd->build_id || abfd->build_id->size > size)
> > >                               ^~
> > > util/symbol-elf.c:554:17: error: 'bfd {aka struct bfd}' has no member named 'build_id'
> > >    memcpy(bf, abfd->build_id->data, abfd->build_id->size);
> > >                   ^~
> > > util/symbol-elf.c:554:39: error: 'bfd {aka struct bfd}' has no member named 'build_id'
> > >    memcpy(bf, abfd->build_id->data, abfd->build_id->size);
> > >                                         ^~
> > > util/symbol-elf.c:555:18: error: 'bfd {aka struct bfd}' has no member named 'build_id'
> > >    memset(bf + abfd->build_id->size, 0, size - abfd->build_id->size);
> > >                    ^~
> > > util/symbol-elf.c:555:50: error: 'bfd {aka struct bfd}' has no member named 'build_id'
> > >    memset(bf + abfd->build_id->size, 0, size - abfd->build_id->size);
> > >                                                    ^~
> > > util/symbol-elf.c:556:12: error: 'bfd {aka struct bfd}' has no member named 'build_id'
> > >    err = abfd->build_id->size;
> > >              ^~
> > >    CC       /tmp/build/perf/util/cap.o
> > > make[4]: *** [/tmp/build/perf/util/symbol-elf.o] Error 1
> > > make[4]: *** Waiting for unfinished jobs....
> > >    LD       /tmp/build/perf/util/scripting-engines/perf-in.o
> > >    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
> > > make[3]: *** [util] Error 2
> > > make[2]: *** [/tmp/build/perf/perf-in.o] Error 2
> > > make[2]: *** Waiting for unfinished jobs....
> > > make[1]: *** [sub-make] Error 2
> > > make: *** [all] Error 2
> > > make: Leaving directory `/git/linux/tools/perf'
> > > + exit 1
> > > [perfbuilder@five ~]$
> > 
> > So, I have the cset at the end of this message in front of your series +
> > the following patch applied to your patch, the debuglink part seems ok
> > and can continue depending on just libbfd, having or not abfd->buildid.
> > 
> 
> Thanks! I may have missed the first changeset you mention -- IIUC the one
> adding the feature check -- but it sounds good to me nonetheless.
> 
> Should I do anything?

No need at this time, here is the new feature test that ends up being
used to check if that abfd->build_id is present:

[acme@five perf]$ git log torvalds/master.. --oneline
d39497a94c1672c2 (HEAD -> perf/core) perf: ftrace: Add filter support for option -F/--funcs
6330d59303482407 perf tools: Consolidate close_control_option()'s into one function
bd0c035c66c933ee perf intel-pt: Document snapshot control command
7f5b197269a34f9a perf annotate: Add 'ret' (intel disasm style) as an alias for 'retq'
2481b0089bddb6b6 perf annotate: Allow configuring the 'disassembler_style' knob via 'perf config'
d20aff1512f013fa (quaco/perf/core) perf record: Add 'snapshot' control command
a8fcbd269b4340c3 perf tools: Add FIFO file names as alternative options to --control
1f4390d825cc04e9 perf tools: Use AsciiDoc formatting for --control option documentation
40db8ff59e75af10 perf tools: Handle read errors from ctl_fd
9864a66defeb8df0 perf tools: Consolidate --control option parsing into one function
ed21d6d7c48e6e96 perf tests: Add test for PE binary format support
eac9a4342e5447ca perf symbols: Try reading the symbol table with libbfd
ba0509dcb7f80640 perf dso: Use libbfd to read build_id and .gnu_debuglink section
e71e19a9ea70952a tools features: Add feature test to check if libbfd has buildid support
[acme@five perf]$


$ git show e71e19a9ea70952a
commit e71e19a9ea70952a53d58a99971820ce6c1794a8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Sep 3 13:44:39 2020 -0300

    tools features: Add feature test to check if libbfd has buildid support
    
    Which is needed by the PE executable support, for instance.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jacek Caban <jacek@codeweavers.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Remi Bernon <rbernon@codeweavers.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index c1daf4d57518c579..8b381d8ec9ded098 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -41,6 +41,7 @@ FEATURE_TESTS_BASIC :=                  \
         gtk2                            \
         gtk2-infobar                    \
         libbfd                          \
+        libbfd-buildid			\
         libcap                          \
         libelf                          \
         libelf-getphdrnum               \
@@ -113,6 +114,7 @@ FEATURE_DISPLAY ?=              \
          glibc                  \
          gtk2                   \
          libbfd                 \
+         libbfd-buildid		\
          libcap                 \
          libelf                 \
          libnuma                \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d220fe952747053a..9e5f8db4a1689832 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -15,6 +15,7 @@ FILES=                                          \
          test-hello.bin                         \
          test-libaudit.bin                      \
          test-libbfd.bin                        \
+         test-libbfd-buildid.bin		\
          test-disassembler-four-args.bin        \
          test-reallocarray.bin			\
          test-libbfd-liberty.bin                \
@@ -229,6 +230,9 @@ $(OUTPUT)test-libpython-version.bin:
 $(OUTPUT)test-libbfd.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
 
+$(OUTPUT)test-libbfd-buildid.bin:
+	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
+
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 5479e543b1947ee9..80c5795f324ba04f 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -90,6 +90,10 @@
 # include "test-libbfd.c"
 #undef main
 
+#define main main_test_libbfd_buildid
+# include "test-libbfd-buildid.c"
+#undef main
+
 #define main main_test_backtrace
 # include "test-backtrace.c"
 #undef main
@@ -208,6 +212,7 @@ int main(int argc, char *argv[])
 	main_test_gtk2(argc, argv);
 	main_test_gtk2_infobar(argc, argv);
 	main_test_libbfd();
+	main_test_libbfd_buildid();
 	main_test_backtrace();
 	main_test_libnuma();
 	main_test_numa_num_possible_cpus();
diff --git a/tools/build/feature/test-libbfd-buildid.c b/tools/build/feature/test-libbfd-buildid.c
new file mode 100644
index 0000000000000000..157644b04c052a51
--- /dev/null
+++ b/tools/build/feature/test-libbfd-buildid.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <bfd.h>
+
+int main(void)
+{
+	bfd *abfd = bfd_openr("Pedro", 0);
+	return abfd && (!abfd->build_id || abfd->build_id->size > 0x506564726f);
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 190be4fa5c2187f3..f73a85ea3e7fb20a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -825,6 +825,12 @@ else
   $(call feature_check,disassembler-four-args)
 endif
 
+ifeq ($(feature-libbfd-buildid), 1)
+  CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
+else
+  msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
+endif
+
 ifdef NO_DEMANGLE
   CFLAGS += -DNO_DEMANGLE
 else
