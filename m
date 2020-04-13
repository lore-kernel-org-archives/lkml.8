Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14987C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1204206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586811941;
	bh=LkCTIni/fa8Quey7RQNZQR1Mn9k2OEZeuLUCdcidPj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DDJzmRBSViP6CJ1kT8RRE4T4+8RGojxez5mIgPYo1hr26b2ZdHPa8+dPEKb0BhXyW
	 c9b9qrWLDt2VYq3HTFwwezJKu3DyreFbG8bjH8YuCeIIvh5BK4Kn7T0ONJDkHvo5WN
	 GlI1zGsmB7yqOlt7VB0E+CUcOIdL8tcjW3tCmGI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbgDMVFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388723AbgDMVFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:05:38 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0E73206DA;
        Mon, 13 Apr 2020 21:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586811938;
        bh=LkCTIni/fa8Quey7RQNZQR1Mn9k2OEZeuLUCdcidPj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m6proOsngFU6tmeB58nGVfSFO0ugVeanxtZkHV29ol2KQP9rib2dh9HBBaC09a0us
         fzz+dXEI/bZbHfpIBXArHts3zvXQ8rPfldvfBR1IVJM+wBdTQ0lJJQIolRlrrF6i0Q
         EFeJoYywLSz8ScowSwcVCKT0EqWKUEgZ1H0lrDJA=
Date:   Mon, 13 Apr 2020 14:05:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 4/4] mm: Add PG_zero support
Message-Id: <20200413140537.eb674579cf8c71b4e20581ab@linux-foundation.org>
In-Reply-To: <5eb37d79-6420-fcb9-2b4c-6cc6194afcd9@linux.intel.com>
References: <20200412090945.GA19582@open-light-1.localdomain>
        <20200412101223.GK21484@bombadil.infradead.org>
        <5eb37d79-6420-fcb9-2b4c-6cc6194afcd9@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 08:11:59 -0700 Alexander Duyck <alexander.h.duyck@linux.intel.com> wrote:

> In addition, unlike madvising the page away there is a pretty 
> significant performance penalty for having to clear the page a second 
> time when the page is split or merged.

I wonder if there might be an issue with increased memory traffic (and
increased energy consumption, etc).  If a page is zeroed immediately
before getting data written into it (eg, plain old file write(),
anonymous pagefault) then we can expect that those 4096 zeroes will be
in CPU cache and mostly not written back.  But if that page was zeroed
a "long" time ago, the caches will probably have been written back. 
Net result: we go from 4k of memory traffic for a 4k page up to 8k of
memory traffic?

Also, the name CONFIG_ZERO_PAGE sounds like it has something to do with
the long established "zero page".  Confusing.  CONFIG_PREZERO_PAGE,
maybe?
