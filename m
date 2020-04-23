Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D1BC55189
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B062D2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="czkNk+sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgDWB70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDWB70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 21:59:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDC5C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 18:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HhOesuEDxibfK6S65js7amlCplnHInNR5VyiDvIuF4g=; b=czkNk+smvOu1E/3PuI9KKGloew
        qzx6uhdq/lK9HujSyydA+abTHL3ctT0kIfMhgpbP2COqLcsNmf/UG29OxMsAJHtJHjTXZ6wiF29f9
        cYKnIVtzIC9lRhuczHj3v4VmD8Ap4pdlK4xCyyZGPcdUupzDKmnhlvH3JdoQmAJyeU01+aWywksi8
        bPRxZmlEqE4Wy46wiCC8jz88l4YeKTQni4kAewldndXgSeKwmddy0hwweP0+x05EwNEicaIYGLHGg
        uVw8nh1dow367QtERsMonyp2pg14F0MWYvCEdg7B6ujdtErND+YC476UfBTCb9M4EZnBi+wQ6F8Sn
        EKtHzYoQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRR93-0006gc-8R; Thu, 23 Apr 2020 01:59:17 +0000
Date:   Wed, 22 Apr 2020 18:59:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5 10/10] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200423015917.GA13910@bombadil.infradead.org>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:54:32PM -0700, Michel Lespinasse wrote:
> On Tue, Apr 21, 2020 at 6:58 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Apr 21, 2020 at 05:14:22PM -0700, Michel Lespinasse wrote:
> > > Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> >
> > Shouldn't some of these be folded into the previous patch?
> 
> So, I didn't do it because previous patch only handled rwsem_is_locked
> call sites. I leaned towards adding as few new API functions as
> possible until we figure out exactly what is required.
> 
> That said, I agree it seems reasonable to split mmap_assert_locked()
> into mmap_assert_read_locked() and mmap_assert_write_locked(), and
> convert the lockdep asserts to use these instead.

Just add mmap_assert_write_locked() -- some of these places can be called
with the rwsem held for either read or write; it doesn't matter which.
Others need it held for write.  There aren't any places (that I'm aware
of) that need to assert that it's held for read, and not held for write.

> I'm not sure we need to do it right away though; we are at least not
> losing any test coverage with the existing version of the patchset...

It seems like a better way to remove users of the term 'mmap_sem' than
just converting them to use the new 'mmap_lock'.
