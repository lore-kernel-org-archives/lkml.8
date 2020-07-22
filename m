Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5148C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E32065E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AKHegjcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgGVKgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:36:37 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:38252 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVKgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595414197; x=1626950197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=bAMQ4NIzCVkNjI66avrrcftODz28EEl2fZZx11uJRrg=;
  b=AKHegjcWd2tagC45bh8teNkiFCmkU/Jklh+F1kZ4wfxczbn3pK/+ZV9x
   4VCQ4+QMzU0NP4Mq+9ecgdOwbbUDW59kWVihiya1UP4lFbXFJ7gWNtfIE
   E4XORBc9+lGjCchfjnoAXqwG7qPstJRCVCfB8nD55NqffKfxBIVhHXt/f
   o=;
IronPort-SDR: UXO/LAA2bMcCDj5NDYikzPWv5PIIT4wczcfQLp70E9yZ7hjXZWQzoyxbzXRw0yTIflT7zLu24o
 i2Q49bQoQtvQ==
X-IronPort-AV: E=Sophos;i="5.75,381,1589241600"; 
   d="scan'208";a="43322491"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 22 Jul 2020 10:36:36 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 45136A394A;
        Wed, 22 Jul 2020 10:36:33 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 10:36:32 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 10:36:17 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <david@redhat.com>, <dwmw@amazon.com>, <foersleo@amazon.de>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v18 09/14] mm/damon: Implement a debugfs interface
Date:   Wed, 22 Jul 2020 12:36:01 +0200
Message-ID: <20200722103601.27454-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713084144.4430-10-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D03UWA004.ant.amazon.com (10.43.160.250) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 10:41:39 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements a debugfs interface for DAMON.  It works for the
> virtual address spaces monitoring.
> 
[...]
> +/*
> + * Converts a string into an array of unsigned long integers
> + *
> + * Returns an array of unsigned long integers if the conversion success, or
> + * NULL otherwise.
> + */
> +static int *str_to_pids(const char *str, ssize_t len, ssize_t *nr_pids)
> +{
> +	int *pids;
> +	const int max_nr_pids = 32;
> +	int pid;
> +	int pos = 0, parsed, ret;
> +
> +	*nr_pids = 0;
> +	pids = kmalloc_array(max_nr_pids, sizeof(pid), GFP_KERNEL);
> +	if (!pids)
> +		return NULL;
> +	while (*nr_pids < max_nr_pids && pos < len) {
> +		ret = sscanf(&str[pos], "%d%n", &pid, &parsed);
> +		pos += parsed;
> +		if (ret != 1)
> +			break;
> +		pids[*nr_pids] = pid;
> +		*nr_pids += 1;
> +	}
> +	if (*nr_pids == 0) {
> +		kfree(pids);
> +		pids = NULL;
> +	}

Hmm, this means debugfs users cannot make 'target_ids' empty again.  I will fix
this in the next spin.


Thanks,
SeongJae Park
