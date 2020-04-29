Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FBDC83008
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C802A2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dT3bog8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD2KLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:11:12 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:20961 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2KLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588155071; x=1619691071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=9CQS42kGK5ZNYWUV4gu/AjvQxaOsf0urRIP1lzCXhDQ=;
  b=dT3bog8FqsnfZ4ouplOerh4c/HrtB8Z9Tldm3fNlaBGDSjepRbnS5eyu
   TH8OMFhJOp0elWNZmTgdCSbeEn1OAT5WQeby00MJU3/dTW3QxMjdRR4wk
   jfMjzplySOAxVnEauxeNh8efmHQgtsfxRfgaeaC8B32X3kh9V9Bajhymn
   I=;
IronPort-SDR: K8AboDQXsW8YZoXYONZzkIizxiyiNkRHbVOEogmdF86aRc06DTu2amOAD3i/LB4jfRbhjfsz1z
 5Mv3iajYFj2Q==
X-IronPort-AV: E=Sophos;i="5.73,331,1583193600"; 
   d="scan'208";a="41592898"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 29 Apr 2020 10:11:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 6A24FA1E7F;
        Wed, 29 Apr 2020 10:10:55 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Apr 2020 10:10:54 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Apr 2020 10:10:38 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v9 00/15] Introduce Data Access MONitor (DAMON)
Date:   Wed, 29 Apr 2020 12:10:19 +0200
Message-ID: <20200429101019.26299-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429101806.000002f4@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D28UWC001.ant.amazon.com (10.43.162.166) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 10:18:06 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 29 Apr 2020 09:49:54 +0200
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > On Tue, 28 Apr 2020 17:17:13 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > > On Tue, 28 Apr 2020 15:23:42 +0200
> > > SeongJae Park <sjpark@amazon.com> wrote:
> > >   
> > > > On Tue, 28 Apr 2020 13:27:04 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > >   
> > > > > On Mon, 27 Apr 2020 14:04:27 +0200
> > > > > SeongJae Park <sjpark@amazon.com> wrote:
> > > > >     
> > > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > > > 
> > > > > > Introduction
> > > > > > ============
> > > > > > 
[...]
> > 
> > Appreciate your explanations and suggestions.
> 
> You are welcome.
> 
> Out of interest, do you have any comparative data on how 'accurate' the resulting
> estimates are vs a more precise heatmap from a memory trace?

No, I don't have such data.

I'm only comparing the big trends of heatmap, working set sizes analyzed from
the recorded access pattern and the DAMOS performance results for each version
using my human eye, to check regression.

> 
> I'm looking at gathering such data but much happier to leverage your work if
> you've already done it!

That would be great.  If I get such data later, I will let you know.  I will be
also very happy if you could get it first and share with me.

Maybe we could make and use another variant of DAMON, which uses page-size
regions only and disable the adaptive regions adjustment.  It will be also
useful for overhead comparison.  Actually, I heard that my previous colleague
made this variant for the comparison based on a prototype of DAMON.  I will
also consider extending DAMON to support such variant.

Also, if you need the heatmaps, analyzed working set size distribution, and/or
the record file itself for each version of the patchsets, please let me know.


Thanks,
SeongJae Park
