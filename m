Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADF4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041BD20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443457;
	bh=a0myFDPreQY3Eoklm/Sp6rJ31Mo5FJA6k7BKDHfVpg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZOLzDmXOmkxUPj4S8J5F+Tv60tjhed6I9Z5PBT+cYmWU5IpJxqQQzToBkLO5ne3rt
	 LUxQWjX6KWY7SToP6NgjBSFYpqBLTNkgiPduMdUif4OFCgXCXcMBKXr4frFVs+MG2a
	 3lxhO6Upsj3YEb230kZWAAi/odx+5nPaqZioiIt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgCQLKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgCQLKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:10:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58427206EC;
        Tue, 17 Mar 2020 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443452;
        bh=a0myFDPreQY3Eoklm/Sp6rJ31Mo5FJA6k7BKDHfVpg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8UQV/qAZrghhGa453zqy0pKkZ0RL0W84ESqBHYcsSfXx/40+1A8V/bB//0lUxp+U
         zwTYgAdV2UaPAp/pjH0QCJHk5jGyLnS3ipaubihEXwHDwT66+SQRd8ZdfNy0lldqO8
         rOgRQO4c0DYfPySPQLd9F9huNsgZhUQTfNqYbP0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.5 085/151] drm/i915: Actually emit the await_start
Date:   Tue, 17 Mar 2020 11:54:55 +0100
Message-Id: <20200317103332.492957036@linuxfoundation.org>
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

commit c67b35d970ed3391069c21f3071a26f687399ab2 upstream.

Fix the inverted test to emit the wait on the end of the previous
request if we /haven't/ already.

Fixes: 6a79d848403d ("drm/i915: Lock signaler timeline while navigating")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.5+
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200305104210.2619967-1-chris@chris-wilson.co.uk
(cherry picked from commit 07e9c59d63df6a1c44c1975c01827ba18b69270a)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_request.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -785,7 +785,7 @@ i915_request_await_start(struct i915_req
 		return PTR_ERR_OR_ZERO(fence);
 
 	err = 0;
-	if (intel_timeline_sync_is_later(i915_request_timeline(rq), fence))
+	if (!intel_timeline_sync_is_later(i915_request_timeline(rq), fence))
 		err = i915_sw_fence_await_dma_fence(&rq->submit,
 						    fence, 0,
 						    I915_FENCE_GFP);


