Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB121C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE43207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589829325;
	bh=X4wI/Pi/dLltPRB3hRK89e/zukj0Cxkq+d6hZJCpsKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F46NoCg3iCKTJK8N3y+4OVCOc8n3LoYB1dAyMg2FIlloJAAqNYkDWMpvAFL1096k7
	 fKUWP+qWLO/7Wtzje+SESqPULtfPwz7FNOirc7zMPotkRV9eRxxl3LRBshWL8PUd6w
	 sAMTCszmOLsb3HS88ND1jnwHhXbm4pY6aVjC/JBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgERTPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgERTPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:15:24 -0400
Received: from kernel.org (unknown [87.71.47.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAEBF20657;
        Mon, 18 May 2020 19:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589829323;
        bh=X4wI/Pi/dLltPRB3hRK89e/zukj0Cxkq+d6hZJCpsKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIXEkXTPPBw8odzrRPOyh3N+C+/qFTle9rnvWhLNBfYyZqoZ1OsMotaU9sGT7ts5e
         55eoYfM8ShDjgphigStUlJ1rVHt56ggoETpiuVbuJhezYqZfr5wLoCH6yt0D8osuo/
         R7P9YfzIsnePtT84bcMsh9qXUYuQbOhimpjdjXwY=
Date:   Mon, 18 May 2020 22:15:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200518191511.GD1118872@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <418aa44b-6fb3-c3d8-a920-1a26e5edec62@roeck-us.net>
 <20200518142310.GC1118872@kernel.org>
 <b171fbbd-f5b2-ac17-24e5-7188f6ce80f0@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b171fbbd-f5b2-ac17-24e5-7188f6ce80f0@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:09:46AM -0700, Guenter Roeck wrote:
> On 5/18/20 7:23 AM, Mike Rapoport wrote:
> 
> Below is another set of bisect results, from next-20200518. It points to one
> of your commits. This is for microblaze (big endian) boot failures.

The microblaze one was easy, as for sparc32 I still have no clue for the
root cause :(

Andrew, can you please fold it into "mm: pgtable: add shortcuts for
accessing kernel PMD and PTE"? 

From 167250de28aa526342641b2647294a755d234090 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 18 May 2020 22:08:10 +0300
Subject: [PATCH] microblaze: fix page table traversal in setup_rt_frame()

The replacement of long folded page table traversal with the direct access
to PMD entry wrongly used the kernel page table in setup_rt_frame()
function instead of the process (current->mm) page table.

Fix it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/microblaze/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index 28b1ec4b4e79..bdd6d0c86e16 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -194,7 +194,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 
 	address = ((unsigned long)frame->tramp);
 #ifdef CONFIG_MMU
-	pmdp = pmd_off_k(address);
+	pmdp = pmd_off(current->mm, address);
 
 	preempt_disable();
 	ptep = pte_offset_map(pmdp, address);
-- 
2.26.2


> Guenter
> 
> ---

-- 
Sincerely yours,
Mike.
