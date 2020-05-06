Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE60EC47259
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D3C20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgEFH0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:26:49 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:34449 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgEFH0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:26:49 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49H7Sj70s3z1rx7x;
        Wed,  6 May 2020 09:26:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49H7Sj52Hxz1qqkL;
        Wed,  6 May 2020 09:26:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id LgHs-hPbv2Fl; Wed,  6 May 2020 09:26:44 +0200 (CEST)
X-Auth-Info: 2z9cDoItip41685WZkAmKeL5Dft+6xIYW+Pc0QNYXAd0dhdAMI46HXdeyiZo6LBw
Received: from igel.home (ppp-46-244-183-249.dynamic.mnet-online.de [46.244.183.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  6 May 2020 09:26:44 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 1B3342C0D4E; Wed,  6 May 2020 09:26:44 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "richard@nod.at" <richard@nod.at>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/2] riscv: defconfig: enable spi nor on Hifive
 Unleashed A00 board.
References: <BN8PR13MB2611968A7252308925FF18B399A70@BN8PR13MB2611.namprd13.prod.outlook.com>
        <mhng-29e22ca7-538a-4094-923f-8fbc0fd327b9@palmerdabbelt-glaptop1>
        <BYAPR13MB2614FE811C8DD83BBDD3A26599A40@BYAPR13MB2614.namprd13.prod.outlook.com>
        <CAAhSdy2-ECrOP=kZOTXxj1t+f8NrcYjbXKDRwPB3KU36mDmWWg@mail.gmail.com>
X-Yow:  I feel like I'm in a Toilet Bowl with a thumbtack in my forehead!!
Date:   Wed, 06 May 2020 09:26:44 +0200
In-Reply-To: <CAAhSdy2-ECrOP=kZOTXxj1t+f8NrcYjbXKDRwPB3KU36mDmWWg@mail.gmail.com>
        (Anup Patel's message of "Wed, 6 May 2020 10:39:39 +0530")
Message-ID: <87d07h8qx7.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 06 2020, Anup Patel wrote:

> We had build issues in past by selecting major driver subsystems
> in Kconfig.socs
>
> I suggest to select SPI_SIFIVE from Kconfig.socs

SPI_SIFIVE can be m, don't override that.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
