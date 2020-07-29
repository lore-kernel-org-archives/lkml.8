Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE41C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC98022BF3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZ7BTSBw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="We6VCptr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgG2Odb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2Od1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:27 -0400
Date:   Wed, 29 Jul 2020 14:33:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=t1J8270onhTTPuSHY3hWD9ArlzSCaBEaQPrHyRfd0uA=;
        b=NZ7BTSBwCqq/Vtj/m0ujvpgSK7ws9pnb0+75hvKg6706JpHd+IBtYFl/EgEMyZv4y4v3vt
        Wbyf8oxzyzvZ3sRUHzK77Um2MvpYg0ycIIqMUnziaMaWWtjy4brntyOWFXbucLCPH5NgzP
        /yUA4nPXIv/CC1nYSVNSPgg/j2P2inHOnVHWSTa5hsunk5sKioOsV4xC3qHJMk7KD31GB0
        m/CdRQIOTmMW26qtZvBSnmPCqNo3kXvIMYjhGOx3cxwVSfuZbNR9Qpjky69jI2F5EXIGK0
        IYyeY1vCjvwhhSD9sUIoc74o93BhxLQ/BxT7W8JGuyx4WCTkosDVOAS7lvJMxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=t1J8270onhTTPuSHY3hWD9ArlzSCaBEaQPrHyRfd0uA=;
        b=We6VCptrU58zt+XaiAnqVYMApktwPIlU35imIE+gveY0GVJJ4NF/wpmwqpsrJPTOoWv2L/
        ignd8oyechR0K1AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqcount: More consistent seqprop names
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159603320383.4006.8951996259705754037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b5e6a027bd327daa679ca55182a920659e2cbb90
Gitweb:        https://git.kernel.org/tip/b5e6a027bd327daa679ca55182a920659e2cbb90
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Jul 2020 12:11:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:30 +02:00

seqcount: More consistent seqprop names

Attempt uniformity and brevity.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/seqlock.h | 52 ++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 251dcd6..a076f78 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -247,9 +247,9 @@ SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
 	__seqprop_case((s),	mutex,		prop),			\
 	__seqprop_case((s),	ww_mutex,	prop))
 
-#define __to_seqcount_t(s)				__seqprop(s, ptr)
-#define __associated_lock_exists_and_is_preemptible(s)	__seqprop(s, preemptible)
-#define __assert_write_section_is_protected(s)		__seqprop(s, assert)
+#define __seqcount_ptr(s)		__seqprop(s, ptr)
+#define __seqcount_lock_preemptible(s)	__seqprop(s, preemptible)
+#define __seqcount_assert_lock_held(s)	__seqprop(s, assert)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
@@ -266,7 +266,7 @@ SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
  * Return: count to be passed to read_seqcount_retry()
  */
 #define __read_seqcount_begin(s)					\
