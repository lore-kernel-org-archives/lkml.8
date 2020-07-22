Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2921BC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7912077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRc9g9Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgGVIt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:49:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29349 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgGVIt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595407764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUHpIDnSN/WmenwqHmZ9mTzcwD02l0uaA4Y7CipC5gk=;
        b=eRc9g9Iej4RwzWcV5KW0JeqzeMFdcPTU1L7NyuABhtF5qc5M/9uqfzBiMAq8Cm3tc9vuBD
        IPVfmEKQZQ06OdkoglkxMRsPJ/KspPLWNihVAiLwZsqi0AUPRQkChu4NbtYeYJTEJ6G3+v
        lX2+pGvN2T3lZS+pojzQHA0ZH1/v17A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375--Sve9uS6OuuqmTN1DPSUwQ-1; Wed, 22 Jul 2020 04:49:19 -0400
X-MC-Unique: -Sve9uS6OuuqmTN1DPSUwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3185A800C64;
        Wed, 22 Jul 2020 08:49:18 +0000 (UTC)
Received: from localhost (ovpn-12-70.pek2.redhat.com [10.72.12.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C1E05C1C3;
        Wed, 22 Jul 2020 08:49:16 +0000 (UTC)
Date:   Wed, 22 Jul 2020 16:49:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 5/5] mm/hugetl.c: warn out if expected count of huge
 pages adjustment is not achieved
Message-ID: <20200722084913.GO32539@MiWiFi-R3L-srv>
References: <20200720062623.13135-1-bhe@redhat.com>
 <20200720062623.13135-6-bhe@redhat.com>
 <c5eb3692-2d05-d6dc-437d-21e51705560e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5eb3692-2d05-d6dc-437d-21e51705560e@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 07/20/20 at 05:38pm, Mike Kravetz wrote:
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

Do you think the below change is OK to you to move the message logging
after lock dropping? If yes, I will repost with updated patches.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6a9b7556ce5b..b5aa32a13569 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2661,7 +2661,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret, old_max;
+	unsigned long min_count, ret, old_max, new_max;
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
 	/*
@@ -2780,7 +2780,10 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
-	if (count != h->max_huge_pages) {
+	new_max = h->max_huge_pages;
+	spin_unlock(&hugetlb_lock);
+
+	if (count != new_max) {
 		char buf[32];
 
 		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
@@ -2788,9 +2791,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			count > old_max ? "increasing" : "decreasing",
 			abs(count - old_max), buf,
 			count > old_max ? "increased" : "decreased",
-			abs(old_max - h->max_huge_pages));
+			abs(old_max - new_max));
 	}
-	spin_unlock(&hugetlb_lock);
 
 	NODEMASK_FREE(node_alloc_noretry);
 

