Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AA5C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7DB2468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Up29+5bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCJL5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:57:00 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:37827 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgCJL47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583841419; x=1615377419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=/536h/PMZwJYWZ+PhtKBlNa6R33fzMsgLqFmj+1/g/g=;
  b=Up29+5bXI3ItrO7J3FJXiDHwupYtuxYKuzJ3C/7NfZuLGzPCCMzx+MH1
   T74B+h6K2LAG/0toAgAwy33sMpjOBKUYw41HtaY0+EfN5V9nVbyWA/FDV
   84hBkqgAxiCYr8sBFiF+qwG14KOM5HVOeDeL4Tum5OYMTCxzjkjiazCA4
   U=;
IronPort-SDR: EjzRwEhoIj4qQ2L/PeyoWyBcO1nF1ZligbE99rfQCXABPF3oHoKjRT7wDJMuiCFRRHL/N2yJTm
 5aNN5ibcwbkw==
X-IronPort-AV: E=Sophos;i="5.70,536,1574121600"; 
   d="scan'208";a="21951174"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Mar 2020 11:56:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 5E9D4142907;
        Tue, 10 Mar 2020 11:56:47 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 10 Mar 2020 11:56:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.115) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 10 Mar 2020 11:56:34 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v6 07/14] mm/damon: Implement kernel space API
Date:   Tue, 10 Mar 2020 12:56:20 +0100
Message-ID: <20200310115620.24768-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310090152.00002c6e@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.115]
X-ClientProxiedBy: EX13D38UWB001.ant.amazon.com (10.43.161.10) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 09:01:52 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 Feb 2020 13:30:40 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit implements the DAMON api for the kernel.  Other kernel code
> > can use DAMON by calling damon_start() and damon_stop() with their own
> > 'struct damon_ctx'.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Seems like it would have been easier to create the header as you went along
> and avoid the need to have the bits here dropping static.

Yes, exporing the API from the beginning must be much simpler and easy to
review!

> 
> Or the moves for that matter.
> 
> Also, ideally have full kernel-doc for anything that forms part of an
> interface that is intended for use by others.

Agreed, will use the kernel-doc comments!


Thanks,
SeongJae Park

> 
> Jonathan
> 
> > ---
[...]
