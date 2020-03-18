Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC870C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E60E2071C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2QUz9ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCRUEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:04:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44419 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCRUEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:04:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id j4so24469187qkc.11;
        Wed, 18 Mar 2020 13:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=38dh2PPgRMJiQBHEOQZk8qLC6LiToJV7VKtFihH5uCo=;
        b=S2QUz9yegmtGVcrI7PALOueg3LtX9+Y2nePW+iw5nOd27fLOvhFveOVNqqoCGKlU/W
         uYXQyyaPeu+z+OKPX8EArPMONYuIn/S9PXwL9ifgyZ7SWBci3Z+iQ0vjQ6IS4ClRWEDU
         EMInQlnpoo7pRo8tPD27X/CCgGf4xT2RdFjbJyRf4jMdwP712PDy0Xg7zBgwxpLkT/Sy
         jUZvwTRL63AdlRVkx094XlBR5ATs9z7oYWkCu/xx2vodDdp9rzrBGhJ4y0a5d4RwmDRo
         EVIetQwg86Me4BW0MZajBDpBSNXBxVW0fuVcH99t3XrFmM0JifVvUq8el7SIn+Vo4hIN
         OVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=38dh2PPgRMJiQBHEOQZk8qLC6LiToJV7VKtFihH5uCo=;
        b=nd4pjWkB92JEXtr3yv+fWRkFvAXK3VQ5FNsiNpSTtQ8v9pZApgQAPun7Y8i+Fhh9HZ
         P0ZWWCjKdzuC0nmwq4jGYp5+KvKPcC+nD6UaiSJalv6b78a0EHlNuQWfQVptQF/zci9g
         t5Fkaqg1NNNCKLYhvzOKYXoxul9Osyl8uSUmXrTHV/gbDAOlOLRGd0pKEySNbJeB6vEv
         9GbOiRPSGyQ77mKbTTMHpMzIqfL92uSyV23CBXoA8KokR+Q2yBnkRVC7yvWDShRDhe/n
         EvJrvnojyJ85rCS1W923ReEtfy4FYngeat8Vcilc8Ylo/CcshFRQWterjj4uF+ewmRCE
         MnXA==
X-Gm-Message-State: ANhLgQ2sD6oZNnv8yE0HiN4ZYAAmQzBDkyRygsPqxl2LV5kFbiEod0Mj
        iQxUHC6ovBzBYnAyQC+x8Ws=
X-Google-Smtp-Source: ADFU+vvSSx/aLP75QAsnIJH0zFusURLXxn/xtb6hp26t1ylsdl0h08PyN4efd2W5Ph3BJ9qMq9MWSQ==
X-Received: by 2002:a37:8346:: with SMTP id f67mr5748951qkd.61.1584561886685;
        Wed, 18 Mar 2020 13:04:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t43sm3463626qtc.14.2020.03.18.13.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 13:04:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63BF3404E4; Wed, 18 Mar 2020 17:04:43 -0300 (-03)
Date:   Wed, 18 Mar 2020 17:04:43 -0300
To:     Vijay Thakkar <vijaythakkar@me.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 0/3] perf vendor events amd: latest PMU events for
 zen1/zen2
Message-ID: <20200318200443.GA29668@kernel.org>
References: <20200318190002.307290-1-vijaythakkar@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318190002.307290-1-vijaythakkar@me.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 02:59:59PM -0400, Vijay Thakkar escreveu:
> This series of patches brings the PMU events for AMD family 17h series
> of processors up to date with the latest versions of the AMD processor
> programming reference manuals.
> 
> The first patch changes the pmu events mapfile to be more selective for
> the model number rather than blanket detecting all f17h processors to
> have the same events directory. This is required for the later patch
> where we add events for zen2 based processors.
> 
> The second patch adds the PMU events for zen2.

Thanks, re-tested and applied.

- Arnaldo
 
> Finally the third patch updates the zen1 PMU events to be in accordance
> with the latest PPR version and bumps up the events version to v2.
> 
> Vijay Thakkar (3):
>   perf vendor events amd: restrict model detection for zen1 based
>     processors
>   perf vendor events amd: add Zen2 events
>   perf vendor events amd: update Zen1 events to V2
> 
>  .../pmu-events/arch/x86/amdfam17h/branch.json |  12 -
>  .../pmu-events/arch/x86/amdfam17h/cache.json  | 329 -----------------
>  .../pmu-events/arch/x86/amdfam17h/other.json  |  65 ----
>  .../pmu-events/arch/x86/amdzen1/branch.json   |  23 ++
>  .../pmu-events/arch/x86/amdzen1/cache.json    | 294 +++++++++++++++
>  .../arch/x86/{amdfam17h => amdzen1}/core.json |  15 +-
>  .../floating-point.json                       |  64 +++-
>  .../x86/{amdfam17h => amdzen1}/memory.json    |  82 +++--
>  .../pmu-events/arch/x86/amdzen1/other.json    |  56 +++
>  .../pmu-events/arch/x86/amdzen2/branch.json   |  52 +++
>  .../pmu-events/arch/x86/amdzen2/cache.json    | 338 +++++++++++++++++
>  .../pmu-events/arch/x86/amdzen2/core.json     | 130 +++++++
>  .../arch/x86/amdzen2/floating-point.json      | 140 +++++++
>  .../pmu-events/arch/x86/amdzen2/memory.json   | 341 ++++++++++++++++++
>  .../pmu-events/arch/x86/amdzen2/other.json    | 115 ++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
>  16 files changed, 1606 insertions(+), 453 deletions(-)
>  delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
>  delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
>  delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/cache.json
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (87%)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (61%)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (63%)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json
> 
> -- 
> 2.25.2
> 

-- 

- Arnaldo
