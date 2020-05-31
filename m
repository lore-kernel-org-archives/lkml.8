Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6018C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69DE2076B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590927464;
	bh=hTanx8Y8bCCgorkG5/bXWyQCs9lIgwprPSFfj4lv8+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zRaLtzX/KXF4KSNaPt8ZHuBjqG3xjVqgGpW5V2mnAOrwnqUaXCP/nDG/crvtpwgEh
	 vBqerUCMYUuKZ217DIKbjAOL9RtKa8vLeh68lgpxDZOLKKKPfPZwbsB6NJ87qMRlHg
	 /lOzUQf9RwEv0/9PaoSAShZDrR8EowHneGwY0b/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgEaMRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 08:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbgEaMRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 08:17:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE701206F1;
        Sun, 31 May 2020 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590927462;
        bh=hTanx8Y8bCCgorkG5/bXWyQCs9lIgwprPSFfj4lv8+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0n00xg5uZmTkhL5qoAnuQxmg9iaMg2dDtWrVXgyOUqUwipi0vd7HPH9qzUeHj3No
         nWViypRCC3hCok1SRfXG6Z2rUhggkKq2qVIr9FWTC5Pd8+rMPJ5hk2UUZfUYtzzlS+
         iNDsuqO/68Nb62dIIpMa8KRyFLdZp72rKsqjhcqM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1C8E40AFD; Sun, 31 May 2020 09:17:40 -0300 (-03)
Date:   Sun, 31 May 2020 09:17:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/3] perf test: Unwind fixes
Message-ID: <20200531121740.GE31795@kernel.org>
References: <20200530082015.39162-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530082015.39162-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 30, 2020 at 01:20:12AM -0700, Ian Rogers escreveu:
> Fix stack frame count and memory sanitizer issues when running the
> dwarf unwinding test with the elfutils/libdw unwinder (libunwind
> disabled).

Thanks, applied.
 
> Ian Rogers (3):
>   tools compiler.h: Add attribute to disable tail calls
>   perf tests: Don't tail call optimize in unwind test
>   perf test: Initialize memory in dwarf-unwind
> 
>  tools/include/linux/compiler-gcc.h       |  8 ++++++++
>  tools/include/linux/compiler.h           |  3 +++
>  tools/perf/arch/x86/tests/dwarf-unwind.c |  8 ++++++++
>  tools/perf/tests/dwarf-unwind.c          | 11 ++++++-----
>  4 files changed, 25 insertions(+), 5 deletions(-)
> 
> -- 
> 2.27.0.rc2.251.g90737beb825-goog
> 

-- 

- Arnaldo
