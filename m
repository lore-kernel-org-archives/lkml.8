Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F97AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567AE206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dt2KlYn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGPEVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 00:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgGPEVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:21:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:21:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x1so5669447ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zb9Ksn8SCjdD/hVC3/rnyZUUJ8FDyQJf1yIXDH+XUgo=;
        b=Dt2KlYn+vrlb6IxoMIFG3XSGRGdLDxfaIjPE/LWF1t7DD/hs/2YR3XXS+a+zNGIOfL
         dzQJQtVcwtOzGBxRcCWxvD3m5Nr2DvzdgZf76vgMNlyZzHbAC7zqI6qY+toNkKB1LpHH
         giyY8rpDowTgjlXW+RSCI5HbXRdC5L0m7eD7lw5sW3Cv2etpkyzA182FJ72p9vGg35ie
         2r/X7wr1Z6YLJX4Q3l6DktFlFGLBe3Kxage/Un+p73hxHakiItT0HcYE9D1h6ormrgr7
         djyTpVUVABVY7CZ8/cJJp7ZVBSuoTwaQy1cCdchVy0jT3Q6KQpx3r36O2gcLCkq2BMk8
         TAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zb9Ksn8SCjdD/hVC3/rnyZUUJ8FDyQJf1yIXDH+XUgo=;
        b=jl+MdKgnyTpZ9SaeM8opojfKsqcpqb9D5rTjS96I0XoMmS2FHGOga/VVIpqAMJGYu7
         phviuGcoTy//uhXt4Ct4ZtHS6+wGVsBcCsHWiasy1MVMdciuBKqs7VAx7jewNsTCV5LO
         xeh/qKlpHHoNzH6sBdJxQLpzonS8eori1/7ki3kDZl51bpoHGULFjRmwtDPqneP8t0tq
         AwT37vVwZlGqUdq3C+sYgPV7cmBhDxooc3nChoNaTFlsczC8cCKJQcUBN0GZZztaPzFS
         KVoShthRFXf+eLorvw2rZ0VV7BZR8taJ9cexz3GqDqu9gfAY4IvV0UQlDVREZ+x0q5DQ
         9mPA==
X-Gm-Message-State: AOAM5321e9eql/CdypDOP51kx6zsZA8834nw8723jhrHLfqoRC2wmgPT
        sDyk95eI7SHnMPrHz7T4j1ORz6MRGiYtsCE=
X-Google-Smtp-Source: ABdhPJxluGUr1UQ6wJGW2Kc125LY9FFANR3BuU8MmlZGKlgqcMEIZR4dwRqE/afhDA7T89bgwSF0L90F5deYkww=
X-Received: by 2002:a25:c342:: with SMTP id t63mr3637322ybf.122.1594873264148;
 Wed, 15 Jul 2020 21:21:04 -0700 (PDT)
Date:   Wed, 15 Jul 2020 21:20:52 -0700
In-Reply-To: <20200716042053.1927676-1-saravanak@google.com>
Message-Id: <20200716042053.1927676-4-saravanak@google.com>
Mime-Version: 1.0
References: <20200716042053.1927676-1-saravanak@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 3/4] regulator: core: Add basic enable/disable support for
 sync_state() callbacks
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the following example:
- regulator-X is provided by device-X.
- regulator-X is a supplier to device-A, device-B and device-C.
- device-A is off/inactive from boot.
- device-B and device-C are left on/active by the bootloader
- regulator-X is left on boot by the bootloader at 2000 mV to supply
  device-B and device-C.

Example boot sequence:
1. device-X is probed successfully.
2. device-A is probed by driver-A
   a. driver-A gets regulator-X
   b. driver-A votes on regulator-X
   c. driver-A initializes device-A
   d. driver-A votes off regulator-X
   e. regulator-X is turned off.
3. System crashes or device-B and device-C become unreliable because
   regulator-X was turned off without following the proper quiescing
   steps for device-B and device-C.

