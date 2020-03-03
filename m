Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09E8C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFC52072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583259204;
	bh=4BypovxFTpsOw6CslQIrS8l2iIcg0DbMZ7zyR66ltGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nsqw60RQyoG6Vr5jnaL2vgppOHPnBThrvlS8k0nByOMOzxLcmqjg91ZHaX0WmYDU6
	 XvZnfzO7DKhuX1WWkmqXYXkrbWkaP2gUf0urdPxdgaUEtEsU/45zcgdL4SsAODNJa/
	 pyTFPLvmjgsTvSOi7WeG/qblJ9XSxu9Tp/U6LJBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733068AbgCCSNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730594AbgCCRqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:46:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150FB215A4;
        Tue,  3 Mar 2020 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257599;
        bh=4BypovxFTpsOw6CslQIrS8l2iIcg0DbMZ7zyR66ltGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1TydXCepXCf4KdHSAb8+kR2D6fXgCDmoQluoHeEbryoOedM0xLInZTnspOQx0DGL
         vWBA0OfavgDrAJLmq2tqn5I2VikH/hbPwUttJvETGX7psjHEvRamfcAwfjF9vsyUlK
         cvTtI5sPBEXiOf2eaKZCQcnIWMjJ6nHPmH0z4+II=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 039/176] arm/ftrace: Fix BE text poking
Date:   Tue,  3 Mar 2020 18:41:43 +0100
Message-Id: <20200303174309.037410397@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit be993e44badc448add6a18d6f12b20615692c4c3 ]

The __patch_text() function already applies __opcode_to_mem_*(), so
when __opcode_to_mem_*() is not the identity (BE*), it is applied
twice, wrecking the instruction.

Fixes: 42e51f187f86 ("arm/ftrace: Use __patch_text()")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/ftrace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index bda949fd84e8b..93caf757f1d5d 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -81,13 +81,10 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 {
 	unsigned long replaced;
 
-	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
 		old = __opcode_to_mem_thumb32(old);
-		new = __opcode_to_mem_thumb32(new);
-	} else {
+	else
 		old = __opcode_to_mem_arm(old);
-		new = __opcode_to_mem_arm(new);
-	}
 
 	if (validate) {
 		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
-- 
2.20.1



