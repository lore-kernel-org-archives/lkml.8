Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E220CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56E32072A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389669AbgDMWaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:30:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:8318 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389641AbgDMWaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:30:18 -0400
IronPort-SDR: qNDXRwrbzQX00elko7XGMXvgX2SJWIDI1H9S3mI3jT1BAweLVfoWvT1tseg5XlGh8f8+S46I3J
 CE2DKitqFyuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 15:30:18 -0700
IronPort-SDR: vRCsw9bREBOCC60RABl7bp+ryTEzmchD5yk8aqBS/Cgjhq0OSHv37Wni/NqCIyDXNdcGm+rTV8
 yIVyEvPleqQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="399760858"
Received: from epcorona-mobl.amr.corp.intel.com (HELO epcorona-moblu.amr.corp.intel.com) ([10.254.189.204])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 15:30:09 -0700
From:   Ernesto Corona <ernesto.corona@intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     Ernesto Corona <ernesto.corona@intel.com>,
        Oleksandr Shamray <oleksandrs@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Steven Filary <steven.a.filary@intel.com>,
        Amithash Prasad <amithash@fb.com>,
        Patrick Williams <patrickw3@fb.com>, Rgrs <rgrs@protonmail.com>
Subject: [PATCH v29 6/6] drivers: jtag: Add JTAG core driver Maintainers
Date:   Mon, 13 Apr 2020 15:29:20 -0700
Message-Id: <20200413222920.4722-7-ernesto.corona@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413222920.4722-1-ernesto.corona@intel.com>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JTAG class driver provide infrastructure to support hardware/software
JTAG platform drivers. It provide user layer API interface for flashing
and debugging external devices which equipped with JTAG interface
using standard transactions.

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Pirko <jiri@mellanox.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Steven Filary <steven.a.filary@intel.com>
Cc: Amithash Prasad <amithash@fb.com>
Cc: Patrick Williams <patrickw3@fb.com>
Cc: Rgrs <rgrs@protonmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..96d20fbb719c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9144,6 +9144,17 @@ L:	linux-serial@vger.kernel.org
 S:	Orphan
 F:	drivers/tty/serial/jsm/
 
+JTAG SUBSYSTEM
+M:	Oleksandr Shamray <oleksandrs@mellanox.com>
+M:	Vadim Pasternak <vadimp@mellanox.com>
+M	Ernesto Corona <ernesto.corona@intel.com>
+S:	Maintained
+F:	include/linux/jtag.h
+F:	include/uapi/linux/jtag.h
+F:	drivers/jtag/
+F:	Documentation/devicetree/bindings/jtag/
+F:	Documentation/ABI/testing/jtag-dev
+
 K10TEMP HARDWARE MONITORING DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	linux-hwmon@vger.kernel.org
-- 
2.17.1

