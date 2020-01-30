Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697A3C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3626B20702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBAEJadw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgA3MEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:04:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39724 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3MEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:04:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so3718980wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 04:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z8G2nDx9WHWYROzn/JgZ7wxgI6aKyyxtEyWYfcNEyQU=;
        b=lBAEJadw9ZYvQXQKdOzKpPzGlzoNVuJ5v8r8CqV5/4dLEX7pFlppZxDhGBnNKS8zJg
         1IJwI77FK7BfCt9DDChKiDlwctdHUiVGETSyISB3XQQJBNGEDuxVYjn9LtrQiWYzxSNH
         zUdyFclHkqpFZRR+FU7uX+I3wwLNkMZcXpc4xrfNB5p3DBKq3NweyhsZsb3QlVj10odu
         hORYJTmrEE9gI7xsMKDJIo9QTM6UDA5sxrjuJngvotZQUW3/YGh0Szgt1S/P7xw9lUi0
         oPi+6NGbist1gFAXJY4BfF7OAyI7oaItgjviiYZUuWG/eCOFpeZPNJxgfkyNQpJRyTXp
         eDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z8G2nDx9WHWYROzn/JgZ7wxgI6aKyyxtEyWYfcNEyQU=;
        b=ZcOTDEa7F0DS9DzOdH3IIyplIc/otK+aTZlK83w7uyHOHkW5ggKlBvCLnHKDKT+xXr
         5Db821hFS5GkyxE33BCGfffiu/18kHIXXdPiHcL4bzYuIzb6JqbpxFbaL5yqWauSglxW
         k8+CNDTCea2F2Nli28mp/5gi7h40HgaNRH9/V4/z4pnq5cJre3ROVaeBtwuWHmgazWu3
         kTq447Q5ofG2ppklzrwghxzpj3tiUilctgoM5+t0MNCJPAXy7IhcMRIP/eBCEW/vQYFw
         CGbP1IxtqyOubGI5VNwYCo3q+Bx4buG3s8L2v1QNIoO6V058CLPADAHUpBk/0JJ1Qvcn
         qqbQ==
X-Gm-Message-State: APjAAAVL7NmnjgWAwF/lLAsMZasdhZMARthRfTPXwNMcYDVCE+ZZI5bI
        UTwAK4U6/hTcSPMWjYx7GLo+wyuGsGyC6NZJH8Af0Q==
X-Google-Smtp-Source: APXvYqwzASac9mf2NAyJJfGelmUOl6rbaq8jYO/hT2mN6eGFmrIjyX5UL8P3rGADCUKdS4lGkDRtA6WFVE3c6ViZLoo=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr2806269wrv.196.1580385849232;
 Thu, 30 Jan 2020 04:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20200130064430.17198-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200130064430.17198-1-walter-zh.wu@mediatek.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 30 Jan 2020 13:03:58 +0100
Message-ID: <CAG_fn=X_jSUJXD932z9oN5hBa--n3Qct4zrjzGaPtb2MwJye7A@mail.gmail.com>
Subject: Re: [PATCH v3] lib/stackdepot: Fix global out-of-bounds in stackdepot
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 7:44 AM Walter Wu <walter-zh.wu@mediatek.com> wrote=
:

Hi Walter,

> If the depot_index =3D STACK_ALLOC_MAX_SLABS - 2 and next_slab_inited =3D=
 0,
> then it will cause array out-of-bounds access, so that we should modify
> the detection to avoid this array out-of-bounds bug.
>
> Assume depot_index =3D STACK_ALLOC_MAX_SLABS - 3
> Consider following call flow sequence:
>
> stack_depot_save()
>    depot_alloc_stack()
>       if (unlikely(depot_index + 1 >=3D STACK_ALLOC_MAX_SLABS)) //pass
>       depot_index++  //depot_index =3D STACK_ALLOC_MAX_SLABS - 2
>       if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) //enter
>          smp_store_release(&next_slab_inited, 0); //next_slab_inited =3D =
0
>       init_stack_slab()
>          if (stack_slabs[depot_index] =3D=3D NULL) //enter and exit
>
> stack_depot_save()
>    depot_alloc_stack()
>       if (unlikely(depot_index + 1 >=3D STACK_ALLOC_MAX_SLABS)) //pass
>       depot_index++  //depot_index =3D STACK_ALLOC_MAX_SLABS - 1
>       init_stack_slab(&prealloc)
>          stack_slabs[depot_index + 1]  //here get global out-of-bounds
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> ---
> changes in v2:
> modify call flow sequence and preconditon
>
> changes in v3:
> add some reviewers
> ---
>  lib/stackdepot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index ed717dd08ff3..7e8a15e41600 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -106,7 +106,7 @@ static struct stack_record *depot_alloc_stack(unsigne=
d long *entries, int size,
>         required_size =3D ALIGN(required_size, 1 << STACK_ALLOC_ALIGN);
>
>         if (unlikely(depot_offset + required_size > STACK_ALLOC_SIZE)) {
> -               if (unlikely(depot_index + 1 >=3D STACK_ALLOC_MAX_SLABS))=
 {
> +               if (unlikely(depot_index + 2 >=3D STACK_ALLOC_MAX_SLABS))=
 {

I don't think this is the right way to fix the problem.
You're basically throwing away the last element of stack_slabs[], as
we won't allocate anything from it.

How about we set |next_slab_inited| to 1 here:

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 2e7d2232ed3c..943a51eb746d 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -105,6 +105,8 @@ static bool init_stack_slab(void **prealloc)
                return true;
        if (stack_slabs[depot_index] =3D=3D NULL) {
                stack_slabs[depot_index] =3D *prealloc;
+               if (depot_index + 1 =3D=3D STACK_ALLOC_MAX_SLABS)
+                       smp_store_release(&next_slab_inited, 1);
        } else {
                stack_slabs[depot_index + 1] =3D *prealloc;
                /*

This will ensure we won't be preallocating pages once |depot_index|
reaches the last element, and we won't attempt to write those pages
anywhere either.

Could you please check if this fixes the problem for you?

>                         WARN_ONCE(1, "Stack depot reached limit capacity"=
);
>                         return NULL;
>                 }
> --
> 2.18.0



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
