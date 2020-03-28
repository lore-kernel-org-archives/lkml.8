Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304D6C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07055206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgC1M00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:26:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55761 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1M0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:26:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIAXa-0004vJ-V3; Sat, 28 Mar 2020 13:26:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 65CB91C03A9;
        Sat, 28 Mar 2020 13:26:18 +0100 (CET)
Date:   Sat, 28 Mar 2020 12:26:17 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a
 regular spinlock_t
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191118132824.rclhrbujqh4b4g4d@linutronix.de>
References: <20191118132824.rclhrbujqh4b4g4d@linutronix.de>
MIME-Version: 1.0
Message-ID: <158539837799.28353.10927555016769302958.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f1e67e355c2aafeddf1eac31335709236996d2fe
Gitweb:        https://git.kernel.org/tip/f1e67e355c2aafeddf1eac31335709236996d2fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 18 Nov 2019 14:28:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Mar 2020 13:21:08 +01:00

fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular spinlock_t

Bit spinlocks are problematic if PREEMPT_RT is enabled, because they
disable preemption, which is undesired for latency reasons and breaks when
regular spinlocks are taken within the bit_spinlock locked region because
regular spinlocks are converted to 'sleeping spinlocks' on RT.

PREEMPT_RT replaced the bit spinlocks with regular spinlocks to avoid this
problem. The replacement was done conditionaly at compile time, but
Christoph requested to do an unconditional conversion.

Jan suggested to move the spinlock into a existing padding hole which
avoids a size increase of struct buffer_head on production kernels.

As a benefit the lock gains lockdep coverage.

[ bigeasy: Remove the wrapper and use always spinlock_t and move it into
           the padding hole ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>
Link: https://lkml.kernel.org/r/20191118132824.rclhrbujqh4b4g4d@linutronix.de
---
 fs/buffer.c                 | 19 +++++++------------
 fs/ext4/page-io.c           |  8 +++-----
 fs/ntfs/aops.c              |  9 +++------
 include/linux/buffer_head.h |  6 +++---
 4 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b8d2837..6b34958 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -274,8 +274,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	 * decide that the page is now completely done.
 	 */
 	first = page_buffers(page);
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
+	spin_lock_irqsave(&first->b_uptodate_lock, flags);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -288,8 +287,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 
 	/*
 	 * If none of the buffers had errors and they are all
@@ -301,8 +299,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	return;
 
 still_busy:
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 	return;
 }
 
@@ -371,8 +368,7 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 	}
 
 	first = page_buffers(page);
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
+	spin_lock_irqsave(&first->b_uptodate_lock, flags);
 
 	clear_buffer_async_write(bh);
 	unlock_buffer(bh);
@@ -384,14 +380,12 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 		}
 		tmp = tmp->b_this_page;
 	}
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 	end_page_writeback(page);
 	return;
 
 still_busy:
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 	return;
 }
 EXPORT_SYMBOL(end_buffer_async_write);
@@ -3385,6 +3379,7 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags)
 	struct buffer_head *ret = kmem_cache_zalloc(bh_cachep, gfp_flags);
 	if (ret) {
 		INIT_LIST_HEAD(&ret->b_assoc_buffers);
+		spin_lock_init(&ret->b_uptodate_lock);
 		preempt_disable();
 		__this_cpu_inc(bh_accounting.nr);
 		recalc_bh_state();
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 68b39e7..de6fe96 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -125,11 +125,10 @@ static void ext4_finish_bio(struct bio *bio)
 		}
 		bh = head = page_buffers(page);
 		/*
-		 * We check all buffers in the page under BH_Uptodate_Lock
+		 * We check all buffers in the page under b_uptodate_lock
 		 * to avoid races with other end io clearing async_write flags
 		 */
-		local_irq_save(flags);
-		bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+		spin_lock_irqsave(&head->b_uptodate_lock, flags);
 		do {
 			if (bh_offset(bh) < bio_start ||
 			    bh_offset(bh) + bh->b_size > bio_end) {
@@ -141,8 +140,7 @@ static void ext4_finish_bio(struct bio *bio)
 			if (bio->bi_status)
 				buffer_io_error(bh);
 		} while ((bh = bh->b_this_page) != head);
-		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&head->b_uptodate_lock, flags);
 		if (!under_io) {
 			fscrypt_free_bounce_page(bounce_page);
 			end_page_writeback(page);
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 7202a1e..554b744 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -92,8 +92,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 				"0x%llx.", (unsigned long long)bh->b_blocknr);
 	}
 	first = page_buffers(page);
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
+	spin_lock_irqsave(&first->b_uptodate_lock, flags);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -108,8 +107,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 	/*
 	 * If none of the buffers had errors then we can set the page uptodate,
 	 * but we first have to perform the post read mst fixups, if the
@@ -142,8 +140,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	unlock_page(page);
 	return;
 still_busy:
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 	return;
 }
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7b73ef7..e0b020e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -22,9 +22,6 @@ enum bh_state_bits {
 	BH_Dirty,	/* Is dirty */
 	BH_Lock,	/* Is locked */
 	BH_Req,		/* Has been submitted for I/O */
-	BH_Uptodate_Lock,/* Used by the first bh in a page, to serialise
-			  * IO completion of other buffers in the page
-			  */
 
 	BH_Mapped,	/* Has a disk mapping */
 	BH_New,		/* Disk mapping was newly created by get_block */
@@ -76,6 +73,9 @@ struct buffer_head {
 	struct address_space *b_assoc_map;	/* mapping this buffer is
 						   associated with */
 	atomic_t b_count;		/* users using this buffer_head */
+	spinlock_t b_uptodate_lock;	/* Used by the first bh in a page, to
+					 * serialise IO completion of other
+					 * buffers in the page */
 };
 
 /*
