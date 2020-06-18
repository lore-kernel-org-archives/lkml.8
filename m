Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB848C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B72120776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444127;
	bh=th7X71BqQW2FaajUKXQspd9Aq58319XeV8XowdC2hjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xqVokXGmJJ6Mc0UfccsY3n8xkVxurrsTlHQ7a45+kc6fHGIOMtqjkNNlNCOexlx6Y
	 dJyRl0KjijutsXt/3Nt5EEWS4oqAwXo6ITW6G51I2nsh19YY+N9IAqCss6pMWFtS9H
	 lrbdg+21wEc3xgzDUcDZPlqgjw2fFj+8DSb65lEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbgFRBbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbgFRB3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:29:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB8022208;
        Thu, 18 Jun 2020 01:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443743;
        bh=th7X71BqQW2FaajUKXQspd9Aq58319XeV8XowdC2hjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAJhjHOg+UnwxEi2J7dj8/yiiD3Wg0vHyaRMneV9b99yQ4I9kOhtnTGBAPK+RNOr+
         9nrecXrWGeQizWE6+EHQmCgA72VLf8iS5HobHBGV/MPvM9SirB2aQ/YxUVDP32WEhs
         W9PCCAj5Xz96PrIO/DBQrt6Uty24llTeMejmVT/0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.9 33/80] tty: hvc: Fix data abort due to race in hvc_open
Date:   Wed, 17 Jun 2020 21:27:32 -0400
Message-Id: <20200618012819.609778-33-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raghavendra Rao Ananta <rananta@codeaurora.org>

[ Upstream commit e2bd1dcbe1aa34ff5570b3427c530e4332ecf0fe ]

Potentially, hvc_open() can be called in parallel when two tasks calls
open() on /dev/hvcX. In such a scenario, if the hp->ops->notifier_add()
callback in the function fails, where it sets the tty->driver_data to
NULL, the parallel hvc_open() can see this NULL and cause a memory abort.
Hence, serialize hvc_open and check if tty->private_data is NULL before
proceeding ahead.

The issue can be easily reproduced by launching two tasks simultaneously
that does nothing but open() and close() on /dev/hvcX.
For example:
$ ./simple_open_close /dev/hvc0 & ./simple_open_close /dev/hvc0 &

Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
Link: https://lore.kernel.org/r/20200428032601.22127-1-rananta@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/hvc/hvc_console.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 985f49a65906..35d591287734 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -89,6 +89,8 @@ static LIST_HEAD(hvc_structs);
  */
 static DEFINE_SPINLOCK(hvc_structs_lock);
 
+/* Mutex to serialize hvc_open */
+static DEFINE_MUTEX(hvc_open_mutex);
 /*
  * This value is used to assign a tty->index value to a hvc_struct based
  * upon order of exposure via hvc_probe(), when we can not match it to
@@ -333,16 +335,24 @@ static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
  */
 static int hvc_open(struct tty_struct *tty, struct file * filp)
 {
-	struct hvc_struct *hp = tty->driver_data;
+	struct hvc_struct *hp;
 	unsigned long flags;
 	int rc = 0;
 
+	mutex_lock(&hvc_open_mutex);
+
+	hp = tty->driver_data;
+	if (!hp) {
+		rc = -EIO;
+		goto out;
+	}
+
 	spin_lock_irqsave(&hp->port.lock, flags);
 	/* Check and then increment for fast path open. */
 	if (hp->port.count++ > 0) {
 		spin_unlock_irqrestore(&hp->port.lock, flags);
 		hvc_kick();
-		return 0;
+		goto out;
 	} /* else count == 0 */
 	spin_unlock_irqrestore(&hp->port.lock, flags);
 
@@ -370,6 +380,8 @@ static int hvc_open(struct tty_struct *tty, struct file * filp)
 	/* Force wakeup of the polling thread */
 	hvc_kick();
 
+out:
+	mutex_unlock(&hvc_open_mutex);
 	return rc;
 }
 
-- 
2.25.1

