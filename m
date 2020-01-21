Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E76C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5802253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgAULQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:16:54 -0500
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:52018 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726473AbgAULQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:16:54 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 791E718224D9C;
        Tue, 21 Jan 2020 11:16:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toys51_3bc2dfa430738
X-Filterd-Recvd-Size: 2336
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 Jan 2020 11:16:50 +0000 (UTC)
Message-ID: <24012ba289823e9e38c2f89116a5f61581ef3909.camel@perches.com>
Subject: Re: [PATCH -next] powerpc/maple: fix comparing pointer to 0
From:   Joe Perches <joe@perches.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Chen Zhou <chenzhou10@huawei.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nivedita@alum.mit.edu,
        tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
        allison@lohutok.net
Date:   Tue, 21 Jan 2020 03:15:49 -0800
In-Reply-To: <20200121074723.GF3191@gate.crashing.org>
References: <20200121013153.9937-1-chenzhou10@huawei.com>
         <618f58cd46f0e4fd619cb2ee3c76665a28e30f4e.camel@perches.com>
         <20200121074723.GF3191@gate.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-21 at 01:47 -0600, Segher Boessenkool wrote:
> On Mon, Jan 20, 2020 at 05:52:15PM -0800, Joe Perches wrote:
> > On Tue, 2020-01-21 at 09:31 +0800, Chen Zhou wrote:
> > > Fixes coccicheck warning:
> > > ./arch/powerpc/platforms/maple/setup.c:232:15-16:
> > > 	WARNING comparing pointer to 0
> > 
> > Does anyone have or use these powerpc maple boards anymore?
> > 
> > Maybe the whole codebase should just be deleted instead.
> 
> This is used for *all* non-Apple 970 systems (not running virtualized),
> not just actual Maple.

OK, then likely this Kconfig description should be updated
(and the http://www.970eval.com link is no longer about powerpc)

$ cat arch/powerpc/platforms/maple/Kconfig
# SPDX-License-Identifier: GPL-2.0
config PPC_MAPLE
	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
	bool "Maple 970FX Evaluation Board"
	select FORCE_PCI
	select MPIC
	select U3_DART
	select MPIC_U3_HT_IRQS
	select GENERIC_TBSYNC
	select PPC_UDBG_16550
	select PPC_970_NAP
	select PPC_NATIVE
	select PPC_RTAS
	select MMIO_NVRAM
	select ATA_NONSTANDARD if ATA
	help
	  This option enables support for the Maple 970FX Evaluation Board.
	  For more information, refer to <http://www.970eval.com>



