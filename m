Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715FAC81857
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5091A2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD0XVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:21:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:55740 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgD0XVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:21:06 -0400
IronPort-SDR: 60Fyd8lDUnZDjcSukgwnHnbSVivkZXpKzrQ6ykQraJycxBhdNVdZivI6HChTX5bmC8AYK/+paC
 3u9WkTA73qtg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 16:21:05 -0700
IronPort-SDR: 9ft+PHVy2iFsvJsAlNi+avj5wS1ZQbS4GIq2K94JuxX2lZvjjlELcQSj3ZFsaA2Vo4nSWtMpAS
 eIr39KkcTeHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="293691443"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2020 16:21:04 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        sean.v.kelley@intel.com, kuo-lang.tseng@intel.com,
        Jithu Joseph <jithu.joseph@intel.com>
Subject: [PATCH v3 0/1] platform/x86: Add Slim Bootloader firmware update support
Date:   Mon, 27 Apr 2020 16:15:13 -0700
Message-Id: <20200427231514.24777-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 addresses review comment from Andy Shevchenko to v2.

Changes in v3
 - Renamed the driver file to intel-wmi-sbl-fw-update.c. This resulted in
   various changes like:
    - renaming, reordering the driver entry in Makefile and Kconfig
    - renaming, reordering the MAINTAINERS file entry
    - renamed the ABI file
    - renaming few data structures and wmi_driver entries to reflect the
      new name

v2 Upstream submission is available here:
https://lore.kernel.org/lkml/20200423224222.29730-1-jithu.joseph@intel.com


From v2 submission:

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

 .../sysfs-platform-intel-wmi-sbl-fw-update    |  12 ++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/Kconfig                  |  10 ++
 drivers/platform/x86/Makefile                 |   1 +
 .../platform/x86/intel-wmi-sbl-fw-update.c    | 145 ++++++++++++++++++
 5 files changed, 175 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update
 create mode 100644 drivers/platform/x86/intel-wmi-sbl-fw-update.c


base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.17.1

