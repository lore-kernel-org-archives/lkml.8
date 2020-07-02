Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F5520748
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653056;
	bh=m9K1TdQIxrOHqAYmq5AHa31I2/plW1whWCcb+4B3pbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qizq07DXP20yFk4srLXzaGICnER4brpnxcJYs3EOLBWrneBOX8MyYWD+ih6Ze+Xb8
	 OcvPCNeexfqTGpwW7yEcm2WYYi8UkAur/KC5zhprkqA4zK3Zir/csldX6m6+AeI0w5
	 Z0D4YeZVMHopItkUSgFs4+hKBo1Ee+Z2pP2fP7RA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgGBBYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbgGBBXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:23:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F1E520A8B;
        Thu,  2 Jul 2020 01:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653034;
        bh=m9K1TdQIxrOHqAYmq5AHa31I2/plW1whWCcb+4B3pbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1nVDof/olQY/KA/Ji0wsQ1xocTddhaUqSFDoVxyQR7qTsetTpqjZvvmos3XTVyFe
         B0yJyHv1wYL4yB+8F131FpyZABrMlhvMcpPyb7qM85TnaUcUloeorcMlYCbDD9Kf8F
         MofWiPAekCCFgqVmiH1yOEERjSyBz6d57pOMNbFY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Marco Elver <elver@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 48/53] x86/entry: Increase entry_stack size to a full page
Date:   Wed,  1 Jul 2020 21:21:57 -0400
Message-Id: <20200702012202.2700645-48-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit c7aadc09321d8f9a1d3bd1e6d8a47222ecddf6c5 ]

Marco crashed in bad_iret with a Clang11/KCSAN build due to
overflowing the stack. Now that we run C code on it, expand it to a
full page.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Reported-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200618144801.819246178@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3bcf27caf6c9f..d64b72346dd27 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -369,7 +369,7 @@ struct x86_hw_tss {
 #define IO_BITMAP_OFFSET_INVALID	(__KERNEL_TSS_LIMIT + 1)
 
 struct entry_stack {
-	unsigned long		words[64];
+	char	stack[PAGE_SIZE];
 };
 
 struct entry_stack_page {
-- 
2.25.1

