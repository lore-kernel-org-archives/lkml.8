Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A930EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B231206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594660765;
	bh=0k8BUut5NzNNQwiO0L2A/+mx7GyTyHo9V1LEsdu4Yvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VZCPlcgLC9sfPgLorAliwKZQZHIobV1HnlUHqsjbVaFb8vUh9G9JdE58rudKlPhdV
	 zaGlAl12opxifS8d6zYPOVnsgN8XXClE/j/H6q4eLqN3ogswZ7fk6KJpLhB9J8Dvhx
	 CO3glnzS/tSndLUlwcDwL5+O0bJzDO1AO5Md737Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgGMRTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbgGMRTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:19:24 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7A52076D;
        Mon, 13 Jul 2020 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594660763;
        bh=0k8BUut5NzNNQwiO0L2A/+mx7GyTyHo9V1LEsdu4Yvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nq6ZaUDOSYOgNEz42ctfMWWTtbQIsEktGMHIVqt+ZbugW+JAqF+Uk/l4eUoaICfrK
         qpl5QnlfENNpZuqYvlnU5GVVSC/PQoqDxyju6k7Uz83oez60iNAWcbjJ8U+FBrqrJp
         Qbwjt81Fftb6wKdXuojHc2vilJafu4VHptk80hB8=
Date:   Mon, 13 Jul 2020 20:19:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        foersleo@amazon.de, irogers@google.com, jolsa@redhat.com,
        kirill@shutemov.name, mark.rutland@arm.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, sblbir@amazon.com,
        shakeelb@google.com, shuah@kernel.org, sj38.park@gmail.com,
        snu@amazon.de, vbabka@suse.cz, vdavydov.dev@gmail.com,
        yang.shi@linux.alibaba.com, ying.huang@intel.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v18 01/14] mm/page_ext: Export lookup_page_ext() to
 GPL modules
Message-ID: <20200713171909.GD707159@kernel.org>
References: <20200713120842.GA707159@kernel.org>
 <20200713122143.25493-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713122143.25493-1-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 02:21:43PM +0200, SeongJae Park wrote:
> On Mon, 13 Jul 2020 15:08:42 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Hi,
> > 
> > On Mon, Jul 13, 2020 at 10:41:31AM +0200, SeongJae Park wrote:
> > > From: SeongJae Park <sjpark@amazon.de>
> > > 
> > > This commit exports 'lookup_page_ext()' to GPL modules.  It will be used
> > > by DAMON in following commit for the implementation of the region based
> > > sampling.
> > 
> > Maybe I'm missing something, but why is DAMON a module?
> 
> I made it loadable just for easier adoption from downstream kernels.  I could
> drop the module build support if asked.
 
Well, exporting core mm symbols to modules should be considred very
carefully. 

Why lookup_page_ext() is required for DAMON? It is not used anywhere in
this patchset.


> Thanks,
> SeongJae Park
> 
> > 
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > > Reviewed-by: Varad Gautam <vrd@amazon.de>
> > > ---
> > >  mm/page_ext.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > index a3616f7a0e9e..9d802d01fcb5 100644
> > > --- a/mm/page_ext.c
> > > +++ b/mm/page_ext.c
> > > @@ -131,6 +131,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
> > >  					MAX_ORDER_NR_PAGES);
> > >  	return get_entry(base, index);
> > >  }
> > > +EXPORT_SYMBOL_GPL(lookup_page_ext);
> > >  
> > >  static int __init alloc_node_page_ext(int nid)
> > >  {
> > > -- 
> > > 2.17.1
> > > 
> > 
> > -- 
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
