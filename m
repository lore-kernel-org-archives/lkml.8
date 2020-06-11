Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D77C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31AB20823
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591882746;
	bh=KOSKPdax8ilT+2RWtVgX6WzLD71Oo9MspvCoj5hcKoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I+zAXVGfC7mr+bQB+NGxT8G6NgtXogpyV+Ubrz4mkMsBLybfpoHPMBM47oAyp69lF
	 MDEFRYXseUsYFkABig64TrIE7Y0voonU63l43bCovJV6danp1oBIYuLwanewgDGrHI
	 iPMHgLyc6Jkq7ecBLq37I4UsK0yOLne+CYPL87bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgFKNjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgFKNjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:39:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A444C20760;
        Thu, 11 Jun 2020 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591882738;
        bh=KOSKPdax8ilT+2RWtVgX6WzLD71Oo9MspvCoj5hcKoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7BqD35GG4LxIIEw8wlnVj15rhSyhzxOGhGR6Xfq9B3LL55G0LvRYxnS5890uHyM1
         +3r8q0xckVU/jsraS6zEV1YAXfmu6vfF3/r3nX51I3YR1rzUBoio28TJy1HnzmktZ1
         Y6T4i4Xo2Xn0FxHKiapl7xuWf3zEzwWfvHxMBN64=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8759E40AFD; Thu, 11 Jun 2020 10:38:54 -0300 (-03)
Date:   Thu, 11 Jun 2020 10:38:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 00/10] perf parse-events: enable more flex/bison warnings
Message-ID: <20200611133854.GD18482@kernel.org>
References: <20200610215100.256599-1-irogers@google.com>
 <20200611090249.GC1786122@krava>
 <20200611130758.GA18482@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611130758.GA18482@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 11, 2020 at 10:07:58AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jun 11, 2020 at 11:02:49AM +0200, Jiri Olsa escreveu:
> > On Wed, Jun 10, 2020 at 02:50:50PM -0700, Ian Rogers wrote:
> > > All C compiler warnings are disabled are disabled by -w. This change
> > > removes the -w from flex and bison targets. To avoid implicit
> > > declarations header files are declared as targets and included.
> > > 
> > > Tested with GCC 9.3.0 and clang 9.0.1.
> > > 
> > > Previously posted as a single change:
> > > https://lore.kernel.org/lkml/20200609234344.3795-2-irogers@google.com/
> > > 
> > > Ian Rogers (10):
> > >   perf parse-events: Use automatic variable for flex input
> > >   perf parse-events: Use automatic variable for yacc input
> > >   perf pmu: Add bison debug build flag
> > >   perf pmu: Add flex debug build flag
> > >   perf parse-events: Declare flex header file output
> > >   perf parse-events: Declare bison header file output
> > >   perf parse-events: Disable a subset of flex warnings
> > >   perf expr: Avoid implicit lex function declaration
> > >   perf parse-events: Avoid implicit lex function declaration
> > >   perf parse-events: Disable a subset of bison warnings
> > 
> > looks great, I wonder what the -w replacement will do in
> > Arnaldo's distro test, but it'd be nice to get rid it
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> Thanks, applied locally and will submit it to the test build suite.

Failed so far for, I'll leave it running, its a holiday here today, so
I'll be on this occasionally, please look until the end of the (long)
message, there are errors for more distros, some are, as expected the
same, but should give a good idea of some extra fixes needed.

[root@quaco ~]# export PERF_TARBALL=http://192.168.124.1/perf/perf-5.7.0.tar.xz
[root@quaco ~]# time dm
Thu 11 Jun 2020 10:18:52 AM -03
# export PERF_TARBALL=http://192.168.124.1/perf/perf-5.7.0.tar.xz
# dm 
   1 alpine:3.4                    : FAIL gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : FAIL gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : FAIL gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : FAIL gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : FAIL gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : FAIL gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : FAIL gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:3.11                   : FAIL gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   9 alpine:3.12                   : FAIL gcc (Alpine 9.3.0) 9.3.0, Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  10 alpine:edge                   : FAIL gcc (Alpine 9.3.0) 9.3.0, Alpine clang version 10.0.0 (git://git.alpinelinux.org/aports 7445adce501f8473efdb93b17b5eaf2f1445ed4c)

I.e. all alpine versions, its Musl Libc

  CC       /tmp/build/perf/util/pmu-bison.o
In file included from util/parse-events.y:20:0:
/tmp/build/perf/util/parse-events-flex.h:1:0: error: unterminated #ifndef
 #ifndef parse_events_HEADER_H
 ^
/tmp/build/perf/util/parse-events-bison.c: In function 'parse_events_parse':
/tmp/build/perf/util/parse-events-bison.c:64:25: error: implicit declaration of function 'parse_events_lex' [-Werror=implicit-function-declaration]
 #define yylex           parse_events_lex
                         ^
/tmp/build/perf/util/parse-events-bison.c:1679:16: note: in expansion of macro 'yylex'
       yychar = yylex (&yylval, &yylloc, scanner);
                ^
cc1: all warnings being treated as errors
mv: can't rename '/tmp/build/perf/util/.parse-events-bison.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/parse-events-bison.o' failed
make[4]: *** [/tmp/build/perf/util/parse-events-bison.o] Error 1

But this is for 3.4, for 3.12 the error is one probably uncovered by these changes and we should fix:

  FLEX     /tmp/build/perf/util/parse-events-flex.c
  CC       /tmp/build/perf/util/parse-events-bison.o
In file included from util/parse-events.y:20:
/tmp/build/perf/util/parse-events-flex.h:1: error: unterminated #ifndef
    1 | #ifndef parse_events_HEADER_H
      | 
/tmp/build/perf/util/parse-events-bison.c: In function 'yydestruct':
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_YYEMPTY' not handled in switch [-Werror=switch-enum]
 1200 |   switch (yykind)
      |   ^~~~~~
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_YYEOF' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_YYerror' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_YYUNDEF' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_START_EVENTS' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_START_TERMS' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_VALUE' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_VALUE_SYM_HW' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_VALUE_SYM_SW' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_RAW' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_TERM' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_VALUE_SYM_TOOL' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_PREFIX_MEM' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_PREFIX_RAW' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_PREFIX_GROUP' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_ERROR' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_ARRAY_ALL' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_PE_ARRAY_RANGE' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_30_' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_31_' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_32_' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_33_' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_34_' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_35_' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_36_' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_37_' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_38_' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_YYACCEPT' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_start' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_start_events' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_value_sym' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_start_terms' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_sep_dc' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c:1200:3: error: enumeration value 'YYSYMBOL_sep_slash_slash_dc' not handled in switch [-Werror=switch-enum]
/tmp/build/perf/util/parse-events-bison.c: In function 'parse_events_parse':
/tmp/build/perf/util/parse-events-bison.c:69:25: error: implicit declaration of function 'parse_events_lex'; did you mean 'parse_events_name'? [-Werror=implicit-function-declaration]
   69 | #define yylex           parse_events_lex
      |                         ^~~~~~~~~~~~~~~~
/tmp/build/perf/util/parse-events-bison.c:1643:16: note: in expansion of macro 'yylex'
 1643 |       yychar = yylex (&yylval, &yylloc, scanner);
      |                ^~~~~
  FLEX     /tmp/build/perf/util/pmu-flex.c
cc1: all warnings being treated as errors
mv: can't rename '/tmp/build/perf/util/.parse-events-bison.o.tmp': No such file or directory
make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/parse-events-bison.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:625: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:231: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/linux/tools/perf'
+ exit 1
[root@quaco ~]# 

Should we disable this -Werror=switch-enum?


And:

  11 alt:p8                        : FAIL x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1), clang version 3.8.0 (tags/RELEASE_380/final)

Alt Linux as well, different error, this one seems to be one perhaps
uncovered by enabling the warnings when building those files, which is
good, right?

util/parse-events.l: In function 'parse_events_lex':
/tmp/build/perf/util/parse-events-flex.c:217:36: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:235:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^
util/parse-events.l:243:4: note: in expansion of macro 'REWIND'
    REWIND(0);
    ^
/tmp/build/perf/util/parse-events-flex.c:217:36: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:235:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^
util/parse-events.l:251:4: note: in expansion of macro 'REWIND'
    REWIND(1);
    ^
/tmp/build/perf/util/parse-events-flex.c:217:36: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:235:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^
util/parse-events.l:257:4: note: in expansion of macro 'REWIND'
    REWIND(0);
    ^
  CC       /tmp/build/perf/util/expr-flex.o
  CC       /tmp/build/perf/util/expr-bison.o
  CC       /tmp/build/perf/util/expr.o
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.parse-events-flex.o.tmp': No such file or directory


-=--------------------------------------------------------------------------------------------------------------------


  12  alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1), clang version 7.0.1 

Alt Linux p9 is a modern distro, so must have all that is needed, built
with both gcc and clang without problems, here are the logs for building
with GCC with NO_LIBBPF=1 and then, after that, for clang building with
everything:

make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= NO_LIBBPF=1 -C /git/linux/tools/perf O=/tmp/build/perf
make: Entering directory '/git/linux/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ on  ]
...                        libbfd: [ on  ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ OFF ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]

