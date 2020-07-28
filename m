Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1761EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8BD20656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgG1IL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:11:28 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46039 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgG1IL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:11:28 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MpUQk-1kaUra2onc-00prHa for <linux-kernel@vger.kernel.org>; Tue, 28 Jul
 2020 10:11:26 +0200
Received: by mail-qt1-f173.google.com with SMTP id o22so14007332qtt.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:11:26 -0700 (PDT)
X-Gm-Message-State: AOAM533I0MCZMMm4bkcrDqnXkua4Bmq8Tg8TO9EFRR8aV6ZlMS26+VzJ
        NVK/GpIMEKqS5tTNOFpWN5hF0iFOJU4kgiSgzsI=
X-Google-Smtp-Source: ABdhPJxCGAB7BbsjfSD7bgaCnwv1WyrC1BKE9mDKkcAW39Ma3IJ37NCcsslzqEKXCuFNjQfzfNsrIHGbS8NsRXh+AwY=
X-Received: by 2002:aed:2946:: with SMTP id s64mr5570242qtd.204.1595923885496;
 Tue, 28 Jul 2020 01:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200728014343.341303-1-yepeilin.cs@gmail.com>
In-Reply-To: <20200728014343.341303-1-yepeilin.cs@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Jul 2020 10:11:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a29=CugbGtZRQc0abGXvexp=gBk+LwOCG3yNCPakup+NQ@mail.gmail.com>
Message-ID: <CAK8P3a29=CugbGtZRQc0abGXvexp=gBk+LwOCG3yNCPakup+NQ@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/bufs: Prevent kernel-infoleak
 in copy_one_buf()
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4+NRdEqI9UaJWac6rKJR1ddUm9iY1HTXJetD4N7Z1KMrrkx9rtb
 ALAiPNHYiuisNi+dGEEUz81Yz4lx5dxsG+OI7E7EYDGU/w9RthD1wq+oELe6Q0xAkqofc7a
 4Yiq4xEYe4EhXXe8JQAB53DeEi7At6ZxRyoVi2b02UQlbPFwGSQJ6FvNUjMXShiXzc+s7+j
 4XyeKjxgFWAD5N1KwBK5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:28gqUn+saW8=:xhBrTZMAt1g/3Xyc7v9Hkv
 1cFfIo7TuuGga3RrVx0SMFQPAqx9DgaJZmb/jF8+9ZJEa3OYlr2HHQN6A8oVwumYvQGbmJ2v4
 Hx0MNVl1yQITTDl7iUoWhor5VogOg9Lkd7pQfbAgscpfnYQzNb3L3e2/rX8UE/j5tZVja+T9i
 y8Lz8OTGLeuc38vwN51jzsjOlfuSIJww7a650hVR0zgMUpMNeEKXdurUM5RV/Y2+vrTCY8oFU
 sxKChQq7/nZHBueeUAqY41CrJi8EWj4e118kGdkoi3ArGGqOLf6ClYjp12V9ZwHu62JHKWNUT
 OsHP6O8OAAHDXgiEy7uKNplhpGMFyGHzyBZuXMtCmj4T8hEqgMfIF2m3Qcy+5woGyLX6ctXEF
 blJ40O7LeHYy8sKoAx5PSoa/IJOUSsuVsOogiEXzGWPjyALSHmiBHRhT8xmSwW0ViL1xuIUo5
 e31U3HFNNoVl3AdkFmM6whI7QhEvb/gsykUQrSVDurbB43lOkoTLgcpv3a9ryGUllsUWyvAyI
 1IKe8RsAkDOaLb2BQU0YA/Lq8v6iVQX8W4qMe1jTFldOJYchpvaLKDHmHvtk4cbSymPDElEs2
 u+pE4iNPqzjlEjFPNlo0Cl5R2AYw35/HgmVTvLVA2zxBtHaImi093wyNNo2fcDSg3h4ssFRXO
 Yj/fGOu+78PC7NdakuyWeWmHsdq50UBzhA120OnplRusdScFCSaVm+Tyxge5kDmsrz+3A1C35
 kzghqsYsBv5PAC5rKla1RuM0XO2+ejbZRQqsfns93/b22YXyH/Td0GyBQxI9Ae08sMG6TRFN7
 94a2pATfXJ2ziEEIglau5xB6AhhRixgDRYepRCgnoNkmLQSBdSxxQ5yIt5REO3+LAevL7+ouh
 lWCqXGBAqalDXNDwNb0lBaO3DzGE2d7TQXcXVjj/uHOZ+R1W7F8lO98cYOKHiZPBqYYBD4p+d
 was/8OUMIAMCMeilshMk3jPsEGeR/OemPX9Z7ZKbeRY4mE5xHSOiQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 3:45 AM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> copy_one_buf() is copying uninitialized stack memory to userspace due to
> the compiler not initializing holes in statically allocated structures.
> Fix it by initializing `v` with memset().

I would add 'potentially' somewhere in that description: it is architecture
dependent whether there are holes in this structure as 'enum' types
and 'long' are both dependent on the ABI, and even if there is a hole,
it is undefined behavior whether the hold gets initialized.

Other than that, the patch looks good.

> Cc: stable@vger.kernel.org
> Fixes: 5c7640ab6258 ("switch compat_drm_infobufs() to drm_ioctl_kernel()")
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  drivers/gpu/drm/drm_bufs.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
> index a0735fbc144b..f99cd4a3f951 100644
> --- a/drivers/gpu/drm/drm_bufs.c
> +++ b/drivers/gpu/drm/drm_bufs.c
> @@ -1349,10 +1349,14 @@ static int copy_one_buf(void *data, int count, struct drm_buf_entry *from)
>  {
>         struct drm_buf_info *request = data;
>         struct drm_buf_desc __user *to = &request->list[count];
> -       struct drm_buf_desc v = {.count = from->buf_count,
> -                                .size = from->buf_size,
> -                                .low_mark = from->low_mark,
> -                                .high_mark = from->high_mark};
> +       struct drm_buf_desc v;
> +
> +       memset(&v, 0, sizeof(v));
> +
> +       v.count = from->buf_count;
> +       v.size = from->buf_size;
> +       v.low_mark = from->low_mark;
> +       v.high_mark = from->high_mark;
>
>         if (copy_to_user(to, &v, offsetof(struct drm_buf_desc, flags)))
>                 return -EFAULT;
> --
> 2.25.1
>
