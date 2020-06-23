Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB98CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84C221531
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944698;
	bh=Jo0DEzc7e3bYZynA5ivPw4/ynVbfmur1H1zbgxYG1xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zxHCxkXoEtVar6lgwUCJFOwEtCM7ombgnojuClpQHJwGCftCCCBspl3GS5Zum7Qcm
	 xBsSvBsj/VSq+nvah5M5ufz1qX0YOhIX/4JccWvLNofE89zoP7+RShWGAHvQaCaii7
	 YnTvyC3CXpjgrLLbRkCY0J8ZsHDf7UMIzJuhvQW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391936AbgFWUiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391915AbgFWUiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:38:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2FE721556;
        Tue, 23 Jun 2020 20:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944686;
        bh=Jo0DEzc7e3bYZynA5ivPw4/ynVbfmur1H1zbgxYG1xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFDwwC9JV3YUifDMHgCYy5bCdUfI0BkSDY8ZeHLw2JTpxUTPP3yuU/yF9TO54UHLY
         Ko19oRG9dXuKcoV25HQ/mQAjOPw2FQMzfURq9SHLKOojTod/fWuIS3/EfhZMd4nZqE
         UzqKJjnZCWVXFWYvJc7PQlfvNJdIs+INIHlUPNJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 085/206] tty: n_gsm: Fix waking up upper tty layer when room available
Date:   Tue, 23 Jun 2020 21:56:53 +0200
Message-Id: <20200623195321.127276344@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 8d8229dd27961..166052002b79d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -665,7 +665,7 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
  *	FIXME: lock against link layer control transmissions
  */
 
-static void gsm_data_kick(struct gsm_mux *gsm)
+static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 {
 	struct gsm_msg *msg, *nmsg;
 	int len;
@@ -697,6 +697,24 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 
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
 
@@ -748,7 +766,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 	/* Add to the actual output queue */
 	list_add_tail(&msg->list, &gsm->tx_list);
 	gsm->tx_bytes += msg->len;
-	gsm_data_kick(gsm);
+	gsm_data_kick(gsm, dlci);
 }
 
 /**
@@ -1209,7 +1227,7 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		gsm_control_reply(gsm, CMD_FCON, NULL, 0);
 		/* Kick the link in case it is idling */
 		spin_lock_irqsave(&gsm->tx_lock, flags);
-		gsm_data_kick(gsm);
+		gsm_data_kick(gsm, NULL);
 		spin_unlock_irqrestore(&gsm->tx_lock, flags);
 		break;
 	case CMD_FCOFF:
@@ -2406,7 +2424,7 @@ static void gsmld_write_wakeup(struct tty_struct *tty)
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



