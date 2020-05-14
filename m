Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840EEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40213205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldWlMyaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgENPEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgENPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:04:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F51C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:04:51 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m11so1315383qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPvUN6mwRUPTAE+t+JNTcXIfbhXwQm1RCEXYfGEreVU=;
        b=ldWlMyaK32lk9Pkg2z1jFw6apgDEVesNIHNiyNfn3g/e4dgXp7pJ8S2v3JXWu4OAep
         BdAWTeA2wqiMyVAbVgBS0kza9FI8whdq82itKjommt1PC7Ygw19VU8+pnO5TE/NsehQR
         n0Gpyh657+t1L3dzF6zNm5ABFLK1lA6G65ASUZ4JvT0hNHm4AHtdMfwLRPc2ZXFnT5v4
         OLbhxSMVLBXVZhBxRLLmSNHq5WkW1USH40edUwJImzqmDDjaoue+QB4gPlP6jlPW7C5j
         CaGIxH9tGDY2/9tYtpxCIN+sMb1aQaOz4M5RXTzk3tZGIh540d+mk7hTdByvbx5CynnL
         xj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPvUN6mwRUPTAE+t+JNTcXIfbhXwQm1RCEXYfGEreVU=;
        b=SLX9RSgcycZ1EH6PY3YrdFA2FrU0818Ih4W1DS7TaEwo9XSDFAQcjNTPiFWQ5GzLFd
         9Yt+Z9XDDttMwRqEWbHagPCJT1hM+yGLooYk8qurvI886KBGkSiXADjbwGV4Tj7lX4q6
         Lfwm8RKaIRqhkM1CMeexyIza7jvkAn7WBdw4OY+j/tk/KwlS8haTNRrFEg7NJlCVwyjl
         pJfB1iCk5i2jk/4THDEHFmu6I4wX5onOwgKUnGdgvsi96rOMlNMn6ffedTZY4LBQLXE+
         Szbpr7moooE+aO1nmsFIAJ0eYgJm8UJuBsMj82ErPjDfY7W9q4RGDTnZ458dZgdxvzeA
         TsqA==
X-Gm-Message-State: AOAM532n1ZKsFYFPW+fPfIVnVF3Vjl/U0bo/DfJTgHdSFB9O5L2Fjqu7
        ZrV+LqpPXLk/O40I76HiC80=
X-Google-Smtp-Source: ABdhPJxCKBE7gJ3rAOM/tX4X3r3REkkKeY0vrnf+5VISL8mBGhyjwZrzpBccaBqqwXIiGrqJis7I6A==
X-Received: by 2002:a37:38e:: with SMTP id 136mr5254374qkd.247.1589468690554;
        Thu, 14 May 2020 08:04:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 132sm2671178qkj.117.2020.05.14.08.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 08:04:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E8D440AFD; Thu, 14 May 2020 12:04:47 -0300 (-03)
Date:   Thu, 14 May 2020 12:04:47 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/3] tools/perf: build fixes for arch_errno_names.sh
Message-ID: <20200514150447.GA29968@kernel.org>
References: <20200306071110.130202-1-irogers@google.com>
 <20200306071110.130202-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306071110.130202-4-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 11:11:10PM -0800, Ian Rogers escreveu:
> Allow the CC compiler to accept a CFLAGS environment variable.
> Make the architecture test directory agree with the code comment.
> This doesn't change the code generated but makes it easier to integrate
> running the shell script in build systems like bazel.

I've looked at this and split this part in a separate patch, and applied
it locally, please take a look, now looking at the other bit of the
patch.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/trace/beauty/arch_errno_names.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
> index 22c9fc900c84..9f9ea45cddc4 100755
> --- a/tools/perf/trace/beauty/arch_errno_names.sh
> +++ b/tools/perf/trace/beauty/arch_errno_names.sh
> @@ -91,7 +91,7 @@ EoHEADER
>  # in tools/perf/arch
>  archlist=""
>  for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
> -	test -d arch/$arch && archlist="$archlist $arch"
> +	test -d $toolsdir/perf/arch/$arch && archlist="$archlist $arch"
>  done
>  
>  for arch in x86 $archlist generic; do
> -- 
commit 1b59e3b7bfc6183d3dc9f119e1875f9607d29d96
Author: Ian Rogers <irogers@google.com>
Date:   Thu Mar 5 23:11:10 2020 -0800

    perf trace: Fix the selection for architectures to generate the errno name tables
    
    Make the architecture test directory agree with the code comment.
    
    Committer notes:
    
    This was split from a larger patch.
    
    The code was assuming the developer always worked from tools/perf/, so make sure we
    do the test -d having $toolsdir/perf/arch/$arch, to match the intent expressed in the comment,
    just above that loop.
    
    Signed-off-by: Ian Rogers <irogers@google.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Alexios Zavras <alexios.zavras@intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: Igor Lubashev <ilubashe@akamai.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Nick Desaulniers <ndesaulniers@google.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Wei Li <liwei391@huawei.com>
    Link: http://lore.kernel.org/lkml/20200306071110.130202-4-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 22c9fc900c84..f8c44a85650b 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -91,7 +91,7 @@ EoHEADER
 # in tools/perf/arch
 archlist=""
 for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
-	test -d arch/$arch && archlist="$archlist $arch"
+	test -d $toolsdir/perf/arch/$arch && archlist="$archlist $arch"
 done
 
 for arch in x86 $archlist generic; do
