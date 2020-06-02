Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072D5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22552074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N1Ne1IWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgFBO5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFBO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:57:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5290DC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YkOeRP7ixrxUjRV41/evzXHhbGKPE5POCnQ7Px2to4s=; b=N1Ne1IWHT2VVZ68QfUBRERhVcC
        GLswuMI2i2LAwW8nAzxA8I1Yfb53j2eysHhgitbdFiHKsmzagBHgFrsiO2HfHvAaFEurQQcYhO7J4
        K0pSmAG5vkOn+0trmGxLRAx9miQYYaDKKLJBYkuge22VELS7MF8N2m/omJGQeQGSB+ucFnmnfKlSS
        QThqXz1xS/fjO17Vuqf81wJo3ukUeNgf8ZcH0i3SyfSZB29gBScvUktbi65QpirPDSKon8OrGN5nL
        HT6omhcISpUFqrdk73ah/c1H+Cvn4FX5cgJBGwualPA1OxmvLys7amsfwQMvDx1kM1qiP+04xPrG1
        9Gn5Z92g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jg8Lx-0005bR-AX; Tue, 02 Jun 2020 14:57:21 +0000
Date:   Tue, 2 Jun 2020 07:57:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wang Hai <wanghai38@huawei.com>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: kobject_init_and_add is easy to misuse
Message-ID: <20200602145721.GM19604@bombadil.infradead.org>
References: <20200602115033.1054-1-wanghai38@huawei.com>
 <20200602121035.GL19604@bombadil.infradead.org>
 <20200602140404.GA3280145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602140404.GA3280145@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:04:04PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 02, 2020 at 05:10:35AM -0700, Matthew Wilcox wrote:
> > On Tue, Jun 02, 2020 at 07:50:33PM +0800, Wang Hai wrote:
> > > syzkaller reports for memory leak when kobject_init_and_add()
> > > returns an error in the function sysfs_slab_add() [1]
> > > 
> > > When this happened, the function kobject_put() is not called for the
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
> 
> Why are random individual drivers calling kobject* functions?  That
> speaks to a larger problem here...

There's around 120 callers in the kernel today ... large, indeed.

> Anyway, yes, it's a tricky function, but the issue usually is that the
> kobject is embedded in something else and if you call init_and_add() you
> want to tear things down _before_ the final put happens.
> 
> The good thing is, that function is really hard to get to fail except if
> you abuse it with syzkaller :)

Yes ;-)

> > I'd argue that the current behaviour is wrong, that kobject_init_and_add()
> > should call kobject_put() if the add fails.  This would need a tree-wide
> > audit.  But somebody needs to do that anyway because based on my random
> > sampling, half of the users currently get it wrong.
> 
> As said above, this is "tricky", and might break things.

My audit may not be correct then.  The kobject_put() may be appropriately
being called at a higher level rather than in the same function as the
kobject_init_and_add().
