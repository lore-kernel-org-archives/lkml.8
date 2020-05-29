Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E53FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3975C2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438182AbgE2Alu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438133AbgE2Als (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:41:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F9C08C5C6;
        Thu, 28 May 2020 17:41:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeT5l-00HFg9-RG; Fri, 29 May 2020 00:41:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 1/5] i915: switch query_{topology,engine}_info() to copy_to_user()
Date:   Fri, 29 May 2020 01:41:41 +0100
Message-Id: <20200529004145.4111807-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/i915/i915_query.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
index ef25ce6e395e..ad8e55fe1e59 100644
--- a/drivers/gpu/drm/i915/i915_query.c
+++ b/drivers/gpu/drm/i915/i915_query.c
@@ -25,10 +25,6 @@ static int copy_query_item(void *query_hdr, size_t query_sz,
 			   query_sz))
 		return -EFAULT;
 
-	if (!access_ok(u64_to_user_ptr(query_item->data_ptr),
-		       total_length))
-		return -EFAULT;
-
 	return 0;
 }
 
@@ -72,20 +68,20 @@ static int query_topology_info(struct drm_i915_private *dev_priv,
 	topo.eu_offset = slice_length + subslice_length;
 	topo.eu_stride = sseu->eu_stride;
 
-	if (__copy_to_user(u64_to_user_ptr(query_item->data_ptr),
+	if (copy_to_user(u64_to_user_ptr(query_item->data_ptr),
 			   &topo, sizeof(topo)))
 		return -EFAULT;
 
-	if (__copy_to_user(u64_to_user_ptr(query_item->data_ptr + sizeof(topo)),
+	if (copy_to_user(u64_to_user_ptr(query_item->data_ptr + sizeof(topo)),
 			   &sseu->slice_mask, slice_length))
 		return -EFAULT;
 
-	if (__copy_to_user(u64_to_user_ptr(query_item->data_ptr +
+	if (copy_to_user(u64_to_user_ptr(query_item->data_ptr +
 					   sizeof(topo) + slice_length),
 			   sseu->subslice_mask, subslice_length))
 		return -EFAULT;
 
-	if (__copy_to_user(u64_to_user_ptr(query_item->data_ptr +
+	if (copy_to_user(u64_to_user_ptr(query_item->data_ptr +
 					   sizeof(topo) +
 					   slice_length + subslice_length),
 			   sseu->eu_mask, eu_length))
@@ -131,14 +127,14 @@ query_engine_info(struct drm_i915_private *i915,
 		info.engine.engine_instance = engine->uabi_instance;
 		info.capabilities = engine->uabi_capabilities;
 
-		if (__copy_to_user(info_ptr, &info, sizeof(info)))
+		if (copy_to_user(info_ptr, &info, sizeof(info)))
 			return -EFAULT;
 
 		query.num_engines++;
 		info_ptr++;
 	}
 
-	if (__copy_to_user(query_ptr, &query, sizeof(query)))
+	if (copy_to_user(query_ptr, &query, sizeof(query)))
 		return -EFAULT;
 
 	return len;
-- 
2.11.0

