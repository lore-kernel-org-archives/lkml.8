Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F520C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9592072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mEjqFFkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgFDQhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbgFDQhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:37:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480F9C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RCZnN0syAW3t9QwdLXO30GKp8cwgBcfJPzlUa/+XJqA=; b=mEjqFFkbAld3kjvhONwEWY/Fgl
        B5MRzmvxEZ+jHliUPauElMi/44BLdQpMSXbnLe8JX1+Jkz8QbrDHg/aAsHUqL1NbIeWCwXVcbjOMv
        OpWCyUB0VCllD8/82AElq6xkYcEP/VzFKl6vESQlf09WefpZaIpwZF6pbN4XKzS8+l3fTOS7j1FOn
        8D1O/KHsNCmSF3aONJa0K86q6y7YS4vlFiiP4y6tvp6EF5JYT0dmmA4gpqQodL8bO4BjJHH9gjjp5
        mkSbCbj6qzY/wW//hiDNQK7JXrUKPFilThjtkS/GMoE67ioqq5NMKcgRYH1n5Tgf+K6q4WixsaWhI
        zt5WylZw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgsrR-0005D8-Ps; Thu, 04 Jun 2020 16:36:57 +0000
Date:   Thu, 4 Jun 2020 09:36:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        hughd@google.com, daniel.m.jordan@oracle.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/vmstat: Add events for THP migration without split
Message-ID: <20200604163657.GV19604@bombadil.infradead.org>
References: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
 <20200604113421.GU19604@bombadil.infradead.org>
 <CBF71911-6BB7-4AA7-AC0F-95AADBB45569@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBF71911-6BB7-4AA7-AC0F-95AADBB45569@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 09:51:10AM -0400, Zi Yan wrote:
> On 4 Jun 2020, at 7:34, Matthew Wilcox wrote:
> > On Thu, Jun 04, 2020 at 09:30:45AM +0530, Anshuman Khandual wrote:
> >> +Quantifying Migration
> >> +=====================
> >> +Following events can be used to quantify page migration.
> >> +
> >> +- PGMIGRATE_SUCCESS
> >> +- PGMIGRATE_FAIL
> >> +- THP_MIGRATION_SUCCESS
> >> +- THP_MIGRATION_FAILURE
> >> +
> >> +THP_MIGRATION_FAILURE in particular represents an event when a THP could not be
> >> +migrated as a single entity following an allocation failure and ended up getting
> >> +split into constituent normal pages before being retried. This event, along with
> >> +PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying and analyzing THP
> >> +migration events including both success and failure cases.
> >
> > First, I'd suggest running this paragraph through 'fmt'.  That way you
> > don't have to care about line lengths.
> >
> > Second, this paragraph doesn't really explain what I need to know to
> > understand the meaning of these numbers.  When Linux attempts to migrate
> > a THP, one of three things can happen:
> >
> >  - It is migrated as a single THP
> >  - It is migrated, but had to be split
> >  - Migration fails
> >
> > How do I turn these four numbers into an understanding of how often each
> > of those three situations happen?  And why do we need four numbers to
> > report three situations?
> >
> > Or is there something else that can happen?  If so, I'd like that explained
> > here too ;-)
> 
> PGMIGRATE_SUCCESS and PGMIGRATE_FAIL record a combination of different events,
> so it is not easy to interpret them. Let me try to explain them.

Thanks!  Very helpful explanation.

> 1. migrating only base pages: PGMIGRATE_SUCCESS and PGMIGRATE_FAIL just mean
> these base pages are migrated and fail to migrate respectively.
> THP_MIGRATION_SUCCESS and THP_MIGRATION_FAILURE should be 0 in this case.
> Simple.
> 
> 2. migrating only THPs:
> 	- PGMIGRATE_SUCCESS means THPs that are migrated and base pages
> 	(from the split of THPs) that are migrated,
> 
> 	- PGMIGRATE_FAIL means THPs that fail to migrate and base pages that fail to migrated.
> 
> 	- THP_MIGRATION_SUCCESS means THPs that are migrated.
> 
> 	- THP_MIGRATION_FAILURE means THPs that are split.
> 
> So PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS means the number of migrated base pages,
> which are from the split of THPs.

Are you sure about that?  If I split a THP and each of those subpages
migrates, won't I then see PGMIGRATE_SUCCESS increase by 512?

> When it comes to analyze failed migration, PGMIGRATE_FAIL - THP_MIGRATION_FAILURE
> means the number of pages that are failed to migrate, but we cannot tell how many
> are base pages and how many are THPs.
> 
> 3. migrating base pages and THP:
> 
> The math should be very similar to the second case, except that
> a) from PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS, we cannot tell how many are pages begin
> as base pages and how many are pages begin as THPs but become base pages after split;
> b) from PGMIGRATE_FAIL - THP_MIGRATION_FAILURE, an additional case,
> base pages that begin as base pages fail to migrate, is mixed into the number and we
> cannot tell three cases apart.

So why don't we just expose PGMIGRATE_SPLIT?  That would be defined as
the number of times we succeeded in migrating a THP but had to split it
to succeed.


