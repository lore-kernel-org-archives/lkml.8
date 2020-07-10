Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F47C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E08E20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGJPMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:12:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:38264 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgGJPLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:11:53 -0400
IronPort-SDR: MVSYzkQxJyFU5XKt0utPPNnuPPOf1yzZqZKEJAG03G94X3bV6RBgzwLDdXrVdzFtceQ9KVW7er
 QRa/S27qrS7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686169"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686169"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:11:47 -0700
IronPort-SDR: /b5b1ZrAefTgCsqe60Bv8qcmJOgeeVbWFa5Ol+QKMA9sFlgaoRwH6AjfmIIktpqQmfUZmYbXei
 QCDwEtkgRLAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675443"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:11:46 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/12] perf intel-pt: Add support for decoding FUP/TIP only
Date:   Fri, 10 Jul 2020 18:10:52 +0300
Message-Id: <20200710151104.15137-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some fixes and small improvements for Intel PT.

Changes in V2:
	For d/e flags, use +/- alphabetic options instead of numbers
	Update help text
	Improve documentation


Adrian Hunter (12):
      perf intel-pt: Fix FUP packet state
      perf intel-pt: Fix duplicate branch after CBR
      perf tools: Improve aux_output not supported error
      perf auxtrace: Add missing itrace options to help text
      perf auxtrace: Add optional error flags to the itrace 'e' option
      perf intel-pt: Use itrace error flags to suppress some errors
      perf auxtrace: Add optional log flags to the itrace 'd' option
      perf intel-pt: Use itrace debug log flags to suppress some messages
      perf intel-pt: Time filter logged perf events
      perf auxtrace: Add itrace 'q' option for quicker, less detailed decoding
      perf intel-pt: Add support for decoding FUP/TIP only
      perf intel-pt: Add support for decoding PSB+ only

 tools/perf/Documentation/itrace.txt                |  14 ++
 tools/perf/Documentation/perf-intel-pt.txt         |  63 +++++-
 tools/perf/util/auxtrace.c                         |  50 +++++
 tools/perf/util/auxtrace.h                         |  31 ++-
 tools/perf/util/evsel.c                            |   4 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 214 +++++++++++++++++++--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
 tools/perf/util/intel-pt.c                         |  45 ++++-
 8 files changed, 389 insertions(+), 33 deletions(-)


Regards
Adrian
