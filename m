Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C03C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFAC206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHDNfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:35:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:35799 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgHDNfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:35:03 -0400
IronPort-SDR: H+GurQ+Tx6hV5fBElpHvtfF6VYVpt/EfR2st4wC1hiH11gg+lO5BRZaq+58/3nxnRN5zi10Hbw
 lgeJMO3sslAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="213845234"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="213845234"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 06:35:02 -0700
IronPort-SDR: wB6qGLmIhUh+DA0ygVAsJn0Twt21K41cRG9dFAmomP8Vof/2fPqiSNDPinGDkGIRy9FJFJk09k
 zX/ycn8spXAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="492894207"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 04 Aug 2020 06:35:00 -0700
Subject: Re: [PATCH V2 00/12] perf intel-pt: Add support for decoding FUP/TIP
 only
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20200710151104.15137-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f0a4f89f-f642-f75f-a390-da16d0a058d0@intel.com>
Date:   Tue, 4 Aug 2020 16:34:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 6:10 pm, Adrian Hunter wrote:
> Hi
> 
> Here are some fixes and small improvements for Intel PT.

Andi added his "Reviewed-by" with 2 comments to tweak the
documentation.

The patches still apply, so do you want me to send a V3?

> 
> Changes in V2:
> 	For d/e flags, use +/- alphabetic options instead of numbers
> 	Update help text
> 	Improve documentation
> 
> 
> Adrian Hunter (12):
>       perf intel-pt: Fix FUP packet state
>       perf intel-pt: Fix duplicate branch after CBR
>       perf tools: Improve aux_output not supported error
>       perf auxtrace: Add missing itrace options to help text
>       perf auxtrace: Add optional error flags to the itrace 'e' option
>       perf intel-pt: Use itrace error flags to suppress some errors
>       perf auxtrace: Add optional log flags to the itrace 'd' option
>       perf intel-pt: Use itrace debug log flags to suppress some messages
>       perf intel-pt: Time filter logged perf events
>       perf auxtrace: Add itrace 'q' option for quicker, less detailed decoding
>       perf intel-pt: Add support for decoding FUP/TIP only
>       perf intel-pt: Add support for decoding PSB+ only
> 
>  tools/perf/Documentation/itrace.txt                |  14 ++
>  tools/perf/Documentation/perf-intel-pt.txt         |  63 +++++-
>  tools/perf/util/auxtrace.c                         |  50 +++++
>  tools/perf/util/auxtrace.h                         |  31 ++-
>  tools/perf/util/evsel.c                            |   4 +
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 214 +++++++++++++++++++--
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
>  tools/perf/util/intel-pt.c                         |  45 ++++-
>  8 files changed, 389 insertions(+), 33 deletions(-)
> 
> 
> Regards
> Adrian
> 

