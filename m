Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9876C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868F120878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J5KdTTMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCLJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFCLJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:09:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437C1C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cDGghqfSCuNlVaGtMZhIDjeMAkusS7gi8giksB3q3O0=; b=J5KdTTMGxUlDBP1135itwZXJyH
        nhrPghOmZliajNwZJ24DM8OaSR6lYwC3lvHRfkQTOOJhKQb1iNMR7sbqshHsMRSESFp/9gR9a+WVc
        Eo0FD1D2/Ez6Zat3T0xAOpXwXlVYAU7Lsc2S+2xhhAIljPcTb9XNln4ryuTYN6lG00vQ2RPV6BUTV
        9Q6R2LjVjx0zmPy/sLZ4NW88Zb/MGCezUuMoBGhFcmVscVSTljHvOU6VotPbPkHVgEn4JEUSJmAe0
        GOH5g7WfbNFBZsQKLGJgd9eNsGICyZvPvBBZEpXdv5XY2LBkwpP+B5l4HNiWsbcFEJ0ZIo2q2YeA6
        P1BqHEwg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRH7-0005t7-6k; Wed, 03 Jun 2020 11:09:37 +0000
Date:   Wed, 3 Jun 2020 04:09:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, hughd@google.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: Add events for PMD based THP migration
 without split
Message-ID: <20200603110937.GP19604@bombadil.infradead.org>
References: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
 <20200602150141.GN19604@bombadil.infradead.org>
 <2d4634ce-9167-6ca6-fb91-f3c671fff672@arm.com>
 <20200603025729.GO19604@bombadil.infradead.org>
 <280304c7-882b-cb2f-55bf-87b2e2f28711@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280304c7-882b-cb2f-55bf-87b2e2f28711@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 10:28:41AM +0530, Anshuman Khandual wrote:
> On 06/03/2020 08:27 AM, Matthew Wilcox wrote:
> > On Wed, Jun 03, 2020 at 06:56:57AM +0530, Anshuman Khandual wrote:
> >> On 06/02/2020 08:31 PM, Matthew Wilcox wrote:
> >>> On Fri, May 22, 2020 at 09:04:04AM +0530, Anshuman Khandual wrote:
> >>>> This adds the following two new VM events which will help in validating PMD
> >>>> based THP migration without split. Statistics reported through these events
> >>>> will help in performance debugging.
> >>>>
> >>>> 1. THP_PMD_MIGRATION_SUCCESS
> >>>> 2. THP_PMD_MIGRATION_FAILURE
> >>>
> >>> There's nothing actually PMD specific about these events, is there?
> >>> If we have a THP of a non-PMD size, you'd want that reported through the
> >>> same statistic, wouldn't you?
> >>
> >> Yes, there is nothing PMD specific here and we would use the same statistics
> >> for non-PMD size THP migration (if any) as well. But is THP migration really
> >> supported for non-PMD sizes ? CONFIG_ARCH_ENABLE_THP_MIGRATION depends upon
> >> CONFIG_TRANSPARENT_HUGEPAGE without being specific or denying about possible
> >> PUD level support. Fair enough, will drop the PMD from the events and their
> >> functions.
> > 
> > I guess you haven't read my large pages patchset?
> 
> I believe you are referring this "[PATCH v5 00/39] Large pages in the page cache"
> (https://lkml.org/lkml/2020/5/28/1755). Unfortunately, I have not been following
> the series. But is there something else in particular that needs to be taken care
> of as well ?

I don't think so, but I haven't looked at the migration path at all.
I'm hoping it "just works", but experience with the rest of the mm has
taught me there's probably an assumption in there that THP => PMD that
will need to be fixed.  I'm not currently testing on a NUMA machine, and
I'm still debugging other paths.
