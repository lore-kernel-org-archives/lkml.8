Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303F2C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158BB20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502156AbgDPIad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:30:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:19918 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441235AbgDPIQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:16:38 -0400
IronPort-SDR: vbYQfoHR1qfzdgayBDNutBTmvwcsrzg+CSO3kLXs3SuiC9p4HjPRwVefNC0RxUxLHRFk+DFnk7
 Nt9TUPJbTnTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:16:06 -0700
IronPort-SDR: Xz9m7BES6KOvRCaaTZCxBIVborDUIhjglxM36PIfasEjEQw64NEBsem2Tj6mIBUCewthdBIyK4
 +7m/qS1GFRPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="277912396"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2020 01:16:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C848BF4E; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 16/20] x86/platform/intel-mid: Add empty stubs for intel_scu_devices_[create|destroy]()
Date:   Thu, 16 Apr 2020 11:15:48 +0300
Message-Id: <20200416081552.68083-17-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to call the functions even when CONFIG_X86_INTEL_MID is not
enabled.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel-mid.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index 8e5af119dc2d..de58391bdee0 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -88,11 +88,17 @@ static inline bool intel_mid_has_msic(void)
 	return (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_PENWELL);
 }
 
+extern void intel_scu_devices_create(void);
+extern void intel_scu_devices_destroy(void);
+
 #else /* !CONFIG_X86_INTEL_MID */
 
 #define intel_mid_identify_cpu()	0
 #define intel_mid_has_msic()		0
 
+static inline void intel_scu_devices_create(void) { }
+static inline void intel_scu_devices_destroy(void) { }
+
 #endif /* !CONFIG_X86_INTEL_MID */
 
 enum intel_mid_timer_options {
@@ -115,9 +121,6 @@ extern enum intel_mid_timer_options intel_mid_timer_options;
 #define SFI_MTMR_MAX_NUM		8
 #define SFI_MRTC_MAX			8
 
-extern void intel_scu_devices_create(void);
-extern void intel_scu_devices_destroy(void);
-
 /* VRTC timer */
 #define MRST_VRTC_MAP_SZ		1024
 /* #define MRST_VRTC_PGOFFSET		0xc00 */
-- 
2.25.1

