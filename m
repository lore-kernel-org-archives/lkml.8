Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DB3C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBD02071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NRA7NIyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgC0UZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:25:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40824 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgC0UZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:25:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id r19so5310617otn.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akWa2ipvxDdFjzHuT26VN2IdHpNjEh3op9l8PYfCVA0=;
        b=NRA7NIyKs9dvbrJdb5I0eFsmvwBuuz3f4W7KGO5Y6YsRY/dAZH+qXFQC1B/HIO8q90
         Di99YhMlahViPssUjztq+3fKqXSiF5fbgKk+mOGT+o3FPZy1dk7n4dYfdnWMzt33uDxD
         xxUKAC5cU66mNQjvtGbkHpDCaqZD7FA8potYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akWa2ipvxDdFjzHuT26VN2IdHpNjEh3op9l8PYfCVA0=;
        b=YounGtBMVUYhHGqhyn03JPyMOMWrk2G3OU/mC427y9zNvc1OgSNISrGo0DCDh4qEL8
         g0IhC+udPuAvksMotdcDIHjdg7uj7XECbaR0lM/DE0hIAdAH1LZqibWXkgBe0zzVgJFX
         987mdAiNniZS//YcyMq/MTBqA7I/j9U99wdLNd+hKldNqVqJDT6LsLToS2x2lzWBVMjd
         L9DDBn7Qiay9MO7EeJQOyLzVxeBHL+gtzjl4ewwTS/NZVtB4CiyfqONGce26P8b0BEy3
         F9TJ/OwoZj8rCQdOLQfKUoai8rQz1xQKp0f4ueGhPq0X4+RX6kLviCUXdjiLIPdvdR//
         2fqg==
X-Gm-Message-State: ANhLgQ0A7xjFzNlAvDLMklXAfkh0UK4/jktS8fe3tBiU6nAeNVp2WBC1
        GDeR4t1Vb0LUKzw61Lx/KcxMC5E7ugFRsarIfAJo
X-Google-Smtp-Source: ADFU+vtEIPmG+pfkHCSu82SSE3geeF9tI5kApWkuTOGuNqdr4Sq82a3K7dRYtvTWJOz2KWUcNK/35wGwBVO+Z9Sv9Ak=
X-Received: by 2002:a05:6820:122:: with SMTP id i2mr1003546ood.73.1585340720551;
 Fri, 27 Mar 2020 13:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200313141545.31943-1-alcooperx@gmail.com> <20200313141545.31943-2-alcooperx@gmail.com>
 <20200313220202.GA23539@bogus>
In-Reply-To: <20200313220202.GA23539@bogus>
From:   Al Cooper <al.cooper@broadcom.com>
Date:   Fri, 27 Mar 2020 16:25:09 -0400
Message-ID: <CAGh=XADV-wp_vggA=3Nf8wGdABvgkhVzpMjFg4XcdOukRoC6TA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add Broadcom STB USB support
To:     Rob Herring <robh@kernel.org>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 6:02 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 13 Mar 2020 10:15:42 -0400, Al Cooper wrote:
> > Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.
> >
> > NOTE: The OHCI driver is not included because it uses the generic
> >       platform driver.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  .../bindings/usb/brcm,bcm7445-ehci.yaml       | 60 +++++++++++++++++++
> >  .../devicetree/bindings/usb/usb-xhci.txt      |  1 +
> >  2 files changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Error: Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.example.dts:24.13-14 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1262: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1254417
> Please check and re-submit.

I fixed this.
Thanks
