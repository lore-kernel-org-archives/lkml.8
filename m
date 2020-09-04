Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E43AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0332C20829
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599247725;
	bh=WWIH31gFtV6DxfxGrGDm5zdU7KSONeVL3oCpw9Pyrbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B8ZyrwisxeUvf3GkenJud0T3ERtC7AvjHLDTI+zXWJdGpWZaLPtGIi6eUOQYlnhlQ
	 HfT/8yZahNNfoQfWR/kz/7hnh3tnpJxrldEkYeCuFvddIWks9owCEGjVuc1dO0nIBU
	 TKgCTxUCNLVi+WWjXK89hieeKbmo858j1O8eYLAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgIDT2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgIDT2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:28:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668A0207EA;
        Fri,  4 Sep 2020 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599247721;
        bh=WWIH31gFtV6DxfxGrGDm5zdU7KSONeVL3oCpw9Pyrbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIjYqav+U61DGupxoppVxMK7+ys1CzHpnYcsjRoSFJoS2NXoI5Dp47LOawFHOgcUC
         k6MoaycIXvw1gehCaVDldZjL/wZHAanP6rRRfaYsgIzBdYEKRVd2BtE7hnEBCTAkGl
         f/9tntak1oBKbaQcXX19sPOUXpIFVyGPa+afNLUU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7CDAB40D3D; Fri,  4 Sep 2020 16:28:39 -0300 (-03)
Date:   Fri, 4 Sep 2020 16:28:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>,
        Martin Jambor <mjambor@suse.cz>,
        Michael Petlan <mpetlan@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] perf vendor events amd: Add recommended events
Message-ID: <20200904192839.GG3753976@kernel.org>
References: <20200901220944.277505-1-kim.phillips@amd.com>
 <20200901220944.277505-3-kim.phillips@amd.com>
 <CAP-5=fVwuKOACD++6UyBVW_fgbTXrOwuOJHSYenD87dwVJk0OA@mail.gmail.com>
 <7a0b893d-8f65-6423-3818-5dafc880dca1@amd.com>
 <CAP-5=fW8zLRgxXgY-CFUnU0HiiZMKhJ6b1znMxT8WeLO5Z-wZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW8zLRgxXgY-CFUnU0HiiZMKhJ6b1znMxT8WeLO5Z-wZA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 03, 2020 at 10:48:15PM -0700, Ian Rogers escreveu:
> On Thu, Sep 3, 2020 at 11:27 AM Kim Phillips <kim.phillips@amd.com> wrote:
> > On 9/3/20 1:19 AM, Ian Rogers wrote:
> > > On Tue, Sep 1, 2020 at 3:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
> > >> The nps1_die_to_dram event may need perf stat's --metric-no-group
> > >> switch if the number of available data fabric counters is less
> > >> than the number it uses (8).

> > > These are really excellent additions! Does:
> > > "MetricConstraint": "NO_NMI_WATCHDOG"
> > > solve the grouping issue? Perhaps the MetricConstraint needs to be
> > > named more generically to cover this case as it seems sub-optimal to
> > > require the use of --metric-no-group.

> > That metric uses data fabric (DFPMC/amd_df) events, not Core PMC
> > events, which the watchdog uses, so NO_NMI_WATCHDOG wouldn't have
> > an effect.  The event is defined as an approximation anyway.

> > I'll have to get back to you on the other items.

> > Thanks for your review!
 
