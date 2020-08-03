Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF1BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A2D20678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596443981;
	bh=+w5zCqoN1RmKfzxyGhYb1oNkZP3P3KWt7Fjgfgt3Xng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y7KRMgPEEGsvkv/BYEpUaoKDnI4LHZnOREQGJ2mR9PuIic0KnQaWYQfH8Sa+mr78i
	 +7FywfUTh0wCpQrTOFQ0M3MDPkdA2bScBqnVOiEwSUVNydaD69Rqj947g9OG7b45SX
	 v2GRyvLjC5n9ZNbgxDv4OPBEPbpkznGmV6GiHHZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgHCIjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCIjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:39:40 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 139E9206D7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596443979;
        bh=+w5zCqoN1RmKfzxyGhYb1oNkZP3P3KWt7Fjgfgt3Xng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cmjHGTITEeHZo/uDJf7BvmxqLE4JfIpnSS89mkZVd9cQSy+Mt/XrtZNjBSdxgUc7o
         Vq/RFmthPcuHNp+hcCGbNgZIUiIwVN0ztJcUM6YmJQtk3HhTGROdzvptcUKGwo/Xrw
         /hRRIJUdbBtPsXz4R8yKxL3rsWhGCyQU8cSZ6JuY=
Received: by mail-lj1-f181.google.com with SMTP id v9so4248451ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 01:39:39 -0700 (PDT)
X-Gm-Message-State: AOAM530QsYfBiZeEyjp00Xmby0bXX9eAxUUYtEjAiUf86iejzNH0UK0F
        5RwOb2h6rzfokj5RrbrrRvvpBDWjmPDdPoE0BDM=
X-Google-Smtp-Source: ABdhPJxZ/8tSlY3D85xhv5bs91wHng9qol3ObhbPPyjjrcGtC8wf4WJQZjOLxNhfR2d7EuzEod+aWwsAPEAlLD+CfOE=
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr5374040ljj.341.1596443978086;
 Mon, 03 Aug 2020 01:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
 <IBDZDQ.K28R5FAI0BXI2@crapouillou.net> <20200724155436.GA7460@kozik-lap>
 <K5Y0EQ.WYAK00ADM46F3@crapouillou.net> <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
 <20200726160616.GA2662@kozik-lap> <RO33EQ.546WD84D5N7K2@crapouillou.net>
 <20200726161545.GA6058@kozik-lap> <B243EQ.VEXGA7ZL5JAE2@crapouillou.net>
 <CAK8P3a1r6AMz2wKBEosAqn7qkuJY4LGFYK7o85sO++d+TSVOgQ@mail.gmail.com>
 <20200727170302.GA3507@kozik-lap> <CAK8P3a3zM4M2y1shVnUYCArZxxf9FHbOkVCK0yAK8wbfQTVChg@mail.gmail.com>
 <20200803103648.17273c10@xps13>
In-Reply-To: <20200803103648.17273c10@xps13>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 3 Aug 2020 10:39:26 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc9HJu4i_3TRXkWfpfYKoB5VB1z1KHg=e5qXbv7ZFT2nA@mail.gmail.com>
Message-ID: <CAJKOXPc9HJu4i_3TRXkWfpfYKoB5VB1z1KHg=e5qXbv7ZFT2nA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 at 10:36, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> Arnd Bergmann <arnd@arndb.de> wrote on Mon, 27 Jul 2020 19:28:48 +0200:
>
> > On Mon, Jul 27, 2020 at 7:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > On Mon, Jul 27, 2020 at 09:55:54AM +0200, Arnd Bergmann wrote:
> > > >
> > > > The way we do it on Arm, the machine Kconfig identifiers stay around
> > > > even for multiplatform targets (which now make up basically actively
> > > > maintained machines).
> > > >
> > > > I don't think it makes any sense for a driver to depend on MIPS_GENERIC:
> > > > either it is a generic driver that should always be visible or it is specific
> > > > to a set of SoCs and should depend on some corresponding vendor
> > > > specific identifiers.
> > >
> > > If support for Ingenic is provided also by MIPS_GENERIC (without
> > > selecting MACH_INGENIC), then it makes sense. This would be just a
> > > different way than ARM of building multi-platform kernel.
> >
> > Yes, it would work just as well, my point was just that it is somewhat
> > confusing to have every architecture do it differently, and that I
> > prefer the way Arm (and also ppc, x86 etc) handles it today.
> >
> > On MIPS, most platforms are not yet part of MIPS_GENERIC, so
> > they are fairly free to pick whatever method works best and is
> > consistent with the rest of the kernel.
>
> In the end, shall I apply Krzysztof patch or shall I wait for an update
> (eg. without 'default y')?

No, this patch should be dropped as we decided to leave it as is. At
least that was my understanding. The other similar changes - relating
to memory driver - were already applied:
https://lore.kernel.org/lkml/20200728104503.23655-2-krzk@kernel.org/

Best regards,
Krzysztof
