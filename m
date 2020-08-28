Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E161AC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BEE2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7j6jrIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgH1OYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgH1OYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598624645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qm4yw14oZW1kOamiCPd98+q7tZwl+c/TO08c6jDr94k=;
        b=C7j6jrItVMCieRNx3cbjEcKhJ1tODwxO2T/xYEhc1D6su05L+vrzTH0toqCEIdS4844INV
        /gZOyYDW0JL9rRhyrUVeEjaekPpV12roYLzHNpJ4MqI1wd1IVTrybU0SilQ9svlfFnmNkt
        7nnGiUCKlWwZI097KDfKzBwOe/YnBdE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-3D6blhN6NKW2-YOSRy6utg-1; Fri, 28 Aug 2020 10:24:04 -0400
X-MC-Unique: 3D6blhN6NKW2-YOSRy6utg-1
Received: by mail-qt1-f200.google.com with SMTP id p43so127951qtb.23
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qm4yw14oZW1kOamiCPd98+q7tZwl+c/TO08c6jDr94k=;
        b=LZK/p0LXPnCYnv1wA0BWqUkH+3lCKLWEvVW7PusnzweQCalFZ3ybIvZivU9FrYqyjL
         tmg5bBSnBemXelRUWvR4mMilvA2utIhkvq2DMrxPHj40106TIq9mOgG44LdQ8DrpfYzR
         hlJ84H6htcb7LtQhiAsXatOzXR46a82Rgsox3aLJ+G4gP6pWRzj3hiiUj+PuNdQ/zZ/b
         sAZwkdZzeLgSJagUPfAfKxBZHKw1nT8PfnJ3l4OcrIwtGZda4dRvQrWnnmF3QI1j/3OH
         eAm0PeGO7g1S1TdcqMQWuWzCHsvnC9JAsrKrpCRK+05Hcxr/mlQVFQdXHeMmw77LYglX
         Krxw==
X-Gm-Message-State: AOAM532TRZk8/+yLqXtqUGt0PUvalAlcbYglSf2nta0HNVLweCHF+Xky
        2G/ZrW+NeNXa3Csijj48Qfaon9F/wIcxJG6Nw+NaJdi+xYPgGCnQOiUG/iOAryubo/yDIU3rfRC
        s/XCRx5/lCawtroM/mvh9f2as
X-Received: by 2002:a0c:dd05:: with SMTP id u5mr1964733qvk.143.1598624643646;
        Fri, 28 Aug 2020 07:24:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS2SFjk0+xV0FK90qlNWVxFACNOzmy1EjYy0Kne2/gImeDcKsxIYjVyoXkR34UqhH/MeqiCg==
X-Received: by 2002:a0c:dd05:: with SMTP id u5mr1964698qvk.143.1598624643273;
        Fri, 28 Aug 2020 07:24:03 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id w3sm886056qkc.10.2020.08.28.07.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 07:24:02 -0700 (PDT)
Date:   Fri, 28 Aug 2020 10:24:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Maoming (maoming, Cloud Infrastructure Service Product Dept.)" 
        <maoming.maoming@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        wangyunjian <wangyunjian@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRD?= =?utf-8?Q?H?= V2] vfio
 dma_map/unmap: optimized for hugetlbfs pages
Message-ID: <20200828142400.GA3197@xz-x1>
References: <20200814023729.2270-1-maoming.maoming@huawei.com>
 <20200825205907.GB8235@xz-x1>
 <8B561EC9A4D13649A62CF60D3A8E8CB28C2D9ABB@dggeml524-mbx.china.huawei.com>
 <20200826151509.GD8235@xz-x1>
 <8B561EC9A4D13649A62CF60D3A8E8CB28C2DBE7A@dggeml524-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8B561EC9A4D13649A62CF60D3A8E8CB28C2DBE7A@dggeml524-mbx.china.huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 09:23:08AM +0000, Maoming (maoming, Cloud Infrastructure Service Product Dept.) wrote:
> In hugetlb_put_pfn(), I delete unpin_user_pages_dirty_lock() and use some simple code to put hugetlb pages.
> Is this right?

I think we should still use the APIs because of the the same reason.  However
again I don't know the performance impact of that to your patch, but I still
think that could be done inside gup itself when needed (e.g., a special path
for hugetlbfs for [un]pinning continuous pages; though if that's the case that
could be something to be discussed on -mm then as a separate patch, imho).

Thanks,

-- 
Peter Xu

