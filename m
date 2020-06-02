Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181AA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591107090;
	bh=q40Prapa4/P9sMDZERYGcRcWWL9XAhQVnAhfCZEjRSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=boVV2ytSvr8yBy7Z3IMzjzcccbOj8w48SSR+l+GuSro+vwHaJ1cahYR8Xlz5mJ+9F
	 7v8TRSuTx/P8MUTx2Xy3E7qxsnPxaa2w5rGn2r4QxOrLBhS3GeAejC78PI+wN/ebIA
	 Bf7+SGysp0IB22yJFS/AvjJxmWDvtKKX2q1LxL+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgFBOL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBOL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:11:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B96206E2;
        Tue,  2 Jun 2020 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591107087;
        bh=q40Prapa4/P9sMDZERYGcRcWWL9XAhQVnAhfCZEjRSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjcfXPBhHpKvYmnQxmqxc91oZSzvlh4agEbB05ua8GgAOT0JH/c7xzTovOtHKHnjb
         yVoUxhmuYWy5otKMfHhLSLPFSAeOSxJsZ6K4iFXnh8MTGjASdzsGAj/K1I8Xl1PYX8
         ob4hwtuaR6MQAhmS4IScVPCLgS5b/cazP7uE6Nuk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2EE1540AFD; Tue,  2 Jun 2020 11:11:25 -0300 (-03)
Date:   Tue, 2 Jun 2020 11:11:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 1/2] perf tools: check libasan and libubsan in
 Makefile.config
Message-ID: <20200602141125.GR31795@kernel.org>
References: <1591071304-19338-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591071304-19338-1-git-send-email-yangtiezhu@loongson.cn>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 02, 2020 at 12:15:03PM +0800, Tiezhu Yang escreveu:
> When build perf with ASan or UBSan, if libasan or libubsan can not find,
> the feature-glibc is 0 and there exists the following error log which is
> wrong, because we can find gnu/libc-version.h in /usr/include, glibc-devel
> is also installed.

I'll check this later,

- Arnaldo
 
> [yangtiezhu@linux perf]$ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
>   BUILD:   Doing 'make -j4' parallel build
>   HOSTCC   fixdep.o
>   HOSTLD   fixdep-in.o
>   LINK     fixdep
> <stdin>:1:0: warning: -fsanitize=address and -fsanitize=kernel-address are not supported for this target
> <stdin>:1:0: warning: -fsanitize=address not supported for this target
> 
> Auto-detecting system features:
> ...                         dwarf: [ OFF ]
> ...            dwarf_getlocations: [ OFF ]
> ...                         glibc: [ OFF ]
> ...                          gtk2: [ OFF ]
> ...                      libaudit: [ OFF ]
> ...                        libbfd: [ OFF ]
> ...                        libcap: [ OFF ]
> ...                        libelf: [ OFF ]
> ...                       libnuma: [ OFF ]
> ...        numa_num_possible_cpus: [ OFF ]
> ...                       libperl: [ OFF ]
> ...                     libpython: [ OFF ]
> ...                     libcrypto: [ OFF ]
> ...                     libunwind: [ OFF ]
> ...            libdw-dwarf-unwind: [ OFF ]
> ...                          zlib: [ OFF ]
> ...                          lzma: [ OFF ]
> ...                     get_cpuid: [ OFF ]
> ...                           bpf: [ OFF ]
> ...                        libaio: [ OFF ]
> ...                       libzstd: [ OFF ]
> ...        disassembler-four-args: [ OFF ]
> 
> Makefile.config:393: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
> Makefile.perf:224: recipe for target 'sub-make' failed
> make[1]: *** [sub-make] Error 2
> Makefile:69: recipe for target 'all' failed
> make: *** [all] Error 2
> [yangtiezhu@linux perf]$ ls /usr/include/gnu/libc-version.h
> /usr/include/gnu/libc-version.h
> 
> After install libasan and libubsan, the feature-glibc is 1 and the build
> process is success, so the cause is related with libasan or libubsan, we
> should check them and print an error log to reflect the reality.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/perf/Makefile.config | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 12a8204..b699d21 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -387,6 +387,12 @@ else
>        NO_LIBBPF := 1
>        NO_JVMTI := 1
>      else
> +      ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
> +        msg := $(error No libasan found, please install libasan);
> +      endif
> +      ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
> +        msg := $(error No libubsan found, please install libubsan);
> +      endif
>        ifneq ($(filter s% -static%,$(LDFLAGS),),)
>          msg := $(error No static glibc found, please install glibc-static);
>        else
> -- 
> 2.1.0
> 

-- 

- Arnaldo
