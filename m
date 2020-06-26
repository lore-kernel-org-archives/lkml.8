Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856B62081A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlFLionZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgFZNFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgFZNFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DECBC08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so9408017wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=daHyuJlZ21yTucBCriQSJRjQqcObN26/yVHvenxInRk=;
        b=HlFLionZgSOs6uB5R/XFj+QIIQ5tQl7fhImDsr1EeJhlVxOL9n404r1ANLopHwWtlY
         zywtHNZ54HiqUqgmPyiXkVySsIX4Hdk5SWXj59y9VIkehX/2bWPlhpcP7bkThFYisB7L
         aYoLNSR3p1LB8G0Ts1jI1ig5BPgz25+wFct97UzGfn349NuZSZqSwCDKY2W2oZlGBzV0
         YmvLsIPf7g1dPN95thFlze08d6GIffTkmWyjaxSaff6/6ReJBYwwFa4XTK8Y5ZeTsUPA
         dz6N/RJAHapYtB681ADXg6GWRBLyVeyCUflJ7MAVPiXKoqzUEY+U6C8hRybcrFPGTzfF
         p12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=daHyuJlZ21yTucBCriQSJRjQqcObN26/yVHvenxInRk=;
        b=jTZgGxEPhYncL4LCL2Oed8mkCZygHSQExCaS9b4PIxgCQM3hJ0VcrSgixMwATuQyv5
         H+/4acEdQIm6mS5NsgggjkcmoQhSfDuALcjs4eJwb6SE93iPF1+VXaZ8PiVbh833geor
         8jGlEVFnoiL/PWKVbviZmVgq5lrohXT89HbhqqnPesdZX0Cdy+fYvA05sN/FD2ER9+aI
         IFdKsVGusEsRh9EIqbHb78u2cBm7Y4ItpMNxwq3d8oVpoJE0xfFU3KfBFEWjbghnQnNL
         IGrr5Dpt50dOpIMai/EC+M55VtRMguWubPcXRLonqgylBfwuhfQjivFC9pnH3II5ZW8M
         tpsw==
X-Gm-Message-State: AOAM532TWhBk8XcvJbxJo8yC49EMlDxMNfP9w8ydPaaMqTLs8QnQtGVU
        CYxbnljuZPMOHC+CjCsxHOwTJQ==
X-Google-Smtp-Source: ABdhPJzdQdsAOHVLeNWM/Vp1yS4sRgT3xxrd2+IrFxsYUcMKcsL2YoQVIt2KlUvCS/9L2F4AxW13NQ==
X-Received: by 2002:adf:e90d:: with SMTP id f13mr3565068wrm.146.1593176731129;
        Fri, 26 Jun 2020 06:05:31 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pavan Savoy <pavan_savoy@ti.com>,
        Naveen Jain <naveen_jain@ti.com>
Subject: [PATCH 02/10] misc: ti-st: st_core: Tidy-up bespoke commentry
Date:   Fri, 26 Jun 2020 14:05:17 +0100
Message-Id: <20200626130525.389469-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626130525.389469-1-lee.jones@linaro.org>
References: <20200626130525.389469-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it's still in use and worth the effort, it sure looks like
this driver could do with a good scrub (clean).

This patch conserns itself with the non-standard comments located
thoughout the file.

It also fixes the following W=1 warnings by demoting the kerneldoc
function headers to standard comments, since there doesn't appear
to be a requirement for the function args to be documented:

 drivers/misc/ti-st/st_core.c:132: warning: Function parameter or member 'st_gdata' not described in 'st_reg_complete'
 drivers/misc/ti-st/st_core.c:132: warning: Function parameter or member 'err' not described in 'st_reg_complete'
 drivers/misc/ti-st/st_core.c:197: warning: Function parameter or member 'st_gdata' not described in 'st_wakeup_ack'
 drivers/misc/ti-st/st_core.c:197: warning: Function parameter or member 'cmd' not described in 'st_wakeup_ack'
 drivers/misc/ti-st/st_core.c:226: warning: Function parameter or member 'disc_data' not described in 'st_int_recv'
 drivers/misc/ti-st/st_core.c:226: warning: Function parameter or member 'data' not described in 'st_int_recv'
 drivers/misc/ti-st/st_core.c:226: warning: Function parameter or member 'count' not described in 'st_int_recv'
 drivers/misc/ti-st/st_core.c:387: warning: Function parameter or member 'st_gdata' not described in 'st_int_dequeue'
 drivers/misc/ti-st/st_core.c:409: warning: Function parameter or member 'st_gdata' not described in 'st_int_enqueue'
 drivers/misc/ti-st/st_core.c:409: warning: Function parameter or member 'skb' not described in 'st_int_enqueue'

