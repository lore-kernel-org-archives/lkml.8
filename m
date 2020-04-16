Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3E0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A78C21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632970AbgDPLUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:20:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38774 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506318AbgDPLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:19:18 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 263642A205D;
        Thu, 16 Apr 2020 12:17:28 +0100 (BST)
Date:   Thu, 16 Apr 2020 13:17:25 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        anders.roxell@linaro.org, andriy.shevchenko@intel.com,
        arnd@arndb.de, brendanhiggins@google.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw,
        miquel.raynal@bootlin.com, piotrs@cadence.com,
        qi-ming.wu@intel.com, richard@nod.at, robh+dt@kernel.org,
        tglx@linutronix.de, vigneshr@ti.com
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on
 Intel LGM SoC
Message-ID: <20200416131725.51259573@collabora.com>
In-Reply-To: <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com>
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
        <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
        <20200416113822.2ef326cb@collabora.com>
        <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com>
        <20200416122619.2c481792@collabora.com>
        <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 18:40:53 +0800
"Ramuthevar, Vadivel MuruganX"
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

> >>> we'll be happy to have one more of the existing driver converted to  
> >>> ->exec_op() ;-).  
> >> I have completely adapted to ->exec_op() hook up to replace the legacy
> >> call-back.  
> > I suspect porting what you've done to the xway driver shouldn't be too
> > complicated.  
> Not ported from xway_nand.c driver , we have developed from the scratch 
> to make it work on
> Intel LGM SoC , it's new x86 ATOM based SoC, IP itself completely 
> different and most of the registers won't match.
> if we port then it would be ugly and also what are the problem may occur 
> we do not know.

Sorry but IMO they look similar enough to try to merge them.
