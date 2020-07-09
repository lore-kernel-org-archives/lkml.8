Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9BBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5D6207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgGIRhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:37:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:35018 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgGIRhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:37:11 -0400
IronPort-SDR: S0Usv0knfCEY2x0/ENir2WhzrYcSXSVsHBzoSg2ypQeTKm42ilNdCtr80xqauJd5q6fACH3oy9
 vwAPXf80MAKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149537096"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149537096"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:37:11 -0700
IronPort-SDR: ISd2rf2HfEUiFRrOaYM4c3M9ujmqmHW+7IuBBzk9LLWjLn7QCBMhwTAoeU6NJx4iQud2I4VQKw
 YlWjnn5qPV/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324292497"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 10:37:09 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] perf intel-pt: Add support for decoding FUP/TIP only
Date:   Thu,  9 Jul 2020 20:36:17 +0300
Message-Id: <20200709173628.5613-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some fixes and small improvements for Intel PT.


Adrian Hunter (11):
      perf intel-pt: Fix FUP packet state
      perf intel-pt: Fix duplicate branch after CBR
      perf tools: Improve aux_output not supported error
      perf auxtrace: Add optional error flags to the itrace 'e' option
      perf intel-pt: Use itrace error flags to suppress some errors
      perf auxtrace: Add optional log flags to the itrace 'd' option
      perf intel-pt: Use itrace debug log flags to suppress some messages
      perf intel-pt: Time filter logged perf events
      perf auxtrace: Add itrace 'q' option for quicker, less detailed decoding
      perf intel-pt: Add support for decoding FUP/TIP only
      perf intel-pt: Add support for decoding PSB+ only

 tools/perf/Documentation/itrace.txt                |   9 +
 tools/perf/Documentation/perf-intel-pt.txt         |  25 ++-
 tools/perf/util/auxtrace.c                         |   7 +
 tools/perf/util/auxtrace.h                         |   6 +
 tools/perf/util/evsel.c                            |   4 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 214 +++++++++++++++++++--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
 tools/perf/util/intel-pt.c                         |  51 ++++-
 8 files changed, 287 insertions(+), 30 deletions(-)


Regards
Adrian
