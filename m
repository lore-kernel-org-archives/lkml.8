Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E023EC8300A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DDD2137B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwlAAJ9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgD2MMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgD2MMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:12:38 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565D0C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:12:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b2so2356388ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vmsu/fwPs4oBXZNMxWYLe7MCK2oXBROz7k2oW8iuVU=;
        b=zwlAAJ9nJlMD2a5IChrfCW2OFWh0NNBeo2TJZRkCy2uyh37eWiMVFQ72IPC7DcpMxx
         fQRcjYZJ5JKxaU8fs/knzvbTgYG0HoF02FuSesWF09CKEwzf14V+pyXM5eCxyLv3anxY
         crZSju5V3kzYc0GRbRYi1qiyuQsAWQzWRlTo34hgoCWWxVhBrUFMRVcKHsuapJABo4T4
         xIZ2EeNzKCB6GucCqqcPeNVhHwtCx8SA93ToNo19jWk/BnOmKuwq/sw2FBlvsQNcZASw
         O5IK8Ldupd2KxPbf8XLp7bV72eGzyjxKqRPaSuN/8adAJuqQj6KEb3bs31YGhRgRgZx+
         tfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vmsu/fwPs4oBXZNMxWYLe7MCK2oXBROz7k2oW8iuVU=;
        b=QaEVWrWZkaiy1xayQY7eT/HfcLViMpmPVr/G2emEIrtwhM0gwKtZOvGovCnwqU7wel
         BeXFRV7MyfDZwgzRIFFIMxnKCypJa2iy9k/rFTPVcqytjje1p9X2Brz1HX6CrKkdCjE/
         SB9VcU1Zp4KzrmJPNgpdhx7d1mJqQadqtSZfCE+X6x0SSEmvp/rvBiD9b4/XzjF1TKh6
         5w/WOS56Nb1NQifcBhIo7AuM6H/jwszOq8FC9ymgW3E4eF40VlDTvrcnwwZLODk8jwEu
         kNEvr6M4YDluA+ZTKRnU5v9zw0bAmShlFEE3zBTN40gFG/0HHwQHZgq9KOEC0lbgt8oQ
         0dLg==
X-Gm-Message-State: AGi0PubZY0ZJ/R3SftquT/U55aeW57Kt0Ad12HGXmSPRhd3DPEJwVA04
        dNMHFksaNLSCYz2my5zT0qiPS9WzILvJXxBnDcUd9A==
X-Google-Smtp-Source: APiQypJadb433yUV+3CvSyHkcenoW49EI2HbqVsg3NYeo//Kqhy39vGkteTUQQYPvvWVEtHeYRVPW0nafRpsIBBtHdU=
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr20911578ljp.277.1588162356793;
 Wed, 29 Apr 2020 05:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200428195651.6793-1-mani@kernel.org> <20200428195651.6793-3-mani@kernel.org>
In-Reply-To: <20200428195651.6793-3-mani@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Apr 2020 14:12:24 +0200
Message-ID: <CACRpkdZ3b-VLvxN06H_4cDOtUEQTVbe=Zw+NA=YjssMzK2d2sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: serial: xr_serial: Add gpiochip support
To:     mani@kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patong.mxl@gmail.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 9:57 PM <mani@kernel.org> wrote:

> From: Manivannan Sadhasivam <mani@kernel.org>
>
> Add gpiochip support for Maxlinear/Exar USB to serial converter
> for controlling the available gpios.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>

That's a nice and clean GPIO driver.

I would change this:

   port_priv->gc.label = "xr_gpios";

to something that is device-unique, like "xr-gpios-<serial number>"
which makes it easy to locate the GPIOs on a specific serial converter
for lab use. However the USB serial maintainers know better what
to use here. Whatever makes a USB-to-serial unique from a TTY
point of view is probably fine with me too.

My idea is that people might want to know which USB cable
this is sitting on, so I have this USB cable and from this label
I can always figure out which GPIO device it is.

Either way, it is not a super-big issue so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Is this a off-the-shelf product that can be bought or is it mainly
integrated on boards?

I'm asking because I'm looking for a neat USB-to-serial adapter
with some GPIOs (2 is enough) that can be used for reset and
power cycling of lab boards using one simple piece of equipment.

Yours,
Linus Walleij
