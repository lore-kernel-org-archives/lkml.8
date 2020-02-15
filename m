Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47280C352A4
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AC72086A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581755813;
	bh=JFw0cgEZWISTYWaAlGZ3Z0sIMAxICnb2wn9dLjM+KjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IjP8+m39dQaPbslYAfwcVxImVsRU5MVBB0utiFBvbS6AYqi2ppbuVra9TB0l/ovd8
	 /NyGtHXyP/pcX3+kJnym3jAZv0EsVa/idQdZByooiHtCkaX6OrmTwn3iYf2isNlNYl
	 o9D3UEwk2wyUdqBfK3C/B3+GKcmOVsrdhU6c1Bmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgBOIgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 03:36:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45263 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgBOIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 03:36:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id g3so13639689wrs.12;
        Sat, 15 Feb 2020 00:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hIiBM6fc+qhC2xLT+fsiSDcQnNPDxc99lzcYg1EoS4Q=;
        b=WPySjz8It8buTPoZ2LRVey7kEvgym9vorbG48DWwwAzORHUHdbksqJW2yoqffMShr5
         iae7+7s0uuuAjkhfT4GuAfVXiShtIhAsjkwcDMYfaO4xOT6RJ3uRcEDkUzGQy37UvMz7
         NDBN/4radbD1nIsyokLw/YbhN8RNNQ9Hk2P8T1zMUQfNXoZN6E5LlxgEmaGCRkaQW0Yc
         FF63cFwtWcbx7Aml1KPHJXvnlz9vpNAYI/O3XhxebpMGTFHmTRAqbn7jmHIEaCLwxMtg
         FhCsBjsEUEMTjw3gloSyj9OcP0//91Bd3yyZgvjJ2BLMzoUOqqAqXyhJsRXf3yraVBJD
         gQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hIiBM6fc+qhC2xLT+fsiSDcQnNPDxc99lzcYg1EoS4Q=;
        b=RfsRuHy+nLYddzeY4Skp72uVa0yDdzpTRfdBLNd2hOOfOJ3fOZBAo2Oghgw2QZqg7K
         RutqP0uAz8+H5hHNfdx8pEDRhRiuonUOtXkFZVKyv2O8CsSAEwUTLoRq9dij9xWQj5AD
         8eDOoVIgPFI4fSYSunw0+FWk09yuiON7UE2/cc+JOx99HUbQeyrjbfbXV9qNvc7NnSs2
         ufvUWqR18Agos/xlVwORSrCyEpOeZEylBdEsjur4GMrK8xmRmgX28+S6z9rGK/MjSMHD
         oxrQ7NKJW5guphLqVcWbTBEFVmnQMl3XPuZDE9lwUDqBXKwwuXKhw6Ci44LfL2fgVeYN
         2HGA==
X-Gm-Message-State: APjAAAWJ+OSqYg4eJ8s8gj/vYVJwJGKTaUsuqSx3gnccCcmRVJGCPfQX
        PAjK2bQH1tW3CxlwEv5KVA8=
X-Google-Smtp-Source: APXvYqwy2aWaM/tumAZwvWzur/4AI+1Y5fKEjnCTIFNJ/Mr1cqkUtBMmeHz4s8ktL/PZ8l4+58fIFg==
X-Received: by 2002:a5d:5742:: with SMTP id q2mr4873533wrw.145.1581755806629;
        Sat, 15 Feb 2020 00:36:46 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p5sm10250789wrt.79.2020.02.15.00.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 00:36:46 -0800 (PST)
