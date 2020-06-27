Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4CCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D5220720
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593234775;
	bh=Gw5zaq+vMe/vtdVW8SlA7Vem2sWc7vMLiEdibwo5Tno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zDQYQwjKUPSNqNR13JKv7iNc4FSDPnTlFclTQ+G55lrp/duKZv8/Wfwvm8cHQnwmj
	 xZu11rjRFUr4biVfIh9hpopP0yWbrijKgodXFRkRdFQ8kg+5am5/C3BKGt32ess1AR
	 OstKzWCdHrWUXbouqY7nk6fnBj3PsPCc4R7vxqnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgF0FMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 01:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgF0FMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 01:12:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78BCD20720;
        Sat, 27 Jun 2020 05:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593234773;
        bh=Gw5zaq+vMe/vtdVW8SlA7Vem2sWc7vMLiEdibwo5Tno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwo183Uw/BYuL37VI8DSmUM58XmYEuDcx3JGyXEv04LLKrFdsl0Qpf4I8MNpPt/A1
         97MOndH+T+zSyc072BVSrb4TmDgxSJ0Kh6y5hOT+rCMvEQdws1tdAD6UjHKDgIyTcB
         uuu58Hmg+kEK+tk2Z+tuApffxTblN3d6OayY0QiA=
Date:   Sat, 27 Jun 2020 07:12:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbtft-bus.c: Removing that prohibited space before ')'
Message-ID: <20200627051249.GB233327@kroah.com>
References: <20200627045150.ysqvd47o52f4a6rc@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627045150.ysqvd47o52f4a6rc@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 12:51:50AM -0400, B K Karthik wrote:
> fbtft-bus.c:
> 
> fixing ERROR: space prohibited before that close parenthesis ')' by removing that space and ',' in line 65 and 67.
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 63c65dd67b17..847cbfbbd766 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)

Also, did you test-build this patch?  I think this just broke the
build...

