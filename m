Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AD7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6519B20723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590405127;
	bh=vRFVXyIsmXnGGPyWv/9BQ79AvtKwa530dOjUkPXl8WM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CGWNt5bY5B3RqZybBphx7ivdU5GlQ/FctZhJcfrXQUrhB8evUMn53qlUOO7WemPuc
	 98+ScFVZn0D8hpOsDL8En0tfEtYCG1x1G1VFwoe3sEo/knDNbB6Pmhbbz7stCcTjJD
	 1FbCPWQhuQqqYErFRzbdrESCmMYT+kbLhvDlypVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390102AbgEYLMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390003AbgEYLMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:12:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF0F20723;
        Mon, 25 May 2020 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590405125;
        bh=vRFVXyIsmXnGGPyWv/9BQ79AvtKwa530dOjUkPXl8WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/XxOHBDQOiPx2mx/lu6b+Em6kLEldYgVbgV039cMwBhdP5FcTvg7e6IAvV+Ty3vW
         ohH4JaIWQUajJj1vhstYuNy6Vyd0ua32NwzrXliQC7L4r0IdB4J+W4n0aEr/glI33v
         +wrSsS79xmKZ3Y9nK/Tsk10aFdLjKmQO/6DQiQIE=
Date:   Mon, 25 May 2020 13:12:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patong.mxl@gmail.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: serial: xr_serial: Add gpiochip support
Message-ID: <20200525111203.GB279021@kroah.com>
References: <20200428195651.6793-1-mani@kernel.org>
 <20200428195651.6793-3-mani@kernel.org>
 <CACRpkdZ3b-VLvxN06H_4cDOtUEQTVbe=Zw+NA=YjssMzK2d2sQ@mail.gmail.com>
 <20200429124918.GC6443@Mani-XPS-13-9360>
 <20200519085703.GB27787@localhost>
 <CACRpkdapMuMs_mEUHheGtaKYg97=nL1bH3zq4Tc3cnX9Jbw-Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdapMuMs_mEUHheGtaKYg97=nL1bH3zq4Tc3cnX9Jbw-Ew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 10:59:59AM +0200, Linus Walleij wrote:
> On Tue, May 19, 2020 at 10:57 AM Johan Hovold <johan@kernel.org> wrote:
> > > On Wed, Apr 29, 2020 at 02:12:24PM +0200, Linus Walleij wrote:
> 
> > > > to something that is device-unique, like "xr-gpios-<serial number>"
> > > > which makes it easy to locate the GPIOs on a specific serial converter
> > > > for lab use. However the USB serial maintainers know better what
> > > > to use here. Whatever makes a USB-to-serial unique from a TTY
> > > > point of view is probably fine with me too.
> > > >
> > > > My idea is that people might want to know which USB cable
> > > > this is sitting on, so I have this USB cable and from this label
> > > > I can always figure out which GPIO device it is.
> >
> > I think we've had this discussion before. First, not every device has a
> > unique serial number. Second, we already have a universal way of
> > distinguishing devices namely by using the bus topology. That's
> > available through sysfs and shouldn't have to be be re-encoded by every
> > driver in the gpiochip name.
> 
> I remember I even referred to this myself, but I've been waning a bit
> on it recently, because it turns out that userspace/users aren't very
> good at parsing sysfs for topology.

Which is why they could use libudev :)

thanks,

greg k-h
