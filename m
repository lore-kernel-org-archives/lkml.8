Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28933C54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A99D20661
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229764;
	bh=+tRoV1zQ0//73ali8SYlLEhpdR7SHnV2xH8pWZqMG7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WIyVQ6zAa8JGBk7DAwecHNAPL2wBuWZ866wR4wy5cpiFAyV5SAZQ9U9X5XGbtDgFT
	 OVetdXpCptKVTx6lO7Hz6bktXNGYQuaQPKxTnC6d8QPyoy/Q+1uCIh2+LrncuobSDE
	 aJf5/HvQ+/YHCXQe6EuTMNSWcd5W+Mud43J5m8hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbgEKUmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731796AbgEKUmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:39 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28E720882;
        Mon, 11 May 2020 20:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229759;
        bh=+tRoV1zQ0//73ali8SYlLEhpdR7SHnV2xH8pWZqMG7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RW73rqLHB+0duL5gxFml+lEXq9zZ74eG32DWHOcB7mgKNt0+lpnXy4bjW+d4FCrRD
         o9MwdfdFfNIv5LPz88EW7jof3MBN7DCE3ee7A85aROuCKQ39C5PtUKBLSd/wyH8um1
         zFKTyW4BN4A0U8LgTRRRp3RnKbjioSCOrAVhz+P4=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and PTE tables
Date:   Mon, 11 May 2020 21:41:36 +0100
Message-Id: <20200511204150.27858-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the page table allocator can free page table allocations
smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
to avoid needlessly wasting memory.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/include/asm/pgtsrmmu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 58ea8e8c6ee7..7708d015712b 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -17,8 +17,8 @@
 /* Number of contexts is implementation-dependent; 64k is the most we support */
 #define SRMMU_MAX_CONTEXTS	65536
 
-#define SRMMU_PTE_TABLE_SIZE		(PAGE_SIZE)
-#define SRMMU_PMD_TABLE_SIZE		(PAGE_SIZE)
+#define SRMMU_PTE_TABLE_SIZE		(PTRS_PER_PTE*4)
+#define SRMMU_PMD_TABLE_SIZE		(PTRS_PER_PMD*4)
 #define SRMMU_PGD_TABLE_SIZE		(PTRS_PER_PGD*4)
 
 /* Definition of the values in the ET field of PTD's and PTE's */
-- 
2.26.2.645.ge9eca65c58-goog

