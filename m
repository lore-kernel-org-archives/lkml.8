Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F191FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D89920675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbgDBSmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:42:49 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388540AbgDBSmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:42:49 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MgARS-1ipxaC2yRq-00hbbd for <linux-kernel@vger.kernel.org>; Thu, 02 Apr
 2020 20:42:46 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 74C67650A8B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 18:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9ErPIgxDbAKN for <linux-kernel@vger.kernel.org>;
        Thu,  2 Apr 2020 20:42:46 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 130A864BA2B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 20:42:46 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.8.5.12) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 20:42:45 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 768EB804FE; Thu,  2 Apr 2020 20:34:03 +0200 (CEST)
Date:   Thu, 2 Apr 2020 20:34:03 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <devel@driverdev.osuosl.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
Subject: [PATCH v5 2/9] media: adv748x: include everything adv748x.h needs
 into the file
Message-ID: <046f909122e03286faf0a8916f30d56259656e14.1585852001.git.alexander.riesen@cetitec.com>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cover.1585852001.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1585852001.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.12]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6C7266
X-Provags-ID: V03:K1:ZvlDTIEfh9I5HjtsOVOqqh+TXNs4jkK3Hw0EStGTUNMOD2VJ0U+
 WX4Ad4tmRLtTzAqyWIz25UqY2Vg5Xtfx5m4kp9XPFnM13NVDMmEjAPSsFGvxeM8/X292PB7
 ZLP6xlztXmDMLHKUwyQibisG/l7f6CGOPnB/V6ejhN0pAqd/lrLuUR+VV8qXqqlYbM1dGbw
 /fsGPhSyJDwABc3pDV0lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:snojTtjHGmg=:xC47a6qD5nfYo/OwnISWuS
 on/b4ULLC7O3X/AMGMq+Hh5/deF7TdBP4B6a+CHkOWk9CgmTAlD5rMwplL/PX2fzkoSo4Y4pG
 gmZcjxB2IzO9lpdvyeZlox4LqOAmnJPRiP7GJRzRXK2WCk45PT4i1KZpa8su53LEV4aFHwKTo
 Dw4yVNOUG7KPFBrWjcPLchlN+dKMXn5Ees/sVsd+N7J5b9kvGzEG+xO2Ob9CY4UHqnsWCLOfK
 8r6k54QtGEtrlQZDNZYDEYiYOz+KvetyGuU0txpTmKqBCNgYVnHk6cOIoj0kflqzUbbE2wzto
 Xd43LA+srz3+bV6chdn8JxQEn9Lq1MjrUZetQrAOaoColS5/xkET9BoKzhfndZdnNyctKCzMp
 yEqMjykzniOGWIOQwHiX6rPXGNxYfbqVVZXDxFJ/UqQKr/3JlZnumGI56LuSVTZNOPs+evAxI
 kqOK3mzRvzCb6EGl3bZPSHRBQZL3MF4UYYoMZQsVqmBE/ckiY+9moTKOtwcJnzpdxuXUeI6a/
 gV8S9JeUD/PCTmIWdM7eYEWp3apwvsXRhGO3HW5vCBHtES/WBmt8kxTx9OkNHKUvxGQ54BOFT
 ktdgFyovsehI2zyUOCEgjjJ74dRFDDH5wg5ilbsa9OvYFdVV51mEJZ5aTWXVBn+O+xIQJx7Xe
 g1ugxyNQwc6NYZO3CWyhl0uGIOw2zz6BMs2zjkPLiJvlTQ46yVnNak0GiD6a8uTuLrB5SmfNE
 Ujsgux7kqCcVCP0bfzLatdcDVjEz/0+OQlwsOxcezi3FgAdVCECKLLFJC8MjWiJDj/q2RULAr
 SUZrNGoUKrmRCtCNpbSFKfFaLDhcAeu6MH+B2VFWCmPpaSrSNx6+7vfxtr+8hBaM5K+Qdo5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To follow the established practice of not depending on others to
