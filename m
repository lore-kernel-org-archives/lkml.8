Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63988C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D3F207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgH1CAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:00:51 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:47530 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgH1CAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:00:50 -0400
Date:   Thu, 27 Aug 2020 22:00:48 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-ID: <20200828020045.GT3265@brightrain.aerifal.cx>
References: <20200714121856.955680-1-hch@lst.de>
 <20200714121856.955680-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714121856.955680-10-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:18:55PM +0200, Christoph Hellwig wrote:
> The code handling non-coherent DMA depends on being able to remap code
> as non-cached.  But that can't be done without an MMU, so using this
> option on NOMMU builds is broken.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/sh/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index f8027eee08edae..337eb496c45a0a 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -61,6 +61,7 @@ config SUPERH
>  	select MAY_HAVE_SPARSE_IRQ
>  	select MODULES_USE_ELF_RELA
>  	select NEED_SG_DMA_LENGTH
> +	select NO_DMA if !MMU && !DMA_COHERENT
>  	select NO_GENERIC_PCI_IOPORT_MAP if PCI
>  	select OLD_SIGACTION
>  	select OLD_SIGSUSPEND
> @@ -135,7 +136,7 @@ config DMA_COHERENT
>  	bool

This change broke SD card support on J2 because MMC_SPI spuriously
depends on HAS_DMA. It looks like it can be fixed just by removing
that dependency from drivers/mmc/host/Kconfig.

Rich
