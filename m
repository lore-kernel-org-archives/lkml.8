Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2B1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051DF22B40
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595524289;
	bh=iB/F1b5c+X/36Vs+nTnucwPGaMsJaU4s+syuS6lbxts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JmekTpw4phQIP0IreAw273WLLMHh64pwECZkXOVojrFT/BEKlhkT8Yt8lIOeJG0ha
	 FakKAKtSP2t04spiYjWsM1scDH52dvlhiQ8TV/f8gTih/yxHur1pg4Z6DOl2pduaX3
	 K6qcTVkuFi5wCre2giPZZstNq7EEsCkDjVydWqNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgGWRL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgGWRL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:11:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2FA208E4;
        Thu, 23 Jul 2020 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595524286;
        bh=iB/F1b5c+X/36Vs+nTnucwPGaMsJaU4s+syuS6lbxts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPTBiJMhu5ImSYJNW8LP2Wa1fUpxncRShVXTFqE0CV6MsVfWH7lroBIcEkzJyHptH
         TxxbCxUgO3f7jZvJ+3dwpcsNTKQoDWET0Sbf2Z0MBnB19ihcoQ3TKXKt4lk3zFCnqT
         Tn4E72d6oMCu+fUIgfGwy1HDRG1ltEP49G9denz4=
Date:   Thu, 23 Jul 2020 19:11:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yannick Schinko <y.schinko@connectingmedia.de>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Interact with a serial device over USB
Message-ID: <20200723171130.GC2835510@kroah.com>
References: <AM4PR0301MB22282740FE8D06D8BB573F0583760@AM4PR0301MB2228.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0301MB22282740FE8D06D8BB573F0583760@AM4PR0301MB2228.eurprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 03:06:51PM +0000, Yannick Schinko wrote:
> Hello,
> 
> so before I get into any detail I'd like to make clear that I am not at all familiar with the Linux kernel itself. However I'm not an inexperienced programmer.
> Additionally the driver I'm describing here (and that I ultimately plan to create) is not intended to merged into the kernel itself. It's made for a specific piece of hardware that will only be produced in miniscule numbers. In turn that means removing existing modules to replace them with my own is a possibility.

We take kernel drivers into the tree for only one piece of hardware in
the world, and one user.  So don't think that we would not take such a
thing, if it were actually needed (see below...)

> 
> Now, why I am writing here in the first place:
> Currently the company I work for is designing an inline UPS for a very specific board (the APU2 series from PC engines). On that UPS there's a microcontroller that communicates over USB with the help of a CH341 chip.
> I have already successfully implemented an userland program that communicates with the microcontroller. This works great! However there's two issues that led me to the conclusion that I need to implement this as a kernel module:
> - Startup and shutdown times/timings: I noticed early on that the program starts too late on boot and stops too early on shutdown, no matter what I did (excluding very very dirty and impractical solutions that should never be used in any kind of production machine) I could not get it to start early enough and survive the shut down sequence long enough. The only way I can think of to circumvent this is by turning the program into a kernel module as that will allow it to start before the OS and to shutdown after the OS, which would be acceptable.

Just fix your system to do this better.  You can start your program
_REALLY_ early at boot, and just never stop running it until you power
down.  That control is up to you, you do not have to be a kernel module
to do that at all.

In fact, you could run your code _before_ kernel modules are loaded, by
putting it into the initramfs, if you really need it.

This isn't a kernel issue, but a userspace configuration issue, that you
have control over fixing.

> - Providing sensor data: The microcontroller has voltage sensors and temperature sensors that I would like to make available to userspace through the normal hwmon interfaces. According to my research that is only possible using a kernel module. Funnily enough that part is already implemented and works provided I feed it mocked data.

Why not use a userspace USB driver to talk to the device and do it that
way?  Why does it have to be a kernel driver?

> In consequence I need to create a kernel module (or at least I think
> so) that listens to data sent by the microcontroller over USB and then
> sends back some other information in response.

Userspace USB code works just fine for this too.

> As a secondary functionality it would be amazing if I somehow could still forward that device as a tty (as it currently is) so I can flash firmware using avrdude. I was thinking that as long as nothing is using that tty in userspace, the kernel module listens to the device and sends responses but stops doing that as soon as the tty is in use and also continues listening again as soon as it's no longer in use. While this would be amazing to have it's not required for our use case.

I don't understand what you mean by this.

In short, I think you should be able to do everything you want/need from
userspace today, no kernel programming needed.

good luck!

greg k-h
