Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B7BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE242078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ewJyWfwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHMHdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMHdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:33:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE3C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n009f/kUZMBxeE9pa5fT61XhvAWtOw5mBgdxS83PReo=; b=ewJyWfwnC0ik8H5uYBiEUgc8qw
        K63WWJCeQW4URaGKnP3bJMPhOeNmCl2r9HBvMuBF5dnPSDi8IguASNmb9WnUMfX35v7tUdKgFGFCW
        Dtj3+9pGtaUNV1A0c9hR3AuKvEvmwPsTGz7CdUiiK72F1NKLNVYLne0AFgg3IxB84iFmDaBPPqdCN
        98A2cAaqK05f0BcTc/VKFvGqXMkJDnpSnL0u8/j7l7/KKtWqcE/WeKXf9jtab+8IXs8AoM2QX86Rw
        M7XZhcIHa7215LpMf+9bwNqMSJV4NC2heYZc0INb8N2zFJgS3OXmU9ZX71SIlSr+dz2hYCatmYO7x
        NvJ0/4jQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k67k1-0004FT-VS; Thu, 13 Aug 2020 07:33:38 +0000
Date:   Thu, 13 Aug 2020 08:33:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <20200813073337.GA16160@infradead.org>
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-3-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811094447.31208-3-roger.pau@citrix.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:44:47AM +0200, Roger Pau Monne wrote:
> If enabled (because ZONE_DEVICE is supported) the usage of the new
> functionality untangles Xen balloon and RAM hotplug from the usage of
> unpopulated physical memory ranges to map foreign pages, which is the
> correct thing to do in order to avoid mappings of foreign pages depend
> on memory hotplug.

So please just select ZONE_DEVICE if this is so much better rather
than maintaining two variants.
