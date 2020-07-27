Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD51C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F190920719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595869395;
	bh=+GEDCW7VmDuCaglkxtFinMfPgklMIr/zwShvRELCoic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S5t/jRf5KG4aFDB9suuJuWZ/0VXscCmosZdI9Z7fcKiqGCO7/+5oRc3WfKqCIYv7A
	 ApUSncIMbulmuToxLpEdUQedprfTWZOJ5YjXFDfTKkRNnX3ofzbaw7XqJoX9soq0ZN
	 Vxv8MYQTj3velUmoP9x6TQYWBgvifjacdsBquDUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgG0RDO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:03:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38513 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgG0RDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:03:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id n2so12680827edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m5pStuZGF1Su2qanmiDVuEvfYQ90bm1Risw4vLu52TA=;
        b=dFOoLp6aMUshVrBObU8jgCblT4hXCHtrBREJ1SXLf5lhM5Cn//60yxMzKS69lEtr/g
         jjAeXbxFJ1yCvkdNf6aJhYnnxy/jBie9SCLCvkZTt1ChqCgoirNXCD3Ad2PXtcw8dks1
         oyb6abHL8xthpp58amivcBYY6U9SNtk6EnlsnDlQ+DOWbRv0x0gfqsaSodsw4pWVlpSc
         A1HO8iXthV1GQ+0qqNN1DQRd/Ur1NeXCE7xjPvYrwsbeLlU7biDUw8t6fEbIFza8f7h2
         c1jgXWGE83PT4CZKSpP3pYl+1eOLvVAD2WoGDxnwaNohnIXf/wGnXT7G8gy3wWECaFKZ
         KDvg==
X-Gm-Message-State: AOAM532aIlHXpbZDiaxubqupAy/+daaY7AfsrRhEHdrVq2zhDQfh4Zym
        KgaV7u7jWYSzDKif9L87zpk=
X-Google-Smtp-Source: ABdhPJzK+jjRoJ65ijtuAY/v3feRZx9jqvfIP6SDKNST7vf2+VBdYCOvHgvl54SbPjeFHmGsL/fa8Q==
X-Received: by 2002:aa7:d2d2:: with SMTP id k18mr21411115edr.16.1595869385368;
        Mon, 27 Jul 2020 10:03:05 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id dc12sm5975430ejb.124.2020.07.27.10.03.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 10:03:04 -0700 (PDT)
Date:   Mon, 27 Jul 2020 19:03:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
Message-ID: <20200727170302.GA3507@kozik-lap>
References: <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
 <IBDZDQ.K28R5FAI0BXI2@crapouillou.net>
 <20200724155436.GA7460@kozik-lap>
 <K5Y0EQ.WYAK00ADM46F3@crapouillou.net>
 <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
 <20200726160616.GA2662@kozik-lap>
 <RO33EQ.546WD84D5N7K2@crapouillou.net>
 <20200726161545.GA6058@kozik-lap>
 <B243EQ.VEXGA7ZL5JAE2@crapouillou.net>
 <CAK8P3a1r6AMz2wKBEosAqn7qkuJY4LGFYK7o85sO++d+TSVOgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAK8P3a1r6AMz2wKBEosAqn7qkuJY4LGFYK7o85sO++d+TSVOgQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 09:55:54AM +0200, Arnd Bergmann wrote:
> On Sun, Jul 26, 2020 at 6:20 PM Paul Cercueil <paul@crapouillou.net> wrote:
> > Le dim. 26 juil. 2020 à 18:15, Krzysztof Kozlowski <krzk@kernel.org> a écrit :
> > > On Sun, Jul 26, 2020 at 06:12:27PM +0200, Paul Cercueil wrote:
> > >>  Le dim. 26 juil. 2020 à 18:06, Krzysztof Kozlowski <krzk@kernel.org> a écrit
>  >
> > > OK, that's true. Anyway, I don't have strong opinion on any of this. I
> > > just followed Arnd's hint.
> > >
> > > For the memory driver (and MTD NAND as well) which one you prefer:
> > > 1. https://lore.kernel.org/lkml/20200724074038.5597-6-krzk@kernel.org/
> > > 2. depends on MACH_INGENIC || MIPS_GENERIC || COMPILE_TEST
> > >
> > > ?
> >
> > I'd say a slightly modified #1. The driver shouldn't be "default y" in
> > the first place, so the patch could be to disable it by default.
> 
> If it defaults to 'n' even for MACH_INGENIC, you may have to enable
> it in the four defconfig files for these machines to avoid surprises.

Exactly. Nothing else selects JZ4780_NEMC, so either we keep default y
("if MACH_INGENIC || MIPS_GENERIC"), or you select it directly from
MACH_INGENIC/MIPS_GENERIC.

A related question is how essential are these drivers? At least for ARM
platforms, all essential SoC blocks/IPs are selected by default, if
support for chosen SoC is enabled. Only non-essential stuff is left,
e.g. DRM, cpufreq, devfreq, ADC, crypto, video, USB, eMMC (although one
could argue that it is essential), IOMMU.

> > And when the Ingenic code is merged into the MIPS generic framework, I'll
> > send a set of patches to change all driver dependencies on MIPS to
> > MIPS_GENERIC.
> 
> The way we do it on Arm, the machine Kconfig identifiers stay around
> even for multiplatform targets (which now make up basically actively
> maintained machines).
> 
> I don't think it makes any sense for a driver to depend on MIPS_GENERIC:
> either it is a generic driver that should always be visible or it is specific
> to a set of SoCs and should depend on some corresponding vendor
> specific identifiers.

If support for Ingenic is provided also by MIPS_GENERIC (without
selecting MACH_INGENIC), then it makes sense. This would be just a
different way than ARM of building multi-platform kernel.

Best regards,
Krzysztof
