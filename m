Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B7C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCAC20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340890;
	bh=jmoOlOQzb/4loTlzktcFcePz/u6qPtutG/oVRDkRKeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hID1WMywDi/NK/rztkUdk7J8oJAVjpHd/de2ycwoykKkwLMl0BSxI3n7EAqaDqnLR
	 UJukbuqLgnx3V4lS26PjfZ1Ng6W7sXPHOlQo4LrzLW2BgP1baA2Of12iF9+Kd7OS2B
	 5dYcjmrr46x4xnyrTvwtYqyvLilAq3GT1kEK0S1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgBJNVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbgBJMhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:32 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F322168B;
        Mon, 10 Feb 2020 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338252;
        bh=jmoOlOQzb/4loTlzktcFcePz/u6qPtutG/oVRDkRKeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U50M41w8doaiWDwaCkwEX4qhQZqvcaeVT+iBlNEqtNgvqr++Ezs2n3CGr+22anq3H
         4Abe8wp7nq1sJyAU+BY+0peX2CN/8QvR08AHJYuD1hk49NWqniSNdqnGO5kOCmx6cF
         MiBSXmOHsi45pYdqEa4SCKUzE6FktIzR3/duqMMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.4 115/309] power: supply: ltc2941-battery-gauge: fix use-after-free
Date:   Mon, 10 Feb 2020 04:31:11 -0800
Message-Id: <20200210122417.607781370@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <thesven73@gmail.com>

commit a60ec78d306c6548d4adbc7918b587a723c555cc upstream.

This driver's remove path calls cancel_delayed_work().
However, that function does not wait until the work function
finishes. This could mean that the work function is still
running after the driver's remove function has finished,
which would result in a use-after-free.

Fix by calling cancel_delayed_work_sync(), which ensures that
that the work is properly cancelled, no longer running, and
unable to re-schedule itself.

This issue was detected with the help of Coccinelle.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/ltc2941-battery-gauge.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -449,7 +449,7 @@ static int ltc294x_i2c_remove(struct i2c
 {
 	struct ltc294x_info *info = i2c_get_clientdata(client);
 
-	cancel_delayed_work(&info->work);
+	cancel_delayed_work_sync(&info->work);
 	power_supply_unregister(info->supply);
 	return 0;
 }


