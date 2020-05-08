Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92292C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6684A208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THnNxIew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHGwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbgEHGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:52:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7718C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:52:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f11so537802ljp.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=snsveWT+yJB6VQ5fgjYi4vu754HWsLYGYs2/57IiIIs=;
        b=THnNxIewCJV4MBQ49YK3xWX6brA2V105UMphDKN/uYq0/0CIK/y4l1fcWiHiQ8m6gc
         P+yfSZep8hKMPuXDcEdPhTvbDB8aH8Za4pekl33uteo/mKqWS8f/A32ttRRYoAGM4F0w
         Qn4JpFG/AjGgkZwx+p/EHQ3Il/JOvTGx/H3epo9E+UK6ZcJeNtYvCdAxmigl91gu73Ch
         pmkb5eGaOds2e9IT9MK6uJRgTHoGN5235d9j0yVCDp5bQGROvfbPe4Uokz22O7+cSObp
         rqmM2I5SqqFV07IgcpdJTbFJIscQr2z2J3nkIA0P3W6mdaxkQ4agZQlo2xew99k1Zjhq
         u56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=snsveWT+yJB6VQ5fgjYi4vu754HWsLYGYs2/57IiIIs=;
        b=r+9Jy1MM0HOZRfWW5SNlFoC6eT/72RdNK7DvBaKcI981/MOclDNu7VLiY1ipcgrjSF
         wLz+kADjlUQ9CS+mwPN/KdR4g0fXuMULqaKXhhlU6HOUD7D9CQn/poKWipyejkbcoPaQ
         ubnAAowUmzBl8MMWe7Ni7tZU2iKJGHP4NBiVqqxIkmOKRrbyFkMQLgxlRQNHI18tuv0K
         JoCKu/SC5qJyGfuJBcaIcfJAtXpVj7XTOBqtJ3n85AZkpujItzrjhDwRRK4wJ25War2L
         mtpNR0SY32oZXRrjzV2ysPt7K461oYp40tG7IcakyeL6BtOKh0Lv2onxdOJJ4ZRCT+g6
         C0Iw==
X-Gm-Message-State: AOAM531o0pL0TAj1RsDq4kH39Axy9L3Umy6XAco2ho2EbRmKuPXZJGwn
        9o0rOeZ93hJnAjnOhfnZVzlixGGC3i55JsZTbe8=
X-Google-Smtp-Source: ABdhPJxFvsxgr5OOUyQJFD7RtgZRdaymEEM49pe0hHmyFol7gUWYsHeqvu9yxLU8P+92BEGP+F20Y0NTXpyukJ1MZTQ=
X-Received: by 2002:a2e:361a:: with SMTP id d26mr657621lja.171.1588920726023;
 Thu, 07 May 2020 23:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200508011603.54553-1-yuchao0@huawei.com> <CACOAw_xxS_Wf==KnD31f9AOMu+QUs3WacowsfcD6w4A9n2AkTg@mail.gmail.com>
 <0d41e29e-c601-e016-e471-aed184ca4a6a@huawei.com> <CACOAw_z39D=2GONkMaQX6pSi2z26nqCvBZwZK-M=n3_yc84+yg@mail.gmail.com>
 <2a241a80-2597-ef9e-62b5-cf2b8bdb33c4@huawei.com>
In-Reply-To: <2a241a80-2597-ef9e-62b5-cf2b8bdb33c4@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 8 May 2020 15:51:54 +0900
Message-ID: <CACOAw_xmar1vv6yFu0DNzNjXq6eqXiVU-uxqQGjs3dUEHBWf_g@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix zstd data corruption
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great, thanks for checking~! :)


2020=EB=85=84 5=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:42, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/5/8 11:30, Daeho Jeong wrote:
> > I am a little bit confused.
> >
> > In compress_log=3D2 (4 pages),
> >
> > Every compression algorithm will set the cc->nr_cpages to 5 pages like =
below.
> >
> >         max_len =3D COMPRESS_HEADER_SIZE + cc->clen;
> >         cc->nr_cpages =3D DIV_ROUND_UP(max_len, PAGE_SIZE);
> >
> >         cc->cpages =3D f2fs_kzalloc(sbi, sizeof(struct page *) *
> >                                         cc->nr_cpages, GFP_NOFS);
> >
> > And call cops->compress_pages(cc) and the returned length of the compre=
ssed data will be set to cc->clen for every case.
> > And if the cc->clen is larger than max_len, we will give up compression=
.
> >
> >         ret =3D cops->compress_pages(cc);
> >         if (ret)
> >                 goto out_vunmap_cbuf;
> >
> >         max_len =3D PAGE_SIZE * (cc->cluster_size - 1) - COMPRESS_HEADE=
R_SIZE;
> >
> >         if (cc->clen > max_len) {
> >                 ret =3D -EAGAIN;
> >                 goto out_vunmap_cbuf;
> >         }
> >
> > So, with your patch, we will just use 3 pages for ZSTD and 5 pages for =
LZO and LZ4 now.
> > My question was whether it is also possible to decrease the compression=
 buffer size for LZO and LZ4 to 3 pages like ZSTD case.
