Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F85C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6622F206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgGURjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:39:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:25532 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbgGURjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:39:00 -0400
IronPort-SDR: anAe2UelXwPsWSmqBnlTWjkR2lUgobtVTxoIIVNU+Y8Z8/57RFjrENJMuDDF1sJ6lJDOjmyZey
 cw3N/0+T+yEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="130274915"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="130274915"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 10:38:59 -0700
IronPort-SDR: XvL32KkZWfZL1I/VkQvfzzL0KHkKuXFuc9S1LyZ3pvvElEcL8Y0s3oRofbP5f2az8MibeUoUXm
 nPu9Ok+1pdDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="432076873"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2020 10:38:59 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C01D6301BF5; Tue, 21 Jul 2020 10:38:59 -0700 (PDT)
Date:   Tue, 21 Jul 2020 10:38:59 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V6 09/14] perf/x86/intel: Support TopDown metrics on Ice
 Lake
Message-ID: <20200721173859.GG1180481@tassilo.jf.intel.com>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-10-kan.liang@linux.intel.com>
 <20200721124042.GX10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721124042.GX10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, that for_each_set_bit() loop, trying to find the events to
> update...
> 
> Can't we, instead, make the SLOTS update advance 5 running counters in
> cpuc and feed the events off of that?

The original patches implemented this through a perf transaction and a
cache.  I think what you're suggesting is similar to the old cache.

-Andi
