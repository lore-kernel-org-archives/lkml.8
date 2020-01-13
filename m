Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6DFC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8E920CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAMSno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:43:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:45123 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgAMSnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:43:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 10:43:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="219367166"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jan 2020 10:43:42 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 84880301003; Mon, 13 Jan 2020 10:43:42 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:43:42 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf parse: Refactor struct perf_evsel_config_term
Message-ID: <20200113184342.GA302770@tassilo.jf.intel.com>
References: <20200113151806.17854-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113151806.17854-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:18:05PM +0800, Leo Yan wrote:
> The struct perf_evsel_config_term::val is a union which contains
> fields 'callgraph', 'drv_cfg' and 'branch' as string pointers.  This
> leads to the complex code logic for handling every type's string
> separately, and it's hard to release string as a general way.
> 
> This patch refactors the structure to add a common field 'str' in the
> 'val' union as string pointer and remove the other three fields
> 'callgraph', 'drv_cfg' and 'branch'.  Without passing field name, the
> patch simplifies the string handling with macro ADD_CONFIG_TERM_STR()
> for string pointer assignment.

Looks like a good cleanup.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
