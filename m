Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B046C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A19B20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="e0xw1Pqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgBYLi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:38:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34157 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgBYLiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:38:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id i10so914146wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vWNd4dO9rM0Zn6N45+ujni9L7yvp+AVlxZygsZuZiUk=;
        b=e0xw1Pqeb1tdU2Rqpqe16SGK7lLTGnDR6ly2V1DQ1l6sUygGKmnIgwkEWEX0+aTNZQ
         Q6qfr55Nc1fi9R2ab8zy1Kw0UB+GDYv/ufui4KBNJbO4XGu4b5uV2/Fh5GiymEgOMXyE
         c3xc8W4oC3Zat68vWtvw/vfp2/6mAxEc34SGMtTqrSCgpXw5i7sWkkXiHfinfaX3hlK+
         0QbWdOIGroVyF1xE06P8DT8pAkA/MgMzkIf7648HJzs+Feyw1FPv7/jLEfbV8ABNg4oA
         DZRVmTNGuoSXNr3saqqnqFEBJj1HNaOtF80QqMYmJjf99hrTGLJalG3rKKZXhvTbXjQH
         c7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vWNd4dO9rM0Zn6N45+ujni9L7yvp+AVlxZygsZuZiUk=;
        b=mTsWMyJTDanL5Z+SxcIe4POITFjSAICv1gL4A57bt2VXiqFlK+232/RbIX0T4ltaoS
         usObOAq3oyIRP1Ob8pFD2jsQDEl+Y1mvuqv/rMiQGGJj8gM5ALxcTazOK+EwM+WANzeK
         Mqdza+GQmmY1rB+8sFm3Ynp22yjTIRTeKlWDp6Q8avdngr5cRFSOsAddLJmFMY1rK8xz
         LO3xx2YaIfY0WUhrYrCZrTSg92QrVkPFSrrEQwfQ3KXnVYu8O++x1F3tp2kYgWoVw9xv
         jK8Ks1ayl4avUxXG0s6M+SGy+LvK1cCll6Q+lN+qZewunb+HTKgWl44lV0kvUEhk3WNY
         Pp8Q==
X-Gm-Message-State: APjAAAXv1jIhXYDRIWeFbIATPvkAEwVjOL2VJKRXeA6MrSa9i4X+pD1L
        NUKqTXWOeCV48KA4waxM/5PnmVaYLNzVoQvTWC4524GLbXY=
X-Google-Smtp-Source: APXvYqxJYb6X2aa8QKMNaCwxTid7DjpjeMWf5aBxYWn0sHuWlTKcUUjVqeGbRB80+4k5vma2rEZLtius03fqLOsmxBE=
X-Received: by 2002:a1c:7919:: with SMTP id l25mr4739099wme.135.1582630703752;
 Tue, 25 Feb 2020 03:38:23 -0800 (PST)
MIME-Version: 1.0
References: <c753b529bdcdfdd40a3cf69121527ec8c63775cb.1581505183.git.michal.simek@xilinx.com>
In-Reply-To: <c753b529bdcdfdd40a3cf69121527ec8c63775cb.1581505183.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 25 Feb 2020 12:38:12 +0100
Message-ID: <CAHTX3dJN5No9wUSDnmcMQXsGRKXKcLrDx_OhP-MF2yL+dXFu7w@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc-xilinx: Fix xudc_stop() kernel-doc format
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@ti.com>, Peter Chen <peter.chen@freescale.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

st 12. 2. 2020 v 11:59 odes=C3=ADlatel Michal Simek <michal.simek@xilinx.co=
m> napsal:
>
> The patch removes "driver" parameter which has been removed without
> updating kernel-doc format.
>
> Fixes: 22835b807e7c ("usb: gadget: remove unnecessary 'driver' argument")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  drivers/usb/gadget/udc/udc-xilinx.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc=
/udc-xilinx.c
> index 29d8e5f8bb58..b1cfc8279c3d 100644
> --- a/drivers/usb/gadget/udc/udc-xilinx.c
> +++ b/drivers/usb/gadget/udc/udc-xilinx.c
> @@ -1399,7 +1399,6 @@ static int xudc_start(struct usb_gadget *gadget,
>  /**
>   * xudc_stop - stops the device.
>   * @gadget: pointer to the usb gadget structure
> - * @driver: pointer to usb gadget driver structure
>   *
>   * Return: zero always
>   */
> --
> 2.25.0
>

Can someone take a look at this patch?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
