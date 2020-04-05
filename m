Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E994C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCC220672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkXSasLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgDEKWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:22:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37166 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgDEKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:22:03 -0400
Received: by mail-io1-f67.google.com with SMTP id q9so12543138iod.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 03:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CcpZ55sIaW80vBf2IOXi5oS4UvwpWuI+r7GfFf/L5RY=;
        b=IkXSasLQ9grTa++au/Z5hXPOKZ3ZYi+1JzuViyhA0HLbYf0TxrRQXTwA9oh8IWSDi8
         dzdpEl2smjGu27eIT7o5v8nOu8XP0B0lJr4jqEisaOuLgNSJsaJnx/WVlQjQCTzZliM1
         ED+serjzQZUw9NU+mOG7b8c/g0O5j4V+5G5QaGdwVPxPzaEN7h9TMFRIa6Xwf3ReS/d8
         1IIjeLFvSMjo2NJUER3BzVCwPsjIDncOnhahCE+euDnJ5TBQFxPAJZfYZsgtQiCvaIpG
         873oPWRQQLsu0YKt0vGP6KcE++U77GXyZCJAytUJ+zFCYr076Qn6O8D1ToIHLPQAmyPr
         RsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CcpZ55sIaW80vBf2IOXi5oS4UvwpWuI+r7GfFf/L5RY=;
        b=skMFwMHWp6duOKpv7vcC51mD8Uw0ceP+0usaXIMe8fao3DyuG27hGnRthLV7WtGnnu
         B6kvXPSrAeQm9ndsxIA7dMcLeFGBIWWIt3/4PmLOY7V94zdhKQ1r7iqN84qDXS44RPKd
         84F4C2+Cl5UrPfYkOJDZswoV4k2NgRUVH0AOJImep6I5PwVKyx4mjk1ozMQOmhiKZW5j
         BDHeR0O2VxS96qQM6NtWvIzrxKt1sLUDi0et5QfKFk6HycXQKkI/D9/gIxaNU34YQ/hD
         H+Y1ZHMG2syCmtP6FK0KhVKyfkQ1fx+Vu3ZZKwfz883P2U4nzNNbfPBIf2yxcY3Kwc0q
         oyjw==
X-Gm-Message-State: AGi0PuZGEfs1cPGEqnPtCbYjccBfBNgKBCg/NdJRBihYGsCFjdq9dlf1
        B2OozO5/TCk5xdGy6E8Nx+NyWJ1fIq2kzzZzzpRBXr8h
X-Google-Smtp-Source: APiQypJKgTx8bihiWHOKmKlabLFQky52UBaqKhm6wL/tZQaMqBSjHPcL7tDK7R6WOyDjxMi2q/21LfluYWWijQp29OE=
X-Received: by 2002:a5d:984b:: with SMTP id p11mr15046520ios.175.1586082122447;
 Sun, 05 Apr 2020 03:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200405075123.28756-1-hqjagain@gmail.com> <99de2220-5a64-e81e-6886-447296431548@c-s.fr>
In-Reply-To: <99de2220-5a64-e81e-6886-447296431548@c-s.fr>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Sun, 5 Apr 2020 18:21:49 +0800
Message-ID: <CAJRQjodoHMn+XA+iYkM2D8OiEWk1rF+trZbB9GvKF_=2Rv2g1w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: add NULL check after kzalloc in opal_add_one_export
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     benh@kernel.crashing.org, paulus@samba.org, tglx@linutronix.de,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 5, 2020 at 6:13 PM Christophe Leroy <christophe.leroy@c-s.fr> w=
rote:
>
>
>
> Le 05/04/2020 =C3=A0 09:51, Qiujun Huang a =C3=A9crit :
> > Here needs a NULL check.
> >
> > Issue found by coccinelle.
> >
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >   arch/powerpc/platforms/powernv/opal.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platf=
orms/powernv/opal.c
> > index 2b3dfd0b6cdd..09443ae3a86e 100644
> > --- a/arch/powerpc/platforms/powernv/opal.c
> > +++ b/arch/powerpc/platforms/powernv/opal.c
> > @@ -811,6 +811,11 @@ static int opal_add_one_export(struct kobject *par=
ent, const char *export_name,
> >               goto out;
> >
> >       attr =3D kzalloc(sizeof(*attr), GFP_KERNEL);
> > +     if (!attr) {
> > +             rc =3D -ENOMEM;
> > +             goto out;
>
> You don't need to go to out:, there is nothing to do. You should do:
>
>         if (!attr)
>                 return -ENOMEM;

Yeah, I get that. Thanks.

>
> > +     }
> > +
> >       name =3D kstrdup(export_name, GFP_KERNEL);
> >       if (!name) {
> >               rc =3D -ENOMEM;
> >
>
> Christophe
