Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28807C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001882071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BuDYCVZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgC0U2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:28:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32776 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgC0U2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:28:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id m14so10015464oic.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NItgZTAZAbK7I7Yq0Kk66FkTCdXcM+5U1aVR69fwhR8=;
        b=BuDYCVZH5ikDIs4PQ1xr651kXz2OJtbIQiASaVtnRinjJOWO1WZ/WwLl9QoQVI2ddI
         BWgojf092/KzaC1Ixz3gCjEIN9CptyyIW94mGT9WXPf0pAPv/MvNXbTmlumq6qdpRBoF
         sLDiSPU1kpUU33mLFo9Ys/9H+9+E0bJStHZQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NItgZTAZAbK7I7Yq0Kk66FkTCdXcM+5U1aVR69fwhR8=;
        b=oeTqoV10qC/4tzS09MADMRnCJCxzAVpLslZshoWxwPmjBijiQclySr2u7Uwsp4fKOQ
         keKUQIokQ3vyfgyKV++j7mempjsDqgI7xfxQival6hR4ri8jTTW1nk1f17y+JBrQHtUH
         DLaw1c9qhBXFqgPbBGF/XfrGRUn/fOBejvEY/kEgDmrxoSzkk/OnY4dPGQz/jZ4Q0pu8
         9jyneZIRFEBluKyXsac1QwXBSpAJTiyTP+lB5FN+fudBFXyL/ODagWXCr9DACWDR3zFK
         k6NBI2/s6/LN9ewz/6fHzZPGaxr4MDzhIcecvT0kvnnHsAVjMiDb+VAPeGzfuD9GDmNY
         8vew==
X-Gm-Message-State: ANhLgQ2Y5YUlex2i4J7TSrNKmQMvNOLbN8noa8h1YFPes838kT/cyzWr
        DfffMoq+eso2pyAMEr8DFuKT9X1qXwuhsidX7D8tLb8=
X-Google-Smtp-Source: ADFU+vt7qTCu8JLz/NVAm+Eo6nFAYH0BJw9Zg7y5krM0ZVYsnUPD4Mur9fuILHw5hLM9VSekbJp6X6UQ4ZxGp4e5b5I=
X-Received: by 2002:aca:f183:: with SMTP id p125mr537461oih.74.1585340922401;
 Fri, 27 Mar 2020 13:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200313141545.31943-1-alcooperx@gmail.com> <20200313141545.31943-4-alcooperx@gmail.com>
 <20200317184851.GA1470797@kroah.com>
In-Reply-To: <20200317184851.GA1470797@kroah.com>
From:   Al Cooper <al.cooper@broadcom.com>
Date:   Fri, 27 Mar 2020 16:28:31 -0400
Message-ID: <CAGh=XAAKmrtg6LFwCOUY5uGx0kkfsgLGFn5PCdL9xbuT_G1AUw@mail.gmail.com>
Subject: Re: [PATCH 3/4] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 2:48 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 13, 2020 at 10:15:44AM -0400, Al Cooper wrote:
> > +static int __init ehci_brcm_init(void)
> > +{
> > +     if (usb_disabled())
> > +             return -ENODEV;
> > +
> > +     pr_info("%s: " BRCM_DRIVER_DESC "\n", brcm_hcd_name);
>
> Drivers should be quiet if all is good, no need for this line.

I removed this.
Thanks
Al

>
> thanks,
>
> greg k-h
