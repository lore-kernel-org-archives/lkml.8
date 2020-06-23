Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CBFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A923207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592936589;
	bh=mMlwBfC/AOOA8JnRMj9iaiXiLFlpuJYlvC0Yf9g26Ik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CazigsDmculvfwXQduh2BzwgIgGXGD6HSTop9QusdIzxRCQXMDHHrCn5DMPDd8FTv
	 VcNp61xQE8IiuenYrc5ODztGyaa7W3VG7XFOYI2a1PFqLj6tui5mgXZD5J6Vll7tkO
	 bhAUFgW/uP5rbsIKaX7Ifzvf7aib1TzqMZx/iyE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbgFWSXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732549AbgFWSXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:23:07 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A0E2080C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592936586;
        bh=mMlwBfC/AOOA8JnRMj9iaiXiLFlpuJYlvC0Yf9g26Ik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xQrQjg6y/iqC5nV/7GeYlvU0lMwMI2kty3sk0InbiW5GIj4oyDPxFZx1T3cE4lmN2
         nKVgQ/VlF7CPbMq9q9jOakGsVyc06wMm11Eiye6Vc3frgTVUyHYsZT5zAFdwuK96Q7
         ao6H2go3xnCi7esJ5DZ9HtIqUr4OUle2ZdHk12oM=
Received: by mail-wm1-f45.google.com with SMTP id a6so2797070wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:23:06 -0700 (PDT)
X-Gm-Message-State: AOAM530o2utKxDIhelIPedOYMXlcp2T0iz8RIxgRVj5aiCj0RI6P7k1P
        L9/te0eH1WEXhtED7oMnQdC/5G2SUGRnjVu/6oQKyA==
X-Google-Smtp-Source: ABdhPJyS1PbTOkEdceaB5phTsb9ndBNW3JTgHxChDtE/w1/bG95tI4QFkfi98PunLTLDyZgLYZL8XEJwJdLzizZzHKo=
X-Received: by 2002:a1c:6202:: with SMTP id w2mr4504794wmb.176.1592936585053;
 Tue, 23 Jun 2020 11:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200622190149.GL32200@zn.tnic> <B4D00859-000A-4F8C-8CFB-45B9BBCCA16D@amacapital.net>
 <20200623102831.GB32590@zn.tnic>
In-Reply-To: <20200623102831.GB32590@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 23 Jun 2020 11:22:53 -0700
X-Gmail-Original-Message-ID: <CALCETrXfaEr9OGc5EDpxnhRZxFk5YZBBNVH-N32Eg8V8diwqXg@mail.gmail.com>
Message-ID: <CALCETrXfaEr9OGc5EDpxnhRZxFk5YZBBNVH-N32Eg8V8diwqXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        jpa@kernelbug.mail.kapsi.fi, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 3:28 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jun 22, 2020 at 12:37:12PM -0700, Andy Lutomirski wrote:
> > It=E2=80=99s this whole mess:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D53383
>
> It really is a mess because our option detection doesn't really work. I d=
id:
>
> ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-option-yn,-mpreferred-stack-boundary=3D3),y)
>         dummy :=3D $(error "gcc supports -mpreferred-stack-boundary=3D3")
>   endif
>   ...
>
> and doing:
>
> $ make CC=3Dgcc-4.8 HOSTCC=3Dgcc-4.8 V=3D1 lib/test_fpu.ko
>
> gives
>
> lib/Makefile:110: *** "gcc supports -mpreferred-stack-boundary=3D3".  Sto=
p.
>
> That same compiler, however, says:
>
> $ gcc-4.8 -mpreferred-stack-boundary=3D3 -c /tmp/foo.c
> /tmp/foo.c:1:0: error: -mpreferred-stack-boundary=3D3 is not between 4 an=
d 12
>
> so I need to dig deep into cc-option* fun.

See that same atrocious bug report.  It's the insane interaction
between -mno-sse2 and -mpreferred-stack-boundary.  So you need to
cc-option them both?  Or just stick with a compiler version check, I
guess.

--Andy
