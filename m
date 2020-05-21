Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C28C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E5120890
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgEUPXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:23:22 -0400
Received: from foss.arm.com ([217.140.110.172]:48900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730018AbgEUPXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:23:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0546BD6E;
        Thu, 21 May 2020 08:23:16 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64EE13F305;
        Thu, 21 May 2020 08:23:14 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Jan Beulich <jbeulich@suse.com>
Cc:     Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/2] Fix W+X debug feature on x86
Date:   Thu, 21 May 2020 16:23:06 +0100
Message-Id: <20200521152308.33096-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan alert me[1] that the W+X detection debug feature was broken in x86
by my change[2] to switch x86 to use the generic ptdump infrastructure.

Fundamentally the approach of trying to move the calculation of
effective permissions into note_page() was broken because note_page() is
only called for 'leaf' entries and the effective permissions are passed
down via the internal nodes of the page tree. The solution I've taken
here is to create a new (optional) callback which is called for all
nodes of the page tree and therefore can calculate the effective
permissions.

Secondly on some configurations (32 bit with PAE) "unsigned long" is not
large enough to store the table entries. The fix here is simple - let's
just use a u64.

I'd welcome testing (and other comments), especially if you have a
configuration which previously triggered W+X warnings as I don't have
such a setup.

[1] https://lore.kernel.org/lkml/d573dc7e-e742-84de-473d-f971142fa319@suse.com/
[2] 2ae27137b2db ("x86: mm: convert dump_pagetables to use walk_page_range")

Steven Price (2):
  x86: mm: ptdump: Calculate effective permissions correctly
  mm: ptdump: Expand type of 'val' in note_page()

 arch/arm64/mm/dump.c          |  2 +-
 arch/x86/mm/dump_pagetables.c | 33 ++++++++++++++++++++-------------
 include/linux/ptdump.h        |  3 ++-
 mm/ptdump.c                   | 17 ++++++++++++++++-
 4 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.20.1

