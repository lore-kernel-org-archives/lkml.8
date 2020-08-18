Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DBCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6FA20706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHRMLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:11:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:58738 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgHRMKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:10:21 -0400
IronPort-SDR: Qr9FqWjiTP6L8hrZdKd+C6OYo5Ui53HNVRo5gPlJa7B5/4TLTq9jBK8Jr/GTtTVahlfLwOAJR3
 BQWP+zZp3hWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200400"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:10:20 -0700
IronPort-SDR: nTd3h3+oObJSYkT1KRpalDVCQ0oWImq4U2yt5oeIcAaBwEHFyL/ErUWnfix6hw31bQ/9uQkGAS
 Q1cenOMyDOGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326713041"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:10:17 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 09/13] mei: bus: use zero vtag for bus clients.
Date:   Tue, 18 Aug 2020 14:51:43 +0300
Message-Id: <20200818115147.2567012-10-tomas.winkler@intel.com>
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

The zero vtag is required for the read flow to work also for
devices on the mei client bus.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c | 72 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index fc20a0da5c24..9cdaa7f3af23 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -495,6 +495,68 @@ static void mei_cl_bus_module_put(struct mei_cl_device *cldev)
 	module_put(cldev->bus->dev->driver->owner);
 }
 
+/**
+ * mei_cl_bus_vtag - get bus vtag entry wrapper
+ *     The tag for bus client is always first.
+ *
+ * @cl: host client
+ *
+ * Return: bus vtag or NULL
+ */
+static inline struct mei_cl_vtag *mei_cl_bus_vtag(struct mei_cl *cl)
+{
+	return list_first_entry_or_null(&cl->vtag_map,
+					struct mei_cl_vtag, list);
+}
+
+/**
+ * mei_cl_bus_vtag_alloc - add bus client entry to vtag map
+ *
+ * @cldev: me client device
+ *
+ * Return:
+ * * 0 on success
+ * * -ENOMEM if memory allocation failed
+ */
+static int mei_cl_bus_vtag_alloc(struct mei_cl_device *cldev)
+{
+	struct mei_cl *cl = cldev->cl;
+	struct mei_cl_vtag *cl_vtag;
+
+	/*
+	 * Bail out if the client does not supports vtags
+	 * or has already allocated one
+	 */
+	if (mei_cl_vt_support_check(cl) || mei_cl_bus_vtag(cl))
+		return 0;
+
+	cl_vtag = mei_cl_vtag_alloc(NULL, 0);
+	if (IS_ERR(cl_vtag))
+		return -ENOMEM;
+
+	list_add_tail(&cl_vtag->list, &cl->vtag_map);
+
+	return 0;
+}
+
+/**
+ * mei_cl_bus_vtag_free - remove the bus entry from vtag map
+ *
+ * @cldev: me client device
+ */
+static void mei_cl_bus_vtag_free(struct mei_cl_device *cldev)
+{
+	struct mei_cl *cl = cldev->cl;
+	struct mei_cl_vtag *cl_vtag;
+
+	cl_vtag = mei_cl_bus_vtag(cl);
+	if (!cl_vtag)
+		return;
+
+	list_del(&cl_vtag->list);
+	kfree(cl_vtag);
+}
+
 /**
  * mei_cldev_enable - enable me client device
  *     create connection with me client
@@ -531,9 +593,15 @@ int mei_cldev_enable(struct mei_cl_device *cldev)
 		goto out;
 	}
 
+	ret = mei_cl_bus_vtag_alloc(cldev);
+	if (ret)
+		goto out;
+
 	ret = mei_cl_connect(cl, cldev->me_cl, NULL);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&cldev->dev, "cannot connect\n");
+		mei_cl_bus_vtag_free(cldev);
+	}
 
 out:
 	mutex_unlock(&bus->device_lock);
@@ -586,6 +654,8 @@ int mei_cldev_disable(struct mei_cl_device *cldev)
 
 	mutex_lock(&bus->device_lock);
 
+	mei_cl_bus_vtag_free(cldev);
+
 	if (!mei_cl_is_connected(cl)) {
 		dev_dbg(bus->dev, "Already disconnected\n");
 		err = 0;
-- 
2.25.4

