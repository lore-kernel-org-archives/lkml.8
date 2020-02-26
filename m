Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B063C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591E20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgBZOwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:52:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:62228 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgBZOwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:52:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 06:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="438448828"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 26 Feb 2020 06:51:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ADF65252; Wed, 26 Feb 2020 16:51:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] mfd: dln2: Fix sanity checking for endpoints
Date:   Wed, 26 Feb 2020 16:51:58 +0200
Message-Id: <20200226145158.13396-1-andriy.shevchenko@linux.intel.com>
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

While here, introduce an enumerator for magic values to prevent similar issue
to happen in the future.

Fixes: 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: Add enumerator (Lee)
 drivers/mfd/dln2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 7841c11411d0..4faa8d2e5d04 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -90,6 +90,11 @@ struct dln2_mod_rx_slots {
 	spinlock_t lock;
 };
 
+enum dln2_endpoint {
+	DLN2_EP_OUT	= 0,
+	DLN2_EP_IN	= 1,
+};
+
 struct dln2_dev {
 	struct usb_device *usb_dev;
 	struct usb_interface *interface;
@@ -733,10 +738,10 @@ static int dln2_probe(struct usb_interface *interface,
 	    hostif->desc.bNumEndpoints < 2)
 		return -ENODEV;
 
-	epin = &hostif->endpoint[0].desc;
-	epout = &hostif->endpoint[1].desc;
+	epout = &hostif->endpoint[DLN2_EP_OUT].desc;
 	if (!usb_endpoint_is_bulk_out(epout))
 		return -ENODEV;
+	epin = &hostif->endpoint[DLN2_EP_IN].desc;
 	if (!usb_endpoint_is_bulk_in(epin))
 		return -ENODEV;
 
-- 
2.25.0

