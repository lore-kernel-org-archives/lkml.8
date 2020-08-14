Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEDDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45C820866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHNPUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:20:05 -0400
Received: from 8bytes.org ([81.169.241.247]:35856 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgHNPUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:20:04 -0400
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de [79.242.187.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id A5D3F1E6;
        Fri, 14 Aug 2020 17:20:01 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, hpa@zytor.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason@zx2c4.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kirill.shutemov@intel.com,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 0/2] x86: Retry to remove vmalloc/ioremap synchronzation
Date:   Fri, 14 Aug 2020 17:19:45 +0200
Message-Id: <20200814151947.26229-1-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

as discussed here are the updates to the recent patches and fixes to
pre-allocate the vmalloc/ioremap second-level page-table pages on
x86-64.

Patch one is a re-send of

	commit 8bb9bf242d1f ("x86/mm/64: Do not sync vmalloc/ioremap mappings")

with more explanations about what broke, what fixed it and why its now
safe to apply it again.

Patch two updates the comment in preallocate_vmalloc_pages(), it is
mostly the wording from Dave Hansen, so he really deserved the
authorship of it. I just didn't want to commit/send it in his name.
Feel free to change authorship of this patch to him.

Regards,

	Joerg

Joerg Roedel (2):
  x86/mm/64: Do not sync vmalloc/ioremap mappings
  x86/mm/64: Update comment in preallocate_vmalloc_pages()

 arch/x86/include/asm/pgtable_64_types.h |  2 --
 arch/x86/mm/init_64.c                   | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

-- 
2.28.0

