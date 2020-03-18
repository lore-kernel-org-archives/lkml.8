Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DFEC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53ED220753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCRIfS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:35:18 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:36533 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCRIfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:35:17 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9E04A24000C;
        Wed, 18 Mar 2020 08:35:12 +0000 (UTC)
Date:   Wed, 18 Mar 2020 09:35:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4 0/2] mtd: spinand: toshiba: Support for new Kioxia
 Serial NAND
Message-ID: <20200318093511.4213c6a2@xps13>
In-Reply-To: <42e02e2c-ee61-1b0d-5d8e-3a512c042151@kioxia.com>
References: <cover.1583834323.git.ytc-mb-yfuruyama7@kioxia.com>
        <20200311165011.63a3d82e@xps13>
        <42e02e2c-ee61-1b0d-5d8e-3a512c042151@kioxia.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshio,

Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Wed, 18 Mar
2020 14:40:47 +0900:

> On 2020/03/12 0:50, Miquel Raynal wrote:
> > Hi Yoshio,
> >
> > Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Wed, 11 Mar
> > 2020 10:47:04 +0900:
> >  
> >> First patch is to rename function name becase of add new device.
> >> Second patch is to supprot for new device.
> >>
> >> Yoshio Furuyama (2):
> >>    mtd: spinand: toshiba: Rename function name to change suffix and
> >>      prefix (8Gbit)
> >>    mtd: spinand: toshiba: Support for new Kioxia Serial NAND
> >>
> >>   drivers/mtd/nand/spi/toshiba.c | 173 +++++++++++++++++++++++++++++++----------
> >>   1 file changed, 130 insertions(+), 43 deletions(-)
> >>  
> > I am very sorry but actually I had issues applying all your patches not
> > because they were not based on v5.6-rc1, but because since then I
> > applied a patch changing the detection that changed the content of a
> > lot of structures (including in Toshiba's driver).
> >
> > Can you please rebase again on top of the current nand/next? I am very
> > sorry for this extra work, this is my mistake.  
> 
> Thanks comment.         I will revise rev (V5) next week.

We are at -rc6 already, it would be good if you could send it before
the end of the week.

Thanks,
Miquèl
