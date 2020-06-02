Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725ACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B37207D8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591106650;
	bh=5Bxzrru4Pb1u+SpPGmIbHIvhtZs/e62GqDODmBighQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l78CqbBJ1bwWAAsGVH3+kTlpwRVD4l0z8sNif05RREle9eyELhLpDVSMBcW8ZGFxB
	 rN7ha3IJmYrK4xFq5AZONX/Gmw1PRaCo5EPbD/LOeSqBM+4f3LwwxR56v2IU3+97yn
	 +w+/5H9YubXcZUd2lRIdpOdpFaLfczHPVvaLzK0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgFBOEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgFBOEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:04:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9F22074B;
        Tue,  2 Jun 2020 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591106647;
        bh=5Bxzrru4Pb1u+SpPGmIbHIvhtZs/e62GqDODmBighQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=07jfzjuY1I6kgihd31CPlafeKfxtbWqOo28rFCuEXtnbt1gXeldBNx/pvJIGnyD43
         p1upWaLE0jnZZquRFBN6IwxKr9l32PHeyRZDpISndr7LKUQ9FGFjwgGwRwtJBeUBJX
         RmiCjViV8am8lLB8oIa3PJ89VexmtLgvCWDc7rns=
Date:   Tue, 2 Jun 2020 16:04:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wang Hai <wanghai38@huawei.com>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: kobject_init_and_add is easy to misuse
Message-ID: <20200602140404.GA3280145@kroah.com>
References: <20200602115033.1054-1-wanghai38@huawei.com>
 <20200602121035.GL19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602121035.GL19604@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 05:10:35AM -0700, Matthew Wilcox wrote:
> On Tue, Jun 02, 2020 at 07:50:33PM +0800, Wang Hai wrote:
> > syzkaller reports for memory leak when kobject_init_and_add()
> > returns an error in the function sysfs_slab_add() [1]
> > 
> > When this happened, the function kobject_put() is not called for the
> > corresponding kobject, which potentially leads to memory leak.
> > 
> > This patch fixes the issue by calling kobject_put() even if
> > kobject_init_and_add() fails.
> 
> I think this speaks to a deeper problem with kobject_init_and_add()
> -- the need to call kobject_put() if it fails is not readily apparent
> to most users.  This same bug appears in the first three users of
> kobject_init_and_add() that I checked --
> arch/ia64/kernel/topology.c
> drivers/firmware/dmi-sysfs.c
> drivers/firmware/efi/esrt.c
> drivers/scsi/iscsi_boot_sysfs.c
> 
> Some do get it right --
> arch/powerpc/kernel/cacheinfo.c
> drivers/gpu/drm/ttm/ttm_bo.c
> drivers/gpu/drm/ttm/ttm_memory.c
> drivers/infiniband/hw/mlx4/sysfs.c

Why are random individual drivers calling kobject* functions?  That
speaks to a larger problem here...

Anyway, yes, it's a tricky function, but the issue usually is that the
kobject is embedded in something else and if you call init_and_add() you
want to tear things down _before_ the final put happens.

The good thing is, that function is really hard to get to fail except if
you abuse it with syzkaller :)

> I'd argue that the current behaviour is wrong, that kobject_init_and_add()
> should call kobject_put() if the add fails.  This would need a tree-wide
> audit.  But somebody needs to do that anyway because based on my random
> sampling, half of the users currently get it wrong.

As said above, this is "tricky", and might break things.

thanks,

greg k-h
