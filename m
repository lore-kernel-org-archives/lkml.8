Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D706C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A0722314
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="2Loee2nK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgBFUCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:02:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39641 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBFUCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:02:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so3288648pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=NOxXfiLsU89ujzW3kiPGNYe4vyeTIrU0tdM0XqziQKQ=;
        b=2Loee2nKehTxo9hAT9CRXC32I/LG3JEYxQBxLbA0eVq6OtGjRZm9qxNkZVsm6OFLzx
         V6ldHIzCvthr7dHOnppjS1m5rFcnyJMmv2ClB5rqenEDZB8pbDc2AvT56GUwifIF7QT0
         RCc8FORJmh6NJ7huMvdDq575kK12LgVxkdMuL3C4Nzx9J3chyNq1RNwCGQ3+aciSytbF
         35riEKkZ8Ymc7hAPwjI+NU/vxzRARsZkrUciH0b+3WL2617ScfTvOKP4xRorCHl5KSOL
         Nd7ZGZeastxo4RWpn+uqYo7L6cNr7x0zwVYcZqbVALmNf1bJWKzCiCCFWQvlhaNmXFML
         gpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NOxXfiLsU89ujzW3kiPGNYe4vyeTIrU0tdM0XqziQKQ=;
        b=KJFwa8rJAZX0CQKugkWpXvsVBn67nUUb8g//VZjqhXF5mykepx6iiCxaUbJ5F7ldUM
         tP9e/VnuSkF8TEp/61TcOl2WGoROEl4TZmTuxuGzeBg5ppuLdxSSmOYwP7J89Ef6hbTT
         aMVVii57mCgz/VMwIxXr6PmOrp/cpdnW1WpsMujOFAHXaJXJIJ2Lk7YjoJ6VywEWvuMA
         29/iFQdjoacmu0HobD9KFVEgywCckzX1AeAOvMHlocypNyE/GBHpW0HjwAaRUQ8cWba9
         GrWRCnJu6C0jTDS+2uNxWDwOHyJ0hz2WtWg7MsPdFbid912Hw6FN6oL8r7t7FDTeIvrn
         jCjg==
X-Gm-Message-State: APjAAAUp/EDJb/Rp21+GbB/BaasRHq2xxmusrY/mSWGA24qgQv3aNEdx
        B4WUMOXZTlehfHifTLlPCm6coA==
X-Google-Smtp-Source: APXvYqwwG76dsJCApYDXOEM5/ERMo3YohWj+EhW9XMkDRl35ta2xzK64z2Ih0l6ABu0KtKcyjS86sQ==
X-Received: by 2002:a62:188:: with SMTP id 130mr5788733pfb.249.1581019359986;
        Thu, 06 Feb 2020 12:02:39 -0800 (PST)
Received: from ?IPv6:2600:1010:b01f:241b:9d8d:a655:f13f:191f? ([2600:1010:b01f:241b:9d8d:a655:f13f:191f])
        by smtp.gmail.com with ESMTPSA id i64sm244143pgc.51.2020.02.06.12.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 12:02:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function sections
Date:   Thu, 6 Feb 2020 12:02:36 -0800
Message-Id: <B413445A-F1F0-4FB7-AA9F-C5FF4CEFF5F5@amacapital.net>
References: <75f0bd0365857ba4442ee69016b63764a8d2ad68.camel@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
In-Reply-To: <75f0bd0365857ba4442ee69016b63764a8d2ad68.camel@linux.intel.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 6, 2020, at 11:41 AM, Kristen Carlson Accardi <kristen@linux.intel.=
com> wrote:
>=20
> =EF=BB=BFOn Thu, 2020-02-06 at 04:26 -0800, Kees Cook wrote:
>>> On Wed, Feb 05, 2020 at 02:39:45PM -0800, Kristen Carlson Accardi
>>> wrote:
>>> We will be using -ffunction-sections to place each function in
>>> it's own text section so it can be randomized at load time. The
>>> linker considers these .text.* sections "orphaned sections", and
>>> will place them after the first similar section (.text). However,
>>> we need to move _etext so that it is after both .text and .text.*
>>> We also need to calculate text size to include .text AND .text.*
>>=20
>> The dependency on the linker's orphan section handling is, I feel,
>> rather fragile (during work on CFI and generally building kernels
>> with
>> Clang's LLD linker, we keep tripping over difference between how BFD
>> and
>> LLD handle orphans). However, this is currently no way to perform a
>> section "pass through" where input sections retain their name as an
>> output section. (If anyone knows a way to do this, I'm all ears).
>>=20
>> Right now, you can only collect sections like this:
>>=20
>>        .text :  AT(ADDR(.text) - LOAD_OFFSET) {
>>        *(.text.*)
>>    }
>>=20
>> or let them be orphans, which then the linker attempts to find a
>> "similar" (code, data, etc) section to put them near:
>> https://sourceware.org/binutils/docs-2.33.1/ld/Orphan-Sections.html
>>=20
>> So, basically, yes, this works, but I'd like to see BFD and LLD grow
>> some kind of /PASSTHRU/ special section (like /DISCARD/), that would
>> let
>> a linker script specify _where_ these sections should roughly live.
>>=20
>> Related thoughts:
>>=20
>> I know x86_64 stack alignment is 16 bytes. I cannot find evidence for
>> what function start alignment should be. It seems the linker is 16
>> byte
>> aligning these functions, when I think no alignment is needed for
>> function starts, so we're wasting some memory (average 8 bytes per
>> function, at say 50,000 functions, so approaching 512KB) between
>> functions. If we can specify a 1 byte alignment for these orphan
>> sections, that would be nice, as mentioned in the cover letter: we
>> lose
>> a 4 bits of entropy to this alignment, since all randomized function
>> addresses will have their low bits set to zero.
>=20
> So, when I was developing this patch set, I initially ignored the value
> of sh_addralign and just packed the functions in one right after
> another when I did the new layout. They were byte aligned :). I later
> realized that I should probably pay attention to alignment and thus
> started respecting the value that was in sh_addralign. There is
> actually nothing stopping me from ignoring it again, other than I am
> concerned that I will make runtime performance suffer even more than I
> already have.

If you start randomizing *data* sections, then alignment matters.

Also, in the shiny new era of Intel-CPUs-can=E2=80=99t-handle-Jcc-spanning-a=
-cacheline, function alignment may actually matter.  Sigh.  The symptom will=
 be horrible maybe-exploitable crashes on old microcode and =E2=80=9Cminimal=
 performance impact=E2=80=9D on new microcode. In this context, =E2=80=9Cmin=
imal=E2=80=9D may actually mean =E2=80=9Chuge, throw away your CPU and repla=
ce it with one from a different vendor.=E2=80=9D

Of course, there doesn=E2=80=99t appear to be anything resembling credible p=
ublic documentation for any of this.
