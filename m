Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084E6C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CD5206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pls08lAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgDUNbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729028AbgDUNbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:31:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC61C061A10;
        Tue, 21 Apr 2020 06:31:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u15so14005474ljd.3;
        Tue, 21 Apr 2020 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYmvXTH2U9X/kLI4SB3G7LElQgVq5vUD+vhvzA8snH8=;
        b=pls08lAH9GnLMCPYR5JJUgNdELDXYgRyz/95waeo2LwBEqcCLegYNbZeRGvABfW4ow
         bspu8yhvRQGzQx67QmvwPcvfyToHLBekjSH/yE5/1BUYQc6pxCby5DqsBXQ42eQvvLo0
         98/tFQjm1vHpMN/37zovgHD57ZBd/f/YywygpA6ToK4sJE92yTH4+equ8OJ/2niDSG42
         hcyDnUqASrIODZEU4a0G7amzvDhL+U9iXmc1vTvLPTLzsbkIDl59iHgVyoVhViC9BMKU
         ppE8IL+tJ1YRMJGIXhyndIPibLVBPMyg1I6Y9vuL8DgyPwWYcIZP87CG0UNI5+pSb4IA
         ycrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYmvXTH2U9X/kLI4SB3G7LElQgVq5vUD+vhvzA8snH8=;
        b=MpjBFRVQ15kzVk3jcYY6IK4wKYrd7+3fcQpik5VRRxU9PUvc+702dytqS83qYuuj9B
         pIAVzPESzlf32ABSc+/+ut59gtEaAQVmZBXXsSzKHabfFwZQWBG4Hi+G5ai/lLB8R4iC
         8dEoM8L+pPYZD+QNIEM7PONVF33z1klz89h+82m3Q3Ybmn3kzNApQVMmrN+gBq2dhtwD
         s/g5TWsr+DFw1aDRH/KDs0GH8pkvQjSuYAm91Ot0leWP+53D14O42ZB1taoI/BwgRUaw
         hj9r0g6Tg8rRcA4K6vixcb+NZiS8KaW+QXfDpwzgWgTFLQa7xQS9LYTQf7GPEnj26DQP
         0iUg==
X-Gm-Message-State: AGi0PuZ33uQD/kGaDZ8wRo8wwYB2bn5i2f/wHkR3PEawIaYLYvw4bdHx
        X3gxuBj2zf4Jx8bmUZusX3M=
X-Google-Smtp-Source: APiQypLQ+q+353TmB2FTptjg7QIJo/90BZs+BtC6KmcUS8ubqcLGhpHA/duszlhJs6Ld61a6KKiLfA==
X-Received: by 2002:a2e:b0ca:: with SMTP id g10mr13521662ljl.169.1587475864097;
        Tue, 21 Apr 2020 06:31:04 -0700 (PDT)
Received: from oak.local ([188.123.231.141])
        by smtp.gmail.com with ESMTPSA id v17sm2031456lfi.49.2020.04.21.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:31:03 -0700 (PDT)
From:   matwey.kornilov@gmail.com
To:     stern@rowland.harvard.edu, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:MUSB MULTIPOINT HIGH SPEED
        DUAL-ROLE CONTROLLER), linux-kernel@vger.kernel.org (open list)
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-usb@vger.kernel.org (open list:MUSB MULTIPOINT HIGH SPEED
        DUAL-ROLE CONTROLLER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 6/6] usb: musb: Decrease URB starting latency in musb_advance_schedule()
Date:   Tue, 21 Apr 2020 16:30:19 +0300
Message-Id: <20200421133019.27167-7-matwey.kornilov@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200421133019.27167-1-matwey.kornilov@gmail.com>
References: <20200421133019.27167-1-matwey.kornilov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matwey V. Kornilov" <matwey@sai.msu.ru>

Previously, the algorithm was the following:

 1. giveback current URB
 2. if current qh is not empty
    then start next URB
 3. if current qh is empty
    then dispose the qh, find next qh if any, and start URB.

It may take a while to run urb->callback inside URB giveback which is
run synchronously in musb. In order to improve the latency we rearrange
the function behaviour for the case when qh is not empty: next URB is
started before URB giveback. When qh is empty or current URB has an
error then the behaviour is intentionally kept in order
  a) not to break existing inter qh scheduling: URB giveback could
potentionally enqueue other URB to the empty qh preventing it from being
disposed;
  b) allow the class driver to cancel outstanding URBs in the queue.

Correct URB giveback order is guaranteed as the following. For each
qh there can be at most three ready URBs processing by the driver.
Indeed, every ready URB can send at most one URB in
musb_advance_schedule(), and in the worst case scenario we have the
following ready URBs:
  1) URB in the giveback lock protected section inside musb_giveback()
  2) URB waiting at the giveback lock acqusition in musb_giveback()
  3) URB waiting at the controller lock acqusition in the glue layer
     interrput handler
Here URB #2 and URB #3 are triggered by URB #1 and URB #2
correspondingly when they passed through musb_advance_schedule().
Since URB #3 is waiting before musb_advance_schedule(), no other new
URBs will be sent until URB#1 is finished, URB#2 goes to the giveback
lock protected section, and URB#3 goes to the controller lock protected
musb_advance_schedule().

