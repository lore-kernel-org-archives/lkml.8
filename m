Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95323C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA86207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgIBQHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:07:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:38102 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgIBQHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:07:10 -0400
IronPort-SDR: KUPLMY5MtGIL55SFlArTlIWy47JKypOd66wmGcllGa8bYBnvyWyrDmYRW6AgIsLJsAq9T0RTLJ
 V5D9feM0wNrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="154924114"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="154924114"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 09:06:53 -0700
IronPort-SDR: l8VrC5+C1S9Nq/aHxQrvNL9I/tMg67YLfqcvEZMDqI/tLYiRgiyChsii2coNEufLjEDBkyVYj7
 STZHlJtnPT6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="315163057"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 02 Sep 2020 09:06:53 -0700
Received: from [10.249.227.213] (abudanko-mobl.ccr.corp.intel.com [10.249.227.213])
        by linux.intel.com (Postfix) with ESMTP id 4234D58041C;
        Wed,  2 Sep 2020 09:06:52 -0700 (PDT)
Subject: Re: [PATCH V2 1/6] perf tools: Consolidate --control option parsing
 into one function
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200901093758.32293-1-adrian.hunter@intel.com>
 <20200901093758.32293-2-adrian.hunter@intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d4769bfe-8d5a-b510-23ae-65012889bf92@linux.intel.com>
Date:   Wed, 2 Sep 2020 19:06:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901093758.32293-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.09.2020 12:37, Adrian Hunter wrote:
> Consolidate --control option parsing into one function, in preparation for
> adding FIFO file name options.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-record.c | 22 ++--------------------
>  tools/perf/builtin-stat.c   | 22 ++--------------------
>  tools/perf/util/evlist.c    | 24 ++++++++++++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  4 files changed, 29 insertions(+), 40 deletions(-)

Acked-by: Alexei Budankov <alexey.budankov@linux.intel.com>

Regards,
Alexei
