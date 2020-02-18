Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A41C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886002173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBRNnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:43:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:14984 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgBRNnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:43:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 05:43:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="235536831"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2020 05:43:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E52F5109; Tue, 18 Feb 2020 15:43:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1] mfd: dln2: Fix sanity checking for endpoints
Date:   Tue, 18 Feb 2020 15:43:48 +0200
Message-Id: <20200218134348.10523-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the commit 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
tries to harden the sanity checks it made at the same time a regression,
i.e.  mixed in and out endpoints. Obviously it should have been not tested on
real hardware at that time, but unluckily it didn't happen.

So, fix above mentioned typo and make device being enumerated again.

Fixes: 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/dln2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 984d6b438aca..3a729b196b1f 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -754,8 +754,8 @@ static int dln2_probe(struct usb_interface *interface,
 	    hostif->desc.bNumEndpoints < 2)
 		return -ENODEV;
 
-	epin = &hostif->endpoint[0].desc;
-	epout = &hostif->endpoint[1].desc;
+	epin = &hostif->endpoint[1].desc;
+	epout = &hostif->endpoint[0].desc;
 	if (!usb_endpoint_is_bulk_out(epout))
 		return -ENODEV;
 	if (!usb_endpoint_is_bulk_in(epin))
-- 
2.25.0

