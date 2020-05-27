Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5AA206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgE0OFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:05:47 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbgE0OFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:05:47 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Myevl-1ioaSD1TtV-00z0dt; Wed, 27 May 2020 16:05:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
        Andi Shyti <andi.shyti@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/i915/pmu: avoid an maybe-uninitialized warning
Date:   Wed, 27 May 2020 16:05:08 +0200
Message-Id: <20200527140526.1458215-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iA/oVTFZbT0EcafqZRx1usz2+oWll8ShFOXyKlbH3L+E47gvF24
 rqK1c0Xjr6CQW/9Sy+2v5OER+rRGSk92oqcKN3TTYYe1sGIBdezAIm9CdYAHoiZtdDxhMQI
 s6KkiyxtAAfHu/e/ASnv9FV7L+EgSb4wsnxyLn0niqe6JnEiNM7wwJk2MjrmrOK2vTbuPmB
 ObhVD+c+lb9Xai3ZpB3eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n4SCQDCGfV4=:ogzOYkn3538mcJo7f6pEXn
 KqUMsB2e549l4uTNcu0TMs57ViYWWma7nnmTkQUgk5pirC0JZJ8I9o1d/3GnQuN90omKJ8/in
 f6WvQv5vfh1kF6kkMNB8TdkmDJiiWWxQsD+aDh8oa7aLUvTFBopx/gGolFh67VhzpalNT4kYK
 5io+ssP/9LSgE173ood5obfWLOz3uPkNzRM//eq3ImMu1sPQAhVYjU97FUs8+7HDjg3hnAnnc
 VGNSKc0IDaNLcFif0+39tHVzQyECePxPsAI6XrVD4DS9h2sMSEyYhb08Fx3sXMBqTdeJ8Esn0
 gHAtyuS2nxpp0womDgWcqxjT8QMMMgZdhrpQudjek57HqwqYpdzsMNdZ0lL2dK1babZq2ZHBV
 R3RpfJr/uNRK6n12I3hSn8PVptJ1YMquHWlh5EhSwfFyJJXrV2C1jgoj+eUHixetnQHYTArum
 mGfEc/Szlj/C810ABru1nVLtHhIapRHTL8jZdaWyiut5bvbgvIt6ZcjP+uHnY/NAojhI0wOnY
 reFYaK6g0U0s52KSBorCrVz6HZtO3N3RGLFiDjRuAJOzIj9wPFxiLR/IjJeehijl1rUw9eDLD
 1YLh45rAQQjojtxacOLrpj1oPPbOJU0Eb4umkPMHbVQh9wFnNGtNVKoqbuv9KyWZjFrOSOv/7
 Mudl4HiW8d4AUmEwLrXvD1gCO40Vi5hhkSs/ZmEq9nYBxFyukyckpsn7q4w9jB00vOP/uZT8n
 CbjVviFDTK9qvvXXLv6ZHukjL2YT/aETMODlRWwbqbKN5KJFcgfoHU2msQ/UYzw8t63mesWnI
 27fZW9RLueux46y0revxiSAGcH0BbUJminol69qJsIw52HXlh8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conditional spinlocks make it hard for gcc and for lockdep to
follow the code flow. This one causes a warning with at least
gcc-9 and higher:

In file included from include/linux/irq.h:14,
                 from drivers/gpu/drm/i915/i915_pmu.c:7:
drivers/gpu/drm/i915/i915_pmu.c: In function 'i915_sample':
include/linux/spinlock.h:289:3: error: 'flags' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  289 |   _raw_spin_unlock_irqrestore(lock, flags); \
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/i915_pmu.c:288:17: note: 'flags' was declared here
  288 |   unsigned long flags;
      |                 ^~~~~

Split out the part between the locks into a separate function
for readability and to let the compiler figure out what the
logic actually is.

Fixes: d79e1bd676f0 ("drm/i915/pmu: Only use exclusive mmio access for gen7")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have no idea why I see three separate issues like this pop up in i915,
there are not a lot of them elsewhere.

 drivers/gpu/drm/i915/i915_pmu.c | 84 ++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index e991a707bdb7..962ded9ce73f 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -269,12 +269,48 @@ static bool exclusive_mmio_access(const struct drm_i915_private *i915)
 	return IS_GEN(i915, 7);
 }
 
