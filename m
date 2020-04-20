Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59427C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A272074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgDTTuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:50:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:25014 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgDTTuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:50:40 -0400
IronPort-SDR: 26XDzRrvTClvlbWqvrhhkyL3/gBPSTrZBtlnGRGPxgBmEGkJv3RQQg7YkdOhvlDbHNb3x202HK
 056H0G315Eiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 12:50:39 -0700
IronPort-SDR: Afwo29XKvnrplIUz8zwXLEe4WnVomTo4tMaFxgQ7z15CoJlVX45jHGJB+sBePtG36AE4nArqIM
 eNk3Q/88JmtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="401946193"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2020 12:50:39 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        sean.v.kelley@intel.com, kuo-lang.tseng@intel.com,
        Jithu Joseph <jithu.joseph@intel.com>
Subject: [PATCH 0/1] platform/x86: Add Slim Bootloader firmware update support
Date:   Mon, 20 Apr 2020 12:44:04 -0700
Message-Id: <20200420194405.8281-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slim Bootloader(SBL) [1] is a small open-source boot firmware,
designed for running on certain Intel platforms. SBL can be
thought-of as fulfilling the role of a minimal BIOS
implementation, i.e initializing the hardware and booting
Operating System.

This driver creates sysfs interfaces which allows user space entities
to trigger update of SBL firmware.

Acknowledgment: Initial draft of the driver code was authored by
Maurice Ma <maurice.ma@intel.com>

[1] https://slimbootloader.github.io

Jithu Joseph (1):
  platform/x86: Add Slim Bootloader firmware update signaling driver

 MAINTAINERS                        |   7 ++
 drivers/platform/x86/Kconfig       |  10 ++
 drivers/platform/x86/Makefile      |   1 +
 drivers/platform/x86/sbl_fwu_wmi.c | 143 +++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 drivers/platform/x86/sbl_fwu_wmi.c


base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
-- 
2.17.1

