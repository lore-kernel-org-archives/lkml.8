Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462AAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1697020771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1+R8FOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgDIRPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:15:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54856 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727028AbgDIRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586452498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QU9j6OtV4Rvivy3f+bc1EjZ9iGXWHUHF7AojBPpVKSU=;
        b=K1+R8FOa1ZZLa6L8zL1otwxQij+ygydWYOL0Md/TRZdntVnS8DcK/q1Jlk6K2z52GZSILi
        ZZJlm9avQGF1/xjZoJysKK5z8mD5gxJuo6F99xelN2ufE+ymBWf5zwKGELNSg371pqwh/9
        CbUZTwnekpYnEp0Gia8QOhCMJDDPuTs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-ECvEr0NoPE6KVUfDXYtiFA-1; Thu, 09 Apr 2020 13:14:50 -0400
X-MC-Unique: ECvEr0NoPE6KVUfDXYtiFA-1
Received: by mail-wr1-f72.google.com with SMTP id c8so6868314wru.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QU9j6OtV4Rvivy3f+bc1EjZ9iGXWHUHF7AojBPpVKSU=;
        b=slD7W+SBPagyu/eGCj60ESjhMZXXsh/tjoGlMW4+AeMivpH+VB7RvIZW4B9hgLsimn
         CetsclKA6mdscbLKJwSDDLzlgjy0ml1KUZs5TBId6aSuqvnEN4o9IrRFNbuVyHtyxX+A
         qTQBXSFgIEvHoQZ5mVMkdob/BQprB+sgEjz9+OqPMn1zI/+fzvAMr7YReD85h4aQoSOU
         K0Tw/By+kPdsPekMMS4pmRrJXUOQ75VZIwrELOxzS7yifPlPovFIKD9v4XgAIj0qGF8V
         Ng88Pk47mgiz9j2kRy1fq+QdFn86ND+08x7krNuH9OP+QrWicGB7Oic79xcWz857LIS+
         tp9g==
X-Gm-Message-State: AGi0PubAo9kIOwGCWtsuEqOMoVi5PURODrc6lzt+tzquwRAa7cQX4P2F
        a1ueK80T2sa+XObKHL2LqsFuSF3sw54+LrKPBhdYSgzwECtGbwmdpQS1q1eRqt2Rw1KhIWWgvNX
        0zS+Ry3MGDA9B3wmnI0A+dRhw
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr198566wrv.226.1586452488479;
        Thu, 09 Apr 2020 10:14:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfLiDmMUYlQIcKimc7E1to2caIcOhtwixRHLT7MxY+sb+Qyr/C/6k5SQUL3pfc1/Qmqs3Gvg==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr198548wrv.226.1586452488286;
        Thu, 09 Apr 2020 10:14:48 -0700 (PDT)
Received: from ?IPv6:2a02:8388:7c1:1280:a281:9dab:554b:2fdc? (2a02-8388-07c1-1280-a281-9dab-554b-2fdc.cable.dynamic.v6.surfer.at. [2a02:8388:7c1:1280:a281:9dab:554b:2fdc])
        by smtp.gmail.com with ESMTPSA id s13sm24842706wrw.20.2020.04.09.10.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 10:14:47 -0700 (PDT)
Subject: Re: [PATCH] perf script: add flamegraph.py script
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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
References: <20200320151355.66302-1-agerstmayr@redhat.com>
 <20200406151118.GC32649@kernel.org>
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
Message-ID: <2b09f863-beaf-7a00-6754-4334d21fc029@redhat.com>
Date:   Thu, 9 Apr 2020 19:14:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406151118.GC32649@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

thanks for merging!

On 06.04.20 17:11, Arnaldo Carvalho de Melo wrote:
> It works then, so I'll add a note to that effect. But please consider
> fixing it so that it works with both python2 and python3, if possible,
> or to fail gracefully and state that only python3 is supported and that
> perf should be built with "PYTHON=python3" on the make command line.

Ok, I just sent a patch (based on your perf/core branch) to add Python 2 
support. I hope soon Python 2 support won't be required anymore ;)

