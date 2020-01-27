Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0B5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710F2214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="MeVeM4EY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgA0PaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:30:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43590 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0PaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:30:13 -0500
Received: by mail-io1-f67.google.com with SMTP id n21so10406142ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 07:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+HbYUDwgKuCOSy+aJjuhYF3MTJxsThpdJHanyjF4dI=;
        b=MeVeM4EYm20gMljITQy3vTouYPSfBaw/cGVF8xMGBCQ4+GtN6aZPZ4H8d/lQn4hi1/
         OQSy3DuTy0+CWMkk38KoEmIuURqqgcjI3LxCjkO8wbSZspDincoM69JfFXTIt9cXUCcA
         YW4OAwhSiXd0d25gVcJxuQj+6r/MMK+h+rv5G17UIXux2NO3b8lRoazCKYdN36ZhEo+8
         U/2RpceyAosWagi8zWLwQ+GkGoyNCPAD5hG0GCmhwooMYES1IpfgPBaYTXqxlvNqpH2r
         xVhEJU+gDNJeCD1A6Jx5asWcEWiHUhrC0yEQBXKvlqyxGm9Tjez/3G+6DfoxpBRzJ3qy
         LAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+HbYUDwgKuCOSy+aJjuhYF3MTJxsThpdJHanyjF4dI=;
        b=qPwqqZ5XumnclIN0srSyIOzEkv+LFbf7mkkB1UB03w8G9VI8HiBsBobjYuSLzwakC/
         VcQQhD1JBRdN7EDCPXT1J4SdyaHSFLkl3QPI0d7IZF5Y0Y6vUT2UrUBAfIv6L4bbQ3Ou
         usResZo0RM2yOTdp1WQ4DsVQbmI4v6SvQ531ahOFv98eLKlRpVIHHk5Hz/ixC1IxWREE
         +pFPuj8RSPBf+rrC8zNDvp8076ETbiaEQvrDnxOO1GnbhxX27aO2aKVF+BTPqlFpwR2N
         vqrnD11x+Z0S2eBTJhrAWWm+fT5azEkPam9+ImfA36RKIpKR4z8w+yziMIwR2mNXz3RN
         HaWA==
X-Gm-Message-State: APjAAAUmZV9dsZEAqYOzcqSMIV4y7YhLUECT4q9LoqTbUFNmlpsw0XJ/
        KAJiXgnr/mcl9iIyIVNU6ZLQBTXyeaRzGvDOKfSF0A==
X-Google-Smtp-Source: APXvYqyeTx481j8L0pBPzR4K6Eoy9fuMn2DYeKU7tHVSTxRPDNd6UROEotFeT6xos/dV5wVn0ql5tfPpBYj13Ua2n/I=
X-Received: by 2002:a05:6602:21c2:: with SMTP id c2mr12046135ioc.278.1580139012045;
 Mon, 27 Jan 2020 07:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20200124092359.12429-1-peter.ujfalusi@ti.com> <20200124200811.ytgs66cg5qpugi5c@localhost>
 <12f40648-fec6-9179-1f62-0a648996ed20@ti.com>
In-Reply-To: <12f40648-fec6-9179-1f62-0a648996ed20@ti.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 27 Jan 2020 07:30:01 -0800
Message-ID: <CAOesGMiFw2V6fdbGCOfgsVq+WK-4ijdzivDdX3hbS2E=bO4zkg@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable Texas Instruments UDMA driver
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 2:31 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> Hi Olof,
>
> On 24/01/2020 22.08, Olof Johansson wrote:
> > On Fri, Jan 24, 2020 at 11:23:59AM +0200, Peter Ujfalusi wrote:
> >> The UDMA driver is used on K3 platforms (am654 and j721e).
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >> Hi,
> >>
> >> The drivers for UDMA are already in linu-next and the DT patches are going to be
> >> also heading for 5.6.
> >> The only missing piece is to enable the drivers in defconfig so clients can use
> >> the DMA.
> >
> > Hi Peter,
> >
> > We normally like to see new options turned on after the driver/option has been
> > merged, so send this during or right after the merge window when that happens,
> > please.
>
> Sure, I'll post it later.

Great!

>
> > I also see that this is statically enabling this driver -- we try to keep as
> > many drivers as possible as modules to avoid the static kernel from growing too
> > large. Would that be a suitable approach here, or is the driver needed to reach
> > rootfs for further module loading?
>
> We would need built in DMA for nfs rootfs, SD/MMC has it's own buit-in
> ADMA. We do not have network drivers upstream as they depend on the DMA.

Ok, so that can either be turned into a ramdisk argument, or into a
"we really want to enable non-ramdisk rootfs boots on this hardware
because it's a common use case".

I find it useful to challenge most of the =y drivers to make people
think about it, and at some point we'll enough overhead of cruft in
the static superset kernel that defconfig today is used for such that
we need to prune more =y -> =m, but this particular driver is probably
OK (it's also not large).

> Imho module would be fine for the DMA stack, but neither ringacc or the
> UDMA driver can be built as module atm until the following patches got
> merged:
> https://lore.kernel.org/lkml/20200122104723.16955-1-peter.ujfalusi@ti.com/
> https://lore.kernel.org/lkml/20200122104031.15733-1-peter.ujfalusi@ti.com/
>
> I have the patches to add back module support, but waiting on these
> currently.

-Olof