Makefile.config:536: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:773: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
Makefile.config:945: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:971: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
  GEN      /tmp/build/perf/common-cmds.h
  PERF_VERSION = 5.7.gc3d44cd87052
  MKDIR    /tmp/build/perf/fd/
  CC       /tmp/build/perf/exec-cmd.o
  CC       /tmp/build/perf/fd/array.o
  CC       /tmp/build/perf/event-parse.o
  CC       /tmp/build/perf/core.o
  CC       /tmp/build/perf/cpumap.o
  CC       /tmp/build/perf/threadmap.o
  CC       /tmp/build/perf/help.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/fs.o
  LD       /tmp/build/perf/fd/libapi-in.o
  CC       /tmp/build/perf/event-plugin.o
  CC       /tmp/build/perf/cpu.o
  CC       /tmp/build/perf/debug.o
  CC       /tmp/build/perf/evsel.o
  CC       /tmp/build/perf/pager.o
  CC       /tmp/build/perf/str_error_r.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/tracing_path.o
  CC       /tmp/build/perf/fs/cgroup.o
  CC       /tmp/build/perf/trace-seq.o
  CC       /tmp/build/perf/parse-options.o
  CC       /tmp/build/perf/run-command.o
  LD       /tmp/build/perf/fs/libapi-in.o
  CC       /tmp/build/perf/sigchain.o
  LD       /tmp/build/perf/libapi-in.o
  AR       /tmp/build/perf/libapi.a
  CC       /tmp/build/perf/subcmd-config.o
  CC       /tmp/build/perf/evlist.o
  CC       /tmp/build/perf/mmap.o
  CC       /tmp/build/perf/zalloc.o
  CC       /tmp/build/perf/parse-filter.o
  CC       /tmp/build/perf/parse-utils.o
  CC       /tmp/build/perf/xyarray.o
  CC       /tmp/build/perf/lib.o
  CC       /tmp/build/perf/kbuffer-parse.o
  CC       /tmp/build/perf/tep_strerror.o
  CC       /tmp/build/perf/event-parse-api.o
  GEN      perf-archive
  MKDIR    /tmp/build/perf/pmu-events/
  GEN      perf-with-kcore
  HOSTCC   /tmp/build/perf/pmu-events/json.o
  MKDIR    /tmp/build/perf/pmu-events/
  MKDIR    /tmp/build/perf/ui/gtk/
  HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
  CC       /tmp/build/perf/ui/gtk/browser.o
  LD       /tmp/build/perf/libtraceevent-in.o
  CC       /tmp/build/perf/plugin_jbd2.o
  LINK     /tmp/build/perf/libtraceevent.a
  CC       /tmp/build/perf/plugin_hrtimer.o
  LD       /tmp/build/perf/libperf-in.o
  HOSTCC   /tmp/build/perf/pmu-events/jevents.o
  MKDIR    /tmp/build/perf/ui/gtk/
  CC       /tmp/build/perf/ui/gtk/hists.o
  LD       /tmp/build/perf/plugin_jbd2-in.o
  AR       /tmp/build/perf/libperf.a
  CC       /tmp/build/perf/plugin_kmem.o
  LD       /tmp/build/perf/plugin_hrtimer-in.o
  CC       /tmp/build/perf/plugin_kvm.o
  CC       /tmp/build/perf/plugin_mac80211.o
  LD       /tmp/build/perf/plugin_kmem-in.o
  CC       /tmp/build/perf/plugin_sched_switch.o
  LD       /tmp/build/perf/libsubcmd-in.o
  LD       /tmp/build/perf/plugin_mac80211-in.o
  AR       /tmp/build/perf/libsubcmd.a
  CC       /tmp/build/perf/ui/gtk/setup.o
  LD       /tmp/build/perf/plugin_kvm-in.o
  CC       /tmp/build/perf/ui/gtk/util.o
  CC       /tmp/build/perf/plugin_function.o
  LD       /tmp/build/perf/plugin_sched_switch-in.o
  CC       /tmp/build/perf/plugin_xen.o
  HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
  LD       /tmp/build/perf/plugin_function-in.o
  LINK     /tmp/build/perf/pmu-events/jevents
  CC       /tmp/build/perf/ui/gtk/helpline.o
  LD       /tmp/build/perf/plugin_xen-in.o
  CC       /tmp/build/perf/plugin_scsi.o
  GEN      /tmp/build/perf/pmu-events/pmu-events.c
  LD       /tmp/build/perf/plugin_scsi-in.o
  CC       /tmp/build/perf/plugin_cfg80211.o
  LD       /tmp/build/perf/plugin_cfg80211-in.o
  LINK     /tmp/build/perf/plugin_jbd2.so
  LINK     /tmp/build/perf/plugin_hrtimer.so
  LINK     /tmp/build/perf/plugin_kmem.so
  CC       /tmp/build/perf/ui/gtk/progress.o
  LINK     /tmp/build/perf/plugin_kvm.so
  LINK     /tmp/build/perf/plugin_mac80211.so
  LINK     /tmp/build/perf/plugin_sched_switch.so
  CC       /tmp/build/perf/pmu-events/pmu-events.o
  LINK     /tmp/build/perf/plugin_function.so
  LINK     /tmp/build/perf/plugin_xen.so
  CC       /tmp/build/perf/ui/gtk/annotate.o
  LINK     /tmp/build/perf/plugin_scsi.so
  LINK     /tmp/build/perf/plugin_cfg80211.so
  CC       /tmp/build/perf/ui/gtk/zalloc.o
  GEN      /tmp/build/perf/libtraceevent-dynamic-list
  CC       /tmp/build/perf/builtin-bench.o
  CC       /tmp/build/perf/builtin-annotate.o
  CC       /tmp/build/perf/builtin-config.o
  CC       /tmp/build/perf/builtin-diff.o
  CC       /tmp/build/perf/builtin-evlist.o
  CC       /tmp/build/perf/builtin-ftrace.o
  CC       /tmp/build/perf/builtin-help.o
  CC       /tmp/build/perf/builtin-sched.o
  CC       /tmp/build/perf/builtin-buildid-list.o
  LD       /tmp/build/perf/pmu-events/pmu-events-in.o
  CC       /tmp/build/perf/builtin-buildid-cache.o
  CC       /tmp/build/perf/builtin-kallsyms.o
  CC       /tmp/build/perf/builtin-list.o
  CC       /tmp/build/perf/builtin-record.o
  CC       /tmp/build/perf/builtin-report.o
  LD       /tmp/build/perf/ui/gtk/gtk-in.o
  CC       /tmp/build/perf/builtin-stat.o
  CC       /tmp/build/perf/builtin-timechart.o
  LD       /tmp/build/perf/gtk-in.o
  LINK     /tmp/build/perf/libperf-gtk.so
  CC       /tmp/build/perf/builtin-top.o
  CC       /tmp/build/perf/builtin-script.o
  CC       /tmp/build/perf/builtin-kmem.o
  CC       /tmp/build/perf/builtin-lock.o
  CC       /tmp/build/perf/builtin-kvm.o
  CC       /tmp/build/perf/builtin-inject.o
  CC       /tmp/build/perf/builtin-mem.o
  CC       /tmp/build/perf/builtin-data.o
  CC       /tmp/build/perf/builtin-version.o
  CC       /tmp/build/perf/builtin-c2c.o
  CC       /tmp/build/perf/builtin-trace.o
  CC       /tmp/build/perf/builtin-probe.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-messaging.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/builtin-test.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/annotate.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-pipe.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/block-info.o
  CC       /tmp/build/perf/bench/mem-functions.o
  CC       /tmp/build/perf/arch/common.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/parse-events.o
  MKDIR    /tmp/build/perf/arch/x86/util/
  CC       /tmp/build/perf/arch/x86/util/header.o
  CC       /tmp/build/perf/bench/futex-hash.o
  MKDIR    /tmp/build/perf/arch/x86/util/
  CC       /tmp/build/perf/arch/x86/util/tsc.o
  CC       /tmp/build/perf/bench/futex-wake.o
  CC       /tmp/build/perf/arch/x86/util/pmu.o
  MKDIR    /tmp/build/perf/arch/x86/tests/
  CC       /tmp/build/perf/arch/x86/tests/regs_load.o
  MKDIR    /tmp/build/perf/arch/x86/tests/
  CC       /tmp/build/perf/arch/x86/tests/dwarf-unwind.o
  CC       /tmp/build/perf/arch/x86/util/kvm-stat.o
  CC       /tmp/build/perf/bench/futex-wake-parallel.o
  CC       /tmp/build/perf/arch/x86/tests/arch-tests.o
  CC       /tmp/build/perf/ui/setup.o
  CC       /tmp/build/perf/arch/x86/util/perf_regs.o
  CC       /tmp/build/perf/arch/x86/tests/rdpmc.o
  CC       /tmp/build/perf/ui/helpline.o
  CC       /tmp/build/perf/bench/futex-requeue.o
  CC       /tmp/build/perf/arch/x86/util/group.o
  CC       /tmp/build/perf/arch/x86/tests/perf-time-to-tsc.o
  MKDIR    /tmp/build/perf/scripts/perl/Perf-Trace-Util/
  CC       /tmp/build/perf/scripts/perl/Perf-Trace-Util/Context.o
  CC       /tmp/build/perf/arch/x86/util/machine.o
  CC       /tmp/build/perf/ui/progress.o
  CC       /tmp/build/perf/bench/futex-lock-pi.o
  CC       /tmp/build/perf/ui/util.o
  CC       /tmp/build/perf/arch/x86/tests/insn-x86.o
  CC       /tmp/build/perf/arch/x86/util/event.o
  CC       /tmp/build/perf/ui/hist.o
  CC       /tmp/build/perf/bench/epoll-wait.o
  CC       /tmp/build/perf/tests/dso-data.o
  CC       /tmp/build/perf/arch/x86/util/dwarf-regs.o
  CC       /tmp/build/perf/arch/x86/tests/intel-pt-pkt-decoder-test.o
  CC       /tmp/build/perf/arch/x86/util/unwind-libunwind.o
  CC       /tmp/build/perf/arch/x86/util/auxtrace.o
  CC       /tmp/build/perf/arch/x86/tests/bp-modify.o
  CC       /tmp/build/perf/util/block-range.o
  LD       /tmp/build/perf/scripts/perl/Perf-Trace-Util/perf-in.o
  LD       /tmp/build/perf/scripts/perf-in.o
  CC       /tmp/build/perf/util/build-id.o
  CC       /tmp/build/perf/bench/epoll-ctl.o
  CC       /tmp/build/perf/tests/attr.o
  CC       /tmp/build/perf/arch/x86/util/archinsn.o
  LD       /tmp/build/perf/arch/x86/tests/perf-in.o
  CC       /tmp/build/perf/arch/x86/util/intel-pt.o
  CC       /tmp/build/perf/util/cacheline.o
  CC       /tmp/build/perf/arch/x86/util/intel-bts.o
  CC       /tmp/build/perf/util/config.o
  CC       /tmp/build/perf/bench/synthesize.o
  CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
  CC       /tmp/build/perf/bench/kallsyms-parse.o
  CC       /tmp/build/perf/tests/openat-syscall.o
  CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
  CC       /tmp/build/perf/util/copyfile.o
  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-lib.o
  CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/tests/mmap-basic.o
  CC       /tmp/build/perf/tests/perf-record.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o
  LD       /tmp/build/perf/arch/x86/util/perf-in.o
  CC       /tmp/build/perf/bench/numa.o
  CC       /tmp/build/perf/util/ctype.o
  LD       /tmp/build/perf/arch/x86/perf-in.o
  LD       /tmp/build/perf/arch/perf-in.o
  CC       /tmp/build/perf/trace/beauty/clone.o
  CC       /tmp/build/perf/perf.o
  CC       /tmp/build/perf/util/db-export.o
  CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
  CC       /tmp/build/perf/tests/evsel-tp-sched.o
  CC       /tmp/build/perf/trace/beauty/fcntl.o
  CC       /tmp/build/perf/tests/fdarray.o
  CC       /tmp/build/perf/tests/pmu.o
  CC       /tmp/build/perf/trace/beauty/flock.o
  CC       /tmp/build/perf/tests/pmu-events.o
  CC       /tmp/build/perf/tests/hists_common.o
  CC       /tmp/build/perf/trace/beauty/fsmount.o
  CC       /tmp/build/perf/tests/hists_link.o
  CC       /tmp/build/perf/tests/hists_filter.o
  CC       /tmp/build/perf/trace/beauty/fspick.o
  CC       /tmp/build/perf/util/env.o
  CC       /tmp/build/perf/trace/beauty/ioctl.o
  CC       /tmp/build/perf/tests/hists_output.o
  CC       /tmp/build/perf/trace/beauty/kcmp.o
  MKDIR    /tmp/build/perf/ui/stdio/
  CC       /tmp/build/perf/ui/stdio/hist.o
  CC       /tmp/build/perf/tests/hists_cumulate.o
  CC       /tmp/build/perf/util/event.o
  CC       /tmp/build/perf/trace/beauty/mount_flags.o
  CC       /tmp/build/perf/trace/beauty/move_mount.o
  CC       /tmp/build/perf/trace/beauty/pkey_alloc.o
  CC       /tmp/build/perf/tests/python-use.o
  CC       /tmp/build/perf/tests/bp_signal.o
  LD       /tmp/build/perf/bench/perf-in.o
  CC       /tmp/build/perf/tests/bp_signal_overflow.o
  CC       /tmp/build/perf/tests/bp_account.o
  CC       /tmp/build/perf/ui/browser.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/ui/browsers/annotate.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/ui/browsers/hists.o
  CC       /tmp/build/perf/ui/browsers/map.o
  CC       /tmp/build/perf/ui/browsers/scripts.o
  CC       /tmp/build/perf/ui/browsers/header.o
  CC       /tmp/build/perf/ui/browsers/res_sample.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/ui/tui/setup.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/ui/tui/util.o
  CC       /tmp/build/perf/ui/tui/helpline.o
  CC       /tmp/build/perf/ui/tui/progress.o
  LD       /tmp/build/perf/ui/tui/perf-in.o
  CC       /tmp/build/perf/util/evlist.o
  CC       /tmp/build/perf/tests/wp.o
  CC       /tmp/build/perf/util/sideband_evlist.o
  CC       /tmp/build/perf/trace/beauty/arch_prctl.o
  CC       /tmp/build/perf/tests/task-exit.o
  CC       /tmp/build/perf/util/evsel.o
  CC       /tmp/build/perf/trace/beauty/prctl.o
  CC       /tmp/build/perf/trace/beauty/renameat.o
  CC       /tmp/build/perf/trace/beauty/sockaddr.o
  CC       /tmp/build/perf/util/evsel_fprintf.o
  CC       /tmp/build/perf/tests/sw-clock.o
  CC       /tmp/build/perf/util/perf_event_attr_fprintf.o
  CC       /tmp/build/perf/tests/mmap-thread-lookup.o
  CC       /tmp/build/perf/trace/beauty/socket.o
  CC       /tmp/build/perf/trace/beauty/statx.o
  CC       /tmp/build/perf/tests/thread-maps-share.o
  CC       /tmp/build/perf/util/evswitch.o
  CC       /tmp/build/perf/trace/beauty/sync_file_range.o
  CC       /tmp/build/perf/util/find_bit.o
  CC       /tmp/build/perf/tests/switch-tracking.o
  MKDIR    /tmp/build/perf/trace/beauty/tracepoints/
  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_irq_vectors.o
  CC       /tmp/build/perf/tests/keep-tracking.o
  CC       /tmp/build/perf/util/get_current_dir_name.o
  MKDIR    /tmp/build/perf/trace/beauty/tracepoints/
  CC       /tmp/build/perf/util/kallsyms.o
  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
  CC       /tmp/build/perf/util/levenshtein.o
  LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
  LD       /tmp/build/perf/trace/beauty/perf-in.o
  CC       /tmp/build/perf/util/llvm-utils.o
  CC       /tmp/build/perf/util/mmap.o
  CC       /tmp/build/perf/tests/code-reading.o
  CC       /tmp/build/perf/util/memswap.o
  CC       /tmp/build/perf/tests/sample-parsing.o
  BISON    /tmp/build/perf/util/parse-events-bison.c
  CC       /tmp/build/perf/util/perf_regs.o
  CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
  CC       /tmp/build/perf/tests/kmod-path.o
  CC       /tmp/build/perf/util/path.o
  CC       /tmp/build/perf/tests/thread-map.o
  CC       /tmp/build/perf/util/print_binary.o
  CC       /tmp/build/perf/tests/llvm.o
  CC       /tmp/build/perf/util/rlimit.o
  CC       /tmp/build/perf/util/argv_split.o
  CC       /tmp/build/perf/tests/bpf.o
  CC       /tmp/build/perf/util/rbtree.o
  CC       /tmp/build/perf/util/libstring.o
  CC       /tmp/build/perf/tests/topology.o
  CC       /tmp/build/perf/util/bitmap.o
  CC       /tmp/build/perf/util/hweight.o
  LD       /tmp/build/perf/ui/browsers/perf-in.o
  CC       /tmp/build/perf/tests/mem.o
  CC       /tmp/build/perf/util/smt.o
  CC       /tmp/build/perf/tests/cpumap.o
  CC       /tmp/build/perf/util/strbuf.o
  LD       /tmp/build/perf/ui/perf-in.o
  CC       /tmp/build/perf/util/string.o
  CC       /tmp/build/perf/util/strlist.o
  CC       /tmp/build/perf/util/strfilter.o
  CC       /tmp/build/perf/tests/stat.o
  CC       /tmp/build/perf/tests/event_update.o
  CC       /tmp/build/perf/util/top.o
  CC       /tmp/build/perf/tests/event-times.o
  CC       /tmp/build/perf/util/usage.o
  CC       /tmp/build/perf/util/dso.o
  CC       /tmp/build/perf/util/dsos.o
  CC       /tmp/build/perf/tests/expr.o
  CC       /tmp/build/perf/util/symbol.o
  CC       /tmp/build/perf/tests/backward-ring-buffer.o
  CC       /tmp/build/perf/util/symbol_fprintf.o
  CC       /tmp/build/perf/tests/sdt.o
  CC       /tmp/build/perf/tests/is_printable_array.o
  CC       /tmp/build/perf/util/color.o
  CC       /tmp/build/perf/tests/bitmap.o
  CC       /tmp/build/perf/tests/perf-hooks.o
  CC       /tmp/build/perf/tests/clang.o
  CC       /tmp/build/perf/util/color_config.o
  CC       /tmp/build/perf/tests/unit_number__scnprintf.o
  CC       /tmp/build/perf/tests/mem2node.o
  CC       /tmp/build/perf/tests/maps.o
  CC       /tmp/build/perf/tests/time-utils-test.o
  CC       /tmp/build/perf/util/metricgroup.o
  CC       /tmp/build/perf/tests/genelf.o
  CC       /tmp/build/perf/util/header.o
  CC       /tmp/build/perf/util/callchain.o
  CC       /tmp/build/perf/tests/api-io.o
  CC       /tmp/build/perf/tests/demangle-java-test.o
  CC       /tmp/build/perf/util/values.o
  CC       /tmp/build/perf/tests/pfm.o
  CC       /tmp/build/perf/tests/parse-metric.o
  CC       /tmp/build/perf/tests/dwarf-unwind.o
  CC       /tmp/build/perf/tests/llvm-src-base.o
  CC       /tmp/build/perf/tests/llvm-src-kbuild.o
  CC       /tmp/build/perf/tests/llvm-src-prologue.o
  CC       /tmp/build/perf/util/debug.o
  CC       /tmp/build/perf/tests/llvm-src-relocation.o
  CC       /tmp/build/perf/util/fncache.o
  CC       /tmp/build/perf/util/machine.o
  CC       /tmp/build/perf/util/map.o
  LD       /tmp/build/perf/tests/perf-in.o
  CC       /tmp/build/perf/util/pstack.o
  CC       /tmp/build/perf/util/session.o
  CC       /tmp/build/perf/util/sample-raw.o
  CC       /tmp/build/perf/util/s390-sample-raw.o
  CC       /tmp/build/perf/util/syscalltbl.o
  CC       /tmp/build/perf/util/ordered-events.o
  CC       /tmp/build/perf/util/namespaces.o
  CC       /tmp/build/perf/util/comm.o
  CC       /tmp/build/perf/util/thread.o
  CC       /tmp/build/perf/util/thread_map.o
  CC       /tmp/build/perf/util/trace-event-parse.o
  FLEX     /tmp/build/perf/util/parse-events-flex.h
  BISON    /tmp/build/perf/util/pmu-bison.c
  CC       /tmp/build/perf/util/trace-event-read.o
  CC       /tmp/build/perf/util/trace-event-info.o
  CC       /tmp/build/perf/util/trace-event-scripting.o
  CC       /tmp/build/perf/util/trace-event.o
  CC       /tmp/build/perf/util/svghelper.o
  CC       /tmp/build/perf/util/sort.o
  CC       /tmp/build/perf/util/hist.o
  CC       /tmp/build/perf/util/util.o
  CC       /tmp/build/perf/util/cpumap.o
  CC       /tmp/build/perf/util/affinity.o
  CC       /tmp/build/perf/util/cputopo.o
  CC       /tmp/build/perf/util/cgroup.o
  CC       /tmp/build/perf/util/target.o
  CC       /tmp/build/perf/util/rblist.o
  CC       /tmp/build/perf/util/intlist.o
  CC       /tmp/build/perf/util/vdso.o
  CC       /tmp/build/perf/util/counts.o
  CC       /tmp/build/perf/util/stat.o
  CC       /tmp/build/perf/util/stat-shadow.o
  CC       /tmp/build/perf/util/stat-display.o
  CC       /tmp/build/perf/util/perf_api_probe.o
  CC       /tmp/build/perf/util/record.o
  CC       /tmp/build/perf/util/srcline.o
  CC       /tmp/build/perf/util/srccode.o
  CC       /tmp/build/perf/util/synthetic-events.o
  CC       /tmp/build/perf/util/data.o
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/util/cloexec.o
  CC       /tmp/build/perf/util/call-path.o
  CC       /tmp/build/perf/util/rwsem.o
  CC       /tmp/build/perf/util/thread-stack.o
  CC       /tmp/build/perf/util/spark.o
  CC       /tmp/build/perf/util/auxtrace.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o
  MKDIR    /tmp/build/perf/util/arm-spe-decoder/
  CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.o
  MKDIR    /tmp/build/perf/util/scripting-engines/
  CC       /tmp/build/perf/util/scripting-engines/trace-event-perl.o
  CC       /tmp/build/perf/util/intel-pt.o
  MKDIR    /tmp/build/perf/util/arm-spe-decoder/
  CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-decoder.o
  CC       /tmp/build/perf/util/intel-bts.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  GEN      /tmp/build/perf/util/intel-pt-decoder/inat-tables.c
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-log.o
  LD       /tmp/build/perf/util/arm-spe-decoder/perf-in.o
  CC       /tmp/build/perf/util/arm-spe.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-decoder.o
  CC       /tmp/build/perf/util/s390-cpumsf.o
  CC       /tmp/build/perf/util/parse-branch-options.o
  CC       /tmp/build/perf/util/dump-insn.o
  CC       /tmp/build/perf/util/parse-regs-options.o
  CC       /tmp/build/perf/util/term.o
  CC       /tmp/build/perf/util/help-unknown-cmd.o
  CC       /tmp/build/perf/util/mem-events.o
  CC       /tmp/build/perf/util/vsprintf.o
  LD       /tmp/build/perf/util/scripting-engines/perf-in.o
  CC       /tmp/build/perf/util/units.o
  CC       /tmp/build/perf/util/time-utils.o
  BISON    /tmp/build/perf/util/expr-bison.c
  CC       /tmp/build/perf/util/branch.o
  CC       /tmp/build/perf/util/mem2node.o
  CC       /tmp/build/perf/util/symbol-elf.o
  CC       /tmp/build/perf/util/probe-file.o
  CC       /tmp/build/perf/util/probe-event.o
  CC       /tmp/build/perf/util/probe-finder.o
  CC       /tmp/build/perf/util/hashmap.o
  CC       /tmp/build/perf/util/dwarf-aux.o
  CC       /tmp/build/perf/util/dwarf-regs.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       /tmp/build/perf/util/unwind-libunwind-local.o
  CC       /tmp/build/perf/util/unwind-libunwind.o
  CC       /tmp/build/perf/util/zlib.o
  CC       /tmp/build/perf/util/lzma.o
  CC       /tmp/build/perf/util/zstd.o
  CC       /tmp/build/perf/util/cap.o
  CC       /tmp/build/perf/util/demangle-java.o
  CC       /tmp/build/perf/util/demangle-rust.o
  CC       /tmp/build/perf/util/jitdump.o
  CC       /tmp/build/perf/util/genelf.o
  LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
  CC       /tmp/build/perf/util/genelf_debug.o
  CC       /tmp/build/perf/util/perf-hooks.o
  FLEX     /tmp/build/perf/util/parse-events-flex.c
  CC       /tmp/build/perf/util/parse-events-bison.o
  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  FLEX     /tmp/build/perf/util/expr-flex.c
  FLEX     /tmp/build/perf/util/expr-flex.h
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/pmu-flex.o
  CC       /tmp/build/perf/util/expr-flex.o
  CC       /tmp/build/perf/util/expr-bison.o
  CC       /tmp/build/perf/util/expr.o
  LD       /tmp/build/perf/util/perf-in.o
  LD       /tmp/build/perf/perf-in.o
  LINK     /tmp/build/perf/perf
