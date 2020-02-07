Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCDFC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4476214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Icftm7Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgBGHKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:10:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53746 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgBGHKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581059433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96SMThz6L0UJNrqUeXD+zFhU/Yhbd2q8gE1aIuv5qyE=;
        b=Icftm7Wn2IiKaFmt4N5uKcejr+GcCPrZ0XUhBNb5gwhc99RTqfUeVg2FMXcNIXz8P5g2Rd
        V0QHYujeaTEMP9vXTIba9u/IeVbSkh4dDGjqOQphh7kfP2fxJGmq2poGyjqUrBJiVxWG8U
        e8oDFcmxBZaI/9+P0RwYOk7tWec/7WA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-TXX9Hn4KOSy8vYk6yU3PPQ-1; Fri, 07 Feb 2020 02:10:31 -0500
X-MC-Unique: TXX9Hn4KOSy8vYk6yU3PPQ-1
Received: by mail-qk1-f200.google.com with SMTP id r145so808539qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 23:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=96SMThz6L0UJNrqUeXD+zFhU/Yhbd2q8gE1aIuv5qyE=;
        b=lc3aPsaThsDdH5F1h1s49roPqFpmnwkWnKUmFIat6T1QtQ+0Ohfn7rCVgZ6r2RMXaj
         Ha1z6//bUh6VLVoiNIDCe5XfYxKREEnrhfamfxIYFX5g0QIelKKanFGyUEysWuNEelJa
         o98sWxgYvVixH0dixsRj1AsrGX9T3otmvxyJtYuPslfWWptlCRMwFFo3FnCweu6nXTPx
         GzrXh9FvzY+ZC8BgV+9I7gbcSob50Gk4dGf+Imyo5IxkzoDJMyCfwPr0xwFhnO5pqRyP
         iOb2N2ACJfmsiA7fKQOHF/zfkye68JtWmdoZ8Hf+18umc7Q+vy4Em6GkefjRWM0Dw4VR
         UeGA==
X-Gm-Message-State: APjAAAVOYssDvcUuJCzZ2ChHmBdLc3fbzrF5ZFnjiU9ZyxKAg2Hg/g13
        yQF4a2ITDoCVUE7E2NWxuVna077orYw/CE0DyHmTLChABb69qWRSvIuGt86PmUI8pr9lVwGlfA6
        FxGakn1HBvtV2GTj1TcakM5ek
X-Received: by 2002:ac8:758a:: with SMTP id s10mr6179210qtq.283.1581059431456;
        Thu, 06 Feb 2020 23:10:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTt5L3VTuonP/9DSLhE6PiW2T051y0ELHfBhpQWVNPM2qU8HF0YoqTUyKVRZwj5KnuN8KJhw==
X-Received: by 2002:ac8:758a:: with SMTP id s10mr6179199qtq.283.1581059431238;
        Thu, 06 Feb 2020 23:10:31 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id 136sm892346qkn.109.2020.02.06.23.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 23:10:30 -0800 (PST)
Date:   Fri, 7 Feb 2020 02:10:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] tools/virtio: option to build an out of tree module
Message-ID: <20200207015917-mutt-send-email-mst@kernel.org>
References: <20200206080125.1178242-1-mst@redhat.com>
 <d4581772-8314-e746-dbea-2603e0447cdd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4581772-8314-e746-dbea-2603e0447cdd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 11:38:20AM +0800, Jason Wang wrote:
> 
> On 2020/2/6 下午4:01, Michael S. Tsirkin wrote:
> > Handy for testing with distro kernels.
> > Warn that the resulting module is completely unsupported,
> > and isn't intended for production use.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   tools/virtio/Makefile | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> > index 8e2a908115c2..94106cde49e3 100644
> > --- a/tools/virtio/Makefile
> > +++ b/tools/virtio/Makefile
> > @@ -8,7 +8,18 @@ CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-poin
> >   vpath %.c ../../drivers/virtio ../../drivers/vhost
> >   mod:
> >   	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
> > -.PHONY: all test mod clean
> > +
> > +#oot: build vhost as an out of tree module for a distro kernel
> > +#no effort is taken to make it actually build or work, but tends to mostly work
> > +#if the distro kernel is very close to upstream
> > +#unsupported! this is a development tool only, don't use the
> > +#resulting modules in production!
> > +oot:
> > +	echo "UNSUPPORTED! Don't use the resulting modules in production!"
> > +	KCFLAGS="-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/$$(uname -r) M=`pwd`/vhost_test V=${V}
> > +	KCFLAGS="-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/$$(uname -r) M=`pwd`/../../drivers/vhost V=${V} CONFIG_VHOST_VSOCK=n
> 
> 
> Any reason for disabling vsock here?
> 
> Thanks

It's just moving too fast with its internal API changes for a simplistic
oot build like this to work. But I guess it need to make it a bit
more generic. I'll try.

> 
> > +
> > +.PHONY: all test mod clean vhost oot
> >   clean:
> >   	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
> >                 vhost_test/Module.symvers vhost_test/modules.order *.d

