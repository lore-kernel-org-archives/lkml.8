Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E603C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004362072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgHYE7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:59:02 -0400
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:59196 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728715AbgHYE5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7303412C8;
        Tue, 25 Aug 2020 04:57:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tooth95_1d0aaa027059
X-Filterd-Recvd-Size: 3852
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:56:58 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/29] drm/i915: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:07 -0700
Message-Id: <d687691df8f9978c7b2362c18d77a16b49be76b0.1598331148.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c           | 8 +++++---
 drivers/gpu/drm/i915/gt/intel_gt_requests.c    | 6 ++++--
 drivers/gpu/drm/i915/gt/selftest_workarounds.c | 6 ++++--
 drivers/gpu/drm/i915/intel_runtime_pm.c        | 6 ++++--
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
index 699125928272..114c13285ff1 100644
--- a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
@@ -323,10 +323,12 @@ static int __gen8_ppgtt_alloc(struct i915_address_space * const vm,
 			}
 
 			spin_lock(&pd->lock);
-			if (likely(!pd->entry[idx]))
+			if (likely(!pd->entry[idx])) {
 				set_pd_entry(pd, idx, pt);
-			else
-				alloc = pt, pt = pd->entry[idx];
+			} else {
+				alloc = pt;
+				pt = pd->entry[idx];
+			}
 		}
 
 		if (lvl) {
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.c b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
index 66fcbf9d0fdd..54408d0b5e6e 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
@@ -139,8 +139,10 @@ long intel_gt_retire_requests_timeout(struct intel_gt *gt, long timeout)
 	LIST_HEAD(free);
 
 	interruptible = true;
-	if (unlikely(timeout < 0))
-		timeout = -timeout, interruptible = false;
+	if (unlikely(timeout < 0)) {
+		timeout = -timeout;
+		interruptible = false;
+	}
 
 	flush_submission(gt, timeout); /* kick the ksoftirqd tasklets */
 	spin_lock(&timelines->lock);
diff --git a/drivers/gpu/drm/i915/gt/selftest_workarounds.c b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
index febc9e6692ba..3e4cbeed20bd 100644
--- a/drivers/gpu/drm/i915/gt/selftest_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
@@ -521,8 +521,10 @@ static int check_dirty_whitelist(struct intel_context *ce)
 
 		srm = MI_STORE_REGISTER_MEM;
 		lrm = MI_LOAD_REGISTER_MEM;
-		if (INTEL_GEN(engine->i915) >= 8)
-			lrm++, srm++;
+		if (INTEL_GEN(engine->i915) >= 8) {
+			lrm++;
+			srm++;
+		}
 
 		pr_debug("%s: Writing garbage to %x\n",
 			 engine->name, reg);
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 153ca9e65382..f498f1c80755 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -201,8 +201,10 @@ __print_intel_runtime_pm_wakeref(struct drm_printer *p,
 		unsigned long rep;
 
 		rep = 1;
-		while (i + 1 < dbg->count && dbg->owners[i + 1] == stack)
-			rep++, i++;
+		while (i + 1 < dbg->count && dbg->owners[i + 1] == stack) {
+			rep++;
+			i++;
+		}
 		__print_depot_stack(stack, buf, PAGE_SIZE, 2);
 		drm_printf(p, "Wakeref x%lu taken at:\n%s", rep, buf);
 	}
-- 
2.26.0

