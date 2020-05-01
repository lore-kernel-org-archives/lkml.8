Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C2CC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548A124955
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340112;
	bh=Pg2DWFBA/wZ8V2TNH1P7vfR7KkbYL+wGWJDvFt2NJfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jiEquYZb39J4KD949Yz4qCcCXFwGf25t3ufzk9sP09wOvFoagXY8dqLYz6QH4K4eK
	 RAp1sV4RN7U4x/P1yVf5mGPZ/R+IcUAlzzYCmE3XlRyB+rF9qFvc99FXZTpgDHVk+R
	 0T47nVlNX5RplLl+eG+geQu8Bt4fUUnl35vNSTpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgEANfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730643AbgEANfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:35:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 977022495A;
        Fri,  1 May 2020 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340102;
        bh=Pg2DWFBA/wZ8V2TNH1P7vfR7KkbYL+wGWJDvFt2NJfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCOy1q9iwB7YiXaobDijvZjooFkQ7IUZhBSxAXHvUYIjbhzS36kkzhM128PYqQeiL
         gv9/7cqdIHeJXghCuj9ztxNiTJXOZZE8LHriGJVyfPACX+oWDNSS/ZPNjjaqH1EC8U
         vBA7BZKROryAS6x9vGneOR/MHGEUS5DCDs7Zu/YA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 094/117] net/cxgb4: Check the return from t4_query_params properly
Date:   Fri,  1 May 2020 15:22:10 +0200
Message-Id: <20200501131555.999408717@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

commit c799fca8baf18d1bbbbad6c3b736eefbde8bdb90 upstream.

Positive return values are also failures that don't set val,
although this probably can't happen. Fixes gcc 10 warning:

drivers/net/ethernet/chelsio/cxgb4/t4_hw.c: In function ‘t4_phy_fw_ver’:
drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:3747:14: warning: ‘val’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 3747 |  *phy_fw_ver = val;

Fixes: 01b6961410b7 ("cxgb4: Add PHY firmware support for T420-BT cards")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3609,7 +3609,7 @@ int t4_phy_fw_ver(struct adapter *adap,
 		 FW_PARAMS_PARAM_Z_V(FW_PARAMS_PARAM_DEV_PHYFW_VERSION));
 	ret = t4_query_params(adap, adap->mbox, adap->pf, 0, 1,
 			      &param, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 	*phy_fw_ver = val;
 	return 0;


