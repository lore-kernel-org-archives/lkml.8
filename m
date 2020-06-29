Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83643C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0DE207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461164;
	bh=5a4vMiA89yhb7XOQaVEtSlAjPYdcO6kAdT0WJKVbJVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=phRuZaKEH9GRJzY9rXDBoyV4CsucoZOWDXNNDXjFC3st+c6Zo6H95lpn4YrYSuRxJ
	 m2buugbUnX9kURBOhHEcSDiwEjBfHetnCO+T5mMPh+fMOVGnp+AI64iTEheKgznKvp
	 Yv08jADuW66q6pWfmVA8rWKdhIQsym24fwP0DBBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgF2UGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732968AbgF2Ta2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A01252FB;
        Mon, 29 Jun 2020 15:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445127;
        bh=5a4vMiA89yhb7XOQaVEtSlAjPYdcO6kAdT0WJKVbJVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CL4NGA/H4iu9of8W2N0iGxcM/a5yFDbsi6osvQVzx7Yiiu3suw7XFPqYVxW8j7/Wz
         mWbBAdpMvhutIJGwIgo53mVHKZ+05dYx4RDT51wkmHYpNB+dpxOyI/cujNSLi3Jq+V
         xFu+v28/81MtpjBmrXPY7Lboy5BoxkrjzdKf9hoI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Scheel <julian@jusst.de>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 34/78] ALSA: usb-audio: uac1: Invalidate ctl on interrupt
Date:   Mon, 29 Jun 2020 11:37:22 -0400
Message-Id: <20200629153806.2494953-35-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153806.2494953-1-sashal@kernel.org>
References: <20200629153806.2494953-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.186-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.186-rc1
X-KernelTest-Deadline: 2020-07-01T15:38+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Scheel <julian@jusst.de>

[ Upstream commit b2500b584cfd228d67e1e43daf27c8af865b499e ]

When an interrupt occurs, the value of at least one of the belonging
controls should have changed. To make sure they get re-read from device
on the next read, invalidate the cache. This was correctly implemented
for uac2 already, but missing for uac1.

Signed-off-by: Julian Scheel <julian@jusst.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index dbbc5609b453b..33deb5ec8b7a1 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2403,9 +2403,14 @@ void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid)
 {
 	struct usb_mixer_elem_list *list;
 
-	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem)
+	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem) {
+		struct usb_mixer_elem_info *info =
+			(struct usb_mixer_elem_info *)list;
+		/* invalidate cache, so the value is read from the device */
+		info->cached = 0;
 		snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
 			       &list->kctl->id);
+	}
 }
 
 static void snd_usb_mixer_dump_cval(struct snd_info_buffer *buffer,
-- 
2.25.1

