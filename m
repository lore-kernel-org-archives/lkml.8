Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38738C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0832720814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590676704;
	bh=RmFJjgpHIMZ8nygCS4jdK56xf6nwmV9LlmBAHLKo6v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DW8PAxzP97Ype7aluzORjgQ2Kpn6Ve0UJx3C2EWI7b5HtfCfUTRX474fCJKyC79nl
	 xi+BYVFBLqiNiXoYsMPuztPq5g2eJGa6GIrqJtA+4ie7smeLW96XOcWjg4DXfgKch/
	 r93bw8+7BcBCYbMMCGHvVgd9GwrRbOQFsRUPO5oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgE1OiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgE1OiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:38:21 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C8D207D3;
        Thu, 28 May 2020 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590676700;
        bh=RmFJjgpHIMZ8nygCS4jdK56xf6nwmV9LlmBAHLKo6v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEQYwHa7HwpKs7ULE1l+b1U/L9PhAIqvOKS0pz1mAr9a20G4Yvqkm39Lp1/iYmRUv
         LQvCDMh7IDAclMkQDEmNTkUL0IT1Ox4YOoEqqLx0b7ig2UHrii+WwDMLZjAj5XsbYs
         AQPkvmoZDRpMU1JtrGxFf1WTgjMq4lc3iSdnv1wE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 75B4240AFD; Thu, 28 May 2020 11:38:18 -0300 (-03)
Date:   Thu, 28 May 2020 11:38:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 2/2] perf intel-pt: Refine kernel decoding only warning
 message
Message-ID: <20200528143818.GH16490@kernel.org>
References: <20200528120859.21604-1-adrian.hunter@intel.com>
 <20200528120859.21604-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528120859.21604-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 28, 2020 at 03:08:59PM +0300, Adrian Hunter escreveu:
> Stop the message displaying when user space is not being traced.
> 
> Example:
> 
>   Prerequisites:
> 
>     sudo setcap "cap_sys_rawio,cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_ipc_lock=ep" ~/bin/perf
>     sudo chmod +r /proc/kcore
> 
>   Before:
> 
>     $ perf record --no-switch-events --kcore -a -e intel_pt//k -- sleep 0.001
>     Warning:
>     Intel Processor Trace decoding will not be possible except for kernel tracing!
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.838 MB perf.data ]
> 
>   After:
> 
>     $ perf record --no-switch-events --kcore -a -e intel_pt//k -- sleep 0.001
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 1.068 MB perf.data ]
> 
>     $ sudo chmod go-r /proc/kcore
>     $ sudo setcap -r ~/bin/perf

Thanks, tested as root and applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/arch/x86/util/intel-pt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 3fc547769707..9fb137282dc8 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -879,7 +879,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  	 * per-cpu with no sched_switch (except workload-only).
>  	 */
>  	if (!ptr->have_sched_switch && !perf_cpu_map__empty(cpus) &&
> -	    !target__none(&opts->target))
> +	    !target__none(&opts->target) &&
> +	    !intel_pt_evsel->core.attr.exclude_user)
>  		ui__warning("Intel Processor Trace decoding will not be possible except for kernel tracing!\n");
>  
>  	return 0;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
