Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF17C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0BC206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgCQGWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:22:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:53584 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQGWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:22:36 -0400
IronPort-SDR: JZycfbG+ucYUuHuXW3BcWjYCW356bOcHWFvMfHc34anAoSfzd6X7M5b+cgJ+rhFP4cT+fWYW1m
 c83GQX1fNkVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 23:22:35 -0700
IronPort-SDR: 5oidMHARsF61tyh6bJeAKehMLXiA7MoeACfDaXBw6m9WWYhj792BLw2iByg4bZPm85mfL7HwLn
 yhef3WOxsHmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="445390308"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2020 23:22:34 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/6] intel_th/stm class: Updates for v5.7
Date:   Tue, 17 Mar 2020 08:22:09 +0200
Message-Id: <20200317062215.15598-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

These are the patches I have for the next merge window. They are mostly
fixes, one new PCI ID and a "feature" for the Trace Hub's memory buffer
trace collection. Andy Shevchenko again lent his keen reviewer's eye,
and aiaiai static checkers approve.

A signed tag can be found below, individual patches follow. Please,
consider pulling or applying. Thanks!

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-stm-for-greg-20200316

for you to fetch changes up to dfc01b7430dc478ce5728539af6f961b7a3ce908:

  intel_th: pci: Add Elkhart Lake CPU support (2020-03-16 20:06:04 +0200)

----------------------------------------------------------------
intel_th/stm class: Updates for v5.7

These are:
 * An option to (not) stop the trace on buffer-full condition
 * Various small fixes
 * A new PCI ID for Intel TH

----------------------------------------------------------------
Alexander Shishkin (6):
      intel_th: Disallow multi mode on devices where it's broken
      stm class: sys-t: Fix the use of time_after()
      intel_th: msu: Make stopping the trace optional
      intel_th: msu: Fix the unexpected state warning
      intel_th: Fix user-visible error codes
      intel_th: pci: Add Elkhart Lake CPU support

 .../ABI/testing/sysfs-bus-intel_th-devices-msc     |  8 +++
 drivers/hwtracing/intel_th/intel_th.h              |  2 +
 drivers/hwtracing/intel_th/msu.c                   | 61 ++++++++++++++++++----
 drivers/hwtracing/intel_th/pci.c                   | 13 ++++-
 drivers/hwtracing/stm/p_sys-t.c                    |  6 +--
 5 files changed, 76 insertions(+), 14 deletions(-)

-- 
2.25.1

