Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAE0C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DB0206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410639AbgDORBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:01:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:27185 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404661AbgDORBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:01:35 -0400
IronPort-SDR: UKjsSZI5q4UFv4Qy+y7CP6qRsxl1PGM109O3mSJCvw7eivdZtA3vLJ6Fr6rD/d7AUAn1mCAZVw
 eEnkiSXVNGXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 10:01:16 -0700
IronPort-SDR: bWaPx+c2YDs/BI2HkoZrq0M+rAvcoOjq6faoZYJBhVVSWkkJKErxVoVCe+PQRX3pE57DwJJYQh
 kOAzMJaWVwLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="427499246"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2020 10:01:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 28EBC49F; Wed, 15 Apr 2020 20:01:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v3 3/3] [media] usb: pulse8-cec: Switch to use %ptT
Date:   Wed, 15 Apr 2020 20:00:46 +0300
Message-Id: <20200415170046.33374-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptT instead of open coded variant to print content of
time64_t type in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/usb/pulse8-cec/pulse8-cec.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/usb/pulse8-cec/pulse8-cec.c b/drivers/media/usb/pulse8-cec/pulse8-cec.c
index 0655aa9ecf28..beae6aa12638 100644
--- a/drivers/media/usb/pulse8-cec/pulse8-cec.c
+++ b/drivers/media/usb/pulse8-cec/pulse8-cec.c
@@ -661,7 +661,6 @@ static int pulse8_setup(struct pulse8 *pulse8, struct serio *serio,
 	u8 *data = pulse8->data + 1;
 	u8 cmd[2];
 	int err;
-	struct tm tm;
 	time64_t date;
 
 	pulse8->vers = 0;
@@ -682,10 +681,7 @@ static int pulse8_setup(struct pulse8 *pulse8, struct serio *serio,
 	if (err)
 		return err;
 	date = (data[0] << 24) | (data[1] << 16) | (data[2] << 8) | data[3];
-	time64_to_tm(date, 0, &tm);
-	dev_info(pulse8->dev, "Firmware build date %04ld.%02d.%02d %02d:%02d:%02d\n",
-		 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-		 tm.tm_hour, tm.tm_min, tm.tm_sec);
+	dev_info(pulse8->dev, "Firmware build date %ptT\n", &date);
 
 	dev_dbg(pulse8->dev, "Persistent config:\n");
 	cmd[0] = MSGCODE_GET_AUTO_ENABLED;
-- 
2.25.1

