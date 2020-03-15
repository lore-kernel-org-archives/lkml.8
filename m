Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE51C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E20206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp92DRfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgCOJZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:25:31 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43712 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgCOJZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:25:30 -0400
Received: by mail-il1-f195.google.com with SMTP id d14so12956503ilq.10;
        Sun, 15 Mar 2020 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDLn6hcaUGXN1ifnm89fP3KORlDlYvpz0bkA0oBIYGM=;
        b=Vp92DRfDmGLIM/NPFDj32KHbGd5+v54Y8Qx53JAOAD18STaqvCL7NqF8E/KfcDTr1N
         RTh37uMH8CGBwXi7s3YU7A9AqUdrD6fmecuUReY3uJ5yex7vhm+o2hnTXMKjuFBsXo8J
         FRimVp9eYRS/Og97n7VrlGVV9giH2n3V/9MUXWgW6I3wwjkOIFXXfG78J9tNal3iQrA3
         gO1CPPERPk/E+tzgHAp8X6rm6y76Q8xQ5fK5NSKoqHMy3CoWgMdhVBy0f55UMQT2l9Yo
         PjFoGSXUOecROOqHn58hc8Ztnv48FZYFeTL64uCDFp58FTA2TSs3iokQUVSnB3mnnWY+
         nyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDLn6hcaUGXN1ifnm89fP3KORlDlYvpz0bkA0oBIYGM=;
        b=JzzcXQjSt1PiPSI277ANzrOxaWzBw8yXSgve7kyUdTFlXWUXO/+OAJvzlZmGkuxHHQ
         ibSsqUYObdJYFpsPshMn5OFjqbYaWYLdr6T6KsTre++kN9OkDsKoH2U05lkP62z1PjBk
         jqTtV88GU8chciFlXcqjaminV1rDIgglzut0+fxV9jCzEyi1XOyFJzL7ZMEjkMx8YEFh
         4Ym6Pqs7FtO6h9gVSg/QHpagYE6hjeAA2FBZs1x6sTSdzKne5Qeq9f6CsCWpub8KFIbI
         K02rz5lCAcfXGDzHybJXF6AjeWZoVu1c0TjYzCAs7NMkAa6+QfzdfnRFMBVPJhzIKn7Y
         ia+w==
X-Gm-Message-State: ANhLgQ2zJ5ujUn//8LzGY7Hs4R1Add0w68Q68f4kX0tP49vsvCby03qT
        Q4qfoyn5s39SosV6h30FOiRoLdTrDoap0xipwBQ=
X-Google-Smtp-Source: ADFU+vu2O/lxp6WbokN0oJhMae6LPLe+vhCCs071Xl1gPKo6khFDdWen7oB+9dJAe4A09kgfcbJwwxr26vMrqKvBJwk=
X-Received: by 2002:a92:d843:: with SMTP id h3mr8319415ilq.246.1584264329583;
 Sun, 15 Mar 2020 02:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200310194854.831-1-linux.amoon@gmail.com> <20200310194854.831-2-linux.amoon@gmail.com>
 <87lfo2f0k9.fsf@kernel.org>
In-Reply-To: <87lfo2f0k9.fsf@kernel.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 15 Mar 2020 14:55:19 +0530
Message-ID: <CANAwSgQgLm623szgs5Lba-NQKySiGw5fRfjyxjfdfHxQxhri7g@mail.gmail.com>
Subject: Re: [PATCHv3 1/5] devicetree: bindings: exynos: Add new compatible
 for Exynos5420 dwc3 clocks support
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Sun, 15 Mar 2020 at 14:37, Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > Add the new compatible string for Exynos5422 DWC3 to support
> > enable/disable of core and suspend clk by DWC3 driver.
> > Also updated the clock names for compatible samsung,exynos5420-dwusb3.
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> What is the dependency here?
>
> checking file Documentation/devicetree/bindings/usb/exynos-usb.txt
> Hunk #2 FAILED at 84.
> 1 out of 2 hunks FAILED
>
> Applying on top of v5.6-rc5
>
> --
> balbi

These patch were made on top linux next-20200306,
And with new updates in the clk driver configuration.
I will update these patchs later, plz drop these changes for now.

-Anand
