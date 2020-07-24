Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD972C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F77206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGXPpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:45:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:37741 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:45:06 -0400
IronPort-SDR: Ugqrheqd+ejiDU6EloqqdecKFKSnukHVSWAa8CFFcsWvfl1ylBNlBAo2pABWyGYgkoy2axLjnV
 nfXGTNXb49nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="215316081"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="215316081"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 08:45:04 -0700
IronPort-SDR: L3fzr5rXNBH5uCZuMXRnrjWAgXHrBflv2Nuyv4zzKx9e1eWlnevt8v3rydOan0bYQiftEN6XOC
 0BfvY8cFSvQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="363401260"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga001.jf.intel.com with ESMTP; 24 Jul 2020 08:45:03 -0700
From:   richard.gong@linux.intel.com
To:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        gregkh@linuxfoundation.org, thor.thayer@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [RESEND PATCHv1] MAINTAINERS: altera: change maintainer for Altera drivers
Date:   Fri, 24 Jul 2020 10:59:15 -0500
Message-Id: <1595606355-1329-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Thor is moving to a new position and I will take over the maintainership.
Add myself as maintainer for 3 Altera drivers below:
1. Altera I2C driver
2. Altera System Manager driver
3. Altera System Resource driver

Signed-off-by: Richard Gong <richard.gong@intel.com>
Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4a43a9..d87a307 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -750,7 +750,7 @@ R:	Pali Rohár <pali@kernel.org>
 F:	drivers/input/mouse/alps.*
 
 ALTERA I2C CONTROLLER DRIVER
-M:	Thor Thayer <thor.thayer@linux.intel.com>
+M:	Richard Gong <richard.gong@linux.intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-altera.txt
 F:	drivers/i2c/busses/i2c-altera.c
@@ -767,13 +767,13 @@ S:	Maintained
 F:	drivers/gpio/gpio-altera.c
 
 ALTERA SYSTEM MANAGER DRIVER
-M:	Thor Thayer <thor.thayer@linux.intel.com>
+M:	Richard Gong <richard.gong@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/altera-sysmgr.c
 F:	include/linux/mfd/altera-sysmgr.h
 
 ALTERA SYSTEM RESOURCE DRIVER FOR ARRIA10 DEVKIT
-M:	Thor Thayer <thor.thayer@linux.intel.com>
+M:	Richard Gong <richard.gong@linux.intel.com>
 S:	Maintained
 F:	drivers/gpio/gpio-altera-a10sr.c
 F:	drivers/mfd/altera-a10sr.c
-- 
2.7.4

