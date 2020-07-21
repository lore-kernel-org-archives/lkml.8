Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289D4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05253208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgGUACq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGUACk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:02:40 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468A9C061794;
        Mon, 20 Jul 2020 17:02:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 811A811E8EC0A;
        Mon, 20 Jul 2020 16:45:54 -0700 (PDT)
Date:   Mon, 20 Jul 2020 17:02:38 -0700 (PDT)
Message-Id: <20200720.170238.1386984311681909814.davem@davemloft.net>
To:     nicolas.ferre@microchip.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, claudiu.beznea@microchip.com,
        harini.katakam@xilinx.com, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH v7 0/2] net: macb: Wake-on-Lan magic packet GEM and
 MACB handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1595235208.git.nicolas.ferre@microchip.com>
References: <cover.1595235208.git.nicolas.ferre@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jul 2020 16:45:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <nicolas.ferre@microchip.com>
Date: Mon, 20 Jul 2020 10:56:51 +0200

> Here is the second part of support for WoL magic-packet on the current macb
> driver. This one
> is addressing the bulk of the feature and is based on current net-next/master.
> 
> MACB and GEM code must co-exist and as they don't share exactly the same
> register layout, I had to specialize a bit the suspend/resume paths and plug a
> specific IRQ handler in order to avoid overloading the "normal" IRQ hot path.
> 
> These changes were tested on both sam9x60 which embeds a MACB+FIFO controller
> and sama5d2 which has a GEM+packet buffer type of controller.

Series applied to net-next, thanks.