> Some RFEs for you to consider:
> 
> 1. make:
> 
>     perf flamegraph -a -F 99 sleep 1
 >
 > be equivalent, should be easy.

`perf flamegraph -a -F 99 sleep 1` should be equivalent to `perf script 
flamegraph -a -F 99 sleep 1`?
Or in other words, flamegraph should be a top-level command of perf, and 
run the flamegraph.py script?

> 2. make the command somehow create a new tab on an existing browser with
> the generated file, and switch the focus to that tab.

As a personal preference I don't like programs interfering with my 
browser session. For example I have a flame graph open in a tab, then I 
generate another one (overwriting the current file), I would not want 
another tab to open with the new flame graph, but instead I want to 
manually refresh the currently open tab.

> 3. get whats in:
> 
> [root@five ~]# perf report --header-only
> # ========
> # captured on    : Mon Apr  6 12:02:52 2020
> # header version : 1
> # data offset    : 336
> # data size      : 1173584
> # feat offset    : 1173920
> # hostname : five
> # os release : 5.5.10-200.fc31.x86_64
> # perf version : 5.6.gb6b7dc6ec0c8
> # arch : x86_64
> # nrcpus online : 12
> # nrcpus avail : 12
> # cpudesc : AMD Ryzen 5 3600X 6-Core Processor
> # cpuid : AuthenticAMD,23,113,0
> # total memory : 32890748 kB
> # cmdline : /home/acme/bin/perf record -a -g -F 99 sleep 1
> # event : name = cycles, , id = { 2918625, 2918626, 2918627, 2918628, 2918629, 2918630, 2918631, 2918632, 2918633, 2918634, 2918635, 2918636 }, size = 120, { sample_period, sample_freq } = 99, sample_type = IP|TID|TIME|CALLCHAIN|CPU|PERIOD, read_format = ID, disabled = 1,>
> # CPU_TOPOLOGY info available, use -I to display
> # NUMA_TOPOLOGY info available, use -I to display
> # pmu mappings: amd_df = 8, software = 1, ibs_op = 11, ibs_fetch = 10, uprobe = 7, cpu = 4, amd_iommu_0 = 12, breakpoint = 5, amd_l3 = 9, tracepoint = 2, kprobe = 6, msr = 13
> # CACHE info available, use -I to display
> # time of first sample : 87600.831767
> # time of last sample : 87601.096829
> # sample duration :    265.062 ms
> # MEM_TOPOLOGY info available, use -I to display
> # bpf_prog_info 40: bpf_prog_6deef7357e7b4530 addr 0xffffffffc030650c size 66
> # bpf_prog_info 41: bpf_prog_6deef7357e7b4530 addr 0xffffffffc03080e8 size 66
> # bpf_prog_info 42: bpf_prog_6deef7357e7b4530 addr 0xffffffffc030a218 size 66
> # bpf_prog_info 43: bpf_prog_6deef7357e7b4530 addr 0xffffffffc036c698 size 66
> # bpf_prog_info 44: bpf_prog_5a2b06eab81b8f51 addr 0xffffffffc036e2c0 size 1132
> # bpf_prog_info 45: bpf_prog_6deef7357e7b4530 addr 0xffffffffc06e7118 size 66
> # bpf_prog_info 46: bpf_prog_6deef7357e7b4530 addr 0xffffffffc06e9cd8 size 66
> # bpf_prog_info 47: bpf_prog_f3b9e166f6c1aaaa addr 0xffffffffc089732c size 1786
> # bpf_prog_info 48: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0dcb64c size 66
> # bpf_prog_info 49: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0dcd0fc size 66
> # bpf_prog_info 50: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0f4d8dc size 66
> # bpf_prog_info 51: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0f4fc7c size 66
> # bpf_prog_info 52: bpf_prog_84efc2eecc454ca6 addr 0xffffffffc0f6e584 size 373
> # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED
> # ========
> #
> [root@five ~]#
> 
> And make it available in some UI element.

Good idea!
I'll implement this with the next set of flame graph template changes.


Thanks,
Andreas

