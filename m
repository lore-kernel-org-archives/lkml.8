Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C1CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2445720885
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9IRhHrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgGDMJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGDMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:09:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BDFC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 05:09:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so35445270wrw.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q6/l6gbVd+4D3HhCjT+3idiCPEiasxsjgaH+81aczFE=;
        b=b9IRhHrzCgesVbckByioxGPz8FlQfkEkVf1NAa+4MF96GTovlwurUQsUsys1b5Ts4U
         ZoMO+/4NqCZOuk9mZuFSTIzqIvoCiTdOlygnvwJC2XxNUu38v/5vQyJP/L8OftsGaf54
         xmBDeimTuhrrVORWJCPd8tsTVsan5nSaASspLFjclUJqabNc3IgaNOO5zaMvfLGn1SgM
         qNz06vmFzuCymAFXe7A3ZxuFxVP7+iQFduXf12UNDfmfj4Z30Kr31ASgbLhIfdYanhER
         sKJnedGfLrmRiXrJw6KpcQmPi1syhPyDV5ZMEH4UMi0Dcupi5RHeRSDW8WmJtiOO2ffD
         0Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q6/l6gbVd+4D3HhCjT+3idiCPEiasxsjgaH+81aczFE=;
        b=bG5Fw86RpuDzgEskalP/Md6x2bg7TT9BANqSjUS86LGspUFPhQsrYPJ8eTR+nL922O
         LiaS50hyR0g9iUQtp0i/DRkMW7dB4i3uIc5oJD4duW4KxTITjjIpc5beY0UqC7+begRB
         yfmSGvR1TGu/fZDYZUu0xkLed5zw64G+WddAB08TmGUR7Hp3Y8EzCGGrB0HWOFrDXGVI
         n37sA5D+sCmMfb4uF7Q+Cyl42rRCC8Ey9rwOVSZO58SaryWYA+qJWjKqiLSvstLkR+iB
         2hJ71pV+hqgfpJaSEjDZIeD/VwNOSfxNAdSYJlMZTVaDr0D0uvVzgi3OPRTBdAzQ409G
         pD8Q==
X-Gm-Message-State: AOAM530K5bLj5FYxfUMniq9/qMzVpaCZLDozlWme4Duan9J4Rx4HyeqG
        aL53wGwrPrWjbwIxoY2x0o9UIaUNkWtRpKtzjB5wCIon
X-Google-Smtp-Source: ABdhPJwB9vVrA8j1YWUIpC/xHJschuvr8/Zcw6GKLce+xK6MBdOXF17mnIqhhLFLxsor2Wf7JWJi6AF5eWi6o8zAgcQ=
X-Received: by 2002:adf:ec90:: with SMTP id z16mr40439204wrn.52.1593864593453;
 Sat, 04 Jul 2020 05:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200702200727.239348-1-kernel@esmil.dk> <CANBLGczQ51LQCiubvu2HTYrdnW2q_6GY_dfVNrV6M+dnRh1KQw@mail.gmail.com>
 <CAJ+HfNh38DwrwKrDi-S_3rzyF+=B4N3kXfAOoMEnXOyoq3LkSg@mail.gmail.com> <CANBLGcxf_vZ6b75Nm52-p0W-1h+Yft77gW+j+U5Wa-9uUo=pxw@mail.gmail.com>
In-Reply-To: <CANBLGcxf_vZ6b75Nm52-p0W-1h+Yft77gW+j+U5Wa-9uUo=pxw@mail.gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Sat, 4 Jul 2020 14:09:42 +0200
Message-ID: <CAJ+HfNhe=esLaRfDXfp93+GYSr+nGEoOswn=puggBPF8ikGw6g@mail.gmail.com>
Subject: Re: [RFC] riscv: Add jump-label implementation
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jul 2020 at 13:35, Emil Renner Berthing <kernel@esmil.dk> wrote:
>
> On Sat, 4 Jul 2020 at 13:23, Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com=
> wrote:
[...]
> > Indeed. And nice work! Can you respin the patch with the 32b fix
> > above, and also without the RFC tag?
>
> Yes, of course. If you don't mind I'll wait a bit and let this collect
> a bit more comments.
>

Certainly!

> > Curious; Why is [branch ? 1 : 0] needed when coding the boolean into
> > the key pointer (arm64 is just [branch]). Different encoding of
> > booleans (branch in this case)?
>
> No, that was just me being unsure exactly how bool works when used as
> an index. After reading up on it it seems the original code is right,
> you can actually trust that _Bool is either 0 or 1. I'll fix it in the
> next version. Thanks!
>

Cool! Thanks for clearing that up for me!

Cheers,
Bj=C3=B6rn
