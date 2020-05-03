Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA0CC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 23:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805EC206E9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 23:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgECXCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 19:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbgECXCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 19:02:43 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5958CC061A0E;
        Sun,  3 May 2020 16:02:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9DE081211C987;
        Sun,  3 May 2020 16:02:42 -0700 (PDT)
Date:   Sun, 03 May 2020 16:02:42 -0700 (PDT)
Message-Id: <20200503.160242.1607340848418848790.davem@davemloft.net>
To:     zhengdejin5@gmail.com
Cc:     nicolas.ferre@microchip.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, yash.shah@sifive.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH net v3] net: macb: fix an issue about leak related
 system resources
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200503123226.7092-1-zhengdejin5@gmail.com>
References: <20200503123226.7092-1-zhengdejin5@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 May 2020 16:02:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Sun,  3 May 2020 20:32:26 +0800

> A call of the function macb_init() can fail in the function
> fu540_c000_init. The related system resources were not released
> then. use devm_platform_ioremap_resource() to replace ioremap()
> to fix it.
> 
> Fixes: c218ad559020ff9 ("macb: Add support for SiFive FU540-C000")
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Yash Shah <yash.shah@sifive.com>
> Suggested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Applied and queued up for -stable, thanks.
