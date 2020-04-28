Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DA1C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C231C206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BpWwlj6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgD1D0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:26:11 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:31914 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgD1D0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:26:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588044371; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=uBTJbgxt0fS4b6DB2Cfh8WGOYVEJj4RGd0cXafUjCe4=; b=BpWwlj6TVAukMv+1XeV+Ck3tyIaU7UlKD6pMHQbSxXo06Myg6PRzfApIMrQ3rVcQ75WERHe8
 GqEwCq3M0iLu6sIc0JQX8Z1A8Xa5LE5lkvxsqg1vKvn/GQ9rvssY56UHKfRzgp/P0SHO03sz
 cZtCYclX2McSRmXUYkwK/ngrWF8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7a252.7f9baf9c7bc8-smtp-out-n01;
 Tue, 28 Apr 2020 03:26:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7BF7FC43637; Tue, 28 Apr 2020 03:26:10 +0000 (UTC)
Received: from rananta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rananta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84D46C433D2;
        Tue, 28 Apr 2020 03:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84D46C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rananta@codeaurora.org
From:   Raghavendra Rao Ananta <rananta@codeaurora.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, andrew@daynix.com
Cc:     rananta@codeaurora.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: hvc: Fix data abort due to race in hvc_open
Date:   Mon, 27 Apr 2020 20:26:01 -0700
Message-Id: <20200428032601.22127-1-rananta@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/tty/hvc/hvc_console.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 436cc51c92c3..ebe26fe5ac09 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -75,6 +75,8 @@ static LIST_HEAD(hvc_structs);
  */
 static DEFINE_MUTEX(hvc_structs_mutex);
 
+/* Mutex to serialize hvc_open */
+static DEFINE_MUTEX(hvc_open_mutex);
 /*
  * This value is used to assign a tty->index value to a hvc_struct based
  * upon order of exposure via hvc_probe(), when we can not match it to
@@ -346,16 +348,24 @@ static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
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
 
@@ -384,6 +394,8 @@ static int hvc_open(struct tty_struct *tty, struct file * filp)
 	/* Force wakeup of the polling thread */
 	hvc_kick();
 
+out:
+	mutex_unlock(&hvc_open_mutex);
 	return rc;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
