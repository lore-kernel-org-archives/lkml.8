Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C67C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35824206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="CrDoZta2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgDFLE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:04:57 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35466 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgDFLE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:04:56 -0400
Received: by mail-il1-f194.google.com with SMTP id 7so14230410ill.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 04:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eMJr7lybVjckF+p9VXJphA0EDg4AyPvRHBanUGShq5o=;
        b=CrDoZta2kyrwvDenzvyMsm6AddKZuZYMjesr0jINzK5cJVxgNZDA9RKMoEEJCX+fpt
         zdWIn+d2cZ7Au/SS8jEVXCM8451FljhFjb9JuA5usXjbPC3nvaqohOlHVoksSrMmxj2R
         6/P9Hmpwn4qd50mEA3liLtHC+OllndrigknCL3y3FWgpyiLFivSEyj7G69yG6AayplOZ
         xrpTWXsdAYkmPjcAc6VrvIG0dy9k+PtNyMkarIyMzCLeplg/w/NWxwKCLf0RgVe0Ysk5
         hMnSOc50sgRSEtN5ZiiXCXZqHKBMGlaw0/BDqpNta9d5xvNj3OWdT/6CReBq0ffZAgLJ
         4lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eMJr7lybVjckF+p9VXJphA0EDg4AyPvRHBanUGShq5o=;
        b=F6oBoSv1v1m/YfNJqL1+5TcC3Fdy6LK5kWu1lZ3Rx2kvzpHucZDC6oCGxXncDzRaN9
         mc051KixekP5kZ5Y+30GdK4jbl1lnjm5cf6/yMZk/+fB9IMM7116+1Dat6thYU8DViPe
         FBG3JNjIIBer4R+BHR+shVO+W6F9zcbXMaDxtK3Mo9F1q/2weZp6mRT2T9jmKhetCEDI
         ojnOUgjDq7j2KNU0/22fMtmixono1It+lOeQlRhEP4CZL0edgUMYcIAyw7OZCSN9eRBD
         4zcUAhWWjwv9eYk5O/zOqd8ukajmv0al+ue3J8Ada3B6x3svLpi6AZPvZ7gqNDckkyXz
         z5KQ==
X-Gm-Message-State: AGi0PuaFMTuyrbiRj7+5n/4IYz69RPE32WgXtMOZwYcUrMpa5c6j9AIA
        h1LVDRXyJTOB2XGpkd6KooJKWnKEpnWRaCIjsqvwpg==
X-Google-Smtp-Source: APiQypKWJs6PHI1hMNLMM3oimdNsa1kWSty3RiXndiBigly0VtAAMGTGpbbSHS6CHAmiJga/4y1ZYRnxDsV6s5hEr1o=
X-Received: by 2002:a92:d18b:: with SMTP id z11mr20685904ilz.76.1586171095697;
 Mon, 06 Apr 2020 04:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com> <20200405164006.GA1582475@kroah.com>
In-Reply-To: <20200405164006.GA1582475@kroah.com>
From:   =?UTF-8?B?5a6L54mn5pil?= <songmuchun@bytedance.com>
Date:   Mon, 6 Apr 2020 19:04:14 +0800
Message-ID: <CAMZfGtUS2_tsf=E3=+O77ooGQUDto0jnt1preWggdar85tb5_A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] driver core: Fix possible use after free
 on name
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhangfeionline@gmail.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi PengfeiZhang,

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2020=E5=B9=B44=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8812:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Apr 05, 2020 at 09:05:49AM -0700, zhangfeionline@gmail.com wrote:
> > From: PengfeiZhang <zhangfeionline@gmail.com>
> >
> > __class_create() copies the pointer to the name passed as an
> > argument only to be used later. But there's a chance the caller
> > could immediately free the passed string(e.g., local variable).
> > This could trigger a use after free when we use class name(e.g.,
> > dev_uevent_name()called by device_destroy(),class_create_release()).
> >
> > To be on the safe side: duplicate the string with kstrdup_const()
> > so that if an unaware user passes an address to a stack-allocated
> > buffer, we won't get the arbitrary name and crash.
>
> Where are you seeing this happen?
>
> >
> > Signed-off-by: PengfeiZhang <zhangfeionline@gmail.com>
> > ---
> >  drivers/base/class.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/class.c b/drivers/base/class.c
> > index bcd410e..770b3b3 100644
> > --- a/drivers/base/class.c
> > +++ b/drivers/base/class.c
> > @@ -206,6 +206,7 @@ void class_unregister(struct class *cls)
> >  static void class_create_release(struct class *cls)
> >  {
> >       pr_debug("%s called for %s\n", __func__, cls->name);
> > +     kfree_const(cls->name);
> >       kfree(cls);
> >  }
> >
> > @@ -227,7 +228,10 @@ struct class *__class_create(struct module *owner,=
 const char *name,
> >                            struct lock_class_key *key)
> >  {
> >       struct class *cls;
> > -     int retval;
> > +     int retval =3D -EINVAL;
> > +
> > +     if (!name)
> > +             goto done;
>
> This is a new change, who calls this function with name not being set?
>
>
> >
> >       cls =3D kzalloc(sizeof(*cls), GFP_KERNEL);
> >       if (!cls) {
> > @@ -235,18 +239,27 @@ struct class *__class_create(struct module *owner=
, const char *name,
> >               goto error;
> >       }
> >
> > +     name =3D kstrdup_const(name, GFP_KERNEL);
> > +     if (!name) {
> > +             retval =3D -ENOMEM;
> > +             goto error;
> > +     }
>
> and overwriting the pointer like that is bad-form, try doing something
> else here instead.
>
> > +
> >       cls->name =3D name;
> >       cls->owner =3D owner;
> >       cls->class_release =3D class_create_release;
> >
> >       retval =3D __class_register(cls, key);
> >       if (retval)
> > -             goto error;
> > +             goto error_class_register;
> >
> >       return cls;
> >
> > +error_class_register:
> > +     kfree(cls->name);
>
> kfree_const()?
>
> thanks,
>
> greg k-h

Yeah, you have some problem with this fix patch which Greg mentioned.
Can you fix it? And
send the fix patch v2 to Greg?

--=20
Yours,
Muchun
