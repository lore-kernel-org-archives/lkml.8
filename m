Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37C72075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258024;
	bh=Vf6JYvAkcH4kNBevz0hjVEvvg8GA3A+d4JKJx0Mgyjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iZn/gYE+XH3KsVrVReks3jljJ5ydJaaZqytTibwyvN5IvovAakA3wOV/X141MnQey
	 iFwmoKw6x3FaeErekGEE0vNFuvctaiAmg5GMdOJ/Zohg56Uw2DOmxhm364qPA9nfwr
	 89YIgQrmiwEM7SQgQVXuZfC5YEVIGpraljIY5hA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgHXIdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbgHXIdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:33:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B1B206F0;
        Mon, 24 Aug 2020 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258018;
        bh=Vf6JYvAkcH4kNBevz0hjVEvvg8GA3A+d4JKJx0Mgyjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOYVLR1Eo2/Ocnu5P9L+NvdpwD6GcZGa8aR3n07QxeVSzFyRHm6gCLBAUygAhcQhi
         mpXzqR1SHmNeaX4dI5VheQIGPoyI3MgFaYF3H7+ArBwPoPcPSXxVdEfH3s7w2yN8Yv
         P8jn/3DfJ8JeHKxN5krZXEySMeNp6idKcFG06Yi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 043/148] drm/i915/pmu: Prefer drm_WARN_ON over WARN_ON
Date:   Mon, 24 Aug 2020 10:29:01 +0200
Message-Id: <20200824082416.120303800@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

[ Upstream commit bf07f6ebffefce2bbf3c318f9ce2f987774ea983 ]

struct drm_device specific drm_WARN* macros include device information
in the backtrace, so we know what device the warnings originate from.

Prefer drm_WARN_ON over WARN_ON.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200504181600.18503-8-pankaj.laxminarayan.bharadiya@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_pmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 962ded9ce73fd..802837de1767c 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -441,7 +441,11 @@ static u64 count_interrupts(struct drm_i915_private *i915)
 
 static void i915_pmu_event_destroy(struct perf_event *event)
 {
-	WARN_ON(event->parent);
+	struct drm_i915_private *i915 =
+		container_of(event->pmu, typeof(*i915), pmu.base);
+
+	drm_WARN_ON(&i915->drm, event->parent);
+
 	module_put(THIS_MODULE);
 }
 
@@ -1058,8 +1062,10 @@ static int i915_pmu_register_cpuhp_state(struct i915_pmu *pmu)
 
 static void i915_pmu_unregister_cpuhp_state(struct i915_pmu *pmu)
 {
-	WARN_ON(pmu->cpuhp.slot == CPUHP_INVALID);
-	WARN_ON(cpuhp_state_remove_instance(pmu->cpuhp.slot, &pmu->cpuhp.node));
+	struct drm_i915_private *i915 = container_of(pmu, typeof(*i915), pmu);
+
+	drm_WARN_ON(&i915->drm, pmu->cpuhp.slot == CPUHP_INVALID);
+	drm_WARN_ON(&i915->drm, cpuhp_state_remove_instance(pmu->cpuhp.slot, &pmu->cpuhp.node));
 	cpuhp_remove_multi_state(pmu->cpuhp.slot);
 	pmu->cpuhp.slot = CPUHP_INVALID;
 }
-- 
2.25.1



