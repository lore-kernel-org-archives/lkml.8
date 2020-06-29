Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8567EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF9B20724
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kVgkPGL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388291AbgF2T4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:56:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36511 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387632AbgF2TkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200629112249euoutp011f8f644da4eb5d01993d88741ed22f3f~c-_7xMFCv2854728547euoutp01D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200629112249euoutp011f8f644da4eb5d01993d88741ed22f3f~c-_7xMFCv2854728547euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593429769;
        bh=CMERx4lgHtPROTVbuhhkyjsE+9cW7GAD7BGwlyn84mI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVgkPGL4+wxH+Z0JxL+EtsiTIFaJtSxVI4hyDag1e/eNU2hDvmOwMrRZzHxgiZ7OW
         7n3NaX9khYVPSujbsWw2I/0Iip5AD45mOrlzD7EiwrjQ+/S+ORpCfdinuUiMHh+4fh
         +jTB3s/f363QTcfmLgh6buum2pOIA2REEP0zhrZA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200629112249eucas1p2fbd5791c8128b15d691229df630f96b4~c-_7WiTKj0840608406eucas1p2U;
        Mon, 29 Jun 2020 11:22:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2E.A7.06456.90FC9FE5; Mon, 29
        Jun 2020 12:22:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200629112249eucas1p160b845444f8fbad96bdec41e9d3938da~c-_673odH1893118931eucas1p1a;
        Mon, 29 Jun 2020 11:22:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200629112248eusmtrp2b89ff42eb1242f6b3f9794b94694cf28~c-_67L5Vj1960419604eusmtrp2o;
        Mon, 29 Jun 2020 11:22:48 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-c4-5ef9cf09a0a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.EC.06017.80FC9FE5; Mon, 29
        Jun 2020 12:22:48 +0100 (BST)
