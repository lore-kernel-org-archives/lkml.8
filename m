Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D068FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7B622D07
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYFMjEox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgHER0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:26:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58582 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728586AbgHERZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596648328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvhF/2Uq1kX64zND5Z4WYms1vSnLsR66mXtK5h4mjnE=;
        b=iYFMjEoxEdZFBoHaoGE3hzOhco99rfVrZHBB3ReXsCMaSLAXGdqVJkOyn93XE3hQfhICwN
        Zern9eyP1/scIQ0swxqT3Vyl4SJfaF2alMtJtBoOFBjGi4igLtGD7Zfoitw7p4Q1Ns+KlA
        vrUfD5glH7nzaK8mEWkoJZj2ElRY8OI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-iL-hBD-FMUOvPz-BFV-jnA-1; Wed, 05 Aug 2020 07:45:51 -0400
X-MC-Unique: iL-hBD-FMUOvPz-BFV-jnA-1
Received: by mail-wr1-f70.google.com with SMTP id k11so12987437wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 04:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dvhF/2Uq1kX64zND5Z4WYms1vSnLsR66mXtK5h4mjnE=;
        b=N1Wwxc8FftXuwtr7pZP8VW8ME0A6Y7FIByFhcMrw/wPPSFrDcccsjr3/7rnkj3vIqv
         D8T76m08XISgvCZgDuR+69VMhQFAOwF+RCobOziUyb7GGXNPResW/Pa/UC66y4KKpdDA
         e1J4PEsAdqCkBhr4vNBxN5ZtyMpo6IGuvnrJbAhPPaSI62UWPO17+yG11BD+TyZ58/BO
         teYSpWNR1dVBAQL4bdLLfrkDL7ptK7YHq/SshYShwa7a/+rbR/FqojWZLt1XzAcO14k+
         jX64PY/YwlMcUTDT6q2DX4YJk9/8+xc5ffe3LXa0Abgor8EJkdMX6DnCIEeuLA8sFzU3
         mLFQ==
X-Gm-Message-State: AOAM532u4FCzHQuktKEsPO5IeMMx9soKSR8DTLfxUrg9Nv8Yz9xtCTPF
        UT0PvUIe42zGKEyPtgybH25xd2InSv4fjSgGaGFWtXULcInC62x8ZfN8cMDlY2fuVfRutcJ8Oqy
        oin9h51HdKZlP/S/WjRPhRbt3
X-Received: by 2002:a1c:a590:: with SMTP id o138mr2959634wme.4.1596627950597;
        Wed, 05 Aug 2020 04:45:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUqGQTkpCDTfa2ZGtGXUiAZzqSzaobMzIluThYVUCvwubI43LF+I4IqyX+82lokvtNLNwvgg==
X-Received: by 2002:a1c:a590:: with SMTP id o138mr2959613wme.4.1596627950321;
        Wed, 05 Aug 2020 04:45:50 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id o2sm2693544wrh.70.2020.08.05.04.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 04:45:49 -0700 (PDT)
Date:   Wed, 5 Aug 2020 07:45:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
Message-ID: <20200805074434-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
 <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 02:28:23PM +0800, Jason Wang wrote:
> 
> On 2020/8/4 上午4:58, Michael S. Tsirkin wrote:
> > Currently all config space fields are of the type __uXX.
> > This confuses people and some drivers (notably vdpa)
> > access them using CPU endian-ness - which only
> > works well for legacy or LE platforms.
> > 
> > Update virtio_cread/virtio_cwrite macros to allow __virtioXX
> > and __leXX field types. Follow-up patches will convert
> > config space to use these types.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   include/linux/virtio_config.h | 50 +++++++++++++++++++++++++++++++++--
> >   1 file changed, 48 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 3b4eae5ac5e3..64da491936f7 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -6,6 +6,7 @@
> >   #include <linux/bug.h>
> >   #include <linux/virtio.h>
> >   #include <linux/virtio_byteorder.h>
> > +#include <linux/compiler_types.h>
> >   #include <uapi/linux/virtio_config.h>
> >   struct irq_affinity;
> > @@ -287,12 +288,57 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
> >   	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
> >   }
> > +/*
> > + * Only the checker differentiates between __virtioXX and __uXX types. But we
> > + * try to share as much code as we can with the regular GCC build.
> > + */
> > +#if !defined(CONFIG_CC_IS_GCC) && !defined(__CHECKER__)
> > +
> > +/* Not a checker - we can keep things simple */
> > +#define __virtio_native_typeof(x) typeof(x)
> > +
> > +#else
> > +
> > +/*
> > + * We build this out of a couple of helper macros in a vain attempt to
> > + * help you keep your lunch down while reading it.
> > + */
> > +#define __virtio_pick_value(x, type, then, otherwise)			\
> > +	__builtin_choose_expr(__same_type(x, type), then, otherwise)
> > +
> > +#define __virtio_pick_type(x, type, then, otherwise)			\
> > +	__virtio_pick_value(x, type, (then)0, otherwise)
> > +
> > +#define __virtio_pick_endian(x, x16, x32, x64, otherwise)			\
> > +	__virtio_pick_type(x, x16, __u16,					\
> > +		__virtio_pick_type(x, x32, __u32,				\
> > +			__virtio_pick_type(x, x64, __u64,			\
> > +				otherwise)))
> > +
> > +#define __virtio_native_typeof(x) typeof(					\
> > +	__virtio_pick_type(x, __u8, __u8,					\
> > +		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
> > +			__virtio_pick_endian(x, __le16, __le32, __le64,		\
> > +				__virtio_pick_endian(x, __u16, __u32, __u64,	\
> > +					/* No other type allowed */		\
> > +					(void)0)))))
> > +
> > +#endif
> > +
> > +#define __virtio_native_type(structname, member) \
> > +	__virtio_native_typeof(((structname*)0)->member)
> > +
> > +#define __virtio_typecheck(structname, member, val) \
> > +		/* Must match the member's type, and be integer */ \
> > +		typecheck(__virtio_native_type(structname, member), (val))
> > +
> > +
> >   /* Config space accessors. */
> >   #define virtio_cread(vdev, structname, member, ptr)			\
> >   	do {								\
> >   		might_sleep();						\
> >   		/* Must match the member's type, and be integer */	\
> > -		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
> > +		if (!__virtio_typecheck(structname, member, *(ptr)))	\
> >   			(*ptr) = 1;					\
> 
> 
> A silly question,  compare to using set()/get() directly, what's the value
> of the accessors macro here?
> 
> Thanks

get/set don't convert to the native endian, I guess that's why
drivers use cread/cwrite. It is also nice that there's type
safety, checking the correct integer width is used.

> 
> >   									\
> >   		switch (sizeof(*ptr)) {					\
> > @@ -322,7 +368,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
> >   	do {								\
> >   		might_sleep();						\
> >   		/* Must match the member's type, and be integer */	\
> > -		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
> > +		if (!__virtio_typecheck(structname, member, *(ptr)))	\
> >   			BUG_ON((*ptr) == 1);				\
> >   									\
> >   		switch (sizeof(*ptr)) {					\

