Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E87BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DA020848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS4Gc3LP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCEUZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:25:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45691 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgCEUZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:25:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id a4so41736qto.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 12:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I9Pwren8cf/RdG0kf6LVbH7KTAG8KIwdtY6cpVVEEHY=;
        b=cS4Gc3LPMcrvk5vNS+FF90/jeAmcrAXMVyEraIWnTrohzS0mMAKKoCDB8Vhj/Xyj53
         CWeY4/fzlFDdIqX6ke1KrCyvkJSRfdp4uRePyoq9J6gaywhA9j7rUiafy61V34J7uoCT
         fAk4/jKjTPB7U6eI7pjwCzImsqNAz2BF8vp3mZvs2rtV7yNFA+I7WlABP2fxoPfZqky0
         O1KaRsl4cUV7JzQOqM2vFSduCUIEp8agy/CRDkLBjVzEMuC20JFIn4wFbIR1HRIIkiZ0
         94GIud/2iZsgexcv5wzhGvisrIRlo8hVO1+pt7tUJtiUVK3H0E2k3DsQB6NFUgH5TVWa
         dheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9Pwren8cf/RdG0kf6LVbH7KTAG8KIwdtY6cpVVEEHY=;
        b=nbBpJzaodFVw0TT/HmvXCx8goADvZ3fKqICRr08HxPrvGJptZfHwRe7twkl8CpL894
         HJo8LGLuK70hB9cwXkIqlnAiq/+NTm18MtadxSNb8QeuOjBa4pX81j+FddVMEzReEfAt
         PMhuoE62EQrRhs/ZVfXve1KKqtTCGMU+fccSYiLNy4/COe8nM7p/LpVHTGUutX1onI6C
         KGt2HSMpG5Ac/snElHmFqHMOgy9fTh0sFyqJn5nJUp57WF+GEu3HM5Zd8ZgIe4TMNlDW
         LlUtKbH4YykrVqETbT/SiKlRNqYdVJ4hLZUH+0DKvbVYd3pVfb2WAz+7qxw1AZ/jsn8C
         VlJQ==
X-Gm-Message-State: ANhLgQ3rp0nf58v0K6bAEKVyvbRxFRvUYgMKfWyP8dSqwFK9awsITJNc
        7rO+csU3TYqUMrhHeMnQsbQ=
X-Google-Smtp-Source: ADFU+vsiSSv8dlujGhQBJI9oyEcYJO35iY7gj6DezmUCDvRKkaIiu+ZrE9uRlhy2NPizs5kpjC3trw==
X-Received: by 2002:ac8:2634:: with SMTP id u49mr495142qtu.162.1583439913375;
        Thu, 05 Mar 2020 12:25:13 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 137sm8127808qkf.40.2020.03.05.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:25:12 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 68458403AD; Thu,  5 Mar 2020 17:25:09 -0300 (-03)
Date:   Thu, 5 Mar 2020 17:25:09 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH 02/12] perf tools: Support PERF_SAMPLE_BRANCH_HW_INDEX
Message-ID: <20200305202509.GA17483@kernel.org>
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
 <20200228163011.19358-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228163011.19358-3-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 28, 2020 at 08:30:01AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A new branch sample type PERF_SAMPLE_BRANCH_HW_INDEX has been introduced
> in latest kernel.
> 
> Enable HW_INDEX by default in LBR call stack mode.
> If kernel doesn't support the sample type, switching it off.
> 
> Add HW_INDEX in attr_fprintf as well. User can check whether the branch
> sample type is set via debug information or header.

So while this works with a kernel where PERF_SAMPLE_BRANCH_HW_INDEX is
present and we get, from the committer notes I was putting together
while testing/applying this cset:

First collect some samples with LBR callchains, system wide, for a few
seconds:

  # perf record --call-graph lbr -a sleep 5
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.625 MB perf.data (224 samples) ]
  #

Now lets use 'perf evlist -v' to look at the branch_sample_type:

  # perf evlist -v
  cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
  #

So the machine has the kernel feature, and it was correctly added to
perf_event_attr.branch_sample_type, for the default 'cycles' event.

Cool, and look at that 'attr.precise_ip: 3' part, the kernel is OK with
having that together with attr.branch_sample_type with HW_INDEX set.

