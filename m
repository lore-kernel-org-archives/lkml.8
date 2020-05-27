Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379EAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A39020890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391981AbgE0SZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbgE0SZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:25:17 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD579C08C5C1;
        Wed, 27 May 2020 11:25:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8DC45128B2F3C;
        Wed, 27 May 2020 11:25:16 -0700 (PDT)
Date:   Wed, 27 May 2020 11:25:15 -0700 (PDT)
Message-Id: <20200527.112515.1714930146142742523.davem@davemloft.net>
To:     brgl@bgdev.pl
Cc:     john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
        kuba@kernel.org, matthias.bgg@gmail.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        fparent@baylibre.com, stephane.leprovost@mediatek.com,
        pedro.tsai@mediatek.com, andrew.perepech@mediatek.com,
        bgolaszewski@baylibre.com, natechancellor@gmail.com
Subject: Re: [PATCH] net: ethernet: mtk-star-emac: fix error path in RX
 handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200527092404.3567-1-brgl@bgdev.pl>
References: <20200527092404.3567-1-brgl@bgdev.pl>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 May 2020 11:25:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 May 2020 11:24:04 +0200

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The dma_addr field in desc_data must not be overwritten until after the
> new skb is mapped. Currently we do replace it with uninitialized value
> in error path. This change fixes it by moving the assignment before the
> label to which we jump after mapping or allocation errors.
> 
> Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied, please use "[PATCH net-next]" to clearly indicate the target
GIT tree next time.

Thank you.
