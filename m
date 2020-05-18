Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B45DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7346B2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589797783;
	bh=arObw6BOIgBBUZeksezIt2wHSMyc4GY++N1SgQCNWYU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=AZsGrcPmJ2a9fo8bljDNTphR/o+2qn0OXAfOvua+ZqmlpsJqcR/RD6YiqWPrfXkrW
	 Q7/XxNn0OaTfjkh8Y2YXUBdKmoujeKrm1cl1XNYtRNDyIfWySILyMND1L1Tpbt07CM
	 IAw3+N5mODGhE86LZ/Dghr4iE/poRv50ivragmUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgERK3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgERK3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:29:42 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B9020657;
        Mon, 18 May 2020 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589797781;
        bh=arObw6BOIgBBUZeksezIt2wHSMyc4GY++N1SgQCNWYU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XLXmi8lYEgfVAf1iAAlNqfd9FbKq/O1BYHhqOu6QaRtVcGF9TUXzxSfFUstCRX1PI
         djnTSpO9reSXFNM5T6CelZdwu7RLwc00rzclzjq/k6OkWYBYZB5iXAuy0IUER1bWS/
         bjRw3CklOp4wvePz3Op4MStBNXFDM/k6xBoSaVDc=
Date:   Mon, 18 May 2020 12:29:37 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
cc:     WANG Wenhu <wenhu.wang@vivo.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wenhu.pku@gmail.com
Subject: Re: [PATCH] powerpc/sysdev: fix compile errors
In-Reply-To: <62251ec1-dd42-6522-dcb2-613838cd5504@c-s.fr>
Message-ID: <nycvar.YFH.7.76.2005181228480.25812@cbobk.fhfr.pm>
References: <20200302053801.26027-1-wenhu.wang@vivo.com> <62251ec1-dd42-6522-dcb2-613838cd5504@c-s.fr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020, Christophe Leroy wrote:

> > Include linux/io.h into fsl_85xx_cache_sram.c to fix the
> > implicit-declaration compile errors when building Cache-Sram.
> > 
> > arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function
> > ‘instantiate_cache_sram’:
> > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit declaration
> > of function ‘ioremap_coherent’; did you mean ‘bitmap_complement’?
> > [-Werror=implicit-function-declaration]
> >    cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
> >                            ^~~~~~~~~~~~~~~~
> >                            bitmap_complement
> > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment makes
> > pointer from integer without a cast [-Werror=int-conversion]
> >    cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
> >                          ^
> > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit declaration
> > of function ‘iounmap’; did you mean ‘roundup’?
> > [-Werror=implicit-function-declaration]
> >    iounmap(cache_sram->base_virt);
> >    ^~~~~~~
> >    roundup
> > cc1: all warnings being treated as errors
> > 
> > Fixed: commit 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
> > Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

As this doesn't seem to have been picked up for linux-next yet, I am 
picking it up now.

Thanks,

-- 
Jiri Kosina
SUSE Labs