+static void engine_sample(struct intel_engine_cs *engine, unsigned int period_ns)
+{
+	struct intel_engine_pmu *pmu = &engine->pmu;
+	bool busy;
+	u32 val;
+
+	val = ENGINE_READ_FW(engine, RING_CTL);
+	if (val == 0) /* powerwell off => engine idle */
+		return;
+
+	if (val & RING_WAIT)
+		add_sample(&pmu->sample[I915_SAMPLE_WAIT], period_ns);
+	if (val & RING_WAIT_SEMAPHORE)
+		add_sample(&pmu->sample[I915_SAMPLE_SEMA], period_ns);
+
+	/* No need to sample when busy stats are supported. */
+	if (intel_engine_supports_stats(engine))
+		return;
+
+	/*
+	 * While waiting on a semaphore or event, MI_MODE reports the
+	 * ring as idle. However, previously using the seqno, and with
+	 * execlists sampling, we account for the ring waiting as the
+	 * engine being busy. Therefore, we record the sample as being
+	 * busy if either waiting or !idle.
+	 */
+	busy = val & (RING_WAIT_SEMAPHORE | RING_WAIT);
+	if (!busy) {
+		val = ENGINE_READ_FW(engine, RING_MI_MODE);
+		busy = !(val & MODE_IDLE);
+	}
+	if (busy)
+		add_sample(&pmu->sample[I915_SAMPLE_BUSY], period_ns);
+}
+
 static void
 engines_sample(struct intel_gt *gt, unsigned int period_ns)
 {
 	struct drm_i915_private *i915 = gt->i915;
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
+	unsigned long flags;
 
 	if ((i915->pmu.enable & ENGINE_SAMPLE_MASK) == 0)
 		return;
@@ -283,53 +319,17 @@ engines_sample(struct intel_gt *gt, unsigned int period_ns)
 		return;
 
 	for_each_engine(engine, gt, id) {
-		struct intel_engine_pmu *pmu = &engine->pmu;
-		spinlock_t *mmio_lock;
-		unsigned long flags;
-		bool busy;
-		u32 val;
-
 		if (!intel_engine_pm_get_if_awake(engine))
 			continue;
 
-		mmio_lock = NULL;
-		if (exclusive_mmio_access(i915))
-			mmio_lock = &engine->uncore->lock;
-
-		if (unlikely(mmio_lock))
-			spin_lock_irqsave(mmio_lock, flags);
-
-		val = ENGINE_READ_FW(engine, RING_CTL);
-		if (val == 0) /* powerwell off => engine idle */
-			goto skip;
-
-		if (val & RING_WAIT)
-			add_sample(&pmu->sample[I915_SAMPLE_WAIT], period_ns);
-		if (val & RING_WAIT_SEMAPHORE)
-			add_sample(&pmu->sample[I915_SAMPLE_SEMA], period_ns);
-
-		/* No need to sample when busy stats are supported. */
-		if (intel_engine_supports_stats(engine))
-			goto skip;
-
-		/*
-		 * While waiting on a semaphore or event, MI_MODE reports the
-		 * ring as idle. However, previously using the seqno, and with
-		 * execlists sampling, we account for the ring waiting as the
-		 * engine being busy. Therefore, we record the sample as being
-		 * busy if either waiting or !idle.
-		 */
-		busy = val & (RING_WAIT_SEMAPHORE | RING_WAIT);
-		if (!busy) {
-			val = ENGINE_READ_FW(engine, RING_MI_MODE);
-			busy = !(val & MODE_IDLE);
+		if (exclusive_mmio_access(i915)) {
+			spin_lock_irqsave(&engine->uncore->lock, flags);
+			engine_sample(engine, period_ns);
+			spin_unlock_irqrestore(&engine->uncore->lock, flags);
+		} else {
+			engine_sample(engine, period_ns);
 		}
-		if (busy)
-			add_sample(&pmu->sample[I915_SAMPLE_BUSY], period_ns);
 
-skip:
-		if (unlikely(mmio_lock))
-			spin_unlock_irqrestore(mmio_lock, flags);
 		intel_engine_pm_put_async(engine);
 	}
 }
-- 
2.26.2

