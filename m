Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33182C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001B2208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593761641;
	bh=4X8EptKuVmIRHczWnGAk4f5jxz5Jmp/CxW9Qyr7SLlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=To5CVYRAG+dqVvut98iK6n1Ck5ba9+HbU3T4R+wJf1zCrxqlGNydccMtqVbk2SZiq
	 52Ait7xujfiMh0pVaHKe1iNPegndiYndi5KAFOL94kvTAv8WJPaR6HtB8Y+cStt2nb
	 sNVIzsMqd0tAPIo78DnN4fkIgcUDhlYsug2N3amI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGCHd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCHd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:33:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC4C20890;
        Fri,  3 Jul 2020 07:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593761638;
        bh=4X8EptKuVmIRHczWnGAk4f5jxz5Jmp/CxW9Qyr7SLlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xP29TgNt/OYLTmQo4oRy8S8lE2ZUB06r1jDPmGiiEtKUFwINtTBM6t81FaTmkRTna
         nV00EPBneiU/XK5Wb3wHVip36XEc45M/PDr2kZtuGUs1wao1Sb4zJtQtOnMh+1rFqw
         1wv7QzdDVlHsueI0F4hJsDqJecy8t439djzKwkzw=
Date:   Fri, 3 Jul 2020 09:34:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 28/30] usb: c67x00: c67x00-hcd: Demote obvious misuse of
 kerneldoc to standard comment blocks
Message-ID: <20200703073402.GA2336858@kroah.com>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
 <20200702144625.2533530-29-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702144625.2533530-29-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:46:23PM +0100, Lee Jones wrote:
> No attempt has been made to document any of the functions here.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'sie' not described in 'c67x00_hcd_irq'
>  drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'int_status' not described in 'c67x00_hcd_irq'
>  drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'msg' not described in 'c67x00_hcd_irq'
>  drivers/usb/c67x00/c67x00-hcd.c:267: warning: Function parameter or member 'hcd' not described in 'c67x00_hcd_start'
>  drivers/usb/c67x00/c67x00-hcd.c:279: warning: Function parameter or member 'hcd' not described in 'c67x00_hcd_stop'
> 
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/c67x00/c67x00-hcd.c | 6 +++---
>  drivers/usb/class/cdc-wdm.c     | 2 +-

You also tried to fix up the cdc-wdm.c whitespace error in this patch :(

I've dropped this one from the queue as well.

thanks,

greg k-h
