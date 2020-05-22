Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90609C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6263A20757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ycKBEsXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgEVGgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 02:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbgEVGgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 02:36:22 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5CDC05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 23:36:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n18so8740825wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mp6z6BeKUJ4Z3j+pwMrXanCl98jvhdKIr7OaOufzROo=;
        b=ycKBEsXTb+BxsF1E77LY/R04LkIWlGVEDVXwR0PFQnoFMwnAQaK1qonVfAKXfGUqVV
         go4okfKzet3y0osi2r+mpOXkYNvUk9iU/3t/pD+GtTVo62YDChDlZDEgRc6ugYkl9UlI
         pA5HIPu0U89oj1XLXQfYyNul4tVsV00fQ9ZfhDgbAFbXHLYOKf7KUnmvPyMbA4/f8CYD
         n1qtH4pfLvrCK2LLVEfHE7Xzro2vu/torO/auE+bF69LPORosxZRLVriwoGuvLwRxQDW
         MVSCz9JTf8ZlhIECQr8ji2+NvFf2YPmqWrGZNKDi3A1gowqwFci315M9B6ejoPUM5/ma
         ATEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mp6z6BeKUJ4Z3j+pwMrXanCl98jvhdKIr7OaOufzROo=;
        b=Gtm+dwHDfBMkxTKZdy4Go8+oPvxS6G9E+7zBEMiujyqxrci48BxV4Klq2EJBweeqSO
         LorAwk5UdvoB3ZcZxkgdLQS+wLhVT5+mhCAxjdiiMaMyiHWVuLdBCuUQrRMAitIzm+Hs
         ZoXxDSSD0jjogQnz8sVEUP/zMvAqJwTNgV3lwLVRWZbG8athx5hf3q4IY00u8bR83EQA
         jfoqs6tvbmlYFUbPKP+qlHadPjnhFOFN6K5OUF1bZ6rfWEfSVpFP1Lo5yjAHKhC1vKhn
         MhByIF1gr0o9YXBfRj1V4hZGtbAIxJs0hIUhwv1ohp4yR0e7ZuDJYI2e8rNRUBEHUHAo
         v3Kg==
X-Gm-Message-State: AOAM532DkeXQMcrt0liiEB0vQ7mG8Iywku5tCuWGJHnyJ5qblB2RFj4U
        adNtSNIbCMWaMLo96fsBb1yc+/KMcV2PO/mAvnbYYw==
X-Google-Smtp-Source: ABdhPJykCpEJOH6fDySj/9KTQUVlXV7NLYQkkTeYIL3vQp6QzdI5zeWjcL1/7ZOhIw9nOY0uY1U3fi2R3XWSJ7hyhmg=
X-Received: by 2002:a1c:7410:: with SMTP id p16mr12579344wmc.134.1590129379212;
 Thu, 21 May 2020 23:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200521134544.816918-1-anup.patel@wdc.com> <20200521134544.816918-6-anup.patel@wdc.com>
 <2aec08b7-7197-4b60-89d9-c3b0d5a8a258@gmail.com> <CAAhSdy0OuxCwMVPBrvPpYMfVrhUuY3pONysk75yognOM5-0U+g@mail.gmail.com>
 <c0e9e625-daf8-b72f-2237-06018ff5d8a0@gmail.com>
In-Reply-To: <c0e9e625-daf8-b72f-2237-06018ff5d8a0@gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 22 May 2020 12:06:07 +0530
Message-ID: <CAAhSdy3_D9S0X1gHoPjHpfcpeEpVWdUa_HE_KYV3eXbB3eVhdw@mail.gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: timer: Add CLINT bindings
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 11:59 AM Sean Anderson <seanga2@gmail.com> wrote:
>
> On 5/22/20 1:54 AM, Anup Patel wrote:
> > On Fri, May 22, 2020 at 1:35 AM Sean Anderson <seanga2@gmail.com> wrote:
> >>
> >> On 5/21/20 9:45 AM, Anup Patel wrote:
> >>> +Required properties:
> >>> +- compatible : "sifive,clint-1.0.0" and a string identifying the actual
> >>> +  detailed implementation in case that specific bugs need to be worked around.
> >>
> >> Should the "riscv,clint0" compatible string be documented here? This
> >
> > Yes, I forgot to add this compatible string. I will add in v2.
> >
> >> peripheral is not really specific to sifive, as it is present in most
> >> rocket-chip cores.
> >
> > I agree that CLINT is present in a lot of non-SiFive RISC-V SOCs and
> > FPGAs but this IP is only documented as part of SiFive FU540 SOC.
> > (Refer, https://static.dev.sifive.com/FU540-C000-v1.0.pdf)
> >
> > The RISC-V foundation should host the CLINT spec independently
> > under https://github.com/riscv and make CLINT spec totally open.
> >
> > For now, I have documented it just like PLIC DT bindings found at:
> > Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
>
> The PLIC seems to have its own RISC-V-sponsored documentation [1] which
> was split off from the older privileged specs. By your logic above,
> should it be renamed to riscv,plic0.txt (with a corresponding change in
> the documented compatible strings)?
>
> [1] https://github.com/riscv/riscv-plic-spec

For PLIC bindings, we can certainly do the renaming because now
we have PLIC v1 specification hosted on RISC-V Foundation Github.

Regards,
Anup