Received: from AMDC3748.digital.local (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200629112248eusmtip12146d8bc48fb9f86c4b5af32af8ff859~c-_6OPabQ2279922799eusmtip1A;
        Mon, 29 Jun 2020 11:22:48 +0000 (GMT)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
Subject: [PATCH v7 2/4] driver core: add deferring probe reason to
 devices_deferred property
Date:   Mon, 29 Jun 2020 13:22:40 +0200
Message-Id: <20200629112242.18380-3-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629112242.18380-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHeXeurlbHKfmipbXsQ4JZVPBGIl2kTlTkl4oSlysP09JlO2qt
        Cy68tkqnIZWXrlZLLc1StoFZ01KJ2dIUK0VFKxRFqC1bWebxrPr2e573/3+ePw8vjcnthD+d
        oEnhtBpVooKU4vUv3e2hXq/dypXu/AXo/cN2Ao0YmwB6dKWaQEWDwySari/A0FvXBIkybleT
        qGtyBENtY104OldQTqHaoW4CdVpLSWQragDoQXMfhWx50ajMWYRtYNjO7jcYO9GTRbEN327g
        rKW4j2JLcq8SbG3FOZJtNXZI2MayKortP98iYR+Xp7N5TyoA++ziJZz9WhsYJdsvDY/jEhPS
        OG1YRKw0ftBxS5JcGnyicOoToQemQAOgacisgfdbfQxASssZE4C5WS9IsXAC+PHOZ2AAXjPF
        VwANn3YLLBgsQ1OUKLoHYI7zPv7PkV3pJAQVySyHvx6/IwX2ZVbDfHvxrANjfuCwKyd7VuTD
        KOF3cyUl5MCZZbDvja/QljEI5ry+RIrbgmBlzTNMYC9mHex0XAXCHMiMUzDT6cJEUSR0VD3F
        RfaBoy1PKJEXwmnLdYnI6bDflImJ5lwA62osHvN62Nv+gxRCYDOpq61hYnsjbDYPkeKN5sGe
        cW+hjc1gYf1lTGzLYG62XFQvgf32Os9AP3jH4fLEZ+FUq8VznwsAnn1RihtBUPH/ZTcAqAB+
        XCqfpOb4VRru+ApelcSnatQrDh1NqgUzn+zV75YvZuDqOGgDDA0Uc2Wx7W6lnFCl8bokG4A0
        pvCVbbK/UsplcSrdSU579IA2NZHjbSCAxhV+stW3RmLkjFqVwh3huGRO+/dVQnv560GDvYo3
        B+iOBOzddVen27K2OOO5PXSPdXBxZgR0bM37XrIvvXHyw5jlesJAtrV+YMe+4arN26WNktHT
        6pidJtCbvC2ySxo8ubL5mvHm+pu/1FF1zLHD+ibvxDkhvP+p8Hy9Lvbp0E8248yytqKXjqVt
        0eV8WHrac0NHRoKDmL/IqMD5eNWqEEzLq/4AjIf7JGADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7oc53/GGexdaG1xa905VouXEw4z
        WmycsZ7VYurDJ2wW/7dNZLa48vU9m0Xz4vVsFle/v2S2OPnmKotF58Ql7BabHl9jtbi8aw6b
        xaGpexkt1h65y25xqC/aYu6XqcwOAh6Xr11k9nh/o5XdY++3BSweO2fdZfeY3TGT1WPTqk42
        jxMTLjF57J+7ht3jfvdxJo/NS+o9+rasYvQ40DuZxePzJrkA3ig9m6L80pJUhYz84hJbpWhD
        CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jIcXFjEVzFGpmPTnGWsD4wq5LkZO
        DgkBE4mdj/+wdzFycQgJLGWUuPysnxkiIS6xe/5bKFtY4s+1LjaIok+MElfPzmUDSbAJaEr8
        3XwTzBYRMJboPzsLbBKzQBurxNzzT9hBEsICMRJXp89j6WLk4GARUJW4e1EEJMwrYCHRfn4y
        G8QCeYnVGw6ALeMUsJS4fGEmI4gtBFRz4Wgn+wRGvgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1
        kvNzNzECY2vbsZ9bdjB2vQs+xCjAwajEw5tw7mecEGtiWXFl7iFGCQ5mJRFep7On44R4UxIr
        q1KL8uOLSnNSiw8xmgLdNJFZSjQ5Hxj3eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1Kz
        U1MLUotg+pg4OKUaGJW1jmdt6Z2qXCMfv1bo3ycvf/2qx+cP9Wn1S4dcLji4qnbdpfNz+e+l
        Bbt/3XU8McNl+n6Pd7x/rnlpTVSYxhtYm5Zf+IPxhsM2+4AHjTfyei8XR4VmLzRm4JrZc01F
        hbm0Z0Nd2MHLbZ4zrcw1RQUDN7M5bk95urJ3J+cLm77Qmb82T/ogqcRSnJFoqMVcVJwIAG3q
        8PXDAgAA
X-CMS-MailID: 20200629112249eucas1p160b845444f8fbad96bdec41e9d3938da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200629112249eucas1p160b845444f8fbad96bdec41e9d3938da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200629112249eucas1p160b845444f8fbad96bdec41e9d3938da
References: <20200629112242.18380-1-a.hajda@samsung.com>
        <CGME20200629112249eucas1p160b845444f8fbad96bdec41e9d3938da@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/kernel/debug/devices_deferred property contains list of deferred devices.
This list does not contain reason why the driver deferred probe, the patch
improves it.
The natural place to set the reason is dev_err_probe function introduced recently,
ie. if dev_err_probe will be called with -EPROBE_DEFER instead of printk the message
will be attached to deferred device and printed when user read devices_deferred
property.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/base/base.h |  3 +++
 drivers/base/core.c |  8 ++++++--
 drivers/base/dd.c   | 23 ++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 95c22c0f9036..6954fccab3d7 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -93,6 +93,7 @@ struct device_private {
 	struct klist_node knode_class;
 	struct list_head deferred_probe;
 	struct device_driver *async_driver;
+	char *deferred_probe_reason;
 	struct device *device;
 	u8 dead:1;
 };
@@ -134,6 +135,8 @@ extern void device_release_driver_internal(struct device *dev,
 extern void driver_detach(struct device_driver *drv);
 extern int driver_probe_device(struct device_driver *drv, struct device *dev);
 extern void driver_deferred_probe_del(struct device *dev);
+extern void device_set_deferred_probe_reson(const struct device *dev,
+					    struct va_format *vaf);
 static inline int driver_match_device(struct device_driver *drv,
 				      struct device *dev)
 {
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3a827c82933f..fee047f03681 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3963,6 +3963,8 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  * This helper implements common pattern present in probe functions for error
  * checking: print debug or error message depending if the error value is
  * -EPROBE_DEFER and propagate error upwards.
+ * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
+ * checked later by reading devices_deferred debugfs attribute.
  * It replaces code sequence:
  * 	if (err != -EPROBE_DEFER)
  * 		dev_err(dev, ...);
@@ -3984,10 +3986,12 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (err != -EPROBE_DEFER)
+	if (err != -EPROBE_DEFER) {
 		dev_err(dev, "error %d: %pV", err, &vaf);
-	else
+	} else {
+		device_set_deferred_probe_reson(dev, &vaf);
 		dev_dbg(dev, "error %d: %pV", err, &vaf);
+	}
 
 	va_end(args);
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9a1d940342ac..dd5683b61f74 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -27,6 +27,7 @@
 #include <linux/async.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
+#include <linux/slab.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -136,6 +137,8 @@ void driver_deferred_probe_del(struct device *dev)
 	if (!list_empty(&dev->p->deferred_probe)) {
 		dev_dbg(dev, "Removed from deferred list\n");
 		list_del_init(&dev->p->deferred_probe);
+		kfree(dev->p->deferred_probe_reason);
+		dev->p->deferred_probe_reason = NULL;
 	}
 	mutex_unlock(&deferred_probe_mutex);
 }
@@ -211,6 +214,23 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+/**
+ * device_set_deferred_probe_reson() - Set defer probe reason message for device
+ * @dev: the pointer to the struct device
+ * @vaf: the pointer to va_format structure with message
+ */
+void device_set_deferred_probe_reson(const struct device *dev, struct va_format *vaf)
+{
+	const char *drv = dev_driver_string(dev);
+
+	mutex_lock(&deferred_probe_mutex);
+
+	kfree(dev->p->deferred_probe_reason);
+	dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
+
+	mutex_unlock(&deferred_probe_mutex);
+}
+
 /*
  * deferred_devs_show() - Show the devices in the deferred probe pending list.
  */
@@ -221,7 +241,8 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 	mutex_lock(&deferred_probe_mutex);
 
 	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
-		seq_printf(s, "%s\n", dev_name(curr->device));
+		seq_printf(s, "%s\t%s", dev_name(curr->device),
+			   curr->device->p->deferred_probe_reason ?: "\n");
 
 	mutex_unlock(&deferred_probe_mutex);
 
-- 
2.17.1

