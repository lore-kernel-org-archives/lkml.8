Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6DDC54FC9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 02:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D812076B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 02:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDTCc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 22:32:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:20233 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgDTCc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 22:32:57 -0400
IronPort-SDR: 8B/KEnNtY3CoaqCvvopdSmeKlHNAHeXpyUqJ5fhxl6iHtY88GUjylId4a1bfJnKoBrtrmCQxjE
 e8Klx+Vnxq4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 19:32:57 -0700
IronPort-SDR: CSVLQz9oXuocuFRvUvZLxSkA5EA1wVP/y9a1uB6hCn7SceHMo+m5DghLzVubub3hZrBGu7MpHM
 gthpS6iHBU3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="279092743"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2020 19:32:54 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>, SeongJae Park <sjpark@amazon.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [RFC] autonuma: Support to scan page table asynchronously
References: <20200418094811.4757-1-sj38.park@gmail.com>
Date:   Mon, 20 Apr 2020 10:32:53 +0800
In-Reply-To: <20200418094811.4757-1-sj38.park@gmail.com> (SeongJae Park's
        message of "Sat, 18 Apr 2020 11:48:11 +0200")
Message-ID: <877dyaubsa.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae Park <sj38.park@gmail.com> writes:
>
> DAMON allows users to know which address ranges have which access frequency.
> Thus, I think DAMON could be used for detection of hot pages, which will be
> good migration candidates, instead of the NUMA hinting fault based referenced
> pages detection.
>
> The benefits I expect from this change are better accuracy and less overhead.
> As we can know not only referenced pages but hot pages, migration will be more
> effective.

The purpose of AutoNUMA scanning isn't to find the hot pages, but the
pages that are accessed across NUMA node.  PTE accessed bit cannot
provide information of accessing CPU, so it's not enough for AutoNUMA.

Best Regards,
Huang, Ying
