Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D717CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93CA2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jaslHGLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgE0LZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:25:18 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:55641 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgE0LZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590578716; x=1622114716;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=JzGa+FDGTOYvjrnaHuDlZavg7Br+lZxZIg7PjU/OI1E=;
  b=jaslHGLmmmgvHY5k0Bcm2JhoILtgZE6cwseP7OwNsRUE08cpxwSuehF9
   6BwjVkGBsfvxakykvMNf9JTGHTAesZbyszjpHzE/YdOaYtYIQcvqRDRXx
   H2tIqfgklQ/yz1YHjMq5Fx/P0K1soMJRGVR2d1JJPrFg9rfunukoWUKqL
   4=;
IronPort-SDR: NHBTOFP/s1JjKE5LXzxQCJEexi+zMsYswezQUru47u+4r3/CNiLS6VJYktOPH+6G2DLs+Oaxrk
 XABLwS6SNvTw==
X-IronPort-AV: E=Sophos;i="5.73,441,1583193600"; 
   d="scan'208";a="32413687"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 27 May 2020 11:25:16 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 5C766A2004;
        Wed, 27 May 2020 11:25:13 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 04RBPAuf027854;
        Wed, 27 May 2020 13:25:10 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 04RBPA5p027852;
        Wed, 27 May 2020 13:25:10 +0200
From:   Leonard Foerster <foersleo@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, irogers@google.com,
        jolsa@redhat.com, kirill@shutemov.name, mark.rutland@arm.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, rdunlap@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        sblbir@amazon.com, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 10/15] mm/damon: Add tracepoints
Date:   Wed, 27 May 2020 13:25:08 +0200
Message-Id: <1590578708-27797-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200525091512.30391-11-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25T11:15:07+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds a tracepoint for DAMON.  It traces the monitoring
> results of each region for each aggregation interval.  Using this, DAMON
> will be easily integrated with any tracepoints supporting tools such as
> perf.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Leonard Foerster <foersleo@amazon.de>
