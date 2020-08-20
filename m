Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC699C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988752080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QRdScb1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgHTH20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:28:26 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:28129 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgHTH2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597908505; x=1629444505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=+z5gRR9lDvZgFOK5wYX/pVE2K58JbzzBVI8/7gKt8aU=;
  b=QRdScb1QLjI7RFNgy/FaHLCiWqApUr5vMxxlgIMuvp1uT0q+Rl1o1qIY
   3B8f1pWOKq5hcssNp6PZTKJHGooBHsU0593o91z2j6VTgFXtQfUJnYR6o
   oYO/YjxDzY4B5y9lv3ctz/yazmmWOdRHVzf6By67E0Am6I2vRtBZsproj
   U=;
X-IronPort-AV: E=Sophos;i="5.76,332,1592870400"; 
   d="scan'208";a="48764235"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 20 Aug 2020 07:28:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 4879FA261F;
        Thu, 20 Aug 2020 07:28:11 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 07:28:11 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.183) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 07:27:54 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, <Jonathan.Cameron@Huawei.com>,
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
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v20 00/15] Introduce Data Access MONitor (DAMON)
Date:   Thu, 20 Aug 2020 09:27:38 +0200
Message-ID: <20200820072738.27602-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817105137.19296-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.183]
X-ClientProxiedBy: EX13D05UWB004.ant.amazon.com (10.43.161.208) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 12:51:22 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Changes from Previous Version
> =============================
> 
> - Place 'CREATE_TRACE_POINTS' after '#include' statements (Steven Rostedt)
> - Support large record file (Alkaid)
> - Place 'put_pid()' of virtual monitoring targets in 'cleanup' callback
> - Avoid conflict between concurrent DAMON users
> - Update evaluation result document
> 
> Introduction
> ============
> 
> DAMON is a data access monitoring framework subsystem for the Linux kernel.
> The core mechanisms of DAMON called 'region based sampling' and 'adaptive
> regions adjustment' (refer to 'mechanisms.rst' in the 11th patch of this
> patchset for the detail) make it
> 
>  - accurate (The monitored information is useful for DRAM level memory
>    management. It might not appropriate for Cache-level accuracy, though.),
>  - light-weight (The monitoring overhead is low enough to be applied online
>    while making no impact on the performance of the target workloads.), and
>  - scalable (the upper-bound of the instrumentation overhead is controllable
>    regardless of the size of target workloads.).
> 
> Using this framework, therefore, the kernel's core memory management mechanisms
> such as reclamation and THP can be optimized for better memory management.  The
> experimental memory management optimization works that incurring high
> instrumentation overhead will be able to have another try.  In user space,
> meanwhile, users who have some special workloads will be able to write
> personalized tools or applications for deeper understanding and specialized
> optimizations of their systems.

DAMON will be presented in the next week LPC[1].  To be prepared for a screen
sharing error (if I get no such error, I will do a live-demo), I recorded a
simple demo video.  I would like to share it here to help your easier
understanding of DAMON.

    https://youtu.be/l63eqbVBZRY

[1] https://linuxplumbersconf.org/event/7/contributions/659/


Thanks,
SeongJae Park
