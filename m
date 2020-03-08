Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E8C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916C120828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583661207;
	bh=HM4Ww0uWHBrydUOUYxNwt5jptdKmQsMTeZBPstuaVQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bxZj6GbBnhMQN2vF/84xHIzaIfALiYtdhIqFl3wqn/PAk9+yIFxWzkEJgZdSNk+0O
	 qx5AHvPVUB2FCj/3BXEbIWvefVCKG/ArFHOWmDU438SWrirbDXzeaB7UEEzo3Rk5b8
	 ZfIsa4GfdcOsKNVLpb0NBNS9A7QCvJxg4X29hfLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCHJx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 05:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgCHJxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 05:53:25 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E4C20848;
        Sun,  8 Mar 2020 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661204;
        bh=HM4Ww0uWHBrydUOUYxNwt5jptdKmQsMTeZBPstuaVQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeKMEkTuKD7iOgpr5jw2zTvo1TUCqFYm1IuvQSsQ0YQhXtYd52WGFNizPCBNV213q
         mWwBpGN4ms4i7FE+SttanGNhum/JWnt9Y4BrE1asn5GQJD8ggxnEzAsl3uX/2ihmE2
         5lWFY3HZkskcIdUL70Dm0snQYzz/Jj5tFpKJOfMQ=
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com,
        greentime.hu@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH V3 02/11] riscv: Rename __switch_to_aux -> fpu
Date:   Sun,  8 Mar 2020 17:49:45 +0800
Message-Id: <20200308094954.13258-3-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
References: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

From: Guo Ren <ren_guo@c-sky.com>

The name of __switch_to_aux is not clear and rename it with the
determine function: __switch_to_fpu. Next we could add other regs'
switch.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/switch_to.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 407bcc96a710..b9234e7178d0 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -44,7 +44,7 @@ static inline void fstate_restore(struct task_struct *task,
 	}
 }
 
-static inline void __switch_to_aux(struct task_struct *prev,
+static inline void __switch_to_fpu(struct task_struct *prev,
 				   struct task_struct *next)
 {
 	struct pt_regs *regs;
@@ -60,7 +60,7 @@ extern bool has_fpu;
 #define has_fpu false
 #define fstate_save(task, regs) do { } while (0)
 #define fstate_restore(task, regs) do { } while (0)
-#define __switch_to_aux(__prev, __next) do { } while (0)
+#define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
 extern struct task_struct *__switch_to(struct task_struct *,
@@ -71,7 +71,7 @@ do {							\
 	struct task_struct *__prev = (prev);		\
 	struct task_struct *__next = (next);		\
 	if (has_fpu)					\
-		__switch_to_aux(__prev, __next);	\
+		__switch_to_fpu(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
-- 
2.17.0

