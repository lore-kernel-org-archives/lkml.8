Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30453C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0216821974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pBeoWm6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgFRJYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:24:03 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:8458 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgFRJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592472238; x=1624008238;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=mwc39JT7lEE4KuagndIAD1fHOgAiEu1k9Z0qdaYumW8=;
  b=pBeoWm6R8k8LofQFIM/BxETjO8MH+GbZXQcLWQOOlBfVX3V/Wshw9uRu
   FaS5xxjnzp/qPDIfMgIgyJinJBpAf4QkXbqmWqXI+kAXLaf1Y+C0xIkbo
   3OEMpmcZGp1nSZOSa9UKvBA7HHXwEpO2r7O/8frqPV6u0OkMAHkiO0/dP
   4=;
IronPort-SDR: 0k3bnbnOOC0ibSwUWEaAqbTA//k6JgCWBRROlxjeVKPOkcJsF5nR8ujzxI8+lOF23Mb6zLeAqQ
 oLi3j0MLsW0w==
X-IronPort-AV: E=Sophos;i="5.73,526,1583193600"; 
   d="scan'208";a="36992751"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 18 Jun 2020 09:23:55 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 602E7A2134;
        Thu, 18 Jun 2020 09:23:43 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 05I9NeHI022756;
        Thu, 18 Jun 2020 11:23:40 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 05I9Ndau022754;
        Thu, 18 Jun 2020 11:23:39 +0200
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
Subject: Re: [PATCH v16 04/14] mm/damon: Adaptively adjust regions
Date:   Thu, 18 Jun 2020 11:23:38 +0200
Message-Id: <1592472218-22708-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200615161927.12637-5-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-15T18:19:17+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Even somehow the initial monitoring target regions are well constructed
> to fulfill the assumption (pages in same region have similar access
> frequencies), the data access pattern can be dynamically changed.  This
> will result in low monitoring quality.  To keep the assumption as much
> as possible, DAMON adaptively merges and splits each region.
> 
> For each ``aggregation interval``, it compares the access frequencies of
> adjacent regions and merges those if the frequency difference is small.
> Then, after it reports and clears the aggregated access frequency of
> each region, it splits each region into two or third regions of random
> size, if the total number of regions after the splits wouldn't exceed
> the user-specified maximum number of regions.
> 
> In this way, DAMON provides its best-effort quality and minimal overhead
> while keeping the overhead bound.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---

Reviewed-by: Leonard Foerster <foersleo@amazon.de>
