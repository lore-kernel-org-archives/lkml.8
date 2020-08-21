Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3195CC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D7420720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHUSGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:06:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgHUSGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:06:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31E40AD3A;
        Fri, 21 Aug 2020 18:06:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 170D31E1312; Fri, 21 Aug 2020 20:06:29 +0200 (CEST)
Date:   Fri, 21 Aug 2020 20:06:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm: Add an 'end' parameter to find_get_entries
Message-ID: <20200821180629.GF3432@quack2.suse.cz>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-4-willy@infradead.org>
 <20200821160759.GE3432@quack2.suse.cz>
 <20200821163306.GW17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20200821163306.GW17456@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri 21-08-20 17:33:06, Matthew Wilcox wrote:
> On Fri, Aug 21, 2020 at 06:07:59PM +0200, Jan Kara wrote:
> > On Wed 19-08-20 16:05:51, Matthew Wilcox (Oracle) wrote:
> > > This simplifies the callers and leads to a more efficient implementation
> > > since the XArray has this functionality already.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > The patch looks good to me. Just I'd note that you could drop some:
> > 
> > 	if (index >= end)
> > 		break;
> > 
> > checks in shmem_undo_range() as well.
> 
> Oh yes, missed a couple ;-)  Thanks, I'll add.
> 
> > In the past I was considering moving find_get_entries() to the same API as
> > find_get_pages_range() has (which is essentially what you do now, but I
> > also had 'start' to be a pgoff_t * so that we can return there where the
> > iteration ended in the range). But in the end I've decided the churn is not
> > worth the few removed lines and didn't push the patch in the end. What you
> > did in this patch seems to be a reasonable middle-ground :)
> 
> I did look at that, but since we're returning the indices, we don't _need_
> to update the index here.
> 
> I have some other ideas for this family of interfaces, but I'm trying
> to get the THP work off my plate before getting distracted by that ;-)

I have one thing which I wanted to do for a long time but never got to it.
IMHO the pagevec abstraction makes the loops unnecessarily complex. I'd
rather have helpers like:

for_each_mapping_page(mapping, page, start, end)

or

for_each_mapping_entry(mapping, entry, index, start, end)

and hide all the pagevec magic inside those. And it's even not that hard to
do including the handling of premature exit from the loop - sample
userspace code is attached...

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--envbJBWh7q8WU6mo
Content-Type: text/x-c; charset=us-ascii
Content-Disposition: attachment; filename="pvec_looping.c"

#include <stdio.h>

#define PAGEVEC_SIZE 15

struct pagevec {
	unsigned char nr;
	int vals[PAGEVEC_SIZE];
};

struct pagevec_iter {
	unsigned char idx;
	int last_index;
	struct pagevec pvec;
};

void pagevec_release(struct pagevec *pvec)
{
	int i;

	for (i = 0; i < pvec->nr; i++)
		printf("Freeing val %d\n", pvec->vals[i]);
	pvec->nr = 0;
}

int pagevec_lookup(struct pagevec *pvec, void *mapping, int *start, int end)
{
	int i;

	for (i = 0; i < PAGEVEC_SIZE && *start < 29; i++) {
		pvec->vals[pvec->nr++] = 100 + *start;
		(*start)++;
	}
	return pvec->nr;
}

static inline int get_next_pvec_val(struct pagevec_iter *pvec_i, void *mapping,
				    int end)
{
	if (pvec_i->idx >= pvec_i->pvec.nr) {
		pagevec_release(&pvec_i->pvec);
		if (!pagevec_lookup(&pvec_i->pvec, mapping, &pvec_i->last_index,
				    end))
			return 0;
		pvec_i->idx = 0;
	}
	return pvec_i->pvec.vals[pvec_i->idx++];
}

void pagevec_release_iter(struct pagevec_iter *pvec_i)
{
	pagevec_release(&pvec_i->pvec);
}

#define for_each_page(mapping, page, start, end)			\
	for (struct pagevec_iter pvec_i					\
		__attribute__ ((cleanup (pagevec_release_iter))) = {	\
			.idx = 0, .last_index = start, .pvec = { .nr = 0 } }; \
	     (page = get_next_pvec_val(&pvec_i, mapping, end));)

int main(void)
{
	int page;

	for_each_page(NULL, page, 5, 32) {
		printf("Seeing val %d\n", page);
		if (page > 122)
			break;
	}
	return 0;
}

--envbJBWh7q8WU6mo--
