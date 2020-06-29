Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10808C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFDC206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465077;
	bh=/sxvIWXyWXMgUn+hUmKJH6X+uguGxYiWi7hE7loHJZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rjXeZAVIUWrIx8FqXljeI6N462eumI9KLXefH13cNZ9fwOApdYN6KnGdgjwtPkb8O
	 0bbE9yo0wsp7VFgAMCnk9r3hnxKjPrD9k/JRypBbumnEpMpbn0HPdoYNILvgv6TFMJ
	 vC8qrzy8unFq0HtJWyutcNfNnE74TcjyX5Am+7dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390396AbgF2VLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgF2TAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9338B254CF;
        Mon, 29 Jun 2020 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446026;
        bh=/sxvIWXyWXMgUn+hUmKJH6X+uguGxYiWi7hE7loHJZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zpe+dYE1iPQQ61dRld04IuuL1e3v5dnpXKaGdgJQ40oTvO8G69bhhcDev1QxsZu9n
         2uOLAd+QhmO76KcUjSS47QXxY5+LoDQHNQTlw8n8JXlzKi7/1CF6cc3+dKhI/i2Cd5
         oa+sVyJspTkCDKnro99WXKBl8AO75nTL+q4dprNo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 032/135] tty: n_gsm: Fix waking up upper tty layer when room available
Date:   Mon, 29 Jun 2020 11:51:26 -0400
Message-Id: <20200629155309.2495516-33-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>

[ Upstream commit 01dbb362f0a114fbce19c8abe4cd6f4710e934d5 ]

Warn the upper layer when n_gms is ready to receive data
again. Without this the associated virtual tty remains blocked
indefinitely.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20200512115323.1447922-4-gregory.clement@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/n_gsm.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 08aaf993221e7..0020de4fe66f5 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -681,7 +681,7 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
  *	FIXME: lock against link layer control transmissions
  */
 
-static void gsm_data_kick(struct gsm_mux *gsm)
+static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 {
 	struct gsm_msg *msg, *nmsg;
 	int len;
@@ -713,6 +713,24 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 
 		list_del(&msg->list);
 		kfree(msg);
+
+		if (dlci) {
+			tty_port_tty_wakeup(&dlci->port);
+		} else {
+			int i = 0;
+
+			for (i = 0; i < NUM_DLCI; i++) {
+				struct gsm_dlci *dlci;
+
+				dlci = gsm->dlci[i];
+				if (dlci == NULL) {
+					i++;
+					continue;
+				}
+
+				tty_port_tty_wakeup(&dlci->port);
+			}
+		}
 	}
 }
 
@@ -764,7 +782,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 	/* Add to the actual output queue */
 	list_add_tail(&msg->list, &gsm->tx_list);
 	gsm->tx_bytes += msg->len;
-	gsm_data_kick(gsm);
+	gsm_data_kick(gsm, dlci);
 }
 
 /**
@@ -1225,7 +1243,7 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		gsm_control_reply(gsm, CMD_FCON, NULL, 0);
 		/* Kick the link in case it is idling */
 		spin_lock_irqsave(&gsm->tx_lock, flags);
-		gsm_data_kick(gsm);
+		gsm_data_kick(gsm, NULL);
 		spin_unlock_irqrestore(&gsm->tx_lock, flags);
 		break;
 	case CMD_FCOFF:
@@ -2423,7 +2441,7 @@ static void gsmld_write_wakeup(struct tty_struct *tty)
 	/* Queue poll */
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	spin_lock_irqsave(&gsm->tx_lock, flags);
-	gsm_data_kick(gsm);
+	gsm_data_kick(gsm, NULL);
 	if (gsm->tx_bytes < TX_THRESH_LO) {
 		gsm_dlci_data_sweep(gsm);
 	}
-- 
2.25.1

