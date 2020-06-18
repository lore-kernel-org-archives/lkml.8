Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E229C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7E221D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443629;
	bh=ZHXm/Zfr+LPZhCMSLNZ/aEVe2ma6TnqweMHKim1xix8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EaCAsSe9ZJDrmE8cNtT/JPUEBKWpFcmrOyOufoQuPdY2B9OwyS+FS7AajZku12N7k
	 EpwHV6HWJE/Ara/XsHhTCdJtpwWT2f+JIJ333DEOwKdQqH7iewjT4ZNAsKNTUaAKaI
	 uJnOuMB84FdiOhf6OzoSDg6qIHbV5MeOXM10MZ8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbgFRB1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730566AbgFRBXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:23:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 462FE20776;
        Thu, 18 Jun 2020 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443424;
        bh=ZHXm/Zfr+LPZhCMSLNZ/aEVe2ma6TnqweMHKim1xix8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6mCVmBg51j/xjoLgAG63sAqB6Crdn3GQ//QLvmTTdqCFA6F5/tHwuM+UYSbHmJHk
         Q7yYnOnlQBv215nnxDm17ZhUWDU9WN0uNNAF7ywyZOEXkMd2Zgt5ecOYmwg7K8Y6Ps
         UyHV3xsM6E1dgH1z2aR4uKIGhkR9Zv1hsHD0vVXA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 065/172] ALSA: usb-audio: Fix racy list management in output queue
Date:   Wed, 17 Jun 2020 21:20:31 -0400
Message-Id: <20200618012218.607130-65-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 36e255d88937..48611849b79b 100644
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

