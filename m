Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EB4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FC1206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PrR32Ha/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgF2CzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgF2CzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:55:08 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B2C03E979;
        Sun, 28 Jun 2020 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=pNAHqrMilcbQWkaDAeEtclkYgijfh3lLVD866ZFpqCE=; b=PrR32Ha/ShmmR9dae2Mk7M7oEZ
        F928ffroGQqSckjotBhAMBxd0SrxJNX4wMMgURqRcdBzsamAraCjSkbumxH5i8BYMVf1kbIy+qTOo
        oPzjuxuXjL5gudXSWNNzf3mGM32/llhnymKLGYVCF3TdVRfWlrmAf0bEHIEXWD4+KddpAq+wnupki
        TxIVhMrtGvqOauK3H3jxx6ajdc88xE1HAnZp8YQo5frFPQCFpbmTYRFlJ8fiRm1xyPgWIE5FAPWPG
        00q1wAEia4UNHRv+zsFiCwWCRNSDuKORDGytsflr0N4xHEESE7ic2+eYJ/sahiOs1vqd3QjMYsmuQ
        DbiqDzYg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpjwW-0002dd-Ci; Mon, 29 Jun 2020 02:54:50 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] usb: fix kernel-doc warnings and formatting in <linux/usb.h>
Message-ID: <7014bab2-268c-69f6-7ef5-57fbd45c8b08@infradead.org>
Date:   Sun, 28 Jun 2020 19:54:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in <linux/usb.h>:

../include/linux/usb.h:713: warning: Function parameter or member 'use_generic_driver' not described in 'usb_device'
../include/linux/usb.h:1253: warning: Function parameter or member 'match' not described in 'usb_device_driver'
../include/linux/usb.h:1253: warning: Function parameter or member 'id_table' not described in 'usb_device_driver'

Also drop an extra blank line and fix indentation.

Fixes: 77419aa403ca ("USB: Fallback to generic driver when specific driver fails")
Fixes: 88b7381a939d ("USB: Select better matching USB drivers when available")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bastien Nocera <hadess@hadess.net>
---
 include/linux/usb.h |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- linux-next-20200626.orig/include/linux/usb.h
+++ linux-next-20200626/include/linux/usb.h
@@ -620,9 +620,9 @@ struct usb3_lpm_parameters {
  *	Management to be disabled for this usb_device.  This count should only
  *	be manipulated by those functions, with the bandwidth_mutex is held.
  * @hub_delay: cached value consisting of:
- *		parent->hub_delay + wHubDelay + tTPTransmissionDelay (40ns)
- *
+ *	parent->hub_delay + wHubDelay + tTPTransmissionDelay (40ns)
  *	Will be used as wValue for SetIsochDelay requests.
+ * @use_generic_driver: ask driver core to reprobe using the generic driver.
  *
  * Notes:
  * Usbcore drivers should not set usbdev->state directly.  Instead use
@@ -1215,6 +1215,7 @@ struct usb_driver {
  * struct usb_device_driver - identifies USB device driver to usbcore
  * @name: The driver name should be unique among USB drivers,
  *	and should normally be the same as the module name.
+ * @match: If set, used for better device/driver matching.
  * @probe: Called to see if the driver is willing to manage a particular
  *	device.  If it is, probe returns zero and uses dev_set_drvdata()
  *	to associate driver-specific data with the device.  If unwilling
@@ -1227,13 +1228,16 @@ struct usb_driver {
  * @dev_groups: Attributes attached to the device that will be created once it
  *	is bound to the driver.
  * @drvwrap: Driver-model core structure wrapper.
+ * @id_table: used with @match() to select better matching driver at
+ * 	probe() time.
  * @supports_autosuspend: if set to 0, the USB core will not allow autosuspend
  *	for devices bound to this driver.
  * @generic_subclass: if set to 1, the generic USB driver's probe, disconnect,
  *	resume and suspend functions will be called in addition to the driver's
  *	own, so this part of the setup does not need to be replicated.
  *
- * USB drivers must provide all the fields listed above except drvwrap.
+ * USB drivers must provide all the fields listed above except drvwrap,
+ * match, and id_table.
  */
 struct usb_device_driver {
 	const char *name;

