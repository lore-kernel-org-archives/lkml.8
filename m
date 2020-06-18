Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096E3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB04D20734
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgFROKG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:10:06 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50847 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgFROJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:09:33 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B86FDC0007;
        Thu, 18 Jun 2020 14:09:27 +0000 (UTC)
Date:   Thu, 18 Jun 2020 16:09:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>,
        Allison Randal <allison@lohutok.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        kernelci-results@groups.io, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Enrico Weigelt <info@metux.net>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-next@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on
 ox820-cloudengines-pogoplug-series-3
Message-ID: <20200618160925.6f77b1d1@xps13>
In-Reply-To: <20200618152324.0b0007a9@xps13>
References: <5eeb5bf7.1c69fb81.4f6e3.8979@mx.google.com>
        <13497644-ae34-d5e3-e76a-742cddf0f0a9@collabora.com>
        <20200618152324.0b0007a9@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 18 Jun 2020
15:23:24 +0200:

> Hi Guillaume,
> 
> Guillaume Tucker <guillaume.tucker@collabora.com> wrote on Thu, 18 Jun
> 2020 13:28:05 +0100:
> 
> > Please see the bisection report below about a kernel panic.
> > 
> > Reports aren't automatically sent to the public while we're
> > trialing new bisection features on kernelci.org but this one
> > looks valid.
> > 
> > See the kernel Oops due to a NULL pointer followed by a panic:
> > 
> >   https://storage.kernelci.org/next/master/next-20200618/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/baseline-ox820-cloudengines-pogoplug-series-3.html#L504
> 
> Thanks for the report, I will not be able to manage it before Monday,
> but I'll try to take care of it early next week.

Actually Boris saw the issue, I just updated nand/next, it should be
part of tomorrow's linux-next. Could you please report if it fixes your
boot?

Thanks,
Miquèl
