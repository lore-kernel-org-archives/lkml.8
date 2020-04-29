Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436C9C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235BA22201
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw9eS9hZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgD2SLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:11:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052DCC03C1AE;
        Wed, 29 Apr 2020 11:11:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so1466706pfc.0;
        Wed, 29 Apr 2020 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32iTtqxt7eYmJSkonzXigk+VsulRBCWrnlSfTREBeNo=;
        b=Lw9eS9hZl4dK37CHk5tVRw7uUhCKuSADlk5CRXEhminLpoMONDxAQixmerLC3pBvvZ
         FrfP3b82EU79rswwstsUDcMOADVZqNmdB9Zx8Xaer91E8fuLGQWXddNO4STLwyfNrMR0
         iPLRyVLGHtCgyh1ZhQ0bGz3eCN7f1NOiQy4IuUZNDp9IViHBAI1W3l0LR7bYNUVY/dwD
         CwhAbRi80WkMrUB3cimuC7TkvK1803k/9WQ9W0xsz8OqAtDkcXoA3IPEe3wKMOmRZ7NP
         27wMUy3IG63FwYI/56sG+ptMRat5NM28DLp9Nn9808D8hfDABRW70ZQHAeCq9wRDZ6fY
         xqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32iTtqxt7eYmJSkonzXigk+VsulRBCWrnlSfTREBeNo=;
        b=IH/++rmbvatHxZ/0KCI1drfvlzLo5Dn6XC7W/ZFbOpA6UNXBGaGctqxFAlcW/NdS+E
         odE8X2RQSQLqoFdNMOJu/dxfE2SkKaWFZtiXy8Z4Y0TrZZoSFtddqTfmBzn0SwTFeXnh
         RyR63TDHVXeQxFGt+jCp+e2EGkYXR9fr2PJqalK1QvaHXZ8hNGDsCwRKjNLvhv9Bo2ME
         NjrXfAg2nBB46YC779IdQDQuRFWRm7KAIlDsYGJm05yAzbwfXmpFEcsNM4Nl56riJHd1
         Ql9QyD5kfcHdqiGeK0IXIzAJFwRI1LJhnDURNL5ZbINQwxwJUz9BUOULuKXQGzCMcfaJ
         ua5w==
X-Gm-Message-State: AGi0PuZHXlZJ+j7KJnJXfX7157J5muqUnO5V/q+A6459h2NVLfj0wkZ9
        mV9rooimoq2kohgU1y8WUAUggjsFpDyDzgCsrYc=
X-Google-Smtp-Source: APiQypL6rg6zBqJKDlDtZabgKh8dNkv3z24vfaXNyZiW3GC67TZ/jVKXSp84ouzCZxuZ9+Z8KNTqntBii41GUJgnfIs=
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr37105646pfr.36.1588183873578;
 Wed, 29 Apr 2020 11:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200429173112.38366-1-alcooperx@gmail.com> <20200429173112.38366-4-alcooperx@gmail.com>
In-Reply-To: <20200429173112.38366-4-alcooperx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Apr 2020 21:11:06 +0300
Message-ID: <CAHp75VdwCBDTpipJZFOXxEvB4yW1qZo5XC5vs1pzHfTnVR+Nvw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
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

On Wed, Apr 29, 2020 at 8:34 PM Al Cooper <alcooperx@gmail.com> wrote:
>
> Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> was created instead of adding support to the existing ehci platform
> driver because of the code required to workaround bugs in the EHCI
> controller.

...

> +/* Copyright (c) 2018, Broadcom */

2020?

...

> +       res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       hcd->regs = devm_ioremap_resource(dev, res_mem);

devm_platform_get_and_ioremap_resource() ?

> +       if (IS_ERR(hcd->regs)) {
> +               err = PTR_ERR(hcd->regs);
> +               goto err_clk;
> +       }
> +       hcd->rsrc_start = res_mem->start;
> +       hcd->rsrc_len = resource_size(res_mem);

-- 
With Best Regards,
Andy Shevchenko
