Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208D0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3872070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vABi0Bq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgEULl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgEULl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:41:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE57EC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I8UycZ0lAoY+wdLU6EmAhxQhnZZhJhMatAs9OekFUgE=; b=vABi0Bq6Ha1sL8cb3zGlS2qqEy
        xtABl7pP8SkymaVf5ZIdW9sCi++6yzoRr8yzYY40/Od5Ts6LWfjBn/riMjq+bvNpz/OPwx6+tXyTy
        zK3xyHP9RpxjKRs91KPR7tk5HytHNiC1WyFWlWxa04gt75oCVe26NcK2nIak/ZxQ/rZ0AehuGDlYW
        +FTa1XVzYeWuLNqoZv9oM/24ffTA6pkxOwKiNVhDzTK7dcEzIl0pZ8oTAR8wg3YYyau2tajqxxvjd
        uDhAtCJ2JZyVatP3KvqJ1cF03sNCLlrBjvgG85NOWBBKKPMxmo7SamxefnrYiCntR2tibV0PcWU5l
        eth0f/yw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbjZb-00080M-VW; Thu, 21 May 2020 11:41:15 +0000
Date:   Thu, 21 May 2020 04:41:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v3] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <20200521114115.GA28818@bombadil.infradead.org>
References: <159002475918.686697.11844615159862491335.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200521022628.GE16070@bombadil.infradead.org>
 <CAPcyv4jpKo7s-bqM2TN2BS73ssOVfhdNaooziZMs2zULH6xs-g@mail.gmail.com>
 <CAPcyv4hvCYF7wCtYwAXi-Okpxm-W+W=nRRJkmSHFg0p+Z2p17A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hvCYF7wCtYwAXi-Okpxm-W+W=nRRJkmSHFg0p+Z2p17A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:39:49PM -0700, Dan Williams wrote:
> On Wed, May 20, 2020 at 9:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > On Wed, May 20, 2020 at 7:26 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Wed, May 20, 2020 at 06:35:25PM -0700, Dan Williams wrote:
> > > > +static struct inode *devmem_inode;
> > > > +
> > > > +#ifdef CONFIG_IO_STRICT_DEVMEM
> > > > +void revoke_devmem(struct resource *res)
> > > > +{
> > > > +     struct inode *inode = READ_ONCE(devmem_inode);
> > > > +
> > > > +     /*
> > > > +      * Check that the initialization has completed. Losing the race
> > > > +      * is ok because it means drivers are claiming resources before
> > > > +      * the fs_initcall level of init and prevent /dev/mem from
> > > > +      * establishing mappings.
> > > > +      */
> > > > +     smp_rmb();
> > > > +     if (!inode)
> > > > +             return;
> > >
> > > But we don't need the smp_rmb() here, right?  READ_ONCE and WRITE_ONCE
> > > are a DATA DEPENDENCY barrier (in Documentation/memory-barriers.txt parlance)
> > > so the smp_rmb() is superfluous ...
> >
> > Is it? I did not grok that from Documentation/memory-barriers.txt.
> > READ_ONCE and WRITE_ONCE are certainly ordered with respect to each
> > other in the same function, but I thought they still depend on
> > barriers for smp ordering?
> >
> > > > +
> > > > +     /* publish /dev/mem initialized */
> > > > +     smp_wmb();
> > > > +     WRITE_ONCE(devmem_inode, inode);
> > >
> > > As above, unnecessary barrier, I think.
> >
> > Well, if you're not sure, how sure should I be?
> 
> I'm pretty sure they are needed, because I need the prior writes to
> initialize the inode to be fenced before the final write to publish
> the inode. I don't think WRITE_ONCE() enforces that prior writes have
> completed.

Completed, no, but I think it does enforce that they're visible to other
CPUs before this write is visible to other CPUs.

I'll quote relevant bits from the document ...

 (2) Data dependency barriers.

     A data dependency barrier is a weaker form of read barrier.  In the case
     where two loads are performed such that the second depends on the result
     of the first (eg: the first load retrieves the address to which the second
     load will be directed), a data dependency barrier would be required to
     make sure that the target of the second load is updated after the address
     obtained by the first load is accessed.

[...]
SMP BARRIER PAIRING
-------------------
[...]
        CPU 1                 CPU 2
        ===============       ===============================
        a = 1;
        <write barrier>
        WRITE_ONCE(b, &a);    x = READ_ONCE(b);
                              <data dependency barrier>
                              y = *x;


> > >
> > > > +     /*
> > > > +      * Use a unified address space to have a single point to manage
> > > > +      * revocations when drivers want to take over a /dev/mem mapped
> > > > +      * range.
> > > > +      */
> > > > +     inode->i_mapping = devmem_inode->i_mapping;
> > > > +     inode->i_mapping->host = devmem_inode;
> > >
> > > umm ... devmem_inode->i_mapping->host doesn't already point to devmem_inode?
> >
> > Not if inode is coming from:
> >
> >      mknod ./newmem c 1 1
> >
> > ...that's the problem that a unified inode solves. You can mknod all
> > you want, but mapping and mapping->host will point to a common
> > instance.

I don't think I explained myself well enough.

When we initialise devmem_inode, does devmem_inode->i_mapping->host point
to somewhere other than devmem_inode?

I appreciate in this function, inode->i_mapping->host will point to inode.
But we're now changing i_mapping to be devmem_inode's i_mapping.  Why
do we need to change devmem_inode's i_mapping->host pointer?

