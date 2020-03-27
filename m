Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B59C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 04:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280E120675
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 04:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgC0EuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 00:50:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:47406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgC0EuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 00:50:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 99DC0AE87;
        Fri, 27 Mar 2020 04:50:11 +0000 (UTC)
Date:   Thu, 26 Mar 2020 21:48:30 -0700
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
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v2 09/10] mmap locking API: use lockdep_assert_held
Message-ID: <20200327044830.qw74dvaxkjg75fh5@linux-p48b>
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
        Markus Elfring <Markus.Elfring@web.de>
References: <20200327021058.221911-1-walken@google.com>
 <20200327021058.221911-10-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200327021058.221911-10-walken@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020, Michel Lespinasse wrote:

>Use lockdep_assert_held when asserting that mmap_sem is held.
>
>Using this instead of rwsem_is_locked makes the assertions more
>tolerant of future changes to the lock type.

Not opposing here, just worth mentioning that the coverage surface
is greatly reduced, lockdep not being very popular in production.

Thanks,
Davidlohr
