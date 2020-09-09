Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FE4C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D915721919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgIIIvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:51:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:58462 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgIIIvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:51:46 -0400
IronPort-SDR: WkCwgNUqb1GdWwEqNPmVosp2md0T2gtHeQRDNqhfQ0d+qXtU3mR5w3YhKzJHG4ifys9D9hfm4O
 xWAfIZ5HRAig==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155694946"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155694946"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 01:49:49 -0700
IronPort-SDR: qOzUxO62IOhBqi8ernrmcw2iZgkIAqbMzQGLQ2g4ruvzODQhYhsOGm//tLXi1O5dejZlXYnF6J
 sbDXwNuxSldQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="328830366"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.190])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2020 01:49:47 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Yu@vger.kernel.org,
        Yu-cheng <yu-cheng.yu@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf intel-pt: Improve handling for tid is -1
Date:   Wed,  9 Sep 2020 11:49:21 +0300
Message-Id: <20200909084923.9096-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a minor non-urgent fix for Intel PT.


Adrian Hunter (2):
      perf script: Display negative tid in non-sample events
      perf intel-pt: Fix "context_switch event has no tid" error

 tools/perf/builtin-script.c | 10 ++++++----
 tools/perf/util/event.c     |  2 +-
 tools/perf/util/intel-pt.c  |  8 ++++----
 3 files changed, 11 insertions(+), 9 deletions(-)


Regards
Adrian
