Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA3C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC72320838
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgEFJki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:40:38 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:50107 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgEFJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:40:38 -0400
X-Originating-IP: 42.109.197.213
Received: from localhost (unknown [42.109.197.213])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5B7AC240004;
        Wed,  6 May 2020 09:40:32 +0000 (UTC)
Date:   Wed, 6 May 2020 15:10:28 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     masonccyang@mxic.com.tw
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, miquel.raynal@bootlin.com,
        Pratyush Yadav <p.yadav@ti.com>, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Message-ID: <20200506094028.2asq56goslfd2ngo@yadavpratyush.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
 <20200421092328.129308f6@collabora.com>
 <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>
 <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
 <20200428085401.574wmo6qddmumd7q@yadavpratyush.com>
 <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw>
 <20200429181856.kkavelcczylg4yxf@yadavpratyush.com>
 <OF28AE0642.4F34D6BB-ON4825855F.002D6E58-4825855F.003458C9@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF28AE0642.4F34D6BB-ON4825855F.002D6E58-4825855F.003458C9@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 05:31PM, masonccyang@mxic.com.tw wrote:
> Hi Pratyush,
> > > I can't apply your patches to enable xSPI Octal mode for 
> > > mx25uw51245g because your patches set up Octal protocol first and 
> > > then using Octal protocol to write Configuration Register 2(CFG 
> > > Reg2). I think driver
> > > should write CFG Reg2 in SPI 1-1-1 mode (power on state) and make sure
> > > write CFG Reg 2 is success and then setup Octa protocol in the last.
> > 
> > Register writes should work in 1S mode, because nor->reg_proto is only 
> > set _after_ 8D mode is enabled (see spi_nor_octal_dtr_enable()). In 
> > fact, both patch 15 and 16 in my series use register writes in 1S mode.
> 
> but I didn't see driver roll back "nor->read/write_proto = 1" 
> if xxx->octal_dtr_enable() return failed!

I copied what spi_nor_quad_enable() did, and made failure fatal. So if 
xxx->octal_dtr_enable() fails, the probe would fail and the flash would 
be unusable. You can try your hand at a fallback system where you try 
all possible protocols available, but I think that should be a different 
patchset.

-- 
Regards,
Pratyush Yadav
