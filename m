Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B157C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4114A20789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k1ee41sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406827AbgFYRbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404993AbgFYRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:31:46 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5500C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:31:45 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p7so3184453qvl.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=itEeZ1F/lzuGzui0eFbAV1XPt3YLhZ3c66RORb7DwP8=;
        b=k1ee41sapeBv+Ec64wWauXUcVjlspfk/nCpFrSmyjqHWPbZOpen3DKVuzSLpEZhorb
         SNyCh4Wrg6Li7Mt/bqu1d93/TQSYUh3V84XlhBqp/w1zTZahN5ITFnxgUvcpC9F0KKsL
         LJLFmCjXYwzNu7O8ELdzpKKbIPsGCZ1MYU32SbHbrX1nUnaAVkfpwwCoUiP4Y8xhI0RO
         JYs9DYZnyUXg8xBcNbdKvBllo8rf5989i+mk+UBsB5R9jOhaY+c5WTAbM23JoenxfNQt
         yR04iqXNABRySelA7WVrXzwrHeiPg4/kuV/aU7jWS6xs+3DNY2vJL+9oBZGwdHz29bOb
         VrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=itEeZ1F/lzuGzui0eFbAV1XPt3YLhZ3c66RORb7DwP8=;
        b=NSd6OrfvA3AUfbeprsLGAV55j0vxrb5M1XLRKdT7rNCshFXnQML83GzYKKfPLK8xp3
         vcIRi0T1s2CH/gE23ehcEi+h40woFfMYoQEMPcwvvwYtnMoRuIv1BqQlTUunUQeRMfGS
         lPyPcKMQWS2QcFMCntFu/F2f2Xb8Kaly3MSe1VcuG/LiKih2X3thjb9WjbfD1t5jK9Jb
         pTrH8K1MK5j3FJoj67xP7m5GIb27DcdcdBlsonUaUdmltI5n1kruYQUuADltqy2jiFh4
         cS8kLQg748m3ePcTrspMez6VeDe62jr0xgx8sD9aI06cPYPa024i09OUYp5qOEc2gwpN
         o7Ug==
X-Gm-Message-State: AOAM531C/OPggNKqG9sfKIM3fCSLq9TycsRIQKculppSHbzNqq9WzQO2
        WNbtMRvvbmTUt1QgvFhEsRhstw==
X-Google-Smtp-Source: ABdhPJzuxsX04dp6vqU3dYcnAf6eQ492YSoYAsmCgHr0gLh6r4gTcCO/Wqy1Q1zh7JC9jxZVWY0cXw==
X-Received: by 2002:ad4:4903:: with SMTP id bh3mr25904140qvb.17.1593106304974;
        Thu, 25 Jun 2020 10:31:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id e9sm1659289qtq.70.2020.06.25.10.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 10:31:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1joViy-00EGdW-2a; Thu, 25 Jun 2020 14:31:44 -0300
Date:   Thu, 25 Jun 2020 14:31:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [RESEND PATCH 2/3] nouveau: fix mixed normal and device private
 page migration
Message-ID: <20200625173144.GT6578@ziepe.ca>
References: <20200622233854.10889-1-rcampbell@nvidia.com>
 <20200622233854.10889-3-rcampbell@nvidia.com>
 <20200624072355.GB18609@lst.de>
 <330f6a82-d01d-db97-1dec-69346f41e707@nvidia.com>
 <a9aba057-3786-8204-f782-6e8f3c290b35@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9aba057-3786-8204-f782-6e8f3c290b35@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 10:25:38AM -0700, Ralph Campbell wrote:
> Making sure to include linux-mm and Bharata B Rao for IBM's
> use of migrate_vma*().
> 
> On 6/24/20 11:10 AM, Ralph Campbell wrote:
> > 
> > On 6/24/20 12:23 AM, Christoph Hellwig wrote:
> > > On Mon, Jun 22, 2020 at 04:38:53PM -0700, Ralph Campbell wrote:
> > > > The OpenCL function clEnqueueSVMMigrateMem(), without any flags, will
> > > > migrate memory in the given address range to device private memory. The
> > > > source pages might already have been migrated to device private memory.
> > > > In that case, the source struct page is not checked to see if it is
> > > > a device private page and incorrectly computes the GPU's physical
> > > > address of local memory leading to data corruption.
> > > > Fix this by checking the source struct page and computing the correct
> > > > physical address.
> > > 
> > > I'm really worried about all this delicate code to fix the mixed
> > > ranges.  Can't we make it clear at the migrate_vma_* level if we want
> > > to migrate from or two device private memory, and then skip all the work
> > > for regions of memory that already are in the right place?  This might be
> > > a little more work initially, but I think it leads to a much better
> > > API.
> > > 
> > 
> > The current code does encode the direction with src_owner != NULL meaning
> > device private to system memory and src_owner == NULL meaning system
> > memory to device private memory. This patch would obviously defeat that
> > so perhaps a flag could be added to the struct migrate_vma to indicate the
> > direction but I'm unclear how that makes things less delicate.
> > Can you expand on what you are worried about?
> > 
> > The issue with invalidations might be better addressed by letting the device
> > driver handle device private page TLB invalidations when migrating to
> > system memory and changing migrate_vma_setup() to only invalidate CPU
> > TLB entries for normal pages being migrated to device private memory.
> > If a page isn't migrating, it seems inefficient to invalidate those TLB
> > entries.
> > 
> > Any other suggestions?
> 
> After a night's sleep, I think this might work. What do others think?
> 
> 1) Add a new MMU_NOTIFY_MIGRATE enum to mmu_notifier_event.
> 
> 2) Change migrate_vma_collect() to use the new MMU_NOTIFY_MIGRATE event type.
>
> 3) Modify nouveau_svmm_invalidate_range_start() to simply return (no invalidations)
> for MMU_NOTIFY_MIGRATE mmu notifier callbacks.

Isn't it a bit of an assumption that migrate_vma_collect() is only
used by nouveau itself?

What if some other devices' device_private pages are being migrated?

Jason
