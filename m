Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1781BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B612A207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599640551;
	bh=tOhCuyrwtMUUuVRNkiFaNUZvPPYBLzxQHqIy6RtPF4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZGwhnXmbpQQ7cCTM9XSvEOyIZgbRy8gk4ougRv+srAufJys3k0x+9E17I2CpJku1x
	 +y4F9wvFAtgi73OGgxfEPInkDdsWXXkrkdyeAuwc8yuXfasdgCXu88GRfZgwpeaH6u
	 v04P5uunWDKBM+beWFpFZ+lDFnN84rVKM5/4AJc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIIIfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgIIIfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:35:46 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9347520578;
        Wed,  9 Sep 2020 08:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599640545;
        bh=tOhCuyrwtMUUuVRNkiFaNUZvPPYBLzxQHqIy6RtPF4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTK03nSKEn9Y7z+1lbDKDlgXeHdeox/iLUALfEVHTlipG4/X5cdvBnOABI92Alz6b
         uH1N94H0cC84ABMckSMgzbyn1sMTLM7PdbXSKSD4H42JzTzg+HQ0TCcH3zCqD28Ip/
         EoWv45PsUOokY3HJdtDAQ+ozyQ3EaXKffXyQw30c=
Date:   Wed, 9 Sep 2020 10:35:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] misc: hisi_hikey_usb: Driver to support onboard
 USB gpio hub on Hikey960
Message-ID: <20200909083555.GA579996@kroah.com>
References: <cover.1599493845.git.mchehab+huawei@kernel.org>
 <d53de8ab89c23e4be6d2a4fd24b10bcd76dad97d.1599493845.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53de8ab89c23e4be6d2a4fd24b10bcd76dad97d.1599493845.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 05:59:32PM +0200, Mauro Carvalho Chehab wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> The HiKey960 has a fairly complex USB configuration due to it
> needing to support a USB-C port for host/device mode and multiple
> USB-A ports in host mode, all using a single USB controller.
> 
> See schematics here:
>   https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> 
> This driver acts as a usb-role-switch intermediary, intercepting
> the role switch notifications from the tcpm code, and passing
> them on to the dwc3 core.
> 
> In doing so, it also controls the onboard hub and power gpios in
> order to properly route the data lines between the USB-C port
> and the onboard hub to the USB-A ports.
> 
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> [jstultz: Major rework to make the driver a usb-role-switch
>           intermediary]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS                   |   7 ++
>  drivers/misc/Kconfig          |   9 ++
>  drivers/misc/Makefile         |   1 +
>  drivers/misc/hisi_hikey_usb.c | 205 ++++++++++++++++++++++++++++++++++
>  4 files changed, 222 insertions(+)
>  create mode 100644 drivers/misc/hisi_hikey_usb.c

Can this, and the next patch, go into my char-misc tree independent of
the other patches in this series?  Or do they all need to go in
together?

thanks,

greg k-h
