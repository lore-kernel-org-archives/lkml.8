Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180C7C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25322077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFvzH70p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgAJPLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:11:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58951 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727855AbgAJPLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578669059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltOkanThXPeot2TPJmTHUMaFNfpDV2RzAlhTkMJQWGk=;
        b=BFvzH70pbEpA50xLW5ch8uq89Mwtj4n4ui14k2sVdUEkQobnWHScUcpUwhQ5qiwysOd1Kr
        l7BNMo1qlcFCvuvxoAHVfafEnDhGV6TWnpahPksCFAe9OoRk6hWCCiHlrr5SzGimwkHDIc
        HUAi0ru15HDv7VcwBZbP24yxuyxA8ws=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-rPdgxf6eMdWnnARiK5k7cQ-1; Fri, 10 Jan 2020 10:10:56 -0500
X-MC-Unique: rPdgxf6eMdWnnARiK5k7cQ-1
Received: by mail-qv1-f69.google.com with SMTP id j10so1347719qvi.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 07:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ltOkanThXPeot2TPJmTHUMaFNfpDV2RzAlhTkMJQWGk=;
        b=sQn/fKXYxCzxWxvlVdi3FeLQz3bzhlYeDd+N0/0a8T7wn+G7Jb5Lcx0VhdQYp1iklD
         92dWYLd6lH8OTX5bSWBiHrjnuCWK3zqxqHD1zM7floZ5RSJ/L2Svg/e2c7jC/8vKUjjU
         eh2mXg/KTUToTnz0IVqkLVhdh77MMrcv89Jw53KclAsJ3YYuzkPcRL5yj+mqFJ3B/gZX
         4kW3U2mSjclFqpvbGWkb9EbEZcfR8hVchpOxcO4sGYmeueyww6xaML4XxShyFtRWwyVB
         /uSMGkPgtjvD+mvLepHmdifZSueEs626PmNti5zewcjmVXh7v6M9PZR13JLWZ/1ppSaG
         +H8Q==
X-Gm-Message-State: APjAAAVkZDl+EKPEZhSH2OCOndrED/2kx5RHDns2DrRvI2uh7FNia7Lt
        P2zYChPhfMJyLnwm4obCM/6PzKd0YIaHhgLQrXqRrsLy0BpiyiLtDOvzLyvvGrrSIBhtL9TGuvI
        AJ3GNx+1xZYbEnbMWxuP0e9KJ
X-Received: by 2002:aed:2bc2:: with SMTP id e60mr2811132qtd.115.1578669056117;
        Fri, 10 Jan 2020 07:10:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwz1r1ONGXTup5Yq+eOHuTwVk4LBOmjj/SDXS4nm/iC9Ca6WSmY4fOOxfZebKAczT+NKktz5g==
X-Received: by 2002:aed:2bc2:: with SMTP id e60mr2811109qtd.115.1578669055902;
        Fri, 10 Jan 2020 07:10:55 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id m5sm1118351qtq.6.2020.01.10.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 07:10:55 -0800 (PST)
Date:   Fri, 10 Jan 2020 10:10:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
Message-ID: <20200110151053.GB53397@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109105443-mutt-send-email-mst@kernel.org>
 <20200109161742.GC15671@xz-x1>
 <20200109113001-mutt-send-email-mst@kernel.org>
 <20200109170849.GB36997@xz-x1>
 <20200109133434-mutt-send-email-mst@kernel.org>
 <20200109193949.GG36997@xz-x1>
 <20200109172718-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109172718-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 05:28:36PM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2020 at 02:39:49PM -0500, Peter Xu wrote:
> > On Thu, Jan 09, 2020 at 02:08:52PM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Jan 09, 2020 at 12:08:49PM -0500, Peter Xu wrote:
> > > > On Thu, Jan 09, 2020 at 11:40:23AM -0500, Michael S. Tsirkin wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > > I know it's mostly relevant for huge VMs, but OTOH these
> > > > > > > probably use huge pages.
> > > > > > 
> > > > > > Yes huge VMs could benefit more, especially if the dirty rate is not
> > > > > > that high, I believe.  Though, could you elaborate on why huge pages
> > > > > > are special here?
> > > > > > 
> > > > > > Thanks,
> > > > > 
> > > > > With hugetlbfs there are less bits to test: e.g. with 2M pages a single
> > > > > bit set marks 512 pages as dirty.  We do not take advantage of this
> > > > > but it looks like a rather obvious optimization.
> > > > 
> > > > Right, but isn't that the trade-off between granularity of dirty
> > > > tracking and how easy it is to collect the dirty bits?  Say, it'll be
> > > > merely impossible to migrate 1G-huge-page-backed guests if we track
> > > > dirty bits using huge page granularity, since each touch of guest
> > > > memory will cause another 1G memory to be transferred even if most of
> > > > the content is the same.  2M can be somewhere in the middle, but still
> > > > the same write amplify issue exists.
> > > >
> > > 
> > > OK I see I'm unclear.
> > > 
> > > IIUC at the moment KVM never uses huge pages if any part of the huge page is
> > > tracked.
> > 
> > To be more precise - I think it's per-memslot.  Say, if the memslot is
> > dirty tracked, then no huge page on the host on that memslot (even if
> > guest used huge page over that).
> 
> Yea ... so does it make sense to make this implementation detail
> leak through UAPI?

I think that's not a leak of internal implementation detail, we just
define the interface as that the address for each kvm_dirty_gfn is
always host page aligned (by default it means no huge page) and point
to a single host page, that's all.  Host page size is always there for
userspace after all so imho it's fine.  Thanks,

-- 
Peter Xu

