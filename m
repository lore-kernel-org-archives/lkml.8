Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873FDC54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBCD20746
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgEKPOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:14:02 -0400
Received: from verein.lst.de ([213.95.11.211]:36611 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbgEKPOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:14:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6F0368BFE; Mon, 11 May 2020 17:13:56 +0200 (CEST)
Date:   Mon, 11 May 2020 17:13:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Michal Simek <monstr@monstr.eu>,
        Jessica Yu <jeyu@kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        alpha <linux-alpha@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: sort out the flush_icache_range mess
Message-ID: <20200511151356.GB28634@lst.de>
References: <20200510075510.987823-1-hch@lst.de> <CAMuHMdXazsBw0mjJd0uFHQud7qbb5-Uw-PTDB3+-M=huRWOfgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXazsBw0mjJd0uFHQud7qbb5-Uw-PTDB3+-M=huRWOfgQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:46:17AM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Sun, May 10, 2020 at 9:55 AM Christoph Hellwig <hch@lst.de> wrote:
> > none of which really are used by a typical MMU enabled kernel, as a.out can
> > only be build for alpha and m68k to start with.
> 
> Quoting myself:
> "I think it's safe to assume no one still runs a.out binaries on m68k."
> http://lore.kernel.org/r/CAMuHMdW+m0Q+j3rsQdMXnrEPm+XB5Y2AQrxW5sD1mZAKgmEqoA@mail.gmail.com

Do you want to drop the:

    select HAVE_AOUT if MMU

for m68k then?

Note that we'll still need flush_icache_user_range for m68k with mmu,
as it also allows binfmt_flat for mmu configs.
