Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DE320774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgF3Tso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:48:44 -0400
Received: from foss.arm.com ([217.140.110.172]:32882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgF3Tso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:48:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C47931B;
        Tue, 30 Jun 2020 12:48:43 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5819D3F73C;
        Tue, 30 Jun 2020 12:48:42 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/14] arm64: Optimise and update memcpy, user copy and string routines
Date:   Tue, 30 Jun 2020 19:48:08 +0000
Message-Id: <20200630194822.1082-1-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This contains an update to the cortex-strings patchset: the
correctness of the fixup routines are improved, with the aim being to
return the exact number of remaining bytes for all copy sizes.
To ensure they are exact - which the current fixups are not for some
copy sizes and are off by a few byes - is an extension to the
original intention of fixing an issue reported by an LTP run last
year, where the fixup routine in v2 of this patchset (which was
importing the cortex-strings memcpy implementation) would over-report
the number of bytes that successfully copied.
Version 3 addressed this but I later found some issues with the fixup
correctness after further testing, and have partially re-written them
here, and addressed some other behaviours of the copy algorithm.

Comments welcome,

Thanks
Oliver

v1: https://lore.kernel.org/linux-arm-kernel/cover.1571073960.git.robin.murphy@arm.com/
v2: https://lore.kernel.org/linux-arm-kernel/cover.1571421836.git.robin.murphy@arm.com/
v3: https://lore.kernel.org/linux-arm-kernel/20200514143227.605-1-oli.swede@arm.com/

Changes since v3:
* Improves the accuracy of the fixups in response to issues that
  arose during futher testing
* Accounts for faults on store instructions on systems with UAO
  enabled
* Expands on comments detailing the implementation

Changes since v2:
* Adds Robin's separate patch that fixes a compilation issue with
  KProbes fixup [1]
* Imports the most recent memcpy implementation by updating Sam's
  patch (and moves this patch to occur after the cortex-strings
  importing so that it's closer to the patches containing its 
  corresponding fixups)
* Uses the stack to preserve the initial parameters
* Replaces the usercopy fixup routine in v2 with multiple longer
  fixups that each make use of the fault address to return the exact
  number of bytes that haven't yet copied.

[1] https://lore.kernel.org/linux-arm-kernel/e70f7b9de7e601b9e4a6fedad8eaf64d304b1637.1571326276.git.robin.murphy@arm.com/

Oliver Swede (5):
  arm64: Store the arguments to copy_*_user on the stack
  arm64: Use additional memcpy macros and fixups
  arm64: Add fixup routines for usercopy load exceptions
  arm64: Add fixup routines for usercopy store exceptions
  arm64: Improve accuracy of fixup for UAO cases

Robin Murphy (2):
  arm64: kprobes: Drop open-coded exception fixup
  arm64: Tidy up _asm_extable_faultaddr usage

Sam Tebbs (7):
  arm64: Allow passing fault address to fixup handlers
  arm64: Import latest version of Cortex Strings' memcmp
  arm64: Import latest version of Cortex Strings' memmove
  arm64: Import latest version of Cortex Strings' strcmp
  arm64: Import latest version of Cortex Strings' strlen
  arm64: Import latest version of Cortex Strings' strncmp
  arm64: Import latest optimization of memcpy

 arch/arm64/include/asm/alternative.h |  36 ---
 arch/arm64/include/asm/assembler.h   |  13 +
 arch/arm64/include/asm/extable.h     |  10 +-
 arch/arm64/kernel/probes/kprobes.c   |   7 -
 arch/arm64/lib/copy_from_user.S      | 272 +++++++++++++++--
 arch/arm64/lib/copy_in_user.S        | 287 ++++++++++++++++--
 arch/arm64/lib/copy_template.S       | 377 +++++++++++++----------
 arch/arm64/lib/copy_template_user.S  |  50 ++++
 arch/arm64/lib/copy_to_user.S        | 273 +++++++++++++++--
 arch/arm64/lib/copy_user_fixup.S     | 433 +++++++++++++++++++++++++++
 arch/arm64/lib/memcmp.S              | 333 ++++++++------------
 arch/arm64/lib/memcpy.S              | 127 ++++++--
 arch/arm64/lib/memmove.S             | 232 +++++---------
 arch/arm64/lib/strcmp.S              | 272 +++++++----------
 arch/arm64/lib/strlen.S              | 247 ++++++++++-----
 arch/arm64/lib/strncmp.S             | 363 ++++++++++------------
 arch/arm64/mm/extable.c              |  13 +-
 arch/arm64/mm/fault.c                |   2 +-
 18 files changed, 2228 insertions(+), 1119 deletions(-)
 create mode 100644 arch/arm64/lib/copy_template_user.S
 create mode 100644 arch/arm64/lib/copy_user_fixup.S

-- 
2.17.1

