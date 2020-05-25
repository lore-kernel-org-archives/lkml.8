Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE204C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817872073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuCC54AT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391047AbgEYPLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:11:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21207 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390998AbgEYPLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590419508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mpYWtKyRgORiVGPfs1mMYQZAQgnaA9yUkeL6coUBH0=;
        b=WuCC54ATOIHN21rZB4BaKG/Bp5ZNMBT5LZDbbYhQwgA6j+wD1LXQRqfrgS/pCuB+3lLs4k
        pTwExkxCdkCBLkIm9EgSt7WdVWScS8kEoY+Csm3+gAdcluGsVhdX7/T7whxJ+0y9n5i0yl
        DdvdT1dSoGdnSLtpNcOmmiZgeL24mAE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-YeQcFF8wNpG0aAjtHkXCbQ-1; Mon, 25 May 2020 11:11:45 -0400
X-MC-Unique: YeQcFF8wNpG0aAjtHkXCbQ-1
Received: by mail-qk1-f197.google.com with SMTP id d190so7407936qkc.20
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3mpYWtKyRgORiVGPfs1mMYQZAQgnaA9yUkeL6coUBH0=;
        b=lwjrkNo5CusnBtrJ7IET+XEe4p8bfWghvWUlngHKyOAT11lWdfgo54DlzRQ5iCPzi4
         1mzkHurIIEvCRsWio0Uxkr8msk/Xg6KY3Xif/kwVKiLbuBujMjjN+2Y1mlMHStO0Hoqc
         YIVgT301XenngTAa/9l3IMFp2cBGB7zBp4b0/e317imyUE40R9U+RZqnapp20DfIYbLT
         L24kxXoFReMAvkbloZdxSnxrIs575NLeWt8apKBZnTofy3UCri5BFMZ0VfC6LC+LLVYI
         4GoIzRiZdwC+Tz9XVSdM+Q5/iz1h+edCTYgfitVefKV2ZqZs5da2RbAOdqgc6QkOoRwN
         henQ==
X-Gm-Message-State: AOAM5309LsqTZwSwHY64vZaOKP2mcYeaZfWODMR4gMrFn4cWwu45U/2+
        kVKOjYKkVPrHfgcIl6nvvA9Bt6wCo3rEbkRi0juOEhRbGpK2G4jjeHD2CLVAV07jffDyrdm6Fih
        k2PEfDdtUn+sa3ErNSGEjOsaI
X-Received: by 2002:aed:3f55:: with SMTP id q21mr14841977qtf.190.1590419505320;
        Mon, 25 May 2020 08:11:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLGO9HFRMMZ35OmlO3lthVjqkN5BxWSbWB0HvGtGQ8EL2CepNgl+pRq3Vcru4K9iTjPXschA==
X-Received: by 2002:aed:3f55:: with SMTP id q21mr14841935qtf.190.1590419505005;
        Mon, 25 May 2020 08:11:45 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f14sm10796275qka.70.2020.05.25.08.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:11:44 -0700 (PDT)
Date:   Mon, 25 May 2020 11:11:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com, cai@lca.pw,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 3/3] vfio-pci: Invalidate mmaps and block MMIO access
 on disabled memory
Message-ID: <20200525151142.GE1058657@xz-x1>
References: <159017449210.18853.15037950701494323009.stgit@gimli.home>
 <159017506369.18853.17306023099999811263.stgit@gimli.home>
 <20200523193417.GI766834@xz-x1>
 <20200523170602.5eb09a66@x1.home>
 <20200523235257.GC939059@xz-x1>
 <20200525122607.GC744@ziepe.ca>
 <20200525142806.GC1058657@xz-x1>
 <20200525144651.GE744@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525144651.GE744@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:46:51AM -0300, Jason Gunthorpe wrote:
> On Mon, May 25, 2020 at 10:28:06AM -0400, Peter Xu wrote:
> > On Mon, May 25, 2020 at 09:26:07AM -0300, Jason Gunthorpe wrote:
> > > On Sat, May 23, 2020 at 07:52:57PM -0400, Peter Xu wrote:
> > > 
> > > > For what I understand now, IMHO we should still need all those handlings of
> > > > FAULT_FLAG_RETRY_NOWAIT like in the initial version.  E.g., IIUC KVM gup will
> > > > try with FOLL_NOWAIT when async is allowed, before the complete slow path.  I'm
> > > > not sure what would be the side effect of that if fault() blocked it.  E.g.,
> > > > the caller could be in an atomic context.
> > > 
> > > AFAICT FAULT_FLAG_RETRY_NOWAIT only impacts what happens when
> > > VM_FAULT_RETRY is returned, which this doesn't do?
> > 
> > Yes, that's why I think we should still properly return VM_FAULT_RETRY if
> > needed..  because IMHO it is still possible that the caller calls with
> > FAULT_FLAG_RETRY_NOWAIT.
> > 
> > My understanding is that FAULT_FLAG_RETRY_NOWAIT majorly means:
> > 
> >   - We cannot release the mmap_sem, and,
> >   - We cannot sleep
> 
> Sleeping looks fine, look at any FS implementation of fault, say,
> xfs. The first thing it does is xfs_ilock() which does down_write().

Yeah.  My wild guess is that maybe fs code will always be without
FAULT_FLAG_RETRY_NOWAIT so it's safe to sleep unconditionally (e.g., I think
the general #PF should be fine to sleep in fault(); gup should be special, but
I didn't observe any gup code called upon file systems)?

Or I must have missed something important...

Thanks,

-- 
Peter Xu

