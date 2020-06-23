Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22557C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E308821927
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945012;
	bh=k6p8OcEuzK4UAhSHv16GJqWypDgF3hbJsp8dDXxMVwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F279lXMrpG7/1gaKeAHJotR+7l4hMDiK4XtKkTi7QREkbXbF8E/QjcobsxUV6EnfI
	 PcDXPpobiQkVEJpjeS27axBghpx0iyZD1KY6AQbsbRehf9vqbIoEw2AkfcNLjVZjNj
	 tRe0Va3J6grV+ajdiCyYpJc6U9PIFMzt7tex7pMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392533AbgFWUn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392515AbgFWUnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:43:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2648121883;
        Tue, 23 Jun 2020 20:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945003;
        bh=k6p8OcEuzK4UAhSHv16GJqWypDgF3hbJsp8dDXxMVwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8DYVt8KiWh3fPgteIlq8XIu5uFyXk37uBnV6CC4dNVkwJVh3wVt+cHOXLQ7IxuAo
         TJY6CtFlqVvZLTY0qix1BuyXUocgrMqhvnTK3Xb9KTiqDUpukvIbpNyGrwLq4OAQaJ
         WV61mxxD3w6EgFyMfT6I5QmqfGGmVFSZGmcE7T7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 196/206] drm/i915: Whitelist context-local timestamp in the gen9 cmdparser
Date:   Tue, 23 Jun 2020 21:58:44 +0200
Message-Id: <20200623195326.671414996@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 273500ae71711c040d258a7b3f4b6f44c368fff2 upstream.

Allow batch buffers to read their own _local_ cumulative HW runtime of
their logical context.

Fixes: 0f2f39758341 ("drm/i915: Add gen9 BCS cmdparsing")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.4+
Reviewed-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200601161942.30854-1-chris@chris-wilson.co.uk
(cherry picked from commit f9496520df11de00fbafc3cbd693b9570d600ab3)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_cmd_parser.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/i915/i915_cmd_parser.c
+++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
@@ -570,6 +570,9 @@ struct drm_i915_reg_descriptor {
 #define REG32(_reg, ...) \
 	{ .addr = (_reg), __VA_ARGS__ }
 
+#define REG32_IDX(_reg, idx) \
+	{ .addr = _reg(idx) }
+
 /*
  * Convenience macro for adding 64-bit registers.
  *
@@ -667,6 +670,7 @@ static const struct drm_i915_reg_descrip
 	REG64_IDX(RING_TIMESTAMP, BSD_RING_BASE),
 	REG32(BCS_SWCTRL),
 	REG64_IDX(RING_TIMESTAMP, BLT_RING_BASE),
+	REG32_IDX(RING_CTX_TIMESTAMP, BLT_RING_BASE),
 	REG64_IDX(BCS_GPR, 0),
 	REG64_IDX(BCS_GPR, 1),
 	REG64_IDX(BCS_GPR, 2),


