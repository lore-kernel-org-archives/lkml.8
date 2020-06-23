Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E8EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3BAA20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946202;
	bh=cEZ8sz7+sb3ad7uTTqXR6PsY7tAHH2fLQBrtuQCGpK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJil8qcrp1Rs64zT2iahyKmrTSg38PpmNXakvQ8FNGqRfiXWOnErFr34m0e+be0wb
	 vVj5aXEppt68dzUp9v18e38NyhwvcUI0fXoFXUS3Ovh0ZPwgx6CDUDkBifWtK4P1EE
	 O+0nLdenIZtndFtYMV4p3pDAqZlE+INKCqQel1Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbgFWVDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391978AbgFWUio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:38:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06512085B;
        Tue, 23 Jun 2020 20:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944724;
        bh=cEZ8sz7+sb3ad7uTTqXR6PsY7tAHH2fLQBrtuQCGpK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P31YHzW6qR3Sz9kDfKuBkbgLijQcMIzoAKcx0AqZS9IasA1Gus1GJlk2aS8TxMnzr
         Zlgx5JdaOdvujKLW60+7M6BGBexmR5Kk8keg28xxBuH8QRnOZDeP0LTFyi5tbJx885
         ua54sjnkdN0q5Z6R2oKWHec/YBsIDdow5FLX/cQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/206] ALSA: usb-audio: Fix racy list management in output queue
Date:   Tue, 23 Jun 2020 21:56:28 +0200
Message-Id: <20200623195319.919537541@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 5b6cc38f3f3f37109ce72b60bda215a5f6892c0b ]

The linked list entry from FIFO is peeked at
queue_pending_output_urbs() but the actual element pop-out is
performed outside the spinlock, and it's potentially racy.

Do delete the link at the right place inside the spinlock.

Fixes: 8fdff6a319e7 ("ALSA: snd-usb: implement new endpoint streaming model")
Link: https://lore.kernel.org/r/20200424074016.14301-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 36e255d889372..48611849b79b6 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -359,17 +359,17 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 			ep->next_packet_read_pos %= MAX_URBS;
 
 			/* take URB out of FIFO */
-			if (!list_empty(&ep->ready_playback_urbs))
+			if (!list_empty(&ep->ready_playback_urbs)) {
 				ctx = list_first_entry(&ep->ready_playback_urbs,
 					       struct snd_urb_ctx, ready_list);
+				list_del_init(&ctx->ready_list);
+			}
 		}
 		spin_unlock_irqrestore(&ep->lock, flags);
 
 		if (ctx == NULL)
 			return;
 
-		list_del_init(&ctx->ready_list);
-
 		/* copy over the length information */
 		for (i = 0; i < packet->packets; i++)
 			ctx->packet_size[i] = packet->packet_size[i];
-- 
2.25.1



