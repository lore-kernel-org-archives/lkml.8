Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEF3C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CEE207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgGWO7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:59:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:50088 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgGWO7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:59:52 -0400
IronPort-SDR: IXIspDQ78GYtyRyMo/Jn8KcjqaH+mp0DN5qKPhDe5TvqJU9/4mBirkbxb3ukJ6wJ2+sewBy5J0
 P1gb+37+t6aA==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="151839043"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="151839043"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 07:59:51 -0700
IronPort-SDR: 6TdPDkvZmhKHlZHbelu6djCJ8ps388ukEN8g9aaH+2/8Y0n39CKtxiNubDkabMiiykUhU/RSRQ
 dFnMXZylaGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="311051231"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 07:59:49 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [char-misc-next 6/6] mei: hw: don't use one element arrays
Date:   Thu, 23 Jul 2020 17:59:27 +0300
Message-Id: <20200723145927.882743-7-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200723145927.882743-1-tomas.winkler@intel.com>
References: <20200723145927.882743-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the single element arrays with a simple value type u8 reserved,
even thought is is not used for dynamically sized trailing elements
it confuses the effort of replacing one-element arrays with
flexible arrays for that purpose.

Link: https://github.com/KSPP/linux/issues/79
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index b1a8d5ec88b3..26fa92cb7f7a 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (c) 2003-2018, Intel Corporation. All rights reserved
+ * Copyright (c) 2003-2020, Intel Corporation. All rights reserved
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -319,7 +319,7 @@ struct hbm_props_response {
 	u8 hbm_cmd;
 	u8 me_addr;
 	u8 status;
-	u8 reserved[1];
+	u8 reserved;
 	struct mei_client_properties client_properties;
 } __packed;
 
@@ -352,7 +352,7 @@ struct hbm_add_client_response {
 	u8 hbm_cmd;
 	u8 me_addr;
 	u8 status;
-	u8 reserved[1];
+	u8 reserved;
 } __packed;
 
 /**
@@ -461,7 +461,7 @@ struct hbm_notification {
 	u8 hbm_cmd;
 	u8 me_addr;
 	u8 host_addr;
-	u8 reserved[1];
+	u8 reserved;
 } __packed;
 
 /**
-- 
2.25.4

