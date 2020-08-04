Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFBEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5042177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aB6+2i8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgHDO3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:29:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58855 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728595AbgHDO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596551293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbBVPTz+4qQmj6PUPVBGDXy1g0Mv+s+KUivSkrwVDIE=;
        b=aB6+2i8LcnSbnnZhRdVvIsRFVbK1MzYdCeCHGJfD0KCuFqitZLC0FYizHBvNpFWCGtKBE1
        cVk4+wbo+XbNgaerPXbHofO5kNScy8os/9Y27CVBggcZxe18SHZ1vKDrYBl9ioYk8zgXcv
        NuVtikZ6KLguy1ehPYAIKJgOtT7C2xo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-ZkvZRNcgM-2GyW_IC8Le5g-1; Tue, 04 Aug 2020 10:28:12 -0400
X-MC-Unique: ZkvZRNcgM-2GyW_IC8Le5g-1
Received: by mail-qk1-f200.google.com with SMTP id z1so22962568qkg.23
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 07:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbBVPTz+4qQmj6PUPVBGDXy1g0Mv+s+KUivSkrwVDIE=;
        b=WkWSJJEWj1nAp2ASLXIOCNO5rtV7f7NGlRCOwdRwfsU38M0nekUpIY5ilR/ijTP/ju
         ZdoEFT0pWq+qcAA49rC11zjaf+Sk37uBhiT3cO8imRvJomJD3dMDxM6BTqgd4BobJ7jk
         CHVHFimsJh3EBhovGaZncCyFV8GANW0wvLa6Fap2/d5nPFK9HQRQXTouxSYx4zTJQ0Dp
         D0seCH5jUzMqcW+Ci07Dm4KTPk0siVPVZRWC4b9halkvkd1lL8y2GvXTGdm84K2M15D1
         Af5R03TYgZfUZfKvUrIf91kCtRIsgUAyCeM24bfs60ni5/1dYGUkT8SDJJn83y6Doe/p
         JOFg==
X-Gm-Message-State: AOAM530v1b5T5Xmd30uXZhIW+lc+6hgWpUhwTow4uMHDmsO8AblxHdps
        2hkLaDTf3MEQfwsUUc2wDhXfbLiWgwfgfpdC7WoB3Pw8s7fbTHX2CZWMVlQgFhANNp3tfgywT8I
        Ma+U9QqMEPYP+/Yf1NAZ9d1F+
X-Received: by 2002:a37:e110:: with SMTP id c16mr20618418qkm.243.1596551291147;
        Tue, 04 Aug 2020 07:28:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNYr64uWxrgZzq/NhikZJkGGsFCOpYd/PIReiG0EgEVdOBFwlavIfWEGbkWktSojL8R7KNlA==
X-Received: by 2002:a37:e110:: with SMTP id c16mr20618398qkm.243.1596551290835;
        Tue, 04 Aug 2020 07:28:10 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id m26sm26101110qtc.83.2020.08.04.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 07:28:09 -0700 (PDT)
Date:   Tue, 4 Aug 2020 10:28:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
Message-ID: <20200804102730-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
 <20200804162340.046b719b.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804162340.046b719b.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 04:23:40PM +0200, Cornelia Huck wrote:
> On Mon, 3 Aug 2020 16:58:46 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
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
> >  include/linux/virtio_config.h | 50 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> (...)
> 
> > @@ -287,12 +288,57 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
> >  	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
> >  }
> >  
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
> 
> It might help with the lunch, but it still gives a slight queasiness.
> No ideas for a better version, though.

A later patch fixes this. Hopefully :)

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
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>

