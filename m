Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07264C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06592467D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XAX/WSax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgAOHHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 02:07:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45198 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOHHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:07:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so14710506qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 23:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZ9Uv0Axx1RVBpC38D2LeKDBlyYIPhsVK6uMDN/OW7Q=;
        b=XAX/WSaxzB/941V80oBGBxxMlodBtHbxrvOGlO9DNVG8J+KyGY10lcKAeED5bV2DCe
         34fnSbo4MmMTXhxsOVoO/3B5Wb9+cL7nGgptOOI3w97miT0zfJK/M9L8J6h3aMZ1Fbwl
         D6mBRXLOC3blOnjD3+EqB9k95pgtA3UPznpZmIeg8pNoPpVEVWiPo1F9UBxADi1h+FCL
         aMoeUfg2TKbt91L1Tzk0BcSWfSe6+bFrX1egciZDzgNVYJG5LEJTHS4lH35FxoJZgtet
         5NEwv4J9K0/fN9B65fLguTC9Se+zbFiH6RWOsEm7RlIR8aoiQulq0M6ykkERQUJUHkvq
         s/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZ9Uv0Axx1RVBpC38D2LeKDBlyYIPhsVK6uMDN/OW7Q=;
        b=OeCfimQvmeme++UMKW0MUVozV5ybkz+Zet0wjPBjqPcVO2zxfFcBFcS52QJKPoLxBU
         y0HHiAkIkpyPosI99v3Y9Q6YuLI3wPSeQQHUobngrruBjziWqIA+/tzDiiEj3tshe24q
         JPePq6ZU9tcFb6Qefjwu7BVUn8h/sYZad7DGHg9n3/7S7b6/vuPxGv/EmWVeWN16D6dQ
         v/JsXzXOz6exrIgiZCYvJEJu7pGr5jCg/CKLhmKCWZDH7O6Fhk0Z0sW71xcMowpqdnRK
         XsUnkrJbvlXqyCza9vVTd0aY0zwS2EPI5cLNMCEevzPW81jqLqDHAvAWx3fzUJUq9RAN
         37Ng==
X-Gm-Message-State: APjAAAXzvFlG6aWfp86eAgxi1gKoXLjjCz+Sj1UC222IXrusV52ByH5q
        ue3YirVSey4tx0ZnSdq/YIJ42NMgEo5svouTyd/R2HDpXuA=
X-Google-Smtp-Source: APXvYqw/Zownjc6NkgO5O3t4IrOukQsUL9/HApOvE0AT9GibAiPkx2vP0IpC0VfPLNP3pPuE2XgD4eB9VY9GIdwmv90=
X-Received: by 2002:ae9:eb56:: with SMTP id b83mr25434351qkg.123.1579072021933;
 Tue, 14 Jan 2020 23:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20200109031516.29639-1-greentime.hu@sifive.com>
 <alpine.DEB.2.21.9999.2001091126480.135239@viisi.sifive.com>
 <alpine.DEB.2.21.9999.2001121011100.160130@viisi.sifive.com>
 <CAHCEehKchrwd7TTmSrhtEPeCmkrYrx7TX_c6ogpCpSkCKnBQoQ@mail.gmail.com> <alpine.DEB.2.21.9999.2001141449500.21279@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.2001141449500.21279@viisi.sifive.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Wed, 15 Jan 2020 15:06:51 +0800
Message-ID: <CAHCEeh+utXxqF65rtvRJXq6cPDjCcwpAeUaiD1pSpGGMFXRT9Q@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: make sure the cores stay looping in .Lsecondary_park
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Gt <green.hu@gmail.com>, greentime@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 6:55 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Hi Greentime,
>
> On Tue, 14 Jan 2020, Greentime Hu wrote:
>
> > I think it is because the sections are too far for bqeu to jump and
> > the config I used just small enough for it to jump so I didn't see
> > this bug. Sorry about that.
>
> No problem.
>
> > I tried this fix to boot in Unleashed board.
> >
> >  #ifdef CONFIG_SMP
> >         li t0, CONFIG_NR_CPUS
> > -       bgeu a0, t0, .Lsecondary_park
> > +       blt a0, t0, .Lgood_cores
> > +       tail .Lsecondary_park
> > +.Lgood_cores:
> >  #endif
>
> Looks reasonable to me.  Care to update and repost the patch?

Yes, Paul. I have sent the v4 patch.
It is tested in Unleashed board.