make: Leaving directory '/git/linux/tools/perf'
+ set +o xtrace
clang version 7.0.1 
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/i586-alt-linux/8
Found candidate GCC installation: /usr/bin/../lib64/gcc/x86_64-alt-linux/8
Found candidate GCC installation: /usr/lib/gcc/i586-alt-linux/8
Found candidate GCC installation: /usr/lib64/gcc/x86_64-alt-linux/8
Selected GCC installation: /usr/bin/../lib64/gcc/x86_64-alt-linux/8
Candidate multilib: .;@m64
Selected multilib: .;@m64
+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= -C /git/linux/tools/perf O=/tmp/build/perf CC=clang
make: Entering directory '/git/linux/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ on  ]
...                        libbfd: [ on  ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ OFF ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]

Makefile.config:536: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:773: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
Makefile.config:945: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:971: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
  GEN      /tmp/build/perf/common-cmds.h
  PERF_VERSION = 5.7.gc3d44cd87052
  CC       /tmp/build/perf/exec-cmd.o
  MKDIR    /tmp/build/perf/fd/
  CC       /tmp/build/perf/fd/array.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/fs.o
  CC       /tmp/build/perf/event-parse.o
  CC       /tmp/build/perf/core.o
  CC       /tmp/build/perf/help.o
  MKDIR    /tmp/build/perf/fs/
  GEN      /tmp/build/perf/bpf_helper_defs.h
  CC       /tmp/build/perf/fs/tracing_path.o
  LD       /tmp/build/perf/fd/libapi-in.o
  CC       /tmp/build/perf/cpumap.o
  CC       /tmp/build/perf/threadmap.o
  CC       /tmp/build/perf/fs/cgroup.o
  CC       /tmp/build/perf/evsel.o
  MKDIR    /tmp/build/perf/staticobjs/
  CC       /tmp/build/perf/staticobjs/libbpf.o
  CC       /tmp/build/perf/pager.o
  LD       /tmp/build/perf/fs/libapi-in.o
  CC       /tmp/build/perf/cpu.o
  CC       /tmp/build/perf/parse-options.o
  CC       /tmp/build/perf/evlist.o
  CC       /tmp/build/perf/mmap.o
  CC       /tmp/build/perf/debug.o
  CC       /tmp/build/perf/str_error_r.o
  MKDIR    /tmp/build/perf/staticobjs/
  CC       /tmp/build/perf/staticobjs/bpf.o
  CC       /tmp/build/perf/zalloc.o
  LD       /tmp/build/perf/libapi-in.o
  AR       /tmp/build/perf/libapi.a
  CC       /tmp/build/perf/event-plugin.o
  CC       /tmp/build/perf/trace-seq.o
  CC       /tmp/build/perf/parse-filter.o
  CC       /tmp/build/perf/parse-utils.o
  CC       /tmp/build/perf/xyarray.o
  CC       /tmp/build/perf/kbuffer-parse.o
  CC       /tmp/build/perf/lib.o
  CC       /tmp/build/perf/tep_strerror.o
  CC       /tmp/build/perf/event-parse-api.o
  CC       /tmp/build/perf/staticobjs/nlattr.o
  LD       /tmp/build/perf/libperf-in.o
  CC       /tmp/build/perf/run-command.o
  AR       /tmp/build/perf/libperf.a
  CC       /tmp/build/perf/sigchain.o
  LD       /tmp/build/perf/libtraceevent-in.o
  LINK     /tmp/build/perf/libtraceevent.a
  CC       /tmp/build/perf/subcmd-config.o
  CC       /tmp/build/perf/staticobjs/btf.o
  CC       /tmp/build/perf/staticobjs/libbpf_errno.o
  LD       /tmp/build/perf/libsubcmd-in.o
  GEN      perf-archive
  AR       /tmp/build/perf/libsubcmd.a
  CC       /tmp/build/perf/staticobjs/str_error.o
  GEN      perf-with-kcore
  MKDIR    /tmp/build/perf/pmu-events/
  MKDIR    /tmp/build/perf/pmu-events/
  HOSTCC   /tmp/build/perf/pmu-events/json.o
  HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
  MKDIR    /tmp/build/perf/pmu-events/
  HOSTCC   /tmp/build/perf/pmu-events/jevents.o
  CC       /tmp/build/perf/staticobjs/netlink.o
  CC       /tmp/build/perf/staticobjs/bpf_prog_linfo.o
  CC       /tmp/build/perf/staticobjs/libbpf_probes.o
  MKDIR    /tmp/build/perf/ui/gtk/
  CC       /tmp/build/perf/plugin_jbd2.o
  CC       /tmp/build/perf/ui/gtk/browser.o
  LD       /tmp/build/perf/plugin_jbd2-in.o
  CC       /tmp/build/perf/plugin_hrtimer.o
  CC       /tmp/build/perf/plugin_kmem.o
  LD       /tmp/build/perf/plugin_kmem-in.o
  CC       /tmp/build/perf/staticobjs/xsk.o
  MKDIR    /tmp/build/perf/ui/gtk/
  CC       /tmp/build/perf/plugin_kvm.o
  CC       /tmp/build/perf/ui/gtk/hists.o
  CC       /tmp/build/perf/plugin_mac80211.o
  HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
  LINK     /tmp/build/perf/pmu-events/jevents
  LD       /tmp/build/perf/plugin_hrtimer-in.o
  CC       /tmp/build/perf/plugin_sched_switch.o
  GEN      /tmp/build/perf/pmu-events/pmu-events.c
  LD       /tmp/build/perf/plugin_mac80211-in.o
  CC       /tmp/build/perf/plugin_function.o
  LD       /tmp/build/perf/plugin_kvm-in.o
  CC       /tmp/build/perf/plugin_xen.o
  LD       /tmp/build/perf/plugin_sched_switch-in.o
  CC       /tmp/build/perf/staticobjs/hashmap.o
  CC       /tmp/build/perf/plugin_scsi.o
  LD       /tmp/build/perf/plugin_xen-in.o
  LD       /tmp/build/perf/plugin_function-in.o
  CC       /tmp/build/perf/ui/gtk/setup.o
  LD       /tmp/build/perf/plugin_scsi-in.o
  CC       /tmp/build/perf/pmu-events/pmu-events.o
  CC       /tmp/build/perf/ui/gtk/util.o
  CC       /tmp/build/perf/staticobjs/btf_dump.o
  CC       /tmp/build/perf/staticobjs/ringbuf.o
  CC       /tmp/build/perf/plugin_cfg80211.o
  CC       /tmp/build/perf/builtin-bench.o
  LD       /tmp/build/perf/plugin_cfg80211-in.o
  LINK     /tmp/build/perf/plugin_jbd2.so
  LINK     /tmp/build/perf/plugin_hrtimer.so
  CC       /tmp/build/perf/builtin-annotate.o
  LD       /tmp/build/perf/staticobjs/libbpf-in.o
  LINK     /tmp/build/perf/plugin_kmem.so
  LINK     /tmp/build/perf/libbpf.a
  LINK     /tmp/build/perf/plugin_kvm.so
  CC       /tmp/build/perf/builtin-config.o
  CC       /tmp/build/perf/builtin-diff.o
  LINK     /tmp/build/perf/plugin_mac80211.so
  CC       /tmp/build/perf/ui/gtk/helpline.o
  LINK     /tmp/build/perf/plugin_sched_switch.so
  LINK     /tmp/build/perf/plugin_function.so
  CC       /tmp/build/perf/ui/gtk/progress.o
  CC       /tmp/build/perf/ui/gtk/annotate.o
  LINK     /tmp/build/perf/plugin_xen.so
  LINK     /tmp/build/perf/plugin_scsi.so
  CC       /tmp/build/perf/builtin-evlist.o
  CC       /tmp/build/perf/builtin-ftrace.o
  LINK     /tmp/build/perf/plugin_cfg80211.so
  CC       /tmp/build/perf/builtin-help.o
  GEN      /tmp/build/perf/libtraceevent-dynamic-list
  CC       /tmp/build/perf/builtin-sched.o
  LD       /tmp/build/perf/pmu-events/pmu-events-in.o
  CC       /tmp/build/perf/builtin-buildid-list.o
  CC       /tmp/build/perf/ui/gtk/zalloc.o
  CC       /tmp/build/perf/builtin-buildid-cache.o
  CC       /tmp/build/perf/builtin-kallsyms.o
  CC       /tmp/build/perf/builtin-list.o
  CC       /tmp/build/perf/builtin-record.o
  CC       /tmp/build/perf/builtin-report.o
  CC       /tmp/build/perf/builtin-stat.o
  LD       /tmp/build/perf/ui/gtk/gtk-in.o
  LD       /tmp/build/perf/gtk-in.o
  LINK     /tmp/build/perf/libperf-gtk.so
  CC       /tmp/build/perf/builtin-timechart.o
  CC       /tmp/build/perf/builtin-top.o
  CC       /tmp/build/perf/builtin-script.o
  CC       /tmp/build/perf/builtin-kmem.o
  CC       /tmp/build/perf/builtin-lock.o
  CC       /tmp/build/perf/builtin-kvm.o
  CC       /tmp/build/perf/builtin-inject.o
  CC       /tmp/build/perf/builtin-mem.o
  CC       /tmp/build/perf/builtin-data.o
  CC       /tmp/build/perf/builtin-version.o
  CC       /tmp/build/perf/builtin-c2c.o
  CC       /tmp/build/perf/builtin-trace.o
  CC       /tmp/build/perf/builtin-probe.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-messaging.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/builtin-test.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/parse-events.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-pipe.o
  CC       /tmp/build/perf/bench/mem-functions.o
  CC       /tmp/build/perf/tests/dso-data.o
  CC       /tmp/build/perf/arch/common.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/annotate.o
  CC       /tmp/build/perf/tests/attr.o
  MKDIR    /tmp/build/perf/arch/x86/util/
  CC       /tmp/build/perf/arch/x86/util/header.o
  MKDIR    /tmp/build/perf/arch/x86/util/
  CC       /tmp/build/perf/arch/x86/util/tsc.o
  CC       /tmp/build/perf/arch/x86/util/pmu.o
  CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
  CC       /tmp/build/perf/tests/openat-syscall.o
  CC       /tmp/build/perf/arch/x86/util/kvm-stat.o
  CC       /tmp/build/perf/arch/x86/util/perf_regs.o
  CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
  CC       /tmp/build/perf/arch/x86/util/group.o
  CC       /tmp/build/perf/arch/x86/util/machine.o
  CC       /tmp/build/perf/ui/setup.o
  CC       /tmp/build/perf/ui/helpline.o
  CC       /tmp/build/perf/ui/progress.o
  CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
  CC       /tmp/build/perf/tests/mmap-basic.o
  MKDIR    /tmp/build/perf/scripts/perl/Perf-Trace-Util/
  CC       /tmp/build/perf/scripts/perl/Perf-Trace-Util/Context.o
  CC       /tmp/build/perf/arch/x86/util/event.o
  CC       /tmp/build/perf/ui/util.o
  CC       /tmp/build/perf/ui/hist.o
  CC       /tmp/build/perf/arch/x86/util/dwarf-regs.o
  CC       /tmp/build/perf/arch/x86/util/unwind-libunwind.o
  CC       /tmp/build/perf/arch/x86/util/auxtrace.o
  LD       /tmp/build/perf/scripts/perl/Perf-Trace-Util/perf-in.o
  LD       /tmp/build/perf/scripts/perf-in.o
  MKDIR    /tmp/build/perf/ui/stdio/
  CC       /tmp/build/perf/ui/stdio/hist.o
  CC       /tmp/build/perf/arch/x86/util/archinsn.o
  CC       /tmp/build/perf/arch/x86/util/intel-pt.o
  CC       /tmp/build/perf/trace/beauty/clone.o
  CC       /tmp/build/perf/trace/beauty/fcntl.o
  CC       /tmp/build/perf/arch/x86/util/intel-bts.o
  CC       /tmp/build/perf/trace/beauty/flock.o
  CC       /tmp/build/perf/trace/beauty/fsmount.o
  CC       /tmp/build/perf/trace/beauty/fspick.o
  CC       /tmp/build/perf/trace/beauty/ioctl.o
  LD       /tmp/build/perf/arch/x86/util/perf-in.o
  MKDIR    /tmp/build/perf/arch/x86/tests/
  CC       /tmp/build/perf/arch/x86/tests/regs_load.o
  CC       /tmp/build/perf/tests/perf-record.o
  CC       /tmp/build/perf/bench/futex-hash.o
  CC       /tmp/build/perf/perf.o
  CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
  CC       /tmp/build/perf/bench/futex-wake.o
  CC       /tmp/build/perf/tests/evsel-tp-sched.o
  MKDIR    /tmp/build/perf/arch/x86/tests/
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/trace/beauty/kcmp.o
  CC       /tmp/build/perf/ui/browser.o
  CC       /tmp/build/perf/util/block-info.o
  CC       /tmp/build/perf/util/block-range.o
  CC       /tmp/build/perf/util/build-id.o
  CC       /tmp/build/perf/trace/beauty/mount_flags.o
  CC       /tmp/build/perf/arch/x86/tests/arch-tests.o
  CC       /tmp/build/perf/arch/x86/tests/dwarf-unwind.o
  CC       /tmp/build/perf/bench/futex-wake-parallel.o
  CC       /tmp/build/perf/tests/fdarray.o
  CC       /tmp/build/perf/bench/futex-requeue.o
  CC       /tmp/build/perf/tests/pmu.o
  CC       /tmp/build/perf/bench/futex-lock-pi.o
  CC       /tmp/build/perf/util/cacheline.o
  CC       /tmp/build/perf/arch/x86/tests/rdpmc.o
  CC       /tmp/build/perf/util/config.o
  CC       /tmp/build/perf/util/copyfile.o
  CC       /tmp/build/perf/bench/epoll-wait.o
  CC       /tmp/build/perf/bench/epoll-ctl.o
  CC       /tmp/build/perf/bench/synthesize.o
  CC       /tmp/build/perf/bench/kallsyms-parse.o
  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-lib.o
  CC       /tmp/build/perf/arch/x86/tests/perf-time-to-tsc.o
  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o
  CC       /tmp/build/perf/tests/pmu-events.o
  CC       /tmp/build/perf/trace/beauty/move_mount.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/tests/hists_common.o
  CC       /tmp/build/perf/ui/browsers/annotate.o
  CC       /tmp/build/perf/trace/beauty/pkey_alloc.o
  CC       /tmp/build/perf/trace/beauty/arch_prctl.o
  CC       /tmp/build/perf/trace/beauty/prctl.o
  CC       /tmp/build/perf/util/ctype.o
  CC       /tmp/build/perf/trace/beauty/renameat.o
  CC       /tmp/build/perf/bench/numa.o
  CC       /tmp/build/perf/trace/beauty/sockaddr.o
  CC       /tmp/build/perf/trace/beauty/socket.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/ui/browsers/hists.o
  CC       /tmp/build/perf/arch/x86/tests/insn-x86.o
  CC       /tmp/build/perf/tests/hists_link.o
  CC       /tmp/build/perf/tests/hists_filter.o
  CC       /tmp/build/perf/util/db-export.o
  CC       /tmp/build/perf/tests/hists_output.o
  CC       /tmp/build/perf/trace/beauty/statx.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/ui/tui/setup.o
  CC       /tmp/build/perf/trace/beauty/sync_file_range.o
  MKDIR    /tmp/build/perf/trace/beauty/tracepoints/
  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_irq_vectors.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/ui/tui/util.o
  MKDIR    /tmp/build/perf/trace/beauty/tracepoints/
  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
  LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
  LD       /tmp/build/perf/trace/beauty/perf-in.o
  CC       /tmp/build/perf/ui/browsers/map.o
  CC       /tmp/build/perf/arch/x86/tests/intel-pt-pkt-decoder-test.o
  CC       /tmp/build/perf/ui/browsers/scripts.o
  CC       /tmp/build/perf/arch/x86/tests/bp-modify.o
  CC       /tmp/build/perf/tests/hists_cumulate.o
  CC       /tmp/build/perf/util/env.o
  CC       /tmp/build/perf/tests/python-use.o
  LD       /tmp/build/perf/arch/x86/tests/perf-in.o
  LD       /tmp/build/perf/arch/x86/perf-in.o
  LD       /tmp/build/perf/arch/perf-in.o
  LD       /tmp/build/perf/bench/perf-in.o
  CC       /tmp/build/perf/tests/bp_signal.o
  CC       /tmp/build/perf/tests/bp_signal_overflow.o
  CC       /tmp/build/perf/util/event.o
  CC       /tmp/build/perf/ui/tui/helpline.o
  CC       /tmp/build/perf/ui/browsers/header.o
  CC       /tmp/build/perf/ui/browsers/res_sample.o
  CC       /tmp/build/perf/ui/tui/progress.o
  CC       /tmp/build/perf/util/evlist.o
  CC       /tmp/build/perf/tests/bp_account.o
  CC       /tmp/build/perf/util/sideband_evlist.o
  CC       /tmp/build/perf/tests/wp.o
  CC       /tmp/build/perf/util/evsel.o
  LD       /tmp/build/perf/ui/tui/perf-in.o
  CC       /tmp/build/perf/util/evsel_fprintf.o
  CC       /tmp/build/perf/util/perf_event_attr_fprintf.o
  CC       /tmp/build/perf/tests/task-exit.o
  CC       /tmp/build/perf/util/evswitch.o
  CC       /tmp/build/perf/tests/sw-clock.o
  CC       /tmp/build/perf/util/find_bit.o
  CC       /tmp/build/perf/util/get_current_dir_name.o
  CC       /tmp/build/perf/util/kallsyms.o
  CC       /tmp/build/perf/tests/mmap-thread-lookup.o
  CC       /tmp/build/perf/tests/thread-maps-share.o
  CC       /tmp/build/perf/tests/switch-tracking.o
  CC       /tmp/build/perf/util/levenshtein.o
  CC       /tmp/build/perf/tests/keep-tracking.o
  CC       /tmp/build/perf/util/llvm-utils.o
  CC       /tmp/build/perf/tests/code-reading.o
  CC       /tmp/build/perf/util/mmap.o
  CC       /tmp/build/perf/tests/sample-parsing.o
  CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
  LD       /tmp/build/perf/ui/browsers/perf-in.o
  LD       /tmp/build/perf/ui/perf-in.o
  CC       /tmp/build/perf/util/memswap.o
  CC       /tmp/build/perf/tests/kmod-path.o
  BISON    /tmp/build/perf/util/parse-events-bison.c
  CC       /tmp/build/perf/util/perf_regs.o
  CC       /tmp/build/perf/util/path.o
  CC       /tmp/build/perf/util/print_binary.o
  CC       /tmp/build/perf/tests/thread-map.o
  CC       /tmp/build/perf/util/rlimit.o
  CC       /tmp/build/perf/tests/llvm.o
  CC       /tmp/build/perf/util/argv_split.o
  CC       /tmp/build/perf/tests/bpf.o
  CC       /tmp/build/perf/util/rbtree.o
  CC       /tmp/build/perf/tests/topology.o
  CC       /tmp/build/perf/util/libstring.o
  CC       /tmp/build/perf/util/bitmap.o
  CC       /tmp/build/perf/tests/mem.o
  CC       /tmp/build/perf/util/hweight.o
  CC       /tmp/build/perf/tests/cpumap.o
  CC       /tmp/build/perf/tests/stat.o
  CC       /tmp/build/perf/tests/event_update.o
  CC       /tmp/build/perf/tests/event-times.o
  CC       /tmp/build/perf/util/smt.o
  CC       /tmp/build/perf/tests/expr.o
  CC       /tmp/build/perf/util/strbuf.o
  CC       /tmp/build/perf/util/string.o
  CC       /tmp/build/perf/util/strlist.o
  CC       /tmp/build/perf/util/strfilter.o
  CC       /tmp/build/perf/tests/backward-ring-buffer.o
  CC       /tmp/build/perf/util/top.o
  CC       /tmp/build/perf/tests/sdt.o
  CC       /tmp/build/perf/util/usage.o
  CC       /tmp/build/perf/tests/is_printable_array.o
  CC       /tmp/build/perf/util/dso.o
  CC       /tmp/build/perf/util/dsos.o
  CC       /tmp/build/perf/util/symbol.o
  CC       /tmp/build/perf/tests/bitmap.o
  CC       /tmp/build/perf/tests/perf-hooks.o
  CC       /tmp/build/perf/tests/clang.o
  CC       /tmp/build/perf/util/symbol_fprintf.o
  CC       /tmp/build/perf/tests/unit_number__scnprintf.o
  CC       /tmp/build/perf/tests/mem2node.o
  CC       /tmp/build/perf/tests/maps.o
  CC       /tmp/build/perf/tests/time-utils-test.o
  CC       /tmp/build/perf/tests/genelf.o
  CC       /tmp/build/perf/util/color.o
  CC       /tmp/build/perf/tests/api-io.o
  CC       /tmp/build/perf/util/color_config.o
  CC       /tmp/build/perf/tests/demangle-java-test.o
  CC       /tmp/build/perf/tests/pfm.o
  CC       /tmp/build/perf/util/metricgroup.o
  CC       /tmp/build/perf/tests/parse-metric.o
  CC       /tmp/build/perf/tests/dwarf-unwind.o
  CC       /tmp/build/perf/util/header.o
  CC       /tmp/build/perf/util/callchain.o
  CC       /tmp/build/perf/util/values.o
  CC       /tmp/build/perf/tests/llvm-src-base.o
  CC       /tmp/build/perf/tests/llvm-src-kbuild.o
  CC       /tmp/build/perf/tests/llvm-src-prologue.o
  CC       /tmp/build/perf/tests/llvm-src-relocation.o
  CC       /tmp/build/perf/util/debug.o
  CC       /tmp/build/perf/util/fncache.o
  LD       /tmp/build/perf/tests/perf-in.o
  CC       /tmp/build/perf/util/machine.o
  CC       /tmp/build/perf/util/map.o
  CC       /tmp/build/perf/util/pstack.o
  CC       /tmp/build/perf/util/session.o
  CC       /tmp/build/perf/util/sample-raw.o
  CC       /tmp/build/perf/util/s390-sample-raw.o
  CC       /tmp/build/perf/util/syscalltbl.o
  CC       /tmp/build/perf/util/ordered-events.o
  CC       /tmp/build/perf/util/namespaces.o
  CC       /tmp/build/perf/util/comm.o
  CC       /tmp/build/perf/util/thread.o
  CC       /tmp/build/perf/util/thread_map.o
  CC       /tmp/build/perf/util/trace-event-parse.o
  FLEX     /tmp/build/perf/util/parse-events-flex.h
  BISON    /tmp/build/perf/util/pmu-bison.c
  CC       /tmp/build/perf/util/trace-event-read.o
  CC       /tmp/build/perf/util/trace-event-info.o
  CC       /tmp/build/perf/util/trace-event-scripting.o
  CC       /tmp/build/perf/util/trace-event.o
  CC       /tmp/build/perf/util/svghelper.o
  CC       /tmp/build/perf/util/sort.o
  CC       /tmp/build/perf/util/hist.o
  CC       /tmp/build/perf/util/util.o
  CC       /tmp/build/perf/util/cpumap.o
  CC       /tmp/build/perf/util/affinity.o
  CC       /tmp/build/perf/util/cputopo.o
  CC       /tmp/build/perf/util/cgroup.o
  CC       /tmp/build/perf/util/target.o
  CC       /tmp/build/perf/util/rblist.o
  CC       /tmp/build/perf/util/intlist.o
  CC       /tmp/build/perf/util/vdso.o
  CC       /tmp/build/perf/util/counts.o
  CC       /tmp/build/perf/util/stat.o
  CC       /tmp/build/perf/util/stat-shadow.o
  CC       /tmp/build/perf/util/stat-display.o
  CC       /tmp/build/perf/util/perf_api_probe.o
  CC       /tmp/build/perf/util/record.o
  CC       /tmp/build/perf/util/srcline.o
  CC       /tmp/build/perf/util/srccode.o
  CC       /tmp/build/perf/util/synthetic-events.o
  CC       /tmp/build/perf/util/data.o
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/util/cloexec.o
  CC       /tmp/build/perf/util/call-path.o
  CC       /tmp/build/perf/util/rwsem.o
  CC       /tmp/build/perf/util/thread-stack.o
  CC       /tmp/build/perf/util/spark.o
  CC       /tmp/build/perf/util/auxtrace.o
  MKDIR    /tmp/build/perf/util/arm-spe-decoder/
  CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  GEN      /tmp/build/perf/util/intel-pt-decoder/inat-tables.c
  MKDIR    /tmp/build/perf/util/scripting-engines/
  CC       /tmp/build/perf/util/scripting-engines/trace-event-perl.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-log.o
  MKDIR    /tmp/build/perf/util/arm-spe-decoder/
  CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-decoder.o
  CC       /tmp/build/perf/util/intel-pt.o
  CC       /tmp/build/perf/util/intel-bts.o
  LD       /tmp/build/perf/util/arm-spe-decoder/perf-in.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-decoder.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       /tmp/build/perf/util/arm-spe.o
  CC       /tmp/build/perf/util/s390-cpumsf.o
  CC       /tmp/build/perf/util/parse-branch-options.o
  CC       /tmp/build/perf/util/dump-insn.o
  LD       /tmp/build/perf/util/scripting-engines/perf-in.o
  CC       /tmp/build/perf/util/parse-regs-options.o
  CC       /tmp/build/perf/util/term.o
  CC       /tmp/build/perf/util/help-unknown-cmd.o
  CC       /tmp/build/perf/util/mem-events.o
  CC       /tmp/build/perf/util/vsprintf.o
  CC       /tmp/build/perf/util/units.o
  CC       /tmp/build/perf/util/time-utils.o
  BISON    /tmp/build/perf/util/expr-bison.c
  CC       /tmp/build/perf/util/branch.o
  CC       /tmp/build/perf/util/mem2node.o
  CC       /tmp/build/perf/util/bpf-loader.o
  CC       /tmp/build/perf/util/bpf_map.o
  CC       /tmp/build/perf/util/bpf-prologue.o
  LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
  CC       /tmp/build/perf/util/symbol-elf.o
  CC       /tmp/build/perf/util/probe-file.o
  CC       /tmp/build/perf/util/probe-event.o
  CC       /tmp/build/perf/util/probe-finder.o
  CC       /tmp/build/perf/util/dwarf-aux.o
  CC       /tmp/build/perf/util/dwarf-regs.o
  CC       /tmp/build/perf/util/unwind-libunwind-local.o
  CC       /tmp/build/perf/util/unwind-libunwind.o
  CC       /tmp/build/perf/util/zlib.o
  CC       /tmp/build/perf/util/lzma.o
  CC       /tmp/build/perf/util/zstd.o
  CC       /tmp/build/perf/util/cap.o
  CC       /tmp/build/perf/util/demangle-java.o
  CC       /tmp/build/perf/util/demangle-rust.o
  CC       /tmp/build/perf/util/jitdump.o
  CC       /tmp/build/perf/util/genelf.o
  CC       /tmp/build/perf/util/genelf_debug.o
  CC       /tmp/build/perf/util/perf-hooks.o
  CC       /tmp/build/perf/util/bpf-event.o
  FLEX     /tmp/build/perf/util/parse-events-flex.c
  CC       /tmp/build/perf/util/parse-events-bison.o
  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  FLEX     /tmp/build/perf/util/expr-flex.c
  FLEX     /tmp/build/perf/util/expr-flex.h
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/pmu-flex.o
  CC       /tmp/build/perf/util/expr-flex.o
  CC       /tmp/build/perf/util/expr-bison.o
  CC       /tmp/build/perf/util/expr.o
  LD       /tmp/build/perf/util/perf-in.o
  LD       /tmp/build/perf/perf-in.o
  LINK     /tmp/build/perf/perf
