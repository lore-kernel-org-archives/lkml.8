Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E38CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119EA20674
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593775509;
	bh=fJRaNyAeb84nWoNN6LiVp9hepWCKtTyjL/1CsYFY0ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YARvLQrYqRDBVlCN6h9H4Rp4rs4VdSjPUkMtGJ1oHnzI+4VfPSb4WKfmenTRLqPq/
	 757SnxAjWT+rutVrLA+h5Os715MUkqZM3lmtJW6KjF/BZ+xfV56Kh2h5Nfy/lSQGig
	 aN7upbdEbcMuHuQDByySFuO+4hZ7qiqWjZjCI1o0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgGCLZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGCLZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:25:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.131.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06888207FF;
        Fri,  3 Jul 2020 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593775506;
        bh=fJRaNyAeb84nWoNN6LiVp9hepWCKtTyjL/1CsYFY0ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLLdsH9vXBEC1yJF+aZOoALDT7ouoy8gJ2QE5BuE1vcRq5c11pIrF0DDbNVI2Tely
         VAcjzK8Oxd30n59JAlbjAuItqkMmJHXn6ZlaOZmnI3MliZnaSTC3fKxkNHjdYhH+Zf
         sMmHKjCoLswn8eg1x/4EZarNwMIpEu+JG7RVIOsE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AEAC3405FF; Fri,  3 Jul 2020 08:25:03 -0300 (-03)
Date:   Fri, 3 Jul 2020 08:25:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH 1/3] perf intel-pt: Fix recording PEBS-via-PT with
 registers
Message-ID: <20200703112503.GB1320@kernel.org>
References: <20200630133935.11150-1-adrian.hunter@intel.com>
 <20200630133935.11150-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630133935.11150-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 30, 2020 at 04:39:33PM +0300, Adrian Hunter escreveu:
> When recording PEBS-via-PT, the kernel will not accept the intel_pt event
> with register sampling e.g.
> 
>  # perf record --kcore -c 10000 -e '{intel_pt/branch=0/,branch-loads/aux-output/ppp}' -I -- ls -l
>  Error:
>  intel_pt/branch=0/: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
> 
> Fix by suppressing register sampling on the intel_pt evsel.

Next time please inform what is the hardware that supports PEBS-via-PT,
I tried this on a:

[    0.245654] smpboot: CPU0: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz (family: 0x6, model: 0x8e, stepping: 0xa)
[    0.245791] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.

And even after this fix I get:

[root@quaco ~]# perf record --kcore -c 10000 -e '{intel_pt/branch=0/,branch-loads/aux-output/ppp}' -I -- ls -l
Error:
branch-loads: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
[root@quaco ~]#

Further details:

[root@quaco ~]# perf record -vv --kcore -c 10000 -e '{intel_pt/branch=0/,branch-loads/aux-output/ppp}' -I -- ls -l
Using CPUID GenuineIntel-6-8E-A
intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
Attempting to add event pmu 'intel_pt' with 'branch,' that may result in non-fatal errors
After aliases, add event pmu 'intel_pt' with 'branch,' that may result in non-fatal errors
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
------------------------------------------------------------
perf_event_attr:
  type                             8
  size                             120
  config                           0x300c601
  { sample_period, sample_freq }   10000
  sample_type                      IP|TID|TIME|CPU|IDENTIFIER
  read_format                      ID
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 11131  cpu 0  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid 11131  cpu 1  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid 11131  cpu 2  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid 11131  cpu 3  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 11131  cpu 4  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 11131  cpu 5  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 11131  cpu 6  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid 11131  cpu 7  group_fd -1  flags 0x8 = 13
------------------------------------------------------------
perf_event_attr:
  type                             3
  size                             120
  config                           0x5
  { sample_period, sample_freq }   10000
  sample_type                      IP|TID|TIME|IDENTIFIER|REGS_INTR
  read_format                      ID
  inherit                          1
  precise_ip                       3
  sample_id_all                    1
  exclude_guest                    1
  aux_output                       1
  sample_regs_intr                 0xff0fff
------------------------------------------------------------
sys_perf_event_open: pid 11131  cpu 0  group_fd 5  flags 0x8
sys_perf_event_open failed, error -95
Error:
branch-loads: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
[root@quaco ~]#




 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 9e64cefe4335b ("perf intel-pt: Process options for PEBS event synthesis")
> ---
>  tools/perf/arch/x86/util/intel-pt.c | 1 +
>  tools/perf/util/evsel.c             | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 839ef52c1ac2..6ce451293634 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -641,6 +641,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  			}
>  			evsel->core.attr.freq = 0;
>  			evsel->core.attr.sample_period = 1;
> +			evsel->no_aux_samples = true;
>  			intel_pt_evsel = evsel;
>  			opts->full_auxtrace = true;
>  		}
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a68ac3632ae6..ef802f6d40c1 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1014,12 +1014,12 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	if (callchain && callchain->enabled && !evsel->no_aux_samples)
>  		evsel__config_callchain(evsel, opts, callchain);
>  
> -	if (opts->sample_intr_regs) {
> +	if (opts->sample_intr_regs && !evsel->no_aux_samples) {
>  		attr->sample_regs_intr = opts->sample_intr_regs;
>  		evsel__set_sample_bit(evsel, REGS_INTR);
>  	}
>  
> -	if (opts->sample_user_regs) {
> +	if (opts->sample_user_regs && !evsel->no_aux_samples) {
>  		attr->sample_regs_user |= opts->sample_user_regs;
>  		evsel__set_sample_bit(evsel, REGS_USER);
>  	}
> -- 
> 2.17.1
> 

-- 

- Arnaldo
