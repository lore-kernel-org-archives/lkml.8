Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA136C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFC3206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgGVGwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:52:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54885 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgGVGwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:52:16 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jy8bu-0005xb-3Z
        for linux-kernel@vger.kernel.org; Wed, 22 Jul 2020 06:52:14 +0000
Received: by mail-wr1-f71.google.com with SMTP id s16so244950wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 23:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uhBXqoms6Y2BJ+DRWgv1UXrLfuoV1AP2/YI2uOM0BIc=;
        b=sObdFnIfHKT3cVDg2uz+NxnYR2pf6wV6jf1RPj2vD7l5jrdGs+95eICyTkTggnGbMv
         mj/8m2qhC9974jELsukuQ+ozAyHMOciTc5320GgAMYNBY4ZfemvkG4Uf0HQDh85Q9slZ
         WOWtKa05nt1nakaM+Syj0MrdMEQu4pebXl+SYsOYUG4+gYN1dWHEhkZjTaH2i3SKB8TR
         yEr+EPMoup5weprttsqJZxbYwATPmSdNPhC6v75iOk5NGqN3ppPcb5upfV7x5SuYZVpK
         X3eyRSg1wP7WdEywJUgQgEo+DbL5u4uskKrMs8rb+laGHQ7C+p4OCzKUbiaaLFWRE3+j
         3VIA==
X-Gm-Message-State: AOAM532jG8NOwnDZIZ/HlIrEEqwdG9qmfL6k2hIH73nzuRxe276k14r8
        dB3qRtYdFQYE5J1Dau8EMdX9QMzhGoVFbUy9xYErsZCNkbei75fUjVQ53PTeAkTJCao8NEdFqg6
        7frtdBkrsbQBgB7MP3IQ5C/QQrzWBbOiuTH6F373FCQ==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr1897721wmc.73.1595400733676;
        Tue, 21 Jul 2020 23:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhC1gnk9TlQyUIEJ3tOszObyW4FaQs/e6/6fGBY61IX5lMt1lAPzd6jSpjxL2aHTCAHJKvaQ==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr1897700wmc.73.1595400733297;
        Tue, 21 Jul 2020 23:52:13 -0700 (PDT)
Received: from localhost (host-87-11-131-192.retail.telecomitalia.it. [87.11.131.192])
        by smtp.gmail.com with ESMTPSA id g70sm2426599wmg.24.2020.07.21.23.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 23:52:12 -0700 (PDT)
Date:   Wed, 22 Jul 2020 08:52:11 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xen-netfront: fix potential deadlock in xennet_remove()
Message-ID: <20200722065211.GA841369@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a potential race in xennet_remove(); this is what the driver is
doing upon unregistering a network device:

  1. state = read bus state
  2. if state is not "Closed":
  3.    request to set state to "Closing"
  4.    wait for state to be set to "Closing"
  5.    request to set state to "Closed"
  6.    wait for state to be set to "Closed"

If the state changes to "Closed" immediately after step 1 we are stuck
forever in step 4, because the state will never go back from "Closed" to
"Closing".

Make sure to check also for state == "Closed" in step 4 to prevent the
deadlock.

Also add a 5 sec timeout any time we wait for the bus state to change,
to avoid getting stuck forever in wait_event() and add a debug message
to help tracking down potential similar issues.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 drivers/net/xen-netfront.c | 79 +++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 482c6c8b0fb7..e09caba93dd9 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -63,6 +63,8 @@ module_param_named(max_queues, xennet_max_queues, uint, 0644);
 MODULE_PARM_DESC(max_queues,
 		 "Maximum number of queues per virtual interface");
 
