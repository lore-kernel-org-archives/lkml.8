Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA6CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B833C2245F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgEVOWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:22:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgEVOV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:21:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EC6FAAD12;
        Fri, 22 May 2020 14:22:00 +0000 (UTC)
Subject: Re: [PATCH v6 12/12] mmap locking API: convert mmap_sem comments
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20200520052908.204642-1-walken@google.com>
 <20200520052908.204642-13-walken@google.com>
 <e01060e9-6f00-7fa8-5da0-c9250c951d10@suse.cz>
 <CANN689GXWS9yHTw0aN-tAkd9tyA-vRn0GbJgC+Td=1r13KBZzA@mail.gmail.com>
 <20200521102516.01dbc9fcc539baba96224c3f@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9858cd98-b303-beb4-82f6-52f902f98772@suse.cz>
Date:   Fri, 22 May 2020 16:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521102516.01dbc9fcc539baba96224c3f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/20 7:25 PM, Andrew Morton wrote:
> On Thu, 21 May 2020 00:50:56 -0700 Michel Lespinasse <walken@google.com> wrote:
> 
>> > >   * Must be called holding task's alloc_lock to protect task's mems_allowed
>> > > - * and mempolicy.  May also be called holding the mmap_semaphore for write.
>> > > + * and mempolicy.  May also be called holding the mmap_lockaphore for write.
>> > >   */
>> > >  static int mpol_set_nodemask(struct mempolicy *pol,
>> > >                    const nodemask_t *nodes, struct nodemask_scratch *nsc)
>> >
>> > :)
>> 
>> Haha, good catch !
> 
> aww, you're all so cruel.  The world would be a better place if Linux
> had lockaphores!

Heh, in fact it does have them, but they are called "btrfs extent buffer locks",
see (or perhaps rather not) fs/btrfs/locking.c :)