Date:   Sat, 15 Feb 2020 09:36:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent improvements and fixes
Message-ID: <20200215083643.GA59911@gmail.com>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.6-20200214
> 
> for you to fetch changes up to 62765941155e487b351a72479078bd6fec973563:
> 
>   perf llvm: Fix script used to obtain kernel make directives to work with new kbuild (2020-02-14 10:06:00 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> BPF:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix script used to obtain kernel make directives to work with new kbuild
>     used for building BPF programs.
> 
> maps:
> 
>   Jiri Olsa:
> 
>   - Fixup kmap->kmaps backpointer in kernel maps.
> 
> arm64:
> 
>   John Garry:
> 
>   - Add arm64 version of get_cpuid() to get proper, arm64 specific output from
>     'perf list' and other tools.
> 
> perf top:
> 
>   Kim Phillips:
> 
>   - Update kernel idle symbols so that output in AMD systems is in line with
>     other systems.
> 
> perf stat:
> 
>   Kim Phillips:
> 
>   - Don't report a null stalled cycles per insn metric.
> 
> tools headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync tools/ headers with the kernel sources to get things like syscall
>     numbers and new arguments so that 'perf trace' can decode and use them in
>     tracepoint filters, e.g. prctl's new PR_{G,S}ET_IO_FLUSHER options.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (15):
>       tools include UAPI: Sync x86's syscalls_64.tbl, generic unistd.h and fcntl.h to pick up openat2 and pidfd_getfd
>       tools headers UAPI: Sync copy of arm64's asm/unistd.h with the kernel sources
>       tools headers UAPI: Sync prctl.h with the kernel sources
>       perf beauty prctl: Export the 'options' strarray
>       perf trace: Resolve prctl's 'option' arg strings to numbers
>       tools headers UAPI: Sync sched.h with the kernel
>       tools headers uapi: Sync linux/fscrypt.h with the kernel sources
>       tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
>       tools headers UAPI: Sync asm-generic/mman-common.h with the kernel
>       tools include UAPI: Sync sound/asound.h copy
>       tools headers x86: Sync disabled-features.h
>       tools arch x86: Sync asm/cpufeatures.h with the kernel sources
>       tools headers kvm: Sync kvm headers with the kernel sources
>       tools headers kvm: Sync linux/kvm.h with the kernel sources
>       perf llvm: Fix script used to obtain kernel make directives to work with new kbuild
> 
> Jiri Olsa (4):
>       perf maps: Mark module DSOs with kernel type
>       perf maps: Mark ksymbol DSOs with kernel type
>       perf maps: Fix map__clone() for struct kmap
>       perf maps: Move kmap::kmaps setup to maps__insert()
> 
> John Garry (1):
>       perf tools: Add arm64 version of get_cpuid()
> 
> Kim Phillips (3):
>       perf stat: Don't report a null stalled cycles per insn metric
>       perf symbols: Update the list of kernel idle symbols
>       perf symbols: Convert symbol__is_idle() to use strlist
> 
>  tools/arch/arm64/include/uapi/asm/kvm.h           |  12 +-
>  tools/arch/arm64/include/uapi/asm/unistd.h        |   1 +
>  tools/arch/x86/include/asm/cpufeatures.h          |   2 +
>  tools/arch/x86/include/asm/disabled-features.h    |   8 +-
>  tools/include/uapi/asm-generic/mman-common.h      |   2 +
>  tools/include/uapi/asm-generic/unistd.h           |   7 +-
>  tools/include/uapi/drm/i915_drm.h                 |  32 +++++
>  tools/include/uapi/linux/fcntl.h                  |   2 +-
>  tools/include/uapi/linux/fscrypt.h                |  14 +-
>  tools/include/uapi/linux/kvm.h                    |   5 +
>  tools/include/uapi/linux/openat2.h                |  39 ++++++
>  tools/include/uapi/linux/prctl.h                  |   4 +
>  tools/include/uapi/linux/sched.h                  |   6 +
>  tools/include/uapi/sound/asound.h                 | 155 ++++++++++++++++++----
>  tools/perf/arch/arm64/util/header.c               |  63 ++++++---
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |   2 +
>  tools/perf/builtin-trace.c                        |   4 +-
>  tools/perf/check-headers.sh                       |   1 +
>  tools/perf/trace/beauty/beauty.h                  |   2 +
>  tools/perf/trace/beauty/prctl.c                   |   3 +-
>  tools/perf/util/llvm-utils.c                      |   1 +
>  tools/perf/util/machine.c                         |  26 ++--
>  tools/perf/util/map.c                             |  17 ++-
>  tools/perf/util/stat-shadow.c                     |   6 -
>  tools/perf/util/symbol.c                          |  17 ++-
>  25 files changed, 353 insertions(+), 78 deletions(-)
>  create mode 100644 tools/include/uapi/linux/openat2.h

Pulled, thanks a lot Arnaldo!

	Ingo
