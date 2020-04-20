Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDE4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C8020775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iDbMYWuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgDTOz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:55:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62390 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgDTOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:55:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587394556; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=7MhmolhOBg+potQk9sjLeyxXiHqBAvP6Cxd5Xrm2ty4=; b=iDbMYWuEUd9rBgcUKpFGYdbHV7LJNkOmxswH5RU7wsqpukzaQPkJ/pz4zVGcRRslOaP1VE72
 PAo0Vy5Znp6aGHp2xe5zVbXm7xLYCc+vSwND0YD9exEC+fUdstD8oQyZZJDVwpFld43Akd16
 mflHfy6jCt0Bex0OEClIBMNTYI4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9db7ef.7f8e566372d0-smtp-out-n04;
 Mon, 20 Apr 2020 14:55:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C0B8C433F2; Mon, 20 Apr 2020 14:55:42 +0000 (UTC)
Received: from congzhan-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: congzhan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE7D4C433D2;
        Mon, 20 Apr 2020 14:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE7D4C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=congzhan@codeaurora.org
From:   Cong Zhang <congzhan@codeaurora.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cong Zhang <congzhan@codeaurora.org>
Subject: [PATCH] ARM: align the start and end of v7_setup_stack to cache line
Date:   Mon, 20 Apr 2020 22:50:35 +0800
Message-Id: <1587394235-24008-1-git-send-email-congzhan@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v7_setup_stack is used when D-cache disabled. When CPU is reading
something nearby with D-cache enabled. It is possible to read
v7_setup_stack to cache line. There is a risk that when cache line write
back the data, v7_setup_stack may already been modified by other CPU with
D-cache disabled.
The change make v7_setup_stack align cache line size and use the whole
cache line to prevent corrupting v7_setup_stack.

Signed-off-by: Cong Zhang <congzhan@codeaurora.org>
---
 arch/arm/mm/proc-v7.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 339eb17..587e2eb 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -18,6 +18,7 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
 #include <asm/memory.h>
+#include <asm/cache.h>
 
 #include "proc-macros.S"
 
@@ -548,10 +549,10 @@ __v7_setup_stack_ptr:
 ENDPROC(__v7_setup)
 
 	.bss
-	.align	2
+	.align	L1_CACHE_SHIFT
 __v7_setup_stack:
 	.space	4 * 7				@ 7 registers
-
+	.align	L1_CACHE_SHIFT
 	__INITDATA
 
 	.weak cpu_v7_bugs_init
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
