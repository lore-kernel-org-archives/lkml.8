Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0BEC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A68820838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBJPXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:23:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:30445 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgBJPXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:23:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 07:23:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="280660475"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2020 07:23:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7062B159; Mon, 10 Feb 2020 17:23:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] MAINTAINERS: Sort entries in database for THUNDERBOLT
Date:   Mon, 10 Feb 2020 17:23:02 +0200
Message-Id: <20200210152302.23098-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run parse-maintainers.pl and choose THUNDERBOLT record. Fix it accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cdfba86c7f4..ed56c6faed61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16573,8 +16573,8 @@ M:	Michael Jamet <michael.jamet@intel.com>
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 M:	Yehezkel Bernat <YehezkelShB@gmail.com>
 L:	linux-usb@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
 F:	Documentation/admin-guide/thunderbolt.rst
 F:	drivers/thunderbolt/
 F:	include/linux/thunderbolt.h
-- 
2.25.0