make: Leaving directory '/git/linux/tools/perf'


  13   114.11 alt:sisyphus                  : FAIL x86_64-alt-linux-gcc (GCC) 9.2.1 20200123 (ALT Sisyphus 9.2.1-alt3), clang version 10.0.0 
  14    27.26 amazonlinux:1                 : FAIL gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  15    28.76 amazonlinux:2                 : FAIL gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)

  FLEX     /tmp/build/perf/util/parse-events-flex.c
  CC       /tmp/build/perf/util/parse-events-bison.o
  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  FLEX     /tmp/build/perf/util/expr-flex.c
  FLEX     /tmp/build/perf/util/expr-flex.h
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu.o
/tmp/build/perf/util/parse-events-flex.c: In function 'parse_events_lex':
/tmp/build/perf/util/parse-events-flex.c:4911:23: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
    for ( yyl = 0; yyl < yyleng; ++yyl )
                       ^
/tmp/build/perf/util/parse-events-flex.c:193:36: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:204:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^~~~~~~~~~~~~~
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^~~~~~
util/parse-events.l:243:4: note: in expansion of macro 'REWIND'
    REWIND(0);
    ^~~~~~
/tmp/build/perf/util/parse-events-flex.c:193:36: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:204:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^~~~~~~~~~~~~~
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^~~~~~
util/parse-events.l:251:4: note: in expansion of macro 'REWIND'
    REWIND(1);
    ^~~~~~
