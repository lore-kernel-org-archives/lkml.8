Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A6FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957B120706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHRMKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:10:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:58731 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgHRMKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:10:03 -0400
IronPort-SDR: Vb4WhoP90+pfrCmcRghVJmCskn+8Avn47AVWc8Dp0c8ZY4MMywv3Epg5/jQqKyggwK0IdUEcnl
 BvGXRlQ5IQjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200369"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:10:02 -0700
IronPort-SDR: O4Eo3EMmM5AzctLeRrnSdoVxslG4oAQRo73pzuzYw6PKP0aySqKUieDKUPtTk74SZuQPvXFGT5
 h6euZM+8kwtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326712951"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:10:00 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 03/13] mei: add vtag support bit in client properties
Date:   Tue, 18 Aug 2020 14:51:37 +0300
Message-Id: <20200818115147.2567012-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200818115147.2567012-1-tomas.winkler@intel.com>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Vtag support is on a client basis, meaning not every client
supports it. The vtag capability is communicated via the client properties
structure during client enumeration process.
Export the propertiy via sysfs.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-mei |  7 +++++++
 drivers/misc/mei/bus.c                  | 11 +++++++++++
 drivers/misc/mei/client.h               | 12 ++++++++++++
 drivers/misc/mei/debugfs.c              |  7 ++++---
 drivers/misc/mei/hw.h                   | 15 ++++++++++++++-
 5 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-mei b/Documentation/ABI/testing/sysfs-bus-mei
index 3d37e2796d5a..6e9a105fe5cb 100644
--- a/Documentation/ABI/testing/sysfs-bus-mei
+++ b/Documentation/ABI/testing/sysfs-bus-mei
@@ -41,6 +41,13 @@ Contact:	Tomas Winkler <tomas.winkler@intel.com>
 Description:	Stores mei client fixed address, if any
 		Format: %d
 
+What:		/sys/bus/mei/devices/.../vtag
+Date:		Nov 2020
+KernelVersion:	5.9
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	Stores mei client vtag support status
+		Format: %d
+
 What:		/sys/bus/mei/devices/.../max_len
 Date:		Nov 2019
 KernelVersion:	5.5
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index a6dfc3ce1db2..2e7ac53a4152 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -810,6 +810,16 @@ static ssize_t fixed_show(struct device *dev, struct device_attribute *a,
 }
 static DEVICE_ATTR_RO(fixed);
 
+static ssize_t vtag_show(struct device *dev, struct device_attribute *a,
+			 char *buf)
+{
+	struct mei_cl_device *cldev = to_mei_cl_device(dev);
+	bool vt = mei_me_cl_vt(cldev->me_cl);
+
+	return sprintf(buf, "%d", vt);
+}
+static DEVICE_ATTR_RO(vtag);
+
 static ssize_t max_len_show(struct device *dev, struct device_attribute *a,
 			    char *buf)
 {
@@ -827,6 +837,7 @@ static struct attribute *mei_cldev_attrs[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_max_conn.attr,
 	&dev_attr_fixed.attr,
+	&dev_attr_vtag.attr,
 	&dev_attr_max_len.attr,
 	NULL,
 };
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index 2f8954def591..0d0f36373a4b 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -93,6 +93,18 @@ static inline u8 mei_me_cl_fixed(const struct mei_me_client *me_cl)
 	return me_cl->props.fixed_address;
 }
 
+/**
+ * mei_me_cl_vt - return me client vtag supported status
+ *
+ * @me_cl: me client
+ *
+ * Return: true if me client supports vt tagging
+ */
+static inline bool mei_me_cl_vt(const struct mei_me_client *me_cl)
+{
+	return me_cl->props.vt_supported == 1;
+}
+
 /**
  * mei_me_cl_max_len - return me client max msg length
  *
diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index b98f6f9a4896..3ab1a431d810 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -27,7 +27,7 @@ static int mei_dbgfs_meclients_show(struct seq_file *m, void *unused)
 
 	down_read(&dev->me_clients_rwsem);
 
-	seq_puts(m, "  |id|fix|         UUID                       |con|msg len|sb|refc|\n");
+	seq_puts(m, "  |id|fix|         UUID                       |con|msg len|sb|refc|vt|\n");
 
 	/*  if the driver is not enabled the list won't be consistent */
 	if (dev->dev_state != MEI_DEV_ENABLED)
@@ -37,14 +37,15 @@ static int mei_dbgfs_meclients_show(struct seq_file *m, void *unused)
 		if (!mei_me_cl_get(me_cl))
 			continue;
 
-		seq_printf(m, "%2d|%2d|%3d|%pUl|%3d|%7d|%2d|%4d|\n",
+		seq_printf(m, "%2d|%2d|%3d|%pUl|%3d|%7d|%2d|%4d|%2d|\n",
 			   i++, me_cl->client_id,
 			   me_cl->props.fixed_address,
 			   &me_cl->props.protocol_name,
 			   me_cl->props.max_number_of_connections,
 			   me_cl->props.max_msg_length,
 			   me_cl->props.single_recv_buf,
-			   kref_read(&me_cl->refcnt));
+			   kref_read(&me_cl->refcnt),
+			   me_cl->props.vt_supported);
 		mei_me_cl_put(me_cl);
 	}
 
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 13e4cb68a0e6..ea0a2e459282 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -314,13 +314,26 @@ struct hbm_host_enum_response {
 	u8 valid_addresses[32];
 } __packed;
 
+/**
+ * struct mei_client_properties - mei client properties
+ *
+ * @protocol_name: guid of the client
+ * @protocol_version: client protocol version
+ * @max_number_of_connections: number of possible connections.
+ * @fixed_address: fixed me address (0 if the client is dynamic)
+ * @single_recv_buf: 1 if all connections share a single receive buffer.
+ * @vt_supported: the client support vtag
+ * @reserved: reserved
+ * @max_msg_length: MTU of the client
+ */
 struct mei_client_properties {
 	uuid_le protocol_name;
 	u8 protocol_version;
 	u8 max_number_of_connections;
 	u8 fixed_address;
 	u8 single_recv_buf:1;
-	u8 reserved:7;
+	u8 vt_supported:1;
+	u8 reserved:6;
 	u32 max_msg_length;
 } __packed;
 
-- 
2.25.4

