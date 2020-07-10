Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478FAC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294C320674
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgGJRPo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:15:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:31671 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgGJRPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:15:44 -0400
IronPort-SDR: D6ya71ft4vcQJueRJp95PVvt+no4ayEV7QQ4stX0NIutk7EM+jYkIJnn00yKAhvYY0/eE9DRcc
 E06T23echicA==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="146319170"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="146319170"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 10:15:35 -0700
IronPort-SDR: OMEX8yzz71moOOb125GbUCoRqR/01b3pvHJLnHLJKYt/dHNIsU+KjDvQ1Trl9Ke/JKO/uSf00L
 Ai4znPyEEMhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="284570094"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2020 10:15:35 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Jul 2020 10:15:34 -0700
Received: from fmsmsx108.amr.corp.intel.com ([169.254.9.193]) by
 FMSMSX109.amr.corp.intel.com ([169.254.15.60]) with mapi id 14.03.0439.000;
 Fri, 10 Jul 2020 10:15:34 -0700
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH v8 2/5] driver core: add deferring probe reason to
 devices_deferred property
Thread-Topic: [PATCH v8 2/5] driver core: add deferring probe reason to
 devices_deferred property
Thread-Index: AQHWVs8brT2CjFa9skuBYqTTYNxLbqkBDYkA
Date:   Fri, 10 Jul 2020 17:15:34 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E866301245BC852@FMSMSX108.amr.corp.intel.com>
References: <20200710153018.12226-1-a.hajda@samsung.com>
 <CGME20200710153024eucas1p1b0686b4acce78838db93fddb3c23939c@eucas1p1.samsung.com>
 <20200710153018.12226-3-a.hajda@samsung.com>
