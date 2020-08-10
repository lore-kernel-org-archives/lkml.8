Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F7DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8CF2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyjP2GBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHJQ0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:26:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60742 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727808AbgHJQ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597076791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhM3TU3ArmSS3ocpeFlc4V6pw+dd29bNaZLcRGz0XY4=;
        b=GyjP2GBGdWSjYA4k+MEsPA310wMqMykLWrj90J9HsY4dYB6Zu3ZvXv0pCZCLPyRMJx7Ihz
        4CysgSa9d3kg7aGSm5+KFhwlj0PG5mro8q8jmCFow6KUO5AIag8GIPWsjAPnywasMMLqE4
        FyI3pHM7z41lcfVTSy49qRjMAXtjqhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-MI_8SZh9OceHQKbicklCkQ-1; Mon, 10 Aug 2020 12:26:29 -0400
X-MC-Unique: MI_8SZh9OceHQKbicklCkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BCA3E91A;
        Mon, 10 Aug 2020 16:26:28 +0000 (UTC)
Received: from gondolin (ovpn-112-218.ams2.redhat.com [10.36.112.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CCA85D9CD;
        Mon, 10 Aug 2020 16:26:24 +0000 (UTC)
Date:   Mon, 10 Aug 2020 18:26:21 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/type1: Add proper error unwind for
 vfio_iommu_replay()
Message-ID: <20200810182621.287f1689.cohuck@redhat.com>
In-Reply-To: <159683127474.1965.16929121291974112960.stgit@gimli.home>
References: <159683127474.1965.16929121291974112960.stgit@gimli.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020 14:14:48 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> The vfio_iommu_replay() function does not currently unwind on error,
> yet it does pin pages, perform IOMMU mapping, and modify the vfio_dma
> structure to indicate IOMMU mapping.  The IOMMU mappings are torn down
> when the domain is destroyed, but the other actions go on to cause
> trouble later.  For example, the iommu->domain_list can be empty if we
> only have a non-IOMMU backed mdev attached.  We don't currently check
> if the list is empty before getting the first entry in the list, which
> leads to a bogus domain pointer.  If a vfio_dma entry is erroneously
> marked as iommu_mapped, we'll attempt to use that bogus pointer to
> retrieve the existing physical page addresses.
> 
> This is the scenario that uncovered this issue, attempting to hot-add
> a vfio-pci device to a container with an existing mdev device and DMA
> mappings, one of which could not be pinned, causing a failure adding
> the new group to the existing container and setting the conditions
> for a subsequent attempt to explode.
> 
> To resolve this, we can first check if the domain_list is empty so
> that we can reject replay of a bogus domain, should we ever encounter
> this inconsistent state again in the future.  The real fix though is
> to add the necessary unwind support, which means cleaning up the
> current pinning if an IOMMU mapping fails, then walking back through
> the r-b tree of DMA entries, reading from the IOMMU which ranges are
> mapped, and unmapping and unpinning those ranges.  To be able to do
> this, we also defer marking the DMA entry as IOMMU mapped until all
> entries are processed, in order to allow the unwind to know the
> disposition of each entry.
> 
> Fixes: a54eb55045ae ("vfio iommu type1: Add support for mediated devices")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c |   71 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 5 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

