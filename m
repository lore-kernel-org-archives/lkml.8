Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3216FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009C62467E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696096;
	bh=bsY2Ez2fjYKqL4INXHo6t0AnfkI2oIAHfv+cfuoZhC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UI/aS0zDo7ga5qalFwwvEv1foV+4fP5nuPyJo2czd/lDkFmToAzn+fE0youGk2P7O
	 An/XaMMEjCXenpAihGFnYuuy+rhBceVrVv5TP0Xx51bmcI0nh+dPeSX7vgJb0x/GvF
	 4gA5lxUOluH+46WxM3SlRypkyMeBMgc48alZH+ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbgBNQBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389077AbgBNQAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:00:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 767E9222C4;
        Fri, 14 Feb 2020 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696010;
        bh=bsY2Ez2fjYKqL4INXHo6t0AnfkI2oIAHfv+cfuoZhC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkG1wnt4RLjlWKSvt0IHl9mqEWyqSrALcPVIRlSe5nAeyEWvqNovK3cPo5pXebgZi
         29SveMxfD099PT8qj5pXZ2KWj0EMsbI9KQeS61y8ncWfj90NbVBj+TOkA09fCVZJLH
         nd5Y99v82pbU3ZMfvOhDuazAB1GfDM4MPjG8o5tE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 527/542] microblaze: Prevent the overflow of the start
Date:   Fri, 14 Feb 2020 10:48:39 -0500
Message-Id: <20200214154854.6746-527-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

[ Upstream commit 061d2c1d593076424c910cb1b64ecdb5c9a6923f ]

In case the start + cache size is more than the max int the
start overflows.
Prevent the same.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/microblaze/kernel/cpu/cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/cpu/cache.c b/arch/microblaze/kernel/cpu/cache.c
index 0bde47e4fa694..dcba53803fa5f 100644
--- a/arch/microblaze/kernel/cpu/cache.c
+++ b/arch/microblaze/kernel/cpu/cache.c
@@ -92,7 +92,8 @@ static inline void __disable_dcache_nomsr(void)
 #define CACHE_LOOP_LIMITS(start, end, cache_line_length, cache_size)	\
 do {									\
 	int align = ~(cache_line_length - 1);				\
-	end = min(start + cache_size, end);				\
+	if (start <  UINT_MAX - cache_size)				\
+		end = min(start + cache_size, end);			\
 	start &= align;							\
 } while (0)
 
-- 
2.20.1

