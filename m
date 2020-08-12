Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C10C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CE722B43
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597234906;
	bh=TchgLMsYO5nWzSvoFfTGdAt5WlgG4pa9hkxjrL3N328=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n+dGQNaYGOsNCcmrvYSwnP5oXMe9RVa5zVNUujW2G4sH0FjkAe7xqApNRbORf6nin
	 +wPInPQk90vSqWRzVseyC8csQFNHJW0M+y2WSmRGGKMXykr6+HWMcmEDCZ7qslR0m4
	 8V8/wdqH3eIMyNfQSiz09UGikxmgZI9gR78o/ffo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHLMVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgHLMVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:21:42 -0400
Received: from quaco.ghostprotocols.net (179.176.8.134.dynamic.adsl.gvt.net.br [179.176.8.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CBAC2245C;
        Wed, 12 Aug 2020 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597234901;
        bh=TchgLMsYO5nWzSvoFfTGdAt5WlgG4pa9hkxjrL3N328=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qmgwlisqWtqqGqYWWjLs/WB9pmQ3wxVt1Ntlp2d9B8BPk/kOoJL41vSjLJNh6LsUG
         dAbSYnio/Dn77o+vW65kBO9yWx2D50NVDp2uyXTp7Rthy3ZpraYC9DOGWb6+kJF43i
         kChx7Rp4jVhtDtM4irf5e+LULfZlHxG8gHCwS1N0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7AED1403C6; Wed, 12 Aug 2020 09:21:39 -0300 (-03)
Date:   Wed, 12 Aug 2020 09:21:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, ak@linux.intel.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH V6 06/16] perf script: Use ULL for enum perf_output_field
Message-ID: <20200812122139.GG13995@kernel.org>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810212436.8026-7-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 10, 2020 at 02:24:26PM -0700, Kan Liang escreveu:
> The Bitwise-Shift operator (1U << ) is used in the enum
> perf_output_field, which has already reached its capacity (32 items).
> If more items are added, a compile error will be triggered.
> 
> Change the U to ULL, which extend the capacity to 64 items.
> 
> The enum perf_output_field is only used to calculate a value for the
> 'fields' in the output structure. The 'fields' is u64. The change
> doesn't break anything.

Jiri did this already:

https://git.kernel.org/torvalds/c/60e5eeb56a1
 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-script.c | 64 ++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 447457786362..214bec350971 100644
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
> 2.17.1
> 

-- 

- Arnaldo
