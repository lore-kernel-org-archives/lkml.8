Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD30C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F622070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgERLH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:07:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgERLH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:07:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12E60AE00;
        Mon, 18 May 2020 11:07:30 +0000 (UTC)
Subject: Re: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
To:     Michel Lespinasse <walken@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com> <20200424013958.GC158937@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <25ca9d8a-7c2a-b82e-f727-fcc940f19f2b@suse.cz>
Date:   Mon, 18 May 2020 13:07:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424013958.GC158937@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 3:39 AM, Michel Lespinasse wrote:
> Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> should now go through the new mmap locking api. The mmap_lock is
> still implemented as a rwsem, though this could change in the future.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>

Except gpu/drm/etnaviv/etnaviv_gem.c all direct users remain in mm or arch/fault
code so that seems fine.


Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


Any plan about all the code comments mentioning mmap_sem? :) Not urgent.
