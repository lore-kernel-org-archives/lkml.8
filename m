Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA6BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4380207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LxZUYmW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgE0GeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0GeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:34:17 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D43EC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:34:17 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k22so3573811qtm.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jx9SX41huVcDZiGVXn4KLHGf8p6glxvggfevEnjr7ck=;
        b=LxZUYmW+vGsrD9WsnMdwwpO+3z98b/3TylSSaEs2WO6+8sBBPUIWJT8SK1UEMyHf3/
         J5VkdG5WcPeWLB+M0ZXGmPcsZ1/JMDVuA6kPMt++lkD/iIebit8/NJ6QfVOHsNEp7AuX
         JM0xZMAQNOu0EW1yv6FI16qk6gXgeDYh3XCCbzNECS22cdxucfUOTdKQouAcMhMA68VB
         4OACz8FmZgoTIf/B0wPdeoeMIbnb5Y6W/O83pCut5it/xxCy3V+a86SPYYYJN8ysiS1l
         3IjcFnhCo6ZmFj+UVtYupDNvGv9AhmtaSpOYs2d9EtVdxUJvxe8pJ67br84Svq3/ahUB
         fQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jx9SX41huVcDZiGVXn4KLHGf8p6glxvggfevEnjr7ck=;
        b=bcy4dfIm6zrB59Ihc84vSNPIpDdIJ3KL3Vdf3BQEYO5v6WljvJ09K5sdknm0NYpG9i
         PDW5bMNPJ+uxQlZmwyyqF7qjMnJ9PmsY2SZ+b5t8c1vl1Bmimtlo3+p160D+mKi+FEuy
         2DbiLarPDZ4XQiVQkLaGizu8EDxF5s3JsiAyK93+ImZJY8uMBCfl6SxgDbUeYRO2rdLN
         hKfwFYVpKdZj2kedFHlHZGhUmMHf0hX4/cdzvgd3dezOrjFjOpj9oX+PoZgriqS/DdI2
         sa0JWtkmA8RKAlpylFc4GRzH5HdaXZknacOiY1wJPgJh9g972oq07Hm+f2gdEBkgtZaa
         5zLg==
X-Gm-Message-State: AOAM5303YebQwqbrcH3Or/6FBafaHO98P8LtcrwnzNaFKKkLXEtRiFm9
        mvK4DgYxh2Lew7zXYDCYI+M3Ghg/+CNKfDg6S+BtdQ==
X-Google-Smtp-Source: ABdhPJygUAGiWPIVOy2S3rSccVsC239CPZ1BWXgy+//5Yp1P/kg1zrolxguOEZcIkdtH+ylTD1po5rTJXylKAHC13nc=
X-Received: by 2002:ac8:31f3:: with SMTP id i48mr2696778qte.128.1590561256702;
 Tue, 26 May 2020 23:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <3700190a602a6d30fcbf76e1eea667e29a65c4c9.1590474856.git.greentime.hu@sifive.com>
 <20200526140027.GC24212@redhat.com>
In-Reply-To: <20200526140027.GC24212@redhat.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Wed, 27 May 2020 14:34:05 +0800
Message-ID: <CAHCEehK7BnWUhjOAynCLP6puRo8EguMvf=N8iG5UMQmaD8ekCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 01/13] ptrace: Use regset_size() for dynamic regset size.
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> =E6=96=BC 2020=E5=B9=B45=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 05/26, Greentime Hu wrote:
> >
> > @@ -882,13 +882,18 @@ static int ptrace_regset(struct task_struct *task=
, int req, unsigned int type,
> >       const struct user_regset_view *view =3D task_user_regset_view(tas=
k);
> >       const struct user_regset *regset =3D find_regset(view, type);
> >       int regset_no;
> > +     unsigned int size;
> >
> > -     if (!regset || (kiov->iov_len % regset->size) !=3D 0)
> > +     if (!regset)
> >               return -EINVAL;
> >
> >       regset_no =3D regset - view->regsets;
> > -     kiov->iov_len =3D min(kiov->iov_len,
> > -                         (__kernel_size_t) (regset->n * regset->size))=
;
> > +     size =3D regset_size(task, regset);
> > +
> > +     if ((kiov->iov_len % size) !=3D 0)
> > +             return -EINVAL;
>
> Hmm. this doesn't look right.
>
> Before this patch we check "iov_len % regset->size", this is not the same
> as "iov_len % regset_size()".
>
> IOW, currently you can read/write, say, only the 1st register, you patch
> breaks this?
>

Hi Oleg,

Thank you. I misunderstood the meaning of regset->size
It seems I only needs to update this line, right?
- kiov->iov_len =3D min(kiov->iov_len,  (__kernel_size_t) (regset->n *
regset->size));
+ kiov->iov_len =3D min(kiov->iov_len,  (__kernel_size_t)
regset_size(task, regset));
