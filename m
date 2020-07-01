Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16281C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5FA2078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgGAIin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:38:43 -0400
Received: from 8bytes.org ([81.169.241.247]:50918 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgGAIim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:38:42 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F316D2F9; Wed,  1 Jul 2020 10:38:40 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 0/3] x86/mm/64: Remove vmalloc/ioremap pgtable synchronization
Date:   Wed,  1 Jul 2020 10:38:35 +0200
Message-Id: <20200701083839.19193-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a small patch-set to implement pre-allocation of the P4D/PUD
pages in the vmalloc/ioremap area of the address space. This allows to
remove the synchronization of these mappings for x86-64 and unexporting
the sync_global_pgds() function.

Please review.

Thanks,

	Joerg

Changes to v1:

	- Made failure at pre-allocation stage fatal
	- As a consequence removed the arch_sync_kernel_mappings()
	  implementation for x86-64
	- Unexported sync_global_pgds()
	- Removed some left-over debug code from the first patch

Joerg Roedel (3):
  x86/mm/64: Pre-allocate p4d/pud pages for vmalloc area
  x86/mm/64: Do not sync vmalloc/ioremap mappings
  x86/mm/64: Make sync_global_pgds() static

 arch/x86/include/asm/pgtable_64.h       |  2 -
 arch/x86/include/asm/pgtable_64_types.h |  2 -
 arch/x86/mm/init_64.c                   | 59 ++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 10 deletions(-)

-- 
2.17.1

