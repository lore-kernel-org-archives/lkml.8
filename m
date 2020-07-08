Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE78C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87AB920656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594194070;
	bh=QiMxQc+GA1mkpDvnpswbM0K1G53EGWM+DhSPgG7EKAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gvVCL2K1OBSzA6TbWBgtMqrD8tfQSxQzbZYsVe0I139PXVj/G9OTnPV0dO+ROit4y
	 jQUeXq79EiWrorps2xQMYQRQ3l6frwpOTZVMcoG3f2gZGCARSqQ/kWnsuElIt46laI
	 vc1r/s3NP4DEbXMQUZMS5MjFti3Rz6Nv1y7UOow4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgGHHlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:41:09 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:44994 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGHHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:41:07 -0400
Received: by mail-ej1-f67.google.com with SMTP id ga4so49256676ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6/A3VQ/K8xvCKHiyxktO8Rg8OAtA4BCJ+I3Yp4ab7mc=;
        b=NJzm+HIF2hx8/UUUuYmkSUKZ+NW5fJHtFPOu4S88YzzlQQdoafkFhs5Le7U7verTtB
         oFZwC3+ExXDldatNQV0U2I+OLvM9orHbr/jAhD7esfGpohx+xct2lYBjFi6A69CunYeL
         4bPc83J8fhfmLbyo58LGcm4tNAVFwhiOzKqHD3JKM2txMywuC02QsL4/m3qpfTtKmllo
         0OhSe8i8mqbqu6m4we8vJIGbb2V2faumUGsehLfjWmZJjiSko0ZZqcfgunX3VLRgQuqS
         9Pa5bYEHoo5IHswuf6iayoXLpy3CJmJ3YqJfAX/SSrtDfpMKetGqG7Ktm+AfAQ+xQw2h
         RSVg==
X-Gm-Message-State: AOAM533KvzzTg+z5HziQfbG/WaSLetvDpq4UZDa0Vhda2hTocNiuXQFk
        9mKpQ0Gmc1/10k2g2zkTiUk=
X-Google-Smtp-Source: ABdhPJykdLeci86uEzWsDP8J/cfe/eHujJtWTsPQHzS01KxobrOSRY5slASSTgDt2Pwhj70aOnSZNA==
X-Received: by 2002:a17:906:6d49:: with SMTP id a9mr48950522ejt.435.1594194065679;
        Wed, 08 Jul 2020 00:41:05 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id dn15sm1605732ejc.26.2020.07.08.00.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:41:04 -0700 (PDT)
Date:   Wed, 8 Jul 2020 09:41:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA
 aware
Message-ID: <20200708074103.GD7271@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
 <c1cd6e11-08c3-5654-60e7-dec2eb80987a@suse.cz>
 <20200708071602.GB16543@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708071602.GB16543@js1304-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-07-20 16:16:02, Joonsoo Kim wrote:
> On Tue, Jul 07, 2020 at 01:22:31PM +0200, Vlastimil Babka wrote:
> > On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > 
> > > new_non_cma_page() in gup.c which try to allocate migration target page
> > > requires to allocate the new page that is not on the CMA area.
> > > new_non_cma_page() implements it by removing __GFP_MOVABLE flag.  This way
> > > works well for THP page or normal page but not for hugetlb page.
> > > 
> > > hugetlb page allocation process consists of two steps.  First is dequeing
> > > from the pool.  Second is, if there is no available page on the queue,
> > > allocating from the page allocator.
> > > 
> > > new_non_cma_page() can control allocation from the page allocator by
> > > specifying correct gfp flag.  However, dequeing cannot be controlled until
> > > now, so, new_non_cma_page() skips dequeing completely.  It is a suboptimal
> > > since new_non_cma_page() cannot utilize hugetlb pages on the queue so this
> > > patch tries to fix this situation.
> > > 
> > > This patch makes the deque function on hugetlb CMA aware and skip CMA
> > > pages if newly added skip_cma argument is passed as true.
> > 
> > Hmm, can't you instead change dequeue_huge_page_node_exact() to test the PF_
> > flag and avoid adding bool skip_cma everywhere?
> 
> Okay! Please check following patch.
> > 
> > I think that's what Michal suggested [1] except he said "the code already does
> > by memalloc_nocma_{save,restore} API". It needs extending a bit though, AFAICS.
> > __gup_longterm_locked() indeed does the save/restore, but restore comes before
> > check_and_migrate_cma_pages() and thus new_non_cma_page() is called, so an
> > adjustment is needed there, but that's all?
> > 
> > Hm the adjustment should be also done because save/restore is done around
> > __get_user_pages_locked(), but check_and_migrate_cma_pages() also calls
> > __get_user_pages_locked(), and that call not being between nocma save and
> > restore is thus also a correctness issue?
> 
> Simply, I call memalloc_nocma_{save,restore} in new_non_cma_page(). It
> would not cause any problem.

I believe a proper fix is the following. The scope is really defined for
FOLL_LONGTERM pins and pushing it inside check_and_migrate_cma_pages
will solve the problem as well but it imho makes more sense to do it in
the caller the same way we do for any others. 

Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")

I am not sure this is worth backporting to stable yet.

diff --git a/mm/gup.c b/mm/gup.c
index de9e36262ccb..75980dd5a2fc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1794,7 +1794,6 @@ static long __gup_longterm_locked(struct task_struct *tsk,
 				     vmas_tmp, NULL, gup_flags);
 
 	if (gup_flags & FOLL_LONGTERM) {
-		memalloc_nocma_restore(flags);
 		if (rc < 0)
 			goto out;
 
@@ -1802,11 +1801,13 @@ static long __gup_longterm_locked(struct task_struct *tsk,
 			for (i = 0; i < rc; i++)
 				put_page(pages[i]);
 			rc = -EOPNOTSUPP;
+			memalloc_nocma_restore(flags);
 			goto out;
 		}
 
 		rc = check_and_migrate_cma_pages(tsk, mm, start, rc, pages,
 						 vmas_tmp, gup_flags);
+		memalloc_nocma_restore(flags);
 	}
 
 out:
-- 
Michal Hocko
SUSE Labs
