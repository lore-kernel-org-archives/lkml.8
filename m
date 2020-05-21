Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D41C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DD220826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgEUPX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:23:26 -0400
Received: from foss.arm.com ([217.140.110.172]:48946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbgEUPXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:23:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4ED61063;
        Thu, 21 May 2020 08:23:19 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 259183F305;
        Thu, 21 May 2020 08:23:18 -0700 (PDT)
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
Subject: [PATCH 2/2] mm: ptdump: Expand type of 'val' in note_page()
Date:   Thu, 21 May 2020 16:23:08 +0100
Message-Id: <20200521152308.33096-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521152308.33096-1-steven.price@arm.com>
References: <20200521152308.33096-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page table entry is passed in the 'val' argument to note_page(),
however this was previously an "unsigned long" which is fine on 64-bit
platforms. But for 32 bit x86 it is not always big enough to contain a
page table entry which may be 64 bits.

Change the type to u64 to ensure that it is always big enough.

Reported-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/mm/dump.c          | 2 +-
 arch/x86/mm/dump_pagetables.c | 2 +-
 include/linux/ptdump.h        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 860c00ec8bd3..d4313bc0c4c1 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -247,7 +247,7 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 }
 
 static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
-		      unsigned long val)
+		      u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	static const char units[] = "KMGTPE";
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 199bbb7fbd79..17aa7ac94a34 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -273,7 +273,7 @@ static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
  * print what we collected so far.
  */
 static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
-		      unsigned long val)
+		      u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	pgprotval_t new_prot, new_eff;
diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
index ac01502763bf..2a3a95586425 100644
--- a/include/linux/ptdump.h
+++ b/include/linux/ptdump.h
@@ -13,7 +13,7 @@ struct ptdump_range {
 struct ptdump_state {
 	/* level is 0:PGD to 4:PTE, or -1 if unknown */
 	void (*note_page)(struct ptdump_state *st, unsigned long addr,
-			  int level, unsigned long val);
+			  int level, u64 val);
 	void (*effective_prot)(struct ptdump_state *st, int level, u64 val);
 	const struct ptdump_range *range;
 };
-- 
2.20.1