/tmp/build/perf/util/parse-events-flex.c:193:36: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:204:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^~~~~~~~~~~~~~
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^~~~~~
util/parse-events.l:257:4: note: in expansion of macro 'REWIND'
    REWIND(0);
    ^~~~~~
/tmp/build/perf/util/parse-events-flex.c: In function 'parse_events__scan_bytes':
/tmp/build/perf/util/parse-events-flex.c:6204:17: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
  for ( i = 0; i < _yybytes_len; ++i )
                 ^
/tmp/build/perf/util/parse-events-flex.c: In function 'yy_fatal_error':
/tmp/build/perf/util/parse-events-flex.c:6265:58: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 static void yy_fatal_error (yyconst char* msg , yyscan_t yyscanner)
                                                          ^~~~~~~~~
/tmp/build/perf/util/parse-events-flex.c: In function 'parse_events_alloc':
/tmp/build/perf/util/parse-events-flex.c:6617:54: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void *parse_events_alloc (yy_size_t  size , yyscan_t yyscanner)
                                                      ^~~~~~~~~
/tmp/build/perf/util/parse-events-flex.c: In function 'parse_events_realloc':
/tmp/build/perf/util/parse-events-flex.c:6622:69: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void *parse_events_realloc  (void * ptr, yy_size_t  size , yyscan_t yyscanner)
                                                                     ^~~~~~~~~
