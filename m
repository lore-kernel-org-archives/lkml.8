Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE48C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0940D20825
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EffEtYrt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2OHatuhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgHCQF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:05:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37166 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgHCQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:05:27 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596470725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cjQTCHJ3y4DCe0XgrxEsW/lCFVYz3XtncIs9t2KFDWo=;
        b=EffEtYrtRBMLVtJXM7+7hG8uxCdzx7hhyRA3cvJilaJdtMn9hxMjuVfyfSdHYFFADGTfYT
        cX0wzmKxApuNteQZgaGezuvlaGYRUxXEmh//UmD8WUrHKuNLoJ2X6jACzJ+bCKKWGKRS6T
        Ze7ShKjud+8Q89ibfrQiOVaGrl5NpESoLojyt+g54oSUignh2cITub++ty/ezi80oPtzTD
        pfJt4AAy3xKEY6UF0wabSMAjvQJWrvzLIbWHNRi9oE2BkXvt1I2EIT4C7D8b/mrzRNWJDw
        2R8ops7ds7t3QIR+E4puS5eLc29HmvFjTm3ZBtg/7dSS8in+DZLPUFIoVXpXnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596470725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cjQTCHJ3y4DCe0XgrxEsW/lCFVYz3XtncIs9t2KFDWo=;
        b=2OHatuhcfrikbBZ3q7Z3YDoAaiFa4hvsDYhozvIhnqBz5gClQ5RAMRdNpDItrOLLnO6KLJ
        U5RzVquCNm1yfICA==
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
In-Reply-To: <yt9dmu3b3jo3.fsf@linux.ibm.com>
References: <20200803055645.79042-1-svens@linux.ibm.com> <20200803055645.79042-3-svens@linux.ibm.com> <87ft93ncaa.fsf@nanos.tec.linutronix.de> <yt9dmu3b3jo3.fsf@linux.ibm.com>
Date:   Mon, 03 Aug 2020 18:05:24 +0200
Message-ID: <87a6zbn29n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven,

Sven Schnelle <svens@linux.ibm.com> writes:
> Thomas Gleixner <tglx@linutronix.de> writes:
>>>  			rc = chsc_sstpc(stp_page, STP_OP_SYNC, 0,
>>>  					&clock_delta);
>>>  			if (rc == 0) {
>>> @@ -609,6 +567,8 @@ static int stp_sync_clock(void *data)
>>>  				if (rc == 0 && stp_info.tmd != 2)
>>>  					rc = -EAGAIN;
>>>  			}
>>> +			smp_wmb(); /* see comment above */
>>
>> See my comments above :)
>
> :-)
>
> What do you think about my question on using vdso_write_begin/end()?
> __arch_get_hw_counter() is called inside a vdso_read_retry() loop, so i
> would think that just enclosing this update with vdso_write_begin/end()
> should sufficient. But i'm not sure whether arch/ should call these
> functions.

My knee jerk reaction is obviously NO, but OTOH it makes sense to
utilize the existing sequence count for that.

Though that want's a bit more than just fiddling with the sequence
counter to be future proof and not restricted to the horrors of stomp
machine context or some other orchestration mechanism. Something like
the below.

Thanks,

        tglx

----
Subject: timekeeping/vsyscall: Provide vdso_update_begin/end()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 03 Aug 2020 17:25:31 +0200

Architectures can have the requirement to add additional architecture
specific data to the VDSO data page which needs to be updated independent
of the timekeeper updates.

To protect these updates vs. concurrent readers and a conflicting update
through timekeeping, provide helper functions to make such updates safe.

vdso_update_begin() takes the timekeeper_lock to protect against a
potential update from timekeeper code and increments the VDSO sequence
count to signal data inconsistency to concurrent readers. vdso_update_end()
makes the sequence count even again to signal data consistency and drops
the timekeeper lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/vdso/vsyscall.h            |    3 +++
 kernel/time/timekeeping.c          |    2 +-
 kernel/time/timekeeping_internal.h |   11 ++++++++---
 kernel/time/vsyscall.c             |   30 ++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 4 deletions(-)

--- a/include/vdso/vsyscall.h
+++ b/include/vdso/vsyscall.h
@@ -6,6 +6,9 @@
 
 #include <asm/vdso/vsyscall.h>
 
+void vdso_update_begin(void);
+void vdso_update_end(void);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __VDSO_VSYSCALL_H */
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -50,7 +50,7 @@ static struct {
 	.seq = SEQCNT_ZERO(tk_core.seq),
 };
 
-static DEFINE_RAW_SPINLOCK(timekeeper_lock);
+DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
 
 /**
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -1,12 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _TIMEKEEPING_INTERNAL_H
 #define _TIMEKEEPING_INTERNAL_H
-/*
- * timekeeping debug functions
- */
+
 #include <linux/clocksource.h>
+#include <linux/spinlock.h>
 #include <linux/time.h>
 
+/*
+ * timekeeping debug functions
+ */
 #ifdef CONFIG_DEBUG_FS
 extern void tk_debug_account_sleep_time(const struct timespec64 *t);
 #else
@@ -31,4 +33,7 @@ static inline u64 clocksource_delta(u64
 }
 #endif
 
+/* Semi public for serialization of non timekeeper VDSO updates. */
+extern raw_spinlock_t timekeeper_lock;
+
 #endif /* _TIMEKEEPING_INTERNAL_H */
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -13,6 +13,8 @@
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
 
+#include "timekeeping_internal.h"
+
 static inline void update_vdso_data(struct vdso_data *vdata,
 				    struct timekeeper *tk)
 {
@@ -127,3 +129,31 @@ void update_vsyscall_tz(void)
 
 	__arch_sync_vdso_data(vdata);
 }
+
+/**
+ * vdso_update_begin - Start of a VDSO update section
+ *
+ * Allows architecture code to safely update the architecture specific VDSO
+ * data.
+ */
+void vdso_update_begin(void)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+
+	raw_spin_lock(&timekeeper_lock);
+	vdso_write_begin(vdata);
+}
+
+/**
+ * vdso_update_end - End of a VDSO update section
+ *
+ * Pairs with vdso_update_begin().
+ */
+void vdso_update_end(void)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+
+	vdso_write_end(vdata);
+	__arch_sync_vdso_data(vdata);
+	raw_spin_unlock(&timekeeper_lock);
+}
