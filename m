Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E851EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85862068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFCGL5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:11:57 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:24220 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbgFCGL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:11:56 -0400
Received: from [100.113.4.218] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id 52/3E-52160-92F37DE5; Wed, 03 Jun 2020 06:11:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRWlGSWpSXmKPExsUS8J9toq6G/fU
  4g5knjSyaF69ns7i8aw6bA5PH/rlr2D0+b5ILYIpizcxLyq9IYM34f/gAY8FGgYqTj46zNzDu
  4Oti5OIQEmhglFjyeCJzFyMnh4SAn8TFrVMYIRKrGSXurl3OBOHsY5Q4+6uHCaSKTUBX4vviz
  6wgtoiAgsTVn7/ZQGxmAW+Jp7+2AtkcHMICThLNd5RBwiwCKhLL7r5lB7F5Bewldu6cwA6xTF
  7i1/PPYIuFBDQkDnduhYuvPbqFBWSMhECcxJc7phCtghInZz6BCltLTNycCFGtJjF/cRcjhM0
  p8f7DByaQEmYBTYn1u/Qh7tKWWLbwNfMERpFZSAbNQqiahaRqASPzKkbLpKLM9IyS3MTMHF1D
  AwNdQ0NjXXNdI2NDvcQq3SS91FLd5NS8kqJEoKxeYnmxXnFlbnJOil5easkmRmC0pBSyP9/Bu
  OrNB71DjJIcTEqivO57r8UJ8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuAVsb0eJyRYlJqeWpGWmQ
  OMXJi0BAePkgjvcxugNG9xQWJucWY6ROoUo6KUOK8dSJ8ASCKjNA+uDZYsLjHKSgnzMjIwMAj
  xFKQW5WaWoMq/YhTnYFQS5pW0A5rCk5lXAjf9FdBiJqDF9n3XQBaXJCKkpBqYmlPz15rlVh/o
  CNnRvv7z/KB1i+RYdgQ/S22PmVb+cfnM/ou3Dyr/ff/V+Fg2U28ut/rVwJqwaW6itm6zFUrfv
  pQKKrZQVHxT/Cr3Q0TMbZZjUtVndmzUT5ribF2c8O34r0TDvHQhiahrF5W26F6+7+A1f826tP
  xZc6v72XbqrAtZWbyp0u/H4pXO32bumvWBLeXqjW81NSxhv+dalLp90X3AIxp2ddWyjJS5RnN
  S7e8aa1Stjtkt8O9nuUHKkvW2khYlP/yOPtNo9eK6mP1gXVlNdOlr/xWi+xTiZm631TVweaS9
  8e0buS6vDxd2HMlQvrvxWkHm2axzQi8WxH64kdo7ScCu+fmvC6ssJr8XUGIpzkg01GIuKk4EA
  E3gJpGRAwAA
X-Env-Sender: Andreas.Geissler@duagon.com
X-Msg-Ref: server-18.tower-239.messagelabs.com!1591164711!4249372!1
X-Originating-IP: [80.255.6.145]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1230 invoked from network); 3 Jun 2020 06:11:52 -0000
Received: from unknown (HELO keys.men.de) (80.255.6.145)
  by server-18.tower-239.messagelabs.com with AES128-SHA encrypted SMTP; 3 Jun 2020 06:11:52 -0000
Received: from MEN-EX01.intra.men.de ([192.168.1.1])
  by keys.men.de (PGP Universal service);
  Wed, 03 Jun 2020 08:11:52 +0200
X-PGP-Universal: processed;
        by keys.men.de on Wed, 03 Jun 2020 08:11:52 +0200
Received: from MEN-EX01.intra.men.de (192.168.1.1) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Jun
 2020 08:11:51 +0200
Received: from build1.dev.men.de (10.64.0.100) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Jun 2020 08:11:51 +0200
From:   AGeissler <Andreas.Geissler@duagon.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        AGeissler <Andreas.Geissler@duagon.com>
Subject: [PATCH] MAINTAINERS: Update maintainer entries for MEN HW
Date:   Wed, 3 Jun 2020 08:11:42 +0200
Message-ID: <20200603061142.4000-1-Andreas.Geissler@duagon.com>
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

﻿Remove Andreas Werner as Maintainer of the F21 BMC driver, as he is no
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

