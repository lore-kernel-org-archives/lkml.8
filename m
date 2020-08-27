Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C92C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9F42177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XunWIOHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgH0Mmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgH0MXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:23:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE1C061235
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:23:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so3231691pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wRmOM+lY0GqSNROHa6fviQnhx1T7htrFs5kxwy8CYOE=;
        b=XunWIOHVfK46PUPdGCFBrt6DQrmEql78iGdRDQ0dSgBP6EPJpisz0AG6MSEfUeoyQj
         /lI1wGZYoKgNcrxl3LKW3RLbNXEcrC78QEzcnUPfdHnazq2tWJ72wCR469Kh6xWUcauR
         u9N+UjKuxt4IRdttNS3wQRF3v8JWH8b+Y9mALm0rmTs8glD8Jw/c7OTRm6uSa+7tVg2o
         iHt3MzI9VXbVQ2/T17enKfOtCOwkE+0VIPNyAbU22DRTzsXIVN67aTRaQdAZumBCJzST
         VFEYlB2yVkK/oGveiTrKmeJkiCGShajE4Fm2aH2CIoyfOugohZ09a3FRn2Zb7NqUZfLC
         Qmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wRmOM+lY0GqSNROHa6fviQnhx1T7htrFs5kxwy8CYOE=;
        b=A/3dajj/wdYVerrb1ereCbAZvvYw9KRtsZIvzaiV3VSsUqJmACvMmlPcpoHF2X+vV8
         4rltG7ESa31Gm905uplkH7SRXTI8H1D/896vrX9hCG4PzNuq0LhtoCM1ZmixI0poZzt7
         Sk0CUWFokQDm/yFFzMvMUyquK/nziQbVo5cATeZTxubzJ94dSG5eBnwGRrdK32YoxXHz
         QcpDmjbTQpOTXtQmQKe1hg26wcu8VJzFgGRVVXBtsNRHIpmcXSE66YSZu0g50LV9uP/W
         PPtlW8qV/4nQIXDvrl3hiOu6RC6UEOY1cmBry45ZRqoQP7CXfMMnKYO6DZdCSW8YIMLQ
         szfA==
X-Gm-Message-State: AOAM531ssX5xtuNpCEOTGIev5D/ELuXpBFEkFwKlphueA/aJpHOM0t87
        CgLgsWMza8ZX1KxdLgGJLgMwjlgflIa5U3U5RqDaxw==
X-Google-Smtp-Source: ABdhPJyPMy1rnX8KIgwVSqzPqTkYUTZKABfqU1VKffDJp9ShtMn+0fBihbauCAdMKqIPYGStK6xy+LlF4EdY3vc9i3E=
X-Received: by 2002:a63:4c:: with SMTP id 73mr14564236pga.286.1598530986286;
 Thu, 27 Aug 2020 05:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <8a499341bbe4767a4ee1d3b8acb8bd83420ce3a5.1597425745.git.andreyknvl@google.com>
 <b7884e93-008f-6b9f-32d8-6c03c7e14243@arm.com>
In-Reply-To: <b7884e93-008f-6b9f-32d8-6c03c7e14243@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Aug 2020 14:22:55 +0200
Message-ID: <CAAeHK+x+DMs9jdeB58XaoJTO-kv+iiWT1_BuhYiJzJH-DoY9EQ@mail.gmail.com>
Subject: Re: [PATCH 25/35] kasan: introduce CONFIG_KASAN_HW_TAGS
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 1:31 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 8/14/20 6:27 PM, Andrey Konovalov wrote:
> > +config=C2=B7KASAN_HW_TAGS
> > +=C2=BB bool=C2=B7"Hardware=C2=B7tag-based=C2=B7mode"
> > +=C2=BB depends=C2=B7on=C2=B7HAVE_ARCH_KASAN_HW_TAGS
> > +=C2=BB depends=C2=B7on=C2=B7SLUB
> > +=C2=BB help
> > +=C2=BB =C2=B7=C2=B7Enables=C2=B7hardware=C2=B7tag-based=C2=B7KASAN=C2=
=B7mode.
> > +
> > +=C2=BB =C2=B7=C2=B7This=C2=B7mode=C2=B7requires=C2=B7both=C2=B7Memory=
=C2=B7Tagging=C2=B7Extension=C2=B7and=C2=B7Top=C2=B7Byte=C2=B7Ignore
> > +=C2=BB =C2=B7=C2=B7support=C2=B7by=C2=B7the=C2=B7CPU=C2=B7and=C2=B7the=
refore=C2=B7is=C2=B7only=C2=B7supported=C2=B7for=C2=B7modern=C2=B7arm64
> > +=C2=BB =C2=B7=C2=B7CPUs=C2=B7(MTE=C2=B7added=C2=B7in=C2=B7ARMv8.5=C2=
=B7ISA).
> > +
>
> I do not thing we should make KASAN_HW_TAGS MTE specific especially becau=
se it
> is in the common code (e.g. SPARC ADI might want to implement it in futur=
e).
>
> Probably would be better to provide some indirection in the generic code =
an
> implement the MTE backend entirely in arch code.
>
> Thoughts?

I think we can reword the help text to say that it enables tag-based
KASAN mode that is backed by the hardware in general, and mention that
this is currently only implemented for arm64 through MTE. I don't
think it makes sense to provide a common arch interface at this point
to keep the code simpler. We can do that when (and if) another
hardware backend is added.
