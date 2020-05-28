Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC78C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F913207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590676334;
	bh=Iuf527Lv4W8lUSgkX/OgL6kcWl5Ikgw5vQLggA1ZUQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wUQTnvEzWp85FYGSTMIfB9E3JT3B8sqibhHZtEPXoZg0JC6pz2jmszJ0G3RMmd/be
	 rUT5lMeUDXz6fE9J6Hf0z5lYNElzdDpe7ge3ac/ZbvzlLsk2giDPUiiwWJomOFw91v
	 GX+GdVexuoMzaBw8TFfOaCwskn+nbC8T2nasWoDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391186AbgE1OcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391060AbgE1OcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:32:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EE6820897;
        Thu, 28 May 2020 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590676330;
        bh=Iuf527Lv4W8lUSgkX/OgL6kcWl5Ikgw5vQLggA1ZUQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwhDrxLg9o/608y2aAlXaatTC3/XuoVYhylREpY5A885tLTsLFi4nhjhUIu+j3uA2
         ExqzdCpQYEW2cdM+ZTcec9DJfMOPf2W8mMRsjf6+UlaqKSysagttygQyisWA/CmekK
         8HW6cqR3/HYuqCT7nc1IlRCI2nUGqcv/jC/z0FRs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3CBBA40AFD; Thu, 28 May 2020 11:32:07 -0300 (-03)
Date:   Thu, 28 May 2020 11:32:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Fix --call-trace for Intel PT
Message-ID: <20200528143207.GF16490@kernel.org>
References: <20200527180250.16723-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527180250.16723-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 27, 2020 at 09:02:50PM +0300, Adrian Hunter escreveu:
> Make process_attr() respect -F-ip, noting also that the condition in
> process_attr() (callchain_param.record_mode != CALLCHAIN_NONE) is always
> true so test the sample type directly.
> 
> Example:
> 
>   Before:
> 
>     $ perf record -e intel_pt//u uname
>     Linux
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.033 MB perf.data ]
>     $ perf script --call-trace | head -5
>            uname 30992 [006] 41758.313696574:  cbr: 42 freq: 4219 MHz (156%)                    0 [unknown] ([unknown]                                         )
>            uname 30992 [006] 41758.313696907: _start                               7f71792c4100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )
>            uname 30992 [006] 41758.313699574:     _dl_start                        7f71792c4103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )
>            uname 30992 [006] 41758.313699907:     _dl_start                        7f71792c4e18 _dl_start+0x28 (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )
>            uname 30992 [006] 41758.313701574:     _dl_start                        7f71792c5128 _dl_start+0x338 (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )
> 
>   After:
> 
>     $ perf script --call-trace | head -5
>            uname 30992 [006] 41758.313696574:  cbr: 42 freq: 4219 MHz (156%)
>            uname 30992 [006] 41758.313696907: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )      _start
>            uname 30992 [006] 41758.313699574: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
>            uname 30992 [006] 41758.313699907: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
>            uname 30992 [006] 41758.313701574: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start

Thanks, tested and applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: f288e8e1aa4f ("perf script: Enable IP fields for callchains")
> ---
>  tools/perf/builtin-script.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 5bdd1a393399..3249ead2deef 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -167,6 +167,7 @@ static struct {
>  	u64 fields;
>  	u64 invalid_fields;
>  	u64 user_set_fields;
> +	u64 user_unset_fields;
>  } output[OUTPUT_TYPE_MAX] = {
>  
>  	[PERF_TYPE_HARDWARE] = {
> @@ -2132,10 +2133,18 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
>  	sample_type = perf_evlist__combined_sample_type(evlist);
>  	callchain_param_setup(sample_type);
>  
> -	/* Enable fields for callchain entries, if it got enabled. */
> -	if (callchain_param.record_mode != CALLCHAIN_NONE) {
> -		output[output_type(evsel->core.attr.type)].fields |= PERF_OUTPUT_IP |
> -								     PERF_OUTPUT_SYM;
> +	/* Enable fields for callchain entries */
> +	if (symbol_conf.use_callchain &&
> +	    (sample_type & PERF_SAMPLE_CALLCHAIN ||
> +	     sample_type & PERF_SAMPLE_BRANCH_STACK ||
> +	     (sample_type & PERF_SAMPLE_REGS_USER &&
> +	      sample_type & PERF_SAMPLE_STACK_USER))) {
> +		int type = output_type(evsel->core.attr.type);
> +
> +		if (!(output[type].user_unset_fields & PERF_OUTPUT_IP))
> +			output[type].fields |= PERF_OUTPUT_IP;
> +		if (!(output[type].user_unset_fields & PERF_OUTPUT_SYM))
> +			output[type].fields |= PERF_OUTPUT_SYM;
>  	}
>  	set_print_ip_opts(&evsel->core.attr);
>  	return 0;
> @@ -2704,9 +2713,11 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
>  					if (change == REMOVE) {
>  						output[j].fields &= ~all_output_options[i].field;
>  						output[j].user_set_fields &= ~all_output_options[i].field;
> +						output[j].user_unset_fields |= all_output_options[i].field;
>  					} else {
>  						output[j].fields |= all_output_options[i].field;
>  						output[j].user_set_fields |= all_output_options[i].field;
> +						output[j].user_unset_fields &= ~all_output_options[i].field;
>  					}
>  					output[j].user_set = true;
>  					output[j].wildcard_set = true;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
