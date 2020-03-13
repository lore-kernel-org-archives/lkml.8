Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C24C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CF02072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgCMOqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:46:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgCMOqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:46:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A3D4AC46;
        Fri, 13 Mar 2020 14:46:29 +0000 (UTC)
Subject: Re: [PATCH v2] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
To:     Matthew Wilcox <willy@infradead.org>,
        Wei Yang <richard.weiyang@gmail.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        david@redhat.com
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312133416.GI22433@bombadil.infradead.org>
 <20200312141826.djb7osbekhcnuexv@master>
 <20200312142535.GK22433@bombadil.infradead.org>
 <20200312225055.ksn4ujtkpjgkqiaf@master>
 <20200313000041.GM22433@bombadil.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c5b8328f-a46f-6f5b-2ef0-e1d8a375fa8e@suse.cz>
Date:   Fri, 13 Mar 2020 15:46:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313000041.GM22433@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 1:00 AM, Matthew Wilcox wrote:
> On Thu, Mar 12, 2020 at 10:50:55PM +0000, Wei Yang wrote:
>> On Thu, Mar 12, 2020 at 07:25:35AM -0700, Matthew Wilcox wrote:
>> >Yes, I thought about that.  I decided it wasn't a problem, as long as
>> >the struct page remains aligned, and we now have a guarantee that allocations
>> >above 512 bytes in size are aligned.  With a 64 byte struct page, as long
>> 
>> Where is this 512 bytes condition comes from?
> 
> Filesystems need to do I/Os from kmalloc addresses and those I/Os need to
> be 512 byte aligned.

To clarify, the guarantee exist for every power of two size. The I/O usecase was
part of the motivation for the guarantee, but there is not 512 byte limit. But
that means there is also no guarantee for a non-power-of-two size above (or
below) 512 bytes. Currently this only matters for sizes that fall into the 96
byte or 192 byte caches. With SLOB it can be any size.

So what I'm saying the allocations should make sure they are power of two and
then they will be aligned. The page size of 64bytes depends on some debugging
options being disabled, right?

>> >as we're allocating at least 8 pages, we know it'll be naturally aligned.
>> >
>> >Your calculation doesn't take into account the size of struct page.
>> >128M / 64k is indeed 2k, but you forgot to multiply by 64, which takes
>> >us to 128kB.
>> 
>> You are right. While would there be other combination? Or in the future?
>> 
>> For example, there are definitions of
>> 
>> #define SECTION_SIZE_BITS       26
>> #define SECTION_SIZE_BITS       24
>> 
>> Are we sure it won't break some thing?
> 
> As I said, once it's at least 512 bytes, it'll be 512 byte aligned.  And I
> can't see us having sections smaller than 8 pages, can you?
> 