There are Android devices that exhibit the issue in the example where
regulator-X is an LDO, device-A is a camera device and device-B and
device-C are UFS and USB. To avoid this, they have their own downstream
changes to the regulator framework.

This patch addresses the problem in the example by:

1. When a regulator is registered,
   a. The sync_state() callback for the regulator's device is set to
      regulator_sync_state(). The sync_state() callback is called when
      all the consumers of the regulator's device have probed
      successfully.
   b. If the regulator is ON at boot, a BOOT-LIMITS consumer is created
      for the regulator and an enable vote is made.

2. When the regulator_sync_state() callback comes, all the boot-on
   regulators registered by that device will have the BOOT-LIMITS enable
   vote removed and the BOOT-LIMITS consumer freed.

If an exclusive get is ever attempted on a boot-on regulator with an
active BOOT-LIMITS vote, the regulator is handed off to the new consumer
(and the BOOT-LIMITS freed) without affecting the regulator state. This
ensures, consumers doing exclusive gets continue to work after this
commit.

To maintain backward compatibility with systems where some consumers of
the device might never probe, a new regulator_cleanup_timeout kernel
commandline argument is added and defaulted to 30 seconds. When the
timeout is a non-zero value and it expires, all BOOT-LIMITS consumer
votes are removed even if the sync_state() callbacks haven't been
called.

In systems where all the consumers are expected to probe, the
regulator_cleanup_timeout can be set to 0. When that's done, the
BOOT-LIMITS consumer votes for a regulator are removed only when all the
consumers of the regulator's device have probed.

So with this patch and regulator_cleanup_timeout=0, the example will work
as follows:

1. device-X is probed successfully.
   a. regulator-X is registered.
   b. Since regulator-X is on, an enable vote is made by the BOOT-LIMITS
      consumer.
2. device-A is probed by driver-A
   a. driver-A gets regulator-X
   b. driver-A votes on regulator-X
   c. driver-A initializes device-A
   d. driver-A votes off regulator-X
   e. regulator-X is NOT turned off due to BOOT-LIMITS consumer.
3. device-B is probed by driver-B
   a. driver-B gets regulator-X
   b. driver-B votes on regulator-X
   c. driver-B initializes device-B.
   d. driver-B votes off regulator-X because device-B enters runtime
      idle.
   e. regulator-X is NOT turned off due to BOOT-LIMITS consumer.
4. device-C is probed by driver-C
   a. Does stuff similar to device-B and votes off regulator-X.
5. Since all consumers of device-X have probed, device-X gets
   sync_state() callback which is a call to regulator_sync_state():
   a. BOOT-LIMITS removes enable vote for regulator-X
   b. regulator-X is turned off.
   c. BOOT-LIMITS consumer is freed.
6. The system is stable because regulator-X is only turned off after
   device-B and device-C get to initialize and quiesce properly.

OR

Same steps for 1 - 3 as above.
4. device-C is never probed because driver-C isn't available.
5. Since all consumers of device-X have NOT probed, device-X doesn't get
   sync_state() callback.
   a. BOOT-LIMITS votes continue to be enforced for regulator-X
