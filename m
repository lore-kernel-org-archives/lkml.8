Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB92C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCABB2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591778536;
	bh=7SMpwWFJtzuSVmrvo9RAnKTTB0pE14Hsv1bWQ+hQyJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IO6/dlYpBoeoNljw6rsS+yrN2d7UuIiYPAQORtJI001+xY9t9xeoAH66x/8DDLDSD
	 9iZN+nekXRt2sPH8yD+UlCXYFVUJfFMPz70eJfXRM+Rr5U5FVaOB9A9MTfdkqaYGn0
	 ym9G8kdtOINY6AwRBwXoTBz2lk79fhaTD3DIeRmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgFJImP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgFJImN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:42:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9411E20734;
        Wed, 10 Jun 2020 08:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591778532;
        bh=7SMpwWFJtzuSVmrvo9RAnKTTB0pE14Hsv1bWQ+hQyJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RhcC2JmrTpkbJUCTpnvnQGqRbvOb2OcZy9AQyr6Qa9wded36lLQ4KFNXKPXVUote6
         fQ8lTVWhnt0nY4aOvfFkWErPWdGIBEGa0mGaCWnzeEuK8hp8knyNXht8nn6Tzm9kwe
         2nHq7zSOAK75VEhjH2byi1HaUpzwEiI67bhMHro8=
Date:   Wed, 10 Jun 2020 09:42:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] efi/libstub/arm64: link stub lib.a conditionally
Message-ID: <20200610084206.GA17035@willie-the-truck>
References: <20200604022031.164207-1-masahiroy@kernel.org>
 <20200610075837.GD15939@willie-the-truck>
 <CAMj1kXES7MoxWDQeO=D-88fit4H_Qh9SEQmikcJA39d8czPCBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXES7MoxWDQeO=D-88fit4H_Qh9SEQmikcJA39d8czPCBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:00:19AM +0200, Ard Biesheuvel wrote:
> On Wed, 10 Jun 2020 at 09:58, Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Jun 04, 2020 at 11:20:30AM +0900, Masahiro Yamada wrote:
> > > Since commit 799c43415442 ("kbuild: thin archives make default for
> > > all archs"), core-y is passed to the linker with --whole-archive.
> > > Hence, the whole of stub library is linked to vmlinux.
> > >
> > > Use libs-y so that lib.a is passed after --no-whole-archive for
> > > conditional linking.
> > >
> > > The unused drivers/firmware/efi/libstub/relocate.o will be dropped
> > > for ARCH=arm64.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > > This patch touches under arch/arm64/, but
> > > this is more related to efi.
> > > I am sending this to Ard.
> >
> > Ok, I'll ignore this then. Ard -- please yell if you want me to do anything
> > else with it.
> >
> 
> I am going to send a batch of EFI fixes early next week, so I can take
> this as well, or alternatively, you can apply it directly.

No, please take it. Just wanted to make sure it didn't slip through the
cracks, that's all.

Will
