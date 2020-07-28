Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B51C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE66A2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595951702;
	bh=aVftNjJBgQbHkyV3BbCKhpUmkcMZMJhVZkUAyIMrxes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ywfTYfizfaBJp4piAgPMkfFOZ6NVrw/ZT0SfNlbQOT8T7cyI25XuTjAvrvXtDQM0H
	 w/BogIj714FLGSCSd1QTktzGoXumli1foX0iY1UpEXpWFogq6/JPfpiwl9HUJy5n68
	 gFotI815dwap0eqvVgfE7R8UBhuC7ejQhGIWOXLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgG1PzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbgG1Py6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:54:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988B42065C;
        Tue, 28 Jul 2020 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595951697;
        bh=aVftNjJBgQbHkyV3BbCKhpUmkcMZMJhVZkUAyIMrxes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PaJDO+2egn0tExAMjFcINRhEZuduM5y5VyMlpw6CyrlqR2wGK6iE1K9DWnECrkpAO
         EZvKi8Ha4FjIYRWNHpfIXxo1j5YG2O912Tw04ZRJPsJMR2Lbj5fVGiMze3R2cNBF9M
         8QF+GF2RmceMPUDeCayAi5Bur+3012P35+dp722U=
Date:   Tue, 28 Jul 2020 17:54:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Qinglang Miao <miaoqinglang@huawei.com>,
        linux-m68k@lists.linux-m68k.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] m68k/amiga: Add missing platform_device_unregister()
 call in amiga_init_devices()
Message-ID: <20200728155450.GC4178776@kroah.com>
References: <1e12105b-aa72-11a2-74f6-c789f8ceaaa3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e12105b-aa72-11a2-74f6-c789f8ceaaa3@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 04:50:06PM +0200, Markus Elfring wrote:
> > Add the missing platform_device_unregister() before return
> > from amiga_init_devices() in the error handling case.
> 
> Will the tag “Fixes” become helpful for the commit message?
> 
> 
> …
> > +++ b/arch/m68k/amiga/platform.c
> > @@ -188,8 +188,10 @@  static int __init amiga_init_devices(void)
> >  			return PTR_ERR(pdev);
> >  		error = platform_device_add_data(pdev, &a1200_ide_pdata,
> >  						 sizeof(a1200_ide_pdata));
> > -		if (error)
> > +		if (error) {
> > +			platform_device_unregister(pdev);
> >  			return error;
> > +		}
> >  	}
> …
> 
> I suggest to add a jump target for the desired exception handling.
> 
>  		if (error)
> +			goto unregister_device;
> 
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
