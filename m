Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CB3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57AD2207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgE0OF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:05:59 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbgE0OF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:05:59 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mo6WJ-1jFYx33Vox-00pcRT; Wed, 27 May 2020 16:05:42 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Andi Shyti <andi.shyti@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/i915/selftests: avoid bogus maybe-uninitialized warning
Date:   Wed, 27 May 2020 16:05:10 +0200
Message-Id: <20200527140526.1458215-3-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527140526.1458215-1-arnd@arndb.de>
References: <20200527140526.1458215-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Bs1kH9SiEUr82+i0D5b4IjNzyMWhRc9ReAI4hRbtaSg+wd4Y+kE
 gsHtJL0netn243C7nHQamvh/2VpFFj/mbWQZYBUlmk15Ur8+KyRpRLNWTSOpnSXrG6ACa8Y
 a50vkShJOWxV4ykm7XUMk0pidxZYJm1W5/Zw9bnILBSY8qbgoV8/N+o6gDRiA7eO91pvrsn
 zFA51RKJXl5UhRluoBa/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+3169tARU2k=:uC5t2mXS/rarwbKpJ4p1IL
 TkcNg5L4b0eQa1dnkKmj9R/sSkzpoRvOHXS4my5yaaC5Ipgn4d1MzqW671izesykz8iby4m+5
 z1IvD+l5KijKgQE7VVqp37PdP1Z8kyBPIudjh8SOJe9IwGRQxJn23IKziQzSrbGAOabL33Rqj
 UC9ZjpLC9GhatIlmPNENyXJDcfdNAmC8jVR75LlmscyCeIQgmKczM8/5DrTdldpueq8wUOTyz
 JV72tDCgqyNcaDaert16Y0sw3l/yCWMETugA/v0l5p8yJzjYFsworrldztzOG9TwwtVECsezT
 Tyx7TQTlKGfirXDvwAFcG5DItmsJw3HVXeTdStNblLhTBLKsOQg9tXZYYJH3LMxOlzLovL0pt
 X4NQgpyhSnJRfCn4ZnC6jt0nte5GJ/7rVDPvPpyNFlqKDZ4tZ7ODiRKv7v2S3TiZ7h/9axGxz
 9/rAxDSK75RmKxgRZFX/z93DUKLmUODUq+S//87z6aF6npDlxOEM5RmRFnCv6S3uA20KZP1DG
 exucUvsLOIrOHJz/b0WA3dI4HoqagLbzF4yIpfoAwfKFe2zu1nlXPeMEVu8nmUw2wSK+Mfbne
 HKWAq152YlnhozAc2jzA2OqZk28FYLTob4ZEMpqiy2XClWwByz/Wlq/nyHi4i/k8x/3TqZJpQ
 OSkAS/+T+5Vq4WASVKIzNKWyiaw9J5BL5wPMTejvRY1jag3b1jmhTWmVMcEkiMBG6fhbr7ysx
 pzkkkkZx0UDRaWqZpEwWJKveoIG9zxc9XE8ju3hQuslsSe94To3JlK2xF+KNjaL6ne+vqnBSB
 bUYPQNyOqcNk6d8FiJRHXwa+NGAXkcy95rnATkLAbrJtAtHBPE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc has a problem following values through IS_ERR/PTR_ERR macros,
leading to a false-positive warning in allmodconfig, with any
compiler version:

In file included from drivers/gpu/drm/i915/gt/intel_lrc.c:5892:
drivers/gpu/drm/i915/gt/selftest_lrc.c: In function 'create_gpr_client.isra.0':
drivers/gpu/drm/i915/gt/selftest_lrc.c:2902:23: error: 'rq' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This one is hard to avoid without impairing readability or adding a
bugus NULL pointer.

Fixes: c92724de6db1 ("drm/i915/selftests: Try to detect rollback during batchbuffer preemption")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/gt/selftest_lrc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_lrc.c b/drivers/gpu/drm/i915/gt/selftest_lrc.c
index 824f99c4cc7c..933c3f5adf0a 100644
--- a/drivers/gpu/drm/i915/gt/selftest_lrc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_lrc.c
@@ -2908,23 +2908,25 @@ create_gpr_client(struct intel_engine_cs *engine,
 
 	vma = i915_vma_instance(global->obj, ce->vm, NULL);
 	if (IS_ERR(vma)) {
-		err = PTR_ERR(vma);
+		rq = ERR_CAST(vma);
 		goto out_ce;
 	}
 
 	err = i915_vma_pin(vma, 0, 0, PIN_USER);
-	if (err)
+	if (err) {
+		rq = ERR_PTR(err);
 		goto out_ce;
+	}
 
 	batch = create_gpr_user(engine, vma, offset);
 	if (IS_ERR(batch)) {
-		err = PTR_ERR(batch);
+		rq = ERR_CAST(batch);
 		goto out_vma;
 	}
 
 	rq = intel_context_create_request(ce);
 	if (IS_ERR(rq)) {
-		err = PTR_ERR(rq);
+		rq = ERR_CAST(rq);
 		goto out_batch;
 	}
 
@@ -2946,17 +2948,20 @@ create_gpr_client(struct intel_engine_cs *engine,
 	i915_vma_unlock(batch);
 	i915_vma_unpin(batch);
 
-	if (!err)
+	if (!err) {
 		i915_request_get(rq);
-	i915_request_add(rq);
-
+		i915_request_add(rq);
+	} else {
+		i915_request_add(rq);
+		rq = ERR_PTR(err);
+	}
 out_batch:
 	i915_vma_put(batch);
 out_vma:
 	i915_vma_unpin(vma);
 out_ce:
 	intel_context_put(ce);
-	return err ? ERR_PTR(err) : rq;
+	return rq;
 }
 
 static int preempt_user(struct intel_engine_cs *engine,
-- 
2.26.2

