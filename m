Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD32C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F51206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XcF7e2eY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405581AbgFXSLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:11:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9403 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405002AbgFXSLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:11:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef397090001>; Wed, 24 Jun 2020 11:10:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Jun 2020 11:11:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Jun 2020 11:11:04 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jun
 2020 18:10:55 +0000
Subject: Re: [RESEND PATCH 2/3] nouveau: fix mixed normal and device private
 page migration
To:     Christoph Hellwig <hch@lst.de>
CC:     <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20200622233854.10889-1-rcampbell@nvidia.com>
 <20200622233854.10889-3-rcampbell@nvidia.com> <20200624072355.GB18609@lst.de>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <330f6a82-d01d-db97-1dec-69346f41e707@nvidia.com>
Date:   Wed, 24 Jun 2020 11:10:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200624072355.GB18609@lst.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593022218; bh=v8AB7qsvs43N+0jRYQSXO+VJlE9cLuPEgWDCbTOxaBo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XcF7e2eY9wqoGbIb+q0hlnCZ/aWuEywTrNd+N4L4Essfz340HGSxkpc1ljpr1gpus
         TYusA4foHTlYUOOM+r3sBtmdh2VuFUmY7hnTMDJNrmr3mnqALg8aLc8pJyTq45agq8
         5QrKwM8xhvnHbGxx04z9MkU7Xn4z3SXmz1aaJE1z32/i9rO2QKJIrORoCdYqlGH+lH
         cHqn3pJe9GeBfSvOF90XWpUVGlpbDnaH4+a3Q5X7ERDb+ifB4Uj4MvTfp+c7qr+iHg
         etCGbdCdeUxoxmbOhGldwfksGpVUYMYARU3/e4z3Pxsj0lPCf7h/FKIjwmB9rzxKSj
         Pz9HFIyT0NVzQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/24/20 12:23 AM, Christoph Hellwig wrote:
> On Mon, Jun 22, 2020 at 04:38:53PM -0700, Ralph Campbell wrote:
>> The OpenCL function clEnqueueSVMMigrateMem(), without any flags, will
>> migrate memory in the given address range to device private memory. The
>> source pages might already have been migrated to device private memory.
>> In that case, the source struct page is not checked to see if it is
>> a device private page and incorrectly computes the GPU's physical
>> address of local memory leading to data corruption.
>> Fix this by checking the source struct page and computing the correct
>> physical address.
> 
> I'm really worried about all this delicate code to fix the mixed
> ranges.  Can't we make it clear at the migrate_vma_* level if we want
> to migrate from or two device private memory, and then skip all the work
> for regions of memory that already are in the right place?  This might be
> a little more work initially, but I think it leads to a much better
> API.
> 

The current code does encode the direction with src_owner != NULL meaning
device private to system memory and src_owner == NULL meaning system
memory to device private memory. This patch would obviously defeat that
so perhaps a flag could be added to the struct migrate_vma to indicate the
direction but I'm unclear how that makes things less delicate.
Can you expand on what you are worried about?

The issue with invalidations might be better addressed by letting the device
driver handle device private page TLB invalidations when migrating to
system memory and changing migrate_vma_setup() to only invalidate CPU
TLB entries for normal pages being migrated to device private memory.
If a page isn't migrating, it seems inefficient to invalidate those TLB
entries.

Any other suggestions?
