Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB362C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 07:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF9B20709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 07:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589612788;
	bh=lFzLoaOUcj9DJlLvvHy8WTx+G2J35XTXJzirouItywQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qyKgag3le1i6V8eDLIlXkhElX8MdUvbjQgFoWbAKkrSOCuldDZC8Q+ilBDrZGN9xM
	 0E4TDBDKaTdaFzZCUmp1b4f+JFKPWPUGEaMnU+k8kjDhtr4ZtLObpbKJkQxmtgDwWq
	 Ih5bKuzeWlfnTFFwe9tBF9hV8iA37KZs+rL160kU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgEPHG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 03:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgEPHG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 03:06:27 -0400
Received: from Mani-XPS-13-9360 (unknown [157.51.192.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B432120709;
        Sat, 16 May 2020 07:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589612786;
        bh=lFzLoaOUcj9DJlLvvHy8WTx+G2J35XTXJzirouItywQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvVnQ0UF0WyuYs+oQDHXYwOfi1DGJVi9MZ4LEJdlb3g5xSNKCCnxQt/xrUHiCdqBf
         W4hgyE7jxiT0HePNR4Dax8nMZtSZqg4wlmGr2JANEs4iOmBXbmtZm4l1GVmL2w8Joe
         K3PADRDT0mWJ/jVFWS7zolBm7PXHIR60RTVIaLxA=
Date:   Sat, 16 May 2020 12:36:17 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com
Subject: Re: [PATCH v3 0/2] Add support for MaxLinear/Exar USB to serial
 converters
Message-ID: <20200516070617.GA9587@Mani-XPS-13-9360>
References: <20200430184924.31690-1-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430184924.31690-1-mani@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 01, 2020 at 12:19:22AM +0530, mani@kernel.org wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
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

Any update on this series?

Thanks,
Mani

> Thanks,
> Mani
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
>  drivers/usb/serial/Kconfig     |   9 +
>  drivers/usb/serial/Makefile    |   1 +
>  drivers/usb/serial/xr_serial.c | 821 +++++++++++++++++++++++++++++++++
>  3 files changed, 831 insertions(+)
>  create mode 100644 drivers/usb/serial/xr_serial.c
> 
> -- 
> 2.17.1
> 
