Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DFFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B2E20771
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgF3W6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF3W6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:58:04 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809CDC061755;
        Tue, 30 Jun 2020 15:58:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0DA8E127BE238;
        Tue, 30 Jun 2020 15:58:02 -0700 (PDT)
Date:   Tue, 30 Jun 2020 15:58:02 -0700 (PDT)
Message-Id: <20200630.155802.2190042564289803175.davem@davemloft.net>
To:     brgl@bgdev.pl
Cc:     jeffrey.t.kirsher@intel.com, kuba@kernel.org, john@phrozen.org,
        sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
        matthias.bgg@gmail.com, hkallweit1@gmail.com, andrew@lunn.ch,
        f.fainelli@gmail.com, linux@armlinux.org.uk, robh+dt@kernel.org,
        frowand.list@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        bgolaszewski@baylibre.com
Subject: Re: [PATCH v2 00/10] net: improve devres helpers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200629120346.4382-1-brgl@bgdev.pl>
References: <20200629120346.4382-1-brgl@bgdev.pl>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jun 2020 15:58:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 29 Jun 2020 14:03:36 +0200

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> So it seems like there's no support for relaxing certain networking devres
> helpers to not require previously allocated structures to also be managed.
> However the way mdio devres variants are implemented is still wrong and I
> modified my series to address it while keeping the functions strict.
> 
> First two patches modify the ixgbe driver to get rid of the last user of
> devm_mdiobus_free().
> 
> Patches 3, 4, 5 and 6 are mostly cosmetic.
> 
> Patch 7 fixes the way devm_mdiobus_register() is implemented.
> 
> Patches 8 & 9 provide a managed variant of of_mdiobus_register() and
> last patch uses it in mtk-star-emac driver.
> 
> v1 -> v2:
> - drop the patch relaxing devm_register_netdev()
> - require struct mii_bus to be managed in devm_mdiobus_register() and
>   devm_of_mdiobus_register() but don't store that information in the
>   structure itself: use devres_find() instead

Series applied, thank you.
