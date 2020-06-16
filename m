Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002C0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E5A208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592336386;
	bh=U9o4JDxYO4HNf8D/oWmzZNEgJEBeZ4ggZ5aIabFuHsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oRKd/JHE6nBp3wg5zL5hmnI/kOzUBGuXqDRDkH3/NOWoNRW4Cr4iy4xIg/2Xz13F0
	 meSXPDZP352DRCuBp0m5RmpipSoxU9H6O5M2iykY1mkXM3wlHVhXIS3+D+s7j9eq8V
	 9VbecK/tWnCUe1NJCfquBNNsvvAgPcxkyQawXj/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgFPTjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgFPTjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:39:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.131.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4CEF20810;
        Tue, 16 Jun 2020 19:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592336383;
        bh=U9o4JDxYO4HNf8D/oWmzZNEgJEBeZ4ggZ5aIabFuHsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlZPYrjxwuNUPfBD7BnE1pGI/HjWxnIw4AKtYf7U3LvsTm0AIA3DSR5AKdYCDJhgP
         iB+OHlswRoUXtmkAQvtq0FxN3xsu20kr78qzfpjgP3Ry1QWOsWlsZpyfxwM3jQe01z
         4O6C3m0OgIfstvfu6AK8CJ/TW1KhmkPZJDnmjPVU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0C94940AFD; Tue, 16 Jun 2020 16:39:41 -0300 (-03)
Date:   Tue, 16 Jun 2020 16:39:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2] tools build: Check libasan and libubsan in
 Makefile.feature
Message-ID: <20200616193941.GD6393@kernel.org>
References: <1591164604-20806-1-git-send-email-yangtiezhu@loongson.cn>
 <20200603113228.GV31795@kernel.org>
 <7bbd7c0c-7e09-7eaf-5a54-602e70e36112@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bbd7c0c-7e09-7eaf-5a54-602e70e36112@loongson.cn>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 15, 2020 at 10:20:10AM +0800, Tiezhu Yang escreveu:
> On 06/03/2020 07:32 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 03, 2020 at 02:10:04PM +0800, Tiezhu Yang escreveu:
> > > When build perf with ASan or UBSan, if libasan or libubsan can not find,
> > > the feature-glibc is 0 and there exists the following error log which is
> > > wrong, because we can find gnu/libc-version.h in /usr/include, glibc-devel
> > > is also installed.
> > > [yangtiezhu@linux perf]$ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
> > >    BUILD:   Doing 'make -j4' parallel build
> > >    HOSTCC   fixdep.o
> > >    HOSTLD   fixdep-in.o
> > >    LINK     fixdep
> > > <stdin>:1:0: warning: -fsanitize=address and -fsanitize=kernel-address are not supported for this target
> > > <stdin>:1:0: warning: -fsanitize=address not supported for this target
> > > Auto-detecting system features:
> > > ...                         dwarf: [ OFF ]
> > > ...            dwarf_getlocations: [ OFF ]
> > > ...                         glibc: [ OFF ]
> > > ...                          gtk2: [ OFF ]
> > > ...                      libaudit: [ OFF ]
> > > ...                        libbfd: [ OFF ]
> > > ...                        libcap: [ OFF ]
> > > ...                        libelf: [ OFF ]
> > > ...                       libnuma: [ OFF ]
> > > ...        numa_num_possible_cpus: [ OFF ]
> > > ...                       libperl: [ OFF ]
> > > ...                     libpython: [ OFF ]
> > > ...                     libcrypto: [ OFF ]
> > > ...                     libunwind: [ OFF ]
> > > ...            libdw-dwarf-unwind: [ OFF ]
> > > ...                          zlib: [ OFF ]
> > > ...                          lzma: [ OFF ]
> > > ...                     get_cpuid: [ OFF ]
> > > ...                           bpf: [ OFF ]
> > > ...                        libaio: [ OFF ]
> > > ...                       libzstd: [ OFF ]
> > > ...        disassembler-four-args: [ OFF ]
> > > 
> > > Makefile.config:393: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
> > > Makefile.perf:224: recipe for target 'sub-make' failed
> > > make[1]: *** [sub-make] Error 2
> > > Makefile:69: recipe for target 'all' failed
> > > make: *** [all] Error 2
> > > [yangtiezhu@linux perf]$ ls /usr/include/gnu/libc-version.h
> > > /usr/include/gnu/libc-version.h
> > > 
> > > After install libasan and libubsan, the feature-glibc is 1 and the build
> > > process is success, so the cause is related with libasan or libubsan, we
> > > should check them and print an error log to reflect the reality.
> > > 
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> > > 
> > > v2:
> > >    - Check libasan and libubsan in tools/build/Makefile.feature
> > >    - Modify the patch subject
> > > 
> > >   tools/build/Makefile.feature | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> > > index 3abd431..e147c17 100644
> > > --- a/tools/build/Makefile.feature
> > > +++ b/tools/build/Makefile.feature
> > > @@ -252,3 +252,10 @@ ifeq ($(feature_verbose),1)
> > >     $(foreach feat,$(TMP),$(call feature_print_status,$(feat),))
> > >     $(info )
> > >   endif
> > > +
> > > +ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
> > > +  msg := $(error No libasan found, please install libasan);
> > > +endif
> > > +ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
> > > +  msg := $(error No libubsan found, please install libubsan);
> > > +endif
> > Hey, we need to only do that if -fsanitize=address is in EXTRA_CFLAGS,
> > right?
> 
> Sorry for the late reply.
> Maybe -fsanitize=undefined is also needed.
> Please reference tools/perf/Documentation/Build.txt

