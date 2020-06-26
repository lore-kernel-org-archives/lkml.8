Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BA6206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593181908;
	bh=BVMWvPhWg1IVXGZyHr7y/cDzo9HIeg1mzA0zLZ9Ejps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UvIDwbqURMUggPNzTC6Z0MZKLopCsxih04vyFwKUDu7Gkv8puPGYr8+2tl92wZ58+
	 MbDyIsmAvScFNNvIyUOI85vLBH7sNXYNmBkbi4RXY+d7bfDUKJE06nSSnvIMexCCuD
	 ZtBL5Xo1vhT4n/dQIdqQSMvRHZCUgHbX0L9B09Ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgFZObq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFZObp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:31:45 -0400
Received: from Mani-XPS-13-9360 (unknown [157.46.30.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7651E206DD;
        Fri, 26 Jun 2020 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593181904;
        bh=BVMWvPhWg1IVXGZyHr7y/cDzo9HIeg1mzA0zLZ9Ejps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=badPBwiYsRmYofQAi4idwNbti2jF26K3xs6g3nIV2db44SeDqs/iL1PFgxmBfJcyG
         dQQbQD4WN5nREeUwl0lrG1vdpBgPLFg3nPdrZhttIHd5MHBwxo6NtCeF58Jmbkik8T
         2blj98QTMW35DYtUf/ZA9kBBhv0k66OCaXgwA260=
Date:   Fri, 26 Jun 2020 20:01:36 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH v4 0/3] Add support for MaxLinear/Exar USB to serial
 converters
Message-ID: <20200626143136.GF8333@Mani-XPS-13-9360>
References: <20200607160809.20192-1-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607160809.20192-1-mani@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 09:38:06PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds support for MaxLinear/Exar USB to serial converters.
> This driver only supports XR21V141X series but it can easily be extended
> to other series in future.
> 
> This driver is inspired from the initial one submitted by Patong Yang:
> 
> https://patchwork.kernel.org/patch/10543261/
> 
> While the initial driver was a custom tty USB driver exposing whole
> new serial interface ttyXRUSBn, this version is completely based on USB
> serial core thus exposing the interfaces as ttyUSBn. This will avoid
> the overhead of exposing a new USB serial interface which the userspace
> tools are unaware of.
> 
> This series has been tested with Hikey970 board hosting XR21V141X chip.
> 

Gentle ping on this series!

Thanks,
Mani

> Thanks,
> Mani
> 
> Changes in v4:
> 
> * Multiple improvements based on Johan's review. Noticeable ones are:
>   - Now the driver claims both control and data interfaces but only registers
>     tty device for data interface.
>   - GPIO pin status is now shared between the console and gpiolib
>     implementations. This is done to avoid changing the lines spuriously.
>   - A separate port_open flag is added to reject GPIO requests while the tty
>     port is open.
>   - Removed padding PID to gpio device.
> * Added Greg and Mauro's review and tested tags.
> * Included a patch from Mauro to avoid the CDC-ACM driver to claim this device
>   when this driver is built.
> 
> Changes in v3:
> 
> * Dropped the check for PID and also the reg_width property.
> 
> Changes in v2:
> 
> * Dropped the code related to handling variable register size. It's all u8 now.
> * Dropped the header file and moved the contents to driver itself.
> * Added Linus's reviewed-by tag for gpiochip patch.
> * Added PID to gpiochip label
> * Dropped gpiochip for interface 0 
> 
> Manivannan Sadhasivam (2):
>   usb: serial: Add MaxLinear/Exar USB to Serial driver
>   usb: serial: xr_serial: Add gpiochip support
> 
> Mauro Carvalho Chehab (1):
>   usb: cdc-acm: Ignore Exar XR21V141X when serial driver is built
> 
>  drivers/usb/class/cdc-acm.c    |   6 +
>  drivers/usb/serial/Kconfig     |   9 +
>  drivers/usb/serial/Makefile    |   1 +
>  drivers/usb/serial/xr_serial.c | 857 +++++++++++++++++++++++++++++++++
>  4 files changed, 873 insertions(+)
>  create mode 100644 drivers/usb/serial/xr_serial.c
> 
> -- 
> 2.17.1
> 
