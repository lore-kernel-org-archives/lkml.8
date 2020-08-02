Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEA2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 09:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F37B2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 09:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596359958;
	bh=0sI0cWie9tDag5hLKiiEIxgczqIVsId5Urn4Kg/NpKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q0cIAaZLb9tfO8uye8evne/kKwdAZSVkJEokTaYzKXhM1ywgJouLXAHox4RVZhQgD
	 cn3f5g/4IZ8+OjH8WED9u4CTI4CQZD4jup/bk/3LPV9h8e5GXwIBt6zLEXk9VyArBm
	 vl6s7jjfAbUOEWDPBM0NhPKPvsOQ1NlErqSEHC3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHBJSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 05:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgHBJSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 05:18:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EFFF2075A;
        Sun,  2 Aug 2020 09:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596359928;
        bh=0sI0cWie9tDag5hLKiiEIxgczqIVsId5Urn4Kg/NpKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjHZNGLz0TbQXYhHdW6OWrj7pa4joZga8CIPJb2UKyjNWCc1JkuPP9coatSZC0jyV
         76oFX1J+0RfDgog+l0JGdanPNVux7AjCoFJeHhKZcx0e6zfx1/LnTpJs+QtWbUcMSb
         +f6LrpF5CFnL/fnAGeuChwsz3k3syx0mkaxhUDcg=
Date:   Sun, 2 Aug 2020 11:18:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, christian.gromm@microchip.com,
        linux-kernel@vger.kernel.org
Subject: Re: staging: most: Build error since commit "drivers: most: add USB
 adapter driver"
Message-ID: <20200802091831.GA139182@kroah.com>
References: <7c18e466-0941-ee7e-9a0f-5a993c993152@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c18e466-0941-ee7e-9a0f-5a993c993152@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 11:08:12AM +0200, Michael Straube wrote:
> Hi,
> 
> with commit 97a6f772f36b7f52bcfa56a581bbd2470cffe23d ("drivers: most: add USB adapter driver")
> I get build errors.
> 
> $ LANG=C make clean drivers/staging/rtl8188eu/
> scripts/Makefile.clean:15: drivers/staging/most/usb/Makefile: No such file or directory
> make[5]: *** No rule to make target 'drivers/staging/most/usb/Makefile'.  Stop.
> make[4]: *** [scripts/Makefile.clean:66: drivers/staging/most/usb] Error 2
> make[3]: *** [scripts/Makefile.clean:66: drivers/staging/most] Error 2
> make[2]: *** [scripts/Makefile.clean:66: drivers/staging] Error 2
> make[1]: *** [Makefile:1763: _clean_drivers] Error 2
> make: *** [Makefile:336: __build_one_by_one] Error 2
> 
> Did you forgot to remove the below line from drivers/staging/most/Makefile ?
> 
> obj-$(CONFIG_MOST_USB)	+= usb/

Ugh, yes, let me go fix that up right now, sorry...

greg k-h
