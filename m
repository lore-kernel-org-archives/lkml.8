Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F5C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2945024695
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220828;
	bh=N53L2593G9AItP5Hfi5f6AE/8lIDgtBvs63EpGa8FJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwRyQ8aetypt8aB4yCM11A197XQyw5sXFRjBgW9b1GezubJ5dy5DOY0YzB/mvigeY
	 4uMxsFk5NdtC3rIL5YLgEKSLjrFGtqglhSGMaE6nype4NKEkbPK7CSZcyAhrI534Sh
	 HrpdHQ6ZKMGjISX7ffxQ78Zr8GKGrVMuyD+2peeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgA1ONr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbgA1ONj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:13:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E41F524688;
        Tue, 28 Jan 2020 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220818;
        bh=N53L2593G9AItP5Hfi5f6AE/8lIDgtBvs63EpGa8FJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjhnUc/7pBLAljg5qn4P3Cq9GYEwVJfE2C5Zv0fs2RZ9Ad6CzEb4+1Zhnf+5TtXgw
         +9hhFyRyz+JTmyEHsJg1tpuGAlDi190jkMET6fXmW8M1lYczv37PYv4nJ2MUxJO/5l
         pTM57e7qA3nSs7xq0TgTCU6lPbeUgQdXdxdrutE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+017e491ae13c0068598a@syzkaller.appspotmail.com,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Tyler Hall <tylerwhall@gmail.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller@googlegroups.com
Subject: [PATCH 4.4 160/183] can, slip: Protect tty->disc_data in write_wakeup and close with RCU
Date:   Tue, 28 Jan 2020 15:06:19 +0100
Message-Id: <20200128135845.698951055@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Palethorpe <rpalethorpe@suse.com>

[ Upstream commit 0ace17d56824165c7f4c68785d6b58971db954dd ]

write_wakeup can happen in parallel with close/hangup where tty->disc_data
is set to NULL and the netdevice is freed thus also freeing
disc_data. write_wakeup accesses disc_data so we must prevent close from
freeing the netdev while write_wakeup has a non-NULL view of
tty->disc_data.

We also need to make sure that accesses to disc_data are atomic. Which can
all be done with RCU.

This problem was found by Syzkaller on SLCAN, but the same issue is
reproducible with the SLIP line discipline using an LTP test based on the
Syzkaller reproducer.

A fix which didn't use RCU was posted by Hillf Danton.

Fixes: 661f7fda21b1 ("slip: Fix deadlock in write_wakeup")
Fixes: a8e83b17536a ("slcan: Port write_wakeup deadlock fix from slip")
Reported-by: syzbot+017e491ae13c0068598a@syzkaller.appspotmail.com
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Tyler Hall <tylerwhall@gmail.com>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/slcan.c |   12 ++++++++++--
 drivers/net/slip/slip.c |   12 ++++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -344,9 +344,16 @@ static void slcan_transmit(struct work_s
  */
 static void slcan_write_wakeup(struct tty_struct *tty)
 {
-	struct slcan *sl = tty->disc_data;
+	struct slcan *sl;
+
+	rcu_read_lock();
+	sl = rcu_dereference(tty->disc_data);
+	if (!sl)
+		goto out;
 
 	schedule_work(&sl->tx_work);
+out:
+	rcu_read_unlock();
 }
 
 /* Send a can_frame to a TTY queue. */
@@ -640,10 +647,11 @@ static void slcan_close(struct tty_struc
 		return;
 
 	spin_lock_bh(&sl->lock);
-	tty->disc_data = NULL;
+	rcu_assign_pointer(tty->disc_data, NULL);
 	sl->tty = NULL;
 	spin_unlock_bh(&sl->lock);
 
+	synchronize_rcu();
 	flush_work(&sl->tx_work);
 
 	/* Flush network side */
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -452,9 +452,16 @@ static void slip_transmit(struct work_st
  */
 static void slip_write_wakeup(struct tty_struct *tty)
 {
-	struct slip *sl = tty->disc_data;
+	struct slip *sl;
+
+	rcu_read_lock();
+	sl = rcu_dereference(tty->disc_data);
+	if (!sl)
+		goto out;
 
 	schedule_work(&sl->tx_work);
+out:
+	rcu_read_unlock();
 }
 
 static void sl_tx_timeout(struct net_device *dev)
@@ -887,10 +894,11 @@ static void slip_close(struct tty_struct
 		return;
 
 	spin_lock_bh(&sl->lock);
-	tty->disc_data = NULL;
+	rcu_assign_pointer(tty->disc_data, NULL);
 	sl->tty = NULL;
 	spin_unlock_bh(&sl->lock);
 
+	synchronize_rcu();
 	flush_work(&sl->tx_work);
 
 	/* VSV = very important to remove timers */


