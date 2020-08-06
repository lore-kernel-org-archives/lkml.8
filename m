Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4956AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD0E20823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvwazSi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHFClB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFClB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:41:01 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CA5C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:40:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id p8so9804953pgn.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 19:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GKCYwGkIkZzoBWY4eR7yYQLz/eI09m7DZMufw7NU6qE=;
        b=XvwazSi3xag0/7Jy8zFjpwnwFNeQwVrgSYsa0XgZby7/Jugj8LH6KadJnFHRSPkvUJ
         yh2egvUU3Fp+OyGy4o9MCfH8181BI1t6UEfTmu3Fz6rmud+tVXMy80S/AAsox0pDohyU
         8y9qWdKYGQcr8DsbOgBLTqjlOxhAfzfmIqVg0G441QsVBcC4sw7RZq0DMXG2bCt6dW0U
         8kjzAACDhPrr+WBbesDyndeDG6ZG4oU+kHmt6L0YW3p4gSqbkQSOL7cV62Y4+D/Iy9PN
         TZ3i4GFfR33HftYQinA8unIbSgcS6ZOxtq5P2bXVkueerF+AzM1vbGqMqgKaO3HeIBHn
         l2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GKCYwGkIkZzoBWY4eR7yYQLz/eI09m7DZMufw7NU6qE=;
        b=LoAIg8ogDcaZp1UxIE0jDrw1uA6uwdhTR+WKNAqEo3OHq5sx/7fUBtqDj4C4i3N8XE
         wU7D5wnlcdRiMVebcvmb2n4qRSH57PCRG7+GfVI24pBgt2H0k9W8jPKLE9k1SxQRLjkA
         xmU7DBnmZqemsd74+dgArYNdBGd0VbwjZIZXvNT0yqSBdrTo0Dfw1DZ3L9VekysuoVTp
         mv2MJkXkoaSNZ51iO5vHLzH5Hz8fVqDHu61rdaXwAdXV+JEk8ja4RJIgyCno1Q+ycdcS
         gldGxfyv277lItnf1G39grMYO3JDbJtkvG7RxiJU5b9tqoGwtFi3+SPXzY3k3Q/6067f
         +Chw==
X-Gm-Message-State: AOAM531VY4N8dNBDDDkjHhu78h1kSkP1ihtLLbaUmmY8DGvtv3f2jS+P
        cUlWUkgYJXjJc6FXa8xuMrhOjg==
X-Google-Smtp-Source: ABdhPJx4z1qFee8nhaSQVAi72rBIVHYCOwE99vG0u72CWb9aTOjnnJwnrtP6YiH76IvKDDMPZWpw1w==
X-Received: by 2002:a62:7c87:: with SMTP id x129mr6464453pfc.165.1596681657326;
        Wed, 05 Aug 2020 19:40:57 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id s24sm877219pjp.1.2020.08.05.19.40.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 19:40:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 00/11] perf mem: Support AUX trace and Arm SPE
Date:   Thu,  6 Aug 2020 10:40:30 +0800
Message-Id: <20200806024041.27475-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to support AUX trace and Arm SPE as the first enabled
hardware tracing for Perf memory tool.

Patches 01 ~ 04 are preparasion patches which mainly resolve the issue
for memory events, since the existed code is hard coded the memory
events which based on x86 and PowerPC architectures, so patches 01 ~ 04
extend to support more flexible memory event name, and introduce weak
functions so can allow every architecture to define its own memory
events structure and returning event pointer and name respectively.

Patch 05 is used to extend Perf memory tool to support AUX trace.

Patch 06 ~ 11 are to support Arm SPE with Perf memory tool.  Firstly it
registers SPE events for memory events, then it extends the SPE packet
to pass addresses info and operation types, and also set 'data_src'
field so can allow the tool to display readable string in the result.

