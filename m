Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D59C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5930D21548
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgF0LpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:45:20 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46952 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0LpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 07:45:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D88E9626F1CF;
        Sat, 27 Jun 2020 13:45:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nyKl7qGuVRZM; Sat, 27 Jun 2020 13:45:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5BD9C626F1B7;
        Sat, 27 Jun 2020 13:45:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZTYWiHUKOkTX; Sat, 27 Jun 2020 13:45:16 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 32B0D626F1AB;
        Sat, 27 Jun 2020 13:45:16 +0200 (CEST)
Date:   Sat, 27 Jun 2020 13:45:16 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, sumit.semwal@linaro.org,
        robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de,
        dan.carpenter@oracle.com
Message-ID: <1669515915.65540.1593258316061.JavaMail.zimbra@nod.at>
Subject: Passing NULL dev to dma_alloc_coherent() allowed or not?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: 13sQTWOYZsCUQyAkPRAVyk7WekFvGA==
Thread-Topic: Passing NULL dev to dma_alloc_coherent() allowed or not?
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While porting on an old out-of-tree driver I noticed that dma_alloc_coherent()
was used with dev being NULL.

commit 148a97d5a02a62f81b5d6176f871c94a65e1f3af
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Wed Apr 24 17:24:37 2019 +0300

    dma-mapping: remove an unnecessary NULL check
    
    We already dereferenced "dev" when we called get_dma_ops() so this NULL
    check is too late.  We're not supposed to pass NULL "dev" pointers to
    dma_alloc_attrs().
    
    Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
    Signed-off-by: Christoph Hellwig <hch@lst.de>

says that dma_alloc_attrs() with dev being NULL is not allowed, but in
include/linux/dma-mapping.h we have:

static inline void *dma_alloc_coherent(struct device *dev, size_t size,
                dma_addr_t *dma_handle, gfp_t gfp)
{

        return dma_alloc_attrs(dev, size, dma_handle, gfp,
                        (gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
}

In Linus' tree I see at least three callers of dma_alloc_coherent() with a NULL device.
drivers/staging/emxx_udc/emxx_udc.c:2596:                       ep->virt_buf = dma_alloc_coherent(NULL, PAGE_SIZE,
drivers/tty/synclink.c:3667:            info->buffer_list = dma_alloc_coherent(NULL, BUFFERLISTSIZE, &info->buffer_list_dma_addr, GFP_KERNEL);
drivers/tty/synclink.c:3777:                    BufferList[i].virt_addr = dma_alloc_coherent(NULL, DMABUFFERSIZE, &BufferList[i].dma_addr, GFP_KERNEL);

I think these callers are wrong.
Can you please clarify?

Thanks,
//richard
