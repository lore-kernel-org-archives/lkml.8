Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AF3C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA76E206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDVOil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:38:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:24155 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgDVOik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:38:40 -0400
IronPort-SDR: M0ff1S6lzAn0NKw939+TuIVhoikW3vPWbVmw16vel+aEsq5GKlPy5sBkznGQpen4J5Yns8UIzp
 DdMIawgO4c1Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 07:38:40 -0700
IronPort-SDR: N1APEwHTnT18ajiIph6Dp451Pq+/HFeago4+E1KDsDOHQbPIYVQ+DwLgO0X2goDYXFbGuezuSP
 BLZc/EIBFXQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="245990894"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2020 07:38:40 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1A1663019B5; Wed, 22 Apr 2020 07:38:40 -0700 (PDT)
Date:   Wed, 22 Apr 2020 07:38:40 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake
 metrics
Message-ID: <20200422143840.GJ608746@tassilo.jf.intel.com>
References: <20200422074809.160248-1-irogers@google.com>
 <20200422074809.160248-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422074809.160248-3-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:48:03AM -0700, Ian Rogers wrote:
> Remove over escaping with \\.
> Remove extraneous if 1 if 0 == 1 else 0 else 0.

So where do these parse errors happen exactly? Some earlier 
patches introduced them as regressions?

The original metrics worked without parse errors as far as I know.

If it fixes something earlier it would need Fixes: tags.

-Andi
