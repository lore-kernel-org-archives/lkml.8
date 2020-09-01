Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01543C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7BE2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eb2Dqd6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIAIif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAIie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059A3C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so297287wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iVsq81HPEYX496NaJd4owSpS0iekNB/zml51XlcrGc8=;
        b=Eb2Dqd6FoZNsc6d4ii7VC8E24Ne6rsogRu0S55o516FePFDP8F/o7HwEv62wknG2fN
         /R+4cJMglE5+LBRapxPUoZWDhj099SwUjx3BiDk1GlbJzPNbv/CQM9rQJVxSnjtGjtqA
         XZRqTCfOKrTMowDYGCdbP2vY0UIEQs7F/sx6CLl9ZJLWIsYt952+h1kgEhobGM/Vnz9Z
         Wv1bpKQOpfYlZIayuhS4noEr1w8WpJX+A+EhzSBQl+QK8I9lvMo9O28VAKpmwP0kOueg
         SfNeEqa79CI8iFwi3QOrl+48aaGaOo+5R4cTh/MIhueRjNyKLJyTnes44i/VnU8aciZG
         K9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iVsq81HPEYX496NaJd4owSpS0iekNB/zml51XlcrGc8=;
        b=TsAMEFHR9uJi2dG/bz6bJqPV7HxUEGuh7jDlSz+QJkusVA1yTBng2LNsAQ7sIZuF+h
         nPhthDWH9fGZTjLOTui3KOJwYU0XfBD7H6iIv3EvXm8XY6ZM+3M9zI3woyF2oWcQubkj
         ql6sHXl+jY+6Az2z1tnQjRyjn7q4XtIXnr2ekoxspz2jvoOdEepLY7eZhGF/KYECVjTu
         nla/jMk+RnyEM7WS4yJIxQMqYu5JnBC40V/m6Ch1vrslbcBQjYIktVbF3zN/mBxtfXzR
         KcGfWQY13fhXrmILUPjTXSBTBoFiqSsvgb1Vd0bJXO3QztDS9Z/S4RQx5xpOeysc6WHT
         V9xw==
X-Gm-Message-State: AOAM531vtog6S3h8jtNET2AIieuuruIaMYmyNFf1X6XaxKrJ5N2PkO4T
        uGaQPrvZAOMVWb6lR9BB/s4mjQ==
X-Google-Smtp-Source: ABdhPJzorDsuuSr3E3GK19eANL2fJspExNgMXxEWE9/9mOOioYi8KjjFJixhokfd38QnKoTvHXmm+Q==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr714237wmg.0.1598949511578;
        Tue, 01 Sep 2020 01:38:31 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:30 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 00/14] perf mem: Support AUX trace and Arm SPE
Date:   Tue,  1 Sep 2020 09:38:01 +0100
Message-Id: <20200901083815.13755-1-leo.yan@linaro.org>
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

Patches 05 and 06 are used to extend Perf memory tool to support AUX
trace, and add a new option 'M' for itrace for generate memory events.

Patches 07 ~ 13 are to support Arm SPE with Perf memory tool.  Firstly it
registers SPE events for memory events, then it extends the SPE packet
to pass addresses info and operation types, and also set 'data_src'
field so can allow the tool to display readable string in the result.

Patch 14 is to update documentation to reflect changes introduced for
support Arm SPE.

This patch set has been tested on ARMv8 Hisilicon D06 platform and
verfied on x86 so avoid to cause regression.  Please note, this patch
set is dependent on the patch set "perf arm-spe: Refactor decoding &
dumping flow" [1].

