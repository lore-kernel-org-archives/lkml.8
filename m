Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA247C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F082065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGXOpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:45:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:37044 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgGXOpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:45:03 -0400
IronPort-SDR: 2eV/3JIdk4JRqiUVtPIylTC+qN6yb9u9NVc/MWImnbFSX9XyhCgdDQFY0Bp/ce/ByS7VElN27c
 KH/SuxGQ6YfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="212259178"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="212259178"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 07:45:03 -0700
IronPort-SDR: 6Ck2M2xBKPYBeWY4Di7+IhB7A6KYcAiZ8Lol/Kpwit0nDqg7wfTGRZ5/kpPaL8Ddn/6XnYHM2n
 grfjSpDl/8sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="289010294"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2020 07:45:03 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 3229A301BF9; Fri, 24 Jul 2020 07:45:03 -0700 (PDT)
Date:   Fri, 24 Jul 2020 07:45:03 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf bench: Add benchmark of find_next_bit
Message-ID: <20200724144503.GD1180481@tassilo.jf.intel.com>
References: <20200724071959.3110510-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724071959.3110510-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:19:59AM -0700, Ian Rogers wrote:
> for_each_set_bit, or similar functions like for_each_cpu, may be hot
> within the kernel. If many bits were set then one could imagine on
> Intel a "bt" instruction with every bit may be faster than the function
> call and word length find_next_bit logic. Add a benchmark to measure
> this.
 
> This benchmark on AMD rome and Intel skylakex shows "bt" is not a good
> option except for very small bitmaps.

Small bitmaps is a common case in the kernel (e.g. cpu bitmaps) 

But the current code isn't that great for small bitmaps. It always looks horrific
when I look at PT traces or brstackinsn, especially since it was optimized
purely for code size at some point.

Probably would be better to have different implementations for
different sizes.

-Andi
