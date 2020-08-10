Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A834C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AA52080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073443;
	bh=yCnOv7z6QR8V//pqvrVl+elidpg/YiHVrVZ9pqUErzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z/NwJw1XSp42fzpftse3FiPWebYrWBw2p2gQeLDwyibD5/6awQNE826Phf7xhYt5r
	 9giKV66+gRWwIhBfNlw5kxvagTNtMsmszQNLaCTFNJkh9fgtszWz4BlAqAwh3pTymW
	 ZbNqGr0j4jdxbcIrhCpk+FjZ1g9tNZ+xcoFO2F6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgHJPal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbgHJPah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:30:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655DA20774;
        Mon, 10 Aug 2020 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073436;
        bh=yCnOv7z6QR8V//pqvrVl+elidpg/YiHVrVZ9pqUErzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Eix6MotZRTq77L5XkIg+eDqmqRe63MhzXhclL4qi4X4zuon3BscF7ytxw35Te6q2
         vPOEPqGLRPIaxyFyHiwbzKzBhepZ0+dveAdZh9YWrUSXtufKd9m4BRuAANNlzGIFzK
         OZCXQ11voLLBu2b6Jvo7gEmO5wIPWie0NFMnkFGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Rafael P." <rparrazo@redhat.com>,
        Dean Nelson <dnelson@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 39/48] net: thunderx: use spin_lock_bh in nicvf_set_rx_mode_task()
Date:   Mon, 10 Aug 2020 17:22:01 +0200
Message-Id: <20200810151806.141225080@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
References: <20200810151804.199494191@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit bab9693a9a8c6dd19f670408ec1e78e12a320682 ]

A dead lock was triggered on thunderx driver:

        CPU0                    CPU1
        ----                    ----
   [01] lock(&(&nic->rx_mode_wq_lock)->rlock);
                           [11] lock(&(&mc->mca_lock)->rlock);
                           [12] lock(&(&nic->rx_mode_wq_lock)->rlock);
   [02] <Interrupt> lock(&(&mc->mca_lock)->rlock);

The path for each is:

  [01] worker_thread() -> process_one_work() -> nicvf_set_rx_mode_task()
  [02] mld_ifc_timer_expire()
  [11] ipv6_add_dev() -> ipv6_dev_mc_inc() -> igmp6_group_added() ->
  [12] dev_mc_add() -> __dev_set_rx_mode() -> nicvf_set_rx_mode()

To fix it, it needs to disable bh on [1], so that the timer on [2]
wouldn't be triggered until rx_mode_wq_lock is released. So change
to use spin_lock_bh() instead of spin_lock().

Thanks to Paolo for helping with this.

v1->v2:
  - post to netdev.

Reported-by: Rafael P. <rparrazo@redhat.com>
Tested-by: Dean Nelson <dnelson@redhat.com>
Fixes: 469998c861fa ("net: thunderx: prevent concurrent data re-writing by nicvf_set_rx_mode")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -2015,11 +2015,11 @@ static void nicvf_set_rx_mode_task(struc
 	/* Save message data locally to prevent them from
 	 * being overwritten by next ndo_set_rx_mode call().
 	 */
-	spin_lock(&nic->rx_mode_wq_lock);
+	spin_lock_bh(&nic->rx_mode_wq_lock);
 	mode = vf_work->mode;
 	mc = vf_work->mc;
 	vf_work->mc = NULL;
-	spin_unlock(&nic->rx_mode_wq_lock);
+	spin_unlock_bh(&nic->rx_mode_wq_lock);
 
 	__nicvf_set_rx_mode_task(mode, mc, nic);
 }


