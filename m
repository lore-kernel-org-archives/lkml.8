Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B051C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF3D21D90
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qiIW3k7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgFRJX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:23:59 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:52806 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbgFRJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592472237; x=1624008237;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=AXktVEBst0a5Xx6ME8y/aUH5oG7cSFUc9f7JNgXbuDM=;
  b=qiIW3k7acs3gg+BFNFo7DmpAP2d35M+sc32SS8ZOB3z7QqqXxxoPU7t3
   Ka0KEi7MbIdbWlJJnzGdqCfRu5QpGayTg3IX/xN8YTDQKeFEUU3bFjj4m
   4hEdDlebwLX7K18Hs1LgD5U3/m83EWanMx/PoJqPgFRZQ5XAv4FlpQac8
   U=;
IronPort-SDR: 1T86ecPT5WS1me4DVgCewcfsSHOeBhqhzAMxlusNuWC6ifv0Btz7+fmrJTbG84DGklWX4oNlH5
 1MtuLKS7jIYw==
X-IronPort-AV: E=Sophos;i="5.73,526,1583193600"; 
   d="scan'208";a="36904964"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 18 Jun 2020 09:23:52 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id F36331A00F3;
        Thu, 18 Jun 2020 09:23:48 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 05I9Nk4P022816;
        Thu, 18 Jun 2020 11:23:46 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 05I9NkJk022812;
        Thu, 18 Jun 2020 11:23:46 +0200
From:   Leonard Foerster <foersleo@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, foersleo@amazon.de,
        irogers@google.com, jolsa@redhat.com, kirill@shutemov.name,
        mark.rutland@arm.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, sblbir@amazon.com, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, david@redhat.com, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 05/14] mm/damon: Allow dynamic monitoring target regions update
Date:   Thu, 18 Jun 2020 11:23:45 +0200
Message-Id: <1592472225-22768-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200615161927.12637-6-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-15T18:19:18+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> The monitoring target regions can be dynamically changed.  For example,
> virtual memory mapping could be dynamically updated and physical memory
> could be hot-plugged.
> 
> To handle such cases, this commit adds a monitoring attribute, ``regions
> update interval`` and a callback ``init_target_regions`` in the
> monitoring context.  If the two fields are properly set, DAMON will call
> the ``init_target_regions()`` callback for every ``regions update
> interval``.  In the callback, users can check current memory mapping or
> hotplugged physical memory sections and appropriately update the
> monitoring target regions of the context.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---

Reviewed-by: Leonard Foerster <foersleo@amazon.de>
