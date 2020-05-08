Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27451C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEDC32173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEHTHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:07:45 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58201 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgEHTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:07:44 -0400
X-Originating-IP: 157.36.216.22
Received: from localhost (unknown [157.36.216.22])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9F7331C0006;
        Fri,  8 May 2020 19:07:38 +0000 (UTC)
Date:   Sat, 9 May 2020 00:37:35 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC-PATCH] mtd: spi-nor: add conditional 4B opcodes
Message-ID: <20200508190735.tpgeuirsnyjexfz4@yadavpratyush.com>
References: <20200507162047.30788-1-danielwa@cisco.com>
 <20200507180346.gwni4hf6kb6gd2e5@yadavpratyush.com>
 <20200507181356.GZ9016@zorba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507181356.GZ9016@zorba>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 07/05/20 06:13PM, Daniel Walker (danielwa) wrote:
> On Thu, May 07, 2020 at 11:33:46PM +0530, Pratyush Yadav wrote:
> > On 07/05/20 09:20AM, Daniel Walker wrote:
> > > Some chips have 4B opcodes, but there is no way to know if they have
> > > them. This device tree option allows platform owners to force enable 4b
> > > opcodes when they know their chips support it even when it can be
> > > automatically identified.
> > 
> > Do you mean that two chips might have the same ID but one of them can 
> > support 4B opcodes and the other can not? Is it possible to detect this 
> > in a fixup hook? I think it would be better to do something like this in 
> > a fixup hook instead of via device tree.
>   
> Yes. The chip I added the option for is an example of this, it's n25q256a. I'm not familiar with the
> fixup hook mechanism, but I would assume you need some way to tell between the 4B
> opcode chips and the non-4B opcode chips. For n25q256a, we have not found a way
> to do that.

I'm assuming this patch is related to [0]. If all you want is to address 
memory above 16M, why not switch to 4-byte addressing mode instead? 
Taking a quick look at the datasheet tells me this can be done via the 
"Enter 4-byte address mode" command (0xB7). Then just use the regular 
read/program commands with 4-byte addresses. Does that work for you? Is 
there any reason you _have_ to use dedicated 4B opcodes?

[0] https://lore.kernel.org/linux-mtd/20200417174620.16420-1-danielwa@cisco.com/ 

-- 
Regards,
Pratyush Yadav
