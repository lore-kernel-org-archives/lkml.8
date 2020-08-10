Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00428C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE6E2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHJHZz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:25:55 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52587 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgHJHZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:25:54 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8FB46FF802;
        Mon, 10 Aug 2020 07:25:49 +0000 (UTC)
Date:   Mon, 10 Aug 2020 09:25:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] mtd: Changes for 5.9
Message-ID: <20200810092548.415bcab7@xps13>
In-Reply-To: <CAHk-=whJ0SQjLeMiVvMXayxvxCmAMdROxyb-Pzs=kr4-Ba5BCA@mail.gmail.com>
References: <20200809003453.79673eb3@xps13>
        <CAHk-=whJ0SQjLeMiVvMXayxvxCmAMdROxyb-Pzs=kr4-Ba5BCA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds <torvalds@linux-foundation.org> wrote on Sun, 9 Aug 2020
12:47:01 -0700:

> On Sat, Aug 8, 2020 at 3:35 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > MTD core changes:  
> ..
> 
> You didn't even mention the stm32 controller change, which seems to be
> the biggest individual thing in here..

Oh sorry, I put it aside and then forgot it when writing the changelog :/
I'll try to be more careful.

Thanks,
Miquèl
