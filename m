Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00723C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C318E20675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="MtlPW6u5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgC3X1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:27:07 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.9]:13160 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728876AbgC3X1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:27:07 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 16EEA1E77
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 18:27:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id J3oAjCmEKSl8qJ3oAjiyR3; Mon, 30 Mar 2020 18:27:06 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xhDG3dLN6Yo/RcJTREoCUsHNM+lDjok6pPw8Y/2IHM8=; b=MtlPW6u5+hLcKOUUXlj4aIV1Rj
        9B0gN5E8BYFgAboLKbVSMJv9CLzUllkbOGoJ5uVeFjdQyFcsKSgmb94YHCEluUiTLdiIvl1Iw9Kh7
        UEysDtp3D/TKEt7UoawdP5pIKFmEHmuEMtb7KbEw87S5JLEHhtvync+0lQAgbAzrPAvDNlKdr0oTQ
        eA8UgVSLM4dW4VduF9LpxGAlWDgc4Tm3z3+eEsqipTPVemYbRNIL5Ke+1I5Z0C6OTZU+aRH6MqoX3
        z4peADMt/7/RUsPjpqton+bGTUBsDpELiYI4qwLsuRc+1PGByVH7+q93N0/n5A3Oy6DSG1aAacQ1n
        mRKizwoQ==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:50684 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jJ3o8-000bhq-I6; Mon, 30 Mar 2020 18:27:04 -0500
Date:   Mon, 30 Mar 2020 18:27:02 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jiri Pirko <jiri@mellanox.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] netdevsim: dev: Fix memory leak in
 nsim_dev_take_snapshot_write
Message-ID: <20200330232702.GA3212@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jJ3o8-000bhq-I6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:50684
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for dummy_data were allocated, release them
before return.

Addresses-Coverity-ID: 1491997 ("Resource leak")
Fixes: 7ef19d3b1d5e ("devlink: report error once U32_MAX snapshot ids have been used")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/netdevsim/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 2b727a7001f6..9897e9a0e26f 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -75,6 +75,7 @@ static ssize_t nsim_dev_take_snapshot_write(struct file *file,
 	err = devlink_region_snapshot_id_get(devlink, &id);
 	if (err) {
 		pr_err("Failed to get snapshot id\n");
+		kfree(dummy_data);
 		return err;
 	}
 	err = devlink_region_snapshot_create(nsim_dev->dummy_region,
-- 
2.23.0