/tmp/build/perf/util/parse-events-flex.c: In function 'parse_events_free':
/tmp/build/perf/util/parse-events-flex.c:6634:47: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void parse_events_free (void * ptr , yyscan_t yyscanner)
                                               ^~~~~~~~~
  CC       /tmp/build/perf/util/pmu-flex.o
  CC       /tmp/build/perf/util/expr-flex.o
/tmp/build/perf/util/pmu-flex.c: In function 'perf_pmu__scan_bytes':
/tmp/build/perf/util/pmu-flex.c:1589:17: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
  for ( i = 0; i < _yybytes_len; ++i )
                 ^
  CC       /tmp/build/perf/util/expr-bison.o
/tmp/build/perf/util/expr-flex.c: In function 'expr__scan_bytes':
/tmp/build/perf/util/expr-flex.c:1789:17: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
  for ( i = 0; i < _yybytes_len; ++i )
                 ^
/tmp/build/perf/util/expr-flex.c: In function 'yy_fatal_error':
/tmp/build/perf/util/expr-flex.c:1810:58: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 static void yy_fatal_error (yyconst char* msg , yyscan_t yyscanner)
                                                          ^~~~~~~~~
/tmp/build/perf/util/expr-flex.c: In function 'expr_alloc':
/tmp/build/perf/util/expr-flex.c:2142:46: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void *expr_alloc (yy_size_t  size , yyscan_t yyscanner)
                                              ^~~~~~~~~
