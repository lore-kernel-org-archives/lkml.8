Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C87C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CF920716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INWLARXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgHKBwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:52:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30437 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727848AbgHKBv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597110718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B65NjOD6ipSRjE7zhOhhykThhsv5n+dkos2I3Rfjbvw=;
        b=INWLARXjig+umfzMpo3V+DJTYBByRhIGjfg2wNkHk7/+6ISdDHn6VjdS3UW1UOgVNPb8mc
        xmfkvViRo4V1NajOzcTL8N1P6oUDieV0d1zgWQoKv2mgmkXCJNHdPPXmbOYjGSmVU1OT0r
        RiqWlhCfkZjA2f8RQ8T45thNbXFbYNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-TQViRskyOaipOO4uc-UJCg-1; Mon, 10 Aug 2020 21:51:54 -0400
X-MC-Unique: TQViRskyOaipOO4uc-UJCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1E898014D7;
        Tue, 11 Aug 2020 01:51:52 +0000 (UTC)
Received: from localhost (ovpn-13-96.pek2.redhat.com [10.72.13.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 000926111F;
        Tue, 11 Aug 2020 01:51:51 +0000 (UTC)
Date:   Tue, 11 Aug 2020 09:51:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>, mhocko@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page
 to workaround the nasty free_huge_page
Message-ID: <20200811015148.GA10792@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
 <20200810021737.GV14854@MiWiFi-R3L-srv>
 <129cc03e-c6d5-24f8-2f3c-f5a3cc821e76@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <129cc03e-c6d5-24f8-2f3c-f5a3cc821e76@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/20 at 05:19pm, Mike Kravetz wrote:
> On 8/9/20 7:17 PM, Baoquan He wrote:
> > On 08/07/20 at 05:12pm, Wei Yang wrote:
> >> Let's always increase surplus_huge_pages and so that free_huge_page
> >> could decrease it at free time.
> >>
> >> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> >> ---
> >>  mm/hugetlb.c | 14 ++++++--------
> >>  1 file changed, 6 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index 1f2010c9dd8d..a0eb81e0e4c5 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -1913,21 +1913,19 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
> >>  		return NULL;
> >>  
> >>  	spin_lock(&hugetlb_lock);
> >> +
> >> +	h->surplus_huge_pages++;
> >> +	h->surplus_huge_pages_node[page_to_nid(page)]++;
> >> +
> >>  	/*
> >>  	 * We could have raced with the pool size change.
> >>  	 * Double check that and simply deallocate the new page
> >> -	 * if we would end up overcommiting the surpluses. Abuse
> >> -	 * temporary page to workaround the nasty free_huge_page
> >> -	 * codeflow
> >> +	 * if we would end up overcommiting the surpluses.
> >>  	 */
> >> -	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
> >> -		SetPageHugeTemporary(page);
> > 
> > Hmm, the temporary page way is taken intentionally in
> > commit 9980d744a0428 ("mm, hugetlb: get rid of surplus page accounting tricks").
> > From code, this is done inside hugetlb_lock holding, and the code flow
> > is straightforward, should be safe. Adding Michal to CC.
> > 
> 
> I remember when the temporary page code was added for page migration.
> The use of temporary page here was added at about the same time.  Temporary
> page does have one advantage in that it will not CAUSE surplus count to
> exceed overcommit.  This patch could cause surplus to exceed overcommit
> for a very short period of time.  However, do note that for this to happen
> the code needs to race with a pool resize which itself could cause surplus
> to exceed overcommit.
> 
> IMO both approaches are valid.
> - Advantage of temporary page is that it can not cause surplus to exceed
>   overcommit.  Disadvantage is as mentioned in the comment 'abuse of temporary
>   page'.
> - Advantage of this patch is that it uses existing counters.  Disadvantage
>   is that it can momentarily cause surplus to exceed overcommit.

Yeah, since it's all done inside hugetlb_lock, should be OK even
though it may cause surplus to exceed overcommit.
> 
> Unless someone has a strong opinion, I prefer the changes in this patch.

Agree, I also prefer the code change in this patch, to remove the
unnecessary confusion about the temporary page.