Cc: Pavan Savoy <pavan_savoy@ti.com>
Cc: Naveen Jain <naveen_jain@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ti-st/st_core.c | 79 ++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 14136d2cc8f93..f4ddd1e670151 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -18,7 +18,8 @@
 
 extern void st_kim_recv(void *, const unsigned char *, long);
 void st_int_recv(void *, const unsigned char *, long);
-/* function pointer pointing to either,
+/*
+ * function pointer pointing to either,
  * st_kim_recv during registration to receive fw download responses
  * st_int_recv after registration to receive proto stack responses
  */
@@ -60,7 +61,8 @@ int st_get_uart_wr_room(struct st_data_s *st_gdata)
 	return tty->ops->write_room(tty);
 }
 
-/* can be called in from
+/*
+ * can be called in from
  * -- KIM (during fw download)
  * -- ST Core (during st_write)
  *
@@ -100,7 +102,8 @@ static void st_send_frame(unsigned char chnl_id, struct st_data_s *st_gdata)
 		kfree_skb(st_gdata->rx_skb);
 		return;
 	}
-	/* this cannot fail
+	/*
+	 * this cannot fail
 	 * this shouldn't take long
 	 * - should be just skb_queue_tail for the
 	 *   protocol stack driver
@@ -121,9 +124,8 @@ static void st_send_frame(unsigned char chnl_id, struct st_data_s *st_gdata)
 	return;
 }
 
-/**
- * st_reg_complete -
- * to call registration complete callbacks
+/*
+ * st_reg_complete - to call registration complete callbacks
  * of all protocol stack drivers
  * This function is being called with spin lock held, protocol drivers are
  * only expected to complete their waits and do nothing more than that.
@@ -156,21 +158,24 @@ static inline int st_check_data_len(struct st_data_s *st_gdata,
 	pr_debug("len %d room %d", len, room);
 
 	if (!len) {
-		/* Received packet has only packet header and
+		/*
+		 * Received packet has only packet header and
 		 * has zero length payload. So, ask ST CORE to
 		 * forward the packet to protocol driver (BT/FM/GPS)
 		 */
 		st_send_frame(chnl_id, st_gdata);
 
 	} else if (len > room) {
-		/* Received packet's payload length is larger.
+		/*
+		 * Received packet's payload length is larger.
 		 * We can't accommodate it in created skb.
 		 */
 		pr_err("Data length is too large len %d room %d", len,
 			   room);
 		kfree_skb(st_gdata->rx_skb);
 	} else {
-		/* Packet header has non-zero payload length and
+		/*
+		 * Packet header has non-zero payload length and
 		 * we have enough space in created skb. Lets read
 		 * payload data */
 		st_gdata->rx_state = ST_W4_DATA;
@@ -178,8 +183,7 @@ static inline int st_check_data_len(struct st_data_s *st_gdata,
 		return len;
 	}
 
-	/* Change ST state to continue to process next
-	 * packet */
+	/* Change ST state to continue to process next packet */
 	st_gdata->rx_state = ST_W4_PACKET_TYPE;
 	st_gdata->rx_skb = NULL;
 	st_gdata->rx_count = 0;
@@ -188,7 +192,7 @@ static inline int st_check_data_len(struct st_data_s *st_gdata,
 	return 0;
 }
 
-/**
+/*
  * st_wakeup_ack - internal function for action when wake-up ack
  *	received
  */
@@ -199,7 +203,8 @@ static inline void st_wakeup_ack(struct st_data_s *st_gdata,
 	unsigned long flags = 0;
 
 	spin_lock_irqsave(&st_gdata->lock, flags);
-	/* de-Q from waitQ and Q in txQ now that the
+	/*
+	 * de-Q from waitQ and Q in txQ now that the
 	 * chip is awake
 	 */
 	while ((waiting_skb = skb_dequeue(&st_gdata->tx_waitq)))
@@ -213,7 +218,7 @@ static inline void st_wakeup_ack(struct st_data_s *st_gdata,
 	st_tx_wakeup(st_gdata);
 }
 
-/**
+/*
  * st_int_recv - ST's internal receive function.
  *	Decodes received RAW data and forwards to corresponding
  *	client drivers (Bluetooth,FM,GPS..etc).
@@ -262,8 +267,10 @@ void st_int_recv(void *disc_data,
 			/* Waiting for complete packet ? */
 			case ST_W4_DATA:
 				pr_debug("Complete pkt received");
-				/* Ask ST CORE to forward
-				 * the packet to protocol driver */
+				/*
+				 * Ask ST CORE to forward
+				 * the packet to protocol driver
+				 */
 				st_send_frame(st_gdata->rx_chnl, st_gdata);
 
 				st_gdata->rx_state = ST_W4_PACKET_TYPE;
@@ -276,7 +283,7 @@ void st_int_recv(void *disc_data,
 				&st_gdata->rx_skb->data
 				[proto->offset_len_in_hdr];
 				pr_debug("plen pointing to %x\n", *plen);
-				if (proto->len_size == 1)/* 1 byte len field */
+				if (proto->len_size == 1) /* 1 byte len field */
 					payload_len = *(unsigned char *)plen;
 				else if (proto->len_size == 2)
 					payload_len =
@@ -294,18 +301,23 @@ void st_int_recv(void *disc_data,
 		}
 
 		/* end of if rx_count */
-		/* Check first byte of packet and identify module
-		 * owner (BT/FM/GPS) */
+
+		/*
+		 * Check first byte of packet and identify module
+		 * owner (BT/FM/GPS)
+		 */
 		switch (*ptr) {
 		case LL_SLEEP_IND:
 		case LL_SLEEP_ACK:
 		case LL_WAKE_UP_IND:
 			pr_debug("PM packet");
-			/* this takes appropriate action based on
+			/*
+			 * this takes appropriate action based on
 			 * sleep state received --
 			 */
 			st_ll_sleep_state(st_gdata, *ptr);
-			/* if WAKEUP_IND collides copy from waitq to txq
+			/*
+			 * if WAKEUP_IND collides copy from waitq to txq
 			 * and assume chip awake
 			 */
 			spin_unlock_irqrestore(&st_gdata->lock, flags);
@@ -331,7 +343,8 @@ void st_int_recv(void *disc_data,
 		default:
 			type = *ptr;
 
-			/* Default case means non-HCILL packets,
+			/*
+			 * Default case means non-HCILL packets,
 			 * possibilities are packets for:
 			 * (a) valid protocol -  Supported Protocols within
 			 *     the ST_MAX_CHANNELS.
@@ -377,7 +390,7 @@ void st_int_recv(void *disc_data,
 	return;
 }
 
-/**
+/*
  * st_int_dequeue - internal de-Q function.
  *	If the previous data set was not written
  *	completely, return that skb which has the pending data.
@@ -396,7 +409,7 @@ static struct sk_buff *st_int_dequeue(struct st_data_s *st_gdata)
 	return skb_dequeue(&st_gdata->txq);
 }
 
-/**
+/*
  * st_int_enqueue - internal Q-ing function.
  *	Will either Q the skb to txq or the tx_waitq
  *	depending on the ST LL state.
@@ -561,7 +574,8 @@ long st_register(struct st_proto_s *new_proto)
 		/* release lock previously held - re-locked below */
 		spin_unlock_irqrestore(&st_gdata->lock, flags);
 
-		/* this may take a while to complete
+		/*
+		 * this may take a while to complete
 		 * since it involves BT fw download
 		 */
 		err = st_kim_start(st_gdata->kim_data);
@@ -583,7 +597,8 @@ long st_register(struct st_proto_s *new_proto)
 		clear_bit(ST_REG_IN_PROGRESS, &st_gdata->st_state);
 		st_recv = st_int_recv;
 
-		/* this is where all pending registration
+		/*
+		 * this is where all pending registration
 		 * are signalled to be complete by calling callback functions
 		 */
 		if ((st_gdata->protos_registered != ST_EMPTY) &&
@@ -593,7 +608,8 @@ long st_register(struct st_proto_s *new_proto)
 		}
 		clear_bit(ST_REG_PENDING, &st_gdata->st_state);
 
-		/* check for already registered once more,
+		/*
+		 * check for already registered once more,
 		 * since the above check is old
 		 */
 		if (st_gdata->is_registered[new_proto->chnl_id] == true) {
@@ -622,7 +638,8 @@ long st_register(struct st_proto_s *new_proto)
 }
 EXPORT_SYMBOL_GPL(st_register);
 
-/* to unregister a protocol -
+/*
+ * to unregister a protocol -
  * to be called from protocol stack driver
  */
 long st_unregister(struct st_proto_s *proto)
@@ -742,7 +759,8 @@ static void st_tty_close(struct tty_struct *tty)
 
 	pr_info("%s ", __func__);
 
-	/* TODO:
+	/*
+	 * TODO:
 	 * if a protocol has been registered & line discipline
 	 * un-installed for some reason - what should be done ?
 	 */
@@ -795,7 +813,8 @@ static void st_tty_receive(struct tty_struct *tty, const unsigned char *data,
 	pr_debug("done %s", __func__);
 }
 
-/* wake-up function called in from the TTY layer
+/*
+ * wake-up function called in from the TTY layer
  * inside the internal wakeup function will be called
  */
 static void st_tty_wakeup(struct tty_struct *tty)
-- 
2.25.1

