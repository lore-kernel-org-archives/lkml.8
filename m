Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB8B206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwJNOUDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389192AbgEYJAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgEYJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:00:12 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4CEC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:00:11 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c12so10093348lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVbZ6tYIp/xVUyUP6VrSfGOnDOAgEBsy3lxuX9EX3i8=;
        b=PwJNOUDMK950t1PfuawMkGO980h5X3fnR2kVKzF+h78exsLmBgyUZTDgfjkuJtNJIo
         6CGui7qiJcCmRiDdMK8o4Z9KkdHcwbHjL7QqxUebvOgZbJZN7nzizdG9YQULLSQ8woe6
         ruSUemnmuVFo1q01gnwjPxrBceAsMAOD2BKTgupqL0yFtR3FOjCvsuoJtyv5mYva5aVw
         nGM0RzfqGAUIJZsBOvZ9dgiRA3HwLCtsR8lsp8LSiQqeLstZ2F35Tln1e1qRW/ZtRPBD
         PJifdjeIxULrERGEzuNRt+cEmOtf47JF3XmjIJI+0E4L5DcIDQCHeBZADLoRMFTjGYYD
         ktOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVbZ6tYIp/xVUyUP6VrSfGOnDOAgEBsy3lxuX9EX3i8=;
        b=Bj6Xsii0iZH8qyoC0nJ2msrLibtsp9F4G9SBE2ADvU/CXWvCs/OBBy911mH8SjAic9
         153kLceKesU3yxMTsa21jSpHqZe46QksGrZEMtv4V2J5nnH/CZoKg+OEdcenNg6enyEf
         n9Fa28tPnPt3svw9UfZMPYaa270KKCO5fyVrbL1WGFwWxLXiKsBhGfAOsKMgYGIy0K/q
         BFCU2NmUA7FqXj2oMh+AzHaujrbLQukjcwjE5UM4fPB95B+uAZYffDPjKlAulaPykHhy
         EJqgkvN+9F452lv2LJpedsP32mD5YhGYKsYWh0SR/AKc7TfZD8LmhTiTtGkD/yP64PYQ
         XH2Q==
X-Gm-Message-State: AOAM530z5ZJXXjYWi1Gcpn2vjZt6nEYfDvikZpim9iGQZhiRnGxe/dbU
        D/K8RX9PXUwK9IHsP46YIjG9dsG/CO+ZPRqiarp2Mw==
X-Google-Smtp-Source: ABdhPJz2MDg67phcWCgGRBiLChLazpbn+5pVTJlj3rgm6su0EUVsdTIKubrpCsJfhSdKOoK4q+eTkg8CxvrbUPGzl10=
X-Received: by 2002:ac2:5cd1:: with SMTP id f17mr13019250lfq.4.1590397210185;
 Mon, 25 May 2020 02:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200428195651.6793-1-mani@kernel.org> <20200428195651.6793-3-mani@kernel.org>
 <CACRpkdZ3b-VLvxN06H_4cDOtUEQTVbe=Zw+NA=YjssMzK2d2sQ@mail.gmail.com>
 <20200429124918.GC6443@Mani-XPS-13-9360> <20200519085703.GB27787@localhost>
In-Reply-To: <20200519085703.GB27787@localhost>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 10:59:59 +0200
Message-ID: <CACRpkdapMuMs_mEUHheGtaKYg97=nL1bH3zq4Tc3cnX9Jbw-Ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: serial: xr_serial: Add gpiochip support
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
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

On Tue, May 19, 2020 at 10:57 AM Johan Hovold <johan@kernel.org> wrote:
> > On Wed, Apr 29, 2020 at 02:12:24PM +0200, Linus Walleij wrote:

> > > to something that is device-unique, like "xr-gpios-<serial number>"
> > > which makes it easy to locate the GPIOs on a specific serial converter
> > > for lab use. However the USB serial maintainers know better what
> > > to use here. Whatever makes a USB-to-serial unique from a TTY
> > > point of view is probably fine with me too.
> > >
> > > My idea is that people might want to know which USB cable
> > > this is sitting on, so I have this USB cable and from this label
> > > I can always figure out which GPIO device it is.
>
> I think we've had this discussion before. First, not every device has a
> unique serial number. Second, we already have a universal way of
> distinguishing devices namely by using the bus topology. That's
> available through sysfs and shouldn't have to be be re-encoded by every
> driver in the gpiochip name.

I remember I even referred to this myself, but I've been waning a bit
on it recently, because it turns out that userspace/users aren't very
good at parsing sysfs for topology.

For userspace other than udev there seems to be a kind of agreement
gap. Dunno how best to bridge it though. Education maybe.

Yours,
Linus Walleij
