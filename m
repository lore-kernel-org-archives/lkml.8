Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F8BC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7270D206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgDTTyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:54:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:32990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgDTTyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:54:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CE4BDAB5F;
        Mon, 20 Apr 2020 19:54:38 +0000 (UTC)
Date:   Mon, 20 Apr 2020 12:51:12 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v4 02/10] MMU notifier: use the new mmap locking API
Message-ID: <20200420195112.uy7xb4d4kltp6cnz@linux-p48b>
Mail-Followup-To: Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200415004353.130248-1-walken@google.com>
 <20200415004353.130248-3-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200415004353.130248-3-walken@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020, Michel Lespinasse wrote:

>This use is converted manually ahead of the next patch in the series,
>as it requires including a new header which the automated conversion
>would miss.
>
>Signed-off-by: Michel Lespinasse <walken@google.com>
>Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

>---
> include/linux/mmu_notifier.h | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
>index 736f6918335e..2f462710a1a4 100644
>--- a/include/linux/mmu_notifier.h
>+++ b/include/linux/mmu_notifier.h
>@@ -5,6 +5,7 @@
> #include <linux/list.h>
> #include <linux/spinlock.h>
> #include <linux/mm_types.h>
>+#include <linux/mmap_lock.h>
> #include <linux/srcu.h>
> #include <linux/interval_tree.h>
>
>@@ -277,9 +278,9 @@ mmu_notifier_get(const struct mmu_notifier_ops *ops, struct mm_struct *mm)
> {
> 	struct mmu_notifier *ret;
>
>-	down_write(&mm->mmap_sem);
>+	mmap_write_lock(mm);
> 	ret = mmu_notifier_get_locked(ops, mm);
>-	up_write(&mm->mmap_sem);
>+	mmap_write_unlock(mm);
> 	return ret;
> }
> void mmu_notifier_put(struct mmu_notifier *subscription);
>-- 
>2.26.0.110.g2183baf09c-goog
>
