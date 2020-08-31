Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13817C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FB720782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ow6EptzT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JUAmwanj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHaBLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:11:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgHaBLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:11:03 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598836261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0z0EV3OyzsvpcpcaBUSJGgPwnnJ4KzYgkOsTiLxoQMo=;
        b=Ow6EptzTrKwqHrsYJrZA9o0HeMwJJ+XZerEzbOh7tCbZfoBcmPBJJ9hbMDfZ50AQPfWmla
        FNqkQSKR7KM9uDhgDH3x/YEw4woRKrK+NWkeXWePUiwKEA2zdIUqfb2/589meCzB7lL3uX
        WcSXfkwr24IjExM1SX1txiCzs1Th4pUJTqcL/XhY4IapqTWcZwni8Uh9xgb1nZRIfOhOHS
        SM+/gewkLBE1q45wS8bD1qP+SkyvFs9yB4jvrKszd3jXne1jbmEFKiPUJ4JM6BRAjRSZk4
        NMt0X+TYrl/wFVsnBk1oUxnF4v4lzIL4Qo7t32P6YTxqKxvtRP+yEJo3FWyHPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598836261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0z0EV3OyzsvpcpcaBUSJGgPwnnJ4KzYgkOsTiLxoQMo=;
        b=JUAmwanjx5WCMf2qz1mKgA+Tj0EeTNChRbtr8jPdh/retT57RnFMzeYZ+bbUyDLjEOBp7L
        gEIayj82CWtPUfCQ==
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
Subject: [PATCH next v3 3/8] printk: ringbuffer: relocate get_data()
Date:   Mon, 31 Aug 2020 03:16:53 +0206
Message-Id: <20200831011058.6286-4-john.ogness@linutronix.de>
In-Reply-To: <20200831011058.6286-1-john.ogness@linutronix.de>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the internal get_data() function as-is above prb_reserve() so
that a later change can make use of the static function.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 116 +++++++++++++++---------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d339ff7647da..86af38c2cf77 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1038,6 +1038,64 @@ static unsigned int space_used(struct prb_data_ring *data_ring,
 		DATA_SIZE(data_ring) - DATA_INDEX(data_ring, blk_lpos->begin));
 }
 
+/*
+ * Given @blk_lpos, return a pointer to the writer data from the data block
+ * and calculate the size of the data part. A NULL pointer is returned if
+ * @blk_lpos specifies values that could never be legal.
+ *
+ * This function (used by readers) performs strict validation on the lpos
+ * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
+ * triggered if an internal error is detected.
+ */
+static const char *get_data(struct prb_data_ring *data_ring,
+			    struct prb_data_blk_lpos *blk_lpos,
+			    unsigned int *data_size)
+{
+	struct prb_data_block *db;
+
+	/* Data-less data block description. */
+	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {
+		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
+			*data_size = 0;
+			return "";
+		}
+		return NULL;
+	}
+
+	/* Regular data block: @begin less than @next and in same wrap. */
+	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
+	    blk_lpos->begin < blk_lpos->next) {
+		db = to_block(data_ring, blk_lpos->begin);
+		*data_size = blk_lpos->next - blk_lpos->begin;
+
+	/* Wrapping data block: @begin is one wrap behind @next. */
+	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
+		   DATA_WRAPS(data_ring, blk_lpos->next)) {
+		db = to_block(data_ring, 0);
+		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
+
+	/* Illegal block description. */
+	} else {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
+	/* A valid data block will always be aligned to the ID size. */
+	if (WARN_ON_ONCE(blk_lpos->begin != ALIGN(blk_lpos->begin, sizeof(db->id))) ||
+	    WARN_ON_ONCE(blk_lpos->next != ALIGN(blk_lpos->next, sizeof(db->id)))) {
+		return NULL;
+	}
+
+	/* A valid data block will always have at least an ID. */
+	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
+		return NULL;
+
+	/* Subtract block ID space from size to reflect data size. */
+	*data_size -= sizeof(db->id);
+
+	return &db->data[0];
+}
+
 /**
  * prb_reserve() - Reserve space in the ringbuffer.
  *
@@ -1192,64 +1250,6 @@ void prb_commit(struct prb_reserved_entry *e)
 	local_irq_restore(e->irqflags);
 }
 
-/*
- * Given @blk_lpos, return a pointer to the writer data from the data block
- * and calculate the size of the data part. A NULL pointer is returned if
- * @blk_lpos specifies values that could never be legal.
- *
- * This function (used by readers) performs strict validation on the lpos
- * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
- * triggered if an internal error is detected.
- */
-static const char *get_data(struct prb_data_ring *data_ring,
-			    struct prb_data_blk_lpos *blk_lpos,
-			    unsigned int *data_size)
-{
-	struct prb_data_block *db;
-
-	/* Data-less data block description. */
-	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {
-		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
-			*data_size = 0;
-			return "";
-		}
-		return NULL;
-	}
-
-	/* Regular data block: @begin less than @next and in same wrap. */
-	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
-	    blk_lpos->begin < blk_lpos->next) {
-		db = to_block(data_ring, blk_lpos->begin);
-		*data_size = blk_lpos->next - blk_lpos->begin;
-
-	/* Wrapping data block: @begin is one wrap behind @next. */
-	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
-		   DATA_WRAPS(data_ring, blk_lpos->next)) {
-		db = to_block(data_ring, 0);
-		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
-
-	/* Illegal block description. */
-	} else {
-		WARN_ON_ONCE(1);
-		return NULL;
-	}
-
-	/* A valid data block will always be aligned to the ID size. */
-	if (WARN_ON_ONCE(blk_lpos->begin != ALIGN(blk_lpos->begin, sizeof(db->id))) ||
-	    WARN_ON_ONCE(blk_lpos->next != ALIGN(blk_lpos->next, sizeof(db->id)))) {
-		return NULL;
-	}
-
-	/* A valid data block will always have at least an ID. */
-	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
-		return NULL;
-
-	/* Subtract block ID space from size to reflect data size. */
-	*data_size -= sizeof(db->id);
-
-	return &db->data[0];
-}
-
 /*
  * Count the number of lines in provided text. All text has at least 1 line
  * (even if @text_size is 0). Each '\n' processed is counted as an additional
-- 
2.20.1

