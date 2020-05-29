Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A72AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43717207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgE2J2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:28:12 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34851 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2J2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:28:11 -0400
Received: from localhost (unknown [42.109.222.225])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D76C2240005;
        Fri, 29 May 2020 09:28:04 +0000 (UTC)
Date:   Fri, 29 May 2020 14:57:58 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com
Subject: Re: [PATCH v4 2/7] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
Message-ID: <20200529092758.ezuyac2r6vmp6tfs@yadavpratyush.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
 <1590737775-4798-3-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590737775-4798-3-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/20 03:36PM, Mason Yang wrote:
> JESD251, xSPI profile 1.0 table supports octal DTR mode.
> Extract information like the fast read opcode, dummy cycles for various
> frequencies, the number of dummy cycles needed for a Read Status
> Register command, the number of address bytes needed for a Read
> Status Register command, read volatile register command and write
> volatile register command.

Like I said before, please don't re-introduce the functions. My patch 
series already parses the table. Add whatever new feature you want on 
top of it.
 
> According to BFPT 20th DWORD of octal maximum speed, driver get it's
> specific dummy cycles from profile 1.0 table and then could update
> it to device by their fixup hooks.

My patch [0] already find out the dummy cycles from the table as you 
suggested, though it doesn't consult the BFPT. Instead, it uses the 
dummy cycle fields themselves as indication that a speed is supported or 
not.
 
[0] https://lore.kernel.org/linux-mtd/20200525091544.17270-10-p.yadav@ti.com/

-- 
Regards,
Pratyush Yadav
