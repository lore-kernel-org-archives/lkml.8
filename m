Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4D0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E4E20709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="o245Zjj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHRV4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgHRV4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 17:56:39 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2F6C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:56:38 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id f12so11398401ils.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLY7DKEY5wW7mQXQ8oT/iCnE/ovDXCbzyVbqbcCsqrg=;
        b=o245Zjj9rVaHE17kBt0+ISQkbkR8B9Y4RqLLw8KMd3Oj/rpXV3dsGPkIzfl/PGnOyh
         JjeH8o28tlxyUfV0f9Dp3xOpzTMm6+G7+m+rmRHDyX51yVHKZsOjBYO0LYzblIEdkcsd
         u64SX9CWMMf93vL46Mye0L+gNb3jPcqkIBFsaGySdt7n0OHHi6kpLrekftbY/+WOip1I
         Z/cwafgW3xhQTmRRi5XeqYIbR73D5y26qV3ufJXoKi7aETBf9sHW+cpagXqBA+manizS
         c/xEVmZgo6zABLwoLWWKS68gyC84vHl3aVTXA1w7SGZjBtYQH+fB5JC882c3ZU9IToYT
         PRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLY7DKEY5wW7mQXQ8oT/iCnE/ovDXCbzyVbqbcCsqrg=;
        b=oj0iK/R68RIAfd8Xmsxw3ycGMNGJWJkt2hBp1o+7wq3TJaq2EhLRHeMroxrs6YbhF9
         /oATBPDzVs86sShGLdaVjNN4za1iB0cvQr5sivK2USiu0yflJB4VrUw4SMppET+KzBHP
         Ac9GHA4EHcgGbZEs4IN3eWuJQw+RyPeI5tWM+OjRHnBo94lkm/Ze2SpPoGmjGm0INOva
         l7NS+kB66RbEnyoYo6PEIncBkrG3wDZa6VOvTfw/kjRNUxvxa6a1d5ItZYkhZZ8nZVZD
         8PNBNXZfSgFEWoe94sNKiwIKA4MBukTrB4qhZoo91t8sY8tWw5oPRb+XF9TArcRpTW4C
         Frbg==
X-Gm-Message-State: AOAM533KdZ61Zv5utPGgAm/I5vuqinWlpHBWJ/FbYAFLcRjs6HDhbLRl
        o5JgkBa/6BYRTnzhxAYVO9qop8D1rOJAi1Zl6xZw
X-Google-Smtp-Source: ABdhPJz+t0uijQIrgkWnhHij+U7BRA+/bic5/ZM1A/Hs7Vp04xXMnYU5YB2mLmG/uezMT4PcjxLTTnZZNZXpr8kj//4=
X-Received: by 2002:a92:c50e:: with SMTP id r14mr7730786ilg.161.1597787798059;
 Tue, 18 Aug 2020 14:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200818124815.11029-1-vaishnav@beagleboard.org> <d53f0014-db7c-902c-70c7-eacac41cc6ed@gmail.com>
In-Reply-To: <d53f0014-db7c-902c-70c7-eacac41cc6ed@gmail.com>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Wed, 19 Aug 2020 03:26:27 +0530
Message-ID: <CALudOK5GaApck7jVZnLeuF=srBPVkw6GUkgZ4cYRX0oWHQXF7w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] mikroBUS driver for add-on boards
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        johan@kernel.org, elder@kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        robh@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
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

On Wed, Aug 19, 2020 at 2:08 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Vaishnav,
>
> +me +devicetree
>
> Please add these two recipients to future versions.
>
> I will comment more after reading the first version and v2.
>
> -Frank
>
Hi Frank,

Sorry, I missed to run get_maintainer.pl after making the changes
will add both recipients in future versions.

Thanks and Regards,
Vaishnav M A
>
> On 2020-08-18 07:48, Vaishnav M A wrote:
> > Hi,
> >
> > This Patch series is an update to the mikroBUS driver
> > RFC v1 Patch : https://lkml.org/lkml/2020/7/24/518 .
> > The mikrobus driver is updated to add mikrobus ports from device-tree
> > overlays, the debug interfaces for adding mikrobus ports through sysFS
> > is removed, and the driver considers the extended usage of mikrobus
> > port pins from their standard purposes.
> >
> > change log:
> >         v2: support for adding mikroBUS ports from DT overlays,
> >         remove debug sysFS interface for adding mikrobus ports,
> >         consider extended pin usage/deviations from mikrobus standard
> >         specifications,
> >         use greybus CPort protocol enum instead of new protcol enums
> >         Fix cases of wrong indendation, ignoring return values, freeing
> >         allocated resources in case of errors and other style suggestions
> >         in v1 review.
> >
> > Vaishnav M A (3):
> >   add mikrobus descriptors to greybus_manifest
> >   mikroBUS driver for add-on boards on mikrobus ports
> >   Add Device Tree Bindings for mikroBUS port
> >
> >  .../bindings/misc/linux,mikrobus.txt          |  81 ++
> >  MAINTAINERS                                   |   6 +
> >  drivers/misc/Kconfig                          |   1 +
> >  drivers/misc/Makefile                         |   1 +
> >  drivers/misc/mikrobus/Kconfig                 |  16 +
> >  drivers/misc/mikrobus/Makefile                |   7 +
> >  drivers/misc/mikrobus/mikrobus_core.c         | 692 ++++++++++++++++++
> >  drivers/misc/mikrobus/mikrobus_core.h         | 191 +++++
> >  drivers/misc/mikrobus/mikrobus_manifest.c     | 444 +++++++++++
> >  drivers/misc/mikrobus/mikrobus_manifest.h     |  21 +
> >  drivers/misc/mikrobus/mikrobus_port.c         | 171 +++++
> >  include/linux/greybus/greybus_manifest.h      |  47 ++
> >  12 files changed, 1678 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/linux,mikrobus.txt
> >  create mode 100644 drivers/misc/mikrobus/Kconfig
> >  create mode 100644 drivers/misc/mikrobus/Makefile
> >  create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
> >  create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
> >  create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
> >  create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h
> >  create mode 100644 drivers/misc/mikrobus/mikrobus_port.c
> >
>