> > I was just curious about that. :)
> I guess we can change LZ4 as we did for ZSTD case, since it supports part=
ially
> compression:
>
> - lz4_compress_pages
>  - LZ4_compress_default
>   - LZ4_compress_fast
>    - LZ4_compress_fast_extState
>     if (maxOutputSize < LZ4_COMPRESSBOUND(inputSize))
>      - LZ4_compress_generic(..., limitedOutput, ...)
>       - if (outputLimited && boundary_check_condition) return 0;
>
> And for LZO case, it looks we have to keep to allocate 5 pages for worst
> compression case as it doesn't support partially compression as I checked=
.
>
> Thanks,
>
> >
> >
> > 2020=EB=85=84 5=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 11:4=
8, Chao Yu <yuchao0@huawei.com <mailto:yuchao0@huawei.com>>=EB=8B=98=EC=9D=
=B4 =EC=9E=91=EC=84=B1:
> >
> >     Hi Daeho,
> >
> >     On 2020/5/8 9:28, Daeho Jeong wrote:
> >     > Hi Chao,
> >     >
> >     > IIUC, you are trying not to use ZSTD_compressBound() to save the =
memory
> >     > space. Am I right?
> >     >
> >     > Then, how about LZ4_compressBound() for LZ4 and lzo1x_worst_compr=
ess() for
> >     > LZO?
> >
> >     Oops, it looks those limits were wrongly used...
> >
> >     #define LZ4_COMPRESSBOUND(isize)        (\
> >             (unsigned int)(isize) > (unsigned int)LZ4_MAX_INPUT_SIZE \
> >             ? 0 \
> >             : (isize) + ((isize)/255) + 16)
> >
> >     #define lzo1x_worst_compress(x) ((x) + ((x) / 16) + 64 + 3 + 2)
> >
> >     Newly calculated boundary size is larger than target buffer size.
> >
> >     However comments on LZ4_compress_default() said:
> >
> >     ...
> >      * @maxOutputSize: full or partial size of buffer 'dest'
> >      *      which must be already allocated
> >     ...
> >     int LZ4_compress_default(const char *source, char *dest, int inputS=
ize,
> >             int maxOutputSize, void *wrkmem);
> >
> >     And @out_len in lzo1x_1_compress() was passed as an output paramete=
r to
> >     pass length of data that compressor compressed into @out buffer.
> >
> >     Let me know if I missed sth.
> >
> >     Thannks,
> >
> >     > Could we save more memory space for these two cases like ZSTD?
> >     > As you know, we are using 5 pages compression buffer for LZ4 and =
LZO in
> >     > compress_log_size=3D2,
> >     > and if the compressed data doesn't fit in 3 pages, it returns -EA=
GAIN to
> >     > give up compressing that one.
> >     >
> >     > Thanks,
> >     >
> >     > 2020=EB=85=84 5=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=
=84 10:17, Chao Yu <yuchao0@huawei.com <mailto:yuchao0@huawei.com>>=EB=8B=
=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >     >
> >     >> During zstd compression, ZSTD_endStream() may return non-zero va=
lue
> >     >> because distination buffer is full, but there is still compresse=
d data
> >     >> remained in intermediate buffer, it means that zstd algorithm ca=
n not
> >     >> save at last one block space, let's just writeback raw data inst=
ead of
> >     >> compressed one, this can fix data corruption when decompressing
> >     >> incomplete stored compression data.
> >     >>
> >     >> Signed-off-by: Daeho Jeong <daehojeong@google.com <mailto:daehoj=
eong@google.com>>
> >     >> Signed-off-by: Chao Yu <yuchao0@huawei.com <mailto:yuchao0@huawe=
i.com>>
> >     >> ---
> >     >>  fs/f2fs/compress.c | 7 +++++++
> >     >>  1 file changed, 7 insertions(+)
> >     >>
> >     >> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> >     >> index c22cc0d37369..5e4947250262 100644
> >     >> --- a/fs/f2fs/compress.c
> >     >> +++ b/fs/f2fs/compress.c
> >     >> @@ -358,6 +358,13 @@ static int zstd_compress_pages(struct compr=
ess_ctx
> >     >> *cc)
> >     >>                 return -EIO;
> >     >>         }
> >     >>
> >     >> +       /*
> >     >> +        * there is compressed data remained in intermediate buf=
fer due to
> >     >> +        * no more space in cbuf.cdata
> >     >> +        */
> >     >> +       if (ret)
> >     >> +               return -EAGAIN;
> >     >> +
> >     >>         cc->clen =3D outbuf.pos;
> >     >>         return 0;
> >     >>  }
> >     >> --
> >     >> 2.18.0.rc1
> >     >>
> >     >>
> >     >>
> >     >> _______________________________________________
> >     >> Linux-f2fs-devel mailing list
> >     >> Linux-f2fs-devel@lists.sourceforge.net <mailto:Linux-f2fs-devel@=
lists.sourceforge.net>
> >     >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >     >>
> >     >
> >
