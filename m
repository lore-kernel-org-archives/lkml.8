Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDFCC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41553205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443821;
	bh=8QmZkzuHsdxht+9tD81+KsUAcaTkKirBAlactgxm99g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=025thzLww+6CsKyhRS2OhvkCVHBRe9CmFUHgkhmiMqUrMa6IOw0SjLN1CFnrkWu0C
	 Q++eFzfRWY3RaXwax46vZYF1lsjjy7vdiuYjXMNAG5iN4cxw1M74X/hkUzHV1U59i0
	 EzkIp3becYq5dcmfrZnjtowSHsOppdBWg6BssBd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCQLQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbgCQLK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:10:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A296E205ED;
        Tue, 17 Mar 2020 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443456;
        bh=8QmZkzuHsdxht+9tD81+KsUAcaTkKirBAlactgxm99g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGOALJab7NG2GIhm9h1YTpN4i4Cfqd2bzbu9HRMYhnxfIB9K7VzDurRgjVj4QOJKn
         YQKnj/Yj7dPE2m12bZkEnROgKsTOvrx6gltio7mN4mI6OKsMPYyVkcvi/zX0kdIEXi
         /ngQruGMy+rWAmBAtaiVo+9ed9JRfXn9CPTYVF+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.5 086/151] drm/i915: Return early for await_start on same timeline
Date:   Tue, 17 Mar 2020 11:54:56 +0100
Message-Id: <20200317103332.561541321@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

commit c951b0af2dddbb1f34be103029eb9030392d5554 upstream.

Requests within a timeline are ordered by that timeline, so awaiting for
the start of a request within the timeline is a no-op. This used to work
by falling out of the mutex_trylock() as the signaler and waiter had the
same timeline and not returning an error.

Fixes: 6a79d848403d ("drm/i915: Lock signaler timeline while navigating")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.5+
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200305134822.2750496-1-chris@chris-wilson.co.uk
(cherry picked from commit ab7a69020fb5d5c7ba19fba60f62fd6f9ca9f779)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_request.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -759,8 +759,8 @@ i915_request_await_start(struct i915_req
 	struct dma_fence *fence;
 	int err;
 
-	GEM_BUG_ON(i915_request_timeline(rq) ==
-		   rcu_access_pointer(signal->timeline));
+	if (i915_request_timeline(rq) == rcu_access_pointer(signal->timeline))
+		return 0;
 
 	rcu_read_lock();
 	tl = rcu_dereference(signal->timeline);


