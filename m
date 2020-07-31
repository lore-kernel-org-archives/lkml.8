Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF57C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BAE220663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbgGaPgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:36:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:58807 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgGaPgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:36:21 -0400
IronPort-SDR: V3cy9WAI8puyK3+OkldWG3Iu9i11voRI5QXwgVHe25fBZ+PnV8HzSmOG5AYIwPCqvb6m+B1Zhr
 vlSl6zO83/SQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131870105"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="131870105"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 08:36:12 -0700
IronPort-SDR: XgET9NixUnhaT4TLYpyY7GHa6ma0MltRBq6C3EiuEBzw7UkyxjJ/AqamIateYupWukx4sYy5RD
 KLX38t/RCaxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="331094744"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga007.jf.intel.com with ESMTP; 31 Jul 2020 08:36:12 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 53F30301C02; Fri, 31 Jul 2020 08:36:12 -0700 (PDT)
Date:   Fri, 31 Jul 2020 08:36:12 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>, peterz@infradead.org,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 0/6] perf tools: Add wallclock time conversion support
Message-ID: <20200731153612.GC1299820@tassilo.jf.intel.com>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730221423.GH2638@hirez.programming.kicks-ass.net>
 <a59b833f-bcb7-3d1b-6e0c-8758b47b93a3@gmail.com>
 <20200731074726.GA1485940@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731074726.GA1485940@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> yep, we have a customer that needs to compare data from multiple servers

It's also needed to correlate over different guests on the same machine.
This is an important use case.

It would be nice if we could find a way to export the per guest 
TSC offset from KVM, then we could use the more reliable TSC for this,
at least as long as no TSC scaling is used.

But failing that wall clock is probably the best you can do.

-Andi
