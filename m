Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF9FC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821AC20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBXMOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:14:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:3613 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbgBXMOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:14:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 04:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="349909448"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2020 04:14:20 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 6/9] usb: roles: Allow the role switches to be named
Date:   Mon, 24 Feb 2020 15:14:03 +0300
Message-Id: <20200224121406.2419-7-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224121406.2419-1-heikki.krogerus@linux.intel.com>
References: <20200224121406.2419-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The switch devices have been named by using the name of the
parent device as base for now, but if for example the
parent device controls multiple muxes, that will not work.

Adding an optional member "name" to the switch descriptor
that can be used for naming the switch during registration.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/roles/class.c | 3 ++-
 include/linux/usb/role.h  | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 11e49213176f..c05a0caa5ee9 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -330,7 +330,8 @@ usb_role_switch_register(struct device *parent,
 	sw->dev.class = role_class;
 	sw->dev.type = &usb_role_dev_type;
 	dev_set_drvdata(&sw->dev, desc->driver_data);
-	dev_set_name(&sw->dev, "%s-role-switch", dev_name(parent));
+	dev_set_name(&sw->dev, "%s-role-switch",
+		     desc->name ? desc->name : dev_name(parent));
 
 	ret = device_register(&sw->dev);
 	if (ret) {
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index c028ba8029ad..0164fed31b06 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -27,6 +27,7 @@ typedef enum usb_role (*usb_role_switch_get_t)(struct usb_role_switch *sw);
  * @get: Callback for getting the role (optional)
  * @allow_userspace_control: If true userspace may change the role through sysfs
  * @driver_data: Private data pointer
+ * @name: Name for the switch (optional)
  *
  * @usb2_port and @usb3_port will point to the USB host port and @udc to the USB
  * device controller behind the USB connector with the role switch. If
@@ -43,6 +44,7 @@ struct usb_role_switch_desc {
 	usb_role_switch_get_t get;
 	bool allow_userspace_control;
 	void *driver_data;
+	const char *name;
 };
 
 
-- 
2.25.0

