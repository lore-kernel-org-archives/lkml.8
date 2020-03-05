Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBBFC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F324B20637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583429029;
	bh=BhyIfmtJjmMPuNVk8eJ8v3alPCrVguYeSygPeKGfx1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LZnx8UoU3YeVQ+J7tnpy4lsTmC8c2WvT1sMPrKtxlrd3t5up1hW971w/a8fwn7YH7
	 iybr9XvjSoX1vBB/H7AEq9GJqZzrmCFZvV1b1q8Av/95N6WLJCE7wAwEQk/LWgYote
	 gBv1AqJlT0q8q8C1ESsLrUzIyTrq6YyXo2zlmF5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgCERXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgCERNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:13:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6DF21556;
        Thu,  5 Mar 2020 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428416;
        bh=BhyIfmtJjmMPuNVk8eJ8v3alPCrVguYeSygPeKGfx1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uT5Tryw1uX7mfyLsNfwExEo+YmWtvlKwjjMzOlIt1ZKliN6mYss8r/NOTjkHY6Wqw
         NzyXJI9c9LU+/upBOxlj7CqIyDyNPTi6oThwDFOjbQ5f34jD+U6UDSSumfOgB1vdL0
         Or0SNZIlBxB+bWXevU9PYhR0dO72ByXJMxU0A4TI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 19/67] RISC-V: Don't enable all interrupts in trap_init()
Date:   Thu,  5 Mar 2020 12:12:20 -0500
Message-Id: <20200305171309.29118-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171309.29118-1-sashal@kernel.org>
References: <20200305171309.29118-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

[ Upstream commit 6a1ce99dc4bde564e4a072936f9d41f4a439140e ]

Historically, we have been enabling all interrupts for each
HART in trap_init(). Ideally, we should only enable M-mode
interrupts for M-mode kernel and S-mode interrupts for S-mode
kernel in trap_init().

Currently, we get suprious S-mode interrupts on Kendryte K210
board running M-mode NO-MMU kernel because we are enabling all
interrupts in trap_init(). To fix this, we only enable software
and external interrupt in trap_init(). In future, trap_init()
will only enable software interrupt and PLIC driver will enable
external interrupt using CPU notifiers.

Fixes: a4c3733d32a7 ("riscv: abstract out CSR names for supervisor vs machine mode")
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Tested-by: Palmer Dabbelt <palmerdabbelt@google.com> [QMEU virt machine with SMP]
[Palmer: Move the Fixes up to a newer commit]
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f4cad5163bf2c..ffb3d94bf0cc2 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -156,6 +156,6 @@ void __init trap_init(void)
 	csr_write(CSR_SCRATCH, 0);
 	/* Set the exception vector address */
 	csr_write(CSR_TVEC, &handle_exception);
-	/* Enable all interrupts */
-	csr_write(CSR_IE, -1);
+	/* Enable interrupts */
+	csr_write(CSR_IE, IE_SIE | IE_EIE);
 }
-- 
2.20.1

