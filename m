Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9D5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86BA20776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590707889;
	bh=Bej7wdnegyBfAmYZr+Ty39Mjs8c2zivHIdOj0jONFBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zPPR1PZ7S3Unzw9JNDAKivWUcKu4Tnlc2M32ao9AGmyh5VW+Nrx22M60LZUhgs9eE
	 OooTwrv2N/qTI2j3kLHovz49Rd0aBGar8sKOf4zAnmuMh0i9bmoTBGS2v02cOaRVQy
	 /5pb5NZLHdcTu6BcJLuM/oA7QO4UqsGk4iHqda3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437482AbgE1XSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:18:08 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42641 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437428AbgE1XSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:18:06 -0400
Received: by mail-il1-f193.google.com with SMTP id 18so658997iln.9;
        Thu, 28 May 2020 16:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHt1I46lXnPM8uSEpy3eA9oH3DddGg6oQn9ZXscyMuY=;
        b=DKJnlbAMob8w/LGvJoTpO9KdnfWU+uE9xHZ8zTpGJK8h/PERyDa5BnWVaNBGsKuyPH
         oX3DBoKQEpbSD/Kkotp6113XCo5/eofXnC00MxYAxLUHfo17XeXGS0qQecuJ+c8Doi1q
         qm7SYesUQj4nQpbcgk1jaaTkarCIyrofzUU/OsmuqCP2DbJW6PZ/dPnwKSM0D3g+SlYw
         /v878JUC83vehhsiUf6hgaO4106aq0OnDf8Qt6X3m449k9mYsN7Auhdvo7d6BIHx2Rcb
         XqAttBkz7bAO7SvCgbYzvpTlvI8z6udyv6VR0EJvj0rtOU24Af+VJIQuuRVuZSAXfrgT
         A39Q==
X-Gm-Message-State: AOAM531cRkvBvpCoaJmlg7MZ5nIUTAADooLvpFMm6jrDjJ1LW2xJLDaf
        L4818bzfSHVAs62Xvk0b2A==
X-Google-Smtp-Source: ABdhPJy+NhxjKJePpWqaAD37mFHhPh4qNfb6+Bmxc/y0RXg8NO0F1Fx0vK0+C9j4KWtf9vwRiuUBzQ==
X-Received: by 2002:a05:6e02:1287:: with SMTP id y7mr4538682ilq.63.1590707885705;
        Thu, 28 May 2020 16:18:05 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w26sm4128801ill.19.2020.05.28.16.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:18:04 -0700 (PDT)
Received: (nullmailer pid 861926 invoked by uid 1000);
        Thu, 28 May 2020 23:18:03 -0000
Date:   Thu, 28 May 2020 17:18:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     seanga2@gmail.com, anup@brainfault.org,
        Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        tglx@linutronix.de, devicetree@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 5/5] dt-bindings: timer: Add CLINT bindings
Message-ID: <20200528231803.GA847232@bogus>
References: <c0e9e625-daf8-b72f-2237-06018ff5d8a0@gmail.com>
 <mhng-0995a264-b39c-4790-9aa5-b8c598b43ffd@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-0995a264-b39c-4790-9aa5-b8c598b43ffd@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 05:32:30PM -0700, Palmer Dabbelt wrote:
> On Thu, 21 May 2020 23:29:36 PDT (-0700), seanga2@gmail.com wrote:
> > On 5/22/20 1:54 AM, Anup Patel wrote:
> > > On Fri, May 22, 2020 at 1:35 AM Sean Anderson <seanga2@gmail.com> wrote:
> > > > 
> > > > On 5/21/20 9:45 AM, Anup Patel wrote:
> > > > > +Required properties:
> > > > > +- compatible : "sifive,clint-1.0.0" and a string identifying the actual
> > > > > +  detailed implementation in case that specific bugs need to be worked around.
> > > > 
> > > > Should the "riscv,clint0" compatible string be documented here? This
> > > 
> > > Yes, I forgot to add this compatible string. I will add in v2.
> > > 
> > > > peripheral is not really specific to sifive, as it is present in most
> > > > rocket-chip cores.
> > > 
> > > I agree that CLINT is present in a lot of non-SiFive RISC-V SOCs and
> > > FPGAs but this IP is only documented as part of SiFive FU540 SOC.
> > > (Refer, https://static.dev.sifive.com/FU540-C000-v1.0.pdf)
> > > 
> > > The RISC-V foundation should host the CLINT spec independently
> > > under https://github.com/riscv and make CLINT spec totally open.
> > > 
> > > For now, I have documented it just like PLIC DT bindings found at:
> > > Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
> > 
> > The PLIC seems to have its own RISC-V-sponsored documentation [1] which
> > was split off from the older privileged specs. By your logic above,
> > should it be renamed to riscv,plic0.txt (with a corresponding change in
> > the documented compatible strings)?
> > 
> > [1] https://github.com/riscv/riscv-plic-spec
> 
> Let's propose tagging that PLIC spec as v1.0.0 in the platform spec group, but
> I don't see a reason why that wouldn't be viable.  Assuming that's all OK, we
> can start calling this a RISC-V PLIC (in addition to a SiFive PLIC, as they'll
> be compatible).
> 
> > > 
> > > If RISC-V maintainers agree then I will document it as "RISC-V CLINT".
> > > 
> > > @Palmer ?? @Paul ??
> 
> The CLINT is a SiFive spec.  It has open source RTL so it's been implemented in
> other designs, but it's not a RISC-V spec.  The CLIC, which is a superset of
> the CLINT, is a RISC-V spec.  IIRC it's not finished yet (it's the fast
> interrupts task group), but presumably we should have a "riscv,clic-2.0.0" (or
> whatever it ends up being called) compat string to go along with the
> specification.

Whatever you all decide on, note that "sifive,<block><num>" is a SiFive 
thing (as it is documented) and <num> corresponds to tag of the IP 
implmentation (at least it is supposed to). So you can't just copy that 
with 'riscv,<block><num>' unless you have the same IP versioning 
and update the documentation.

Using a spec version is fine, but not standalone. You need 
implementation specific compatible too because no one perfectly 
implements any spec and/or there details a spec may not cover.

Rob
