Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487E2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E952206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KHPHmp6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgGGLZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:25:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41962 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGGLZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:25:41 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2A3D720B7188
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:25:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A3D720B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594121140;
        bh=BKCVWRXZ9Ouj0n7PqqzxeeGd+C5Mkj0pv5/dEZdQLBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KHPHmp6MOjLDjSWpfdMLhmd3kPhW54SLhux4xCryDsPpaLs7/m+NhDkAzbJaf4LLa
         5BJHl7M05taXyw1zCtwFQlR8zE4/4UZW+ITNHyFsVR3YePoMkzRMqMFIa5mbw14bu9
         R0xhMHCCjpzzywRQ+BdunPV9kZilKKN+g0G+1h1s=
Received: by mail-qv1-f48.google.com with SMTP id el4so14532807qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:25:39 -0700 (PDT)
X-Gm-Message-State: AOAM533fsjS5t1MKidElirPOUKxbzHJY62+zpbqOFLTL5UYXL31Wfq/0
        7wkigznzalmX3wmDPlzMWCaM+J9j/osp/f6UJMs=
X-Google-Smtp-Source: ABdhPJxvEFlnazCDXb2cYPOR5tRT5OGOgIi9kX280zN5a24Hw9bRN9xhHeezGiQMrH5qE4yklpe8eJPzAklsBpKgd+0=
X-Received: by 2002:a0c:e3d0:: with SMTP id e16mr52296966qvl.250.1594121138978;
 Tue, 07 Jul 2020 04:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200706234045.9516-1-mcroce@linux.microsoft.com> <202007061852.5B9A0F9ED@keescook>
In-Reply-To: <202007061852.5B9A0F9ED@keescook>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 7 Jul 2020 13:25:02 +0200
X-Gmail-Original-Message-ID: <CAFnufp1WJxhE_Rj=+BdPwDhoKQe9kZCRVfpmgRiTxS2m7xKRjA@mail.gmail.com>
Message-ID: <CAFnufp1WJxhE_Rj=+BdPwDhoKQe9kZCRVfpmgRiTxS2m7xKRjA@mail.gmail.com>
Subject: Re: [PATCH] pstore/platform: build fix when crypto API are disabled
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 4:37 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jul 07, 2020 at 01:40:45AM +0200, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > When building a kernel with CONFIG_PSTORE=y and CONFIG_CRYPTO not set,
> > a build error happens:
> >
> >     ld: fs/pstore/platform.o: in function `pstore_dump':
> >     platform.c:(.text+0x3f9): undefined reference to `crypto_comp_compress'
> >     ld: fs/pstore/platform.o: in function `pstore_get_backend_records':
> >     platform.c:(.text+0x784): undefined reference to `crypto_comp_decompress'
> >
> > This because some pstore code uses crypto_comp_(de)compress
> > regardless of the CONFIG_CRYPTO status.
> > Fix it by wrapping the (de)compress usage by IS_ENABLED(CONFIG_PSTORE_COMPRESS)
>
> I'm surprised this hasn't come up before in a randconfig! But I guess
> it'd require a very lucky config: picking CONFIG_PSTORE but not
> CONFIG_CRYPTO _and_ 0 of the many compression options in pstore. :P
>
> But yes, I can reproduce this with:
>
> # CONFIG_CRYPTO is not set
> CONFIG_PSTORE=y
> # CONFIG_PSTORE_DEFLATE_COMPRESS is not set
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> # CONFIG_PSTORE_842_COMPRESS is not set
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
>
> >
> > Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> > ---
> >  fs/pstore/platform.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> > index a9e297eefdff..6022d8359f96 100644
> > --- a/fs/pstore/platform.c
> > +++ b/fs/pstore/platform.c
> > @@ -436,7 +436,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
> >                                         dst_size, &dump_size))
> >                       break;
> >
> > -             if (big_oops_buf) {
> > +             if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && big_oops_buf) {
> >                       zipped_len = pstore_compress(dst, psinfo->buf,
> >                                               header_size + dump_size,
> >                                               psinfo->bufsize);
> > @@ -668,7 +668,7 @@ static void decompress_record(struct pstore_record *record)
> >       int unzipped_len;
> >       char *unzipped, *workspace;
> >
> > -     if (!record->compressed)
> > +     if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !record->compressed)
> >               return;
> >
> >       /* Only PSTORE_TYPE_DMESG support compression. */
> > --
> > 2.26.2
>
> This report also reminds me that I want to stop hard-coding the possible
> compressors[1].
>
> Regardless, for now, I'd like a slightly different patch, which pokes
> pstore_compress() instead of doing it inline in pstore_dump():
>
>
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index a9e297eefdff..36714df37d5d 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -269,6 +269,9 @@ static int pstore_compress(const void *in, void *out,
>  {
>         int ret;
>
> +       if (!IS_ENABLED(CONFIG_PSTORE_COMPRESSION))
> +               return -EINVAL;
> +
>         ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
>         if (ret) {
>                 pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
> @@ -668,7 +671,7 @@ static void decompress_record(struct pstore_record *record)
>         int unzipped_len;
>         char *unzipped, *workspace;
>
> -       if (!record->compressed)
> +       if (!IS_ENABLED(CONFIG_PSTORE_COMPRESSION) || !record->compressed)
>                 return;
>
>         /* Only PSTORE_TYPE_DMESG support compression. */
>
>
>
> Let me know if that works for you (it fixes it on my end).
>

Yes, it works for me!

-- 
per aspera ad upstream
