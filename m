Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F43CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713EE24673
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865778;
	bh=G7yiM4Mx4FQY3C0RGbZOxU31hHPfQB51XNmbhiDL2CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V/umjXqDe8D6Fs8EbYx+bVbGlwAt13EDe4lFX4ZwvI6HdB9tyLyeg9sA4cwMepO0j
	 rk37w4YHEFi/7Ho/dzYUk+0VPAG2USbg1OhAF5yGvGOJf57yrMPpRHc9Vv9gn79pF1
	 i6iBPLPFISrMQDSwFxIoaUOHZcXMPYLUaDH/Za6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404757AbgAXLgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404494AbgAXLcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:32:48 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01BA20718;
        Fri, 24 Jan 2020 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865567;
        bh=G7yiM4Mx4FQY3C0RGbZOxU31hHPfQB51XNmbhiDL2CQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BP7B99ffkboJcWATw2voNa1lNNAPnfPrrNlAb2ONc7OLd1jOtTMPeob2GhTIccRvF
         0nlU5aYYFAppgbNZYTlc1KZFyXnAHfBQVUP8xDc2MJvTEaMwRZzmmL1msDQC+Mctgh
         aNdJQIYdu/Cr+OT2XnqHRNN8AfpR0oPZgaVaSExs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 565/639] um: Fix off by one error in IRQ enumeration
Date:   Fri, 24 Jan 2020 10:32:15 +0100
Message-Id: <20200124093200.123988574@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 49ed3e35b35ad..ce7a78c3bcf21 100644
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



