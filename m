Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F49C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D270A23BCD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d03zDIJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgDFPLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:11:23 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:40602 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgDFPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:11:23 -0400
Received: by mail-qt1-f169.google.com with SMTP id y25so13087216qtv.7;
        Mon, 06 Apr 2020 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=99djusiLVzCO2PuJgf7fSS2owapfZJNAdNjwh2DypLI=;
        b=d03zDIJQRG1Y7JjZSX8Qh73uTuwxDH7V53ruH0Y4h4VSarne/EQPE53gkBuMneOWeJ
         fpDT38mLHN8gBVzH9iHIFeRagolXnbHOiIZctbiHuSxw1aQ9MXBnLCzBH7JYczbpvQkk
         kJMUigd7dhD4zwQ0Bl9eA1OBrwET/E8Gnd9AZ7lo7y419Jfniu4wVVcbA/Q9nQMFd4v6
         anaQLsuNQbhxF+NxZh1vDiVe1b+wybML8paZ3oUPKcsXxajW8vfZ61drdjxyC5ksV35J
         N2lfTabGre8BZRZ48UoQ2d4XLLzNcwbWDL+6cGuI/EkSv5k5PyoSHTMq+Z3t9/Pv3HeX
         cD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=99djusiLVzCO2PuJgf7fSS2owapfZJNAdNjwh2DypLI=;
        b=LvPJMdjr5BQ5yvKYryly8X3PFeFr7zML0Ak7mWNRq79dWeSeb7wXUZIiafQMalYRYd
         XXxQ2LPU8O/+r/pnaA87lUzpuZFH+n2DerUzFAXWKMdjnZe5xUP5n9DwD5nX68mIuARk
         s+7Up746VuHfiUZ/qrfZJPRvswPnU6VjQ/Wk5roNGKYDXuf/H1IE0GHk5qph3KBOAVNt
         2/zUqHydH5Is9ctfbHS0cat2KcXvNy+U4KzUr0o7K8fEqxPBty6rNVHt1lA2beVtnGpS
         kS3FcdToTytpMIMW+47O8/zLVKbI6oF0G+xvXN+X1B5XfyZx1nEmTwvUSWBRntaAuMk/
         FCBw==
X-Gm-Message-State: AGi0PuZCmL4y6S8prXB4Lzj29McQI94IM/WiEz/Lq2Zhe6MUc/vC2YJx
        GKF9QKGkuiXt2zlKs7DUAuI=
X-Google-Smtp-Source: APiQypKb8f3Uck3LmrJlm1lO36LFaO1OSwIU4B8qW3rEPLY0MY6AVEU2W4imzr3BAitfKwcL8rLK7A==
X-Received: by 2002:ac8:3f78:: with SMTP id w53mr21409901qtk.26.1586185882030;
        Mon, 06 Apr 2020 08:11:22 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id f7sm1279570qkh.25.2020.04.06.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:11:21 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5AFD7409A3; Mon,  6 Apr 2020 12:11:18 -0300 (-03)
Date:   Mon, 6 Apr 2020 12:11:18 -0300
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Martin Spier <mspier@netflix.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: add flamegraph.py script
Message-ID: <20200406151118.GC32649@kernel.org>
References: <20200320151355.66302-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320151355.66302-1-agerstmayr@redhat.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 20, 2020 at 04:13:48PM +0100, Andreas Gerstmayr escreveu:
> This script works in tandem with d3-flame-graph to generate flame graphs
> from perf. It supports two output formats: JSON and HTML (the default).
> The HTML format will look for a standalone d3-flame-graph template file in
> /usr/share/d3-flame-graph/d3-flamegraph-base.html and fill in the collected
> stacks.
> 
> Usage:
> 
>     perf record -a -g -F 99 sleep 60
>     perf script report flamegraph
> 
> Combined:
> 
>     perf script flamegraph -a -F 99 sleep 60
> 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>

Trying it now with:

