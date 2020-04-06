Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B925FC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835A3206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="teYFQL2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgDFKna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:43:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44938 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgDFKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:43:30 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so5369998iok.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lOa9iM9gNScBNjatBpfkjLRP+ZnsCMVjbmqgaOoy0jY=;
        b=teYFQL2DoFbzlP36d4tP/jQ/B8sNS57A4EiRRVQddjrkDQB7wda38bPqOyOTsejIRj
         Aj+8ZeuqnnOy1ePMu2dWsTxMSf8ZKaTLs12Ho9BTO5KwBPFWoj1SspEZs3C3mwVFifMy
         5qtqDrpaFl2zNXdP2gzTf3CNTK6bcqK/8ppUvYmZ5SUq7XPoH9pr3Eq+TeoEGlkEunzs
         hGELaHjfLfxfWwzdGsv1tXUDCneRn7Lm8kjVBIT+90tuqYsbKV7a5o8ZFaB829gV9JH0
         541S6NzpVEX12ZzaMh2TIgtirPz76QnFH05KT8sLXrKxfhH/naZ/i6VGX4g5KrETxWZu
         6UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lOa9iM9gNScBNjatBpfkjLRP+ZnsCMVjbmqgaOoy0jY=;
        b=OKHmHNJpGiEXxT/p9AOwDiZ0qPZaGjfLuTXnjGK7mKC4HXS7i7z3kjfo359ITvnGXf
         y8RDi5IoBMgAziv6i0BnouRKqf3Zjmf+eeE5Xj9KsKcVOu3ITKJ/HfKHa7sBF1Sugdjy
         XPaIrr1kCzS/dtra/XP7S7YyYEQD+7WTCGJ3m2oZfWj7mG8NKoHxQDWA/j9QXI+eWeKv
         M9udtesFgSRI2g3I6gKW6lnCuJ87NbfNo1Dz8V4kkyqTyOzhNM0PCpFX7d71RpEZQmfk
         7CpfyDHpb+FxJ9oOoUgWenXj9MmAQw3F+awhXlCoMhV7bMd6Hjus5C7KwDtNvBIzt3dv
         3xxA==
X-Gm-Message-State: AGi0PubyxEskLw1UgVaAcUVfdw1guUkTB7L1ZeFqbGNLqpAsyRg3n07+
        vTuti9in6PxqiCCFcijyDX365tbfIV03HDhn/BAHSBb/JPNdNg==
X-Google-Smtp-Source: APiQypKURmlIu5ptF6JIEg04D/bJDjvWLtS7mUp0dkNvq8LOqS0jn08uLZI+ewzhEFnMLhuPV5RwdEgJG/tJ3mqs3E4=
X-Received: by 2002:a6b:491a:: with SMTP id u26mr19178084iob.30.1586169808881;
 Mon, 06 Apr 2020 03:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com>
 <20200405164006.GA1582475@kroah.com> <CAC_binJNLLxfOm0W2TuVTJZxJRTZTvPPocSDNQMU=21XO37oZg@mail.gmail.com>
 <20200406054110.GA1638548@kroah.com> <CAC_binJMn-uRNy1dwp=2fhF54R8DpaTZYskwEz3GNE-U0pShDQ@mail.gmail.com>
 <20200406082857.GA1646464@kroah.com>
In-Reply-To: <20200406082857.GA1646464@kroah.com>
From:   =?UTF-8?B?5a6L54mn5pil?= <songmuchun@bytedance.com>
Date:   Mon, 6 Apr 2020 18:42:46 +0800
Message-ID: <CAMZfGtURi4KDijw1=2JuTWxufcjypzS2_fEe0sGwXoAOUKbT5Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] driver core: Fix possible use after free
 on name
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Fei Zhang <zhangfeionline@gmail.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2020=E5=B9=B44=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:29=E5=86=99=E9=81=93=EF=BC=9A
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Mon, Apr 06, 2020 at 03:40:41PM +0800, Fei Zhang wrote:
> > Dear Greg,
> >
> > Mostly, "class_creat" is used in kernel driver module, basically
> > read-only strings,
> > but it is easier to use a local variable string. When writing drive mod=
ule,
> > it fails to judge the local variable string which cannot be passed in
> > only via interface.
> > I found that someone else may also face the same problem.
>
> An individual driver should NOT be creating a class, that is not what it
> is there for.

If someone want to create a virtual device, someone can call device_create(=
).
But the first argument is type of 'struct class *class', so we have to
call class_create()
before create device. So an individual driver may be creating a class, righ=
t?

>
> Class names are very "rare" and should not be dynamically created at
> all.

I have reviewed the code of the kstrdup_const() which is just below.

const char *kstrdup_const(const char *s, gfp_t gfp)
{
        if (is_kernel_rodata((unsigned long)s))
                return s;

        return kstrdup(s, gfp);
}

A readonly string which is in the kernel rodata, so we do not need to
dynamically allocate
memory to store the name. So with this patch applied, there is nothing
changed which
means that we did not waste memory. But it can prevent someone from
reading stale name
if an unaware user passes an address to a stack-allocated buffer.

So I think it is worth fixing, right?

--=20
Yours,
Muchun
