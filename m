Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273B0C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D8421D90
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIROAHaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgD2SMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726882AbgD2SMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:12:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C343CC03C1AE;
        Wed, 29 Apr 2020 11:12:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a7so1077042pju.2;
        Wed, 29 Apr 2020 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2iiF8eLYUS7geaeL51YFIwVieGq2CPRystA+8gQyAE=;
        b=HIROAHaFP2LYp7KDV0cJInDYForeR11I1pCH0XoEoi2GIRQlLDiE1yrWaoMpPY2shG
         kAHO1OQZwj7ON9G7cc+V3IIYNI2WKbqdGMz/bAHoBgg1S7slWPNwHxzo6/qX8CYeVPI6
         1WLhY4svLHUMqgtP/GQNXUx5TaTU92RAxcdbY6R+LiI0An4SYFnbIQ78hAxmzltLwx5D
         t3a5F63JdpMjJRVLvvEcb+k36V9C93GjCWnJ8CyDMpOr8kPvy3ysS2MOp8YeHgTGrzUo
         R3MYmqpmweFoo575fbEmZ6RdJ2uMC64XsOnw1G8ZpwXkw/djKYoZKJ+p7N4u06eqC9GF
         xmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2iiF8eLYUS7geaeL51YFIwVieGq2CPRystA+8gQyAE=;
        b=Lvi5uauice1xkn1HDk5U0cgeBK3SO+6/cTF8OGoZlysVspOZkRDEvg20ToZgNsuK7i
         fFAqNaLv3F2m4Sh52S7O+/VZ+e6bw/uSMYToTfb5sH8lpi76+kX2s23TJIvblj+8bXZR
         dxVV16ksTdpU6WhVP3i2ihohtttpYAdRkYMJPlQgq+JjjtOx5916VDy17na567LRZ0rV
         q7dWyD8YOh9VQJMR4Meoaf8QY4znHLnDRmkMc45/g0U2OxZzusCI+XSxbocdfkV9SGMv
         5m412/sSt2LGskJYVZGhTmFs/hRklR0YBJD6md+H3I+EGDVValb01ucO417FyliHLliK
         a2RQ==
X-Gm-Message-State: AGi0PuYk3Z0U/iNCc3xK2PXsOW64/vVxDF8R7NyG/tPh3gjWnen6movo
        w5rwsi5OUUvAQ2dqYrJ34f0+OwoK9K0zS87K588=
X-Google-Smtp-Source: APiQypL/o082CcCG7bO4nwva90iOUAOOXATVEA0CCq557uNHxakfsLVaGqefgmCsqIYKT8G43LBgay0mpntpr3vv8DY=
X-Received: by 2002:a17:902:7003:: with SMTP id y3mr9060348plk.18.1588183940336;
 Wed, 29 Apr 2020 11:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200429173112.38366-1-alcooperx@gmail.com>
In-Reply-To: <20200429173112.38366-1-alcooperx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Apr 2020 21:12:13 +0300
Message-ID: <CAHp75VcA4kRJcdMxNovSafh4_Tin5-gvemvq=-6McgaP+8je+g@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 8:33 PM Al Cooper <alcooperx@gmail.com> wrote:
>
> v4 - A few more fixes to the brcm,bcm7445-ehci.yaml dt-bindings
>      document requested by Rob Herring.
>    - Fixed ordering issue in MAINTAINERS as requested by
>      Andy Shevchenko.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(consider addressing couple of minor comments)

>
> v3 - Addressed all of Andy Shevchenko's review comments for
>      ehci-brcm.c.
>    - Fixed the brcm,bcm7445-ehci.yaml dt-bindings document,
>      dt_binding_check now passes.
>    - Added the XHCI functionality to xhci-plat.c instead of creating
>      new brcmstb files, as suggested by Mathias Nyman.
>
> v2 - Addressed Andy Shevchenko's review comments.
>    - Fixed dt_binding_check error pointed out by Rob Herring.
>    - Removed pr_info message in ehci_brcm_init as suggested by
>      Greg Kroah-Hartman.
>
>
> Al Cooper (4):
>   dt-bindings: Add Broadcom STB USB support
>   usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
>   usb: ehci: Add new EHCI driver for Broadcom STB SoC's
>   usb: host: Add ability to build new Broadcom STB USB drivers
>
>  .../bindings/usb/brcm,bcm7445-ehci.yaml       |  60 ++++
>  .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
>  MAINTAINERS                                   |   8 +
>  drivers/usb/host/Kconfig                      |  16 +
>  drivers/usb/host/Makefile                     |  16 +-
>  drivers/usb/host/ehci-brcm.c                  | 286 ++++++++++++++++++
>  drivers/usb/host/xhci-plat.c                  |  10 +
>  7 files changed, 391 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
>  create mode 100644 drivers/usb/host/ehci-brcm.c
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