6. device-C continues to work in the mode the boot loader left it in and
   the system remains usable. For example, device C is
   - A display backlight that doesn't have a driver
   - An interconnect that doesn't have an interconnect provider driver

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/regulator/core.c         | 155 ++++++++++++++++++++++++++++++-
 include/linux/regulator/driver.h |   2 +
 2 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c9615d3530c7..f10ef6ec1af1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1769,6 +1769,115 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+/**
+ * regulator_add_boot_limits - Set up boot limits for a regulator device.
+ * @rdev: regulator device to set up boot limits for.
+ *
+ * Makes requests on the regulator device @rdev so that its operating state
+ * doesn't drop below the state in which the bootloader left it at before
+ * starting the kernel.
+ *
+ * If boot limits has already been set up, this function doesn't do anything.
+ *
+ * The boot limits can be dropped later by calling regulator_del_boot_limits().
+ */
+static void regulator_add_boot_limits(struct regulator_dev *rdev)
+{
+	/* We already set up boot limits. */
+	if (rdev->boot_limits)
+		return;
+
+	/*
+	 * If the regulator is disabled or has an error getting the status,
+	 * assume it's not on. We won't explicitly turn it off now, that can
+	 * happen later.
+	 */
+	if (_regulator_is_enabled(rdev) <= 0)
+		return;
+
+	/* Wait for supply to get resolved */
+	if (rdev->supply_name && !rdev->supply)
+		return;
+
+	/* Wait for coupled regulators to be resolved */
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled)
+		return;
+
+	/*
+	 * Get a reference to a regulator to set up boot limits to prevent it
+	 * from going below the state in which the boot loader left it in.
+	 */
+	rdev->boot_limits = create_regulator(rdev, NULL, "BOOT-LIMITS");
+	if (rdev->boot_limits == NULL) {
+		dev_err(&rdev->dev, "Unable to get boot limits handle\n");
+		rdev->boot_limits = ERR_PTR(-EPERM);
+		return;
+	}
+	rdev->open_count++;
+
+	if (regulator_enable(rdev->boot_limits)) {
+		dev_err(&rdev->dev, "Unable to set boot limits\n");
+		destroy_regulator(rdev->boot_limits);
+		rdev->boot_limits = ERR_PTR(-EPERM);
+	}
+}
+
+/**
+ * regulator_del_boot_limits - Remove boot limits for a regulator device.
+ * @rdev: regulator device to remove boot limits for.
+ * @handoff: Flag to control if the regulator should be handed off without a
+ *	     state change to the hardware.
+ *
+ * If boot limits has never been set up for this regulator, this function
+ * doesn't do anything and returns immediately.
+ *
+ * If boot limits have already been set up for the regulator device @rdev, this
+ * functions removes the boot limits so that operating state of @rdev can drop below
+ * the state in which the bootloader left it at before starting the kernel.
+ *
+ * In addition, if @handoff is NOT set, the function immediately updates the
+ * state of the regulator (potentially disabling it too).  Otherwise, this
+ * function removes the boot limits and leaves the regulator state update to
+ * subsequent requests by other consumers. This is mainly useful for removing
+ * the boot limits when an exclusive consumer takes control of the regulator.
+ */
+static int regulator_del_boot_limits(struct regulator_dev *rdev, bool handoff)
+{
+	if (IS_ERR_OR_NULL(rdev->boot_limits))
+		return 0;
+
+	rdev_info(rdev, "removing boot limits\n");
+	if (!handoff)
+		regulator_disable(rdev->boot_limits);
+	else
+		rdev->use_count--;
+	destroy_regulator(rdev->boot_limits);
+	/*
+	 * Set it to an error value so that boot limits can't be set again once
+	 * it has been removed.
+	 */
+	rdev->boot_limits = ERR_PTR(-EINVAL);
+	return 0;
+}
+
+static int regulator_del_boot_limits_by_dev(struct device *dev, void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+
+	if (dev->parent != data)
+		return 0;
+
+	regulator_del_boot_limits(rdev, false);
+	return 0;
+}
+
+void regulator_sync_state(struct device *dev)
+{
+	class_for_each_device(&regulator_class, NULL, dev,
+			      regulator_del_boot_limits_by_dev);
+}
+EXPORT_SYMBOL_GPL(regulator_sync_state);
+
 static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
@@ -1827,6 +1936,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		return ret;
 	}
 
