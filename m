Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB10C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566122245A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594739066;
	bh=FYCfNCt5uaRkVo5QbOItUGbXRJQEdHEvBhLF5JIiyX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Tk58lprwV6Un1I/NBCCfCIc2nP2Ssw0cgAol0sm4EfbG97UtsJOtesqe0JCm13JgU
	 +3YhIGnsgDa+KZhUaYS2w9ZFLG95ekcQ8GcNVf/mgI8+Ph4PIX7hCO8V3/MDns0JED
	 SHkUw0EFntjWSYFn7Q6C8pk1SXbjt+KleAMthI0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGNPEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNPEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:04:24 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D08B722473;
        Tue, 14 Jul 2020 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594739063;
        bh=FYCfNCt5uaRkVo5QbOItUGbXRJQEdHEvBhLF5JIiyX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vKFLh7a7V8L2G7kls9Fkf68/5iKD9IjMArDhOL2udS1vFjV919bMfuiBuhR99/c+W
         rerP0+vnmTb+9qhqC1iLUMLrbIAcFu9MeN397oe931Pu5+VDjm0IA5F6kkhvu+RvWq
         GdsMz58j+EV54H9qXsHHRTVWGwH3hJ4tw+UP7fjM=
Received: by mail-oo1-f42.google.com with SMTP id p26so3398024oos.7;
        Tue, 14 Jul 2020 08:04:23 -0700 (PDT)
X-Gm-Message-State: AOAM533M4YaWXafcSvsO9uzZuhhbcBKXiw8tRCbpmGOoxLaodDMO6XaK
        QOCxIcFhfxvSv/EE9g1OxEFldWI+BJrJaFGbvw==
X-Google-Smtp-Source: ABdhPJwsDP9x0kim57Rk9m1PvNioEMAED/geuEjKV85XSOp5N+kWkC9OHZn74arPvotNxGhaS6KiH03426VYKBf/v/I=
X-Received: by 2002:a4a:ae07:: with SMTP id z7mr1744282oom.25.1594739063197;
 Tue, 14 Jul 2020 08:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200627161957.134376-1-anup.patel@wdc.com> <20200627161957.134376-6-anup.patel@wdc.com>
 <20200714023748.GA1164267@bogus> <CAAhSdy0O0YoDJ84NX8OasjuTdE8pd=Yk51WJWLpBiAEk3AcCQQ@mail.gmail.com>
In-Reply-To: <CAAhSdy0O0YoDJ84NX8OasjuTdE8pd=Yk51WJWLpBiAEk3AcCQQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jul 2020 09:04:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL9xcnzNAtL5nM3tt21pbfwz8qB_BSwfFAtXe0mj=MVEA@mail.gmail.com>
Message-ID: <CAL_JsqL9xcnzNAtL5nM3tt21pbfwz8qB_BSwfFAtXe0mj=MVEA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] dt-bindings: timer: Add CLINT bindings
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 9:47 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Jul 14, 2020 at 8:07 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sat, Jun 27, 2020 at 09:49:57PM +0530, Anup Patel wrote:
> > > We add DT bindings documentation for CLINT device.
> > >
> > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > > ---
> > >  .../bindings/timer/sifive,clint.txt           | 34 +++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.txt
> >
> > Bindings should be in DT schema format now.
>
> Okay, will update.
>
> >
> > >
> > > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.txt b/Documentation/devicetree/bindings/timer/sifive,clint.txt
> > > new file mode 100644
> > > index 000000000000..45b75347a7d5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.txt
> > > @@ -0,0 +1,34 @@
> > > +SiFive Core Local Interruptor (CLINT)
> > > +-------------------------------------
> > > +
> > > +SiFive (and other RISC-V) SOCs include an implementation of the SiFive Core
> > > +Local Interruptor (CLINT) for M-mode timer and inter-processor interrupts.
> > > +
> > > +It directly connects to the timer and inter-processor interrupt lines of
> > > +various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local interrupt
> > > +controller is the parent interrupt controller for CLINT device.
> > > +
> > > +The clock frequency of CLINT is specified via "timebase-frequency" DT
> > > +property of "/cpus" DT node. The "timebase-frequency" DT property is
> > > +described in: Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +
> > > +Required properties:
> > > +- compatible : should be "riscv,clint0" or "sifive,clint-1.0.0". A specific
> >
> > A new versioning scheme from SiFive? To review, we don't do version
> > numbers unless there's a well defined and documented scheme. IOW, one
> > that's not s/w folks just making up v1, v2, v3, etc.
>
> The "riscv,clint0" is already used by various RISC-V systems (including QEMU).

Not my problem that undocumented bindings are being used.

> The "sifive,clint-1.0.0" is for being consistent with the PLIC
> versioning scheme.

Where is that documented? This is what I expect you to be following or
updating to match:

Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt

>
> There is no clear documentation of CLINT versioning scheme. I think it's best
> to just drop "sifive,clint-1.0.0" . Agree ??

No, because then you are left with a very generic compatible string.
You need something specific enough to handle any implementation
features/quirks/bugs without needing a DT update. Typically, this
means a per SoC compatible string for a block as even the same IP
version can have different integration quirks.

Rob