+#define XENNET_TIMEOUT  (5 * HZ)
+
 static const struct ethtool_ops xennet_ethtool_ops;
 
 struct netfront_cb {
@@ -1334,12 +1336,20 @@ static struct net_device *xennet_create_dev(struct xenbus_device *dev)
 
 	netif_carrier_off(netdev);
 
-	xenbus_switch_state(dev, XenbusStateInitialising);
-	wait_event(module_wq,
-		   xenbus_read_driver_state(dev->otherend) !=
-		   XenbusStateClosed &&
-		   xenbus_read_driver_state(dev->otherend) !=
-		   XenbusStateUnknown);
+	do {
+		dev_dbg(&dev->dev,
+			"%s: switching to XenbusStateInitialising\n",
+			dev->nodename);
+		xenbus_switch_state(dev, XenbusStateInitialising);
+		err = wait_event_timeout(module_wq,
+				 xenbus_read_driver_state(dev->otherend) !=
+				 XenbusStateClosed &&
+				 xenbus_read_driver_state(dev->otherend) !=
+				 XenbusStateUnknown, XENNET_TIMEOUT);
+		dev_dbg(&dev->dev, "%s: state = %d\n", dev->nodename,
+			xenbus_read_driver_state(dev->otherend));
+	} while (!err);
+
 	return netdev;
 
  exit:
@@ -2139,28 +2149,53 @@ static const struct attribute_group xennet_dev_group = {
 };
 #endif /* CONFIG_SYSFS */
 
-static int xennet_remove(struct xenbus_device *dev)
+static void xennet_bus_close(struct xenbus_device *dev)
 {
-	struct netfront_info *info = dev_get_drvdata(&dev->dev);
-
-	dev_dbg(&dev->dev, "%s\n", dev->nodename);
+	int ret;
 
-	if (xenbus_read_driver_state(dev->otherend) != XenbusStateClosed) {
+	if (xenbus_read_driver_state(dev->otherend) == XenbusStateClosed)
+		return;
+	do {
+		dev_dbg(&dev->dev, "%s: switching to XenbusStateClosing\n",
+			dev->nodename);
 		xenbus_switch_state(dev, XenbusStateClosing);
-		wait_event(module_wq,
-			   xenbus_read_driver_state(dev->otherend) ==
-			   XenbusStateClosing ||
-			   xenbus_read_driver_state(dev->otherend) ==
-			   XenbusStateUnknown);
+		ret = wait_event_timeout(module_wq,
+				   xenbus_read_driver_state(dev->otherend) ==
+				   XenbusStateClosing ||
+				   xenbus_read_driver_state(dev->otherend) ==
+				   XenbusStateClosed ||
+				   xenbus_read_driver_state(dev->otherend) ==
+				   XenbusStateUnknown,
+				   XENNET_TIMEOUT);
+		dev_dbg(&dev->dev, "%s: state = %d\n", dev->nodename,
+			xenbus_read_driver_state(dev->otherend));
+	} while (!ret);
+
+	if (xenbus_read_driver_state(dev->otherend) == XenbusStateClosed)
+		return;
 
+	do {
+		dev_dbg(&dev->dev, "%s: switching to XenbusStateClosed\n",
+			dev->nodename);
 		xenbus_switch_state(dev, XenbusStateClosed);
-		wait_event(module_wq,
-			   xenbus_read_driver_state(dev->otherend) ==
-			   XenbusStateClosed ||
-			   xenbus_read_driver_state(dev->otherend) ==
-			   XenbusStateUnknown);
-	}
+		ret = wait_event_timeout(module_wq,
+				   xenbus_read_driver_state(dev->otherend) ==
+				   XenbusStateClosed ||
+				   xenbus_read_driver_state(dev->otherend) ==
+				   XenbusStateUnknown,
+				   XENNET_TIMEOUT);
+		dev_dbg(&dev->dev, "%s: state = %d\n", dev->nodename,
+			xenbus_read_driver_state(dev->otherend));
+	} while (!ret);
+}
+
+static int xennet_remove(struct xenbus_device *dev)
+{
+	struct netfront_info *info = dev_get_drvdata(&dev->dev);
+
+	dev_dbg(&dev->dev, "%s\n", dev->nodename);
 
+	xennet_bus_close(dev);
 	xennet_disconnect_backend(info);
 
 	if (info->netdev->reg_state == NETREG_REGISTERED)
-- 
2.25.1

