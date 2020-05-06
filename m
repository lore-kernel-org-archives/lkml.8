Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2541C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DF5206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CDYYUXVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgEFQS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729521AbgEFQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:18:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D5C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:18:26 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id q13so1849508qtp.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dI/8k01wqNtPsEMN3JryPuexKMUAM9GFAPsiKlMJOgs=;
        b=CDYYUXVytFKURB46DxLbtSQhLKEUVHOamKg4N6ws/VeYuZqe48aW2fVU4DY/h9Bp0C
         oxPsar9OJVyyfKYewl2b61UAK/iYMJhUOEztf6FyAWUPWMHx6K52Ms3zjFawc0T82Nl1
         7Xt+P1aPijxMvudfHiyJNFg5C9ZFGxb7Xq5W8dbwJ21FJwxC/q1Blc/Rw7qi4EBtZ7QU
         QsgB9ERVVjUURncAAw80TIEnHnDpJ9Brzd9+PloSZTbvOPoos60r/CIiiaGLTHr18jlp
         z1hKejvJ2XMgEhTqjmxxET3DODSbvUQWlTA4t/TK35N6seBmGymATrWanur938yEOAM8
         A/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dI/8k01wqNtPsEMN3JryPuexKMUAM9GFAPsiKlMJOgs=;
        b=DIRayEjvVcxXyOLbZixl7+FMNDesJqUGKGNZTcwzy3F9wkwz9Yo0CLw9aAIoKo311H
         ZDaMmaYWBN2+CGI9AxcTZ7dVvTjeq7isU72Mb3posRW9YGmKh610c4LBZw3QIOFM0qJY
         HHQnvVBBb9utTyfPjHBmepGErx9fA81MiAQ1V88ewkg9yDKXi5szvTUsDpWntAkHr6sj
         +c8X3rZpSbFTFE4rPvTZiXz7YFZQIqFvXcbDPEStceCB3unS0NBAMaNHOaym1SEpLyqn
         JZ9BNuJibyIOHIKOwkO0diMzxJI1fc1LCYQROBSfOYe9edd/SSbLSO4mChQkAEHaxE8a
         SdNQ==
X-Gm-Message-State: AGi0PuaVXOVZaeFyIKGfRiNg4nref4gUerdkXPy3LfeWbf41Ti6XHpXC
        wC/Lcd0DPnxVgEaInv9NGCUfKA==
X-Google-Smtp-Source: APiQypKyDRDNEzprm+gsfACpH0aQyfocl+/L2XhuNJKEuZItD8tyLPJ84MVvdGkrVM9/6D8550tNkg==
X-Received: by 2002:aed:2e83:: with SMTP id k3mr9101168qtd.2.1588781906015;
        Wed, 06 May 2020 09:18:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h13sm1895261qti.32.2020.05.06.09.18.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 09:18:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWMka-0002ut-Lq; Wed, 06 May 2020 13:18:24 -0300
Date:   Wed, 6 May 2020 13:18:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH hmm v2 5/5] mm/hmm: remove the customizable pfn format
 from hmm_range_fault
Message-ID: <20200506161824.GG26002@ziepe.ca>
References: <5-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
 <3c06a94c-c17f-dc31-537e-f3f6e1ace9a2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c06a94c-c17f-dc31-537e-f3f6e1ace9a2@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 05:53:26PM -0700, Ralph Campbell wrote:
> > Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > Tested-by: Ralph Campbell <rcampbell@nvidia.com>
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >   Documentation/vm/hmm.rst                |  26 ++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  35 ++----
> >   drivers/gpu/drm/nouveau/nouveau_dmem.c  |  27 +---
> >   drivers/gpu/drm/nouveau/nouveau_dmem.h  |   3 +-
> >   drivers/gpu/drm/nouveau/nouveau_svm.c   |  87 ++++++++-----
> >   include/linux/hmm.h                     |  99 ++++++---------
> >   mm/hmm.c                                | 160 +++++++++++-------------
> >   7 files changed, 192 insertions(+), 245 deletions(-)
> > 
> 
> ...snip...
> 
> > +static void nouveau_hmm_convert_pfn(struct nouveau_drm *drm,
> > +				    struct hmm_range *range, u64 *ioctl_addr)
> > +{
> > +	unsigned long i, npages;
> > +
> > +	/*
> > +	 * The ioctl_addr prepared here is passed through nvif_object_ioctl()
> > +	 * to an eventual DMA map in something like gp100_vmm_pgt_pfn()
> > +	 *
> > +	 * This is all just encoding the internal hmm reprensetation into a
> 
> s/reprensetation/representation/
> 
> Looks good and still tests OK with nouveau.

Got it, thanks

Jason
