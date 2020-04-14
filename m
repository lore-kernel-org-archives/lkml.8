Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86730C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2E620787
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403846AbgDNBpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 21:45:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:1314 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgDNBpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 21:45:43 -0400
IronPort-SDR: peIj0ED6tBRRwL2Hkjr8iGVJTt0N4TVvH1cazX0JiPGsYnRxnTDxz3wbiTiBNezpq1zC+OiKmP
 +NqSHqs2iTng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 18:45:42 -0700
IronPort-SDR: UexRrFsjgpHMwK9A/oshz470Jyjmt45pDLe5ZgnWgwlNmXbLHxziiQ0KeEPirtr6TXqNxuNBWf
 KflPfxfdcp7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="256353181"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2020 18:45:40 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
References: <20200413111810.GA801367@xps-13>
        <875ze37cle.fsf@yhuang-dev.intel.com> <20200413132658.GB801367@xps-13>
Date:   Tue, 14 Apr 2020 09:45:39 +0800
In-Reply-To: <20200413132658.GB801367@xps-13> (Andrea Righi's message of "Mon,
        13 Apr 2020 15:26:58 +0200")
Message-ID: <87sgh66drw.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

> On Mon, Apr 13, 2020 at 09:13:33PM +0800, Huang, Ying wrote:
>> Andrea Righi <andrea.righi@canonical.com> writes:
>> 
>> > The global swap-in readahead policy takes in account the previous access
>> > patterns, using a scaling heuristic to determine the optimal readahead
>> > chunk dynamically.
>> >
>> > This works pretty well in most cases, but like any heuristic there are
>> > specific cases when this approach is not ideal, for example the swapoff
>> > scenario.
>> >
>> > During swapoff we just want to load back into memory all the swapped-out
>> > pages and for this specific use case a fixed-size readahead is more
>> > efficient.
>> >
>> > The specific use case this patch is addressing is to improve swapoff
>> > performance when a VM has been hibernated, resumed and all memory needs
>> > to be forced back to RAM by disabling swap (see the test case below).
>> 
>> Why do you need to swapoff after resuming?  The swap device isn't used
>> except hibernation?  I guess the process is,
>> 
>> 1) add swap device to VM
>> 2) hibernate
>> 3) resume
>> 4) swapoff
>
> Correct, the swap device is used only for hibernation, when the system
> is resumed the swap is disabled (swapoff).
>
>> 
>> Some pages are swapped out in step 2?  If os, can we just set
>> /proc/sys/vm/swappiness to 0 to avoid swapping in step 2?
>
> Sorry, can you elaborate more on this? All anonymous pages are swapped
> out during step 2, it doesn't matter if we set swappiness to 0, they are
> swapped out anyway, because we need save them somewhere in order to
> hibernate, shutting down the system.

All pages will be written to the swap device in step 2.  But the normal
swapout path isn't used.  So these pages will be restored in step 3
instead of step 4.  But at the beginning of step 2, system may try to
reclaim some pages, the reclaimed anonymous pages will be restored in
step 4.  This may be avoided via setting /proc/sys/vm/swappiness to 0
before step 2.

Best Regards,
Huang, Ying

> Thanks,
> -Andrea
