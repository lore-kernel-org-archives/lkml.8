Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9476AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A79420775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055580;
	bh=0vKhX8eqkC4hibNoWu6IOHcT8SXG4FHJa/n34WYhQYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nv3vmI9eggYr/9VPzeNfltiVuWxOc3JuPQGFw6gKbO6RG+Dro/upi3JP7gamvpAVO
	 /NP26PSVpgKDV+ZsawezpxTlqkbbER1NMivgQpTWmkO7dqkxa+5JzEvboSLw43KVHX
	 W31/yQqRtof1NPNCwFJyquOuShtyMWBoYYmt8mls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgCXNM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbgCXNMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:12:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650E2208CA;
        Tue, 24 Mar 2020 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055574;
        bh=0vKhX8eqkC4hibNoWu6IOHcT8SXG4FHJa/n34WYhQYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjFOJ4qoeDnohWikn5fUzR3gqjC2A3pHolAvLKVBogQQC0Ss3LK4aAM6j4jQmWG8u
         rMUE02OERKCvHOFjcxjKe6YPqHpcpz0uqpypKOvooys2roKfQ5fG0LJGcyT1pFkzvi
         F0L1fns4pLeDcipxogEmDAjqDAAYjPObboE1aM0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 28/65] ALSA: seq: oss: Fix running status after receiving sysex
Date:   Tue, 24 Mar 2020 14:10:49 +0100
Message-Id: <20200324130800.803603283@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 6c3171ef76a0bad892050f6959a7eac02fb16df7 upstream.

This is a similar bug like the previous case for virmidi: the invalid
running status is kept after receiving a sysex message.

Again the fix is to clear the running status after handling the sysex.

Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/3b4a4e0f232b7afbaf0a843f63d0e538e3029bfd.camel@domdv.de
Link: https://lore.kernel.org/r/20200316090506.23966-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/oss/seq_oss_midi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -615,6 +615,7 @@ send_midi_event(struct seq_oss_devinfo *
 		len = snd_seq_oss_timer_start(dp->timer);
 	if (ev->type == SNDRV_SEQ_EVENT_SYSEX) {
 		snd_seq_oss_readq_sysex(dp->readq, mdev->seq_device, ev);
+		snd_midi_event_reset_decode(mdev->coder);
 	} else {
 		len = snd_midi_event_decode(mdev->coder, msg, sizeof(msg), ev);
 		if (len > 0)


