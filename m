Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AB0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7679A2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202363;
	bh=1Y83ZRy4JQGM0BUTA/qOSFth1ukzvcOryxz+QvYzsxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=corLVBni98iIbIAfG9Xhn9w/m7rTN3VgxtV6xmuZ2wG+qiczWNkl/M1F4IVJf8ZIS
	 BzLzAgS7UyOIaPf27Qs1abq/gjPm8ejNE7uvLimQDVl2Twgi6QlmMkfOYtwCZbFN8P
	 uD+SgDtfQHr6NYyoba8R2dvk5iCcIbzY+evIQoX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAPTTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbgAPQyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:54:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5658D22525;
        Thu, 16 Jan 2020 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193662;
        bh=1Y83ZRy4JQGM0BUTA/qOSFth1ukzvcOryxz+QvYzsxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGDPjtpQlr5FysV9vC0FzVLcxEwxmczDi9JeRBt6N69hq/Qiq5aXn8AiU+EBMNSvd
         6Z9sNTuPjB+funRi5cpppEnQCQ1i/Ai4wHxejfH/CF3BXQn0Fc59qdKQRie/pXUvJJ
         Db9LxnkqRKvsYCvu+Q5F/Pg37SBvPvLsMIMIhgQo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Lexi Shao <shaolexi@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 189/205] powerpc/kasan: Fix boot failure with RELOCATABLE && FSL_BOOKE
Date:   Thu, 16 Jan 2020 11:42:44 -0500
Message-Id: <20200116164300.6705-189-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 71eb40fc53371bc247c8066ae76ad9e22ae1e18d ]

When enabling CONFIG_RELOCATABLE and CONFIG_KASAN on FSL_BOOKE,
the kernel doesn't boot.

relocate_init() requires KASAN early shadow area to be set up because
it needs access to the device tree through generic functions.

Call kasan_early_init() before calling relocate_init()

Reported-by: Lexi Shao <shaolexi@huawei.com>
Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/b58426f1664a4b344ff696d18cacf3b3e8962111.1575036985.git.christophe.leroy@c-s.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/head_fsl_booke.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index adf0505dbe02..519d49547e2f 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -238,6 +238,9 @@ set_ivor:
 
 	bl	early_init
 
+#ifdef CONFIG_KASAN
+	bl	kasan_early_init
+#endif
 #ifdef CONFIG_RELOCATABLE
 	mr	r3,r30
 	mr	r4,r31
@@ -264,9 +267,6 @@ set_ivor:
 /*
  * Decide what sort of machine this is and initialize the MMU.
  */
-#ifdef CONFIG_KASAN
-	bl	kasan_early_init
-#endif
 	mr	r3,r30
 	mr	r4,r31
 	bl	machine_init
-- 
2.20.1

