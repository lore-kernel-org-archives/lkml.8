Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0226AC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A4D20771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYtnQ7q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgDHRH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:07:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726663AbgDHRH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586365678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=831n3NNH1eOyJVeWwcK0b1hYMKlT0SmVSL68krCbNsU=;
        b=fYtnQ7q7TC3yLE5fEYOVY9F7beAgGr42MM+uoMj+iD+e6EuULAsGNVzbq9dvwMGhFiTKAN
        GjNejQU9Pm4yuKbgglxu51Mm1HAMmW+TcmCmxHOWjkq0xGIc3Ow75gD8aBN+x8Db+TA5XJ
        kdoWare79tWzm4YV+kfX1R+59+3zu+g=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-GFrqFxbHMQ2INrZ7SzVn_Q-1; Wed, 08 Apr 2020 13:07:54 -0400
X-MC-Unique: GFrqFxbHMQ2INrZ7SzVn_Q-1
Received: by mail-il1-f200.google.com with SMTP id a79so7398953ill.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 10:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=831n3NNH1eOyJVeWwcK0b1hYMKlT0SmVSL68krCbNsU=;
        b=li6NuvVmNsOU68trtwnnYnlJ8UFD0MGMPipDUTyB82+//EoB4lpAi3OBd+lDiOhztL
         vRU3EtF9k3e5VABMLtf32S15wv9Ze0GidosTVJt79pdk7DvXXYI9brTN7lwjxdu0ZVHp
         M2Dj0AOdGqC1TjcRijaylpq4X/SZ2xsDQnjwNpOemoFT+ocCxzeCld8YioTS9aQ3IRe8
         IZS+A6V7IPLRX8x3npiV2XSAQVWrcuzX3OujdG8Lk2pbWrq465R1J/EpbmJ3ZjlS3axY
         /C9nqfrWqh35k4kvdXoazH6y3v8x9TP3v8V1W3fpNK0HSj5RPDZ9Ii4mCjYeOOlGNalv
         leiQ==
X-Gm-Message-State: AGi0PubaA/3SvdrSIxrkfCtIrkvSNsV5nopmMbpCzYPCuMU6irPJJnMt
        V35gur0m8ctTTABMlWA35f16EACNx1dU042vXmFZIL/jYGuoBR4pmInysUhlmFjsK+n8/+MrEDP
        ZEndgZ8NtdPM/ath6VD9MOO7VNhRA5VMigTQepcYj
X-Received: by 2002:a02:aa93:: with SMTP id u19mr3298083jai.70.1586365673742;
        Wed, 08 Apr 2020 10:07:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypJVwAt/GF+D/bFHyQ0hslIrhAHYssU13qonP7sA8qIVwe7mp31P/nG0Ns3obKBCHr/rn/cjYLWmSsjifKOJBNo=
X-Received: by 2002:a02:aa93:: with SMTP id u19mr3298064jai.70.1586365673393;
 Wed, 08 Apr 2020 10:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200407202853.1791218-1-marcandre.lureau@redhat.com> <8a6dced2-886f-f8bd-aff9-3793f418cb0e@cambridgegreys.com>
In-Reply-To: <8a6dced2-886f-f8bd-aff9-3793f418cb0e@cambridgegreys.com>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date:   Wed, 8 Apr 2020 19:07:42 +0200
Message-ID: <CAMxuvaz17pVzSQ--y1_zXNFeM-MkH8L8ayiM34eCN0OkEF21WQ@mail.gmail.com>
Subject: Re: [PATCH] um: add a generic "fd" vector transport
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     linux-um <linux-um@lists.infradead.org>,
        joerd.simons@collabora.co.uk, richard@nod.at, jdike@addtoit.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alex.dewar@gmx.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Apr 7, 2020 at 11:02 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> On 07/04/2020 21:28, Marc-Andr=C3=A9 Lureau wrote:
