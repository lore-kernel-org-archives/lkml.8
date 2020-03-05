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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A58FC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D9E2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnFT5lrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCEXRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:17:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46842 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEXRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:17:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id u124so547737qkh.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 15:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yYWha+UeSKbpQpeQ0w+auAiqhCf8opaJNF/2GoPV9j0=;
        b=tnFT5lrhMOMkx/x8wwxX9gd9wWvqe3jScv53pGm4bLEsYxWNDGBMPfjD+3FZSvA2ow
         lRdgPyIDeQv6cOw+0gs7FuOc5rGpS8KSvlT0VDbYJsatqnz7Q7UtCVWj5D7Mi/pQwZV6
         byWO/GthWdnPMDoqbHwTzuk5Gxobv/d18kQVCb6ZQc6cNade2e/EAsVhZqOFPJNFhlhL
         iucNo1AsB8Bz7qIniDsVu4eGDH6CwdXNDq5CV9Nh49MY9aBe/k+fCsOIfdW8I+rzQXZJ
         6/W5tzoKYWuqjYyrdoBjZXswBfXlguXkywA870ng7ZEk9qbbAs9Xp327Pqfg6l1Pm9Dr
         ikjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yYWha+UeSKbpQpeQ0w+auAiqhCf8opaJNF/2GoPV9j0=;
        b=JqjYFBAro1jJpI1HJ7Ar/HG1Rgdy+isxFUXGtPei+saNeXCKW6AL7gWBXx16r4GI+S
         cKvKwRN/s7npQribomxG6IEvKTA6U/pnbo1GAFZkBzWCXZosT8IZ4HidKQVqGxVFlz6w
         2o8ZiuymwIMZMROg5Oyr2G9Tr9gLtw9/tKBO+DeksILcr4dWeVDuCXSboDUlSBwTQXe7
         jUc6x3Ti0GP/eNc2wLwTihZx7H3uCqj3A69bngSRjYgfIAnQnvf+gPUN9JEvNNB3P5ck
         4oJ+LrZPnPPo3be0JQm6t+DGcr0BNoyjwnJI263B8o4ZXhY+COjtnnytPE8fP2J7+v3O
         yAbQ==
X-Gm-Message-State: ANhLgQ2tSXkaE8ASASV+9exGe/MwOjnjeSaH4W0TjfZ8u4AGs846GIDI
        91r95hj1NV9eDCzRToRGT2Y=
X-Google-Smtp-Source: ADFU+vvC3Go/YY3eqbm1proBOMM6EN7dPLfAQLeUs5C+y7WaFRJzNTJrkJ6BYRaKxsCdapIcMbRgpA==
X-Received: by 2002:ae9:f503:: with SMTP id o3mr400371qkg.402.1583450267544;
        Thu, 05 Mar 2020 15:17:47 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id j85sm1172019qke.20.2020.03.05.15.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 15:17:46 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 861FB403AD; Thu,  5 Mar 2020 20:17:44 -0300 (-03)
Date:   Thu, 5 Mar 2020 20:17:44 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH 02/12] perf tools: Support PERF_SAMPLE_BRANCH_HW_INDEX
Message-ID: <20200305231744.GB17483@kernel.org>
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
 <20200228163011.19358-3-kan.liang@linux.intel.com>
 <20200305202509.GA17483@kernel.org>
 <74b01cee-12dc-2a95-9817-4f89a3fbd441@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74b01cee-12dc-2a95-9817-4f89a3fbd441@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 04:02:10PM -0500, Liang, Kan escreveu:
