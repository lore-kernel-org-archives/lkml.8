Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D12FC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0032076A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgD1UyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbgD1UyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:54:18 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A14C03C1AC;
        Tue, 28 Apr 2020 13:54:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9B4B9120F52B8;
        Tue, 28 Apr 2020 13:54:16 -0700 (PDT)
Date:   Tue, 28 Apr 2020 13:54:15 -0700 (PDT)
Message-Id: <20200428.135415.1205625453935613273.davem@davemloft.net>
To:     chentao107@huawei.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next] net: phy: bcm54140: Make a bunch of functions
 static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200428014804.54944-1-chentao107@huawei.com>
References: <20200428014804.54944-1-chentao107@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 28 Apr 2020 13:54:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChenTao <chentao107@huawei.com>
Date: Tue, 28 Apr 2020 09:48:04 +0800

> Fix the following warning:
> 
> drivers/net/phy/bcm54140.c:663:5: warning:
> symbol 'bcm54140_did_interrupt' was not declared. Should it be static?
> drivers/net/phy/bcm54140.c:672:5: warning:
> symbol 'bcm54140_ack_intr' was not declared. Should it be static?
> drivers/net/phy/bcm54140.c:684:5: warning:
> symbol 'bcm54140_config_intr' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenTao <chentao107@huawei.com>

Applied, thank you.
