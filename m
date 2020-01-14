Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA12C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700A024673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgANTWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:22:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:48040 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANTWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:22:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 11:22:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="423259140"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2020 11:22:20 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com, prarit@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/5] Intel Speed Select Core Power Support
Date:   Tue, 14 Jan 2020 11:22:12 -0800
Message-Id: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add core-power or SST-CP support. Also fixes some display
issue with SST-TF.

Srinivas Pandruvada (5):
  platform/x86: ISST: Allow additional core-power mailbox commands
  tools/power/x86/intel-speed-select: Add support for core-power
    discovery
  tools/power/x86/intel-speed-select: Fix result display for turbo-freq
    auto mode
  tools/power/x86/intel-speed-select: Change the order for clos disable
  tools/power/x86/intel-speed-select: Update version

 .../intel_speed_select_if/isst_if_common.c    |  3 +
 .../x86/intel-speed-select/isst-config.c      | 34 ++++++------
 .../power/x86/intel-speed-select/isst-core.c  | 55 +++++++++++++++++++
 .../x86/intel-speed-select/isst-display.c     | 27 ++++++---
 tools/power/x86/intel-speed-select/isst.h     |  6 ++
 5 files changed, 100 insertions(+), 25 deletions(-)

-- 
2.24.1

