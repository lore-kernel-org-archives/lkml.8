Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1496C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BD520829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SFqwTAVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgG3QMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:12:44 -0400
Received: from crapouillou.net ([89.234.176.41]:46982 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3QMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596125561; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=4UC5bN4C11HykhL6jcWAyq2cNXGmAe0l6v/GKa5hpCM=;
        b=SFqwTAVXyt5/QqdVrTJJqTsoraPX+mj2SLqfbWIh9748jBha+th241DbIgs37ngAPh6W6x
        Eov0wNaCpN6UGlztkNMSt6q8xky2mTwpo82jhTM+DMII5ttFKAQKpLyJcgo3rDWwCVzEJR
        QdvCWO1Vkls7RRlJp/4MS9tQmAlExXE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/4] MIPS: head.S: Init fw_passed_dtb to builtin DTB
Date:   Thu, 30 Jul 2020 18:12:30 +0200
Message-Id: <20200730161233.61876-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init the 'fw_passed_dtb' pointer to the buit-in Device Tree blob when it
has been compiled in with CONFIG_BUILTIN_DTB.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/kernel/head.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 3b02ffe46304..7dd234e788e6 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -111,6 +111,12 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	move		t2, a1
 	beq		a0, t1, dtb_found
 
+#ifdef CONFIG_BUILTIN_DTB
+	PTR_LA	t2, __dtb_start
+	PTR_LA	t1, __dtb_end
+	bne		t1, t2, dtb_found
+#endif /* CONFIG_BUILTIN_DTB */
+
 	li		t2, 0
 dtb_found:
 #endif /* CONFIG_USE_OF */
-- 
2.27.0

