Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10555C43460
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A2B22C9D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281243;
	bh=GGUUnrT70vCshPJghf6krsi3BKNCu8O77QYQpIvqC9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IlJoVT+zfDPg7fSkpH27vFsU/BY7it8ph4RN31FsZ7oDXLd/RE0LW7UezzV/8Fu8Z
	 b71gr9oGVf4TnYK7nMAhcaF0kaT1P+4hWdMSYClL0G4r8f8rvdWLL5Uv2H8c4GDVJI
	 ginDF5oYzze+HPFjF2ZIeJJr3CeVR7x8y60VQY9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgGTVjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgGTVjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:39:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D0822BF5;
        Mon, 20 Jul 2020 21:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281152;
        bh=GGUUnrT70vCshPJghf6krsi3BKNCu8O77QYQpIvqC9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpLciazkAdfgR7dOUbS+nFL1d/PUAbhcn+XmkuiBRdHyRebVLjSpKdAf95EEySc7o
         q17iWBUiOOgDmzQ/xSr0zOuubzLkJoUF+u76pcVkP4oDIjZia31nwBJnAzuv2A1HIE
         opp5xt0xgesYFj4c/e8j86Bg/hD+NUSAwPxgXMCU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 18/19] RISC-V: Upgrade smp_mb__after_spinlock() to iorw,iorw
Date:   Mon, 20 Jul 2020 17:38:49 -0400
Message-Id: <20200720213851.407715-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213851.407715-1-sashal@kernel.org>
References: <20200720213851.407715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

[ Upstream commit 38b7c2a3ffb1fce8358ddc6006cfe5c038ff9963 ]

While digging through the recent mmiowb preemption issue it came up that
we aren't actually preventing IO from crossing a scheduling boundary.
While it's a bit ugly to overload smp_mb__after_spinlock() with this
behavior, it's what PowerPC is doing so there's some precedent.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/barrier.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index d4628e4b3a5ea..f4c92c91aa047 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -69,8 +69,16 @@ do {									\
  * The AQ/RL pair provides a RCpc critical section, but there's not really any
  * way we can take advantage of that here because the ordering is only enforced
  * on that one lock.  Thus, we're just doing a full fence.
+ *
+ * Since we allow writeX to be called from preemptive regions we need at least
+ * an "o" in the predecessor set to ensure device writes are visible before the
+ * task is marked as available for scheduling on a new hart.  While I don't see
+ * any concrete reason we need a full IO fence, it seems safer to just upgrade
+ * this in order to avoid any IO crossing a scheduling boundary.  In both
+ * instances the scheduler pairs this with an mb(), so nothing is necessary on
+ * the new hart.
  */
-#define smp_mb__after_spinlock()	RISCV_FENCE(rw,rw)
+#define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
 
 #include <asm-generic/barrier.h>
 
-- 
2.25.1