This patch set has been tested on ARMv8 Hisilicon D06 platform.  I noted
now the 'data object' cannot be displayed properly, this should be
another issue so need to check separately.   Below is testing result:

# Samples: 73  of event 'l1d-miss'
# Total weight : 73
# Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
#
# Overhead       Samples  Local Weight  Memory access             Symbol                              Shared Object      Data Symbol                                                   Data Object         Snoop         TLB access              Locked
# ........  ............  ............  ........................  ..................................  .................  ............................................................  ..................  ............  ......................  ......
#
     2.74%             2  0             L1 or L1 miss             [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027aacb08a8                                        [unknown]           N/A           N/A                     No
     2.74%             2  0             L1 or L1 miss             [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027be6488a8                                        [unknown]           N/A           N/A                     No
     2.74%             2  0             L1 or L1 miss             [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027c432f8a8                                        [unknown]           N/A           N/A                     No
     1.37%             1  0             L1 or L1 miss             [k] __arch_copy_to_user             [kernel.kallsyms]  [k] 0xffff0027a65352a0                                        [unknown]           N/A           N/A                     No
     1.37%             1  0             L1 or L1 miss             [k] __d_lookup_rcu                  [kernel.kallsyms]  [k] 0xffff0027d3cbf468                                        [unknown]           N/A           N/A                     No
     1.37%             1  0             L1 or L1 miss             [k] __d_lookup_rcu                  [kernel.kallsyms]  [k] 0xffff0027d8f44490                                        [unknown]           N/A           N/A                     No
     [...]


# Samples: 101  of event 'l1d-access'
# Total weight : 101
# Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
#
# Overhead       Samples  Local Weight  Memory access             Symbol                              Shared Object      Data Symbol                                                   Data Object             Snoop         TLB access              Locked
# ........  ............  ............  ........................  ..................................  .................  ............................................................  ......................  ............  ......................  ......
#
     2.97%             3  0             L1 or L1 hit              [k] perf_event_mmap                 [kernel.kallsyms]  [k] perf_swevent+0x5c                                         [kernel.kallsyms].data  N/A           N/A                     No
     1.98%             2  0             L1 or L1 hit              [k] kmem_cache_alloc                [kernel.kallsyms]  [k] 0xffff2027af40e3d0                                        [unknown]               N/A           N/A                     No
     1.98%             2  0             L1 or L1 hit              [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027aacb08a8                                        [unknown]               N/A           N/A                     No
     1.98%             2  0             L1 or L1 hit              [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027be6488a8                                        [unknown]               N/A           N/A                     No
     1.98%             2  0             L1 or L1 hit              [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027c432f8a8                                        [unknown]               N/A           N/A                     No
     0.99%             1  0             L1 or L1 hit              [k] __arch_copy_to_user             [kernel.kallsyms]  [k] 0xffff0027a65352a0                                        [unknown]               N/A           N/A                     No
     0.99%             1  0             L1 or L1 hit              [k] __d_lookup_rcu                  [kernel.kallsyms]  [k] 0xffff0027d3cbf468                                        [unknown]               N/A           N/A                     No
     0.99%             1  0             L1 or L1 hit              [k] __d_lookup_rcu                  [kernel.kallsyms]  [k] 0xffff0027d8f44490                                        [unknown]               N/A           N/A                     No
     [...]


# Samples: 46  of event 'llc-miss'
# Total weight : 46
# Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
#
# Overhead       Samples  Local Weight  Memory access             Symbol                              Shared Object      Data Symbol                                                   Data Object         Snoop         TLB access              Locked
# ........  ............  ............  ........................  ..................................  .................  ............................................................  ..................  ............  ......................  ......
#
     2.17%             1  0             L3 or L3 miss             [k] __arch_copy_to_user             [kernel.kallsyms]  [k] 0xffff0027a65352a0                                        [unknown]           N/A           N/A                     No
     2.17%             1  0             L3 or L3 miss             [k] __d_lookup_rcu                  [kernel.kallsyms]  [k] 0xffff0027d3cbf468                                        [unknown]           N/A           N/A                     No
     2.17%             1  0             L3 or L3 miss             [k] __d_lookup_rcu                  [kernel.kallsyms]  [k] 0xffff0027d8f44490                                        [unknown]           N/A           N/A                     No
     2.17%             1  0             L3 or L3 miss             [k] __tty_buffer_request_room       [kernel.kallsyms]  [k] 0xffff2027c424ac08                                        [unknown]           N/A           N/A                     No
     2.17%             1  0             L3 or L3 miss             [.] _dl_addr                        libc-2.28.so       [.] 0x0000ffff9afc94c4                                        libc-2.28.so        N/A           N/A                     No
     2.17%             1  0             L3 or L3 miss             [.] _dl_addr                        libc-2.28.so       [.] 0x0000ffff9afc98b6                                        libc-2.28.so        N/A           N/A                     No
     2.17%             1  0             L3 or L3 miss             [.] _dl_lookup_symbol_x             ld-2.28.so         [.] 0x0000ffff9af38703                                        libdl-2.28.so       N/A           N/A                     No
     [...]


# Samples: 6  of event 'llc-access'
# Total weight : 6
# Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
#
# Overhead       Samples  Local Weight  Memory access             Symbol                   Shared Object      Data Symbol             Data Object       Snoop         TLB access              Locked
# ........  ............  ............  ........................  .......................  .................  ......................  ................  ............  ......................  ......
#
    16.67%             1  0             L3 or L3 hit              [.] _dl_addr             libc-2.28.so       [.] 0x0000ffff9afc98b6  libc-2.28.so      N/A           N/A                     No
    16.67%             1  0             L3 or L3 hit              [.] _dl_lookup_symbol_x  ld-2.28.so         [.] 0x0000ffff9af38703  libdl-2.28.so     N/A           N/A                     No
    16.67%             1  0             L3 or L3 hit              [.] _dl_relocate_object  ld-2.28.so         [.] 0x0000aaaadc9e4dd0  ls                N/A           N/A                     No
    16.67%             1  0             L3 or L3 hit              [.] _dl_relocate_object  ld-2.28.so         [.] 0x0000aaaadc9e5970  ls                N/A           N/A                     No
    16.67%             1  0             L3 or L3 hit              [k] copy_page            [kernel.kallsyms]  [k] 0xffff0027a8528be0  [unknown]         N/A           N/A                     No
    16.67%             1  0             L3 or L3 hit              [k] copy_page            [kernel.kallsyms]  [k] 0xffff2027c66a65e0  [unknown]         N/A           N/A                     No


# Samples: 32  of event 'tlb-miss'
# Total weight : 32
# Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
#
# Overhead       Samples  Local Weight  Memory access             Symbol                              Shared Object      Data Symbol             Data Object         Snoop         TLB access              Locked
# ........  ............  ............  ........................  ..................................  .................  ......................  ..................  ............  ......................  ......
#
     6.25%             2  0             N/A                       [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027be6488a8  [unknown]           N/A           Walker miss             No
     6.25%             2  0             N/A                       [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027c432f8a8  [unknown]           N/A           Walker miss             No
     3.12%             1  0             N/A                       [k] __arch_clear_user               [kernel.kallsyms]  [k] 0x0000aaaadca14658  [unknown]           N/A           Walker miss             No
     3.12%             1  0             N/A                       [.] _dl_map_object_deps             ld-2.28.so         [.] 0x0000ffffdd807c50  [stack]             N/A           Walker miss             No
     3.12%             1  0             N/A                       [.] _dl_map_object_from_fd          ld-2.28.so         [.] 0x0000ffff9af32d50  libpthread-2.28.so  N/A           Walker miss             No
     [...]


# Samples: 114  of event 'tlb-access'
# Total weight : 114
# Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
#
# Overhead       Samples  Local Weight  Memory access             Symbol                              Shared Object      Data Symbol                                                   Data Object             Snoop         TLB access              Locked
# ........  ............  ............  ........................  ..................................  .................  ............................................................  ......................  ............  ......................  ......
#
     2.63%             3  0             N/A                       [k] perf_event_mmap                 [kernel.kallsyms]  [k] perf_swevent+0x5c                                         [kernel.kallsyms].data  N/A           Walker hit              No
     1.75%             2  0             N/A                       [k] kmem_cache_alloc                [kernel.kallsyms]  [k] 0xffff2027af40e3d0                                        [unknown]               N/A           Walker hit              No
     1.75%             2  0             N/A                       [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027aacb08a8                                        [unknown]               N/A           Walker hit              No
     1.75%             2  0             N/A                       [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027be6488a8                                        [unknown]               N/A           Walker hit              No
     1.75%             2  0             N/A                       [k] perf_iterate_ctx.constprop.151  [kernel.kallsyms]  [k] 0xffff2027c432f8a8                                        [unknown]               N/A           Walker hit              No
     0.88%             1  0             N/A                       [k] __arch_clear_user               [kernel.kallsyms]  [k] 0x0000aaaadca14658                                        [unknown]               N/A           Walker hit              No
     0.88%             1  0             N/A                       [k] __arch_clear_user               [kernel.kallsyms]  [k] 0x0000ffff9b1963f8                                        [unknown]               N/A           Walker hit              No
     [...]


# Samples: 21  of event 'remote-access'
# Total weight : 21
# Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
#
# Overhead       Samples  Local Weight  Memory access             Symbol                      Shared Object      Data Symbol                                                   Data Object         Snoop         TLB access              Locked
# ........  ............  ............  ........................  ..........................  .................  ............................................................  ..................  ............  ......................  ......
#
     4.76%             1  0             Remote Cache (1 hop) or Any cache hit  [k] __arch_copy_to_user     [kernel.kallsyms]  [k] 0xffff0027a65352a0                                        [unknown]           N/A           N/A                     No
     4.76%             1  0             Remote Cache (1 hop) or Any cache hit  [k] __d_lookup_rcu          [kernel.kallsyms]  [k] 0xffff0027d3cbf468                                        [unknown]           N/A           N/A                     No
     4.76%             1  0             Remote Cache (1 hop) or Any cache hit  [k] __d_lookup_rcu          [kernel.kallsyms]  [k] 0xffff0027d8f44490                                        [unknown]           N/A           N/A                     No
     4.76%             1  0             Remote Cache (1 hop) or Any cache hit  [.] _dl_addr                libc-2.28.so       [.] 0x0000ffff9afc94c4                                        libc-2.28.so        N/A           N/A                     No
     [...]


Leo Yan (11):
  perf mem: Search event name with more flexible path
  perf mem: Introduce weak function perf_mem_events__ptr()
  perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
  perf mem: Only initialize memory event for recording
  perf mem: Support AUX trace
  perf mem: Support Arm SPE events
  perf arm-spe: Enable attribution PERF_SAMPLE_DATA_SRC
  perf arm-spe: Save memory addresses in packet
  perf arm-spe: Store operation types in packet
  perf arm-spe: Fill address info for memory samples
  perf arm-spe: Set sample's data source field

 tools/perf/arch/arm64/util/Build              |   2 +-
 tools/perf/arch/arm64/util/mem-events.c       |  46 +++++++
 tools/perf/builtin-c2c.c                      |  18 ++-
 tools/perf/builtin-mem.c                      |  71 ++++++++--
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  15 +++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |   8 ++
 tools/perf/util/arm-spe.c                     | 125 +++++++++++++++---
 tools/perf/util/mem-events.c                  |  32 +++--
 tools/perf/util/mem-events.h                  |   3 +-
 9 files changed, 266 insertions(+), 54 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.c

-- 
2.17.1

