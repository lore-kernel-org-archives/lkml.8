Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05473C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDE12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593024997;
	bh=IUZ1TdJqxfyYQjX35T0yNKtN123wm6TZ++oWRDKTlMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KIXM431Cnqkk7wDEjX172ApNogBSEPHPKxdVNkc4HeL/Nr7m53GVSiy7oFYXkh6aW
	 QnYNrsXdk3t5+vSuALSqAcmb+ETJ7yqPwRX9OS+LL7e/rgHNqw2vdQFNJ77xzKR//O
	 9fttOTCpzFT/B4Rl8FxsUVgE+g4swnf4EDmT9oAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406066AbgFXS4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405469AbgFXS4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:56:35 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB8020702;
        Wed, 24 Jun 2020 18:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593024995;
        bh=IUZ1TdJqxfyYQjX35T0yNKtN123wm6TZ++oWRDKTlMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qfTFkUqOsu0wIXUbkk0qItvD/XS6wCQC2ect3Y+O9FahvOqWIVJK68z5s703MCHR2
         0VwH/qcqmdaMCe2f/o6ydeQA9cAWNdp4UlydsyyrkS+9gww8RVoCcExnGjqSzpqyiB
         VJAheCd8yzEn453CqrljkXRCHHu5a9hgbQt7XfPU=
Date:   Wed, 24 Jun 2020 11:56:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Rafael Aquini <aquini@redhat.com>,
        "Fabrizio D'Angelo" <fdangelo@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/page_alloc: fix documentation error and remove
 magic numbers
Message-Id: <20200624115635.852cb4563ad52844685e5c61@linux-foundation.org>
In-Reply-To: <20200624170131.GQ21350@casper.infradead.org>
References: <20200624164943.32048-1-jsavitz@redhat.com>
        <20200624170131.GQ21350@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 18:01:31 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Jun 24, 2020 at 12:49:43PM -0400, Joel Savitz wrote:
> > When I increased the upper bound of the min_free_kbytes value in
> > ee8eb9a5fe863, I forgot to tweak the above comment to reflect
> > the new value. This patch fixes that mistake.
> > 
> > In addition, this patch replaces the magic number bounds with symbolic
> > constants to clarify the logic.
> > 
> > changes from v1:
> > - declare constants via enum instead of separate integers
> > 
> > Suggested-by: John Hubbard <jhubbard@nvidia.com>
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> 
> NAK.  Just fix the documentation.  It's bad form to combine two completely
> different things in one patch anyway.

I don't think the enums add value anyway - if these numbers are only
used in a single place, it's clearer to just open-code them.

One advantage of using a #define/enum for single-use constants is that
the #define/enum site provides a neat location for documenting
(commenting) the reasoning behind the particular values which were
chosen.  But this patch didn't do that.

