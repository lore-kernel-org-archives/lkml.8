Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43580C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B41120709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="0bhENrTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHRVxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgHRVxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 17:53:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCC1C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:53:00 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t13so18940610ile.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+eND3yUn7afYyyUX+ZOLNk8wIrEfdj82iS2j0XFFq0=;
        b=0bhENrTR9TrSFAtLMEnlmOxvRDyoUzHRcavRD+sPcB/2RchhxjMr5TiCMqMaKLCdPJ
         OeC7YF9Qwd9vWoxGQygSp+e82lOQOrsLnHplYkZV2mIJ17G3GqR+pV7j04BiOXZAfZFm
         13qjnvWj0KfIyd4Ql4Zg5GbzYnhvWM9ZvcPhbWh1BaQUDk6IxKCFMFODwz1GlHTZ9h43
         hd341+nSJWwotTvWwVyP2Ym1BS6HvqdGQm+E2RE5Sa3hmqFA4hW9hjgY41WKCNqwmHmU
         3o9lJUoOXhGPoisbsy14XzY1IQHzhFnTPB1LCgxiKA7vl1lLANEm3tokEQAGL3Q6h/DP
         gcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+eND3yUn7afYyyUX+ZOLNk8wIrEfdj82iS2j0XFFq0=;
        b=I0mm7Trnuna6pf1n5QwbDqBVSjRIO9v5F+JQ+kuQTxZxYTzlT0j27qEdu/8fldbeoB
         zjQq6EtAKNdZyJOfhXzZ/DocyJJxAeSLh6+aSf2OFEcWuJTxQ/DI04Sh6RFlAMgal2PQ
         hd8PU0VzyWua6ZmfTcBJaS/jzjtWa262PtaLnuR1pQoEZsLic8GiIJetIEV14hFwqbmd
         eicojahUbAnIWXqQXYbG6JVhgytoAVBF4zG46c82ezNGlc6IbcqaMHOhdjJD53tKaRMz
         eZEP+IrGtNvTyxmgONV5QTks3E+mG01g+On2abCtzBT/hQEbB6ipTVkdcrQw/cvpnBwM
         ep1Q==
X-Gm-Message-State: AOAM530mgwZkIGl4/6T8PUCJFLVvvEGIOzMPwKCnpdCMG0H5jzJ7S9Bh
        NQtesUuE96E/cLvjtW17VFZpghAqstysUoUihmpTiJeCyR1w
X-Google-Smtp-Source: ABdhPJxLjWSNd7ynfl1wvpKbJ3WBA4UNitdVRIp3M1T7zGJJdKR2f+uQeJOcY3J32rROZjl8LKN8lBYVvmvS91peslo=
X-Received: by 2002:a92:9955:: with SMTP id p82mr19435772ili.186.1597787579879;
 Tue, 18 Aug 2020 14:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200818124815.11029-1-vaishnav@beagleboard.org> <20200818152426.GA713928@kroah.com>
In-Reply-To: <20200818152426.GA713928@kroah.com>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Wed, 19 Aug 2020 03:22:48 +0530
Message-ID: <CALudOK4jgtJiB8sn4CsDm2c=va=d8M7ocoa55f=NV9sTaBHJJg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] mikroBUS driver for add-on boards
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, johan@kernel.org, elder@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 8:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 18, 2020 at 06:18:12PM +0530, Vaishnav M A wrote:
> > Hi,
> >
> > This Patch series is an update to the mikroBUS driver
> > RFC v1 Patch : https://lkml.org/lkml/2020/7/24/518 .
>
> Please use lore.kernel.org for links, we have no idea if lkml.org will
> be working tomorrow or not :)
>
Hi Greg,

Thanks, will use lore.kernel.org for the links, attaching the corresponding
link to the v1 RFC patch thread for reference:
https://lore.kernel.org/lkml/20200724120637.GA427284@vaishnav-VirtualBox/

> > The mikrobus driver is updated to add mikrobus ports from device-tree
> > overlays, the debug interfaces for adding mikrobus ports through sysFS
> > is removed, and the driver considers the extended usage of mikrobus
> > port pins from their standard purposes.
>
> I don't know what "properties" and "device" mean with regards to things
> here, any chance you can provide a patch to the greybus spec itself that
> adds this information so we can better understand the reasoning here to
> see if the kernel changes match up with the goals?
>
> thanks,
>
> greg k-h
Sure, I will add a patch to the greybus-spec to describe the new descriptors,
the property and device descriptors are introduced to add information
about the SPI/I2C/UART chip/sensor which is required by the corresponding
device drivers, With these descriptors, it will be possible to describe devices
on I2C, SPI, UART, etc. behind a greybus device so as to bind existing kernel
drivers to them, This is not what is currently being done within the mikroBUS
driver, now it tries to instantiate devices on actual I2C, SPI, UART from
describing manifests, but the ultimate goal is to describe the devices on
I2C/SPI/UART behind a greybus device, thus enabling to attach existing
kernel drivers to devices present in add-on boards attached to mikroBUS
ports added via greybus.

Shall I submit a pull request to https://github.com/projectara/greybus-spec
for the specs, is there a different official upstream to greybus-spec?

Thanks and Regards,
Vaishnav M A
