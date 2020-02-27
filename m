Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82F6C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C9424672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgB0F4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:56:23 -0500
Received: from foss.arm.com ([217.140.110.172]:45994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgB0F4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:56:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FFDE30E;
        Wed, 26 Feb 2020 21:56:22 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0CC53F73B;
        Wed, 26 Feb 2020 21:56:18 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     vbabka@suse.cz, Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] mm/vma: some more minor changes
Date:   Thu, 27 Feb 2020 11:26:02 +0530
Message-Id: <1582782965-3274-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The motivation here is to consolidate VMA flags and helpers in generic
memory header and reduce code duplication when ever applicable. If there
are other possible similar instances which might be missing here, please
do let me me know. I will be happy to incorporate them.

This series is based on v5.6-rc3. This series has been build tested on
multiple platforms but boot tested only on arm64 and x86.

Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org

Changes in V2:

- Moved VM_NO_KHUGEPAGED after VM_SPECIAL with a comment per Vlastimil
- Renamed is_vma_temporary_stack() as vma_is_temporary_stack() per Vlastimil

Changes in V1: (https://patchwork.kernel.org/cover/11405177/)

Anshuman Khandual (3):
  mm/vma: Move VM_NO_KHUGEPAGED into generic header
  mm/vma: Make vma_is_foreign() available for general use
  mm/vma: Make is_vma_temporary_stack() available for general use

 arch/powerpc/mm/book3s64/pkeys.c   | 12 ------------
 arch/x86/include/asm/mmu_context.h | 15 ---------------
 include/linux/huge_mm.h            |  4 +---
 include/linux/mm.h                 | 29 ++++++++++++++++++++++++++++-
 mm/khugepaged.c                    |  4 +---
 mm/mremap.c                        |  2 +-
 mm/rmap.c                          | 16 +---------------
 7 files changed, 32 insertions(+), 50 deletions(-)

-- 
2.20.1

