Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C35C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89032077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgAJPm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:42:57 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:50523 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAJPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:42:55 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MJEIl-1j6Dpk2HXP-00Kkub; Fri, 10 Jan 2020 16:42:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 1/3] y2038: remove ktime to/from timespec/timeval conversion
Date:   Fri, 10 Jan 2020 16:42:30 +0100
Message-Id: <20200110154232.4104492-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200110154232.4104492-1-arnd@arndb.de>
References: <20200110154232.4104492-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WN5sgzBqrE9ZO3S/x1vHkpv54XqSJpRSR0UqsmHRSbnIZeDknv4
 IV9C2H6FlMPqSoYXRnO0CuTSehUYs1ipdSplQ9aGqlrg5KVCBCFky0v+3Sv3P6Uq7hLKRFi
 CnBV6FSwhnyEeli+ghN5kD63b88CiGY6wjNEt5d1e5qo0L/+FZHVwmCNPCIvmissRMIuag3
 1DrQLSeViky4DZBhhEKuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D19hN1bQ+NM=:UHKNsPYYhaiF+2cp+6tzTt
 yMKtliSynXcYwWqDt5G1vdyEePf9TaF1s5Vec/Pparj6T3EzFdQ6QC5I3xwcr0pTzPnIRd9+b
 qDULY1vyaaMF26f+H25YQAEh4pu6ylYLRAV0X23h5SQ43PbQQKXrWwCSeYiPwbGH6Zp1JAioG
 eAFC0VuvfZtuBketm3vdAnFgzsbOsFkQ4cmvCTm9p1T/HqO1NFZEahB2mTYiXnlvLq945Vw/G
 52rhkkI1c1n+FCIRXdhoene6Bq0du0x0c/vKG7KBm4AJ4HBq9qT0UG3ABf8GyE5Ydu06zhJIw
 SdownPwI+1KNkmrqZab7Y5kv8W9KgUVmq7uPUgBT0Dwvmlxf+Fd4pUE39qbqsfJ/ZL+ThWNjq
 i4eiq2UJsnrUHnueS0emTGwsmQzvIkhnsL2g8tGoKgvxrHroJ82gaqwNShZeP4JCIM/illoqC
 mhojxrb0iSEEzTaLcAyd4dS7EKPhtH/S6dLRii393uK/h7uw1/XePiRyYjt2LFFmvLJgGiYYN
 fqmCzY9nSRXMr5XNabS1Egw15CFTn+Ts6r67z7hfyvoT4a8lKxorr9S22ESraawejzQDAG4qi
 3ttR2yGQiMflJ1c7VF55Wo0D2F09w18g4jrZ4MeoeIXZjmHPxaM5HFT9Lb1jiZs3nxgTRrO58
 taUM7OAR90GGhICwU+Fzpq61Pr4bInrt93a9H2XUN4E/maCKHsMqYDuygCxyA25sA76wRZgmT
 /L3tl4CRRqMndJjZuOQk9Lv92pEYrcZID2RXETay9jKeV5uDJb/3TSsD5XwQIBabfYNUqNJD0
 liIkEGN5WAF978lZWiHyybap4ox8+8Bpgs/mwredpWP9CVe+6rXfSryrAAYier3+6WjI5IBS6
 mZ1YwnqVQ+4BnJnfq1HQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of helpers are now obsolete and can be removed, so drivers can
no longer start using them and instead use y2038-safe interfaces.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/ktime.h | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index b2bb44f87f5a..d1fb05135665 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -66,33 +66,15 @@ static inline ktime_t ktime_set(const s64 secs, const unsigned long nsecs)
  */
 #define ktime_sub_ns(kt, nsval)		((kt) - (nsval))
 
-/* convert a timespec to ktime_t format: */
-static inline ktime_t timespec_to_ktime(struct timespec ts)
-{
-	return ktime_set(ts.tv_sec, ts.tv_nsec);
-}
-
 /* convert a timespec64 to ktime_t format: */
 static inline ktime_t timespec64_to_ktime(struct timespec64 ts)
 {
 	return ktime_set(ts.tv_sec, ts.tv_nsec);
 }
 
-/* convert a timeval to ktime_t format: */
-static inline ktime_t timeval_to_ktime(struct timeval tv)
-{
-	return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
-}
-
-/* Map the ktime_t to timespec conversion to ns_to_timespec function */
-#define ktime_to_timespec(kt)		ns_to_timespec((kt))
-
 /* Map the ktime_t to timespec conversion to ns_to_timespec function */
 #define ktime_to_timespec64(kt)		ns_to_timespec64((kt))
 
-/* Map the ktime_t to timeval conversion to ns_to_timeval function */
-#define ktime_to_timeval(kt)		ns_to_timeval((kt))
-
 /* Convert ktime_t to nanoseconds */
 static inline s64 ktime_to_ns(const ktime_t kt)
 {
@@ -215,25 +197,6 @@ static inline ktime_t ktime_sub_ms(const ktime_t kt, const u64 msec)
 
 extern ktime_t ktime_add_safe(const ktime_t lhs, const ktime_t rhs);
 
-/**
- * ktime_to_timespec_cond - convert a ktime_t variable to timespec
- *			    format only if the variable contains data
- * @kt:		the ktime_t variable to convert
- * @ts:		the timespec variable to store the result in
- *
- * Return: %true if there was a successful conversion, %false if kt was 0.
- */
-static inline __must_check bool ktime_to_timespec_cond(const ktime_t kt,
-						       struct timespec *ts)
-{
-	if (kt) {
-		*ts = ktime_to_timespec(kt);
-		return true;
-	} else {
-		return false;
-	}
-}
-
 /**
  * ktime_to_timespec64_cond - convert a ktime_t variable to timespec64
  *			    format only if the variable contains data
-- 
2.20.0

