Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F627C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3353420781
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584687232;
	bh=ExI1kfSKUVZS2XzqSdVhVyWr/Qtz6K6BVNxaXsqXMDs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qr8VmD6kreCjvJ7i5sLhb10g1u8NA914y8E+TreLHe42spjUwOeQAIlNjwQyC+5rc
	 KZB0+tXjAtpG7eqHv7DuXX35ZK9F6jKC2OwxBLyT3aW4XCiWVWKjfzG85qfGFtWzRp
	 0IrH9YqdQdseLYDIKzqHw3rI5xCI298G4Fb1deb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTGxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 02:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgCTGxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:53:51 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C14120776;
        Fri, 20 Mar 2020 06:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584687230;
        bh=ExI1kfSKUVZS2XzqSdVhVyWr/Qtz6K6BVNxaXsqXMDs=;
        h=From:To:Cc:Subject:Date:From;
        b=cKTqTZDshlB1lRM9r5dVcPtGnlFPxL7114xBariQgVvQYnFztpRP/lHmDAwPEUXoE
         c9pabuEMgWPyYBxmJoo+9VZneQ2Bbqds9K8r6DiLmWWsElk0VgeuxkC6dQAOAHaCkE
         2AL1UZbjx1sHhoI1/bEbhimr7XEpN3t7Y4ApGddg=
From:   guoren@kernel.org
To:     rostedt@goodmis.org, mingo@redhat.co, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] arm/ftrace: Remove duplicate function
Date:   Fri, 20 Mar 2020 14:53:40 +0800
Message-Id: <20200320065340.32685-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There is no arch implementation of ftrace_arch_code_modify_prepare in arm,
so just use the __weak one in kernel/trace/ftrace.c.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/arm/kernel/ftrace.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 10499d44964a..f66ade28eb8a 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -56,11 +56,6 @@ static unsigned long adjust_address(struct dyn_ftrace *rec, unsigned long addr)
 	return addr;
 }
 
-int ftrace_arch_code_modify_prepare(void)
-{
-	return 0;
-}
-
 int ftrace_arch_code_modify_post_process(void)
 {
 	/* Make sure any TLB misses during machine stop are cleared. */
-- 
2.17.0

