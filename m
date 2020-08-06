Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4205DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8122D206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735551;
	bh=QrxjxFQXvrxHBH9YwYcV7vnXh+iepBJIdhJO2i2pYwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZPIkVxiOc3awVFASpaow96P2dTamp3sP92HPsIszYyYQ3LZtp2+XiDZzUWGdlYKyP
	 M1E/g+7uJ8UbiXvGhLUFdk5CAhP/K9EldbqV1d2n4I2RhFEPB/lX3GNKWslKqszx3G
	 bX/y5Oxucv1AseOWfXAXmLkP3thFLFgcIL0L0W/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgHFRjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbgHFRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.129.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A3B22D0B;
        Thu,  6 Aug 2020 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596717970;
        bh=QrxjxFQXvrxHBH9YwYcV7vnXh+iepBJIdhJO2i2pYwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uX8oj8a0O0wlst6i0TMUJvQdx1C9L0JnVS7VabH1BZZjEM3yNcWmoAM235rVTBzip
         vF/heXazR6fsDCMq25esXaLoi2m6SGrnIZbeUfuT75aIz+TpUyIUAOpaNKlIoJdFU5
         CGNrv9pkmgZoSFhouNY48YNe8/9w4aMGnis/isZM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1FA3B40D9D; Thu,  6 Aug 2020 09:46:08 -0300 (-03)
Date:   Thu, 6 Aug 2020 09:46:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH v2 6/7] perf script: Change enum perf_output_field values
 to be 64 bits
Message-ID: <20200806124608.GH71359@kernel.org>
References: <20200805093444.314999-1-jolsa@kernel.org>
 <20200805093444.314999-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805093444.314999-7-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 05, 2020 at 11:34:43AM +0200, Jiri Olsa escreveu:
> So it's possible to add new values. I did not find any place
> where the enum values are passed through some number type,
> so it's safe to make this change.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-script.c | 64 ++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 0dfc38fb6d35..eb45f678dc2f 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -82,38 +82,38 @@ static bool			native_arch;
>  unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
>  
>  enum perf_output_field {
> -	PERF_OUTPUT_COMM            = 1U << 0,
> -	PERF_OUTPUT_TID             = 1U << 1,
> -	PERF_OUTPUT_PID             = 1U << 2,
> -	PERF_OUTPUT_TIME            = 1U << 3,
> -	PERF_OUTPUT_CPU             = 1U << 4,
> -	PERF_OUTPUT_EVNAME          = 1U << 5,
> -	PERF_OUTPUT_TRACE           = 1U << 6,
> -	PERF_OUTPUT_IP              = 1U << 7,
> -	PERF_OUTPUT_SYM             = 1U << 8,
> -	PERF_OUTPUT_DSO             = 1U << 9,
> -	PERF_OUTPUT_ADDR            = 1U << 10,
> -	PERF_OUTPUT_SYMOFFSET       = 1U << 11,
> -	PERF_OUTPUT_SRCLINE         = 1U << 12,
> -	PERF_OUTPUT_PERIOD          = 1U << 13,
> -	PERF_OUTPUT_IREGS	    = 1U << 14,
> -	PERF_OUTPUT_BRSTACK	    = 1U << 15,
> -	PERF_OUTPUT_BRSTACKSYM	    = 1U << 16,
> -	PERF_OUTPUT_DATA_SRC	    = 1U << 17,
> -	PERF_OUTPUT_WEIGHT	    = 1U << 18,
> -	PERF_OUTPUT_BPF_OUTPUT	    = 1U << 19,
> -	PERF_OUTPUT_CALLINDENT	    = 1U << 20,
> -	PERF_OUTPUT_INSN	    = 1U << 21,
> -	PERF_OUTPUT_INSNLEN	    = 1U << 22,
> -	PERF_OUTPUT_BRSTACKINSN	    = 1U << 23,
> -	PERF_OUTPUT_BRSTACKOFF	    = 1U << 24,
> -	PERF_OUTPUT_SYNTH           = 1U << 25,
> -	PERF_OUTPUT_PHYS_ADDR       = 1U << 26,
> -	PERF_OUTPUT_UREGS	    = 1U << 27,
> -	PERF_OUTPUT_METRIC	    = 1U << 28,
> -	PERF_OUTPUT_MISC            = 1U << 29,
> -	PERF_OUTPUT_SRCCODE	    = 1U << 30,
> -	PERF_OUTPUT_IPC             = 1U << 31,
> +	PERF_OUTPUT_COMM            = 1ULL << 0,
> +	PERF_OUTPUT_TID             = 1ULL << 1,
> +	PERF_OUTPUT_PID             = 1ULL << 2,
> +	PERF_OUTPUT_TIME            = 1ULL << 3,
> +	PERF_OUTPUT_CPU             = 1ULL << 4,
> +	PERF_OUTPUT_EVNAME          = 1ULL << 5,
> +	PERF_OUTPUT_TRACE           = 1ULL << 6,
> +	PERF_OUTPUT_IP              = 1ULL << 7,
> +	PERF_OUTPUT_SYM             = 1ULL << 8,
> +	PERF_OUTPUT_DSO             = 1ULL << 9,
> +	PERF_OUTPUT_ADDR            = 1ULL << 10,
> +	PERF_OUTPUT_SYMOFFSET       = 1ULL << 11,
> +	PERF_OUTPUT_SRCLINE         = 1ULL << 12,
> +	PERF_OUTPUT_PERIOD          = 1ULL << 13,
> +	PERF_OUTPUT_IREGS	    = 1ULL << 14,
> +	PERF_OUTPUT_BRSTACK	    = 1ULL << 15,
> +	PERF_OUTPUT_BRSTACKSYM	    = 1ULL << 16,
> +	PERF_OUTPUT_DATA_SRC	    = 1ULL << 17,
> +	PERF_OUTPUT_WEIGHT	    = 1ULL << 18,
> +	PERF_OUTPUT_BPF_OUTPUT	    = 1ULL << 19,
> +	PERF_OUTPUT_CALLINDENT	    = 1ULL << 20,
> +	PERF_OUTPUT_INSN	    = 1ULL << 21,
> +	PERF_OUTPUT_INSNLEN	    = 1ULL << 22,
> +	PERF_OUTPUT_BRSTACKINSN	    = 1ULL << 23,
> +	PERF_OUTPUT_BRSTACKOFF	    = 1ULL << 24,
> +	PERF_OUTPUT_SYNTH           = 1ULL << 25,
> +	PERF_OUTPUT_PHYS_ADDR       = 1ULL << 26,
> +	PERF_OUTPUT_UREGS	    = 1ULL << 27,
> +	PERF_OUTPUT_METRIC	    = 1ULL << 28,
> +	PERF_OUTPUT_MISC            = 1ULL << 29,
> +	PERF_OUTPUT_SRCCODE	    = 1ULL << 30,
> +	PERF_OUTPUT_IPC             = 1ULL << 31,
>  };
>  
>  struct output_option {
> -- 
> 2.25.4
> 

-- 

- Arnaldo
