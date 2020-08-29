Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9373C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4262065F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ftjdZj/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgH2Vfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgH2Vfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:35:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F116DC061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:35:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 10so1258864plg.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7RdUXdVmt/kFej4uMUfuaGRxBv1nxHHUFVIXbTbxnPM=;
        b=ftjdZj/k/Of6WUvRCxHiFf6vfjzRm8ExfOqx16987Wa8PkaUNf0yjzyp6tK8N60tsH
         Dov1PWIC2Yb097qDIUE0X1yoovuo7E2ByKUpiZjIfo0qHaqoEJA57u7WVipRrFujXs5g
         QzyzDEombgWnY8WTaLJPdhQAWFQZ/GRgM3BOmR0l7Yp1dTV3wu2DUj4c1fivaGW8r80D
         ycG5fZz4BZ4129slIxXieuqX0R0BE3t+meIGTxNHOPOje7ivS06FUo0f66K1ZWliiv6o
         IoW8yWJm1dGvYwJLBC0JSBHiMNIptzKB1h7TWY+dxB9fkIpEcnnZR4eoklKHcmuFnbQv
         skHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7RdUXdVmt/kFej4uMUfuaGRxBv1nxHHUFVIXbTbxnPM=;
        b=dKlsuJ2kAaij1AahQu+GWno4SDrBJRYOAb+olTgrMcJD/2pg8Xu+yh9gWpbhvMur/M
         wVTL0ZrqF1E6L3bqA0QsZoyrqej1hp+AA4tDFBMdC8xxQLqsaGXVTCblDBE5+qROepxc
         OyO18fQHq4wzTd5qW7t2NEQ1W9mZRIcxUi/LviP+4pZsrHvTmzVx1qkSrNutys4vXe5o
         4K6UMFuOKjlS2AMSNRenoq3DPBcA6cZP5NoCM8mMf1DMIR1Zk2x4DczgIqwECWOBQKjU
         eItK+2a9OtLJBBPhIneRpqiHPE+Wsno4QGYmZK2t5wY2qQ1v2uHbtJx64bIHTkF64ylg
         22Jg==
X-Gm-Message-State: AOAM5328Y6cV+AOjD3Swz6lRtBqVepmVV4QKtgbJ9KhtgIg6zPZT0vzK
        FkvUO9d/N0CHSON8Mlh/Ea/6KiIVrzEHnQ==
X-Google-Smtp-Source: ABdhPJwbxPdoak/KUgM03+6hVAODi766DigG24kMbD3fvojoy18UfdpbwcqyvrsYz+Yqaud7EgzBvQ==
X-Received: by 2002:a17:90a:5298:: with SMTP id w24mr4075606pjh.221.1598736939198;
        Sat, 29 Aug 2020 14:35:39 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id 143sm3599126pfc.66.2020.08.29.14.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 14:35:38 -0700 (PDT)
Date:   Sat, 29 Aug 2020 14:35:37 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Exner <dex@dragonslave.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        crazy@frugalware.org
Subject: Re: Kernel 5.9-rc Regression: Boot failure with nvme
In-Reply-To: <20200829175735.GA16416@lst.de>
Message-ID: <alpine.DEB.2.23.453.2008291431360.3955211@chino.kir.corp.google.com>
References: <f7328aad-ce1d-dd3f-577b-20b3d2efbabc@dragonslave.de> <CAHk-=whuO3U90x_i6nq+xmVymwqcc=kkb5=gv4vyLScQn7ZwBw@mail.gmail.com> <20200829175735.GA16416@lst.de>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Aug 2020, Christoph Hellwig wrote:

> > Just adding Christoph to the participants list, since at a guess it's
> > due to his changes whether they came from the nvme side or the dma
> > side..
> > 
> > Christoph?
> 
> This kinda looks like the sqsize regression we had in earlier 5.9-rc,
> but that should have been fixed in -rc2 with
> 
> 7442ddcedc344b6fa073692f165dffdd1889e780
> Author: John Garry <john.garry@huawei.com>
> Date:   Fri Aug 14 23:34:25 2020 +0800
> 
>     nvme-pci: Use u32 for nvme_dev.q_depth and nvme_queue.q_depth
> 
> Daniel, can you double check that you don't have that commit?
> 

Looks like Daniel has confirmed that this indeed does fix his issue -- 
great!

Christoph, re the plan to backport the atomic DMA pool support to 5.4 LTS 
for the purposes of fixing the AMD SEV allocation issues, I've composed 
the following list:

e860c299ac0d dma-remap: separate DMA atomic pools from direct remap code
c84dc6e68a1d dma-pool: add additional coherent pools to map to gfp mask
54adadf9b085 dma-pool: dynamically expanding atomic pools
76a19940bd62 dma-direct: atomic allocations must come from atomic coherent pools
2edc5bb3c5cc dma-pool: add pool sizes to debugfs
1d659236fb43 dma-pool: scale the default DMA coherent pool size with memory capacity
3ee06a6d532f dma-pool: fix too large DMA pools on medium memory size systems
dbed452a078d dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL
** 633d5fce78a6 dma-direct: always align allocation size in dma_direct_alloc_pages()
** 96a539fa3bb7 dma-direct: re-encrypt memory if dma_direct_alloc_pages() fails
** 56fccf21d196 dma-direct: check return value when encrypting or decrypting memory
** 1a2b3357e860 dma-direct: add missing set_memory_decrypted() for coherent mapping
d07ae4c48690 dma-mapping: DMA_COHERENT_POOL should select GENERIC_ALLOCATOR
71cdec4fab76 dma-mapping: warn when coherent pool is depleted
567f6a6eba0c dma-direct: provide function to check physical memory area validity
23e469be6239 dma-pool: get rid of dma_in_atomic_pool()
48b6703858dd dma-pool: introduce dma_guess_pool()
81e9d894e03f dma-pool: make sure atomic pool suits device
d9765e41d8e9 dma-pool: do not allocate pool memory from CMA
9420139f516d dma-pool: fix coherent pool allocations for IOMMU mappings
d7e673ec2c8e dma-pool: Only allocate from CMA when in same memory zone

 [ The commits prefixed with ** are not absolutely required for atomic DMA
   but rather fix other issues with SEV in the DMA layer that I found 
   along the way.  They are likely deserving of their own stable 
   backports, but added them here because it's probably best to backport 
   in order to minimize conflicts.  We'll simply make a note of that in 
   the cover letter for the stable backport series. ]

Do you know of any others to add?  NVMe specific fixes, perhaps John 
Garry's fix above, Intel IOMMU fixes maybe?
