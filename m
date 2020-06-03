Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D86C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16B5206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKkaRY7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFCGbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:31:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41596 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbgFCGa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591165856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qhE31HcIzDAxbPbDIk2wZyZIZFK9elalZKddVhonKnM=;
        b=XKkaRY7hMvsd6HtuR31BNuFpEvFkTNDT98PVlLbg7Ve1k14L+j1QF8HKo6BVyphz+RdRn7
        t8Evl5/uTNuF9knQ3xBrgUOF5cwB3aGanQVuvjmdh9SSAKn4cd48B8otIEoiPdXdIPTRwo
        oiSInlnFsQ6wReYTL/0pPhzxSC+iorM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-uMNZ5mVoPF2nWFhlm9hVzA-1; Wed, 03 Jun 2020 02:30:54 -0400
X-MC-Unique: uMNZ5mVoPF2nWFhlm9hVzA-1
Received: by mail-wm1-f70.google.com with SMTP id j128so472935wmj.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 23:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhE31HcIzDAxbPbDIk2wZyZIZFK9elalZKddVhonKnM=;
        b=EI1hFJ/5tMyGN5LKsdY8xttHwgf+yb8vMnHjICyYt4WgwoV+X1PQdD65UBOO6mLUrG
         8p6jGDIAZYS7xoAxCtbZSgVT9lPQLE5pe3IRp1hVavgj7V17PG0ChyxciplIVSUnOj7v
         d+bKSPWADjlPKPGUpuR7Y7PPj5dKfiCeiHeOhoOLQI2O6/Uk77KC/wSOWSA0yLT8Lop1
         qy92Z3AmCgfteY9DwhjKWqlKINz3D2xhsfNQEztPwm1rqqoPgGZBectRrb971TNla9b2
         UgVm1giOq9MngxYE3x2wEt7hbFW/bnnviB3aXb4FMpukNJTL2FE0HedgDisxEsQDuJLi
         QOyg==
X-Gm-Message-State: AOAM532M6DOz5q+3GiEEnkSXBagAzdM5314+AiKRPn/ynCWekbPoz66r
        guTDsxpmX6OehH4DHpjzojowd+w3Z9tCqwXnl0yoZ71VMmyjssNRseEuZ8zF0zjeI+tKOHRO3xS
        tCWgzXwabZ/UA7CFCAUkcODcm
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr7052448wmk.120.1591165853826;
        Tue, 02 Jun 2020 23:30:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP9jW6Rsfd2VTCnqrAo+o9JORQHZzZImTA5f+mEAuJg4PHUsougvW0Y8tOcfWNrF5IfN+ohw==
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr7052435wmk.120.1591165853665;
        Tue, 02 Jun 2020 23:30:53 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id q13sm1684498wrn.84.2020.06.02.23.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 23:30:53 -0700 (PDT)
Date:   Wed, 3 Jun 2020 02:30:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200603022935-mutt-send-email-mst@kernel.org>
References: <20200602084257.134555-1-mst@redhat.com>
 <20200603014815.GR23230@ZenIV.linux.org.uk>
 <3358ae96-abb6-6be9-346a-0e971cb84dcd@redhat.com>
 <20200603041849.GT23230@ZenIV.linux.org.uk>
 <3e723db8-0d55-fae6-288e-9d95905592db@redhat.com>
 <20200603013600-mutt-send-email-mst@kernel.org>
 <b7de29fa-33f2-bbc1-08dc-d73b28e3ded5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7de29fa-33f2-bbc1-08dc-d73b28e3ded5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 02:23:08PM +0800, Jason Wang wrote:
> > 
> > BTW now I re-read it I don't understand __vhost_get_user_slow:
> > 
> > 
> > static void __user *__vhost_get_user_slow(struct vhost_virtqueue *vq,
> >                                            void __user *addr, unsigned int size,
> >                                            int type)
> > {
> >          int ret;
> > 
> >          ret = translate_desc(vq, (u64)(uintptr_t)addr, size, vq->iotlb_iov,
> >                               ARRAY_SIZE(vq->iotlb_iov),
> >                               VHOST_ACCESS_RO);
> > 
> > ..
> > }
> > 
> > how does this work? how can we cast a pointer to guest address without
> > adding any offsets?
> 
> 
> I'm not sure I get you here. What kind of offset did you mean?
> 
> Thanks

OK so points:

1. type argument seems unused. Right?
2. Second argument to translate_desc is a GPA, isn't it?
   Here we cast a userspace address to this type. What if it
   matches a valid GPA by mistake?

-- 
MST

