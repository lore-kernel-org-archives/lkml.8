Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDA9C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7253B246AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582967568;
	bh=/17i6A5zxf9hIQar3PyiujsJE9r1s5hi7Ji7IrTfsuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eCO9sxggTW9TSTl3zHXJRED5hfRz2D4QA1jSvlrptl+vcEONRCepLpMwp7gEu8rmZ
	 zXEaGK3l2BjQIhrOxh8LV1ZmnsDibm+g39o+q3fyQcSucOJDT4dVRRi8zT0tRUsO8Y
	 TBUVayPrXLCQRp3BsRVfreROXFO+Ci5YQs1/uz50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgB2JMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 04:12:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38879 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgB2JME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:12:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id e8so6091359wrm.5;
        Sat, 29 Feb 2020 01:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q1k9FHaiXfJ/3FbZaHs3Pl1sBoOSSSbZGIUOPSJ3m9I=;
        b=d7wrbiE99mf5aodj8y2B8/+jdfzIiCbsROxkK5wd9fCIgsbM6bhGfnBCpyC7jw5rq8
         v6kDVjBtPfT/Mye2fs57gpDlt6uLnC5XsxeBhvAGoHpeHACyUqiMuY2nVDzgX2QWIFX5
         /NYMImzTTCk9Y9akY4SlDwvPE+f+pc95MzOEF8t3VAp0luqZqiPMFoEB6eRnBgB+H83j
         WKwezcNPJBJ0EofrWcA76FunrE8B6GZZJI32slkjeTnTG0T4f8DcuiNrOHuQtaiVO6xJ
         UvERUDTHSlPtOPr2W5BUJJpePHq5an73TUs3PzoL/b6WGxjz+wWRK5nc58FRaTi0qh0k
         KGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q1k9FHaiXfJ/3FbZaHs3Pl1sBoOSSSbZGIUOPSJ3m9I=;
        b=a6foLRQIt8DBjPssiyZcrdbvvCABLUorXPWCb8mXfPbn6fecl0lTUeELhVAm6kyy+B
         tZLfORHceUmK74gLB62sKA+Ix0EKkIiUtA7QUjOsm7ISEiqwOfshz8zbMRgmdAbcyzEa
         Vm8gUbVPdKoFTHaOVzsf55oECPDkGndVt2oY4FPGTNyUuzuH/hSnACj/aJMfMOD75T9o
         ia8/cf3S4ornzEhs8pcEWRe+F+BJFlK4xPr12HLAvEuVxNXKmubrDghnvLxHGn2GKp5V
         oyvtt1Ha0frUCTyanaR2sA8NBIIYzgxJWcsAvJ9fxNTCQcxEhjGCiGrXGICRJwPZOiMP
         JTsg==
X-Gm-Message-State: APjAAAU3JLHGIOfbmNKgsXOGzw4LMGJV7KDxj8JfKplheHHBuFyvhzGL
        mtbupk+6uQ7vrtjy7MGU0fQ=
X-Google-Smtp-Source: APXvYqyhSDFaz4XRIJxFMUJrhYs4GJ7epBBQVl13J+Gd2FbOQ1/tpMOubixgZq9vBo/UiywmM6cZww==
X-Received: by 2002:adf:e490:: with SMTP id i16mr5114045wrm.215.1582967522601;
        Sat, 29 Feb 2020 01:12:02 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g14sm17113777wrv.58.2020.02.29.01.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 01:12:01 -0800 (PST)
Date:   Sat, 29 Feb 2020 10:11:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        He Zhe <zhe.he@windriver.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20200229091159.GA92847@gmail.com>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
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
> The following changes since commit 4c45945aa418f5e2f31cdaf0b1484e146e29f72f:
> 
>   Merge tag 'perf-urgent-for-mingo-5.6-20200220' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2020-02-26 15:18:05 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.6-20200228
> 
> for you to fetch changes up to e0560ba6d92f06dbe13e9d11c921a60c07ea6fcc:
> 
>   perf annotate: Fix segfault with source toggle (2020-02-27 11:47:23 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf annotate:
> 
>   Ravi Bangoria:
> 
>   - Fix segfault with source toggle.
> 
>   - Fix --show-total-period and --show-nr-samples for tui/stdio2.
> 
>   - Fix handling of settings in ~/.perfconfig versus the ones passed
>     in the command line
> 
>   - Re-render title bar after switching back from script browser.
> 
>   - Fix options man page, document some missing ones.
> 
> perf probe:
> 
>   He Zhe:
> 
>   - Check return value of strlist__add() for -ENOMEM.
> 
> tools UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync x86's msr-index.h copy with the kernel sources.
> 
>   - Update tools's copy of x86's kvm.h headers.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (2):
>       tools arch x86: Sync the msr-index.h copy with the kernel sources
>       tools headers UAPI: Update tools's copy of kvm.h headers
> 
> He Zhe (1):
>       perf probe: Check return value of strlist__add() for -ENOMEM
> 
> Ravi Bangoria (12):
>       perf annotate/tui: Re-render title bar after switching back from script browser
>       perf annotate: Fix --show-total-period for tui/stdio2
>       perf annotate: Fix --show-nr-samples for tui/stdio2
>       perf config: Introduce perf_config_u8()
>       perf annotate: Make perf config effective
>       perf annotate: Prefer cmdline option over default config
>       perf annotate: Fix perf config option description
>       perf config: Document missing config options
>       perf annotate: Remove privsize from symbol__annotate() args
>       perf annotate: Simplify disasm_line allocation and freeing code
>       perf annotate: Align struct annotate_args
>       perf annotate: Fix segfault with source toggle
> 
>  tools/arch/x86/include/asm/msr-index.h   |   2 +
>  tools/arch/x86/include/uapi/asm/kvm.h    |   1 +
>  tools/perf/Documentation/perf-config.txt |  74 +++++++++++-
>  tools/perf/builtin-annotate.c            |   4 +-
>  tools/perf/builtin-probe.c               |   6 +-
>  tools/perf/builtin-report.c              |   2 +-
>  tools/perf/builtin-top.c                 |   4 +-
>  tools/perf/ui/browsers/annotate.c        |  19 ++-
>  tools/perf/ui/gtk/annotate.c             |   2 +-
>  tools/perf/util/annotate.c               | 194 ++++++++++++-------------------
>  tools/perf/util/annotate.h               |   9 +-
>  tools/perf/util/config.c                 |  12 ++
>  tools/perf/util/config.h                 |   1 +
>  tools/perf/util/probe-file.c             |  28 ++++-
>  14 files changed, 210 insertions(+), 148 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
