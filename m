Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A751C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379DB204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690070;
	bh=dHoB6WN7dMe7me8nFYFb2Na5SEj5aIZg5J6VQssDatI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZLf1gxw2yXppyL25JnyyNfPCLf4/Sy7/MCZwiwXHT/a6Y4DSQyENJwm9Ft49JZgrT
	 3UB6htc0R94vvDd1/Q6mJGHgvvtglCEXjrGvcS0HIdMWUTMeM7boDdHwkpCSIGf2pL
	 TKbtCABLeqTsLxYWYH5R0qO/3UGZP296d2zmyddU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391360AbgHQSrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388028AbgHQPzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:55:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2390F207DA;
        Mon, 17 Aug 2020 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679736;
        bh=dHoB6WN7dMe7me8nFYFb2Na5SEj5aIZg5J6VQssDatI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Moe8LbpojW1yjvaPjDYkTC1f803SkghqIXrBLBQJ4GQ6GV3lzIFiFvtiX/HZ7Ux6z
         EJKlX6Ghe0FuyJbsNKR8ocKNYcHwW0Twyu+HIMTsat2k7V782ee3jy0rg+tHfGgpKk
         ZCRPU0zltybHWLBzYbEwY3FZTIz1u+o+Q3Ly/eKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 289/393] qtnfmac: Missing platform_device_unregister() on error in qtnf_core_mac_alloc()
Date:   Mon, 17 Aug 2020 17:15:39 +0200
Message-Id: <20200817143833.641551886@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit 141bc9abbbffa89d020957caa9ac4a61d0ef1e26 ]

Add the missing platform_device_unregister() before return from
qtnf_core_mac_alloc() in the error handling case.

Fixes: 616f5701f4ab ("qtnfmac: assign each wiphy to its own virtual platform device")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Reviewed-by: Sergey Matyukevich <geomatsi@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200730064910.37589-1-wanghai38@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/quantenna/qtnfmac/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index eea777f8acea5..6aafff9d4231b 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -446,8 +446,11 @@ static struct qtnf_wmac *qtnf_core_mac_alloc(struct qtnf_bus *bus,
 	}
 
 	wiphy = qtnf_wiphy_allocate(bus, pdev);
-	if (!wiphy)
+	if (!wiphy) {
+		if (pdev)
+			platform_device_unregister(pdev);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	mac = wiphy_priv(wiphy);
 
-- 
2.25.1



