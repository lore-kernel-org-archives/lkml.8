Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A007C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A23206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgD0Onm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:43:42 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:63775 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgD0Onl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:43:41 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5F011240007;
        Mon, 27 Apr 2020 14:43:38 +0000 (UTC)
Date:   Mon, 27 Apr 2020 16:43:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "R, Vignesh" <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mtd: rawnand: brcmnand: Remove unused including
 <linux/version.h>
Message-ID: <20200427164336.5df4650a@xps13>
In-Reply-To: <CAC=U0a2VfQBmHdS4eL0Fbm==aVCS0FWoBnZi7tRHzNKmm=SDVQ@mail.gmail.com>
References: <20200417101129.35556-1-yuehaibing@huawei.com>
        <CAC=U0a2VfQBmHdS4eL0Fbm==aVCS0FWoBnZi7tRHzNKmm=SDVQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Fri, 17 Apr 2020 14:40:51
-0400:

> On Fri, Apr 17, 2020 at 6:12 AM YueHaibing <yuehaibing@huawei.com> wrote:
> >
> > Remove including <linux/version.h> that don't need it.
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>  
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Can I suppose you meant "Reviewed-by" ?


Thanks,
Miquèl
