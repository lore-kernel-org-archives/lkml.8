Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022E2C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B9624671
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgBLUqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:46:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:27753 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBLUqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:46:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:46:52 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="281335102"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:46:52 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] New way to track mce notifier chain actions
Date:   Wed, 12 Feb 2020 12:46:47 -0800
Message-Id: <20200212204652.1489-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a skeleton of how it might look. Several issues
arose while looking at this ... not all directly related to
the problem at hand.

Parts 1 & 2 are just cleanup.  CEC should follow the same rules
as everyone else who wants to be on the mce notifier chain. No
real reason for it to have direct hooks into mce/core.c

Part 3 adds a field to struct mce, and defines the BIT fields
for each class of notifier. All EDAC drivers share the same BIT
since only one of them should be active.

Part 4 is where things are interesting and need a great deal more
thought.  A bunch of things on the chain return NOTIFY_STOP which
prevents anything else on the chain from being run.  For the moment
I ignored that semantic and added code everywhere to set the BIT
even though nobody else will see it.  This is because I think at
least some of them should NOT be NOTIFY_STOP.

Part 5 is currently written to always call __print_mce() for
debugging. The "if (1 || ...)" obviously doesn't want the "1"
(though I'd like to add some /sys knob to flip a switch to force
printing for systems where something weird is happening and logs
are being lost).

Tony Luck (5):
  x86/mce: Rename "first" function as "early"
  x86/mce: Convert corrected error collector to use mce notifier
  x86/mce: Add new "handled" field to "struct mce"
  x86/mce: Fix all mce notifiers to update the mce->handled bitmask
  x86/mce: Change default mce logger to check mce->handled

 arch/x86/include/asm/mce.h           | 15 ++++----
 arch/x86/include/uapi/asm/mce.h      |  9 +++++
 arch/x86/kernel/cpu/mce/core.c       | 53 +++++++---------------------
 arch/x86/kernel/cpu/mce/dev-mcelog.c |  1 +
 drivers/acpi/acpi_extlog.c           |  1 +
 drivers/acpi/nfit/mce.c              |  1 +
 drivers/edac/i7core_edac.c           |  1 +
 drivers/edac/mce_amd.c               |  5 ++-
 drivers/edac/pnd2_edac.c             |  1 +
 drivers/edac/sb_edac.c               |  1 +
 drivers/edac/skx_common.c            |  1 +
 drivers/ras/cec.c                    | 29 +++++++++++++++
 12 files changed, 69 insertions(+), 49 deletions(-)

-- 
2.21.1

