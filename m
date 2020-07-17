Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ED7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9825620684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgGQTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQTpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:45:04 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD7C0619D2;
        Fri, 17 Jul 2020 12:45:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 22FD911E45925;
        Fri, 17 Jul 2020 12:45:03 -0700 (PDT)
Date:   Fri, 17 Jul 2020 12:45:02 -0700 (PDT)
Message-Id: <20200717.124502.1686970196922612927.davem@davemloft.net>
To:     wanghai38@huawei.com
Cc:     nico@fluxnic.net, kuba@kernel.org, mst@redhat.com,
        hkallweit1@gmail.com, snelson@pensando.io,
        elfring@users.sourceforge.net, dmitry.torokhov@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanghai26@huawei.com
Subject: Re: [PATCH] net: smc91x: Fix possible memory leak in
 smc_drv_probe()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200716035038.19207-1-wanghai38@huawei.com>
References: <20200716035038.19207-1-wanghai38@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jul 2020 12:45:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>
Date: Thu, 16 Jul 2020 11:50:38 +0800

> If try_toggle_control_gpio() failed in smc_drv_probe(), free_netdev(ndev)
> should be called to free the ndev created earlier. Otherwise, a memleak
> will occur.
> 
> Fixes: 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Applied, thank you.
