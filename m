Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B2CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1659208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="D7wyka/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgFPVRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFPVRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:17:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB149C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:17:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 64so14804pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ygC6qMurkn40lJC+ZxZdg4QZG2wG7RbCx3Wlz0SLBsE=;
        b=D7wyka/mpU5++cE6VacKtAVZS1jGFny3KQ+YI5AQhYLI0AcABIcRi6LPvEQCg7ntfO
         Vw+6PxiFj5LcYbIkZfKSINSlHj4Zjw5hSoT78pEVL3amTA8BptxMCNBk3ph+IyyYrwTV
         VabzLkf/oPBgF4k9sqxS/m5MyvYSuCvSRfeQXvYVu1Wm4BbKJPcxU9snRCmlLiorIRIe
         B/h97YZHAcU+OKHDj+xvjdTH1CY0hYF395n84GAMrZchhib3EkKNbpSHxxJfbb8AHbEm
         QW8zH1FsbboFlIt1YXjT6QPI3wEKwN8ATZ5vsdYwdSD+PE4rbxOnTIBq9u7jDT0PE3cl
         TB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ygC6qMurkn40lJC+ZxZdg4QZG2wG7RbCx3Wlz0SLBsE=;
        b=tvisT6EeBuQJ9ceuO+NSiwnrWLnD8y8QqCtmy35QspIL8SD+2QTzAw5tS2k7uxJ47a
         jUibacuYsC8dU3imShOvvoq2Uu7KlrmNfxec7W+IMkm8vFqM7NcE2VohRdzc8VN8DAue
         4Uq70iLZq6tK/bCNKSE3RzH56iwsqrAY5PGpD5v1oMfXCEA29mF7+aRGhXQ1+6oopjWc
         jgPhaDt/DM3Xb5I4kwFCyNjN6kFsT+uOsKHz0A1oAo13KgisSOBbLVJ+W4GYvAkKwQcW
         ZPbR7RGUkCPsKNCcU8nMU2CaevVPouekH4BQ+xcZh4WdQUvemmRZaJkFEUczkWn0Hqu/
         bMnw==
X-Gm-Message-State: AOAM5304JyPJ2x35+fnNbOXjFy9xT6PSY9xBro2IlnmGzJShwfglw+6r
        VPkNQ/z3r+B6B/VRts2NbeUUdA==
X-Google-Smtp-Source: ABdhPJzlSUJLoAPVc0cvu6kUevY+O5e5Ep96KVko8SsIoQj8uEOac6htRRD/eEBJYzBCiBzQpMBX5A==
X-Received: by 2002:a05:6a00:84e:: with SMTP id q14mr3756497pfk.309.1592342239355;
        Tue, 16 Jun 2020 14:17:19 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:2854:eba6:e44d:d731? ([2601:646:c200:1ef2:2854:eba6:e44d:d731])
        by smtp.gmail.com with ESMTPSA id d6sm3470492pjh.5.2020.06.16.14.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 14:17:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
Date:   Tue, 16 Jun 2020 14:17:16 -0700
Message-Id: <1D569B6B-B8C3-497E-8A74-2E1A3D46299E@amacapital.net>
References: <20200616180123.GL13515@zn.tnic>
Cc:     x86-ml <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20200616180123.GL13515@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 16, 2020, at 11:01 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Tue, Jun 16, 2020 at 09:53:39AM -0700, Andy Lutomirski wrote:
>>> On Tue, Jun 16, 2020 at 2:53 AM Borislav Petkov <bp@alien8.de> wrote:
>>>=20
>>> Ok,
>>>=20
>>> here's the fix first so that it goes in. I'll hammer on the test case la=
ter.
>>=20
>> Does the 32-bit case need FNINIT?
>=20
> Pasting from IRC:
>=20
> I'm thinking if you'd need to reinit the FPU, then you need to do it for
> both, not only 32-bit or do you mean something else? Also, if you end up
> doing FNSAVE (old CPU) that one reinits state.

We definitely need to sanitize MXCSR for kernel fpu if kernel fpu means SSE2=
.  If kernel fpu means x87, we need to fix the fpu control word.

On x86_64, I suspect the UEFI ABI technically requires a clean x87 control w=
ord too. If we=E2=80=99re willing to declare that the kernel proper won=E2=80=
=99t use x87, then we could shove that into the UEFI code.

>=20
> Whatever we decide doing, this should be a separate patch anyway.
>=20
> Thx.
>=20
> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette
