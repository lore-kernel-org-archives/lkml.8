Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC38C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DFD206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633043AbgDNUXB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:23:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:52201 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633019AbgDNUWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:22:45 -0400
IronPort-SDR: TaG4wlkcMUzvzbGZWoWhj5AiYzGSnQ56NJoK2i09u24qDwhgkH0XKUFezb6UmXJjYBDFzDaiz+
 jM6uDlBjl4OA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:22:42 -0700
IronPort-SDR: V0+HOszgHeIq+0rekuUIV0Y5Q1Ykf6UNOYs4D2TW1H2VxAUm2gYsw9HXh0Xx3tblx45u/ZzrI5
 5d9Vclu4QyOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="245510622"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2020 13:22:42 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 13:22:41 -0700
Received: from orsmsx108.amr.corp.intel.com ([169.254.2.172]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.99]) with mapi id 14.03.0439.000;
 Tue, 14 Apr 2020 13:22:41 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: Use ARRAY_SIZE instead of hardcoded siz
Thread-Topic: [PATCH] ACPICA: Use ARRAY_SIZE instead of hardcoded siz
Thread-Index: AQHWEZysu7u4opIOMUyKgwd1vmqkR6h5D5pA
Date:   Tue, 14 Apr 2020 20:22:40 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3C68A849E@ORSMSX108.amr.corp.intel.com>
References: <20200413143156.22633-1-yanaijie@huawei.com>
In-Reply-To: <20200413143156.22633-1-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we've discussed this in the past. ARRAY_SIZE is not standard, and will get in the way of portability:

On gcc v7.4.0:
../../../source/components/resources/rsdumpinfo.c:335:25: note: in expansion of macro 'ACPI_RSD_TABLE_SIZE'
     {ACPI_RSD_TITLE,    ACPI_RSD_TABLE_SIZE (AcpiRsDumpGenericReg),         "Generic Register",         NULL},

../../../source/components/resources/rsdumpinfo.c:166:37: error: initializer element is not constant
 #define ACPI_RSD_TABLE_SIZE(name)   ARRAY_SIZE (name)


And, on MSVC 2017:
Severity	Code	Description	Project	File	Line	Suppression State
Warning	C4013	'ARRAY_SIZE' undefined; assuming extern returning int	AcpiExec	c:\acpica\source\components\resources\rsdumpinfo.c	179	
-----Original Message-----
From: Jason Yan <yanaijie@huawei.com> 
Sent: Monday, April 13, 2020 7:32 AM
To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ACPICA: Use ARRAY_SIZE instead of hardcoded siz

Fix the following coccicheck warning:

./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/acpi/acpica/rsdumpinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index cafa8134b4c6..f1ba4cd8080f 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -15,7 +15,7 @@ ACPI_MODULE_NAME("rsdumpinfo")  #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUGGER)
 #define ACPI_RSD_OFFSET(f)          (u8) ACPI_OFFSET (union acpi_resource_data,f)
 #define ACPI_PRT_OFFSET(f)          (u8) ACPI_OFFSET (struct acpi_pci_routing_table,f)
-#define ACPI_RSD_TABLE_SIZE(name)   (sizeof(name) / sizeof (struct acpi_rsdump_info))
+#define ACPI_RSD_TABLE_SIZE(name)   ARRAY_SIZE(name)
 /*******************************************************************************
  *
  * Resource Descriptor info tables
--
2.21.1

