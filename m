Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00374C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B9520733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxzfVtZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJK4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:56:11 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40229 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgBJK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:56:10 -0500
Received: by mail-il1-f193.google.com with SMTP id i7so5360085ilr.7;
        Mon, 10 Feb 2020 02:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2IBt4/L/Nkmzl5hW1D/wjWzKHtqUWjVQiav92+TxjY=;
        b=MxzfVtZRAKUIarDmqF9d8MtEWcqpjh3ZP6t4+CyS8iwJfg0VnRBEN5ecfTDSB/ifw5
         Oe347EZ7IjQ/Ttkp4C8larMqFO3D5OVo62hVxbh4VB3YtEOic4v59wV2OxqSTcuqaAVZ
         LSOuY+hEW35bByT0bXCtc6yvB+n7dHLJUDyaSyLv0aadoQKM8mWVpWgp+Cwa53vCsTUw
         XZrC/jqYPGVltNO292Ad157gdmd/UuL51Qh1NxLP0atu/cJMiPWTUjy57gsZ2DfsD10S
         NW92pC8NuZwhD0VTS3sLgeUes7Ghgp4jE+43B+Zy+lkj+fhmiFl44cZVQm9/58ycOa2K
         mYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2IBt4/L/Nkmzl5hW1D/wjWzKHtqUWjVQiav92+TxjY=;
        b=GWiI0lpy1NSXbVswL6dJOXyCDTxlSl10wsOAIbMU4C4Q1iP0xN8xAb4IYgU/4682jb
         +7Pv9YdSbELTQi2BtshQYKVXrzu1DZnXYr5FTRYwC7jm/L03+BPVuFSYsVEH2flOweHo
         834sJBB1/vAKRpi1jaHUTMqP6XJyTzXmwRqLbZH5zZ79NOhsJ8TTgp1cWed+ZH7SETLG
         ZHc+2DnZw7amC47Mtz6tHnl+ugos2eRgsSBwYMwA5zLaCMFYuuRfmtYlMgwM3HmvEPo2
         e7cLd+Dq2F6xnrf7hLuC7Khbi2C+ezvBMJudUvg5L59yvCy3POevkGSpUviGeGorJDdU
         zXLw==
X-Gm-Message-State: APjAAAW39qINGrEF8dtQ6v+uQCrkdT/G96hzcvFi/2iUtXVLWCJw5j6a
        kuvEJtv+7yVe+PdgClDb/Waxtikhbd9nAoEMkK105Q==
X-Google-Smtp-Source: APXvYqzSD3AIuSazFlh5pPF5er+MSkw4OA9zMqA91tlC+bDSAj88WNPxzkmfnD9iDxhN7ozPY0QwiaRGDUDo1oQbwSw=
X-Received: by 2002:a92:5d92:: with SMTP id e18mr761070ilg.75.1581332169369;
 Mon, 10 Feb 2020 02:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20200210105108.1128-1-linux.amoon@gmail.com>
In-Reply-To: <20200210105108.1128-1-linux.amoon@gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 10 Feb 2020 16:26:01 +0530
Message-ID: <CANAwSgQzwRJE9mK+RwuCjsMaBMmD1f3fx+g-23B5Opo19kywUw@mail.gmail.com>
Subject: Re: [PATCHv3 0/3] Add support for suspend clk for Exynos5422 SoC
To:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry typo this patch series should be PATCHv1 and not PATCHv3

-Anand

On Mon, 10 Feb 2020 at 16:21, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Long time ago I tried to add suspend clk for dwc3 phy
> which was wrong appoch, see below.
>
> [0] https://lore.kernel.org/patchwork/patch/837635/
> [1] https://lore.kernel.org/patchwork/patch/837636/
>
> This patch series tries to enable suspend clk using
> exynos dwc3 driver, for this I have added new
> compatible string "samsung,exynos5420-dwusb3"
> so that we could add new suspend clk in addition
> to the core clk. exynos dwc3 driver will help
> enable/disable these clk.
>
> -Anand
>
> Anand Moon (3):
>   devicetree: bindings: exynos: Add new compatible for Exynos5420 dwc3
>     clocks support
>   ARM: dts: exynos: Add missing usbdrd3 suspend clk
>   usb: dwc3: exynos: Add support for Exynos5422 suspend clk
>
>  Documentation/devicetree/bindings/usb/exynos-usb.txt | 4 +++-
>  arch/arm/boot/dts/exynos5420.dtsi                    | 8 ++++----
>  arch/arm/boot/dts/exynos54xx.dtsi                    | 4 ++--
>  drivers/usb/dwc3/dwc3-exynos.c                       | 9 +++++++++
>  4 files changed, 18 insertions(+), 7 deletions(-)
>
> --
> 2.25.0
>
