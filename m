Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30232C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0941C21D93
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587031678;
	bh=U07hiohRA+D9y6jbCgSK5eKp4Syf0sJdVgvk/8g3YAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T6yuQdnndMYlzYkvUKBlBoM5MjK0IF8Pr2bgrgI2RDJRoZW+pWvsB48SG6bSJPhyd
	 CAYDFoiBv5AjyKVjvCcIm8Pk3t82NtA3vu+/JYspeThg6piJj54xpHWeA7x+AljN0F
	 Dne+Kp0UGm+xUANI/u/3mJDBF0TEXrssHSKfvGFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504759AbgDPKHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504502AbgDPKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:07:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15791C061A0C;
        Thu, 16 Apr 2020 03:07:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so4175916wmh.3;
        Thu, 16 Apr 2020 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OlzqNuRAf4M1JO6sfzgiibPFGi4knfJaatl8Sy869Yc=;
        b=TegZ0HssEhBvvlvwTu2nZs6DxIi6nIPmIjIHw4srcWPisr91rqUeZaSd6SeWAPbylt
         MlkkFoLfpt0pGJ6cGW2oACMTqGjRM055ByGn1a5PpoFK2Hd0sNkdJtleufzAGiT7k3eo
         43999l9SrgK7855poFj0PoI+1EgnnjAfc81otOAFU7271t+vgAglTppC84o8sWKRq0we
         M6Wkaboy8Od/VA3tNfJzykxtdcemGwizN2naOljwDnYHAXUzeImhr3uDv/1zNqrBW8g9
         ZL/8TuajcIw+ngGp9AVIcWv9ppgBt/TqlOvV/pUapCMou+ofHZLCMtxKccudu0IRpstO
         jTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OlzqNuRAf4M1JO6sfzgiibPFGi4knfJaatl8Sy869Yc=;
        b=shjsY5i2CzOGBIFSY7kCUkvnMiRjU3C96c9XkWRpZvCq/+6dss1FZpm5QiYj1NNGiK
         bo8+8QQRcGOTytBw6Tq4xuexWi0jxtoFWDNQ55xeWZ3DdoQtsAw8AUmFaEDOTLIUWXY7
         RmUwbsdVNcd/9Y6menZnjbGOyrPQYDALpAt+Ft6T0DqTDNouaJlLc/vg1A0V+JnpdrtD
         GNiM3p8PsfPpqjlBuygjHcmsV6qCAQZKx5TMLej6eP7gQhQCwKYpxH7YTIrQ99m9K4ey
         nBCsxzsRoz25y0Ldk25xEPn0csp5+UmiocJHzwVnJouKOIWp7iijPrsHQpK8wgH2Em34
         a4tg==
X-Gm-Message-State: AGi0PuanqVRJnYBL1Klx62gJy/XBj5sdd/RSaNEJQTPP5gIzQE19KwP+
        QqHy5CKTAmituYkMJDoCqNY=
X-Google-Smtp-Source: APiQypLnANVYVz8+YLsANYD1nEKM9cffSvsulKQtEUTSFn41Z/E6LePJcnU7wy56my/PxqjCaZ0f8A==
X-Received: by 2002:a7b:c118:: with SMTP id w24mr3938775wmi.173.1587031661719;
        Thu, 16 Apr 2020 03:07:41 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l26sm19586480wrb.7.2020.04.16.03.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 03:07:40 -0700 (PDT)
Date:   Thu, 16 Apr 2020 12:07:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20200416100738.GC18982@gmail.com>
References: <20200414164854.26026-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
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
> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
> 
>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.7-20200414
> 
> for you to fetch changes up to e3698b23ecb8c099b4b523e7d5c8c042e93ef15d:
> 
>   tools headers: Synchronize linux/bits.h with the kernel sources (2020-04-14 11:40:05 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf stat:
> 
>   Jin Yao:
> 
>   - Fix no metric header if --per-socket and --metric-only set
> 
> build system:
> 
>   - Fix python building when built with clang, that was failing if the clang
>     version doesn't support -fno-semantic-interposition.
> 
> tools UAPI headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Update various copies of kernel headers, some ended up automatically
>     updating build-time generated tables to enable tools such as 'perf trace'
>     to decode syscalls and tracepoints arguments.
> 
>     Now the tools/perf build is free of UAPI drift warnings.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (14):
>       tools arch x86: Sync the msr-index.h copy with the kernel sources
>       perf python: Check if clang supports -fno-semantic-interposition
>       tools headers: Update linux/vdso.h and grab a copy of vdso/const.h
>       tools headers UAPI: Sync sched.h with the kernel
>       tools headers UAPI: Sync linux/mman.h with the kernel
>       tools arch x86: Sync asm/cpufeatures.h with the kernel sources
>       tools include UAPI: Sync linux/vhost.h with the kernel sources
>       tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
>       tools headers kvm: Sync linux/kvm.h with the kernel sources
>       tools headers UAPI: Update tools's copy of drm.h headers
>       tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
>       tools headers: Update x86's syscall_64.tbl with the kernel sources
>       tools headers: Adopt verbatim copy of compiletime_assert() from kernel sources
>       tools headers: Synchronize linux/bits.h with the kernel sources
> 
> Jin Yao (1):
>       perf stat: Fix no metric header if --per-socket and --metric-only set
> 
>  tools/arch/x86/include/asm/cpufeatures.h          |   5 +-
>  tools/arch/x86/include/asm/msr-index.h            |   9 +
>  tools/include/linux/bits.h                        |  24 +-
>  tools/include/linux/build_bug.h                   |  82 +++
>  tools/include/linux/compiler.h                    |  26 +
>  tools/include/linux/const.h                       |   5 +-
>  tools/include/linux/kernel.h                      |   4 +-
>  tools/include/uapi/drm/drm.h                      |   2 +
>  tools/include/uapi/drm/i915_drm.h                 |  21 +
>  tools/include/uapi/linux/fscrypt.h                |   1 +
>  tools/include/uapi/linux/kvm.h                    |  47 +-
>  tools/include/uapi/linux/mman.h                   |   5 +-
>  tools/include/uapi/linux/sched.h                  |   5 +
>  tools/include/uapi/linux/vhost.h                  |  24 +
>  tools/include/vdso/bits.h                         |   9 +
>  tools/include/vdso/const.h                        |  10 +
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 740 +++++++++++-----------
>  tools/perf/check-headers.sh                       |   3 +
>  tools/perf/trace/beauty/clone.c                   |   1 +
>  tools/perf/trace/beauty/mmap.c                    |   1 +
>  tools/perf/util/setup.py                          |   2 +
>  tools/perf/util/stat-shadow.c                     |   7 +-
>  22 files changed, 646 insertions(+), 387 deletions(-)
>  create mode 100644 tools/include/linux/build_bug.h
>  create mode 100644 tools/include/vdso/bits.h
>  create mode 100644 tools/include/vdso/const.h

Pulled into tip:perf/urgent, thanks a lot Arnaldo!

	Ingo
