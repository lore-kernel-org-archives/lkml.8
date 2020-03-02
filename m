Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EEBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4B5246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCBJM6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:12:58 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:54959 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgCBJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:12:58 -0500
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E8381100002;
        Mon,  2 Mar 2020 09:12:55 +0000 (UTC)
Date:   Mon, 2 Mar 2020 10:12:54 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spinand: toshiba: Rename function name to
 change suffix and prefix (8Gbit)
Message-ID: <20200302101254.31ca0c83@xps13>
In-Reply-To: <d2837c89-c9b2-fd18-d090-567f2a90cf75@kontron.de>
References: <cover.1582603241.git.ytc-mb-yfuruyama7@kioxia.com>
        <41b30e2d308ec7f252d71970a2ed1c29cd25c0d7.1582603241.git.ytc-mb-yfuruyama7@kioxia.com>
        <d2837c89-c9b2-fd18-d090-567f2a90cf75@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Mon, 2 Mar 2020
08:02:25 +0000:

> On 28.02.20 04:11, Yoshio Furuyama wrote:
> > The suffix was changed to classify from "g" to "j" between 1st generation
> > device and 2nd generation device that's new Serial NAND of Kioxia brand.  
> 
> I had to read this sentence multiple times to understand it. Maybe 
> something like this would be better:
> 
>    The suffix was changed from "g" to "j" to classify between 1st
>    generation and 2nd generation serial NAND devices (which now belong to
>    the Kioxia brand).
> 
> > As reference that's
> > 1st generation device of 1Gbit product is "tc58cvg0s3hraig"
> > 2nd generation device of 1Gbit product is "tc58cvg0s3hraij".
> > 
> > The 8Gbit product "TH58CxG3S0HRAIJ" is new line up of Kioxia's serial nand
> > and changed the prefix from tc58 to th58.
> > Thus it was changed argument to the function from "tc58cxgxsx" to
> > "tx58cxgxsxraix".  
> 
> Same here. It is very hard to read. I would write something like this:
> 
>    The 8Gbit type "TH58CxG3S0HRAIJ" is new to Kioxia's serial NAND lineup
>    and the prefix was changed from "TC58" to "TH85".
> 
>    Thus the functions were renamed from tc58cxgxsx_*() to
>    tx58cxgxsxraix_*().
> 
> With an easier to understand commit message:
> 
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Agreed, the commit log proposal from Frieder looks better.

The rest of the patch is fine by me though.

Thanks,
Miquèl
