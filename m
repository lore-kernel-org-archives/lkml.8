Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48066C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A09206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597830043;
	bh=zWlnnmPKekpNj9Y7nF8x2xH0z5eGvfiJTnebm6MK6iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZmvPshjotz/4tjh/iR8GxqmMFruJh61XKNAVE7scjLqU9qPjadVyBw92AfXHGkaNz
	 E5hr5K8gYCeyFKrHyfz2ea0idLmTnyKYgN3f/670rhj1DTET6fTOEKO4dQc+F9hUwG
	 BAbybynpLO4OLBxaigf3DGQiuEonZrP1+qMhN2aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgHSJkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSJkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:40:40 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D803C206FA;
        Wed, 19 Aug 2020 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597830040;
        bh=zWlnnmPKekpNj9Y7nF8x2xH0z5eGvfiJTnebm6MK6iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1Ozp2FMCiu1nGYJ0WKQtL9pUQLIznu7r34psjTtEfcJa6NbQFH0nrK4XvfeDqivJ
         9CCVmcn1TzRIBgLeNS24FrB5zlUZ1KMQKfkKiRFmvkIQyPIz7v+OzhSEP0YBY5v/2a
         L8q02eB904x3nL8639fpF5sQY9wieu352DVPKO+A=
Date:   Wed, 19 Aug 2020 12:40:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ceph: Delete features that are not used in the kernel
Message-ID: <20200819094037.GT7555@unreal>
References: <20200819075747.917595-1-leon@kernel.org>
 <CAOi1vP-54DybxncMy0tyyy62nsgvQEn0DysbOTpmk_tnxnbv-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP-54DybxncMy0tyyy62nsgvQEn0DysbOTpmk_tnxnbv-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:47:38AM +0200, Ilya Dryomov wrote:
> On Wed, Aug 19, 2020 at 9:57 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > The ceph_features.h has declaration of features that are not in-use
> > in kernel code. This causes to seeing such compilation warnings in
> > almost every kernel compilation.
> >
> > ./include/linux/ceph/ceph_features.h:14:24: warning: 'CEPH_FEATURE_UID' defined but not used [-Wunused-const-variable=]
> >    14 |  static const uint64_t CEPH_FEATURE_##name = (1ULL<<bit);  \
> >       |                        ^~~~~~~~~~~~~
> > ./include/linux/ceph/ceph_features.h:75:1: note: in expansion of macro 'DEFINE_CEPH_FEATURE'
> >    75 | DEFINE_CEPH_FEATURE( 0, 1, UID)
> >       | ^~~~~~~~~~~~~~~~~~~
> >
> > The upstream kernel indeed doesn't have any use of them, so delete it.
> >
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > I'm sending this as RFC because probably the patch is wrong, but I
> > would like to bring your attention to the existing problem and asking
> > for an acceptable solution.
>
> Hi Leon,
>
> Yes, removing unused feature definitions is wrong.  Annotating them
> as potentially unused would be much better -- I'll send a patch.
>
> I don't think any of us builds with W=1, so these things don't get
> noticed.

Thanks, W=1 is our default compilation level for Mellanox RDMA submissions.

>
> Thanks,
>
>                 Ilya
