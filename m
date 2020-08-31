Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712EBC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4360A2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KH5RYJxE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="trjyE6zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgHaMzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:55:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32896 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgHaMzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:55:02 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598878499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lGQo9hpe0trotAopSA3xK5zyymKFzRu3IY6OsteBVw=;
        b=KH5RYJxEhBfNp3QQhWr+jY1sWpj/IDdbg7iuv0dIaiGTfbu02cn4BjJQMIua7hNtctzojS
        zO/ZaY4y3251+Z7SI/KrdFhbiYH8/4+TW16RfQzSzbzUOFk6SACN1DCza1xCET8qmjXNcz
        rL9C4UrRrmATY/MuUVPr/lwIw+5Q/cJKdDPIPdbpi5oaD8gejKCEBg0PgP/EYSm7LbDlsi
        xXUDGVQYTUTl+Zq0UlHClsDq95flcs5UOiJ5pSOOy4l95ijZj3ccUkfoRTwYzhcGs+eB3W
        9fZ0FG99sexxgHcx2nhWHliOswFvDYl0UNHQIQcDZeV4N99c0duGgDu9tf0anA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598878499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lGQo9hpe0trotAopSA3xK5zyymKFzRu3IY6OsteBVw=;
        b=trjyE6zxysZzqAhklw2Z09gDNbz7Fjng/xL093ahrRYgdIe9Nz/RuS5zTgE21+Mhj7pdT8
        WpNgwr2ME00vkwCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3 6/8] printk: ringbuffer: add finalization/extension support
In-Reply-To: <20200831011058.6286-7-john.ogness@linutronix.de>
References: <20200831011058.6286-1-john.ogness@linutronix.de> <20200831011058.6286-7-john.ogness@linutronix.de>
Date:   Mon, 31 Aug 2020 15:00:58 +0206
Message-ID: <878sdvq8kd.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This critical piece was missing from patch 6...


From 0b745d507f0c38e6d1612ed9468aa52845ca025b Mon Sep 17 00:00:00 2001
From: John Ogness <john.ogness@linutronix.de>
Date: Mon, 31 Aug 2020 14:45:40 +0206
Subject: [PATCH] printk: ringbuffer: allow reading consistent descriptors

desc_read() will fail to read if a descriptor is in the desc_reserved
queried state because such data would be inconsistent. However, since
("printk: ringbuffer: add finalization/extension support") the
desc_reserved state can have the DESC_COMMIT_MASK flag set, in which
case it _is_ consistent. And indeed, desc_reopen_last() is expecting
a read in this case.

Allow desc_read() to read desc_reserved descriptors if the
DESC_COMMIT_MASK flag is set.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reported-by: Andy Lavr <andy.lavr@gmail.com>
Fixes: ("printk: ringbuffer: add finalization/extension support")
---
 kernel/printk/printk_ringbuffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 0731d5e2dddd..6ba7d3fc96f1 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -446,8 +446,10 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	/* Check the descriptor state. */
 	state_val = atomic_long_read(state_var); /* LMM(desc_read:A) */
 	d_state = get_desc_state(id, state_val);
-	if (d_state != desc_committed && d_state != desc_reusable)
+	if (d_state == desc_miss ||
+	    (d_state == desc_reserved && !(state_val & DESC_COMMIT_MASK))) {
 		return d_state;
+	}
 
 	/*
 	 * Guarantee the state is loaded before copying the descriptor
-- 
2.20.1
