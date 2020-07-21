Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97599C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AF82073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDUf0yko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgGUJzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:55:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47840 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729035AbgGUJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595325326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1XnvnThZnc7BMSa0y7ll+MrXkseUeXuMgZvuNS+LSeM=;
        b=bDUf0ykotFD1kUvXvhNLHfqc3iGWYE7S5VRtdAMv/AB7OXLV2Fj/ACn4CfS6LCs5PVbXwq
        YUIZis7fQPCg+nJXnow1SzssiwrqnQiCXdWDltTLQYYFgU2RF9p90FiUnkcIhqdTL/hhaK
        7T/Q5uPrIkigFnwh/WDjRdi3uSTMRiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-AdemcYfsN6Wr2Mh9BhQkmQ-1; Tue, 21 Jul 2020 05:55:24 -0400
X-MC-Unique: AdemcYfsN6Wr2Mh9BhQkmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A1FE1B2C980;
        Tue, 21 Jul 2020 09:55:23 +0000 (UTC)
Received: from localhost (ovpn-12-170.pek2.redhat.com [10.72.12.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AECD7C0060;
        Tue, 21 Jul 2020 09:55:22 +0000 (UTC)
Date:   Tue, 21 Jul 2020 17:55:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 5/5] mm/hugetl.c: warn out if expected count of huge
 pages adjustment is not achieved
Message-ID: <20200721095520.GN32539@MiWiFi-R3L-srv>
References: <20200720062623.13135-1-bhe@redhat.com>
 <20200720062623.13135-6-bhe@redhat.com>
 <c5eb3692-2d05-d6dc-437d-21e51705560e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5eb3692-2d05-d6dc-437d-21e51705560e@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/20 at 05:38pm, Mike Kravetz wrote:
> On 7/19/20 11:26 PM, Baoquan He wrote:
> > A customer complained that no any message is printed out when failed to
> > allocate explicitly specified number of persistent huge pages. That
> > specifying can be done by writing into /proc/sys/vm/nr_hugepages to
> > increase the persisten huge pages.
> > 
> > In the current code, it takes the best effort way to allocate the expected
> > number of huge pages. If only succeeding to get part of them, no any
> > information is printed out.
> > 
> > Here try to send out warning message if the expected number of huge pages
> > adjustment is not achieved, including increasing and decreasing the count
> > of persistent huge pages.
> 
> Perhaps change the wording a bit,
> 
> A customer complained that no message is logged when the number of
> persistent huge pages is not changed to the exact value written to
> the sysfs or proc nr_hugepages file.
> 
> In the current code, a best effort is made to satisfy requests made
> via the nr_hugepages file.  However, requests may be only partially
> satisfied.
> 
> Log a message if the code was unsuccessful in fully satisfying a
> request.  This includes both increasing and decreasing the number
> of persistent huge pages.

Thanks, sounds much better, I will use these to replace the old log.

> 
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/hugetlb.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> I am not opposed to this patch.  However, I believe the best way for a user
> to determine if their request was successful is to compare the value of
> nr_hugepages to the value which was written.

Agree. While from our customer's request, they told the log can help
'Easily detect and analyse previous reservation failures'.

> 
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 467894d8332a..1dfb5d9e4e06 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2661,7 +2661,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
> >  static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
> >  			      nodemask_t *nodes_allowed)
> >  {
> > -	unsigned long min_count, ret;
> > +	unsigned long min_count, ret, old_max;
> >  	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
> >  
> >  	/*
> > @@ -2723,6 +2723,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
> >  	 * pool might be one hugepage larger than it needs to be, but
> >  	 * within all the constraints specified by the sysctls.
> >  	 */
> > +	old_max = persistent_huge_pages(h);
> >  	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
> >  		if (!adjust_pool_surplus(h, nodes_allowed, -1))
> >  			break;
> > @@ -2779,6 +2780,16 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
> >  	}
> >  out:
> >  	h->max_huge_pages = persistent_huge_pages(h);
> > +	if (count != h->max_huge_pages) {
> > +		char buf[32];
> > +
> > +		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> > +		pr_warn("HugeTLB: %s %lu of page size %s failed. Only %s %lu hugepages.\n",
> > +			count > old_max ? "increasing" : "decreasing",
> > +			abs(count - old_max), buf,
> > +			count > old_max ? "increased" : "decreased",
> > +			abs(old_max - h->max_huge_pages));
> > +	}
> >  	spin_unlock(&hugetlb_lock);
> 
> I would prefer if we drop the lock before logging the message.  That would
> involve grabbing the value of h->max_huge_pages before dropping the lock.

Sure, will change. We should try to release the lock's burden. Thanks.

