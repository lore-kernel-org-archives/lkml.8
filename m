Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A04C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B636C2065F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgGHNh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:37:59 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:48223 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbgGHNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:37:59 -0400
X-Greylist: delayed 650 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 09:37:57 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 14E1010190FA4;
        Wed,  8 Jul 2020 15:37:57 +0200 (CEST)
Received: from localhost (pd95be530.dip0.t-ipconnect.de [217.91.229.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id B1E906106EC8;
        Wed,  8 Jul 2020 15:37:56 +0200 (CEST)
X-Mailbox-Line: From f2d349b5ba67b5ca70cb19577725167642eb69c5 Mon Sep 17 00:00:00 2001
Message-Id: <f2d349b5ba67b5ca70cb19577725167642eb69c5.1594214103.git.lukas@wunner.de>
In-Reply-To: <cover.1594214103.git.lukas@wunner.de>
References: <cover.1594214103.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 8 Jul 2020 15:27:03 +0200
Subject: [PATCH 3/3] driver core: Avoid adding children below a dead parent
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_OF_DYNAMIC or CONFIG_ACPI is enabled, SPI devices may be added
below a controller at runtime by a DeviceTree overlay or DSDT patch.
But there are no precautions to prevent adding a device below a
controller that's being removed.

This seems like something that should be guarded against in the driver
core because it's not specific to SPI:  Adding a child below a parent
that's going away seems like a bad idea regardless of the bus type.

Take advantage of kill_device() which was added by commit 00289cd87676
("drivers/base: Introduce kill_device()"), call it upon removal of an
SPI controller and teach the driver core to refuse device addition below
a killed parent.  To make this race-free, device_add() needs to take the
parent's dead_sem before checking its "dead" flag and until the child
device has been added to the parent's klist_children.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/core.c | 18 ++++++++++++++++--
 drivers/spi/spi.c   |  3 +++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 057da42b1a660..1d4e39696f996 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2597,6 +2597,14 @@ int device_add(struct device *dev)
 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
 
 	parent = get_device(dev->parent);
+	if (parent) {
+		down_read(&parent->p->dead_sem);
+		if (parent->p->dead) {
+			error = -ENODEV;
+			goto parent_error;
+		}
+	}
+
 	kobj = get_device_parent(dev, parent);
 	if (IS_ERR(kobj)) {
 		error = PTR_ERR(kobj);
@@ -2679,9 +2687,11 @@ int device_add(struct device *dev)
 	}
 
 	bus_probe_device(dev);
-	if (parent)
+	if (parent) {
 		klist_add_tail(&dev->p->knode_parent,
 			       &parent->p->klist_children);
+		up_read(&parent->p->dead_sem);
+	}
 
 	if (dev->class) {
 		mutex_lock(&dev->class->p->mutex);
@@ -2722,6 +2732,8 @@ int device_add(struct device *dev)
  Error:
 	cleanup_glue_dir(dev, glue_dir);
 parent_error:
+	if (parent)
+		up_read(&parent->p->dead_sem);
 	put_device(parent);
 name_error:
 	kfree(dev->p);
@@ -2785,7 +2797,9 @@ EXPORT_SYMBOL_GPL(put_device);
  * kill_device - declare device dead
  * @dev: device in question
  *
- * Declare @dev dead to prevent it from binding to a driver.
+ * Declare @dev dead to prevent it from binding to a driver and
+ * to prevent addition of children.
+ *
  * Return true if it was killed or false if it was already dead.
  */
 bool kill_device(struct device *dev)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8158e281f3540..005eca4bae089 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2764,6 +2764,9 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	struct spi_controller *found;
 	int id = ctlr->bus_num;
 
+	/* Prevent addition of new children, then remove existing ones */
+	if (IS_ENABLED(CONFIG_OF_DYNAMIC) || IS_ENABLED(CONFIG_ACPI))
+		kill_device(&ctlr->dev);
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
 	/* First make sure that this controller was ever added */
-- 
2.27.0