> 
> 
> On 3/5/2020 3:25 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Feb 28, 2020 at 08:30:01AM -0800, kan.liang@linux.intel.com escreveu:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > A new branch sample type PERF_SAMPLE_BRANCH_HW_INDEX has been introduced
> > > in latest kernel.
> > > 
> > > Enable HW_INDEX by default in LBR call stack mode.
> > > If kernel doesn't support the sample type, switching it off.
> > > 
> > > Add HW_INDEX in attr_fprintf as well. User can check whether the branch
> > > sample type is set via debug information or header.
> > 
> > So while this works with a kernel where PERF_SAMPLE_BRANCH_HW_INDEX is
> > present and we get, from the committer notes I was putting together
> > while testing/applying this cset:
> > 
> > First collect some samples with LBR callchains, system wide, for a few
> > seconds:
> > 
> >    # perf record --call-graph lbr -a sleep 5
> >    [ perf record: Woken up 1 times to write data ]
> >    [ perf record: Captured and wrote 0.625 MB perf.data (224 samples) ]
> >    #
> > 
> > Now lets use 'perf evlist -v' to look at the branch_sample_type:
> > 
> >    # perf evlist -v
> >    cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
> >    #
> > 
> > So the machine has the kernel feature, and it was correctly added to
> > perf_event_attr.branch_sample_type, for the default 'cycles' event.
> > 
> > Cool, and look at that 'attr.precise_ip: 3' part, the kernel is OK with
> > having that together with attr.branch_sample_type with HW_INDEX set.
> > 
> > The problem happens when I go test this in an older kernel, where the
> > kernel doesn't know about HW_INDEX, we get it disabled but then
> > precise_ip is set to zero in its detection , even if at the end we get
> > it to 3, as expected, which got me a bit confused, I'll investigate this
> > a bit more to try and avoid these extra probes for the max precise level
> > that fails in older kernels due to branch_sample_type having HW_INDEX
> > :-\
> 
> It looks like this is an expected behavior for the event with maximum
> precise config for current perf tool.
> 
> The related commits are as below:
> commit ID: 4e8a5c155137 ("perf evsel: Fix max perf_event_attr.precise_ip
> detection")
> commit ID: cd136189370c ("perf evsel: Do not rely on errno values for
> precise_ip fallback")
> 
> Before handling any standard fallback (not just HW_INDEX), perf tool will
> try all the precise_ip value first.

Right, and since it uses HW_INDEX and the kernel doesn't support that,
that precise_ip max value detection will fail, it will go back to
whatever it was and try again later, then the fallback will remove the
HW_INDEX and it will work.

What I said is that if we don't set branch_sample_type when detecting
the max precise_ip, then that detection will work and we will not
needlessly go on testing with precise_ip = 3, 2, 1, 0.

My doubt was more about if HW_INDEX (or any other branch_sample_type)
had to be tested in conjunction with precise_ip, which I think isn't
the case from what I saw in my tests.

- Arnaldo
 
> Thanks,
> Kan
> 
> > 
> > 
> > # perf record -vv --call-graph lbr -a sleep 5
> > <SNIP>
> > ------------------------------------------------------------
> > perf_event_attr:
> >    size                             120
> >    { sample_period, sample_freq }   4000
> >    sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
> >    read_format                      ID
> >    disabled                         1
> >    inherit                          1
> >    mmap                             1
> >    comm                             1
> >    freq                             1
> >    task                             1
> >    precise_ip                       3
> >    sample_id_all                    1
> >    exclude_guest                    1
> >    mmap2                            1
> >    comm_exec                        1
> >    ksymbol                          1
> >    bpf_event                        1
> >    branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
> > ------------------------------------------------------------
> > sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -95
> > decreasing precise_ip by one (2)
> > ------------------------------------------------------------
> > perf_event_attr:
> >    size                             120
> >    { sample_period, sample_freq }   4000
> >    sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
> >    read_format                      ID
> >    disabled                         1
> >    inherit                          1
> >    mmap                             1
> >    comm                             1
> >    freq                             1
> >    task                             1
> >    precise_ip                       2
> >    sample_id_all                    1
> >    exclude_guest                    1
> >    mmap2                            1
> >    comm_exec                        1
> >    ksymbol                          1
> >    bpf_event                        1
> >    branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
> > ------------------------------------------------------------
> > sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -95
> > decreasing precise_ip by one (1)
> > ------------------------------------------------------------
> > perf_event_attr:
> >    size                             120
> >    { sample_period, sample_freq }   4000
> >    sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
> >    read_format                      ID
> >    disabled                         1
> >    inherit                          1
> >    mmap                             1
> >    comm                             1
> >    freq                             1
> >    task                             1
> >    precise_ip                       1
> >    sample_id_all                    1
> >    exclude_guest                    1
> >    mmap2                            1
> >    comm_exec                        1
> >    ksymbol                          1
> >    bpf_event                        1
> >    branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
> > ------------------------------------------------------------
> > sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -95
> > decreasing precise_ip by one (0)
> > ------------------------------------------------------------
> > perf_event_attr:
> >    size                             120
> >    { sample_period, sample_freq }   4000
> >    sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
> >    read_format                      ID
> >    disabled                         1
> >    inherit                          1
> >    mmap                             1
> >    comm                             1
> >    freq                             1
> >    task                             1
> >    sample_id_all                    1
> >    exclude_guest                    1
> >    mmap2                            1
> >    comm_exec                        1
> >    ksymbol                          1
> >    bpf_event                        1
> >    branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
> > ------------------------------------------------------------
> > sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -22
> > switching off branch HW index support
> > ------------------------------------------------------------
> > perf_event_attr:
> >    size                             120
> >    { sample_period, sample_freq }   4000
> >    sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
> >    read_format                      ID
> >    disabled                         1
> >    inherit                          1
> >    mmap                             1
> >    comm                             1
> >    freq                             1
> >    task                             1
> >    precise_ip                       3
> >    sample_id_all                    1
> >    exclude_guest                    1
> >    mmap2                            1
> >    comm_exec                        1
> >    ksymbol                          1
> >    bpf_event                        1
> >    branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES
> > ------------------------------------------------------------
> > 
> > 
> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > > ---
> > >   tools/perf/util/evsel.c                   | 15 ++++++++++++---
> > >   tools/perf/util/evsel.h                   |  1 +
> > >   tools/perf/util/perf_event_attr_fprintf.c |  1 +
> > >   3 files changed, 14 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 05883a45de5b..816d930d774e 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -712,7 +712,8 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
> > >   				attr->branch_sample_type = PERF_SAMPLE_BRANCH_USER |
> > >   							PERF_SAMPLE_BRANCH_CALL_STACK |
> > >   							PERF_SAMPLE_BRANCH_NO_CYCLES |
> > > -							PERF_SAMPLE_BRANCH_NO_FLAGS;
> > > +							PERF_SAMPLE_BRANCH_NO_FLAGS |
> > > +							PERF_SAMPLE_BRANCH_HW_INDEX;
> > >   			}
> > >   		} else
> > >   			 pr_warning("Cannot use LBR callstack with branch stack. "
> > > @@ -763,7 +764,8 @@ perf_evsel__reset_callgraph(struct evsel *evsel,
> > >   	if (param->record_mode == CALLCHAIN_LBR) {
> > >   		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
> > >   		attr->branch_sample_type &= ~(PERF_SAMPLE_BRANCH_USER |
> > > -					      PERF_SAMPLE_BRANCH_CALL_STACK);
> > > +					      PERF_SAMPLE_BRANCH_CALL_STACK |
> > > +					      PERF_SAMPLE_BRANCH_HW_INDEX);
> > >   	}
> > >   	if (param->record_mode == CALLCHAIN_DWARF) {
> > >   		perf_evsel__reset_sample_bit(evsel, REGS_USER);
> > > @@ -1673,6 +1675,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> > >   		evsel->core.attr.ksymbol = 0;
> > >   	if (perf_missing_features.bpf)
> > >   		evsel->core.attr.bpf_event = 0;
> > > +	if (perf_missing_features.branch_hw_idx)
> > > +		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
> > >   retry_sample_id:
> > >   	if (perf_missing_features.sample_id_all)
> > >   		evsel->core.attr.sample_id_all = 0;
> > > @@ -1784,7 +1788,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> > >   	 * Must probe features in the order they were added to the
> > >   	 * perf_event_attr interface.
> > >   	 */
> > > -	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
> > > +	if (!perf_missing_features.branch_hw_idx &&
> > > +	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
> > > +		perf_missing_features.branch_hw_idx = true;
> > > +		pr_debug2("switching off branch HW index support\n");
> > > +		goto fallback_missing_features;
> > > +	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
> > >   		perf_missing_features.aux_output = true;
> > >   		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
> > >   		goto out_close;
> > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > index 99a0cb60c556..33804740e2ca 100644
> > > --- a/tools/perf/util/evsel.h
> > > +++ b/tools/perf/util/evsel.h
> > > @@ -119,6 +119,7 @@ struct perf_missing_features {
> > >   	bool ksymbol;
> > >   	bool bpf;
> > >   	bool aux_output;
> > > +	bool branch_hw_idx;
> > >   };
> > >   extern struct perf_missing_features perf_missing_features;
> > > diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> > > index 651203126c71..355d3458d4e6 100644
> > > --- a/tools/perf/util/perf_event_attr_fprintf.c
> > > +++ b/tools/perf/util/perf_event_attr_fprintf.c
> > > @@ -50,6 +50,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
> > >   		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
> > >   		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
> > >   		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
> > > +		bit_name(HW_INDEX),
> > >   		{ .name = NULL, }
> > >   	};
> > >   #undef bit_name
> > > -- 
> > > 2.17.1
> > > 
> > 

-- 

- Arnaldo
