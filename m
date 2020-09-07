Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCDAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBFD20732
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgIGHUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:20:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:38944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgIGHUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:20:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D30E9AD49;
        Mon,  7 Sep 2020 07:20:16 +0000 (UTC)
Date:   Mon, 7 Sep 2020 09:20:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200907072014.GD30144@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
 <20200904074207.GC15277@dhcp22.suse.cz>
 <20200904211045.GA567128@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904211045.GA567128@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-09-20 14:10:45, Roman Gushchin wrote:
> On Fri, Sep 04, 2020 at 09:42:07AM +0200, Michal Hocko wrote:
[...]
> > An explicit opt-in sounds much more appropriate to me as well. If we go
> > with a specific API then I would not make it 1GB pages specific. Why
> > cannot we have an explicit interface to "defragment" address space
> > range into large pages and the kernel would use large pages where
> > appropriate? Or is the additional copying prohibitively expensive?
> 
> Can you, please, elaborate a bit more here? It seems like madvise(MADV_HUGEPAGE)
> provides something similar to what you're describing, but there are lot
> of details here, so I'm probably missing something.

MADV_HUGEPAGE is controlling a preference for THP to be used for a
particular address range. So it looks similar but the historical
behavior is to control page faults as well and the behavior depends on
the global setup.

I've had in mind something much simpler. Effectively an API to invoke
khugepaged (like) functionality synchronously from the calling context
on the specific address range. It could be more aggressive than the
regular khugepaged and create even 1G pages (or as large THPs as page
tables can handle on the particular arch for that matter).

As this would be an explicit call we do not have to be worried about
the resulting latency because it would be an explicit call by the
userspace.  The default khugepaged has a harder position there because
has no understanding of the target address space and cannot make any
cost/benefit evaluation so it has to be more conservative.
-- 
Michal Hocko
SUSE Labs
