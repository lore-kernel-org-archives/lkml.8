Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9036CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6821620781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458897;
	bh=hqsaVkWYZ30Bdjp65ee3HuhTa6iU30/KGApD393mAUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2RV/DXekvS+OPr9n1Yh9uajhd8qSsHWGBR1x5PegD6f/p9Kt7Y9mMo6dnwl9vm4D5
	 m8yaJDSRQXT1nsfCZicCatYxnE/HK2FNf3I4W3Uq98O7NObRFHLyk3TQWa5Yg8tU6k
	 /hdtpQHUBo1beVVjgdKyfeF14csczqv09LWEOa9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgHCMsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgHCMYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:24:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2594C204EC;
        Mon,  3 Aug 2020 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457493;
        bh=hqsaVkWYZ30Bdjp65ee3HuhTa6iU30/KGApD393mAUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/I/4ggz3iKnvz3wM9JAx7/qm24ogk0AlJT5fEAIWW23lVnsYtEq6aHRyMV/3mrSQ
         2sJ8i7QXscfOd9FkMD29VeioMt/7MTH3krK57wkyxsUG+pRNC4g/pjH9HWQ4xbzAPj
         8bdYSLNXn6ZjVIUXpCffMg9XoEPmsGGTGET1yTH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Shannon Nelson <snelson@pensando.io>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 088/120] ionic: unlock queue mutex in error path
Date:   Mon,  3 Aug 2020 14:19:06 +0200
Message-Id: <20200803121907.156107894@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121902.860751811@linuxfoundation.org>
References: <20200803121902.860751811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shannon Nelson <snelson@pensando.io>

[ Upstream commit 59929fbb45e06da7d501d3a97f10a91912181f7c ]

On an error return, jump to the unlock at the end to be sure
to unlock the queue_lock mutex.

Fixes: 0925e9db4dc8 ("ionic: use mutex to protect queue operations")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Shannon Nelson <snelson@pensando.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 2c3e9ef22129c..337d971ffd92c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1959,7 +1959,7 @@ int ionic_reset_queues(struct ionic_lif *lif, ionic_reset_cb cb, void *arg)
 		netif_device_detach(lif->netdev);
 		err = ionic_stop(lif->netdev);
 		if (err)
-			return err;
+			goto reset_out;
 	}
 
 	if (cb)
@@ -1969,6 +1969,8 @@ int ionic_reset_queues(struct ionic_lif *lif, ionic_reset_cb cb, void *arg)
 		err = ionic_open(lif->netdev);
 		netif_device_attach(lif->netdev);
 	}
+
+reset_out:
 	mutex_unlock(&lif->queue_lock);
 
 	return err;
-- 
2.25.1



