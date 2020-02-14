Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12DFC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAF92082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgBNW2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:28:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:5118 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgBNW1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:21 -0800
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="227756426"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:21 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] New way to track mce notifier chain actions
Date:   Fri, 14 Feb 2020 14:27:13 -0800
Message-Id: <20200214222720.13168-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212204652.1489-1-tony.luck@intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parts 1 & 2 are just cleanup.  CEC should follow the same rules
as everyone else who wants to be on the mce notifier chain. No
real reason for it to have direct hooks into mce/core.c
	[No substantive change since RFC version 1, but note that
	 I have kept the change to make CEC a "normal" user of
	 the mce notifier chain. Result is a few checks for
	 if (mce->kflags & MCE_HANDLED_CEC) in EDAC etc. drivers.]

Part 3 adds a field to struct mce, and defines the BIT fields
for each class of notifier. All EDAC drivers share the same BIT
since only one of them should be active.
	[Boris: Changed name of new field to "kflags" and made
	        it __u64, so plenty of space for possible future
		other uses]

Part 4 Re-done since draft based on Luto and Tglx comments that
	we should kill of all usage of NOTIFY_STOP. This patch
	now gets rid of all but one.  That's an AMD case where
	it looks like they don't want to decode some particular
	errors on a specific platform.  The right fix for that
	is to take Luto's advice and filter out before that item
	gets to the notifier chain. We even already have a filter
	function (filter_mce) to do that! But that change needs
	to be handled by someone with the appropriate h/w.

Part 5	Now just checks for mce->kflags in the default handler at
	the end of the chain to decide whether to print.

Part 6	NEW - add mce=print_all option to override default and
	print everything to the console. Intended for debug, or
	desperation scenarios where other logs are lost.

Part 7	NEW - Delete the code that tries to make sure only one
	out of acpi_extlog and the current loaded EDAC driver
	deals with an error.


Tony Luck (7):
  x86/mce: Rename "first" function as "early"
  x86/mce: Convert corrected error collector to use mce notifier
  x86/mce: Add new "kflags" field to "struct mce"
  x86/mce: Fix all mce notifiers to update the mce->kflags bitmask
  x86/mce: Change default mce logger to check mce->kflags
  x86/mce: Add mce=print_all option
  x86/mce: Drop the EDAC report status checks

 arch/x86/include/asm/mce.h           | 15 +++----
 arch/x86/include/uapi/asm/mce.h      |  9 ++++
 arch/x86/kernel/cpu/mce/core.c       | 58 ++++++++------------------
 arch/x86/kernel/cpu/mce/dev-mcelog.c |  5 +++
 arch/x86/kernel/cpu/mce/internal.h   |  1 +
 drivers/acpi/acpi_extlog.c           | 19 ++-------
 drivers/acpi/nfit/mce.c              |  1 +
 drivers/edac/edac_mc.c               | 61 ----------------------------
 drivers/edac/i7core_edac.c           |  5 ++-
 drivers/edac/mce_amd.c               |  9 +++-
 drivers/edac/pnd2_edac.c             |  8 ++--
 drivers/edac/sb_edac.c               |  7 ++--
 drivers/edac/skx_common.c            |  3 +-
 drivers/ras/cec.c                    | 29 +++++++++++++
 include/linux/edac.h                 |  8 ----
 15 files changed, 91 insertions(+), 147 deletions(-)


base-commit: b19e8c68470385dd2c5440876591fddb02c8c402
-- 
2.21.1