> > Learn to take a pre-opened file-descriptor for vector IO.
> >
> > Instead of teaching the driver to open a FD in multiple ways, it can
> > rely on management layer to do it on its behalf. For example, this
> > allows inheriting a preconfigured device fd or a simple socketpair()
> > setup, without further arguments, privileges or system access by UML.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   arch/um/drivers/vector_user.c | 59 ++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 59 insertions(+)
> >
> > diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_use=
r.c
> > index 29fae0456ade..45c1550dbb37 100644
> > --- a/arch/um/drivers/vector_user.c
> > +++ b/arch/um/drivers/vector_user.c
> > @@ -29,6 +29,7 @@
> >   #include <netdb.h>
> >   #include <stdlib.h>
> >   #include <os.h>
> > +#include <limits.h>
> >   #include <um_malloc.h>
> >   #include "vector_user.h"
> >
> > @@ -42,6 +43,9 @@
> >   #define TRANS_RAW "raw"
> >   #define TRANS_RAW_LEN strlen(TRANS_RAW)
> >
> > +#define TRANS_FD "fd"
> > +#define TRANS_FD_LEN strlen(TRANS_FD)
> > +
> >   #define VNET_HDR_FAIL "could not enable vnet headers on fd %d"
> >   #define TUN_GET_F_FAIL "tapraw: TUNGETFEATURES failed: %s"
> >   #define L2TPV3_BIND_FAIL "l2tpv3_open : could not bind socket err=3D%=
i"
> > @@ -347,6 +351,59 @@ static struct vector_fds *user_init_unix_fds(struc=
t arglist *ifspec, int id)
> >       return NULL;
> >   }
> >
> > +static int strtofd(const char *nptr)
> > +{
> > +     long fd;
> > +     char *endptr;
> > +
> > +     if (nptr =3D=3D NULL)
> > +             return -1;
> > +
> > +     errno =3D 0;
> > +     fd =3D strtol(nptr, &endptr, 10);
> > +     if (nptr =3D=3D endptr ||
> > +             errno !=3D 0 ||
> > +             *endptr !=3D '\0' ||
> > +             fd < 0 ||
> > +             fd > INT_MAX) {
> > +             return -1;
> > +     }
> > +     return fd;
> > +}
> > +
> > +static struct vector_fds *user_init_fd_fds(struct arglist *ifspec)
> > +{
> > +     int fd =3D -1;
> > +     char *fdarg =3D NULL;
> > +     struct vector_fds *result =3D NULL;
> > +
> > +     fdarg =3D uml_vector_fetch_arg(ifspec, "fd");
> > +     fd =3D strtofd(fdarg);
> > +     if (fd =3D=3D -1) {
> > +             printk(UM_KERN_ERR "fd open: bad or missing fd argument")=
;
> > +             goto fd_cleanup;
> > +     }
> > +
> > +     result =3D uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
> > +     if (result =3D=3D NULL) {
> > +             printk(UM_KERN_ERR "fd open: allocation failed");
> > +             goto fd_cleanup;
> > +     }
> > +
> > +     result->rx_fd =3D fd;
> > +     result->tx_fd =3D fd;
> > +     result->remote_addr_size =3D 0;
> > +     result->remote_addr =3D NULL;
> > +     return result;
> > +
> > +fd_cleanup:
> > +     if (fd >=3D 0)
> > +             os_close_file(fd);
> > +     if (result !=3D NULL)
> > +             kfree(result);
> > +     return NULL;
> > +}
> > +
> >   static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
> >   {
> >       int rxfd =3D -1, txfd =3D -1;
> > @@ -578,6 +635,8 @@ struct vector_fds *uml_vector_user_open(
> >               return user_init_socket_fds(parsed, ID_L2TPV3);
> >       if (strncmp(transport, TRANS_BESS, TRANS_BESS_LEN) =3D=3D 0)
> >               return user_init_unix_fds(parsed, ID_BESS);
> > +     if (strncmp(transport, TRANS_FD, TRANS_FD_LEN) =3D=3D 0)
> > +             return user_init_fd_fds(parsed);
> >       return NULL;
> >   }
> >
> >
>
> We should also control enable/disable of recv/sendmmsg as an option here.
>
> It can be made generic and be fed into get_transport_options() in
> vector_kern.c as an override.

So actually, there seems to be a way to do that already:

vec0:transport=3Dfd,fd=3DN,vec=3D0

>
> --
> Anton R. Ivanov
> Cambridgegreys Limited. Registered in England. Company Number 10273661
> https://www.cambridgegreys.com/
>

