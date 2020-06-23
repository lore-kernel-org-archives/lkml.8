Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7E5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B46F20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947071;
	bh=7i/UUvq2ow8wHVnKokk+DClSu8XQ9EKsbnb7G8pQP90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N8cAufVKlSjo4EU/h18xyPwyIosZScPmaclWILYmKad19z8R4sz8c9wxadhHhHRN/
	 g5gOIn4hP4RD03lbO+r7R1OE7AHZVcrrv6g/rel1vmJn2HqjtRRjEUdbzMgSPbW03B
	 muahvDkvWVIxSzxxxc7wcRzuIDfAbEH5mmdt1MDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393421AbgFWVRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389149AbgFWU0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:26:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 223DF20702;
        Tue, 23 Jun 2020 20:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943994;
        bh=7i/UUvq2ow8wHVnKokk+DClSu8XQ9EKsbnb7G8pQP90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llNFSLyIHkCJVVPSjUM189Fg1BUCspCfQH9apj5GScBnJbLUoFWrfTEXjB2HoAjvh
         WKKPE6/tSXG03xs+gFp02sT7gOwD6aCHzDWQqO49mYm/JN0URAXQUem6CNuG1iSstI
         wlxfqtGOK3u1Y0Gr2Q3Ckymt/cfCDmz4GyLisXFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 100/314] ALSA: usb-audio: Fix racy list management in output queue
Date:   Tue, 23 Jun 2020 21:54:55 +0200
Message-Id: <20200623195343.630805044@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
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
index d8dc7cb56d43c..50104f658ed49 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -346,17 +346,17 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
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