-	__read_seqcount_t_begin(__to_seqcount_t(s))
+	__read_seqcount_t_begin(__seqcount_ptr(s))
 
 static inline unsigned __read_seqcount_t_begin(const seqcount_t *s)
 {
@@ -289,7 +289,7 @@ repeat:
  * Return: count to be passed to read_seqcount_retry()
  */
 #define raw_read_seqcount_begin(s)					\
-	raw_read_seqcount_t_begin(__to_seqcount_t(s))
+	raw_read_seqcount_t_begin(__seqcount_ptr(s))
 
 static inline unsigned raw_read_seqcount_t_begin(const seqcount_t *s)
 {
@@ -305,7 +305,7 @@ static inline unsigned raw_read_seqcount_t_begin(const seqcount_t *s)
  * Return: count to be passed to read_seqcount_retry()
  */
 #define read_seqcount_begin(s)						\
-	read_seqcount_t_begin(__to_seqcount_t(s))
+	read_seqcount_t_begin(__seqcount_ptr(s))
 
 static inline unsigned read_seqcount_t_begin(const seqcount_t *s)
 {
@@ -325,7 +325,7 @@ static inline unsigned read_seqcount_t_begin(const seqcount_t *s)
  * Return: count to be passed to read_seqcount_retry()
  */
 #define raw_read_seqcount(s)						\
-	raw_read_seqcount_t(__to_seqcount_t(s))
+	raw_read_seqcount_t(__seqcount_ptr(s))
 
 static inline unsigned raw_read_seqcount_t(const seqcount_t *s)
 {
@@ -353,7 +353,7 @@ static inline unsigned raw_read_seqcount_t(const seqcount_t *s)
  * Return: count to be passed to read_seqcount_retry()
  */
 #define raw_seqcount_begin(s)						\
-	raw_seqcount_t_begin(__to_seqcount_t(s))
+	raw_seqcount_t_begin(__seqcount_ptr(s))
 
 static inline unsigned raw_seqcount_t_begin(const seqcount_t *s)
 {
@@ -380,7 +380,7 @@ static inline unsigned raw_seqcount_t_begin(const seqcount_t *s)
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	__read_seqcount_t_retry(__to_seqcount_t(s), start)
+	__read_seqcount_t_retry(__seqcount_ptr(s), start)
 
 static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
@@ -400,7 +400,7 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	read_seqcount_t_retry(__to_seqcount_t(s), start)
+	read_seqcount_t_retry(__seqcount_ptr(s), start)
 
 static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
@@ -414,10 +414,10 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
-	if (__associated_lock_exists_and_is_preemptible(s))		\
+	if (__seqcount_lock_preemptible(s))				\
 		preempt_disable();					\
 									\
-	raw_write_seqcount_t_begin(__to_seqcount_t(s));			\
+	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
 } while (0)
 
 static inline void raw_write_seqcount_t_begin(seqcount_t *s)
@@ -433,9 +433,9 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
-	raw_write_seqcount_t_end(__to_seqcount_t(s));			\
+	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
 									\
-	if (__associated_lock_exists_and_is_preemptible(s))		\
+	if (__seqcount_lock_preemptible(s))				\
 		preempt_enable();					\
 } while (0)
 
@@ -456,12 +456,12 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
  */
 #define write_seqcount_begin_nested(s, subclass)			\
 do {									\
-	__assert_write_section_is_protected(s);				\
+	__seqcount_assert_lock_held(s);					\
 									\
-	if (__associated_lock_exists_and_is_preemptible(s))		\
+	if (__seqcount_lock_preemptible(s))				\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin_nested(__to_seqcount_t(s), subclass);	\
+	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
 } while (0)
 
 static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
@@ -483,12 +483,12 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
  */
 #define write_seqcount_begin(s)						\
 do {									\
-	__assert_write_section_is_protected(s);				\
+	__seqcount_assert_lock_held(s);					\
 									\
-	if (__associated_lock_exists_and_is_preemptible(s))		\
+	if (__seqcount_lock_preemptible(s))				\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin(__to_seqcount_t(s));			\
+	write_seqcount_t_begin(__seqcount_ptr(s));			\
 } while (0)
 
 static inline void write_seqcount_t_begin(seqcount_t *s)
@@ -504,9 +504,9 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
  */
 #define write_seqcount_end(s)						\
 do {									\
-	write_seqcount_t_end(__to_seqcount_t(s));			\
+	write_seqcount_t_end(__seqcount_ptr(s));			\
 									\
-	if (__associated_lock_exists_and_is_preemptible(s))		\
+	if (__seqcount_lock_preemptible(s))				\
 		preempt_enable();					\
 } while (0)
 
@@ -558,7 +558,7 @@ static inline void write_seqcount_t_end(seqcount_t *s)
  *      }
  */
 #define raw_write_seqcount_barrier(s)					\
-	raw_write_seqcount_t_barrier(__to_seqcount_t(s))
+	raw_write_seqcount_t_barrier(__seqcount_ptr(s))
 
 static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
 {
@@ -578,7 +578,7 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
  * will complete successfully and see data older than this.
  */
 #define write_seqcount_invalidate(s)					\
-	write_seqcount_t_invalidate(__to_seqcount_t(s))
+	write_seqcount_t_invalidate(__seqcount_ptr(s))
 
 static inline void write_seqcount_t_invalidate(seqcount_t *s)
 {
@@ -604,7 +604,7 @@ static inline void write_seqcount_t_invalidate(seqcount_t *s)
  * checked with read_seqcount_retry().
  */
 #define raw_read_seqcount_latch(s)					\
-	raw_read_seqcount_t_latch(__to_seqcount_t(s))
+	raw_read_seqcount_t_latch(__seqcount_ptr(s))
 
 static inline int raw_read_seqcount_t_latch(seqcount_t *s)
 {
@@ -695,7 +695,7 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
  *	patterns to manage the lifetimes of the objects within.
  */
 #define raw_write_seqcount_latch(s)					\
-	raw_write_seqcount_t_latch(__to_seqcount_t(s))
+	raw_write_seqcount_t_latch(__seqcount_ptr(s))
 
 static inline void raw_write_seqcount_t_latch(seqcount_t *s)
 {
