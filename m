Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57C0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48022074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258027;
	bh=6kxEf6AG81lq00RpGUhnCRlncWQZOL6FoY5qkZ92GHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nDUBOwV+jqqZXyvCVa7f4QO2Bn0qA8dhid6kRX+6zQxnkKCVHvi7MCAU7cVbqfPZe
	 ri1AFzKkIrU3nPNwk72O593FFwiRBY0Z08yJMo2jfacrwaW8oGxN97ORW8DXyWHRdN
	 y67lglU7y7XPSLzEQJ/D76tEto4/lifYSuNvoHWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHXIdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbgHXIdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:33:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB4C206F0;
        Mon, 24 Aug 2020 08:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258020;
        bh=6kxEf6AG81lq00RpGUhnCRlncWQZOL6FoY5qkZ92GHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLX8Q7kgh+6NdcEwuqt24xrgp9gV/EpnNBFF0Szl6sCvUoNdGGOQ3bPYWAj/Y1gXe
         kd2fBRZ+ahKmwfW23VIZOPyHgZu9QYPenAHvnRdku1MPoVoGkIewaX1IvSsz+zvHSH
         xg/Rn2E9aXaSQUAJ0m3mclmZJTBfYo95mfp/+pXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 044/148] drm/i915: Provide the perf pmu.module
Date:   Mon, 24 Aug 2020 10:29:02 +0200
Message-Id: <20200824082416.177573856@linuxfoundation.org>
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

From: Chris Wilson <chris@chris-wilson.co.uk>

[ Upstream commit df3ab3cb7eae63c6eb7c9aebcc196a75d59f65dd ]

Rather than manually implement our own module reference counting for perf
pmu events, finally realise that there is a module parameter to struct
pmu for this very purpose.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200716094643.31410-1-chris@chris-wilson.co.uk
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 27e897beec1c59861f15d4d3562c39ad1143620f)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_pmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 802837de1767c..9792220ddbe2e 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -445,8 +445,6 @@ static void i915_pmu_event_destroy(struct perf_event *event)
 		container_of(event->pmu, typeof(*i915), pmu.base);
 
 	drm_WARN_ON(&i915->drm, event->parent);
-
-	module_put(THIS_MODULE);
 }
 
 static int
@@ -538,10 +536,8 @@ static int i915_pmu_event_init(struct perf_event *event)
 	if (ret)
 		return ret;
 
-	if (!event->parent) {
-		__module_get(THIS_MODULE);
+	if (!event->parent)
 		event->destroy = i915_pmu_event_destroy;
-	}
 
 	return 0;
 }
@@ -1127,6 +1123,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	if (!pmu->base.attr_groups)
 		goto err_attr;
 
+	pmu->base.module	= THIS_MODULE;
 	pmu->base.task_ctx_nr	= perf_invalid_context;
 	pmu->base.event_init	= i915_pmu_event_init;
 	pmu->base.add		= i915_pmu_event_add;
-- 
2.25.1



