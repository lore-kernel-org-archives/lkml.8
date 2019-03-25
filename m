Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47277C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3FF2073E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgC1QnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:16 -0400
Received: from mx.sdf.org ([205.166.94.20]:50248 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgC1QnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:15 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhCw4016539
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:12 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhC3b019313;
        Sat, 28 Mar 2020 16:43:12 GMT
Message-Id: <202003281643.02SGhC3b019313@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Mon, 25 Mar 2019 14:24:48 -0400
Subject: [RFC PATCH v1 15/50] drivers/block/drbd/drbd_main: fix
 _drbd_fault_random()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@tron.linbit.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal PRNG had numerous problems:

* Since the last operation in this function truncates the
  return value to 32 bits, there's no point maintaining
  a 64-bit state and doing 64-bit math.  (The msbits have
  no effect on the return value.)
* Use prandom_u32() rather than get_random_bytes().  If
  we're using an even crappier PRNG, we don't need
  crypto-quality seeds.
* Since the function is reseeded from a non-deterministic
  source periodically, the output isn't repeatable, so it's
  okay to change the algorithm.
* The multiplier used (39916801) is bad.  Multipliers must
  be == 1 (mod 4) for maximum period, which this is, but
  should also be == 5 (mod 8) which this is not.  Replace it
  with a multiplier chosen from a published list as having
  good lattice structure on the spectral test.
* The additive constant is unnecessarily complex.  Any odd
  number is as as good as another, so just use 1.
* The "% 100" output transformation is unnecessarily
  expensive.  Use multiplicative range reduction instead,
  which is significantly faster.
* Multiplicative range reduction also avoids the problems
  with the low-order bits which modulo-2^n LCGs are subject
  to.  Thus, the final "swahw32" may be omitted from
  _drbd_fault_random().

* Also, use get_random_u64() in drbd_uuid_new_current().
  That's still crypto-quality, but we don't need
  get_random_bytes().

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
---
 drivers/block/drbd/drbd_main.c | 37 +++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a18155cdce416..2bd5e84a18dd6 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3483,11 +3483,9 @@ void drbd_uuid_set(struct drbd_device *device, int idx, u64 val) __must_hold(loc
  */
 void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local)
 {
-	u64 val;
+	u64 val = get_random_u64();
 	unsigned long long bm_uuid;
 
-	get_random_bytes(&val, sizeof(u64));
-
 	spin_lock_irq(&device->ldev->md.uuid_lock);
 	bm_uuid = device->ldev->md.uuid[UI_BITMAP];
 
@@ -3834,30 +3832,37 @@ void unlock_all_resources(void)
 /* Fault insertion support including random number generator shamelessly
  * stolen from kernel/rcutorture.c */
 struct fault_random_state {
-	unsigned long state;
-	unsigned long count;
+	u32 state;
+	unsigned int count;
 };
 
-#define FAULT_RANDOM_MULT 39916801  /* prime */
-#define FAULT_RANDOM_ADD	479001701 /* prime */
+/*
+ * From table 5 of L'Ecuyer (1999)
+ * "Tables Of Linear Congruential Generators Of Different Sizes And Good
+ * Lattice Structure"
+ * https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.34.1024
+ * https://www.iro.umontreal.ca/~lecuyer/myftp/papers/latrules99Errata.pdf
+ */
+#define FAULT_RANDOM_MULT 2891336453
+#define FAULT_RANDOM_ADD 1
 #define FAULT_RANDOM_REFRESH 10000
 
 /*
  * Crude but fast random-number generator.  Uses a linear congruential
- * generator, with occasional help from get_random_bytes().
+ * generator, with occasional help from prandom_u32().
+ *
+ * NOTE LCGs with a power-of-2 modulus, like this have a well-known
+ * problem that their low-order bits have short period.  It is used in
+ * a way that cares mostly about the high bits, avoiding the probem.
  */
-static unsigned long
+static u32
 _drbd_fault_random(struct fault_random_state *rsp)
 {
-	long refresh;
-
 	if (!rsp->count--) {
-		get_random_bytes(&refresh, sizeof(refresh));
-		rsp->state += refresh;
+		rsp->state += prandom_u32();
 		rsp->count = FAULT_RANDOM_REFRESH;
 	}
-	rsp->state = rsp->state * FAULT_RANDOM_MULT + FAULT_RANDOM_ADD;
-	return swahw32(rsp->state);
+	return rsp->state = rsp->state * FAULT_RANDOM_MULT + FAULT_RANDOM_ADD;
 }
 
 static char *
@@ -3886,7 +3891,7 @@ _drbd_insert_fault(struct drbd_device *device, unsigned int type)
 	unsigned int ret = (
 		(drbd_fault_devs == 0 ||
 			((1 << device_to_minor(device)) & drbd_fault_devs) != 0) &&
-		(((_drbd_fault_random(&rrs) % 100) + 1) <= drbd_fault_rate));
+		reciprocal_scale(_drbd_fault_random(&rrs), 100) < drbd_fault_rate);
 
 	if (ret) {
 		drbd_fault_count++;
-- 
2.26.0

