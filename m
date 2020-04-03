Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9672AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAE220B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585888946;
	bh=nvZcsugJL+0E5wF9e5T9iUO1QUbFqyTqIZWR5uk6nKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nld0DwJxrtEytxqYsALqMYrMdS4A7MQwVZNIO/0lFhe3jBocKCfxjS0ogIi4I+cve
	 4o6USdCSc30/FpvnKsO6xklJBzqJQ/eldZVBbiO0EVKKI4GU1eJT3SLT/5QtZNwLLt
	 ZcKZsp7/kMS9rqHVdtgks/NwhZ4RmS1x71CJTfaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgDCEmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732873AbgDCEmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:18 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C27C208E4;
        Fri,  3 Apr 2020 04:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585888937;
        bh=nvZcsugJL+0E5wF9e5T9iUO1QUbFqyTqIZWR5uk6nKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcWYeFuqCCZ3dwgpfJ+FWtt4vQ1YSzi2xfCfuCM2H0KETmlyiGcQtBAsUoB5GP4Nh
         bcPrEppfNJl4gTYw6XteN6HWmh4wBSl0pGRWAWAK+WCvx3mY/zsgcn+qqKrTJ5cXSc
         YDkvMKtOHPRzxazDAWtyrcU7qIQ6SPDy8PWGcdAU=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Ma Jun <majun258@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 07/11] csky: Enable the gcov function
Date:   Fri,  3 Apr 2020 12:41:46 +0800
Message-Id: <20200403044150.20562-7-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200403044150.20562-1-guoren@kernel.org>
References: <20200403044150.20562-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Jun <majun258@linux.alibaba.com>

Support the gcov function in csky architecture.

Signed-off-by: Ma Jun <majun258@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 6cf169a15794..a75b8e1fef1d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -3,6 +3,7 @@ config CSKY
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
-- 
2.17.0

