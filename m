Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA935C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB54206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B3nrk1q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgFDLej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgFDLei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 07:34:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83F9C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 04:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p9QVJ3Lo99pFeR+OabRjGu19usxqVkhLhkbiQm7crNs=; b=B3nrk1q/BmdstT3t5wnGI3zTWY
        tslgFuh09KlXol7r4KPhS+L7hcK70HzQYrBrhvdH2vyQ0daCFVaCboq6yAnEdmMXSFdQi7NwvzJCH
        T1oYdqY2d5eAq7jk0rHfVhJ/YvQYvkPc6SPxkNpqP1DD8U+mKywiD+zfTdiKmxypLNY8veiRphyV1
        Kkqhi5F4LhI+2B9hd10HCMQfs1ZnDwNTKMMUIET7Y5b6amsrkbQ74gbj+xh+TGxH403LtbDwEK3IG
        KV4cw5N0B24J0XEV042U2tMpKM3KdlWehu1lY1ejILkifS276EmZdsN4g3jgjbGk+gKFF2TGM1Rx5
        cPSnc3ig==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgo8b-0001F0-VY; Thu, 04 Jun 2020 11:34:21 +0000
Date:   Thu, 4 Jun 2020 04:34:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, hughd@google.com, daniel.m.jordan@oracle.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/vmstat: Add events for THP migration without split
Message-ID: <20200604113421.GU19604@bombadil.infradead.org>
References: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 09:30:45AM +0530, Anshuman Khandual wrote:
> Add the following new VM events which will help in validating THP migration
> without split. Statistics reported through these new events will help in
> performance debugging.
> 
> 1. THP_MIGRATION_SUCCESS
> 2. THP_MIGRATION_FAILURE
> 
> THP_MIGRATION_FAILURE in particular represents an event when a THP could
> not be migrated as a single entity following an allocation failure and
> ended up getting split into constituent normal pages before being retried.
> This event, along with PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in
> quantifying and analyzing THP migration events including both success and
> failure cases.

> +Quantifying Migration
> +=====================
> +Following events can be used to quantify page migration.
> +
> +- PGMIGRATE_SUCCESS
> +- PGMIGRATE_FAIL
> +- THP_MIGRATION_SUCCESS
> +- THP_MIGRATION_FAILURE
> +
> +THP_MIGRATION_FAILURE in particular represents an event when a THP could not be
> +migrated as a single entity following an allocation failure and ended up getting
> +split into constituent normal pages before being retried. This event, along with
> +PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying and analyzing THP
> +migration events including both success and failure cases.

First, I'd suggest running this paragraph through 'fmt'.  That way you
don't have to care about line lengths.

Second, this paragraph doesn't really explain what I need to know to
understand the meaning of these numbers.  When Linux attempts to migrate
a THP, one of three things can happen:

 - It is migrated as a single THP
 - It is migrated, but had to be split
 - Migration fails

How do I turn these four numbers into an understanding of how often each
of those three situations happen?  And why do we need four numbers to
report three situations?

Or is there something else that can happen?  If so, I'd like that explained
here too ;-)

