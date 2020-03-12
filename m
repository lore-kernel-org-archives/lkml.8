Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C05C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AF4206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IP3ABait"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCLMGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:06:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46595 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCLMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:06:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so7071579wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 05:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WpIF59sushRUzQN6JFPoJ2ob7mS8MGSjQgRAtDMNHBs=;
        b=IP3ABaitp1o1i8i4tS3GZkiE1lze4gcNrgfGixIs7X3iDBfMmRoX/QUCwfKK7Pubt3
         WJaqkGTvHbPJ2dZW3uq0Z6X7ryK1WqR33Nif/+lQatPxW9IsShhy+1yFhCCNChpDYWAq
         lecZu/uTsgJ7MIAF1utJOaOP9y9rggX0E47GI4019g6VNBxeKB56MhFtQb7GJRrresdF
         Xe7XEsR59mrvqopwsswO3pSiaKe+svMQ0B8GKFICSceRWiDXnt+9Vbvq9eBsatrtOkFT
         lHL8Qm0x/C7DNVKolSUtm5K7MTa0X0N/nXw52GHc4PHBrxxSyaykpCie5jqGmVqCl8Iw
         QyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WpIF59sushRUzQN6JFPoJ2ob7mS8MGSjQgRAtDMNHBs=;
        b=B4wFvInwREfmPUj0hLD8O0EdR9TcJMtzJP5p6flgGmmaTr7EDTF7HHPDOpO2zuV9tG
         3fR/dCcUXbqI97WpDC/hom+fg+GYLpm3KptH77klC2mo/zyloMbiWUHBNrs6yO6ZOHwC
         UqLrzsvN5YRa58zMIQt8FmCggtNkry10kq1x7XTQg4zV1+Wk8Ylj0+eHdhdu9VdOmI0I
         9H8UAvG4hdZMo6mbcYvVKfm/NWOHeXSKd2cuMGdL2BvhGlOMUXzghizce3Ocqm/YCbQe
         QqJ5i5GZiwEdY+u7Y2hcia+PUgup22pK2FB7efIis+SMfHA+thz9AylgJ0WPyhb2c2No
         K79A==
X-Gm-Message-State: ANhLgQ1HtoLd2mPjA9BNzMOfuB3toets13BfQ4z5P4Wl+Iyo64p4dd3k
        D3lM/qYYdJM4k16a4a2rJiYtdvRPAW7nqLsT8iEOzA==
X-Google-Smtp-Source: ADFU+vuG4nmHESpyz83ycBTMualHGTG00Wir4cgLn4BKFEmt3VQqAC1YdhwQi5UUXGr4YGTw3WJ7f7+rh1jsecG7oNs=
X-Received: by 2002:adf:e98c:: with SMTP id h12mr10978634wrm.345.1584014794085;
 Thu, 12 Mar 2020 05:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200312113006.GA20562@mwanda>
In-Reply-To: <20200312113006.GA20562@mwanda>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Mar 2020 13:06:23 +0100
Message-ID: <CAG_fn=WP0xeCaWpWzhzvT-uxW4w1dvVvxZ=yBGKGTNFwjD=gJw@mail.gmail.com>
Subject: Re: [PATCH] lib/stackdepot.c: fix a condition in stack_depot_fetch()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miles Chen <miles.chen@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:30 PM Dan Carpenter <dan.carpenter@oracle.com> w=
rote:
>
> We should check for a NULL pointer first before adding the offset.
> Otherwise if the pointer is NULL and the offset is non-zero, it will
> lead to an Oops.

 Thanks!

> Fixes: d45048e65a59 ("lib/stackdepot.c: check depot_index before accessin=
g the stack slab")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Alexander Potapenko <glider@google.com>

> ---
>  lib/stackdepot.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index da5d1880bf34..2caffc64e4c8 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -207,18 +207,16 @@ unsigned int stack_depot_fetch(depot_stack_handle_t=
 handle,
>         size_t offset =3D parts.offset << STACK_ALLOC_ALIGN;
>         struct stack_record *stack;
>
> +       *entries =3D NULL;
>         if (parts.slabindex > depot_index) {
>                 WARN(1, "slab index %d out of bounds (%d) for stack id %0=
8x\n",
>                         parts.slabindex, depot_index, handle);
> -               *entries =3D NULL;
>                 return 0;
>         }
>         slab =3D stack_slabs[parts.slabindex];
> -       stack =3D slab + offset;
> -       if (!stack) {
> -               *entries =3D NULL;
> +       if (!slab)
>                 return 0;
> -       }
> +       stack =3D slab + offset;
>
>         *entries =3D stack->entries;
>         return stack->size;
> --
> 2.20.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
