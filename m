Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6A2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E773205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lDzKO+Sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFBMKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgFBMKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:10:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC15C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WrfBjwiOrb7PjgUKlk477CgtnlYtSsCH84CvLpw+afU=; b=lDzKO+Sh+UZJj8+9PI6Pu2BERT
        z/aFznFzLY9dLtBPIFUHqqwjs3a5y3QdegtAe9Dfdox7nruONlQhuLoUX7u3Gnhi7GNNM/o2RWwQW
        7pmVkjaIDxtYhVJTML8MPYs0Diz0ZXBmX1+ds9025TB9C/Z2V7h2hPEDk8hm6v/IXYftGF4VtZJUe
        inTxL8CXe6mm0aKEWwrWvKNHk5GaitvYFNGpGxiCkXZ7pAbMnU8CpsWUmV1NwXwrqn6TSY91mT26z
        v2cmwBfJJpIGrladitzuEoqkXlq+iKFA8pbIJtg+nO6SEWiuHSRpjOZ6pFI50Rfv+0uNjIErxVRD7
        NIUx9GIg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jg5kZ-0001oq-Dj; Tue, 02 Jun 2020 12:10:35 +0000
Date:   Tue, 2 Jun 2020 05:10:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        khlebnikov@yandex-team.ru, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: kobject_init_and_add is easy to misuse
Message-ID: <20200602121035.GL19604@bombadil.infradead.org>
References: <20200602115033.1054-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602115033.1054-1-wanghai38@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 07:50:33PM +0800, Wang Hai wrote:
> syzkaller reports for memory leak when kobject_init_and_add()
> returns an error in the function sysfs_slab_add() [1]
> 
> When this happened, the function kobject_put() is not called for the
> corresponding kobject, which potentially leads to memory leak.
> 
> This patch fixes the issue by calling kobject_put() even if
> kobject_init_and_add() fails.

I think this speaks to a deeper problem with kobject_init_and_add()
-- the need to call kobject_put() if it fails is not readily apparent
to most users.  This same bug appears in the first three users of
kobject_init_and_add() that I checked --
arch/ia64/kernel/topology.c
drivers/firmware/dmi-sysfs.c
drivers/firmware/efi/esrt.c
drivers/scsi/iscsi_boot_sysfs.c

Some do get it right --
arch/powerpc/kernel/cacheinfo.c
drivers/gpu/drm/ttm/ttm_bo.c
drivers/gpu/drm/ttm/ttm_memory.c
drivers/infiniband/hw/mlx4/sysfs.c

I'd argue that the current behaviour is wrong, that kobject_init_and_add()
should call kobject_put() if the add fails.  This would need a tree-wide
audit.  But somebody needs to do that anyway because based on my random
sampling, half of the users currently get it wrong.