+	mutex_lock(&regulator_list_mutex);
+	regulator_add_boot_limits(rdev);
+	mutex_unlock(&regulator_list_mutex);
+
 	/*
 	 * In set_machine_constraints() we may have turned this regulator on
 	 * but we couldn't propagate to the supply if it hadn't been resolved
@@ -1851,7 +1964,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 	struct regulator_dev *rdev;
 	struct regulator *regulator;
 	struct device_link *link;
-	int ret;
+	int ret, open_count;
 
 	if (get_type >= MAX_GET_TYPE) {
 		dev_err(dev, "invalid type %d in %s\n", get_type, __func__);
@@ -1908,7 +2021,15 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		return regulator;
 	}
 
-	if (get_type == EXCLUSIVE_GET && rdev->open_count) {
+	/*
+	 * Adjust for boot limits that'll be dropped if EXCLUSIVE_GET can
+	 * succeed.
+	 */
+	open_count = rdev->open_count;
+	if (!IS_ERR_OR_NULL(rdev->boot_limits))
+		open_count--;
+
+	if (get_type == EXCLUSIVE_GET && open_count) {
 		regulator = ERR_PTR(-EBUSY);
 		put_device(&rdev->dev);
 		return regulator;
@@ -1947,6 +2068,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 
 	rdev->open_count++;
 	if (get_type == EXCLUSIVE_GET) {
+		/* Drop boot limits before exclusive consumer */
+		regulator_del_boot_limits(rdev, true);
+
 		rdev->exclusive = 1;
 
 		ret = _regulator_is_enabled(rdev);
@@ -4896,7 +5020,9 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
 		regulator_unlock(c_rdev);
 
 		regulator_resolve_coupling(c_rdev);
+		regulator_add_boot_limits(c_rdev);
 	}
+	regulator_add_boot_limits(rdev);
 }
 
 static void regulator_remove_coupling(struct regulator_dev *rdev)
@@ -5223,6 +5349,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	rdev_init_debugfs(rdev);
 
+	dev_set_drv_sync_state(rdev->dev.parent, regulator_sync_state);
+
 	/* try to resolve regulators coupling since a new one was registered */
 	mutex_lock(&regulator_list_mutex);
 	regulator_resolve_coupling(rdev);
@@ -5755,6 +5883,17 @@ static int regulator_late_cleanup(struct device *dev, void *data)
 	return 0;
 }
 
+static int regulator_boot_limits_timeout(struct device *dev, void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+
+	regulator_del_boot_limits(rdev, false);
+	return 0;
+}
+
+static unsigned int regulator_cleanup_timeout = 30000;
+core_param(regulator_cleanup_timeout, regulator_cleanup_timeout, uint, 0);
+
 static void regulator_init_complete_work_function(struct work_struct *work)
 {
 	/*
@@ -5767,6 +5906,16 @@ static void regulator_init_complete_work_function(struct work_struct *work)
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_register_resolve_supply);
 
+	/*
+	 * If regulator_cleanup_timeout is set to a non-zero value, it probably
+	 * means some of the consumers will never probe or the regulators have
+	 * some restrictions on how long they can stay ON. So, don't wait
+	 * forever for consumer devices to probe.
+	 */
+	if (regulator_cleanup_timeout)
+		class_for_each_device(&regulator_class, NULL, NULL,
+				      regulator_boot_limits_timeout);
+
 	/* If we have a full configuration then disable any regulators
 	 * we have permission to change the status for and which are
 	 * not in use or always_on.  This is effectively the default
@@ -5802,7 +5951,7 @@ static int __init regulator_init_complete(void)
 	 * command line option might be useful.
 	 */
 	schedule_delayed_work(&regulator_init_complete_work,
-			      msecs_to_jiffies(30000));
+			      msecs_to_jiffies(regulator_cleanup_timeout));
 
 	return 0;
 }
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 7eb9fea8e482..4761157a1528 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -451,6 +451,7 @@ struct regulator_dev {
 	struct regulator *supply;	/* for tree */
 	const char *supply_name;
 	struct regmap *regmap;
+	struct regulator *boot_limits;
 
 	struct delayed_work disable_work;
 
@@ -475,6 +476,7 @@ devm_regulator_register(struct device *dev,
 			const struct regulator_desc *regulator_desc,
 			const struct regulator_config *config);
 void regulator_unregister(struct regulator_dev *rdev);
+void regulator_sync_state(struct device *dev);
 void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev);
 
 int regulator_notifier_call_chain(struct regulator_dev *rdev,
-- 
2.28.0.rc0.105.gf9edc3c819-goog

