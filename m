Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE209C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF7C207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594843;
	bh=Kz+MsIx+k0H0Jyjr25FoFiXZUgZRjJfbjCM/BqH9qMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NIrqnvU/DbQOoIwCrrgr7sezitOE3xvaWH+amMGRCOcV2ioXQKX1+VqdGfEn+1Tul
	 ONl7N4r2I03nxbHBxgEYocoPvKdyPs7qVtlYWPOMOo1SyVNvpJZ5tNzUKrHyQ4TZG6
	 quxckE1LeZ/vcfxec6BYcxBdNDmpHKKj+r0kfd9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbgIHTyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbgIHPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:42:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 855BA20936;
        Tue,  8 Sep 2020 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599578516;
        bh=Kz+MsIx+k0H0Jyjr25FoFiXZUgZRjJfbjCM/BqH9qMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmfyECmelqzQhvE3og7RX1xbYVDY8b1ej613t07oSH4GQEQQ1cvKbuxDoQbtxCGYj
         mW1IILvjiaCd2v8ko8zi27vBMSd8xrLOqppC2lFtuwCEC0LkilFcSVvj76leMu2OW/
         LmXxYGP8UIWfpiTbcAR60Xb+HsaihKhoPRBC8gHI=
Date:   Tue, 8 Sep 2020 17:22:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 03/12] x86/platform/uv: Adjust references in UV kernel
 modules
Message-ID: <20200908152207.GC4114051@kroah.com>
References: <20200907185430.363197758@hpe.com>
 <20200907185430.685975987@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907185430.685975987@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:54:33PM -0500, Mike Travis wrote:
> There is a symbol clash from the auto-generated uv_mmrs.h file that
> clashes with code in the UV kernel modules (is_uv() is the symbol).
> Change those prior to the symbol clash so as to not cause a compile error.
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  drivers/misc/sgi-xp/xp.h            |   11 ++++++-----
>  drivers/misc/sgi-xp/xp_main.c       |    7 ++++---
>  drivers/misc/sgi-xp/xp_uv.c         |    9 ++++++---
>  drivers/misc/sgi-xp/xpc_main.c      |    9 +++++----
>  drivers/misc/sgi-xp/xpc_partition.c |    5 +++--
>  drivers/misc/sgi-xp/xpnet.c         |    5 +++--
>  6 files changed, 27 insertions(+), 19 deletions(-)
> 
> --- linux.orig/drivers/misc/sgi-xp/xp.h
> +++ linux/drivers/misc/sgi-xp/xp.h
> @@ -3,7 +3,8 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   *
> - * Copyright (C) 2004-2008 Silicon Graphics, Inc. All rights reserved.
> + * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
> + * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.

This change does not make sense.  If you want to make it, please make it
in a separate patch that justifies the dates being added here please.

thanks,

greg k-h
