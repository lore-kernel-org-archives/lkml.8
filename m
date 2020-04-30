Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22760C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060B92076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD3LfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:35:17 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49595 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgD3LfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:35:09 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 66E6B1C000A;
        Thu, 30 Apr 2020 11:35:07 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 3/3] tty: n_gsm: Fix waking up upper tty layer when room available
Date:   Thu, 30 Apr 2020 13:34:33 +0200
Message-Id: <20200430113433.2162886-5-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430113433.2162886-1-gregory.clement@bootlin.com>
References: <20200430113433.2162886-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn the upper layer when n_gms is ready to receive data
again. Without this the associated virtual tty remain blocked
indefinitely.

Fixes: 96fd7ce58ffb ("TTY: create drivers/tty and move the tty core files there")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/tty/n_gsm.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 58950b33e5ac..4ff2b981aa7e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -665,10 +665,12 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
  *	FIXME: lock against link layer control transmissions
  */
 
-static void gsm_data_kick(struct gsm_mux *gsm)
+static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 {
 	struct gsm_msg *msg, *nmsg;
 	int len;
+	struct tty_struct *tty_dlci = NULL;
+
 
 	list_for_each_entry_safe(msg, nmsg, &gsm->tx_list, list) {
 		if (gsm->constipated && msg->addr)
@@ -697,6 +699,29 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 
 		list_del(&msg->list);
 		kfree(msg);
+
+		if (dlci) {
+			tty_dlci = tty_port_tty_get(&dlci->port);
+			if (tty_dlci)
+				tty_wakeup(tty_dlci);
+		} else {
+			int i = 0;
+
+			while (i < NUM_DLCI) {
+				struct gsm_dlci *dlci;
+
+				dlci = gsm->dlci[i];
+				if (dlci == NULL) {
+					i++;
+					continue;
+				}
+
+				tty_dlci = tty_port_tty_get(&dlci->port);
+				if (tty_dlci)
+					tty_wakeup(tty_dlci);
+				i++;
+			}
+		}
 	}
 }
 
@@ -748,7 +773,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 	/* Add to the actual output queue */
 	list_add_tail(&msg->list, &gsm->tx_list);
 	gsm->tx_bytes += msg->len;
-	gsm_data_kick(gsm);
+	gsm_data_kick(gsm, dlci);
 }
 
 /**
@@ -1209,7 +1234,7 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		gsm_control_reply(gsm, CMD_FCON, NULL, 0);
 		/* Kick the link in case it is idling */
 		spin_lock_irqsave(&gsm->tx_lock, flags);
-		gsm_data_kick(gsm);
+		gsm_data_kick(gsm, NULL);
 		spin_unlock_irqrestore(&gsm->tx_lock, flags);
 		break;
 	case CMD_FCOFF:
@@ -2531,7 +2556,7 @@ static void gsmld_write_wakeup(struct tty_struct *tty)
 	/* Queue poll */
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	spin_lock_irqsave(&gsm->tx_lock, flags);
-	gsm_data_kick(gsm);
+	gsm_data_kick(gsm, NULL);
 	if (gsm->tx_bytes < TX_THRESH_LO) {
 		gsm_dlci_data_sweep(gsm);
 	}
-- 
2.26.1

