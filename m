Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A84EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF53D20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590783572;
	bh=54POcsKVLD+4Fr8LyFN7BTyjEdg9FvL0qMZYFmuBkKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IZ/eY8B4fQDPL+NHCrln7CE/nf3CHX1jhFC/mb4S40rcgePgKE2aYas2IbPQOjYu+
	 JxsWzP9iWvZvnrWAUNNR2wnt5WK8QmvWuSKoaaTcy5LGwil4n2H1B7E0G0gAYrJa/o
	 JvrvKBEniUUSuXw0RHzn4LsanJH5fyoiYm3wnn1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgE2UTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgE2UTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:19:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CAC92074D;
        Fri, 29 May 2020 20:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590783569;
        bh=54POcsKVLD+4Fr8LyFN7BTyjEdg9FvL0qMZYFmuBkKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGEzNVU9mu8GMwZFM5OvpFuRQbRT1vsAPttn4lGJIHDlYV8ooj9hvaERS/ZnH1i7c
         navgYasAvAmMDBpOyFBhbNWqmLpHbA3+7xEB5+LFzJlfsiCSll5QkK9b8DJIdij543
         UM5+mECzPPMaaiszVTQVGLmCV9O5s5ttsydL7GSA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2882B40AFD; Fri, 29 May 2020 17:19:27 -0300 (-03)
Date:   Fri, 29 May 2020 17:19:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] perf build: Group the NO_SYSCALL_TABLE logic
Message-ID: <20200529201927.GC31795@kernel.org>
References: <20200529155552.463-1-acme@kernel.org>
 <20200529155552.463-2-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529155552.463-2-acme@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 29, 2020 at 12:55:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To help in allowing to disable it from the make command line.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.config | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ae325f79e598..93fb7510a9a9 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -23,12 +23,26 @@ include $(srctree)/tools/scripts/Makefile.arch
>  $(call detected_var,SRCARCH)
>  
>  NO_PERF_REGS := 1
> +
>  NO_SYSCALL_TABLE := 1
>  
> +ifeq ($(SRCARCH),x86)
> +  ifeq (${IS_64_BIT}, 1)
> +    NO_SYSCALL_TABLE := 0
> +  endif
> +else
> +  ifneq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390))

The above should've been a ifeq, to see if SRCARCH is one of those,
detected in the cross build tests, fixed.

- Arnaldo

> +    NO_SYSCALL_TABLE := 0
> +  endif
> +endif
> +
> +ifneq ($(NO_SYSCALL_TABLE),1)
> +  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
> +endif
> +
>  # Additional ARCH settings for ppc
>  ifeq ($(SRCARCH),powerpc)
>    NO_PERF_REGS := 0
> -  NO_SYSCALL_TABLE := 0
>    CFLAGS += -I$(OUTPUT)arch/powerpc/include/generated
>    LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
>  endif
> @@ -37,7 +51,6 @@ endif
>  ifeq ($(SRCARCH),x86)
>    $(call detected,CONFIG_X86)
>    ifeq (${IS_64_BIT}, 1)
> -    NO_SYSCALL_TABLE := 0
>      CFLAGS += -DHAVE_ARCH_X86_64_SUPPORT -I$(OUTPUT)arch/x86/include/generated
>      ARCH_INCLUDE = ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/memset_64.S
>      LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
> @@ -55,7 +68,6 @@ endif
>  
>  ifeq ($(SRCARCH),arm64)
>    NO_PERF_REGS := 0
> -  NO_SYSCALL_TABLE := 0
>    CFLAGS += -I$(OUTPUT)arch/arm64/include/generated
>    LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
>  endif
> @@ -70,7 +82,6 @@ endif
>  
>  ifeq ($(ARCH),s390)
>    NO_PERF_REGS := 0
> -  NO_SYSCALL_TABLE := 0
>    CFLAGS += -fPIC -I$(OUTPUT)arch/s390/include/generated
>  endif
>  
> @@ -78,10 +89,6 @@ ifeq ($(NO_PERF_REGS),0)
>    $(call detected,CONFIG_PERF_REGS)
>  endif
>  
> -ifneq ($(NO_SYSCALL_TABLE),1)
> -  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
> -endif
> -
>  # So far there's only x86 and arm libdw unwind support merged in perf.
>  # Disable it on all other architectures in case libdw unwind
>  # support is detected in system. Add supported architectures
> -- 
> 2.25.3
> 

-- 

- Arnaldo
