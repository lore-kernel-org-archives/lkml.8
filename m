Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A67C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4D720899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653264;
	bh=ZRRb4awJREa0OKA+5uYMfVnNompYcbeIiEG0iZwwA2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jM0mkloaKRAaLG9TUnlAhIfqASxoI70vNMZHSngfx8+6TUG6AM8P8qrpmqUmEHNW0
	 46ti8H4Vo/m5j8Xe35GWRREtoJOYnoh+ucURxy2Z9ggY/ikQ11vfSMQxv6qH4HwIfs
	 0Cd7j3qOoiriwGFCyTdy+dOVfP6mxP5dSF1bWPzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgGBB1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728403AbgGBB07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:26:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E2CA20874;
        Thu,  2 Jul 2020 01:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653218;
        bh=ZRRb4awJREa0OKA+5uYMfVnNompYcbeIiEG0iZwwA2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIxaD3gATKE0ZJhHLg8/RN6SKhhKNKpyKTP9M2CEPo6yr2gvfA72r3bYHfzLq3ROH
         KQS2/7hJzYEWhxz3B14l3XNNJ6KyMW53wt/YZ1v//mxIXFWEi2xdRM51CwNVjaCRu4
         io1nwpgHCHgDTMg+n0xNZKrlX+MyPyR60UmnN0W8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Christensen <drc@linux.vnet.ibm.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/17] tg3: driver sleeps indefinitely when EEH errors exceed eeh_max_freezes
Date:   Wed,  1 Jul 2020 21:26:39 -0400
Message-Id: <20200702012649.2701799-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012649.2701799-1-sashal@kernel.org>
References: <20200702012649.2701799-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Christensen <drc@linux.vnet.ibm.com>

[ Upstream commit 3a2656a211caf35e56afc9425e6e518fa52f7fbc ]

The driver function tg3_io_error_detected() calls napi_disable twice,
without an intervening napi_enable, when the number of EEH errors exceeds
eeh_max_freezes, resulting in an indefinite sleep while holding rtnl_lock.

Add check for pcierr_recovery which skips code already executed for the
"Frozen" state.

Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index bc0221eafe5c4..e40d31b405253 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18179,8 +18179,8 @@ static pci_ers_result_t tg3_io_error_detected(struct pci_dev *pdev,
 
 	rtnl_lock();
 
-	/* We probably don't have netdev yet */
-	if (!netdev || !netif_running(netdev))
+	/* Could be second call or maybe we don't have netdev yet */
+	if (!netdev || tp->pcierr_recovery || !netif_running(netdev))
 		goto done;
 
 	/* We needn't recover from permanent error */
-- 
2.25.1

