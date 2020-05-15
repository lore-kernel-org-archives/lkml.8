Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12C5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A4F20671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXq6yCSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgEOPW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:22:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24234 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726228AbgEOPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589556176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HUXlVHVDew6Pt3rQAcFMVAmdI76CZRZY959odxV7XQU=;
        b=UXq6yCSbV8edS0c/m5LOup+pyMPyCO3nhcNPu3tP5azr5s/iR7Vd6Z0DSUb2Uc6AYPjyzW
        yOx/lUPO77OqkSZzcAP08Gbz52KQpOt54OvgboK/0XjfvCj3G8mhxIhJYpjex/xL4EANbF
        uXGxFQ1bZ+7D8kz6ubrdm/SzLRjrM2A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-W1HwUj4_PeqAZywcV4pquQ-1; Fri, 15 May 2020 11:22:54 -0400
X-MC-Unique: W1HwUj4_PeqAZywcV4pquQ-1
Received: by mail-qt1-f198.google.com with SMTP id h1so2798278qtu.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUXlVHVDew6Pt3rQAcFMVAmdI76CZRZY959odxV7XQU=;
        b=jBjtMr+wKLepseXiJXl+pHRsmfHx+EbS2nFtWBfXdRvQl0HZ1UZrBr5HMA7VHylDUQ
         /VuJwHoikS5YJ9ih7VhmeEMsAUXMKNRnv75ACI85gTw2PqhH+HP7nQP71gmFOtATZKO2
         NUCpgYOVH2aBqD9XfPNfBv9xwjN6HHIgCLS2G+uicuyARsm+MdWojrQ9R/EYTlHM2X9s
         BLHqyM+x0uOxhqmnzVxuu3bDue2k3+IXMeKEIU1Q2xHtf9u2X3Uf+GfHPEuk/fKH4HTy
         boYwpZQ1QjYFF7LaFjH+GE8t8l7BJNkif7tESqiyP3ckFeLoKpiB1Dta9K+bQc0c7Ij0
         KmSw==
X-Gm-Message-State: AOAM532D2OKPvU+o68qPLSKrhAqNH98qoHXj7r3e7I3ISA4bywaWIeoi
        9Yu9aeP09Gd1yZeYQR9VNENTeFzaN3GYBG82FG4la09TGwKvXJIm8WXkii3i36Qpaa27ry9dII0
        GdLmiKpWfsm/y+ClHpXw6lmY+
X-Received: by 2002:a37:643:: with SMTP id 64mr3421460qkg.99.1589556174151;
        Fri, 15 May 2020 08:22:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRAwA2xdxuhP8vOOprcU5gdcl4p5EwlfhbJap+VnVrYrharU53VdbVu9YOHDr3i4Xs+InCQA==
X-Received: by 2002:a37:643:: with SMTP id 64mr3421434qkg.99.1589556173861;
        Fri, 15 May 2020 08:22:53 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id l133sm1798296qke.105.2020.05.15.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 08:22:53 -0700 (PDT)
Date:   Fri, 15 May 2020 11:22:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com
Subject: Re: [PATCH 0/2] vfio/type1/pci: IOMMU PFNMAP invalidation
Message-ID: <20200515152251.GB499802@xz-x1>
References: <158947414729.12590.4345248265094886807.stgit@gimli.home>
 <20200514212538.GB449815@xz-x1>
 <20200514161712.14b34984@w520.home>
 <20200514222415.GA24575@ziepe.ca>
 <20200514165517.3df5a9ef@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514165517.3df5a9ef@w520.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:55:17PM -0600, Alex Williamson wrote:
> > I'm not if this makes sense, can't we arrange to directly trap the
> > IOMMU failure and route it into qemu if that is what is desired?
> 
> Can't guarantee it, some systems wire that directly into their
> management processor so that they can "protect their users" regardless
> of whether they want or need it.  Yay firmware first error handling,
> *sigh*.  Thanks,

Sorry to be slightly out of topic - Alex, does this mean the general approach
of fault reporting from vfio to the userspace is not gonna work too?

Thanks,

-- 
Peter Xu

