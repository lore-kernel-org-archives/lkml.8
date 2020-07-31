Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D22C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D325208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbgGaPdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:33:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:4921 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgGaPdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:33:37 -0400
IronPort-SDR: cHEKKO/EI8hStQxA1EeOqYnS5vI1WK9bMHQfepdFdDUEbjWgR+gmoV5Pl7wnG+QvKTF97YIy2g
 jM7iXzKfx1Ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="139778113"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="139778113"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 08:33:37 -0700
IronPort-SDR: 2hslcI54DbfZjmPQl1pu1Esh1A8rzh6xr9es06Y4An/M8HNKWq8XKblHTgkdcuRGlzpErv6FWJ
 vt4ZKvpT35Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="304966113"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2020 08:33:37 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 3A09B301C02; Fri, 31 Jul 2020 08:33:37 -0700 (PDT)
Date:   Fri, 31 Jul 2020 08:33:37 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        David Ahern <dsahern@gmail.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 1/6] perf tools: Add clockid_name function
Message-ID: <20200731153337.GB1299820@tassilo.jf.intel.com>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730213950.1503773-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730213950.1503773-2-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index f486fdd3a538..126dad238ee3 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -62,4 +62,6 @@ char *perf_exe(char *buf, int len);
>  #endif
>  #endif
>  
> +const char *clockid_name(clockid_t clk_id);

If it's a generic "util" it probably shouldn't live in builtin-record.c

-Andi