The problem happens when I go test this in an older kernel, where the
kernel doesn't know about HW_INDEX, we get it disabled but then
precise_ip is set to zero in its detection , even if at the end we get
it to 3, as expected, which got me a bit confused, I'll investigate this
a bit more to try and avoid these extra probes for the max precise level
that fails in older kernels due to branch_sample_type having HW_INDEX
:-\


# perf record -vv --call-graph lbr -a sleep 5
<SNIP>
------------------------------------------------------------
perf_event_attr:
  size                             120
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  precise_ip                       3
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
  branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -95
decreasing precise_ip by one (2)
------------------------------------------------------------
perf_event_attr:
  size                             120
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  precise_ip                       2
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
  branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -95
decreasing precise_ip by one (1)
------------------------------------------------------------
perf_event_attr:
  size                             120
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  precise_ip                       1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
  branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -95
decreasing precise_ip by one (0)
------------------------------------------------------------
perf_event_attr:
  size                             120
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
  branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -22
switching off branch HW index support
------------------------------------------------------------
perf_event_attr:
  size                             120
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  precise_ip                       3
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
  branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES
------------------------------------------------------------


 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/evsel.c                   | 15 ++++++++++++---
>  tools/perf/util/evsel.h                   |  1 +
>  tools/perf/util/perf_event_attr_fprintf.c |  1 +
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 05883a45de5b..816d930d774e 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -712,7 +712,8 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
>  				attr->branch_sample_type = PERF_SAMPLE_BRANCH_USER |
>  							PERF_SAMPLE_BRANCH_CALL_STACK |
>  							PERF_SAMPLE_BRANCH_NO_CYCLES |
> -							PERF_SAMPLE_BRANCH_NO_FLAGS;
> +							PERF_SAMPLE_BRANCH_NO_FLAGS |
> +							PERF_SAMPLE_BRANCH_HW_INDEX;
>  			}
>  		} else
>  			 pr_warning("Cannot use LBR callstack with branch stack. "
> @@ -763,7 +764,8 @@ perf_evsel__reset_callgraph(struct evsel *evsel,
>  	if (param->record_mode == CALLCHAIN_LBR) {
>  		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
>  		attr->branch_sample_type &= ~(PERF_SAMPLE_BRANCH_USER |
> -					      PERF_SAMPLE_BRANCH_CALL_STACK);
> +					      PERF_SAMPLE_BRANCH_CALL_STACK |
> +					      PERF_SAMPLE_BRANCH_HW_INDEX);
>  	}
>  	if (param->record_mode == CALLCHAIN_DWARF) {
>  		perf_evsel__reset_sample_bit(evsel, REGS_USER);
> @@ -1673,6 +1675,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		evsel->core.attr.ksymbol = 0;
>  	if (perf_missing_features.bpf)
>  		evsel->core.attr.bpf_event = 0;
> +	if (perf_missing_features.branch_hw_idx)
> +		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
>  retry_sample_id:
>  	if (perf_missing_features.sample_id_all)
>  		evsel->core.attr.sample_id_all = 0;
> @@ -1784,7 +1788,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	 * Must probe features in the order they were added to the
>  	 * perf_event_attr interface.
>  	 */
> -	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
> +	if (!perf_missing_features.branch_hw_idx &&
> +	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
> +		perf_missing_features.branch_hw_idx = true;
> +		pr_debug2("switching off branch HW index support\n");
> +		goto fallback_missing_features;
> +	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
>  		perf_missing_features.aux_output = true;
>  		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
>  		goto out_close;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 99a0cb60c556..33804740e2ca 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -119,6 +119,7 @@ struct perf_missing_features {
>  	bool ksymbol;
>  	bool bpf;
>  	bool aux_output;
> +	bool branch_hw_idx;
>  };
>  
>  extern struct perf_missing_features perf_missing_features;
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index 651203126c71..355d3458d4e6 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -50,6 +50,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
>  		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
>  		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
>  		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
> +		bit_name(HW_INDEX),
>  		{ .name = NULL, }
>  	};
>  #undef bit_name
> -- 
> 2.17.1
> 

-- 

- Arnaldo
