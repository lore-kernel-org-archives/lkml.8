Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F104C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0A120679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgFCHLD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:11:03 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:58490 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbgFCHLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:11:02 -0400
Received: from [100.113.2.218] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id C2/3B-37389-30D47DE5; Wed, 03 Jun 2020 07:10:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRWlGSWpSXmKPExsUS8J9toi6T7/U
  4g6erjS3+NP1ms2hevJ7N4uGXWywWl3fNYXNg8fjwMc5j06pONo/9c9ewe3zeJBfAEsWamZeU
  X5HAmjH/znKWggsCFTdPPGdtYLzE18XIxSEk0MAosW39QbYuRk4OCQE/iX9nb7BDJFYzSuydd
  JcZwtnHKPFzz3RWkCo2AV2J74s/g9kiAgoSV3/+ButmFkiX6Lm3HKibg0NYwFPi5hIhkDCLgI
  rE5hlHWUHCvAL2Et+fpELskpf49fwzM4gtJKAhcbhzKztMfO3RLSwg5RICcRJf7piChHkFBCV
  OznwCFbaWmLg5EaJaTWL+4i5GCJtT4v2HD0wgJcwCmhLrd+lDnKUtsWzha+YJjCKzkAyahVA1
  C0nVAkbmVYyWSUWZ6RkluYmZObqGBga6hobGusa6RqaGeolVuol6qaW6yal5JUWJQFm9xPJiv
  eLK3OScFL281JJNjMCISilk/r2D8fHrD3qHGCU5mJREeRPdr8cJ8SXlp1RmJBZnxBeV5qQWH2
  KU4eBQkuAV9wHKCRalpqdWpGXmAKMbJi3BwaMkwlvjDZTmLS5IzC3OTIdInWJUlBLnXQaSEAB
  JZJTmwbXBEsolRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8c0Cm8GTmlcBNfwW0mAlosX3f
  NZDFJYkIKakGJs4A1ZkmfbyvjqYdrphWfegm99cvFTtLzbfvXXZ0XtTpl8KlryRMU8/cCgk+4
  /luth9/fO3J+s2lYT4F+lcfMmWszt9wNea9rfFfzfIc3jefZvNvWvD6U6mXmdqnyw93/by9a/
  uadz0rHrO9m7pKycv9Xn+3aMWZUKm6sLce06+pn+PnZ9qxb0fT/eCTbNXRiVs+FuvfenKiUKp
  /lrVEW/w84bm/qw5uVfym7BjYWf4i4vv6K0452Yd3n9G/EriwMXfTMcFddfUhszoKp3Ka5olm
  e/09LGn+qPbkx2LdtgDG8mO1Yho/Le+fCN2Tfr7f0NBZK3a/yPFUzpUerM78TJ1lyncezsr2n
  MPXZJj5QImlOCPRUIu5qDgRADVUtpyjAwAA
X-Env-Sender: Andreas.Geissler@duagon.com
X-Msg-Ref: server-10.tower-229.messagelabs.com!1591168258!1070118!1
X-Originating-IP: [80.255.6.145]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8765 invoked from network); 3 Jun 2020 07:10:58 -0000
Received: from unknown (HELO keys.men.de) (80.255.6.145)
  by server-10.tower-229.messagelabs.com with AES128-SHA encrypted SMTP; 3 Jun 2020 07:10:58 -0000
Received: from MEN-EX01.intra.men.de ([192.168.1.1])
  by keys.men.de (PGP Universal service);
  Wed, 03 Jun 2020 09:10:58 +0200
X-PGP-Universal: processed;
        by keys.men.de on Wed, 03 Jun 2020 09:10:58 +0200
Received: from MEN-EX01.intra.men.de (192.168.1.1) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Jun
 2020 09:10:57 +0200
Received: from build1.dev.men.de (10.64.0.100) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Jun 2020 09:10:57 +0200
From:   AGeissler <Andreas.Geissler@duagon.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <jth@kernel.org>,
        <crustyaw@gmx.de>, <Andreas.Geissler@duagon.com>
Subject: [PATCH RESEND] MAINTAINERS: Update maintainer entries for MEN HW
Date:   Wed, 3 Jun 2020 09:10:49 +0200
Message-ID: <20200603071049.7309-1-Andreas.Geissler@duagon.com>
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [10.64.0.100]
X-ClientProxiedBy: MEN-EX01.intra.men.de (192.168.1.1) To
 MEN-EX01.intra.men.de (192.168.1.1)
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e4841e51-7998-49c0-ba41-8b8a0e2d8962
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Loop: 2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿[resend; because of missing cc]

Remove Andreas Werner as Maintainer of the F21 BMC driver, as he is no
longer with the company and add Andreas Geissler as additional
Maintainer for all MEN Hardware.

Acked-by: Johannes Thumshirn <jth@kernel.org>
Acked-by: Andreas Werner <crustyaw@gmx.de>
Signed-off-by: AGeissler <Andreas.Geissler@duagon.com>
---
 MAINTAINERS | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68cd1b966b45..b3b45d2e9c8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11044,19 +11044,21 @@ F:	include/uapi/mtd/
 
 MEN A21 WATCHDOG DRIVER
 M:	Johannes Thumshirn <morbidrsa@gmail.com>
+M:	Andreas Geissler <andreas.geissler@duagon.com>
 L:	linux-watchdog@vger.kernel.org
 S:	Maintained
 F:	drivers/watchdog/mena21_wdt.c
 
 MEN CHAMELEON BUS (mcb)
 M:	Johannes Thumshirn <morbidrsa@gmail.com>
+M:	Andreas Geissler <andreas.geissler@duagon.com>
 S:	Maintained
 F:	Documentation/driver-api/men-chameleon-bus.rst
 F:	drivers/mcb/
 F:	include/linux/mcb.h
 
 MEN F21BMC (Board Management Controller)
-M:	Andreas Werner <andreas.werner@men.de>
+M:	Andreas Geissler <andreas.geissler@duagon.com>
 S:	Supported
 F:	Documentation/hwmon/menf21bmc.rst
 F:	drivers/hwmon/menf21bmc_hwmon.c
@@ -11066,10 +11068,18 @@ F:	drivers/watchdog/menf21bmc_wdt.c
 
 MEN Z069 WATCHDOG DRIVER
 M:	Johannes Thumshirn <jth@kernel.org>
+M:	Andreas Geissler <andreas.geissler@duagon.com>
 L:	linux-watchdog@vger.kernel.org
 S:	Maintained
 F:	drivers/watchdog/menz69_wdt.c
 
+MEN Z135 UART DRIVER
+M:	Johannes Thumshirn <jth@kernel.org>
+M:	Andreas Geissler <andreas.geissler@duagon.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	drivers/tty/serial/men_z135_uart.c
+
 MESON AO CEC DRIVER FOR AMLOGIC SOCS
 M:	Neil Armstrong <narmstrong@baylibre.com>
 L:	linux-media@vger.kernel.org

base-commit: d6f9469a03d832dcd17041ed67774ffb5f3e73b3
-- 
2.16.4


MEN Mikro Elektronik GmbH
Neuwieder Straße 1-7 90411 Nürnberg
Geschäftsführer: Dr. Michael Goldbach - Matthias Kamolz - Yilmaz Kocak - Handelsregister AG Nürnberg HRB 5540

