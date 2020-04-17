Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3099C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E302063A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgDQFSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:18:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:12615 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgDQFSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 01:18:40 -0400
IronPort-SDR: /rGaqSomH6JQ5IaYpGBV+w2iwUE5gVD3OvTPRLnQFMEJV6NETE1SBaCWV2BBFf5HGTquhCPx5F
 FDRkn1f4EEHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 22:18:39 -0700
IronPort-SDR: +8q+macfzoj/N2yw0IIxmAGyRLpsfCjBnl+JlEA8LbLjUnvsb5Yf0/G791k12W+LlekB2AY143
 QV1s76f9+Z8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="454603579"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga005.fm.intel.com with ESMTP; 16 Apr 2020 22:18:38 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: swap: properly update readahead statistics in unuse_pte_range()
References: <20200416180132.GB3352@xps-13>
        <871romvmrh.fsf@yhuang-dev.intel.com>
        <20200416210646.774bae8c321e3a44d6ffa8c3@linux-foundation.org>
Date:   Fri, 17 Apr 2020 13:18:37 +0800
In-Reply-To: <20200416210646.774bae8c321e3a44d6ffa8c3@linux-foundation.org>
        (Andrew Morton's message of "Thu, 16 Apr 2020 21:06:46 -0700")
Message-ID: <87sgh2u1ua.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri, 17 Apr 2020 11:01:22 +0800 "Huang\, Ying" <ying.huang@intel.com> wrote:
>
>> Andrea Righi <andrea.righi@canonical.com> writes:
>> 
>> > In unuse_pte_range() we blindly swap-in pages without checking if the
>> > swap entry is already present in the swap cache.
>> >
>> > By doing this, the hit/miss ratio used by the swap readahead heuristic
>> > is not properly updated and this leads to non-optimal performance during
>> > swapoff.
>> 
>> It's more important to describe why we need this patch in the patch
>> description.  So, please add some information about your use case.  And
>> please focus on the technical part instead of the business part.
>
> Confused.  I thought the changelog was quite good.  If "business part"
> means "end user effect of the patch" then that's a very important
> thing.

Previously, Andrea has described their use case in the cloud environment
to hiberate the guest and swapoff after resuming.  So swapoff
performance is important for them.  I think that should be included.
For the business part, I mean something like "Ubuntu used in AWS EC2", I
think that isn't important for the patch description.

>> Thanks!  But you don't need to do this.  You can add my Reviewed-by after
>> we have finished the work on patch description.
>
> Can you be more specific about how you want this changed?

Please use

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying
