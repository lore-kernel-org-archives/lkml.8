Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mga14.intel.com ([192.55.52.115]:2894 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbgCKQFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:05:09 -0400
From: "Luck, Tony" <tony.luck@intel.com>
To: Wei Huang <wei.huang2@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@suse.de" <bp@suse.de>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "smita.koralahallichannabasappa@amd.com"
        <smita.koralahallichannabasappa@amd.com>
Subject: RE: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Date: Wed, 11 Mar 2020 16:05:07 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F59AA85@ORSMSX115.amr.corp.intel.com>
References: <20200311044409.2717587-1-wei.huang2@amd.com>
In-Reply-To: <20200311044409.2717587-1-wei.huang2@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+		if ((val & 3UL) == 2UL)
+			set_cpu_cap(c, X86_FEATURE_PPIN);

You may have copied a bug of mine from upstream. We recently found
a system where the BIOS enabled PPIN and set the lock bit.

If that is possible on AMD, then you should just check for enabled at this
point. "if (val & 2UL)"

See this commit in TIP tree:

59b5809655bd ("x86/mce: Fix logic and comments around MSR_PPIN_CTL")

Otherwise looks fine:

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony

