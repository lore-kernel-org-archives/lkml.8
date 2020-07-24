Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C9A20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgGXOjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:39:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:62746 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgGXOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:39:09 -0400
IronPort-SDR: xFsb1O4KeEi/zoTtXzRNq9AXk2L1ikdxFHseZsUiIR858b2js2TMis8g94mSkI5KAL8mltaPr5
 WMG94WTL89Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="138218393"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="138218393"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 07:39:09 -0700
IronPort-SDR: ifAd3cKGAuEsmBo0T3lYxM9fJTmzHo+Zm2oBBiTYKMkE3F1oC1aITZIPqXBQiQRHb+piW8oJx6
 zjJIXvdDn9GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="488758608"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2020 07:39:08 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E996D301BF9; Fri, 24 Jul 2020 07:39:08 -0700 (PDT)
Date:   Fri, 24 Jul 2020 07:39:08 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     peterz@infradead.org
Cc:     kan.liang@linux.intel.com, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, like.xu@linux.intel.com
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
Message-ID: <20200724143908.GC1180481@tassilo.jf.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
 <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The consequence is that SLOTS must be the leader, is that really a
> problem? You keep providing the {cycles, slots, metric-things} example,

Yes that's a problem. One (major) use case for topdown is to
sample on lots of different events, but always create groups that
also measure topdown metrics for that sampling period. For that we need
other leaders.

-Andi
