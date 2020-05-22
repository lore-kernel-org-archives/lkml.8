Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D7FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E091206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgEVWg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVWg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:36:56 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513D6C061A0E;
        Fri, 22 May 2020 15:36:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B0F6412738EE0;
        Fri, 22 May 2020 15:36:54 -0700 (PDT)
Date:   Fri, 22 May 2020 15:36:53 -0700 (PDT)
Message-Id: <20200522.153653.998395486877096103.davem@davemloft.net>
To:     brgl@bgdev.pl
Cc:     corbet@lwn.net, matthias.bgg@gmail.com, john@phrozen.org,
        sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, kuba@kernel.org,
        arnd@arndb.de, fparent@baylibre.com, hkallweit1@gmail.com,
        edwin.peer@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        stephane.leprovost@mediatek.com, pedro.tsai@mediatek.com,
        andrew.perepech@mediatek.com, bgolaszewski@baylibre.com
Subject: Re: [PATCH 0/5] net: provide a devres variant of register_netdev()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200520114415.13041-1-brgl@bgdev.pl>
References: <20200520114415.13041-1-brgl@bgdev.pl>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 May 2020 15:36:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 May 2020 13:44:10 +0200

>   net: ethernet: mtk_eth_mac: use devm_register_netdev()

This patch doesn't apply to net-next.

Neither the source file drivers/net/ethernet/mediatek/mtk_eth_mac.c,
nor the function mtk_mac_probe() even exist in the net-next GIT
tree.
