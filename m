Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B03C433F8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697AB22D70
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qdje07V/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgHFF6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 01:58:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46037 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726051AbgHFF6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596693513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROash10duIpE/uRw8Y0foDvQjeHUSzvvXlunxpzl8MY=;
        b=Qdje07V/lSm4HgB395YlIbPFFvEuDH4BnZ6RDJZT7HKu5elsLl3TcYzTiiceJqaPZjk86S
        I2k1W4unC9kDhzhZlrVUHRNHBVUD0YQHS2+jaufA9EEK5k9XEzq2QUBJP1QEFzBgsZ+g2I
        Idp/zuhCD4wC6hswcOkjSIuQ+peLgnE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Z5p72NYkMQ-cK5clyRqhgQ-1; Thu, 06 Aug 2020 01:58:31 -0400
X-MC-Unique: Z5p72NYkMQ-cK5clyRqhgQ-1
Received: by mail-wm1-f69.google.com with SMTP id c184so2613285wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 22:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ROash10duIpE/uRw8Y0foDvQjeHUSzvvXlunxpzl8MY=;
        b=OzYDgwwS7+xwE+n4cveRK3mmGkdoVSxOfwYquMnxbRzW1+4jWauWGQKR5Yb0tdLeE7
         53n45e6tVcJqTkJgFeIiDLxHUJUkR6lykaP1luZwN3kGADTEB/LJ5QS6P4dT8cpRLI45
         5InDZuRQson9ayckBPdl5dFKNpnS1PjsLTQ6V6kBxpexV/BbMajgJXazLPMmt/XCnamI
         hDuuuAgjxHwmwnavAqmD5vaP3tffFcZ1pFsspW8cLGJEZIIh29iVL6U2funRsHK39jbc
         +CxTcvYOE/5aHy9U+AAYOHlyLaxZ8eytoup1nMhxJVVVVOKM7PuP3/Jf5tC3FIOXvUGW
         8tqA==
X-Gm-Message-State: AOAM5321ZNfp2b7vyMyV4h7qKGoZDPrgebxmyEpd0FuX2B+cXHHpkfuz
        fLlYDU9CvMUYhCUOc4UQY6loVqXbg5wEz68wKFpDIiCYYGtVQycnU8yCtziRINw9MfAaAkjILK0
        wh7MB6Ia6CoPSIy0SWQYBiPum
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr6644724wmb.104.1596693510110;
        Wed, 05 Aug 2020 22:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMfTd+fQO/qWYVB46EsFXyAOA5C3DoglabIcYVWxoQ2qa+aefyPe9WQJEOfgniTDRJwIeZog==
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr6644711wmb.104.1596693509935;
        Wed, 05 Aug 2020 22:58:29 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id y17sm5492967wrh.63.2020.08.05.22.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 22:58:29 -0700 (PDT)
Date:   Thu, 6 Aug 2020 01:58:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
Message-ID: <20200806015604-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
 <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
 <20200805074434-mutt-send-email-mst@kernel.org>
 <4aa65ad6-5324-0a8c-0fa6-0d8e680f0706@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aa65ad6-5324-0a8c-0fa6-0d8e680f0706@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 11:37:38AM +0800, Jason Wang wrote:
> 
> On 2020/8/5 下午7:45, Michael S. Tsirkin wrote:
> > > >    #define virtio_cread(vdev, structname, member, ptr)			\
> > > >    	do {								\
> > > >    		might_sleep();						\
> > > >    		/* Must match the member's type, and be integer */	\
> > > > -		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
> > > > +		if (!__virtio_typecheck(structname, member, *(ptr)))	\
> > > >    			(*ptr) = 1;					\
> > > A silly question,  compare to using set()/get() directly, what's the value
> > > of the accessors macro here?
> > > 
> > > Thanks
> > get/set don't convert to the native endian, I guess that's why
> > drivers use cread/cwrite. It is also nice that there's type
> > safety, checking the correct integer width is used.
> 
> 
> Yes, but this is simply because a macro is used here, how about just doing
> things similar like virtio_cread_bytes():
> 
> static inline void virtio_cread(struct virtio_device *vdev,
>                       unsigned int offset,
>                       void *buf, size_t len)
> 
> 
> And do the endian conversion inside?
> 
> Thanks
> 

Then you lose type safety. It's very easy to have an le32 field
and try to read it into a u16 by mistake.

These macros are all about preventing bugs: and the whole patchset
is about several bugs sparse found - that is what prompted me to make
type checks more strict.


> > 

