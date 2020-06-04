Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE34C433E4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24240206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aHfI3s4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgFDIN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgFDINU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:13:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D95CC03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IfinYWvBdTCCIaneu/iWkUgHWl2JfGtLuUEKRHK9Vk4=; b=aHfI3s4WLnLBft+Nady6ib4iGZ
        uFoN52/Xxc0nrWP7AIy7CcGExAT0vWzl2Aso3MNHXQVdS/19Rz25eI3ZI3fXBlQGPDDCddU3ukVcq
        9LVWCCuqXhjNrqMqXKlFK9E/AlaWsR+KnBoH2I1jbnEch509QKak3HJ8zbsLTcFHmAp0NxVtHL7zN
        iVGEF94kTcB9Q5gCXCPDR9GD2ddHv4G1q0fDGEp4ngGxUsABt9YxMEohAtBqIOAZZ7Hc+Azq/2CvN
        HsJfdsFPiyI8x4556NOrRUX+om8x4kaWsATcFNirIVgWwj5pDKKJcqfy1EM1t8wEWhc/AJAYykJRO
        KqLOir0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgkzz-0004pC-Sy; Thu, 04 Jun 2020 08:13:15 +0000
Date:   Thu, 4 Jun 2020 01:13:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Dave Airlie <airlied@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [git pull] drm for 5.8-rc1
Message-ID: <20200604081315.GA23276@infradead.org>
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200603201337.GA225528@ziepe.ca>
 <1d1ad025-e215-da23-5282-bbaf154fa979@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d1ad025-e215-da23-5282-bbaf154fa979@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 10:10:21AM +0200, Christian König wrote:
> Dave and Daniel explicitly said they want to have this and it is ok as long
> as I open code it in the driver and keep it AMD internal.

But it fundamentally is broken, and we've been through all the arguments
why it is broken,  and it is not going to be any less broken because
someone said they want this.

I have to say I'm really pissed that you guys just sneaked it in.  I've
been hoping that graphics is getting a litter better, but this attitud
of we sneak hacks into the driver code that just happen to work on some
platform you care about instead because you're too lazy to do the proper
thing has top stop right now.  drm has been creating so much more
maintainaince nightmares and buggy code than any other subsysem just
because of that attitude.
