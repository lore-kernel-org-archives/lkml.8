Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0828EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA6D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596540876;
	bh=PdL7dmBcGVuTWu4ybcpV6t4DvW7WSlxwwBQKJaRjvBg=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=YY51Ws7+Vstdtsx1lpToCivec8lj/NVpywrbUhbsuhJgTuHJGvow3WMa01o8z8ENa
	 AZz8XfoIcdfBhCIOdXTgluc0UpnTIPrDH+dpusRwTcUu+E5SsB4ZfavSNaJHH16O9B
	 0zp+3kGD62snHlT5qE/6IbMfLQJBryhprDpceQKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgHDLef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgHDLed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:34:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653182086A;
        Tue,  4 Aug 2020 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596540873;
        bh=PdL7dmBcGVuTWu4ybcpV6t4DvW7WSlxwwBQKJaRjvBg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QxCfIxE4JI3HoeOCBjew2jm2grr9RL1ZWpwzTwpn4OV+o4IH335ItqMKfOQy440Uh
         LMF2MmzShTVtP6PJk+z43xl9tTGkT5ZAlaynPNI3t+dSKsge3OxDWqkncWckxWLieM
         bm/l2Ls9ff6IxvbTTfH+qggloAKYc9Z8JKkAc/QE=
Date:   Tue, 4 Aug 2020 13:34:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH 2/2] speakup: only build serialio when ISA is enabled
Message-ID: <20200804113413.GA181242@kroah.com>
References: <20200804111332.dex7jobmabifdzw5@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804111332.dex7jobmabifdzw5@function>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:13:32PM +0200, Samuel Thibault wrote:
> Drivers using serialio are already made available in Kconfig only under
> the ISA condition.
> 
> This solves warnings in inb/outb macros on platform that do not have 
> support for ISA.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Index: linux-2.6/drivers/accessibility/speakup/Makefile
> ===================================================================
> --- linux-2.6.orig/drivers/accessibility/speakup/Makefile
> +++ linux-2.6/drivers/accessibility/speakup/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_SPEAKUP_SYNTH_TXPRT) += spe
>  obj-$(CONFIG_SPEAKUP_SYNTH_DUMMY) += speakup_dummy.o
>  
>  obj-$(CONFIG_SPEAKUP) += speakup.o
> +obj-$(CONFIG_ISA) += serialio.o
>  speakup-y := \
>  	buffers.o \
>  	devsynth.o \
> @@ -25,7 +26,6 @@ speakup-y := \
>  	keyhelp.o \
>  	kobjects.o \
>  	selection.o \
> -	serialio.o \
>  	spk_ttyio.o \
>  	synth.o \
>  	thread.o \

Oops, no, I get the following build errors with this patch:

ERROR: modpost: "spk_wait_for_xmitr" [drivers/accessibility/speakup/speakup.ko] undefined!
ERROR: modpost: "spk_serial_io_ops" [drivers/accessibility/speakup/speakup_keypc.ko] undefined!
ERROR: modpost: "spk_stop_serial_interrupt" [drivers/accessibility/speakup/speakup_keypc.ko] undefined!
ERROR: modpost: "spk_serial_io_ops" [drivers/accessibility/speakup/speakup_dtlk.ko] undefined!
ERROR: modpost: "spk_stop_serial_interrupt" [drivers/accessibility/speakup/speakup_dtlk.ko] undefined!
ERROR: modpost: "spk_serial_io_ops" [drivers/accessibility/speakup/speakup_decpc.ko] undefined!
ERROR: modpost: "spk_stop_serial_interrupt" [drivers/accessibility/speakup/speakup_decpc.ko] undefined!
ERROR: modpost: "spk_serial_io_ops" [drivers/accessibility/speakup/speakup_acntpc.ko] undefined!
ERROR: modpost: "spk_stop_serial_interrupt" [drivers/accessibility/speakup/speakup_acntpc.ko] undefined!


So something else needs to change here, sorry, dropping this patch for
now.

thanks,

greg k-h