In-Reply-To: <20200710153018.12226-3-a.hajda@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
>Andrzej Hajda
>Sent: Friday, July 10, 2020 11:30 AM
>To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Jernej Skrabec <jernej.skrabec@siol.net>; Rafael J. Wysocki
><rafael@kernel.org>; Jonas Karlman <jonas@kwiboo.se>; Bartlomiej
>Zolnierkiewicz <b.zolnierkie@samsung.com>; linux-kernel@vger.kernel.org;
>open list:DRM DRIVERS <dri-devel@lists.freedesktop.org>; Russell King - ARM
>Linux <linux@armlinux.org.uk>; Neil Armstrong <narmstrong@baylibre.com>;
>Andrzej Hajda <a.hajda@samsung.com>; andy.shevchenko@gmail.com; Mark
>Brown <broonie@kernel.org>; Laurent Pinchart
><Laurent.pinchart@ideasonboard.com>; linux-arm-
>kernel@lists.infradead.org; Marek Szyprowski
><m.szyprowski@samsung.com>
>Subject: [PATCH v8 2/5] driver core: add deferring probe reason to
>devices_deferred property
>
>/sys/kernel/debug/devices_deferred property contains list of deferred
>devices.
>This list does not contain reason why the driver deferred probe, the patch
>improves it.
>The natural place to set the reason is dev_err_probe function introduced
>recently, ie. if dev_err_probe will be called with -EPROBE_DEFER instead of
>printk the message will be attached to a deferred device and printed when
>user
>reads devices_deferred property.
>
>Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>Reviewed-by: Mark Brown <broonie@kernel.org>
>Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
>---
>v8:
>- improved commit message
>---
> drivers/base/base.h |  3 +++
> drivers/base/core.c |  8 ++++++--
> drivers/base/dd.c   | 23 ++++++++++++++++++++++-
> 3 files changed, 31 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/base/base.h b/drivers/base/base.h
>index 95c22c0f9036..6954fccab3d7 100644
>--- a/drivers/base/base.h
>+++ b/drivers/base/base.h
>@@ -93,6 +93,7 @@ struct device_private {
> 	struct klist_node knode_class;
> 	struct list_head deferred_probe;
> 	struct device_driver *async_driver;
>+	char *deferred_probe_reason;
> 	struct device *device;
> 	u8 dead:1;
> };
>@@ -134,6 +135,8 @@ extern void device_release_driver_internal(struct
>device *dev,
> extern void driver_detach(struct device_driver *drv);
> extern int driver_probe_device(struct device_driver *drv, struct device
>*dev);
> extern void driver_deferred_probe_del(struct device *dev);
>+extern void device_set_deferred_probe_reson(const struct device *dev,
>+					    struct va_format *vaf);
> static inline int driver_match_device(struct device_driver *drv,
> 				      struct device *dev)
> {
>diff --git a/drivers/base/core.c b/drivers/base/core.c
>index 3a827c82933f..fee047f03681 100644
>--- a/drivers/base/core.c
>+++ b/drivers/base/core.c
>@@ -3963,6 +3963,8 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>  * This helper implements common pattern present in probe functions for
>error
>  * checking: print debug or error message depending if the error value is
>  * -EPROBE_DEFER and propagate error upwards.
>+ * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
>+ * checked later by reading devices_deferred debugfs attribute.
>  * It replaces code sequence:
>  * 	if (err != -EPROBE_DEFER)
>  * 		dev_err(dev, ...);
>@@ -3984,10 +3986,12 @@ int dev_err_probe(const struct device *dev, int
>err, const char *fmt, ...)
> 	vaf.fmt = fmt;
> 	vaf.va = &args;
>
>-	if (err != -EPROBE_DEFER)
>+	if (err != -EPROBE_DEFER) {
> 		dev_err(dev, "error %d: %pV", err, &vaf);
>-	else
>+	} else {
>+		device_set_deferred_probe_reson(dev, &vaf);
> 		dev_dbg(dev, "error %d: %pV", err, &vaf);
>+	}
>
> 	va_end(args);
>
>diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>index 9a1d940342ac..dd5683b61f74 100644
>--- a/drivers/base/dd.c
>+++ b/drivers/base/dd.c
>@@ -27,6 +27,7 @@
> #include <linux/async.h>
> #include <linux/pm_runtime.h>
> #include <linux/pinctrl/devinfo.h>
>+#include <linux/slab.h>
>
> #include "base.h"
> #include "power/power.h"
>@@ -136,6 +137,8 @@ void driver_deferred_probe_del(struct device *dev)
> 	if (!list_empty(&dev->p->deferred_probe)) {
> 		dev_dbg(dev, "Removed from deferred list\n");
> 		list_del_init(&dev->p->deferred_probe);
>+		kfree(dev->p->deferred_probe_reason);
>+		dev->p->deferred_probe_reason = NULL;
> 	}
> 	mutex_unlock(&deferred_probe_mutex);
> }
>@@ -211,6 +214,23 @@ void device_unblock_probing(void)
> 	driver_deferred_probe_trigger();
> }
>
>+/**
>+ * device_set_deferred_probe_reson() - Set defer probe reason message
>for device
>+ * @dev: the pointer to the struct device
>+ * @vaf: the pointer to va_format structure with message
>+ */
>+void device_set_deferred_probe_reson(const struct device *dev, struct

Is 'reson'  supposed to be 'reason'?

Same spelling on the above kernel-doc, but the comment says "reason".

mike

>va_format *vaf)
>+{
>+	const char *drv = dev_driver_string(dev);
>+
>+	mutex_lock(&deferred_probe_mutex);
>+
>+	kfree(dev->p->deferred_probe_reason);
>+	dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s:
>%pV", drv, vaf);
>+
>+	mutex_unlock(&deferred_probe_mutex);
>+}
>+
> /*
>  * deferred_devs_show() - Show the devices in the deferred probe pending
>list.
>  */
>@@ -221,7 +241,8 @@ static int deferred_devs_show(struct seq_file *s, void
>*data)
> 	mutex_lock(&deferred_probe_mutex);
>
> 	list_for_each_entry(curr, &deferred_probe_pending_list,
>deferred_probe)
>-		seq_printf(s, "%s\n", dev_name(curr->device));
>+		seq_printf(s, "%s\t%s", dev_name(curr->device),
>+			   curr->device->p->deferred_probe_reason ?: "\n");
>
> 	mutex_unlock(&deferred_probe_mutex);
>
>--
>2.17.1
>
>_______________________________________________
>dri-devel mailing list
>dri-devel@lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/dri-devel
