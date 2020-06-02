Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C75CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1720420734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591119368;
	bh=aTA24MVtMAuQu3t1M90w7EDGpDeSOUQshfIJ9wDyIMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CUZmFCLpGa/GP8ZizGevegFUlJo0ZzccRDhJXQKBGozdOsI1DzhK94d5VvxSZlSvz
	 N+ixOx/BzXlPBHpEHOAlDK/STMxezRjx5tPzftkGivVQ3e6iXewzG6LTGd0kOmvq7E
	 53Pn+64FFSF6V9q0mnsg2hBaoJJPNhJE6dkVTWR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFBRgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgFBRgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:36:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95EE206E2;
        Tue,  2 Jun 2020 17:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591119366;
        bh=aTA24MVtMAuQu3t1M90w7EDGpDeSOUQshfIJ9wDyIMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJ44s8oj3g2D2laZ5EhFP4qTiwG28LQWQSsgumnv3X7ONkZs7ia+589jSRSWdQzmc
         q5IaU0k2sqVuU0SiPL0VHKYTSwyTGS30BQjdDhHC9DijWYWyfkbBrqMKE8qm6Oh0No
         pIoVKTq8SThIKf0m421RcWWPzMW7KmaNFdgkILek=
Date:   Tue, 2 Jun 2020 19:36:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: kobject_init_and_add is easy to misuse
Message-ID: <20200602173603.GB3579519@kroah.com>
References: <20200602115033.1054-1-wanghai38@huawei.com>
 <20200602121035.GL19604@bombadil.infradead.org>
 <1591111514.4253.32.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591111514.4253.32.camel@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 08:25:14AM -0700, James Bottomley wrote:
> On Tue, 2020-06-02 at 05:10 -0700, Matthew Wilcox wrote:
> > On Tue, Jun 02, 2020 at 07:50:33PM +0800, Wang Hai wrote:
> > > syzkaller reports for memory leak when kobject_init_and_add()
> > > returns an error in the function sysfs_slab_add() [1]
> > > 
> > > When this happened, the function kobject_put() is not called for
> > > the
> > > corresponding kobject, which potentially leads to memory leak.
> > > 
> > > This patch fixes the issue by calling kobject_put() even if
> > > kobject_init_and_add() fails.
> > 
> > I think this speaks to a deeper problem with kobject_init_and_add()
> > -- the need to call kobject_put() if it fails is not readily apparent
> > to most users.  This same bug appears in the first three users of
> > kobject_init_and_add() that I checked --
> > arch/ia64/kernel/topology.c
> > drivers/firmware/dmi-sysfs.c
> > drivers/firmware/efi/esrt.c
> > drivers/scsi/iscsi_boot_sysfs.c
> > 
> > Some do get it right --
> > arch/powerpc/kernel/cacheinfo.c
> > drivers/gpu/drm/ttm/ttm_bo.c
> > drivers/gpu/drm/ttm/ttm_memory.c
> > drivers/infiniband/hw/mlx4/sysfs.c
> > 
> > I'd argue that the current behaviour is wrong,
> 
> Absolutely agree with this.  We have a big meta pattern here where we
> introduce functions with tortuous semantics then someone creates a
> checker for the semantics and misuses come crawling out of the woodwork
> leading to floods of patches, usually for little or never used error
> paths, which really don't buy anything apart from theoretical
> correctness.  Just insisting on simple semantics would have avoided
> this.

I "introduced" this way back at the end of 2007.  It's not exactly a new
function.

> >  that kobject_init_and_add() should call kobject_put() if the add
> > fails.  This would need a tree-wide audit.  But somebody needs to do
> > that anyway because based on my random sampling, half of the users
> > currently get it wrong.
> 
> Well, the semantics of kobject_init() are free on fail, so these are
> the ones everyone seems to be using.  The semantics of kobject_add are
> put on fail.  The problem is that put on fail isn't necessarily correct
> in the kobject_init() case: the release function may make assumptions
> about the object hierarchy which aren't satisfied in the kobject_init()
> failure case.  This argues that kobject_init_and_add() can't ever have
> correct semantics and we should eliminate it.

At the time, it did reduce common functionality and error handling all
into a simpler function.  And, given it's history, it must have somehow
worked for the past 12 years or so :)

Odds are, lots of the callers shouldn't be messing around with kobjects
in the first place.  Originally it was only assumed that there would be
very few users.  But it has spread to filesystems and firmware
subsystems.  Drivers should never use it though, so it's a good hint
something is wrong there...

Anyway, patches to fix this up to make a "sane" api for kobjects is
always appreciated.  Personally I don't have the time at the moment.

thanks,

greg k-h
