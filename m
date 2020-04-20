Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40437C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8872074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgDTTvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:51:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:59880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgDTTvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:51:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42D0CAC20;
        Mon, 20 Apr 2020 19:51:41 +0000 (UTC)
Date:   Mon, 20 Apr 2020 12:48:13 -0700
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
Subject: Re: [PATCH v4 01/10] mmap locking API: initial implementation as
 rwsem wrappers
Message-ID: <20200420194813.v7m7tmqhuza6qzoi@linux-p48b>
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
 <20200415004353.130248-2-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200415004353.130248-2-walken@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020, Michel Lespinasse wrote:

>This change wraps the existing mmap_sem related rwsem calls into a new
>mmap locking API. There are two justifications for the new API:
>
>- At first, it provides an easy hooking point to instrument mmap_sem
>  locking latencies independently of any other rwsems.
>
>- In the future, it may be a starting point for replacing the rwsem
>  implementation with a different one, such as range locks.
>
>Signed-off-by: Michel Lespinasse <walken@google.com>
>Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

With one observation below.

>+static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
>+{
>+	downgrade_write(&mm->mmap_sem);
>+}

Shouldn't this really be just mmap_downgrade_write()? In locking
normally don't add the _lock at the end as it implies the operation
of acquiring the lock.

Thanks,
Davidlohr
