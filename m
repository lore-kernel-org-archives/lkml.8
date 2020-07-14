Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84193C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61015206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Dn/xsk6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGNDry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGNDrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:47:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3013FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:47:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so19562407wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qI24xBB/rzdG/cpOm9YsxEJKq/zwmC3JEgqbChZ686c=;
        b=Dn/xsk6EaU3zSb3BKgpl+10/FOdZR1egP1f1UGyP/yNSXO++t5ytc1+ErOGmvm+3Qw
         sKKbiNY4LnTQ8EzxXcs6o3fPg+FB3aGqwwk3T6BNlzi4Ebc4Vte3BvxGAccxcvLgprJa
         dFBBCrQvDqm3cTojPiUdKlSODLmPVNibHOmFmaV2z2OCkvZrDheBxM9q99AG3Wx/GhRM
         k91NIQFoXCd1vjRmkwAntBQQEg72tpb5qFckMM4QyANyda/c40HxMabSblMYJX4kJvGL
         FujGdM2y3OlTkTveXMZupSqKsV0sqI50l2HoHWCBz7yh3OzxseS/idJUYn88p5lbQsXx
         a7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qI24xBB/rzdG/cpOm9YsxEJKq/zwmC3JEgqbChZ686c=;
        b=MMpmJKBBO2ntA6zYo89AJVpL98IDyfIeQ+j8Xjx+0XbcJBgy9/5nAu43AR+x0TqIm1
         l1jL/DB0eqaPTs0rVHm5+/1wvOox37wLd2WEkPjoaIkMEydMNhdnSarRNalagiPgqQat
         woyp5fNMFd/jvDs0u/5ZQH58GOQ60MvNQMtu7huMPyrKlweoObETpta1mYiwQ54f/HRT
         2YETThreyAd1bm+Hey4beJoXBs6k5mnrlhCGYE+v1LYO5fYH5CT8u+g2IknLz1WVEpu6
         iqLah2Do7P8pL+LeEVoA45z/R6Wg8Cx/tFAIQN4LxqwbY9cKXv86iL89xEO/sJg2FEBQ
         eAEQ==
X-Gm-Message-State: AOAM533iq1pWGiNKiYeNmM+Dc6IH2ImLdQuKoDjzPThCQKjWEaKvgBbE
        OcC/pJGHm4ux/fyZRx5lzek+5rGtMpez6kbkCSz41Q==
X-Google-Smtp-Source: ABdhPJyzmGfojs4K3LUS8fPXgGa7xK2rYTn4JhLpsd4yeuJCR3uTFmQBj4zD54/cXBQfEZqb4E1JRCJz4UWUThjGymE=
X-Received: by 2002:adf:fcca:: with SMTP id f10mr2659455wrs.325.1594698471722;
 Mon, 13 Jul 2020 20:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200627161957.134376-1-anup.patel@wdc.com> <20200627161957.134376-6-anup.patel@wdc.com>
 <20200714023748.GA1164267@bogus>
In-Reply-To: <20200714023748.GA1164267@bogus>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 14 Jul 2020 09:17:39 +0530
Message-ID: <CAAhSdy0O0YoDJ84NX8OasjuTdE8pd=Yk51WJWLpBiAEk3AcCQQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] dt-bindings: timer: Add CLINT bindings
To:     Rob Herring <robh@kernel.org>
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

On Tue, Jul 14, 2020 at 8:07 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Jun 27, 2020 at 09:49:57PM +0530, Anup Patel wrote:
> > We add DT bindings documentation for CLINT device.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > ---
> >  .../bindings/timer/sifive,clint.txt           | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.txt
>
> Bindings should be in DT schema format now.

Okay, will update.

>
> >
> > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.txt b/Documentation/devicetree/bindings/timer/sifive,clint.txt
> > new file mode 100644
> > index 000000000000..45b75347a7d5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.txt
> > @@ -0,0 +1,34 @@
> > +SiFive Core Local Interruptor (CLINT)
> > +-------------------------------------
> > +
> > +SiFive (and other RISC-V) SOCs include an implementation of the SiFive Core
> > +Local Interruptor (CLINT) for M-mode timer and inter-processor interrupts.
> > +
> > +It directly connects to the timer and inter-processor interrupt lines of
> > +various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local interrupt
> > +controller is the parent interrupt controller for CLINT device.
> > +
> > +The clock frequency of CLINT is specified via "timebase-frequency" DT
> > +property of "/cpus" DT node. The "timebase-frequency" DT property is
> > +described in: Documentation/devicetree/bindings/riscv/cpus.yaml
> > +
> > +Required properties:
> > +- compatible : should be "riscv,clint0" or "sifive,clint-1.0.0". A specific
>
> A new versioning scheme from SiFive? To review, we don't do version
> numbers unless there's a well defined and documented scheme. IOW, one
> that's not s/w folks just making up v1, v2, v3, etc.

The "riscv,clint0" is already used by various RISC-V systems (including QEMU).

The "sifive,clint-1.0.0" is for being consistent with the PLIC
versioning scheme.

There is no clear documentation of CLINT versioning scheme. I think it's best
to just drop "sifive,clint-1.0.0" . Agree ??

>
> > +  string identifying the actual implementation can be added if implementation
> > +  specific worked arounds are needed.
> > +- reg : Should contain 1 register range (address and length).
> > +- interrupts-extended : Specifies which HARTs (or CPUs) are connected to
> > +  the CLINT.  Each node pointed to should be a riscv,cpu-intc node, which
> > +  has a riscv node as parent.
> > +
> > +Example:
> > +
> > +     clint@2000000 {
> > +             compatible = "sifive,clint-1.0.0", "sifive,fu540-c000-clint";
>
> Doesn't match the binding.

Okay, will update.

>
> > +             interrupts-extended = <
> > +                     &cpu1-intc 3 &cpu1-intc 7
> > +                     &cpu2-intc 3 &cpu2-intc 7
> > +                     &cpu3-intc 3 &cpu3-intc 7
> > +                     &cpu4-intc 3 &cpu4-intc 7>;
> > +             reg = <0x2000000 0x4000000>;
> > +     };
> > --
> > 2.25.1
> >

Regards,
Anup
