Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D20DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A52F2467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAVQ2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:28:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:54723 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbgAVQ2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:28:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:28:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="222083128"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jan 2020 08:28:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2F4331AD; Wed, 22 Jan 2020 18:28:13 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] platform/x86: intel_scu_ipc: A fix and cleanups
Date:   Wed, 22 Jan 2020 19:28:03 +0300
Message-Id: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As suggested by Greg in the discussion around my SCU/PMC IPC rework series [1],
I split the cleanups touching intel_scu_ipc driver in a separate series
that can be applied independly.

The first patch fixes interrupt support to work in Intel Merrifield. The
rest of the patches are cleanups mostly removing code that is not used
anywhere.

[1] https://lkml.org/lkml/2020/1/21/678

Mika Westerberg (10):
  platform/x86: intel_scu_ipc: Fix interrupt support
  platform/x86: intel_scu_ipc: Add constants for register offsets
  platform/x86: intel_scu_ipc: Remove Lincroft support
  platform/x86: intel_scu_ipc: Drop intel_scu_ipc_i2c_cntrl()
  platform/x86: intel_scu_ipc: Sleeping is fine when polling
  platform/x86: intel_scu_ipc: Drop unused prototype intel_scu_ipc_fw_update()
  platform/x86: intel_scu_ipc: Drop unused macros
  platform/x86: intel_scu_ipc: Drop intel_scu_ipc_io[read|write][8|16]()
  platform/x86: intel_scu_ipc: Drop intel_scu_ipc_raw_command()
  platform/x86: intel_scu_ipc: Reformat kernel-doc comments of exported functions

 arch/x86/include/asm/intel_scu_ipc.h |  20 --
 drivers/platform/x86/intel_scu_ipc.c | 414 ++++++---------------------
 2 files changed, 91 insertions(+), 343 deletions(-)

-- 
2.24.1

