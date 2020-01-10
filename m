Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF4DC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4016020721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAJIV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:21:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50198 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgAJIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:21:56 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1F0FF293977;
        Fri, 10 Jan 2020 08:21:55 +0000 (GMT)
Date:   Fri, 10 Jan 2020 09:21:52 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: nand: spi: rework detect procedure for
 different read id op
Message-ID: <20200110092152.64d05705@collabora.com>
In-Reply-To: <20200110091024.56918193@xps13>
References: <20200110025218.1257809-1-gch981213@gmail.com>
        <20200110075859.3edfae3a@collabora.com>
        <CAJsYDVK4RtX92O3M+EOsZa5qS4TxE0OVaEq=KOnAuP6DEHvw2Q@mail.gmail.com>
        <20200110090422.75988c49@collabora.com>
        <20200110091024.56918193@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 09:10:24 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> Boris Brezillon <boris.brezillon@collabora.com> wrote on Fri, 10 Jan
> 2020 09:04:22 +0100:
> 
> > On Fri, 10 Jan 2020 15:34:28 +0800
> > Chuanhong Guo <gch981213@gmail.com> wrote:
> >   
> > > Hi!
> > > 
> > > On Fri, Jan 10, 2020 at 2:59 PM Boris Brezillon
> > > <boris.brezillon@collabora.com> wrote:    
> > > > [...]      
> > > > > +     ret = spinand_read_id_op(spinand, 1, 0, id);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +     ret = spinand_manufacturer_match(spinand,
> > > > > +                                      SPINAND_READID_METHOD_OPCODE_ADDR);
> > > > > +     if (!ret)
> > > > > +             return 0;
> > > > > +
> > > > > +     ret = spinand_read_id_op(spinand, 0, 1, id);      
> > > >
> > > > Hm, we should probably do only one of each read_id and iterate over all
> > > > manufacturers/chips each time instead of doing 3 read_ids per
> > > > manufacturer.      
> > > 
> > > This actually do the former instead of the latter. Maybe the function
> > > names are a bit
> > > misleading. spinand_manufacturer_match iterates over all manufacturers
> > > in one call,
> > > and spinand_manufacturer_detect is called once in spinand_detect.
> > > Do you have suggestions on function naming?    
> > 
> > Maybe you can just inline the content of this function in
> > spinand_detect().  
> 
> Actually I found that part clear enough, I would keep it as is, out of
> the spinand_detect() function as long as there is no actual reason to
> merge them?

Hm, I kind of disagree. The current name makes it sound like the
function detects the manufacturer or does a per-manufacturer id
detection, which is not the case. How about spinand_id_based_detect() or
spinand_readid_detect()?
