Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F028C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E2220786
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npT9p+MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGIVtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgGIVtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 17:49:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09354C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 14:49:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn17so1698534pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hFr4sv4HqUSHsiMLFrScOT9Ngpz9Cto5b81cd6f0i7M=;
        b=npT9p+MKNUWXQYWnllvP0dSbLmAXzhuZ/YaLbF3/8MW4bc+uhAX1qaA89d9JVJxBR6
         PbUgRXSVwJZeFnp0E9X5JZoApnSJT0NfL23ffg22fwzr5sxzXEzHcL/uaMA6f5Ni2Acd
         zT37F2Hko+N8k9JdOa4Txvp0uVcibFkV+cndLptq13d8npFhI8UlM2fR2zoAjgawPoTi
         eTPoxLFxZ3n/VbBci5vXHlMUlSvVgr/66p04oUNOMaidVbaLVmcpnaoKHdWCcCCq+jkA
         qtaAbzyPWkqMl390vWaIOCRnfftDYD1rUZt8xxobcI7XIrplNI2Xvy5x6HaBo4NjhGMZ
         L3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hFr4sv4HqUSHsiMLFrScOT9Ngpz9Cto5b81cd6f0i7M=;
        b=oTf7dpwBLozWl4zIK/rw4Avic0ArhQrxJAH7cGLb65HaAcwJZf3qCt2VZCxDgz5aoj
         ptN9dJV5Kw7q//nSFKjVm5Vfq2aZTZuZaUuz3lRQtUu/vRcgrkuyu0OFuV/sVm1kEXcm
         fUueTeyfGXmLBVRz6Ze2/Xj5I6kJAfnrBG9UlB1TkwwYAQQLRNO1tNOKFZSApQuheLQF
         YyoJO34Nm9Jt05RObexrXkwWBnrkA85NdCA6n5fMjstS27d9c46Nl5JHT7KVZeNZf0lT
         eAhSbGkheyi14Z5+6jzWzt6O54fncGWsHoO6xhuQTsk9wjYjSyteYbMO9NlkCuEim2Z/
         gXBQ==
X-Gm-Message-State: AOAM533VwgPIyTLj4gQ8aM0uszYmv2leAcPheetd4JLJXfGoHFGNPRLw
        3dLzOBepe67RHmOs9o2v5QkHjw==
X-Google-Smtp-Source: ABdhPJxifzME9k8oQf7I8/PrwyXLawsOmZkDIwApjP8xedu3YYKr6okgkKrdw3W2Hz9t2cE8c+Pk6Q==
X-Received: by 2002:a17:90b:3c1:: with SMTP id go1mr2110948pjb.129.1594331378329;
        Thu, 09 Jul 2020 14:49:38 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id u74sm3454482pgc.58.2020.07.09.14.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:49:37 -0700 (PDT)
Date:   Thu, 9 Jul 2020 14:49:37 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
In-Reply-To: <20200708161010.GA30184@lst.de>
Message-ID: <alpine.DEB.2.23.453.2007091448550.972523@chino.kir.corp.google.com>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de> <20200708153509.GA26743@lst.de> <e81db35628a22a0d1635699d1e87bacde706ad25.camel@suse.de> <20200708161010.GA30184@lst.de>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020, Christoph Hellwig wrote:

> On Wed, Jul 08, 2020 at 06:00:35PM +0200, Nicolas Saenz Julienne wrote:
> > On Wed, 2020-07-08 at 17:35 +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 07, 2020 at 02:28:04PM +0200, Nicolas Saenz Julienne wrote:
> > > > When allocating atomic DMA memory for a device, the dma-pool core
> > > > queries __dma_direct_optimal_gfp_mask() to check which atomic pool to
> > > > use. It turns out the GFP flag returned is only an optimistic guess.
> > > > The pool selected might sometimes live in a zone higher than the
> > > > device's view of memory.
> > > > 
> > > > As there isn't a way to grantee a mapping between a device's DMA
> > > > constraints and correct GFP flags this unifies both DMA atomic pools.
> > > > The resulting pool is allocated in the lower DMA zone available, if any,
> > > > so as for devices to always get accessible memory while having the
> > > > flexibility of using dma_pool_kernel for the non constrained ones.
> > > > 
> > > > Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp
> > > > mask")
> > > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > 
> > > Hmm, this is not what I expected from the previous thread.  I thought
> > > we'd just use one dma pool based on runtime available of the zones..
> > 
> > I may be misunderstanding you, but isn't that going back to how things used to
> > be before pulling in David Rientjes' work? The benefit of having a GFP_KERNEL
> > pool is that non-address-constrained devices can get their atomic memory there,
> > instead of consuming somewhat scarcer low memory.
> 
> Yes, I think we are misunderstanding each other.  I don't want to remove
> any pool, just make better runtime decisions when to use them.
> 

Just to be extra explicit for the record and for my own understanding: 
Nicolas, your patch series "dma-pool: Fix atomic pool selection" obsoletes 
this patch, right? :)
