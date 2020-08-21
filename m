Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A1AC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C082173E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598039250;
	bh=8xJ0F7JbD2VxF2kbGN+MXw9TdxCSx05LiKE9CoRfqKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=uQm/pZBb1p5v/aQEzBXN/4/TEGSPQTpfUfPVDNRdUvt17WAhyAFoUan2K7b/D/A2y
	 6Dqxf0n+FB03V1iSwjpMxzDHlMrxYqb/25LIRzsidL5YHKPRJJ/V3xn7Aav4Sh9Pno
	 CQFwxxhpTS6LeaLo9E0JV2Z3SxIq9nUHaYUB/qqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgHUTrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgHUTrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:47:09 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A30342076E;
        Fri, 21 Aug 2020 19:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598039228;
        bh=8xJ0F7JbD2VxF2kbGN+MXw9TdxCSx05LiKE9CoRfqKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=eTMkRU87bRSvnmgnc/fY78cBPJrPL5PoZqQe5avnCStmV8lGqte14CePOIJKig4Xg
         GeeFzux17WPw1fntGUADKoKfFxC0kXAwLx5IJtWI3E0MLLB/x119VeLsHcOKH5GXWP
         uTapAbHwfsBdoIa8l3rp/qL4OO+nf7peSx7aTsWM=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH RT 2/5] Bluetooth: Acquire sk_lock.slock without disabling interrupts
Date:   Fri, 21 Aug 2020 14:47:01 -0500
Message-Id: <964fd3a30eb7d0ac0c0f89f9f9a11c38bb8dfec9.1598039186.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598039186.git.zanussi@kernel.org>
References: <cover.1598039186.git.zanussi@kernel.org>
In-Reply-To: <cover.1598039186.git.zanussi@kernel.org>
References: <cover.1598039186.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.19.135-rt61-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit e6da0edc24eecef2f6964d92fa9044e1821deace ]

There was a lockdep which led to commit
   fad003b6c8e3d ("Bluetooth: Fix inconsistent lock state with RFCOMM")

Lockdep noticed that `sk->sk_lock.slock' was acquired without disabling
the softirq while the lock was also used in softirq context.
Unfortunately the solution back then was to disable interrupts before
acquiring the lock which however made lockdep happy.
It would have been enough to simply disable the softirq. Disabling
interrupts before acquiring a spinlock_t is not allowed on PREEMPT_RT
because these locks are converted to 'sleeping' spinlocks.

Use spin_lock_bh() in order to acquire the `sk_lock.slock'.

Reported-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>
Reported-by: kbuild test robot <lkp@intel.com> [missing unlock]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 net/bluetooth/rfcomm/sock.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index c044ff2f73e6..75bc8102cdd7 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -64,15 +64,13 @@ static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
 static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 {
 	struct sock *sk = d->owner, *parent;
-	unsigned long flags;
 
 	if (!sk)
 		return;
 
 	BT_DBG("dlc %p state %ld err %d", d, d->state, err);
 
-	local_irq_save(flags);
-	bh_lock_sock(sk);
+	spin_lock_bh(&sk->sk_lock.slock);
 
 	if (err)
 		sk->sk_err = err;
@@ -93,8 +91,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 		sk->sk_state_change(sk);
 	}
 
-	bh_unlock_sock(sk);
-	local_irq_restore(flags);
+	spin_unlock_bh(&sk->sk_lock.slock);
 
 	if (parent && sock_flag(sk, SOCK_ZAPPED)) {
 		/* We have to drop DLC lock here, otherwise
-- 
2.17.1

