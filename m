Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91115C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC6C207BB
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591050495;
	bh=HZeHYKJaA5zfzUfWCv5xs+dYsYLFUWGAULPrEiyXdHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SqKbicryEmEXOStQj0e//J2UEV/RYp9o5mMD2yX+2oNOAf13WoZmQjc+uVLWMVjlw
	 3dyvH47XPNfrPmmtfSL3n31F1wi52nYG+EmwXbH51tu7Iut+/DxvsilqsPg2zupL+r
	 JMpGBnQ2DQu/BpTCR7hcCBjjZvTtKtC4FXjq7Se8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgFAW2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 18:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgFAW2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 18:28:14 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57335207DF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 22:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591050493;
        bh=HZeHYKJaA5zfzUfWCv5xs+dYsYLFUWGAULPrEiyXdHU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i6fw7Woj321Rj0NEBV5lz31PlvlC+0F5wCw2tEpvRtDhUZY17QTIZZB2fuiJRm32G
         a34qK0Q1RdyLGubyqCl8BZtDRu8Ylab2JFWWDfY3rvBcczS43wrRoKSzvar/rHf6OO
         v7xbiwqwbM9qYTqsNjIQ5Z4HrO+YCp9Gl6nFREEo=
Received: by mail-oo1-f54.google.com with SMTP id q188so1348499ooq.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 15:28:13 -0700 (PDT)
X-Gm-Message-State: AOAM532GVC9zcLSX9F3/FCD4hyRmJS9Wg+TnEEWY4N+eYw3RQvjkHZPz
        tQi2XQqN4/hSASjVlTlhk9PiAjr+PzlqXP0LpLw=
X-Google-Smtp-Source: ABdhPJx439ODktknmn00LL4bUu84xVfsoS2i+XtRQqynlW0jpzGZlCtf2Sa7BVPhzYl4dy9KZEUj0KvDav8V5PIXt9E=
X-Received: by 2002:a4a:b18a:: with SMTP id c10mr9200772ooo.41.1591050492222;
 Mon, 01 Jun 2020 15:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200521100952.GA5360@willie-the-truck> <20200521173738.GA29590@e121166-lin.cambridge.arm.com>
 <20200526202157.GE2206@willie-the-truck> <20200527134104.GA16115@e121166-lin.cambridge.arm.com>
 <20200601070459.GB8601@willie-the-truck> <CAKwvOdmXmxOdW_TJQmYBYDY8gDOacjDTcpSWQGATb2p_85tFAQ@mail.gmail.com>
 <CAMj1kXFQzBaZO+RGKs2iJOzW6rdEiAjdVc8PJ4U+KMWgCD9a6w@mail.gmail.com> <CAKwvOdnz-=GD9-taLQt6LDhs2Q-xgWmywCUA6skB0NJhubB+nw@mail.gmail.com>
In-Reply-To: <CAKwvOdnz-=GD9-taLQt6LDhs2Q-xgWmywCUA6skB0NJhubB+nw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 2 Jun 2020 00:28:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXErFuvOoG=DB6sz5HBvDuHDiKwWD8uOyLuxaX-u8-+dbA@mail.gmail.com>
Message-ID: <CAMj1kXErFuvOoG=DB6sz5HBvDuHDiKwWD8uOyLuxaX-u8-+dbA@mail.gmail.com>
Subject: Re: arm64/acpi: NULL dereference reports from UBSAN at boot
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 00:19, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Jun 1, 2020 at 2:57 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 1 Jun 2020 at 23:52, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > Anyways, it looks like the address of member from NULL subexpression
> > > looks problematic.  I wonder if offsetof can be used here?
> > >
> > > #define ACPI_OFFSET(d, f) ACPI_PTR_DIFF (offsetof(d, f), (void *) 0)
> > >
> > > Seems to work in my basic test case.  Untested in the kernel.
> > >
> > > IIUC, ACPI_OFFSET is trying to calculate the difference between the
> > > offset of a member of a struct and 0?  Isn't that the tautology `x - 0
> > > == x`?
> >
> > No. ACPI_OFFSET() is just a poor person's version of offsetof().
> >
> > (Note that it calculates the difference between &(((d *) 0)->f) and
> > (void *)0x0, so the 0x0 term is there on both sides)
>
> Got it. So we're trying to avoid including stddef.h?  Can
> __builtin_offsetof be used here?
> #define ACPI_OFFSET(d, f) ACPI_PTR_DIFF (__builtin_offsetof(d, f), (void *) 0)

Drop the 0x0:

#define ACPI_OFFSET __builtin_offsetof

should be all we need.

> The oldest version of GCC in godbolt.org (4.1) supports this builtin.

Yeah I think that should be fine.

Alternatively, using any arbitrary address other than 0x0 on both
sides should work as well to get rid of the undefined behavior
(assuming the use of NULL pointers is what is causing it), but I don't
see why we need to invent our own helper here.

BTW some other macros looks dodgy as well.
761f0b82393353507930b6721ae4311a9df2ca36 provides a nice set of
candidates to go and clean up.
