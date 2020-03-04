Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7344DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EB521D56
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KPBxnELE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgCDQIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:08:19 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:58834 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgCDQIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583338099; x=1614874099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=jc/5pmQb0YfPhtIbInDedgkyxcFInN57uJozqb4Q7Vc=;
  b=KPBxnELEWwQRxi86ZgyWeL0TS14/E+WRA4aneA2vF2YyCXJ0GJgkbrBu
   GRN8cST+iYuLkh9o2xxIaLQPG5v46TG6d8juXFgC4qU9jbIESzi2gdQ/k
   YaO0I08Wq1I5qtq8jJF0E+azl13Dt+7B0RmW0H9GI5Mbyv1WoEmY1Rv/X
   s=;
IronPort-SDR: 2pyxj85lzSXsWPOES5aKY6zToYQjHYcLHFmoLoTVMVJEbwnzkx7WZo1br2DPd94KSzx0s4f9LR
 peenIz+NnxNg==
X-IronPort-AV: E=Sophos;i="5.70,514,1574121600"; 
   d="scan'208";a="19761042"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 04 Mar 2020 16:08:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id AA8A3A20D6;
        Wed,  4 Mar 2020 16:07:54 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 4 Mar 2020 16:07:54 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.115) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Mar 2020 16:07:42 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Rik van Riel <riel@surriel.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [RFC v4 2/7] mm/damon: Account age of target regions
Date:   Wed, 4 Mar 2020 17:07:28 +0100
Message-ID: <20200304160728.19130-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <221dab45ed46405b707825455086855665ead7cc.camel@surriel.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.115]
X-ClientProxiedBy: EX13D19UWA001.ant.amazon.com (10.43.160.169) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rick,

Thank you for question :)

On Wed, 04 Mar 2020 10:21:29 -0500 Rik van Riel <riel@surriel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 558 bytes --]
> 
> On Tue, 2020-03-03 at 13:14 +0100, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> 
> > --- a/mm/damon.c
> > +++ b/mm/damon.c
> > @@ -87,6 +87,10 @@ static struct damon_region
> > *damon_new_region(struct damon_ctx *ctx,
> >  	ret->sampling_addr = damon_rand(ctx, vm_start, vm_end);
> >  	INIT_LIST_HEAD(&ret->list);
> >  
> > +	ret->age = 0;
> > +	ret->last_vm_start = vm_start;
> > +	ret->last_vm_end = vm_end;
> 
> Wait, what tree is this supposed to apply against?
> 
> I see no mm/damon.c file in current Linus upstream.

This patchset is supposed to apply against v5.5 plus DAMON patchset[1] plus a
patch from Minchan.  You can get the tree this patchset is applied via:

    $ git clone git://github.com/sjp38/linux -b damos/rfc/v4

Or, the web is also available:
https://github.com/sjp38/linux/releases/tag/damos/rfc/v4

I am posting this as a seperate RFC patchset because 1) this patchset is based
on the tree other than Linus or other maintainers' upstream trees, 2) I
want to keep the size of original patchset small for convenience of reviewers,
3) this patchset is relatively recently made and thus might unstable compared
to the DAMON patchset[1], and 4) I want to share my plan and get early
feedbacks as many as possible.

Sorry if this made you confused.  Also, if you have some opinions regarding
this seperated postings, please let me know.


[1] https://lore.kernel.org/linux-mm/20200224123047.32506-1-sjpark@amazon.com


Thanks,
SeongJae Park

> 
> -- 
> All Rights Reversed.