[root@five ~]# perf record -a -g -F 99 sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.120 MB perf.data (59 samples) ]
[root@five ~]#  perf script report flamegraph
  File "/home/acme/libexec/perf-core/scripts/python/flamegraph.py", line 46
    print(f"Flame Graph template {self.args.template} does not " +
                                                               ^
SyntaxError: invalid syntax
Error running python script /home/acme/libexec/perf-core/scripts/python/flamegraph.py
[root@five ~]#



Ok, gets better when I build with 'make -C tools/perf PYTHON=python3'

[root@five ~]#  perf script report flamegraph
Flame Graph template /usr/share/d3-flame-graph/d3-flamegraph-base.html does not exist. Please install the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) package, specify an existing flame graph template (--template PATH) or another output format (--format FORMAT).
[root@five ~]#

It works then, so I'll add a note to that effect. But please consider
fixing it so that it works with both python2 and python3, if possible,
or to fail gracefully and state that only python3 is supported and that
perf should be built with "PYTHON=python3" on the make command line.

Some RFEs for you to consider:

1. make:

   perf flamegraph -a -F 99 sleep 1

be equivalent, should be easy.

2. make the command somehow create a new tab on an existing browser with
the generated file, and switch the focus to that tab.

3. get whats in:

[root@five ~]# perf report --header-only
# ========
# captured on    : Mon Apr  6 12:02:52 2020
# header version : 1
# data offset    : 336
# data size      : 1173584
# feat offset    : 1173920
# hostname : five
# os release : 5.5.10-200.fc31.x86_64
# perf version : 5.6.gb6b7dc6ec0c8
# arch : x86_64
# nrcpus online : 12
# nrcpus avail : 12
# cpudesc : AMD Ryzen 5 3600X 6-Core Processor
# cpuid : AuthenticAMD,23,113,0
# total memory : 32890748 kB
# cmdline : /home/acme/bin/perf record -a -g -F 99 sleep 1
# event : name = cycles, , id = { 2918625, 2918626, 2918627, 2918628, 2918629, 2918630, 2918631, 2918632, 2918633, 2918634, 2918635, 2918636 }, size = 120, { sample_period, sample_freq } = 99, sample_type = IP|TID|TIME|CALLCHAIN|CPU|PERIOD, read_format = ID, disabled = 1,>
# CPU_TOPOLOGY info available, use -I to display
# NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: amd_df = 8, software = 1, ibs_op = 11, ibs_fetch = 10, uprobe = 7, cpu = 4, amd_iommu_0 = 12, breakpoint = 5, amd_l3 = 9, tracepoint = 2, kprobe = 6, msr = 13
# CACHE info available, use -I to display
# time of first sample : 87600.831767
# time of last sample : 87601.096829
# sample duration :    265.062 ms
# MEM_TOPOLOGY info available, use -I to display
# bpf_prog_info 40: bpf_prog_6deef7357e7b4530 addr 0xffffffffc030650c size 66
# bpf_prog_info 41: bpf_prog_6deef7357e7b4530 addr 0xffffffffc03080e8 size 66
# bpf_prog_info 42: bpf_prog_6deef7357e7b4530 addr 0xffffffffc030a218 size 66
# bpf_prog_info 43: bpf_prog_6deef7357e7b4530 addr 0xffffffffc036c698 size 66
# bpf_prog_info 44: bpf_prog_5a2b06eab81b8f51 addr 0xffffffffc036e2c0 size 1132
# bpf_prog_info 45: bpf_prog_6deef7357e7b4530 addr 0xffffffffc06e7118 size 66
# bpf_prog_info 46: bpf_prog_6deef7357e7b4530 addr 0xffffffffc06e9cd8 size 66
# bpf_prog_info 47: bpf_prog_f3b9e166f6c1aaaa addr 0xffffffffc089732c size 1786
# bpf_prog_info 48: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0dcb64c size 66
# bpf_prog_info 49: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0dcd0fc size 66
# bpf_prog_info 50: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0f4d8dc size 66
# bpf_prog_info 51: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0f4fc7c size 66
# bpf_prog_info 52: bpf_prog_84efc2eecc454ca6 addr 0xffffffffc0f6e584 size 373
# missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED
# ========
#
[root@five ~]#

And make it available in some UI element.

Thanks,

- Arnaldo