/tmp/build/perf/util/expr-flex.c: In function 'expr_realloc':
/tmp/build/perf/util/expr-flex.c:2147:61: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void *expr_realloc  (void * ptr, yy_size_t  size , yyscan_t yyscanner)
                                                             ^~~~~~~~~
/tmp/build/perf/util/expr-flex.c: In function 'expr_free':
/tmp/build/perf/util/expr-flex.c:2159:39: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void expr_free (void * ptr , yyscan_t yyscanner)
                                       ^~~~~~~~~
  CC       /tmp/build/perf/util/expr.o
cc1: all warnings being treated as errors


  16    19.41 android-ndk:r12b-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  17    19.34 android-ndk:r15c-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  18    14.87 centos:5                      : FAIL gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  19    21.77 centos:6                      : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  20    27.32 centos:7                      : FAIL gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
  21    30.78 centos:8                      : FAIL gcc (GCC) 8.3.1 20190507 (Red Hat 8.3.1-4), clang version 8.0.1 (Red Hat 8.0.1-1.module_el8.1.0+215+a01033fb)

For centos:8:

  FLEX     /tmp/build/perf/util/parse-events-flex.c
  CC       /tmp/build/perf/util/parse-events-bison.o
  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  FLEX     /tmp/build/perf/util/expr-flex.c
  FLEX     /tmp/build/perf/util/expr-flex.h
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu.o
/tmp/build/perf/util/parse-events-flex.c: In function 'parse_events_lex':
/tmp/build/perf/util/parse-events-flex.c:4924:23: error: comparison of integer expressions of different signedness: 'yy_size_t' {aka 'long unsigned int'} and 'int' [-Werror=sign-compare]
    for ( yyl = 0; yyl < yyleng; ++yyl )
                       ^
