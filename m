Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A424AC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C17D20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624206;
	bh=PNrmHsCIJfqE4uohYbNXy7WH6tKKMYk92T39QNr6kac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YFISMfeUAQ9+L0MlJjbtPqlFm/XbrePRQ5D+NKPm0X2ElDYiaNbNaU2rm+c2yqybm
	 2E8WSdDTUEcnJtFHJqEMMaRPeoCgttsKMI+tlgTRgLefm8UeppWGjLSABndGEktkFF
	 9zzwWEwatX6tQw3/4g4wggvCkG8eLHCMVgAF/ckk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgCSNXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbgCSNXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:23:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C073B2098B;
        Thu, 19 Mar 2020 13:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624201;
        bh=PNrmHsCIJfqE4uohYbNXy7WH6tKKMYk92T39QNr6kac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLIbRDbBOwbuqTYYP6GJNg1dUsPtxswGm/aOhFHdKe40bQOqPaYAuRq4hQzObwvPL
         9oOfs++vTDv84yOQFMV7ziX2jQKQZFO8rAJLZ7f4UUZMtTgpEQXi38xfHbiWaB+7/M
         Q7rOGJQIK+SEmW5vYpSZLk5Y2tpB5d1XHqYk9VOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luo bin <luobin9@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 41/60] hinic: fix a bug of rss configuration
Date:   Thu, 19 Mar 2020 14:04:19 +0100
Message-Id: <20200319123932.644875281@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123919.441695203@linuxfoundation.org>
References: <20200319123919.441695203@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo bin <luobin9@huawei.com>

[ Upstream commit 386d4716fd91869e07c731657f2cde5a33086516 ]

should use real receive queue number to configure hw rss
indirect table rather than maximal queue number

Signed-off-by: Luo bin <luobin9@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 2411ad270c98e..42d00b049c6e8 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -356,7 +356,8 @@ static void hinic_enable_rss(struct hinic_dev *nic_dev)
 	if (!num_cpus)
 		num_cpus = num_online_cpus();
 
-	nic_dev->num_qps = min_t(u16, nic_dev->max_qps, num_cpus);
+	nic_dev->num_qps = hinic_hwdev_num_qps(hwdev);
+	nic_dev->num_qps = min_t(u16, nic_dev->num_qps, num_cpus);
 
 	nic_dev->rss_limit = nic_dev->num_qps;
 	nic_dev->num_rss = nic_dev->num_qps;
-- 
2.20.1



