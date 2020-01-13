Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0974C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF4C21569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgAMQ3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:29:23 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37944 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728912AbgAMQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:28:48 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 Jan 2020 18:28:43 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 00DGSefY032667;
        Mon, 13 Jan 2020 18:28:43 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v3 03/11] Documentation/ABI: Add missed attribute for mlxreg-io sysfs interfaces
Date:   Mon, 13 Jan 2020 16:28:31 +0000
Message-Id: <20200113162839.18103-4-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200113162839.18103-1-vadimp@mellanox.com>
References: <20200113162839.18103-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed "cpld4_version" attribute.

Fixes: 52675da1d087 ("Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
v2->v3:
 Comments pointed out by Andy:
 - add "Fixes" tag.
 - Drop blank line between "What" and "Date".
---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index 8b1461fa3538..05601a90a9b6 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -121,6 +121,15 @@ Description:	These files show the system reset cause, as following: ComEx
 
 		The files are read only.
 
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld4_version
+Date:		November 2018
+KernelVersion:	5.0
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	These files show with which CPLD versions have been burned
+		on LED board.
+
+		The files are read only.
+
 Date:		June 2019
 KernelVersion:	5.3
 Contact:	Vadim Pasternak <vadimpmellanox.com>
-- 
2.11.0

