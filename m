Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F25C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BDE207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgELHE4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:04:56 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41485 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgELHE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:04:56 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3431524000A;
        Tue, 12 May 2020 07:04:52 +0000 (UTC)
Date:   Tue, 12 May 2020 09:04:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: Re: linux-next: build failure after merge of the nand tree
Message-ID: <20200512090450.499421bd@xps13>
In-Reply-To: <20200512140840.0e102581@canb.auug.org.au>
References: <20200512140840.0e102581@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Rothwell <sfr@canb.auug.org.au> wrote on Tue, 12 May 2020
14:08:40 +1000:

> Hi all,
> 
> After merging the nand tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/mtd/nand/raw/stm32_fmc2_nand.c: In function 'stm32_fmc2_nfc_write_data':
> drivers/mtd/nand/raw/stm32_fmc2_nand.c:1294:34: error: 'fmc2' undeclared (first use in this function)
>  1294 |   stm32_fmc2_nfc_set_buswidth_16(fmc2, true);
>       |                                  ^~~~
> drivers/mtd/nand/raw/stm32_fmc2_nand.c:1294:34: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   6c1c863ca431 ("mtd: rawnand: stm32_fmc2: cleanup")
> 
> I have used the nand tree from next-20200511 for today.
> 

Thanks for the notice, we will fix it by tomorrow.


Thanks,
Miquèl
