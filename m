Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA910C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862B420715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgGFBUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:20:09 -0400
Received: from foss.arm.com ([217.140.110.172]:45830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbgGFBUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:20:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76057C0A;
        Sun,  5 Jul 2020 18:20:07 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 111313F718;
        Sun,  5 Jul 2020 18:20:03 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kaly Xin <Kaly.Xin@arm.com>,
        Jia He <justin.he@arm.com>
Subject: [PATCH 1/3] arm64/numa: set numa_off to false when numa node is fake
Date:   Mon,  6 Jul 2020 09:19:45 +0800
Message-Id: <20200706011947.184166-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706011947.184166-1-justin.he@arm.com>
References: <20200706011947.184166-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, numa_off is set to true unconditionally in dummy_numa_init(),
even if there is a fake numa node.

But acpi will translate node id to NUMA_NO_NODE(-1) in acpi_map_pxm_to_node()
because it regards numa_off as turning off the numa node.

Without this patch, pmem can't be probed as a RAM device on arm64 if SRAT table
isn't present.

$ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -a 64K
kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with invalid node: -1
kmem: probe of dax0.0 failed with error -22

This fixes it by setting numa_off to false.

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/mm/numa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index aafcee3e3f7e..7689986020d9 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -440,7 +440,8 @@ static int __init dummy_numa_init(void)
 		return ret;
 	}
 
-	numa_off = true;
+	/* force numa_off to be false since we have a fake numa node here */
+	numa_off = false;
 	return 0;
 }
 
-- 
2.17.1

