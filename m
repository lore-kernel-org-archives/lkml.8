Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA67C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD2120643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgERTgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:36:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:7912 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgERTgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:36:20 -0400
IronPort-SDR: xW7Iqin2VRvV5ZrmZjtlEpqoAfXEpElEzFNs4irft/zbeOIkv28uMYh/kAABdfYILmWK5DnhYM
 Y/B4+F0Ejzrg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 12:36:20 -0700
IronPort-SDR: pmrUrMYIDmXNQdU/m+smABOd86JuqpZGWL88Z07ntz+em1sOnvZQl8WmALSb44GP6N3MNnc7oA
 c8YqC690SG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="267631604"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2020 12:36:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4B86C94; Mon, 18 May 2020 22:36:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] auxdisplay: charlcd: Reuse hex_to_bin() instead of custom code
Date:   Mon, 18 May 2020 22:36:17 +0300
Message-Id: <20200518193617.74548-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hex_to_bin() may be used to convert hexdecimal digit to its binary
representation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/charlcd.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index d58278ae9e4a..5aee0f546351 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -485,24 +485,19 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		shift = 0;
 		value = 0;
 		while (*esc && cgoffset < 8) {
+			int half;
+
 			shift ^= 4;
-			if (*esc >= '0' && *esc <= '9') {
-				value |= (*esc - '0') << shift;
-			} else if (*esc >= 'A' && *esc <= 'F') {
-				value |= (*esc - 'A' + 10) << shift;
-			} else if (*esc >= 'a' && *esc <= 'f') {
-				value |= (*esc - 'a' + 10) << shift;
-			} else {
-				esc++;
+
+			half = hex_to_bin(*esc++);
+			if (half < 0)
 				continue;
-			}
 
+			value |= half << shift;
 			if (shift == 0) {
 				cgbytes[cgoffset++] = value;
 				value = 0;
 			}
-
-			esc++;
 		}
 
 		lcd->ops->write_cmd(lcd, LCD_CMD_SET_CGRAM_ADDR | (cgaddr * 8));
-- 
2.26.2

