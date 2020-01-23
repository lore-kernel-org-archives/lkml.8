Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D3C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 06:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E55217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 06:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PIVXTPnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAWGll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 01:41:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgAWGll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 01:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vzA4qFI0clehk17KAQWnrnqYblUUCzc7lcilnwcRFvA=; b=PIVXTPnpPMrYaUzy4A4QmGXDD1
        F2yRfoz0Em5QGFQtULhnLC+Al6M+v5iz9V6KGHTI4W9fC7cgM3JwuIa/IDXWW4IlgusDM90rgVRm+
        8qGAyvv54PG/P5klPQIbSeTFpIARw9kVzLg5CAct8QLjaom5acY1Xg87avWx9NBoolhwskCpZkmJN
        WHeoVfH0r1rocGdd45006lBGjqAXvsiqvtcfN/w27n0LfswZcMp0yKKiAMOnz/HdAr0RSCv2A0+gH
        BiWJsT2v6Yr/J9zho3kFjBqSJM2Fnb2aiakIdsBpn+wnUhprd6dyK+cdGbUwUsIpCw6bj/stxFSIe
        nLZwxfcQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuWBQ-0001la-NL; Thu, 23 Jan 2020 06:41:40 +0000
Date:   Wed, 22 Jan 2020 22:41:40 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] XArray for 5.5
Message-ID: <20200123064140.GG4675@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I had an oops live on stage at linux.conf.au this year, and it turned out
to be a bug in xas_find() which I can't prove isn't triggerable in the
current codebase.  Then in looking for the bug, I spotted two more bugs.
The bots have had a few days to chew on this with no problems reported,
and it passes the test-suite (which now has more tests to make sure
these problems don't come back).

So I feel pretty comfortable asking you to pull this, even though it's
so late in the development cycle.

The following changes since commit 0058b0a506e40d9a2c62015fe92eb64a44d78cd9:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2019-11-08 18:21:05 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git tags/xarray-5.5

for you to fetch changes up to 00ed452c210a0bc1ff3ee79e1ce6b199f00a0638:

  XArray: Add xa_for_each_range (2020-01-17 22:33:37 -0500)

----------------------------------------------------------------
XArray updates for 5.5

Primarily bugfixes, mostly around handling index wrap-around correctly.
A couple of doc fixes and adding missing APIs.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (7):
      XArray: Fix xas_pause at ULONG_MAX
      XArray: Improve documentation of search marks
      XArray: Add wrappers for nested spinlocks
      XArray: Fix infinite loop with entry at ULONG_MAX
      XArray: Fix xa_find_after with multi-index entries
      XArray: Fix xas_find returning too many entries
      XArray: Add xa_for_each_range

 Documentation/core-api/xarray.rst | 70 +++++++++++++++++++++--------------
 include/linux/xarray.h            | 45 +++++++++++++++++++---
 lib/test_xarray.c                 | 78 ++++++++++++++++++++++++++++++++-------
 lib/xarray.c                      | 41 ++++++++++++++------
 4 files changed, 175 insertions(+), 59 deletions(-)

