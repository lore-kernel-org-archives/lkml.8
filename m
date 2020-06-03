Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF8C20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cxcy66h4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgFCMmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:42:42 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:45172 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFCMmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591188162; x=1622724162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=OU49Gc1THRYl34IwIl5qtP+O5EzheFvQzNCFW6NI5pQ=;
  b=Cxcy66h4mwG+21x2znl4+751jOSOlPYsdDSnhmEXCgGUZhPBbOEmKcHc
   xVbrV+aW57MMi91mDiW8UffYviqw8qo9VsHwjhBPQu9YarWO4jPSf6K0/
   lF/JVtzVECM8UiUS+3h0YHtugBjFkK5SRpTZSLpbOUUebPMYfKOwhIKk2
   Y=;
IronPort-SDR: PnVBPs5Rbbg8Oq33qPMcrEiXYqvM4dqxYocMGmd5xnYl3pl2EKBR97PSyGXxOoW+RLiqiblGKc
 jLcEmFFEmf1Q==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="49498028"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 03 Jun 2020 12:42:38 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 0D582A17C3;
        Wed,  3 Jun 2020 12:42:36 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 12:42:35 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 12:42:19 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <cai@lca.pw>,
        Colin King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, Ian Rogers <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>,
        "Mark Rutland" <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <sblbir@amazon.com>,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        SeongJae Park <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v14 13/15] mm/damon-test: Add a kunit test for recording setup
Date:   Wed, 3 Jun 2020 14:42:03 +0200
Message-ID: <20200603124203.22719-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g447MLhQ5F2MeizMEM+V1kSUY7Cqjp-1XxrfdLvEzxXFEg@mail.gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D40UWA003.ant.amazon.com (10.43.160.29) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 13:28:03 -0700 Brendan Higgins <brendanhiggins@google.com> wrote:

> On Tue, Jun 2, 2020 at 6:16 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit adds another unit test case for the recording setup.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for the review!  As the previous patch is also for the kunit test and it
already received your 'Reviewed-by', I would like to merge this patch into the
previous one in the next spin.  If there is any problem, please let me know.


Thanks,
SeongJae Park
