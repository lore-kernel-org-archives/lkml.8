Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677AFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2102074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596097035;
	bh=5gNHqO+GCSod2CKxpuKdHoXKiG22bORog2a1CSBJxns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dhiQkGZzV4Cb7vl3OupBx/g9A1s7vpgHFYE4T/NnKZG3WOvtaBou6hs144VA44TAS
	 rq9mIsSMlvXGzU+eWQZMWyQFGP0/lQIotCkcV+rFyO7zkkUjU7QFrekrrlZg0OUZfW
	 URoDd7XSOQ8SYrVE6zDezWQtcrGu0qC5LXd3M+z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgG3IRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729761AbgG3IJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:09:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE03E2070B;
        Thu, 30 Jul 2020 08:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096599;
        bh=5gNHqO+GCSod2CKxpuKdHoXKiG22bORog2a1CSBJxns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bk3pL+7i1GEcBvnU2j0RrisSrjlQhecYNPNi307g/lHbDFD3Y/0Y0cQHQZgElYvyK
         rBOs1EtRTqAAlPUWopH7MLJRkBj/vVd/ifpXCMWpqQat3SI+ISvb3kXOyJKwRmPc+6
         kVgZa8HdgMKcasgdKNAgieX5CskPPAJS6sEEFhqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 19/61] net: smc91x: Fix possible memory leak in smc_drv_probe()
Date:   Thu, 30 Jul 2020 10:04:37 +0200
Message-Id: <20200730074421.779574780@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.811058810@linuxfoundation.org>
References: <20200730074420.811058810@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit bca9749b1aa23d964d3ab930938af66dbf887f15 ]

If try_toggle_control_gpio() failed in smc_drv_probe(), free_netdev(ndev)
should be called to free the ndev created earlier. Otherwise, a memleak
will occur.

Fixes: 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/smsc/smc91x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index b0c72167badec..3c221ca2cc125 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2294,7 +2294,7 @@ static int smc_drv_probe(struct platform_device *pdev)
 		ret = try_toggle_control_gpio(&pdev->dev, &lp->power_gpio,
 					      "power", 0, 0, 100);
 		if (ret)
-			return ret;
+			goto out_free_netdev;
 
 		/*
 		 * Optional reset GPIO configured? Minimum 100 ns reset needed
@@ -2303,7 +2303,7 @@ static int smc_drv_probe(struct platform_device *pdev)
 		ret = try_toggle_control_gpio(&pdev->dev, &lp->reset_gpio,
 					      "reset", 0, 0, 100);
 		if (ret)
-			return ret;
+			goto out_free_netdev;
 
 		/*
 		 * Need to wait for optional EEPROM to load, max 750 us according
-- 
2.25.1



