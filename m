Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5620DC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A42E2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200037;
	bh=nkN2iBCnT8Nzt9x5Yz5qfXfAW/ndK9fwwMNcpjVbPfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UUycryaR1feFGniYdHVqN7WvXLkSPq+B5nCX5208tJ16/YeonP+17ZjDBHJMTTlDP
	 jv5VH+PsxUGnZqLGK34MzjxRgL95uvh1w1KgRJ2zdEjY63frq752cHIBmh7dgeIn03
	 iDaW7pKtO3NRL2iV6ZccAyCgkbuZ73/9M4S+GzCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390387AbgAPRMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389121AbgAPRL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:11:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88DE24695;
        Thu, 16 Jan 2020 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194715;
        bh=nkN2iBCnT8Nzt9x5Yz5qfXfAW/ndK9fwwMNcpjVbPfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2jprDbSzBeKQ9FJXz3rZBlcrtxHeBC94iwglRGLJ/11whYrj6GFrvwxQiW7fAiXz
         9gPmzUL1CpPTpb/f52fgqghdhgwxjxwwXN7AjLsCvNrtul5QVl4avs9Gs8MyXxlxqY
         X8GxtCDlq6vMYMZzjGFXkhUq7trV1AoWvhl7i47Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 552/671] um: Fix off by one error in IRQ enumeration
Date:   Thu, 16 Jan 2020 12:03:10 -0500
Message-Id: <20200116170509.12787-289-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

[ Upstream commit 09ccf0364ca3e94aba4093707ef433ea8014e2a4 ]

Fix an off-by-one in IRQ enumeration

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Reported by: Dana Johnson <djohns042@gmail.com>
Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/include/asm/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 49ed3e35b35a..ce7a78c3bcf2 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -23,7 +23,7 @@
 #define VECTOR_BASE_IRQ		15
 #define VECTOR_IRQ_SPACE	8
 
-#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ)
+#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ - 1)
 
 #else
 
-- 
2.20.1

