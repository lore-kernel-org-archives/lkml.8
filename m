Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784A7C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B832063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759268;
	bh=0vKhX8eqkC4hibNoWu6IOHcT8SXG4FHJa/n34WYhQYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QIixtmlHD7iC9EklyttZ5zsH8sda7/BYheoxPivyLDwzmmvsS0lHOBdTPBge4RmEM
	 M677m/7nQtTNUm9jJTxqe+46ar86tUQN+ZzvMNmpNJKTpLI+XCGQq41AKEy4Yyp2gp
	 9yJde6V+//3qTaDbvf4n0V7ZmMrT8UEvUxAq0URY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbgDAQlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389382AbgDAQk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:40:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF92217D8;
        Wed,  1 Apr 2020 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759257;
        bh=0vKhX8eqkC4hibNoWu6IOHcT8SXG4FHJa/n34WYhQYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEqTYyPLcN2J4yeJwLQotuKyaeUbU3jb9eyuV3EhMgyjHFzSkVM1RGPik2unEqBOX
         WnR+jGPY9PbQoVATbBh9aCqv6g/1DoAOpNck7/GKQpjAOjXBF5dsw1ok12eFq7fVG8
         o4aqJm91fjc0kOCNia0WaJfew7oAI9ZWtek7+WYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 023/148] ALSA: seq: oss: Fix running status after receiving sysex
Date:   Wed,  1 Apr 2020 18:16:55 +0200
Message-Id: <20200401161554.698558831@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
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