Can you send an updated patch then?
 
> > 
> > I applied it and got:
> > 
> >    $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
> >    $ make O=/tmp/build/perf -C tools/perf install-bin
> >    make: Entering directory '/home/acme/git/perf/tools/perf'
> >      BUILD:   Doing 'make -j8' parallel build
> >      HOSTCC   /tmp/build/perf/fixdep.o
> >      HOSTLD   /tmp/build/perf/fixdep-in.o
> >      LINK     /tmp/build/perf/fixdep
> >    Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest version at 'tools/lib/bpf/hashmap.h'
> >    diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
> >    Warning: Kernel ABI header at 'tools/perf/util/hashmap.c' differs from latest version at 'tools/lib/bpf/hashmap.c'
> >    diff -u tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
> >    Auto-detecting system features:
> >    ...                         dwarf: [ on  ]
> >    ...            dwarf_getlocations: [ on  ]
> >    ...                         glibc: [ on  ]
> >    ...                          gtk2: [ on  ]
> >    ...                        libbfd: [ on  ]
> >    ...                        libcap: [ on  ]
> >    ...                        libelf: [ on  ]
> >    ...                       libnuma: [ on  ]
> >    ...        numa_num_possible_cpus: [ on  ]
> >    ...                       libperl: [ on  ]
> >    ...                     libpython: [ on  ]
> >    ...                     libcrypto: [ on  ]
> >    ...                     libunwind: [ on  ]
> >    ...            libdw-dwarf-unwind: [ on  ]
> >    ...                          zlib: [ on  ]
> >    ...                          lzma: [ on  ]
> >    ...                     get_cpuid: [ on  ]
> >    ...                           bpf: [ on  ]
> >    ...                        libaio: [ on  ]
> >    ...                       libzstd: [ on  ]
> >    ...        disassembler-four-args: [ on  ]
> >    /home/acme/git/perf/tools/build/Makefile.feature:255: *** No libasan found, please install libasan.  Stop.
> >    make[1]: *** [Makefile.perf:231: sub-make] Error 2
> >    make: *** [Makefile:110: install-bin] Error 2
> >    make: Leaving directory '/home/acme/git/perf/tools/perf'
> >    $
> > 
> > Something enclosed in:
> > 
> > 	ifneq ($(filter s% -fsanitize=address%,$(EXTRA_CFLAGS),),)
> > 
> > Right Jiri?
> > 
> > - Arnaldo
> 

-- 

- Arnaldo
