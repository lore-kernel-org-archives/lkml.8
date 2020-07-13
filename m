Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D33C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97502076D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Eqq3AWLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgGMRjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:39:07 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:65407 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594661947; x=1626197947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=T3joC21Q3WsUvBmyUsXIOnge1qxcYWwsALm+sfFme2I=;
  b=Eqq3AWLtZx6DCU0DcUcreaXpEtTRaubKTxkJ3D9SmL0TLvkswOEwD1+q
   mEAjhgGzZyyzULzG8354QuUjfLG03ptnoZCikjmd1KA1x8nj85W19I6vZ
   CgDXNV/OWlFmD6OwP8Q0oYmV4WLmAwq5/nHgOLYn6Fd8KDRDH3DgW4dTb
   M=;
IronPort-SDR: toR5kVyvDSeaPz16GNmjn+07qfTDjOYYC+IiceMsuH1Ar9qMnz4Njk3bbgQhO/5vr8DWUdLfRV
 MTY6B5FW3shA==
X-IronPort-AV: E=Sophos;i="5.75,348,1589241600"; 
   d="scan'208";a="41570660"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 13 Jul 2020 17:39:02 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 384CDA23D0;
        Mon, 13 Jul 2020 17:38:58 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 17:38:58 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 17:38:37 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH v18 01/14] mm/page_ext: Export lookup_page_ext() to GPL modules
Date:   Mon, 13 Jul 2020 19:38:05 +0200
Message-ID: <20200713173805.31923-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713171909.GD707159@kernel.org> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D40UWA002.ant.amazon.com (10.43.160.149) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 20:19:09 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> On Mon, Jul 13, 2020 at 02:21:43PM +0200, SeongJae Park wrote:
> > On Mon, 13 Jul 2020 15:08:42 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > Hi,
> > > 
> > > On Mon, Jul 13, 2020 at 10:41:31AM +0200, SeongJae Park wrote:
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > > 
> > > > This commit exports 'lookup_page_ext()' to GPL modules.  It will be used
> > > > by DAMON in following commit for the implementation of the region based
> > > > sampling.
> > > 
> > > Maybe I'm missing something, but why is DAMON a module?
> > 
> > I made it loadable just for easier adoption from downstream kernels.  I could
> > drop the module build support if asked.
>  
> Well, exporting core mm symbols to modules should be considred very
> carefully. 

Agreed.  I will drop the module support from the next spin.

> 
> Why lookup_page_ext() is required for DAMON? It is not used anywhere in
> this patchset.

It's indirectly used.  In the 6th patch, DAMON uses 'set_page_young()' to not
interfere with other PTE Accessed bit users.  And, 'set_page_young()' uses
'lookup_page_ext()' if !CONFIG_64BIT.  That's why I exported it.


Thanks,
SeongJae Park
