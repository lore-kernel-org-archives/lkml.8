Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BDBC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09F520736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgDWWt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:49:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:36983 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDWWt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 18:49:26 -0400
IronPort-SDR: b3wZtSpBe/B0/lo8G3V1DZ9YbMl0k8oMJWXa9RHAPeE9ySTrAI8pwnHrgJan22YkiqMTpF16KV
 0jQoX7mHUt/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 15:49:25 -0700
IronPort-SDR: diI5/0t1rbZ3Sv5KS05Ae7RMdcx0iTHV5JV1E9rIOoG0pvKR6wrEByaReWlTvJftLwGYGUpf/H
 5YO0j1/MEVZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,309,1583222400"; 
   d="scan'208";a="403090496"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga004.jf.intel.com with ESMTP; 23 Apr 2020 15:49:25 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        sean.v.kelley@intel.com, kuo-lang.tseng@intel.com,
        Jithu Joseph <jithu.joseph@intel.com>
Subject: [PATCH v2 0/1] platform/x86: Add Slim Bootloader firmware update support
Date:   Thu, 23 Apr 2020 15:42:21 -0700
Message-Id: <20200423224222.29730-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 Upstream submission is available here:
https://lore.kernel.org/lkml/20200420194405.8281-1-jithu.joseph@intel.com

v2 primarily addresses review comments from Andy Shevchenko to v1. 

Changes in v2
 - Rebased on top of tag: v5.7-rc2
 - Added ABI documentation file
 - Changed the ordering of SBL entry in Makefile and Kconfig
 - Replaced kstrtobool() with kstrtouint() for user input processing
 - Added DocLink: tag to annottate weblink in commit message
 - Minor edits to commit message in p1/1
 - Style related changes

From v1 submission:

Slim Bootloader(SBL) [see link below] is a small open-source boot
firmware, designed for running on certain Intel platforms. SBL can be
thought-of as fulfilling the role of a minimal BIOS
implementation, i.e initializing the hardware and booting
Operating System.

This driver creates sysfs interfaces which allows user space entities
to trigger update of SBL firmware.

Acknowledgment: Initial draft of the driver code was authored by
Maurice Ma <maurice.ma@intel.com>

DocLink: https://slimbootloader.github.io

Jithu Joseph (1):
  platform/x86: Add Slim Bootloader firmware update signaling driver

 .../ABI/testing/sysfs-platform-sbl-fwu-wmi    |  12 ++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/Kconfig                  |  10 ++
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/sbl_fwu_wmi.c            | 144 ++++++++++++++++++
 5 files changed, 174 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-sbl-fwu-wmi
 create mode 100644 drivers/platform/x86/sbl_fwu_wmi.c


base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.17.1

