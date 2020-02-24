Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAFAC38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D6B20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBXUlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:41:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:31560 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgBXUlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:41:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 12:41:07 -0800
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="255704768"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 12:41:07 -0800
Date:   Mon, 24 Feb 2020 12:41:05 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Tony Luck <tony.luck@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: always use batched entropy for
 get_random_u{32,64}
Message-ID: <20200224204105.GA24543@agluck-desk2.amr.corp.intel.com>
References: <20200216161836.1976-1-Jason@zx2c4.com>
 <20200216182319.GA54139@kroah.com>
 <CA+8MBbKScktNPWPgMqexp9gSX+y2FVnXTDJyyEMVsdONPBpFrQ@mail.gmail.com>
 <CA+8MBbKyRhipHsxb0nvV11Bvv8ypQ_gq5JR8ihfuG6JfBTnxZw@mail.gmail.com>
 <CAHmME9q1rnD5z2bENYhqnM5-XCD+E68nm2RrGRWXt8ntpvfezg@mail.gmail.com>
 <20200222004133.GC873427@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222004133.GC873427@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 07:41:33PM -0500, Theodore Y. Ts'o wrote:
> On Fri, Feb 21, 2020 at 09:08:19PM +0100, Jason A. Donenfeld wrote:
> > On Thu, Feb 20, 2020 at 11:29 PM Tony Luck <tony.luck@gmail.com> wrote:
> > >
> > > Could we just disable interrupts and pre-emption around the entropy extraction?
> > 
> > Probably, yes... We can address this in a separate patch.
> 
> No, we can't; take a look at invalidate_batched_entropy(), where we
> need invalidate all of per-cpu batched entropy from a single CPU after
> we have initialized the the CRNG.
> 
> Since most of the time after CRNG initialization, the spinlock for
> each CPU will be on that CPU's cacheline, the time to take and release
> the spinlock is not going to be material.

So we could get rid of the spin lock by replacing with a "bool"
that is written when we want to do an invalidate on the next call
(where it is read and cleared).

For me it makes a 15 cycle difference (56 vs. 71) for the fast
case when we are just picking a value from the array. The slow
path when we do extract_crng() is barely changed (731 vs 736 cycles).

But I took the "do lazily" comment above invalidate_batched_entropy()
very literally and didn't add any fences to make sure that readers
of need_invalidate see the store ASAP. So a close race where the
invalidate request would have won control of the spin lock might
not get processed until a subsequent call.

If you think a fence is needed, the the advantage will be lost
and the below patch is worthless.

-Tony

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a6b77a850ddd..6fb222996ea4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2144,7 +2144,7 @@ struct batched_entropy {
 		u32 entropy_u32[CHACHA_BLOCK_SIZE / sizeof(u32)];
 	};
 	unsigned int position;
-	spinlock_t batch_lock;
+	bool need_invalidate;
 };
 
 /*
@@ -2155,9 +2155,7 @@ struct batched_entropy {
  * wait_for_random_bytes() should be called and return 0 at least once at any
  * point prior.
  */
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
-	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
-};
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64);
 
 u64 get_random_u64(void)
 {
@@ -2168,21 +2166,23 @@ u64 get_random_u64(void)
 
 	warn_unseeded_randomness(&previous);
 
+	local_irq_save(flags);
+	preempt_disable();
 	batch = raw_cpu_ptr(&batched_entropy_u64);
-	spin_lock_irqsave(&batch->batch_lock, flags);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
+	if (batch->need_invalidate ||
+	    batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
 		extract_crng((u8 *)batch->entropy_u64);
 		batch->position = 0;
+		batch->need_invalidate = false;
 	}
 	ret = batch->entropy_u64[batch->position++];
-	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	preempt_enable();
+	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u64);
 
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
-	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
-};
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32);
 u32 get_random_u32(void)
 {
 	u32 ret;
@@ -2192,14 +2192,18 @@ u32 get_random_u32(void)
 
 	warn_unseeded_randomness(&previous);
 
+	local_irq_save(flags);
+	preempt_disable();
 	batch = raw_cpu_ptr(&batched_entropy_u32);
-	spin_lock_irqsave(&batch->batch_lock, flags);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0) {
+	if (batch->need_invalidate ||
+	    batch->position % ARRAY_SIZE(batch->entropy_u32) == 0) {
 		extract_crng((u8 *)batch->entropy_u32);
 		batch->position = 0;
+		batch->need_invalidate = false;
 	}
 	ret = batch->entropy_u32[batch->position++];
-	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	preempt_enable();
+	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u32);
@@ -2217,14 +2221,10 @@ static void invalidate_batched_entropy(void)
 		struct batched_entropy *batched_entropy;
 
 		batched_entropy = per_cpu_ptr(&batched_entropy_u32, cpu);
-		spin_lock_irqsave(&batched_entropy->batch_lock, flags);
-		batched_entropy->position = 0;
-		spin_unlock(&batched_entropy->batch_lock);
+		batched_entropy->need_invalidate = true;
 
 		batched_entropy = per_cpu_ptr(&batched_entropy_u64, cpu);
-		spin_lock(&batched_entropy->batch_lock);
-		batched_entropy->position = 0;
-		spin_unlock_irqrestore(&batched_entropy->batch_lock, flags);
+		batched_entropy->need_invalidate = true;
 	}
 }
 
