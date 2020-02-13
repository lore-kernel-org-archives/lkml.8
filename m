Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C70C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E3A222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDPTDEy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgBMN3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:29:04 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36765 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgBMN3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:29:04 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so4965045iln.3;
        Thu, 13 Feb 2020 05:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfE2W5LQkoH0UQl9XbqZm7z7YZPx+sJdXqj0cViMT9Y=;
        b=qDPTDEy3Wwk4R4THsiNOjtlrg7zGYl9R2KtnB0Vy98kGWf8Mhue5K04gGadiYjOhJA
         OECkjl7zgSyVTM5gbskiMbTETf+UpRizBu2GA90YYSh00wtnIubUwZNgzlLyxqv322Nt
         2O4mOsjv3IVl5zqbDSjloBWSQzh/bXytjQEREZD1k1BtwrCRwdKPHywgcR/kymjYz59I
         mB1xQVs4tye3cty8HbTxBWFkIilCgdhCURMlPWiJaeR6bR5PO3GCSLb2zqbTt5BJv3Dp
         +Ednjlh1F9uwLcHkarMO30YaCVIN2e+VuOjGcWVFhpclKZrMSP6uuyRaTcFcRftXeUCz
         BdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfE2W5LQkoH0UQl9XbqZm7z7YZPx+sJdXqj0cViMT9Y=;
        b=tRBtgux72wOdWQ1xpKox7kyk9mAWBzo8/izwxkRwcCoPtXRoc9m+/uyEPQlMoJQUWD
         qOlhW2u72qzU9xeUx7abYVMxpI4hYjQwwRUHOZKH3hNQf5PeR9GxwfKDyzhJRRhADSjq
         fj7i/9BSQrCkXlVcijnhB8q1YRDoyP0VR0uT6SmUmJplH0kkj+8PY2JPsJ3vnH1HT2gr
         as0P4DLnJmE9EiU0DBR6tCH+6l1C4gYkZfqfTtDXGLpxcNjf+2iwoDc2+WVgFDaV8zwB
         shXCDRwaRmvedrXfLoPQ+C7n7sulR+v0YHPJbyPjQVTmlSXQ61S3GFSiL8WoM4PX7Nzl
         pIiw==
X-Gm-Message-State: APjAAAVN3xWlbBAszULQOMgcJD0jdkjmzyJaxISgdHBOPO18U7VEEXYx
        w5vnHFp6n80CL50sTzw9njx5pxhh8ike7sYgx/A=
X-Google-Smtp-Source: APXvYqyZADe9aFJTPHWo+2m+qnyTFGMvRJstebqLC899Zq0rrvQgRDaG+VSSVPANdZD+NvJ4x3Rs9wqKM+CNDfEx+4Y=
X-Received: by 2002:a92:5d92:: with SMTP id e18mr15908939ilg.75.1581600543378;
 Thu, 13 Feb 2020 05:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20200212120237.1332-1-linux.amoon@gmail.com> <20200213101744.GA11087@kozik-lap>
In-Reply-To: <20200213101744.GA11087@kozik-lap>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 13 Feb 2020 18:58:51 +0530
Message-ID: <CANAwSgR+PFiE0=FEhDY__FDx+470pe0OsbUXcSG64JDuG++ccQ@mail.gmail.com>
Subject: Re: [PATCHv1 0/2] Add FSYS2 power domain for MMC driver
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Krzysztof,

On Thu, 13 Feb 2020 at 15:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Feb 12, 2020 at 12:02:35PM +0000, Anand Moon wrote:
> > This patches add the power domain for MMC driver,
> > but somehow the suspend/resume feature is broken
> > so any input on how to fix this.
>
> I think S2R was working on XU3-family after Marek's fixes, so you mean
> that these patches break it?
>
Yes I my testing mmc driver failed to come up after suspend.

But I see below in power domain, Just to confirm.
#  cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
CAM                             off-0
FSYS2                           on
    /devices/platform/soc/10010000.clock-controller/exynos5-subcmu.6.auto
 active
    /devices/platform/soc/12200000.mmc                  active
    /devices/platform/soc/12220000.mmc                  active

# powerdebug -d
FSYS2:
current_state: on
active_time: 29016991 ms
total_idle_time: 4037 ms
Idle States:
             State            Time
             S0               4037
Devices:
         /devices/platform/soc/10010000.clock-controller/exynos5-subcmu.6.auto
         /devices/platform/soc/12200000.mmc
         /devices/platform/soc/12220000.mmc

> Best regards,
> Krzysztof
>
>

-Anand

> >
> > Also on similar lines I tried to add power domain
> > FSYS for usb3 and usb2 nodes but this time
> > it failed to load the kernel, so how can I reslove
> > this issue.
> >
> > -Anand
> >
> > Anand Moon (2):
> >   ARM: dts: exynos: Add FSYS2 power domain to Exynos542x
> >   clk: samsung: exynos542x: Move FSYS2 subsystem clocks to its sub-CMU
> >
> >  arch/arm/boot/dts/exynos5420.dtsi    | 10 ++++++++++
> >  drivers/clk/samsung/clk-exynos5420.c | 24 +++++++++++++++++++++---
> >  2 files changed, 31 insertions(+), 3 deletions(-)
> >
> > --
> > 2.25.0
> >