pull everything in. While at it, make sure it stays like this.

Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/adv748x/adv748x-afe.c  | 6 ++----
 drivers/media/i2c/adv748x/adv748x-core.c | 6 ++----
 drivers/media/i2c/adv748x/adv748x-csi2.c | 6 ++----
 drivers/media/i2c/adv748x/adv748x-hdmi.c | 6 ++----
 drivers/media/i2c/adv748x/adv748x.h      | 2 ++
 5 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-afe.c b/drivers/media/i2c/adv748x/adv748x-afe.c
index dbbb1e4d6363..5a25d1fbe25f 100644
--- a/drivers/media/i2c/adv748x/adv748x-afe.c
+++ b/drivers/media/i2c/adv748x/adv748x-afe.c
@@ -6,18 +6,16 @@
  * Copyright (C) 2017 Renesas Electronics Corp.
  */
 
+#include "adv748x.h"
+
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/v4l2-dv-timings.h>
 
-#include <media/v4l2-ctrls.h>
-#include <media/v4l2-device.h>
 #include <media/v4l2-dv-timings.h>
 #include <media/v4l2-ioctl.h>
 
-#include "adv748x.h"
-
 /* -----------------------------------------------------------------------------
  * SDP
  */
diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
index c3fb113cef62..5c59aad319d1 100644
--- a/drivers/media/i2c/adv748x/adv748x-core.c
+++ b/drivers/media/i2c/adv748x/adv748x-core.c
@@ -10,6 +10,8 @@
  *	Kieran Bingham <kieran.bingham@ideasonboard.com>
  */
 
+#include "adv748x.h"
+
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
@@ -20,14 +22,10 @@
 #include <linux/slab.h>
 #include <linux/v4l2-dv-timings.h>
 
-#include <media/v4l2-ctrls.h>
-#include <media/v4l2-device.h>
 #include <media/v4l2-dv-timings.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-ioctl.h>
 
-#include "adv748x.h"
-
 /* -----------------------------------------------------------------------------
  * Register manipulation
  */
diff --git a/drivers/media/i2c/adv748x/adv748x-csi2.c b/drivers/media/i2c/adv748x/adv748x-csi2.c
index c43ce5d78723..c00d4f347d95 100644
--- a/drivers/media/i2c/adv748x/adv748x-csi2.c
+++ b/drivers/media/i2c/adv748x/adv748x-csi2.c
@@ -5,15 +5,13 @@
  * Copyright (C) 2017 Renesas Electronics Corp.
  */
 
+#include "adv748x.h"
+
 #include <linux/module.h>
 #include <linux/mutex.h>
 
-#include <media/v4l2-ctrls.h>
-#include <media/v4l2-device.h>
 #include <media/v4l2-ioctl.h>
 
-#include "adv748x.h"
-
 static int adv748x_csi2_set_virtual_channel(struct adv748x_csi2 *tx,
 					    unsigned int vc)
 {
diff --git a/drivers/media/i2c/adv748x/adv748x-hdmi.c b/drivers/media/i2c/adv748x/adv748x-hdmi.c
index c557f8fdf11a..f598acec3b5c 100644
--- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
+++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
@@ -5,18 +5,16 @@
  * Copyright (C) 2017 Renesas Electronics Corp.
  */
 
+#include "adv748x.h"
+
 #include <linux/module.h>
 #include <linux/mutex.h>
 
-#include <media/v4l2-ctrls.h>
-#include <media/v4l2-device.h>
 #include <media/v4l2-dv-timings.h>
 #include <media/v4l2-ioctl.h>
 
 #include <uapi/linux/v4l2-dv-timings.h>
 
-#include "adv748x.h"
-
 /* -----------------------------------------------------------------------------
  * HDMI and CP
  */
diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
index fccb388ce179..09aab4138c3f 100644
--- a/drivers/media/i2c/adv748x/adv748x.h
+++ b/drivers/media/i2c/adv748x/adv748x.h
@@ -19,6 +19,8 @@
  */
 
 #include <linux/i2c.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
 
 #ifndef _ADV748X_H_
 #define _ADV748X_H_
-- 
2.25.1.25.g9ecbe7eb18


