Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1C7C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35C420866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgCCLhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:37:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:48947 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgCCLhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:37:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 03:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="258350423"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2020 03:36:58 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        "Alexander Duyck" <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
References: <20200228033819.3857058-1-ying.huang@intel.com>
        <20200228034248.GE29971@bombadil.infradead.org>
        <87a7538977.fsf@yhuang-dev.intel.com>
        <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
        <871rqf850z.fsf@yhuang-dev.intel.com>
        <20200228095048.GK3771@dhcp22.suse.cz>
        <87d09u7sm2.fsf@yhuang-dev.intel.com>
        <20200302142549.GO4380@dhcp22.suse.cz>
        <874kv66x8r.fsf@yhuang-dev.intel.com>
        <20200303081929.GY4380@dhcp22.suse.cz>
Date:   Tue, 03 Mar 2020 19:36:57 +0800
In-Reply-To: <20200303081929.GY4380@dhcp22.suse.cz> (Michal Hocko's message of
        "Tue, 3 Mar 2020 09:19:29 +0100")
Message-ID: <87k1414qli.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Tue 03-03-20 09:30:28, Huang, Ying wrote:
> [...]
>> Yes.  mmap() can control whether to populate the underlying physical
>> pages.
>
> right because many usecases benefit from it. They simply know that the
> mapping will be used completely and it is worth saving overhead for #PF.
> See. there is a clear justification for that policy.
>
>> But for migrating MADV_FREE pages, there's no control, all pages
>> will be populated again always by default.  Maybe we should avoid to do
>> that in some situations too.
>
> Now let's have a look here. It is the userspace that decided to mark
> MADV_FREE pages. It is under its full control which pages are to be
> freed lazily. If the userspace wants to move those pages then it is
> likely aware they have been MADV_FREE, right? If the userspace wanted to
> save migration overhead then it could either chose to not migrate those
> pages or simply unmap them right away. So in the end we are talking
> about saving munmap/MAMDV_DONTNEED or potentially more move_pages calls
> to skip over MADV_FREE holes. Which is all nice but is there any
> userspace that really does care? Because this is a fundamental question
> here and it doesn't make much sense to discuss this left to right unless
> this is clear.

Although I don't agree with you, I don't want to continue.  Because I
feel that the discussion may be too general to go anywhere.  I admit
that I go to the general side firstly, sorry about that.

Best Regards,
Huang, Ying
