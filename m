Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4426C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC8020787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgDASa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:30:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:5040 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732316AbgDASa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:30:58 -0400
IronPort-SDR: gsMiNtKxcdu5oVJ76pI5gLAPdvxM/nETmL1y5M7CrLuOd1vvc4axrOfDx/itkBQn6dIg+9X8Xn
 /8O+LxjwQhMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 11:30:57 -0700
IronPort-SDR: wVPU0WUjVp8y/JWvA0x6xRVuOmgt37FAkIkzjAxLh7lReCE30B1UpmOoNMDWknHmdK7Qp5+Stm
 rP75WdVe2RDQ==
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="249552580"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 11:30:57 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 0/2] x86/resctrl: Enable user to view and select thread throttling mode
Date:   Wed,  1 Apr 2020 11:30:46 -0700
Message-Id: <cover.1585765499.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch in this series introduces a new resctrl file,
"thread_throttle_mode", on Intel systems that exposes to the
user how per-thread values are allocated to a core. This is added in
support of newer Intel systems that can be configured to allocate
either maximum or minimum throttling of the per-thread CLOS values
to the core.

Details about the feature can be found in the commit description and
in Chapter 9 of the most recent Intel ISE available from
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

The first patch parses user input with the appropriate sysfs API that has
not previously been used in resctrl. The second patch is added as a
subsequent cleanup that switches existing resctrl string parsing code
to also use this appropriate API.

Reinette Chatre (2):
  x86/resctrl: Enable user to view and select thread throttling mode
  x86/resctrl: Use appropriate API for strings terminated by newline

 Documentation/x86/resctrl_ui.rst       |  21 ++-
 arch/x86/kernel/cpu/resctrl/core.c     |  29 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |   9 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 221 +++++++++++++++++++++++--
 4 files changed, 266 insertions(+), 14 deletions(-)

-- 
2.21.0

