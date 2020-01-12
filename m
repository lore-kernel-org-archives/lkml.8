Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C774BC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 12:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89BB21744
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 12:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgALMTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 07:19:02 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60765 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732780AbgALMS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 07:18:58 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 12 Jan 2020 14:18:53 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 00CCIpSQ023227;
        Sun, 12 Jan 2020 14:18:53 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v2 02/10] Documentation/ABI: Fix documentation inconsistency for mlxreg-io sysfs interfaces
Date:   Sun, 12 Jan 2020 12:18:41 +0000
Message-Id: <20200112121849.7056-3-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200112121849.7056-1-vadimp@mellanox.com>
References: <20200112121849.7056-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix attribute name from "jtag_enable", which described twice to
"cpld3_version", which is expected to be instead of second appearance
of "jtag_enable".

Fixes: 2752e34442b5 ("Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
v1-v2:
 Comments pointed out by Andy:
 - Explain that patch fixes documentation inconsistency.
---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index 8ca498447aeb..8b1461fa3538 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -29,13 +29,13 @@ Description:	This file shows the system fans direction:
 
 		The files are read only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld3_version
 
 Date:		November 2018
 KernelVersion:	5.0
 Contact:	Vadim Pasternak <vadimpmellanox.com>
 Description:	These files show with which CPLD versions have been burned
-		on LED board.
+		on LED or Gearbox board.
 
 		The files are read only.
 
-- 
2.11.0

