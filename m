Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BBAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA2B2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfFIRYhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGAUrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:47:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34065 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbgGAUrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593636458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MbiyraTJ4trv3FWb4qCBJhr5R70RrnDBw9rQbrUZ784=;
        b=VfFIRYhyN7UAlCmU4ycy3YjrdUnZaix3K83yEmCJ4yw+0MKL3BwuvHujojAeGw/KHJUYyy
        Y6SsKzUGNYq4BV0q2xfZCxCjGX4LJA3yWuprFF0sVrh4rQU/MTjyXc6+cmBsvv5uUMLYRf
        309S+3va0D9/K/zDx6wiFR3gKOdZ6+w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-HysxjhcjMOOVN17aKfk3VA-1; Wed, 01 Jul 2020 16:47:36 -0400
X-MC-Unique: HysxjhcjMOOVN17aKfk3VA-1
Received: by mail-wm1-f71.google.com with SMTP id o13so25176897wmh.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 13:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MbiyraTJ4trv3FWb4qCBJhr5R70RrnDBw9rQbrUZ784=;
        b=Gm1dPRrwCgoL9T10X6SbBKszogGlI46IpOFEzypGef6pQP96s7UbcCmHZxykr/IbKI
         8pVw+K5rU4BKDVte/jKO5OIoX4+VN5QH/zwNN69yr+aTAjME+O4ImfKnTX8DJsw6Cj2Z
         ww3mPvZdEk2WERDtKSOQFQ8QoSXe1Vfn1oeLe525vJ22II6fMVast+SSEs0jrQNUhQ81
         3KXqeY/EyBF90GTApvfZSqHmrbZVD5cKXFW2HPASfFYEbz/7rT3slmCf7u1YyJO3ehGa
         0Tahey7JxRTQNqqC1aQa4MWQ5iXBnGxw/n68xCk9aPPTGN/uRf8LpvkkuKgufzMm3vP0
         yGAA==
X-Gm-Message-State: AOAM5302EBlwxSdEMok5tqIYmi784S4rwN/2ZRUrRSacl7d99R5H1+vh
        Ta9P3NGZmEU0TTHewqj/RHgtD3vOpMVvHGr2d2uWFA41lCJ76oacMxIcEXno2/PzgQyPGawoKpB
        aVeejgGBfdCkYg3hQ0uyERwNu
X-Received: by 2002:adf:ed47:: with SMTP id u7mr30433374wro.201.1593636455515;
        Wed, 01 Jul 2020 13:47:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi4/QeFIvFvIhW8MFrahcm+NHf1Nr8du8L4WlMn+iG6s23576AuHveqgE2W9yZnAvkgrNyJg==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr30433344wro.201.1593636455219;
        Wed, 01 Jul 2020 13:47:35 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id h2sm8337653wrw.62.2020.07.01.13.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 13:47:32 -0700 (PDT)
Date:   Wed, 1 Jul 2020 16:47:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, jgross@suse.com,
        Peng Fan <peng.fan@nxp.com>, x86@kernel.org,
        konrad.wilk@oracle.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-imx@nxp.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200701164501-mutt-send-email-mst@kernel.org>
References: <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
 <20200701133456.GA23888@infradead.org>
 <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 10:34:53AM -0700, Stefano Stabellini wrote:
> On Wed, 1 Jul 2020, Christoph Hellwig wrote:
> > On Mon, Jun 29, 2020 at 04:46:09PM -0700, Stefano Stabellini wrote:
> > > > I could imagine some future Xen hosts setting a flag somewhere in the
> > > > platform capability saying "no xen specific flag, rely on
> > > > "VIRTIO_F_ACCESS_PLATFORM". Then you set that accordingly in QEMU.
> > > > How about that?
> > > 
> > > Yes, that would be fine and there is no problem implementing something
> > > like that when we get virtio support in Xen. Today there are still no
> > > virtio interfaces provided by Xen to ARM guests (no virtio-block/net,
> > > etc.)
> > > 
> > > In fact, in both cases we are discussing virtio is *not* provided by
> > > Xen; it is a firmware interface to something entirely different:
> > > 
> > > 1) virtio is used to talk to a remote AMP processor (RPMesg)
> > > 2) virtio is used to talk to a secure-world firmware/OS (Trusty)
> > >
> > > VIRTIO_F_ACCESS_PLATFORM is not set by Xen in these cases but by RPMesg
> > > and by Trusty respectively. I don't know if Trusty should or should not
> > > set VIRTIO_F_ACCESS_PLATFORM, but I think Linux should still work
> > > without issues.
> > > 
> > 
> > Any virtio implementation that is not in control of the memory map
> > (aka not the hypervisor) absolutely must set VIRTIO_F_ACCESS_PLATFORM,
> > else it is completely broken.
> 
> Lots of broken virtio implementations out there it would seem :-(

Not really, most of virtio implementations are in full control of
memory, being part of the hypervisor.

> 
> > > The xen_domain() check in Linux makes it so that vring_use_dma_api
> > > returns the opposite value on native Linux compared to Linux as Xen/ARM
> > > DomU by "accident". By "accident" because there is no architectural
> > > reason why Linux Xen/ARM DomU should behave differently compared to
> > > native Linux in this regard.
> > > 
> > > I hope that now it is clearer why I think the if (xen_domain()) check
> > > needs to be improved anyway, even if we fix generic dma_ops with virtio
> > > interfaces missing VIRTIO_F_ACCESS_PLATFORM.
> > 
> > IMHO that Xen quirk should never have been added in this form..
> 
> Would you be in favor of a more flexible check along the lines of the
> one proposed in the patch that started this thread:
> 
>     if (xen_vring_use_dma())
>             return true;
> 
> 
> xen_vring_use_dma would be implemented so that it returns true when
> xen_swiotlb is required and false otherwise.

I'll need to think about it. Sounds reasonable on the surface ...

-- 
MST

