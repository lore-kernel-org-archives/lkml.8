Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C301CC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF5B2467C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBSOdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:33:06 -0500
Received: from outbound-smtp59.blacknight.com ([46.22.136.243]:60659 "EHLO
        outbound-smtp59.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727855AbgBSOdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:33:06 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp59.blacknight.com (Postfix) with ESMTPS id 00217FB160
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:33:03 +0000 (GMT)
Received: (qmail 26706 invoked from network); 19 Feb 2020 14:33:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Feb 2020 14:33:03 -0000
Date:   Wed, 19 Feb 2020 14:33:00 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, mst@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, yang.zhang.wz@gmail.com,
        pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com,
        riel@surriel.com, willy@infradead.org, lcapitulino@redhat.com,
        dave.hansen@intel.com, wei.w.wang@intel.com, aarcange@redhat.com,
        pbonzini@redhat.com, dan.j.williams@intel.com, mhocko@kernel.org,
        alexander.h.duyck@linux.intel.com, vbabka@suse.cz,
        osalvador@suse.de
Subject: Re: [PATCH v17 3/9] mm: Add function __putback_isolated_page
Message-ID: <20200219143300.GR3466@techsingularity.net>
References: <20200211224416.29318.44077.stgit@localhost.localdomain>
 <20200211224624.29318.89287.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200211224624.29318.89287.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 02:46:24PM -0800, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> There are cases where we would benefit from avoiding having to go through
> the allocation and free cycle to return an isolated page.
> 
> Examples for this might include page poisoning in which we isolate a page
> and then put it back in the free list without ever having actually
> allocated it.
> 
> This will enable us to also avoid notifiers for the future free page
> reporting which will need to avoid retriggering page reporting when
> returning pages that have been reported on.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Ok, the prior code that used post_alloc_hook to make the isolated page seem
like a normally allocated page followed by a free seems strange anyway. As
well as being expensive, isolated pages can end up on the per-cpu lists
which is probably not what is desired. I *think* what you've done is ok so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
