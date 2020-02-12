Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B08C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7E920714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSzKAPAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgBLJ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:56:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33785 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgBLJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:56:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so4296738wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 01:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TQ1zZ0ymxed3qDUIKzHztDCn/dmuH3K9mD8Ys8Cv5Zg=;
        b=vSzKAPAlhQfj6c5BBo0DJVK/oJZyyREHyhZxD2KH6/eUQlsWH5ZKJ6Ell6NTySerhS
         JtNqWCr5hvfRH2rwfrAsH0hFFuOE7sAbrbKbKJLjzly6g1AvBy/RTsOLEstww+zjxFAj
         F5L3fpc2l7cUbROSLZpd7KUNtUIc0snHYV5OZp6uw2StV86v4UIUpWRCLYJRiaQ3em8V
         RZfH+6IcUUsc/F4wpvlUKvVD7Oz9sFwpMn9T+ZeQasaXKbvQcpq0e85h6NZYGweXxYpZ
         UR4w33lPZjCxrGQTysv3tfuLuEpnv0N32q13CiFbmviyhIBJGQEc1mz/xVN66ejuPaXM
         weyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TQ1zZ0ymxed3qDUIKzHztDCn/dmuH3K9mD8Ys8Cv5Zg=;
        b=juJY3EOAR0eV+s5tv2LOt7cWdKyIPtcSiV5zxSKu1Bi/0bSCpuiuObdWHSqeXTGv1c
         iNwY2vHVDGjCyjFPHr5IlzQhsOK0Xq67ZxTbjoSPQNs+JZtPa4qYk5DOPYqQx1YMmRfp
         /vF2KZwI8iEZuB6XjVXfjhBAFwbem6DJvfXhqBLlTfEnfqmuHgXgtrCfkq2rcjSB3oKR
         Pi2DSDgMPPGVXX606ZrkHFkj/xvkAaYioezzahFUsRdHIExJKOfMem8AfRSAMg0GjcH9
         l8WCnJbWMce/t0BwmCbIJ8EJDi0himMNCBFc2D0X8CRUmmZ3KnRJqxbIIuvmslPvtISv
         kleQ==
X-Gm-Message-State: APjAAAUtsOOcXDLZG/YVZ5YoVcH8tB0zXSC54OBmkRqlFtL3KV3fWUsn
        A/oL8r4sQCfI+5Ra4RQP5OFoGqR5UuoyPE088py93w==
X-Google-Smtp-Source: APXvYqwdQOlZL+9n02L0y3DZwmpPu/bhWs5U9xIRVwqxkOLt3sm0Ui1jW+zICNwJCat78vUel/DjHk1hX+QpYpnqLEY=
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr12083830wme.21.1581501387602;
 Wed, 12 Feb 2020 01:56:27 -0800 (PST)
MIME-Version: 1.0
References: <1581501228-5393-1-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1581501228-5393-1-git-send-email-wang.yi59@zte.com.cn>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 12 Feb 2020 10:56:16 +0100
Message-ID: <CAG_fn=UGmEMyjASasZTK3cXAZzJ4tb9wCGsW1FoA+kPNJiW1Gw@mail.gmail.com>
Subject: Re: [PATCH] lib: Use kzalloc() instead of kmalloc() with flag GFP_ZERO.
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Huang Zijiang <huang.zijiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:54 AM Yi Wang <wang.yi59@zte.com.cn> wrote:
>
> From: Huang Zijiang <huang.zijiang@zte.com.cn>
>
> Use kzalloc instead of manually setting kmalloc
> with flag GFP_ZERO since kzalloc sets allocated memory
> to zero.
>
> Change in v2:
>     add indation
>
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
>  lib/test_kasan.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 328d33b..79be158 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -599,7 +599,7 @@ static noinline void __init kasan_memchr(void)
>         size_t size =3D 24;
>
>         pr_info("out-of-bounds in memchr\n");
> -       ptr =3D kmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +       ptr =3D kzalloc(size, GFP_KERNEL);
>         if (!ptr)
>                 return;
>
> @@ -614,7 +614,7 @@ static noinline void __init kasan_memcmp(void)
>         int arr[9];
>
>         pr_info("out-of-bounds in memcmp\n");
> -       ptr =3D kmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +       ptr =3D kzalloc(size, GFP_KERNEL);
>         if (!ptr)
>                 return;
>
> @@ -629,7 +629,7 @@ static noinline void __init kasan_strings(void)
>         size_t size =3D 24;
>
>         pr_info("use-after-free in strchr\n");
> -       ptr =3D kmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +       ptr =3D kzalloc(size, GFP_KERNEL);
>         if (!ptr)
>                 return;
>
> --
> 1.9.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/1581501228-5393-1-git-send-email-wang.yi59%40zte.com.cn.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