Before this patch, time spent in urb->callback led to the following
glitches between the host and a hub during isoc transfer (line 4):

    11.624492 d=  0.000124 [130.6 +  1.050] [  4] SPLIT
    11.624492 d=  0.000000 [130.6 +  1.467] [  3] IN   : 3.5
    11.624493 d=  0.000000 [130.6 +  1.967] [ 37] DATA0: aa 08 [skipped...]
    11.625617 d=  0.001124 [131.7 +  1.050] [  4] SPLIT
    11.625617 d=  0.000000 [131.7 +  1.467] [  3] IN   : 3.5
    11.625867 d=  0.000250 [132.1 +  1.050] [  4] SPLIT
    11.625867 d=  0.000000 [132.1 +  1.467] [  3] IN   : 3.5
    11.625868 d=  0.000001 [132.1 +  1.983] [  3] DATA0: 00 00
    11.626617 d=  0.000749 [132.7 +  1.050] [  4] SPLIT
    11.626617 d=  0.000000 [132.7 +  1.467] [  3] IN   : 3.5
    11.626867 d=  0.000250 [133.1 +  1.050] [  4] SPLIT
    11.626867 d=  0.000000 [133.1 +  1.467] [  3] IN   : 3.5
    11.626868 d=  0.000000 [133.1 +  1.967] [  3] DATA0: 00 00

After the hub, they look as the following and may lead to broken
perepherial transfer (as in case of PWC based webcam):

    11.332004 d=  0.000997 [ 30.0 +  3.417] [  3] IN   : 5.5
    11.332007 d=  0.000003 [ 30.0 +  6.833] [800] DATA0: 8a 1c [skipped...]
    11.334004 d=  0.001997 [ 32.0 +  3.417] [  3] IN   : 5.5
    11.334007 d=  0.000003 [ 32.0 +  6.750] [  3] DATA0: 00 00
    11.335004 d=  0.000997 [ 33   +  3.417] [  3] IN   : 5.5
    11.335007 d=  0.000003 [ 33   +  6.750] [  3] DATA0: 00 00

Removing this glitches makes us able to successfully run 10fps
video stream from the webcam attached via USB hub. That was
previously impossible.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/usb/musb/musb_host.c | 36 ++++++++++++++++++++++++++++++++----
 drivers/usb/musb/musb_host.h |  1 +
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 46d9dd7d6f67..863f55907ddc 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -85,6 +85,11 @@ static bool musb_qh_empty(struct musb_qh *qh)
 	return list_empty(&qh->hep->urb_list);
 }
 
+static bool musb_qh_singular(struct musb_qh *qh)
+{
+	return list_is_singular(&qh->hep->urb_list);
+}
+
 static void musb_qh_unlink_hep(struct musb_qh *qh)
 {
 	if (!qh->hep)
@@ -301,15 +306,24 @@ musb_start_next_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 }
 
 /* Context: caller owns controller lock, IRQs are blocked */
-static void musb_giveback(struct musb *musb, struct urb *urb, int status)
+static void musb_giveback(struct musb *musb, struct musb_qh *qh, struct urb *urb, int status)
 __releases(musb->lock)
 __acquires(musb->lock)
 {
 	trace_musb_urb_gb(musb, urb);
 
+	/*
+	 * This line is protected by the controller lock: at most
+	 * one thread waiting on the giveback lock.
+	 */
+	spin_lock(&qh->giveback_lock);
 	usb_hcd_unlink_urb_from_ep(musb->hcd, urb);
+
 	spin_unlock(&musb->lock);
+
 	usb_hcd_giveback_urb(musb->hcd, urb, status);
+	spin_unlock(&qh->giveback_lock);
+
 	spin_lock(&musb->lock);
 }
 
@@ -344,8 +358,21 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 		break;
 	}
 
+	if (ready && !musb_qh_singular(qh) && !status) {
+		struct urb *next_urb = list_next_entry(urb, urb_list);
+
+		musb_dbg(musb, "... next ep%d %cX urb %p", hw_ep->epnum, is_in ? 'R' : 'T', next_urb);
+		musb_start_urb(musb, is_in, qh, next_urb);
+
+		qh->is_ready = 0;
+		musb_giveback(musb, qh, urb, status);
+		qh->is_ready = ready;
+
+		return;
+	}
+
 	qh->is_ready = 0;
-	musb_giveback(musb, urb, status);
+	musb_giveback(musb, qh, urb, status);
 	qh->is_ready = ready;
 
 	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
@@ -2174,6 +2201,7 @@ static int musb_urb_enqueue(
 	qh->hep = hep;
 	qh->dev = urb->dev;
 	INIT_LIST_HEAD(&qh->ring);
+	spin_lock_init(&qh->giveback_lock);
 	qh->is_ready = 1;
 
 	qh->maxpacket = usb_endpoint_maxp(epd);
@@ -2406,7 +2434,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		int	ready = qh->is_ready;
 
 		qh->is_ready = 0;
-		musb_giveback(musb, urb, 0);
+		musb_giveback(musb, qh, urb, 0);
 		qh->is_ready = ready;
 
 		/* If nothing else (usually musb_giveback) is using it
@@ -2465,7 +2493,7 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 		 * will activate any of these as it advances.
 		 */
 		while (!musb_qh_empty(qh))
-			musb_giveback(musb, next_urb(qh), -ESHUTDOWN);
+			musb_giveback(musb, qh, next_urb(qh), -ESHUTDOWN);
 
 		musb_qh_free(qh);
 	}
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 2999845632ce..6223b0177c68 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -19,6 +19,7 @@ struct musb_qh {
 	struct musb_hw_ep	*hw_ep;		/* current binding */
 
 	struct list_head	ring;		/* of musb_qh */
+	spinlock_t		giveback_lock;	/* to keep URB giveback order */
 	/* struct musb_qh		*next; */	/* for periodic tree */
 	u8			mux;		/* qh multiplexed to hw_ep */
 
-- 
2.25.0

