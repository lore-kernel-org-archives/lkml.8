Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28175C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03EFD20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hIP1rtfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgE0Mlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:41:52 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:49605 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbgE0Mlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590583312; x=1622119312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=NjJxb+k1jhgqirndi8Qb2IsZaPxzGMEU8argi+sZW10=;
  b=hIP1rtfpL/AaEFUY8xQxmvi1SlqmKv8wVFe9cnIkLPMNpdHyI4ZYK0K+
   Ff+hxepe733tUkf1Ww3/7764JXjenB0BbgU6HM9T+xsUKwz++uN7UVIA8
   ajC1uJ0cFfHPpvlHjR9G1bEe8raotpuEMeO5YfHNhFW3U7ibcfZuuvgLO
   c=;
IronPort-SDR: CFd8xfY1BDnoW0Zu22Uj3KKYVv7C54bHiomKm5zwTNaxWOdxUYD1NgJ6P82SHT3pXtX1QUxqPl
 5YPR/ezXHhhg==
X-IronPort-AV: E=Sophos;i="5.73,441,1583193600"; 
   d="scan'208";a="38099710"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 27 May 2020 12:41:38 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 5D7C7A23CA;
        Wed, 27 May 2020 12:41:26 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 May 2020 12:41:25 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.200) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 May 2020 12:41:09 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Leonard Foerster <foersleo@amazon.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v13 03/15] mm: Introduce Data Access MONitor (DAMON)
Date:   Wed, 27 May 2020 14:40:49 +0200
Message-ID: <20200527124050.18038-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1590578611-26983-1-git-send-email-foersleo@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D30UWC004.ant.amazon.com (10.43.162.4) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 13:23:31 +0200 Leonard Foerster <foersleo@amazon.com> wrote:

> On 2020-05-25T11:15:00+02:00 SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit introduces a kernel module named DAMON.  Note that this
> > commit is implementing only the stub for the module load/unload, basic
> > data structures, and simple manipulation functions of the structures to
> > keep the size of commit small.  The core mechanisms of DAMON will be
> > implemented one by one by following commits.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> > [...]
> > +
> > +/**
> > + * struct damon_ctx - Represents a context for each monitoring.
> > + * @tasks_list:		Head of monitring target tasks (&damon_task) list.
> 
> nit: monitring -> monitoring

Good catch!  Will fix in the next spin.


Thanks,
SeongJae Park

> 
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> 
