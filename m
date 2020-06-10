Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE52DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECB82081A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgFJUVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:21:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:53249 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgFJUVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:21:50 -0400
IronPort-SDR: 4zDQ23Y+hruCLkPaIg3Eb0FTF0WJhI6e6zUNvN0Yp2BBh1HbE7wlGNPeVHJ4uP1uns5wGvn5NW
 w9D4hZRu0SZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 13:21:49 -0700
IronPort-SDR: r1Zbibk8XXir5xJvUIE1LXJTAFKapEGUABZjG2uK6GbCFlViEbZnc8NAzbMEUYtKiF/DCc6D0q
 XratW+5cxkrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,497,1583222400"; 
   d="scan'208";a="380178474"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.141])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2020 13:21:49 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com
Subject: [RFC PATCH 0/3] Add Documentation for /proc/cpuinfo flags 
Date:   Wed, 10 Jun 2020 13:06:58 -0700
Message-Id: <20200610200701.16757-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there isn't any documentation in the kernel about how
/proc/cpuinfo flags are generated and what it means when they are
missing. x86 maintainers have expressed objections on adding flags
for features without kernel use cases and that part of the reason is
the lack of documentation on the logic behind such flags.

If users want to know if a feature is available on a given system, they
try to find the flag in /proc/cpuinfo. If a given flag is present, it
means that Linux supports it. If such flag represents a hardware feature,
it also means that the hardware supports it. Therefore, it is not
sufficient to read CPUID to determine whether a hardware feature is
available. If the flag is missing in /proc/cpuinfo, users need to find
out the reason why the flag is missing and how to enable it, which is
not always easy.

/proc/cpuinfo should show all of the hardware features and bugs that any
application or end user might care about. Some of these flags are derived
from CPUID, and others are derived from other sources, including some that
are entirely software-based. Add documentation how features are created,
naming of the flags and when they are missing, what it means to users.

Include two instances of features for which there are not implemented
use cases in the kernel.

Patch 1 creates a new documentation for /proc/cpuinfo flags bits.
Patch 2 adds X86_FEATURE_SERIALIZE.
Patch 3 adds X86_FEATURE_TSXLDTRK.

This RFC series has been reviewed by Dave Hansen.

Kyung Min Park (2):
  Documentation/x86: Add documentation for /proc/cpuinfo feature flags
  x86/cpufeatures: Enumerate TSX suspend load address tracking
    instructions

Ricardo Neri (1):
  x86/cpufeatures: Add enumeration for SERIALIZE instruction

 Documentation/x86/cpuinfo.rst      | 152 +++++++++++++++++++++++++++++
 Documentation/x86/index.rst        |   1 +
 arch/x86/include/asm/cpufeatures.h |   2 +
 3 files changed, 155 insertions(+)
 create mode 100644 Documentation/x86/cpuinfo.rst

-- 
2.17.1