> NP, more nits than anything else.
 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied, testing notes added to the cset:

    Committer testing:
    
    On a AMD Ryzen 3900x system:
    
    Before:
    
      # perf list all_dc_accesses   all_tlbs_flushed   l1_dtlb_misses   l2_cache_accesses_from_dc_misses   l2_cache_accesses_from_ic_misses   l2_cache_hits_from_dc_misses   l2_cache_hits_from_ic_misses   l2_cache_misses_from_dc_misses   l2_cache_misses_from_ic_miss   l2_dtlb_misses   l2_itlb_misses   sse_avx_stalls   uops_dispatched   uops_retired   l3_accesses   l3_misses | grep -v "^Metric Groups:$" | grep -v "^$"
      #
    
    After:
    
      # perf list all_dc_accesses   all_tlbs_flushed   l1_dtlb_misses   l2_cache_accesses_from_dc_misses   l2_cache_accesses_from_ic_misses   l2_cache_hits_from_dc_misses   l2_cache_hits_from_ic_misses   l2_cache_misses_from_dc_misses   l2_cache_misses_from_ic_miss   l2_dtlb_misses   l2_itlb_misses   sse_avx_stalls   uops_dispatched   uops_retired   l3_accesses   l3_misses | grep -v "^Metric Groups:$" | grep -v "^$" | grep -v "^recommended:$"
      all_dc_accesses
           [All L1 Data Cache Accesses]
      all_tlbs_flushed
           [All TLBs Flushed]
      l1_dtlb_misses
           [L1 DTLB Misses]
      l2_cache_accesses_from_dc_misses
           [L2 Cache Accesses from L1 Data Cache Misses (including prefetch)]
      l2_cache_accesses_from_ic_misses
           [L2 Cache Accesses from L1 Instruction Cache Misses (including
            prefetch)]
      l2_cache_hits_from_dc_misses
           [L2 Cache Hits from L1 Data Cache Misses]
      l2_cache_hits_from_ic_misses
           [L2 Cache Hits from L1 Instruction Cache Misses]
      l2_cache_misses_from_dc_misses
           [L2 Cache Misses from L1 Data Cache Misses]
      l2_cache_misses_from_ic_miss
           [L2 Cache Misses from L1 Instruction Cache Misses]
      l2_dtlb_misses
           [L2 DTLB Misses & Data page walks]
      l2_itlb_misses
           [L2 ITLB Misses & Instruction page walks]
      sse_avx_stalls
           [Mixed SSE/AVX Stalls]
      uops_dispatched
           [Micro-ops Dispatched]
      uops_retired
           [Micro-ops Retired]
      l3_accesses
           [L3 Accesses. Unit: amd_l3]
      l3_misses
           [L3 Misses (includes Chg2X). Unit: amd_l3]
      #
    
      # perf stat -a -e all_dc_accesses,all_tlbs_flushed,l1_dtlb_misses,l2_cache_accesses_from_dc_misses,l2_cache_accesses_from_ic_misses,l2_cache_hits_from_dc_misses,l2_cache_hits_from_ic_misses,l2_cache_misses_from_dc_misses,l2_cache_misses_from_ic_miss,l2_dtlb_misses,l2_itlb_misses,sse_avx_stalls,uops_dispatched,uops_retired,l3_accesses,l3_misses sleep 2
    
       Performance counter stats for 'system wide':
    
           433,439,949      all_dc_accesses                                               (35.66%)
                   443      all_tlbs_flushed                                              (35.66%)
             2,985,885      l1_dtlb_misses                                                (35.66%)
            18,318,019      l2_cache_accesses_from_dc_misses                                     (35.68%)
            50,114,810      l2_cache_accesses_from_ic_misses                                     (35.72%)
            12,423,978      l2_cache_hits_from_dc_misses                                     (35.74%)
            40,703,103      l2_cache_hits_from_ic_misses                                     (35.74%)
             6,698,673      l2_cache_misses_from_dc_misses                                     (35.74%)
            12,090,892      l2_cache_misses_from_ic_miss                                     (35.74%)
               614,267      l2_dtlb_misses                                                (35.74%)
               216,036      l2_itlb_misses                                                (35.74%)
                11,977      sse_avx_stalls                                                (35.74%)
           999,276,223      uops_dispatched                                               (35.73%)
         1,075,311,620      uops_retired                                                  (35.69%)
             1,420,763      l3_accesses
               540,164      l3_misses
    
           2.002344121 seconds time elapsed
    
      # perf stat -a -e all_dc_accesses,all_tlbs_flushed,l1_dtlb_misses,l2_cache_accesses_from_dc_misses,l2_cache_accesses_from_ic_misses sleep 2
    
       Performance counter stats for 'system wide':
    
           175,943,104      all_dc_accesses
                   310      all_tlbs_flushed
             2,280,359      l1_dtlb_misses
            11,700,151      l2_cache_accesses_from_dc_misses
            25,414,963      l2_cache_accesses_from_ic_misses
    
           2.001957818 seconds time elapsed
    
      #
    
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
    Signed-off-by: Kim Phillips <kim.phillips@amd.com>
    Acked-by: Ian Rogers <irogers@google.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
