Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA0C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA082074A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482686;
	bh=5x3QQ0e2UkWENL6GljWmqxUP3OcCMZkZBDtwURmupAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=prdf2sr+c16uZIQxPU3QqACzTtzeEWAaWh5+LhPJEI2rFo6UG1RXUVl0PF/gJ+Vfb
	 LqYGGT1d99dSr1bVXCHBr+lqUDotQuQjdl4VPnfrAvyUbbyhXFsjXlRNvNWP1x5UNc
	 4xSO5a1d1Km1dfjC6YALm4vHsEwEjg4xcsYuNAe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgENS6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgENS4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:56:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D2620801;
        Thu, 14 May 2020 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482591;
        bh=5x3QQ0e2UkWENL6GljWmqxUP3OcCMZkZBDtwURmupAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xpTEdIXFqTFVMCbjZgFOG12vVljUkDnuPgcjNjj054SBzdfRi4eYJwt1zgzB4lr6Q
         8NG6dzu/OryYZypp37FAKJYBC+R9Fuctbke7fnLKd2eideKLdzSMSsbKY6VSWHjO6M
         LWiEWZPsh+j32i4tjAi3VwDuKkCb2l6ZD3cAOwv4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 05/14] dp83640: reverse arguments to list_add_tail
Date:   Thu, 14 May 2020 14:56:16 -0400
Message-Id: <20200514185625.21753-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185625.21753-1-sashal@kernel.org>
References: <20200514185625.21753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@inria.fr>

[ Upstream commit 865308373ed49c9fb05720d14cbf1315349b32a9 ]

In this code, it appears that phyter_clocks is a list head, based on
the previous list_for_each, and that clock->list is intended to be a
list element, given that it has just been initialized in
dp83640_clock_init.  Accordingly, switch the arguments to
list_add_tail, which takes the list head as the second argument.

Fixes: cb646e2b02b27 ("ptp: Added a clock driver for the National Semiconductor PHYTER.")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index e6f564d50663b..847c9fc10f9a9 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1107,7 +1107,7 @@ static struct dp83640_clock *dp83640_clock_get_bus(struct mii_bus *bus)
 		goto out;
 	}
 	dp83640_clock_init(clock, bus);
-	list_add_tail(&phyter_clocks, &clock->list);
+	list_add_tail(&clock->list, &phyter_clocks);
 out:
 	mutex_unlock(&phyter_clocks_lock);
 
-- 
2.20.1

