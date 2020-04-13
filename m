Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7728AC2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1F82072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgDMNNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:13:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:45768 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbgDMNNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:13:36 -0400
IronPort-SDR: niPVWaW2RkcRfRqeeUygZIHkyiZDaStXBQD3OHnQ3oUOEs39NVonbUjucnIy2ftT/4+3JceP09
 rrLxn4B8IvnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 06:13:35 -0700
IronPort-SDR: EBarXwOJVuLuIhZVVqFQ5Ln6ll8U7Rpxf8g0h9ogMC3BvyKdu46ZUNzdUW5NOpgy6c7bXX4gTX
 0FE9zkRtP9Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="399603024"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 06:13:34 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
References: <20200413111810.GA801367@xps-13>
Date:   Mon, 13 Apr 2020 21:13:33 +0800
In-Reply-To: <20200413111810.GA801367@xps-13> (Andrea Righi's message of "Mon,
        13 Apr 2020 13:18:10 +0200")
Message-ID: <875ze37cle.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

> The global swap-in readahead policy takes in account the previous access
> patterns, using a scaling heuristic to determine the optimal readahead
> chunk dynamically.
>
> This works pretty well in most cases, but like any heuristic there are
> specific cases when this approach is not ideal, for example the swapoff
> scenario.
>
> During swapoff we just want to load back into memory all the swapped-out
> pages and for this specific use case a fixed-size readahead is more
> efficient.
>
> The specific use case this patch is addressing is to improve swapoff
> performance when a VM has been hibernated, resumed and all memory needs
> to be forced back to RAM by disabling swap (see the test case below).

Why do you need to swapoff after resuming?  The swap device isn't used
except hibernation?  I guess the process is,

1) add swap device to VM
2) hibernate
3) resume
4) swapoff

Some pages are swapped out in step 2?  If os, can we just set
/proc/sys/vm/swappiness to 0 to avoid swapping in step 2?

Best Regards,
Huang, Ying
