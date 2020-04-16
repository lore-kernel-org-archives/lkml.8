Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1285C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B887F206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441388AbgDPIYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:24:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:19918 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440397AbgDPIQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:16:50 -0400
IronPort-SDR: 4zMl6053SnIX4bpir7Y1RlESyH3vMfiF4F7HchltOJO2FVVxVHEJhAvu/B7csmNjABX6EQrRGF
 Hjdv24snLY4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:16:06 -0700
IronPort-SDR: kbpRwV7sYmu0zeouw0s8OozPbcJkoOas/ikEV9nqLdFi3cweF+WRlBEdqtR7nf6TlOKG189wjl
 N7/b1810+S7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="277912398"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2020 01:16:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 01E3EF40; Thu, 16 Apr 2020 11:15:54 +0300 (EEST)
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
Subject: [PATCH v9 20/20] MAINTAINERS: Update entry for Intel Broxton PMC driver
Date:   Thu, 16 Apr 2020 11:15:52 +0300
Message-Id: <20200416081552.68083-21-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver lives now under MFD so split the current entry into two parts
and add me as co-maintainer of the Intel Broxton PMC driver. While there
correct formatting of Zha Qipeng's email address.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..9d5694a59bec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8495,6 +8495,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel_atomisp2_pm.c
 
+INTEL BROXTON PMC DRIVER
+M:	Mika Westerberg <mika.westerberg@linux.intel.com>
+M:	Zha Qipeng <qipeng.zha@intel.com>
+S:	Maintained
+F:	drivers/mfd/intel_pmc_bxt.c
+F:	include/linux/mfd/intel_pmc_bxt.h
+
 INTEL C600 SERIES SAS CONTROLLER DRIVER
 M:	Intel SCU Linux support <intel-linux-scu@intel.com>
 M:	Artur Paszkiewicz <artur.paszkiewicz@intel.com>
@@ -8702,6 +8709,13 @@ F:	include/uapi/linux/mic_common.h
 F:	include/uapi/linux/mic_ioctl.h
 F:	include/uapi/linux/scif_ioctl.h
 
+INTEL P-Unit IPC DRIVER
+M:	Zha Qipeng <qipeng.zha@intel.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	arch/x86/include/asm/intel_punit_ipc.h
+F:	drivers/platform/x86/intel_punit_ipc.c
+
 INTEL PMC CORE DRIVER
 M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
 M:	Vishwanath Somayaji <vishwanath.somayaji@intel.com>
@@ -8709,15 +8723,6 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel_pmc_core*
 
-INTEL PMC/P-Unit IPC DRIVER
-M:	Zha Qipeng<qipeng.zha@intel.com>
-L:	platform-driver-x86@vger.kernel.org
-S:	Maintained
-F:	arch/x86/include/asm/intel_pmc_ipc.h
-F:	arch/x86/include/asm/intel_punit_ipc.h
-F:	drivers/platform/x86/intel_pmc_ipc.c
-F:	drivers/platform/x86/intel_punit_ipc.c
-
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
 S:	Maintained
-- 
2.25.1

