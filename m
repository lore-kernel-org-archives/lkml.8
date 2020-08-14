Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56263C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264B120639
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R3lBnAZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgHNH30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgHNH3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 03:29:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BECC061757
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AfrMrkrA2HZxTkg5Cv0NWjTzaYh5Z28RiUGGto0tVJU=; b=R3lBnAZpajlKS+ZYCmzCTpzXZE
        WGskKYnrQlnWOI08brF1QFByRNy9vewCqurBe8Sf7S6fS7hkYLfKSbxupKlE9RPQT9NbuzcWIwtfe
        +5b6TguaGGXn5Lcg34eWFhwMbYdHtbmQAHk8+UgjKsuOR5zYxZthbEqKTZgd7Q+IXKUIaTDTTy6hi
        EKm9u0BgGFiEAtjVzo/4P5mO2SjqiAw7Pb8SEMSUEqUKekpbo6VERpfF1Eai1/PwpiNTcC7tdq8M2
        5DDK5kk5wuflH/Kkdc/b25Aln3IQ3Kt2ErsOFEzjpFNp7ioD/PZIfZc2H1Ob+lJhV/YbogoRFnlP0
        SXuEMMGw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6U9Q-0001lh-7m; Fri, 14 Aug 2020 07:29:20 +0000
Date:   Fri, 14 Aug 2020 08:29:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Roger Pau Monn?? <roger.pau@citrix.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, Wei Liu <wl@xen.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 2/2] xen: add helpers to allocate unpopulated memory
Message-ID: <20200814072920.GA6126@infradead.org>
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-3-roger.pau@citrix.com>
 <20200813073337.GA16160@infradead.org>
 <20200813075420.GC975@Air-de-Roger>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813075420.GC975@Air-de-Roger>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 09:54:20AM +0200, Roger Pau Monn?? wrote:
> On Thu, Aug 13, 2020 at 08:33:37AM +0100, Christoph Hellwig wrote:
> > On Tue, Aug 11, 2020 at 11:44:47AM +0200, Roger Pau Monne wrote:
> > > If enabled (because ZONE_DEVICE is supported) the usage of the new
> > > functionality untangles Xen balloon and RAM hotplug from the usage of
> > > unpopulated physical memory ranges to map foreign pages, which is the
> > > correct thing to do in order to avoid mappings of foreign pages depend
> > > on memory hotplug.
> > 
> > So please just select ZONE_DEVICE if this is so much better rather
> > than maintaining two variants.
> 
> We still need to other variant for Arm at least, so both need to be
> maintained anyway, even if we force ZONE_DEVICE on x86.

Well, it still really helps reproducability if you stick to one
implementation of x86.

The alternative would be an explicit config option to opt into it,
but just getting a different implementation based on a random
kernel option is strange.
