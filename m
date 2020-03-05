Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD16C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D36B206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCEWpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:45:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:5017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgCEWpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674594"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:44 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 00/27] tools/power/x86/intel-speed-select: Enhancements
Date:   Thu,  5 Mar 2020 14:45:11 -0800
Message-Id: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are not urgent fixes, but improves usability based on user
feedback. This series addresses:
- Check validaity of user options for a command
- Print helpful errors
- Improves help
- Enhance existing options like --info
- Fixes issues with json keys
- Take care of handling offline CPUs


Srinivas Pandruvada (27):
  tools/power/x86/intel-speed-select: Warn for invalid package id
  tools/power/x86/intel-speed-select: Make target CPU optional for
    core-power info
  tools/power/x86/intel-speed-select: Enhance core-power info command
  tools/power/x86/intel-speed-select: Use more verbiage for clos
    information
  tools/power/x86/intel-speed-select: Special handling for CPU 0
    online/offline
  tools/power/x86/intel-speed-select: Max CPU count calculation when
    CPU0 is offline
  tools/power/x86/intel-speed-select: Store topology information
  tools/power/x86/intel-speed-select: Helpful warning for missing kernel
    interface
  tools/power/x86/intel-speed-select: Enhance help
  tools/power/x86/intel-speed-select: Enhance --info option
  tools/power/x86/intel-speed-select: Add an API for error/information
    print
  tools/power/x86/intel-speed-select: Improve error display for
    perf-profile feature
  tools/power/x86/intel-speed-select: Check feature status first
  tools/power/x86/intel-speed-select: Display error for invalid priority
    type
  tools/power/x86/intel-speed-select: Enhance help for core-power assoc
  tools/power/x86/intel-speed-select: Improve output of perf-profile
    commands
  tools/power/x86/intel-speed-select: Improve error display for
    base-freq feature
  tools/power/x86/intel-speed-select: Improve error display for
    turbo-freq feature
  tools/power/x86/intel-speed-select: Kernel interface error handling
  tools/power/x86/intel-speed-select: Improve core-power result and
    error display
  tools/power/x86/intel-speed-select: Show error for invalid CPUs in the
    options
  tools/power/x86/intel-speed-select: Improve CLX commands
  tools/power/x86/intel-speed-select: Fix avx options for turbo-freq
    feature
  tools/power/x86/intel-speed-select: Print friendly warning for bad
    command line
  tools/power/x86/intel-speed-select: Add display for enabled cpus count
  tools/power/x86/intel-speed-select: Avoid duplicate Package strings
    for json
  tools/power/x86/intel-speed-select: Update version

 .../x86/intel-speed-select/isst-config.c      | 574 ++++++++++++++----
 .../power/x86/intel-speed-select/isst-core.c  | 117 +++-
 .../x86/intel-speed-select/isst-display.c     | 274 ++++++---
 tools/power/x86/intel-speed-select/isst.h     |  12 +-
 4 files changed, 752 insertions(+), 225 deletions(-)

-- 
2.24.1