/tmp/build/perf/util/parse-events-flex.c:189:36: error: comparison of integer expressions of different signedness: 'yy_size_t' {aka 'long unsigned int'} and 'int' [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:207:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^~~~~~~~~~~~~~
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^~~~~~
util/parse-events.l:243:4: note: in expansion of macro 'REWIND'
    REWIND(0);
    ^~~~~~
/tmp/build/perf/util/parse-events-flex.c:189:36: error: comparison of integer expressions of different signedness: 'yy_size_t' {aka 'long unsigned int'} and 'int' [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:207:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^~~~~~~~~~~~~~
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^~~~~~
util/parse-events.l:251:4: note: in expansion of macro 'REWIND'
    REWIND(1);
    ^~~~~~
/tmp/build/perf/util/parse-events-flex.c:189:36: error: comparison of integer expressions of different signedness: 'yy_size_t' {aka 'long unsigned int'} and 'int' [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:207:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^~~~~~~~~~~~~~
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^~~~~~
util/parse-events.l:257:4: note: in expansion of macro 'REWIND'
    REWIND(0);
    ^~~~~~
  CC       /tmp/build/perf/util/pmu-flex.o
  CC       /tmp/build/perf/util/expr-flex.o
  CC       /tmp/build/perf/util/expr-bison.o
  CC       /tmp/build/perf/util/expr.o
cc1: all warnings being treated as errors

  22    68.72 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.3.1 20200501 releases/gcc-9.3.0-196-gcb2c76c8b1, clang version 10.0.0 
  23    29.61 debian:8                      : FAIL gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)

    FLEX     /tmp/build/perf/util/parse-events-flex.c
  CC       /tmp/build/perf/util/parse-events-bison.o
  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  FLEX     /tmp/build/perf/util/expr-flex.c
  FLEX     /tmp/build/perf/util/expr-flex.h
  CC       /tmp/build/perf/util/expr.o
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/pmu-flex.o
  CC       /tmp/build/perf/util/expr-flex.o
  CC       /tmp/build/perf/util/expr-bison.o
util/parse-events.l: In function 'parse_events_lex':
/tmp/build/perf/util/parse-events-flex.c:201:36: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:219:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^
util/parse-events.l:243:4: note: in expansion of macro 'REWIND'
    REWIND(0);
    ^
/tmp/build/perf/util/parse-events-flex.c:201:36: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:219:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^
util/parse-events.l:251:4: note: in expansion of macro 'REWIND'
    REWIND(1);
    ^
/tmp/build/perf/util/parse-events-flex.c:201:36: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
                 for ( yyl = n; yyl < yyleng; ++yyl )\
                                    ^
/tmp/build/perf/util/parse-events-flex.c:219:9: note: in expansion of macro 'YY_LESS_LINENO'
         YY_LESS_LINENO(yyless_macro_arg);\
         ^
util/parse-events.l:129:2: note: in expansion of macro 'yyless'
  yyless(0);      \
  ^
util/parse-events.l:257:4: note: in expansion of macro 'REWIND'
    REWIND(0);
    ^
/tmp/build/perf/util/parse-events-flex.c: In function 'yy_fatal_error':
/tmp/build/perf/util/parse-events-flex.c:6287:58: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 static void yy_fatal_error (yyconst char* msg , yyscan_t yyscanner)
                                                          ^
/tmp/build/perf/util/parse-events-flex.c: In function 'parse_events_alloc':
/tmp/build/perf/util/parse-events-flex.c:6639:54: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void *parse_events_alloc (yy_size_t  size , yyscan_t yyscanner)
                                                      ^
/tmp/build/perf/util/parse-events-flex.c: In function 'parse_events_realloc':
/tmp/build/perf/util/parse-events-flex.c:6644:69: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void *parse_events_realloc  (void * ptr, yy_size_t  size , yyscan_t yyscanner)
                                                                     ^
/tmp/build/perf/util/parse-events-flex.c: In function 'parse_events_free':
/tmp/build/perf/util/parse-events-flex.c:6656:47: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void parse_events_free (void * ptr , yyscan_t yyscanner)
                                               ^
/tmp/build/perf/util/expr-flex.c: In function 'yy_fatal_error':
/tmp/build/perf/util/expr-flex.c:1826:58: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 static void yy_fatal_error (yyconst char* msg , yyscan_t yyscanner)
                                                          ^
/tmp/build/perf/util/expr-flex.c: In function 'expr_alloc':
/tmp/build/perf/util/expr-flex.c:2158:46: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void *expr_alloc (yy_size_t  size , yyscan_t yyscanner)
                                              ^
/tmp/build/perf/util/expr-flex.c: In function 'expr_realloc':
/tmp/build/perf/util/expr-flex.c:2163:61: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void *expr_realloc  (void * ptr, yy_size_t  size , yyscan_t yyscanner)
                                                             ^
/tmp/build/perf/util/expr-flex.c: In function 'expr_free':
/tmp/build/perf/util/expr-flex.c:2175:39: error: unused parameter 'yyscanner' [-Werror=unused-parameter]
 void expr_free (void * ptr , yyscan_t yyscanner)
                                       ^
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.expr-flex.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/expr-flex.o' failed
make[4]: *** [/tmp/build/perf/util/expr-flex.o] Error 1
make[4]: *** Waiting for unfinished jobs....
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.parse-events-flex.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/parse-events-flex.o' failed
make[4]: *** [/tmp/build/perf/util/parse-events-flex.o] Error 1
/git/linux/tools/build/Makefile.build:139: recipe for target 'util' failed
make[3]: *** [util] Error 2
Makefile.perf:625: recipe for target '/tmp/build/perf/perf-in.o' failed
make[2]: *** [/tmp/build/perf/perf-in.o] Error 2
Makefile.perf:230: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make: *** [all] Error 2
make: Leaving directory '/git/linux/tools/perf'
+ exit 1
[root@quaco ~]#

I'll leave it building and will try to figure out what is the problem

