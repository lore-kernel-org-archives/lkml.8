Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EFEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F35221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599842503;
	bh=FTxGdMGV3rapitRut8OA4Fjo29OIVMgG3dH1ljjIHq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xa/V3eQdIVy52NVhST8VuRXiRqzmbDSxKLM/wn+s+8Ep/e+eUwNeq4qlwVWXqdCuA
	 8Heq6ujCffMVMJMPjCWDAwAN9HMDyV/6o8ztKMa9Emv1W9QJL2+XMfTBKXuHnQqi2f
	 FIP1pZXgaS2tElln2ciP9kn/7GqNGOPKeVO/xpUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIKQlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgIKPKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:10:51 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27BB4222D9;
        Fri, 11 Sep 2020 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599835421;
        bh=FTxGdMGV3rapitRut8OA4Fjo29OIVMgG3dH1ljjIHq4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DyOQR0vKPCwij4NYetqRa7C5Kmex5BfD6ov1ZtH9EuiqxbZXBjHAr6cYDZEf/p8bU
         XZ/i6PohwH46vqkc8B08yhYU6SPRuFIyKq48Y09IlqH3K2mvEYg0EJ1C28zhlcdSfO
         cpy+wUI8LSH4fdpr2WaYN6MYzK/oz8QSsg/RSLbY=
Received: by mail-oo1-f41.google.com with SMTP id h9so2334089ooo.10;
        Fri, 11 Sep 2020 07:43:41 -0700 (PDT)
X-Gm-Message-State: AOAM5307qRhyFVI+fYjkipf5PZecpKpz5SZ2b0oPCWXcG3GwStCFp3Il
        2nyoMkJjXtezX1I1YHuivz6BZdyRVaK1imAW6Q==
X-Google-Smtp-Source: ABdhPJwrgQnxQEoMlDU3NAfllatuQT+8fpSwzBbuHMB3L4XBVNZlqEu/rI6S5Wu077rTYbX5JpCI+mGf15EFY143Ph4=
X-Received: by 2002:a4a:9d48:: with SMTP id f8mr1840695ook.50.1599835420448;
 Fri, 11 Sep 2020 07:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120254.8902-1-matthias.schiffer@ew.tq-group.com>
 <4dd06b79-1402-d7cf-9676-1f9a9526da12@gmail.com> <9eb72c6561333661599411e49072928385629999.camel@ew.tq-group.com>
 <ac64852a-7f2a-6005-f914-268670cd4f95@gmail.com> <CAL_Jsq+1LsTBdVaODVfmB0eme2jMpNL4VgKk-OM7rQWyyF0Jbw@mail.gmail.com>
 <d7dc1017818e935acf9ba838080bcc3c11b30888.camel@ew.tq-group.com> <735c00caa90746d20bfaafa42c4d911c61729228.camel@ew.tq-group.com>
In-Reply-To: <735c00caa90746d20bfaafa42c4d911c61729228.camel@ew.tq-group.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Sep 2020 08:43:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+SuJ5F=SxGfZp0g9V8TPejSxEu8Ya45qfDxhZ0rL8ETg@mail.gmail.com>
Message-ID: <CAL_Jsq+SuJ5F=SxGfZp0g9V8TPejSxEu8Ya45qfDxhZ0rL8ETg@mail.gmail.com>
Subject: Re: [PATCH] of: skip disabled CPU nodes
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 2:58 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> On Thu, 2020-08-27 at 09:10 +0200, Matthias Schiffer wrote:
> > On Wed, 2020-08-26 at 13:26 -0600, Rob Herring wrote:
> > > On Wed, Aug 26, 2020 at 8:47 AM Frank Rowand <
> > > frowand.list@gmail.com>
> > > wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On 2020-08-26 08:54, Matthias Schiffer wrote:
> [snip]
> > > > >
> > > > > Hmm, I see. This difference in behaviour is quite unfortunate,
> > > > > as
> > > > > I'm
> > > > > currently looking for a way to *really* disable a CPU core.
> > > > >
> > > > > In arch/arm64/boot/dts/freescale/imx8mn.dtsi (and other
> > > > > variants
> > > > > of the
> > > > > i.MX8M), there are 4 CPU nodes for the full-featured quad-core
> > > > > version.
> > > > > The reduced single- and dual-core versions are currently
> > > > > handled
> > > > > in
> > > > > NXP's U-Boot fork by deleting the additional nodes.
> > > > >
> > > > > Not doing so causes the kernel to hang for a while when trying
> > > > > to
> > > > > online the non-existent cores during boot (at least in linux-
> > > > > imx
> > > > > 5.4 -
> > > > > I have not checked a more recent mainline kernel yet), but the
> > > > > deletion
> > > > > is non-trivial to do without leaving dangling phandle
> > > > > references.
> > > >
> > > > Any thoughts on implementing another universal property that
> > > > means
> > > > something like "the hardware described by this node does not
> > > > exist
> > > > or is so broken that you better not use it".
> > >
> > > There's a couple of options:
> > >
> > > The DT spec defines 'fail' value for status. We could use that
> > > instead
> > > of 'disabled'.
> > >
> > > The spec behavior with cpu 'disabled' is only on PPC AFAIK. On
> > > arm/arm64 (probably riscv now too) we've never followed it where we
> > > online 'disabled' CPUs. So we could just make the check conditional
> > > on
> > > !IS_ENABLED(CONFIG_PPC). This would need some spec update.
> >
> > On ARM(64), the "disabled" status on CPUs doesn't have any effect. I
> > assume this changed with the mentioned commit c961cb3be906 "of: Fix
> > cpu
> > node iterator to not ignore disabled cpu nodes", as reverting it
> > gives
> > me the desired behaviour of considering the disabled CPUs non-
> > existent.
> >
> > So it seems that we already changed the interpretation in a non-
> > compatible way once (back in v4.20), and somehow PPC has yet another
> > different behaviour?
> >
> > How do we get out of this mess? Is going back to the v4.19 logic for
> > non-PPC platforms an acceptable regression fix, or would this be
> > considered another breaking change?

Yes, this is my 2nd option above. Need to double check MIPS and Sparc though.

> Any new insights on this? I'll gladly provide patches or proposals for
> a spec update if we can decide where we want to go with this.

I gave 2 options. I'm fine with either one (or both). Using 'fail' is
the simplest.

Rob
