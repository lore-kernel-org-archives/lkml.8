Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9C3C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F373F2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgBNPSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:18:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:54230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgBNPSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:18:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3CB97AF57;
        Fri, 14 Feb 2020 15:18:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <8bd7a25a-359d-5b30-4c95-004032d78cb6@samsung.com>
Date:   Fri, 14 Feb 2020 16:14:23 +0100
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Stefan Wahren" <stefan.wahren@i2se.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: bcm2835_defconfig: add minimal support for
 Raspberry Pi4
Message-Id: <C0LZGU1IU7QO.9VKWHWJ56XZV@vian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 14, 2020 at 1:25 PM, Marek Szyprowski wrote:
> Hi Stefan,
>
> On 13.02.2020 10:59, Stefan Wahren wrote:
> > On 13.02.20 08:35, Marek Szyprowski wrote:
> >> On 12.02.2020 19:31, Nicolas Saenz Julienne wrote:
> >>> On Wed, 2020-02-12 at 11:20 +0100, Marek Szyprowski wrote:
> >>>> Add drivers for the minimal set of devices needed to boot Raspberry =
Pi4
> >>>> board.
> >>>>
> >>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> Just so you know, the amount of support on the RPi4 you might be able=
 to get
> >>> updating bcm2835_defconfig's config is very limited. Only 1GB of ram =
and no
> >>> PCIe (so no USBs).
> >> Yes, I know. A lots of core features is missing: SMP, HIGHMEM, LPAE, P=
CI
> >> and so on, but having a possibility to boot RPi4 with this defconfig
> >> increases the test coverage.
> > in case you want to increase test coverage, we better enable all
> > Raspberry Pi 4 relevant hardware parts (hwrng, thermal, PCI ...). This
> > is what we did for older Pi boards.
>
> Okay, I will add thermal in v2. HWRNG is already selected as module.
> Enabling PCI without LPAE makes no sense as the driver won't be able to
> initialize properly.

Agree on this.

> > SMP, HIGHMEM, LPAE are different and shouldn't be enabled in
> > bcm2835_defconfig from my PoV.
>
> Maybe it would make sense to also add bcm2711_defconfig or
> bcm2835_lpae_defconfig?

IMO bcm2711_defconfig if the last resort solution. I don't think you can
do bcm2835_lpae_defconfig as RPi and RPi2 SoCs don't support LPAE. An
intemediate solution is being discussed here:
https://lkml.org/lkml/2020/1/10/694

Regards,
Nicolas
