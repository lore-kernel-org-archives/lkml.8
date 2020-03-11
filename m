Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC0FC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1B621D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgCKMVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:21:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:31410 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgCKMVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:21:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 05:21:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="234694349"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga007.fm.intel.com with ESMTP; 11 Mar 2020 05:21:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf intel-pt: Intel PT man page
Date:   Wed, 11 Mar 2020 14:20:31 +0200
Message-Id: <20200311122034.3697-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are patches that make the Intel PT documentation into a man page.


Adrian Hunter (3):
      perf intel-pt: Rename intel-pt.txt and put it in man page format
      perf intel-pt: Add Intel PT man page references
      perf intel-pt: Update intel-pt.txt file with new location of the documentation

 tools/perf/Documentation/intel-pt.txt      |  992 +--------------------------
 tools/perf/Documentation/perf-inject.txt   |    3 +-
 tools/perf/Documentation/perf-intel-pt.txt | 1007 ++++++++++++++++++++++++++++
 tools/perf/Documentation/perf-record.txt   |    2 +-
 tools/perf/Documentation/perf-report.txt   |    3 +-
 tools/perf/Documentation/perf-script.txt   |    2 +-
 6 files changed, 1014 insertions(+), 995 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-intel-pt.txt


Regards
Adrian
