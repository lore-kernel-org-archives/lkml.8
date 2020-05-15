Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0203C20727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589563704;
	bh=ABe6HtCY2BXd5/kuL4vILx9xPHe8+HCzgvhneFJFTyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kxDWIK9SeLBWUKb3YdY8UxedpDhqUWf9YVufIEHkahGB0N84qRzTjKPWitwlPbxQk
	 80AXmzhIe5k1CVo1tS/SPu2VZKHZAs+ZUpsZoeCsQ/k3fcgLW8o3l27tB17FuhulJZ
	 +ruGxQJBDDf80O/7i6d+DoKHrlzPK1WxCWQ+ExWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEOR2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgEOR2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:28:17 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB162207DA;
        Fri, 15 May 2020 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563697;
        bh=ABe6HtCY2BXd5/kuL4vILx9xPHe8+HCzgvhneFJFTyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8Bq6TnL9F9NCbt6Nn3/Eifd+upKBoavceS4C7D/UHKa6I3fQ1C5JA+08R22FK84P
         tsHNSdBR7iXkE+esIPeR0qsd/EAs6d/+9zw36V/JLMVgYZio6erR905reXmUfnkBb/
         KLU94b9Y5U2Zn4rby6g+vUV7WHwL61PKSKauhK58=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: [PATCH 5/6] scs: Remove references to asm/scs.h from core code
Date:   Fri, 15 May 2020 18:27:55 +0100
Message-Id: <20200515172756.27185-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515172756.27185-1-will@kernel.org>
References: <20200515172756.27185-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/scs.h is no longer needed by the core code, so remove a redundant
header inclusion and update the stale Kconfig text.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/Kconfig | 4 ++--
 kernel/scs.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 45dfca9a98d3..2e6f843d87c4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -537,8 +537,8 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
 	bool
 	help
 	  An architecture should select this if it supports Clang's Shadow
-	  Call Stack, has asm/scs.h, and implements runtime support for shadow
-	  stack switching.
+	  Call Stack and implements runtime support for shadow stack
+	  switching.
 
 config SHADOW_CALL_STACK
 	bool "Clang Shadow Call Stack"
diff --git a/kernel/scs.c b/kernel/scs.c
index faf0ecd7b893..222a7a9ad543 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -10,7 +10,6 @@
 #include <linux/scs.h>
 #include <linux/slab.h>
 #include <linux/vmstat.h>
-#include <asm/scs.h>
 
 static struct kmem_cache *scs_cache;
 
-- 
2.26.2.761.g0e0b3e54be-goog

