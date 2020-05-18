Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D99AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5636D207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgERKmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:42:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:33096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgERKmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:42:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C680AA4F;
        Mon, 18 May 2020 10:42:54 +0000 (UTC)
Subject: Re: [PATCH v5 07/10] mmap locking API: add
 mmap_read_trylock_non_owner()
To:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-8-walken@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <afc8cb91-2620-99f3-9aaa-b6b2e80becba@suse.cz>
Date:   Mon, 18 May 2020 12:42:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422001422.232330-8-walken@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 2:14 AM, Michel Lespinasse wrote:
> Add a couple APIs used by kernel/bpf/stackmap.c only:
> - mmap_read_trylock_non_owner()
> - mmap_read_unlock_non_owner() (may be called from a work queue).
> 
> It's still not ideal that bpf/stackmap subverts the lock ownership
> in this way. Thanks to Peter Zijlstra for suggesting this API as the
> least-ugly way of addressing this in the short term.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Ugh... oh well.


Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

