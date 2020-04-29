Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8706C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E86E20737
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FkFAtxo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgD2BsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 21:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2BsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:48:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5497CC03C1AC;
        Tue, 28 Apr 2020 18:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LCV05bmUMt/JTnik/FHerL4Ec6mpH5O0Enok8cXx9E8=; b=FkFAtxo48mz7pUFlav7T1IDRCW
        EkFO3Pxze3Q4aD90IVsb4it+V85tsX7cOEjdDX0reX18BoNdq7zOe7j/KNZGlRS6qEXeUMqobpAhL
        xLOpR68hSSbWMco3ZLW7gDleGlTlFDS08fAJr/uzLQZKc83VzyI3Rvi8MUNCOuCMgW4W0dtDqLWlQ
        hld/UnzliFEQfDKWjPxyFORuzQ9a2CXmM2juej1AbUYphFXyLirQXRmw356z+7VkbLe51GbJKo/U0
        xQb5ZzSNNsjavNkuYLw1eN8uv0/G9yjopfGn4T+1opbtOtpdGf32jCmlKku9/Q0xVmkr4mM2w+X8H
        2GYE3/Tg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTbpT-0004yP-Dr; Wed, 29 Apr 2020 01:48:03 +0000
Date:   Tue, 28 Apr 2020 18:48:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Waiman Long <longman@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ipc: use GFP_ATOMIC under spin lock
Message-ID: <20200429014803.GO29705@bombadil.infradead.org>
References: <20200428034736.27850-1-weiyongjun1@huawei.com>
 <20200428111403.GJ29705@bombadil.infradead.org>
 <20200428171420.045f0acc9e1bf20044c4560e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428171420.045f0acc9e1bf20044c4560e@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 05:14:20PM -0700, Andrew Morton wrote:
> On Tue, 28 Apr 2020 04:14:03 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Apr 28, 2020 at 03:47:36AM +0000, Wei Yongjun wrote:
> > > The function ipc_id_alloc() is called from ipc_addid(), in which
> > > a spin lock is held, so we should use GFP_ATOMIC instead.
> > > 
> > > Fixes: de5738d1c364 ("ipc: convert ipcs_idr to XArray")
> > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > 
> > I see why you think that, but it's not true.  Yes, we hold a spinlock, but
> > the spinlock is in an object which is not reachable from any other CPU.
> > So it's not possible to deadlock.
> 
> um, then why are we taking it?

The lock has to be held by the time 'new' is findable because 'new' is
not completely constructed at that point.  The finder will try to acquire
the spinlock before looking at the uninitialised fields, so it's safe.
But it's not a common idiom we use at all.

> >  This probably confuses all kinds
> > of automated checkers,
> 
> A big fat code comment would reduce the email traffic?

I think I can rewrite this to take the spinlock after doing the allocation.