Below commands can run successfully on D06:

  $ perf mem record -t ldst -- ~/false_sharing.exe 2
  $ perf mem record -t load -- ~/false_sharing.exe 2
  $ perf mem record -t store -- ~/false_sharing.exe 2
  $ perf mem report
  $ perf mem report --itrace=M

  # Samples: 391K of event 'memory'
  # Total weight : 391193
  # Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
  #
  # Overhead       Samples  Local Weight  Memory access             Symbol                                           Shared Object       Data Symbol                                                   Data Object        Snoop         TLB access              Locked
  # ........  ............  ............  ........................  ...............................................  ..................  ............................................................  .................  ............  ......................  ......
  #
      18.56%         72611  0             L1 or L1 miss             [.] read_write_func                              false_sharing.exe   [.] buf1+0x0                                                  false_sharing.exe  N/A           Walker hit              No
      16.16%         63207  0             L1 or L1 hit              [.] read_write_func                              false_sharing.exe   [.] __do_global_dtors_aux_fini_array_entry+0x228              false_sharing.exe  N/A           Walker hit              No
      15.91%         62239  0             L1 or L1 hit              [.] read_write_func                              false_sharing.exe   [.] __do_global_dtors_aux_fini_array_entry+0x250              false_sharing.exe  N/A           Walker hit              No
       4.67%         18280  0             N/A                       [.] read_write_func                              false_sharing.exe   [.] buf2+0x8                                                  false_sharing.exe  N/A           Walker hit              No
       3.34%         13082  0             L1 or L1 hit              [.] read_write_func                              false_sharing.exe   [.] __do_global_dtors_aux_fini_array_entry+0x230              false_sharing.exe  N/A           Walker hit              No
       2.49%          9755  0             L1 or L1 hit              [.] read_write_func                              false_sharing.exe   [.] 0x0000aaaac23a3450                                        false_sharing.exe  N/A           Walker hit              No
       2.46%          9611  0             L1 or L1 hit              [.] read_write_func                              false_sharing.exe   [.] lock_thd_name+0x0                                         false_sharing.exe  N/A           Walker hit              No
       2.26%          8856  0             L1 or L1 hit              [.] read_write_func                              false_sharing.exe   [.] 0x0000aaaac23a3458                                        false_sharing.exe  N/A           Walker hit              No
       2.19%          8549  0             L1 or L1 miss             [.] read_write_func                              false_sharing.exe   [.] buf2+0x28                                                 false_sharing.exe  N/A           Walker hit              No

Changes from v1:
* Refined patch 02 to use perf_mem_events__ptr() to return event pointer
  and check if pointer is NULL, and remove the condition checking for
  PERF_MEM_EVENTS__MAX; (James Clark)
* Added new itrace option 'M' for memory events;
* Added patch 14 to update documentation.

[1] https://lore.kernel.org/patchwork/cover/1288406/


Leo Yan (14):
  perf mem: Search event name with more flexible path
  perf mem: Introduce weak function perf_mem_events__ptr()
  perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
  perf mem: Only initialize memory event for recording
  perf auxtrace: Add option '-M' for memory events
  perf mem: Support AUX trace
  perf mem: Support Arm SPE events
  perf arm-spe: Enable attribution PERF_SAMPLE_DATA_SRC
  perf arm-spe: Save memory addresses in packet
  perf arm-spe: Store operation types in packet
  perf arm-spe: Fill address info for samples
  perf arm-spe: Synthesize memory event
  perf arm-spe: Set sample's data source field
  perf mem: Document options introduced by Arm SPE

 tools/perf/Documentation/itrace.txt           |   1 +
 tools/perf/Documentation/perf-mem.txt         |  10 +-
 tools/perf/arch/arm64/util/Build              |   2 +-
 tools/perf/arch/arm64/util/mem-events.c       |  46 ++++++
 tools/perf/builtin-c2c.c                      |  23 ++-
 tools/perf/builtin-mem.c                      |  73 ++++++++--
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  15 ++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |   8 ++
 tools/perf/util/arm-spe.c                     | 132 +++++++++++++++---
 tools/perf/util/auxtrace.c                    |   4 +
 tools/perf/util/auxtrace.h                    |   2 +
 tools/perf/util/mem-events.c                  |  41 ++++--
 tools/perf/util/mem-events.h                  |   3 +-
 13 files changed, 302 insertions(+), 58 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.c

-- 
2.20.1

