Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C4C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160F0208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZbNFPg5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgH1JyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:54:04 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:21581 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgH1JyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598608440; x=1630144440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=DHIeByoeNNGhi1tQWHNSg9o1zcBPyZT+FLDAQ3S29Es=;
  b=ZbNFPg5cPe46ndGtB/QuDhM8fVAw6uhpOd+OOuGttVA2tEbiYGdRzoSv
   IiCDZyZHsVn+533U2IbLiyc8LUmwfaPHMokLDsbU7a4ClLPxphwK5VD6l
   TPPQaCbaECQ0obUpjTZeLTNxdca1K9rDDkIUW9KAhNMhosn3RlA+wTBb6
   M=;
X-IronPort-AV: E=Sophos;i="5.76,363,1592870400"; 
   d="scan'208";a="51943484"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 28 Aug 2020 09:53:58 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id E2039240F6D;
        Fri, 28 Aug 2020 09:53:46 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.38) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 28 Aug 2020 09:53:29 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Alkaid <zgf574564920@gmail.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v7 06/10] mm/damon: Implement callbacks for physical memory monitoring
Date:   Fri, 28 Aug 2020 11:53:15 +0200
Message-ID: <20200828095315.27210-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJFQjcOCDFGq7pNgYWpKbrhBM5FQo76d274H8UU1ma_8TWjvuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13d09UWA003.ant.amazon.com (10.43.160.227) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 04:11:56 -0400 Alkaid <zgf574564920@gmail.com> wrote:

> 
> [-- Attachment #1: Type: text/plain, Size: 2677 bytes --]
> 
> Hi SeongJae,
> 
> I think there are potential memory leaks in the following execution paths

Agreed, definitely memory leaks exists.  Thank you for let me know this!  I
will post a patch for this soon.


Thanks,
SeongJae Park
[...]
