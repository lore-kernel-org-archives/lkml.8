Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68028C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40907206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JLVkzSnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406169AbgE1TGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406108AbgE1TGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:06:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B249C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:06:20 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j16so431182qka.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nk4V/T2WhSqisMKpR6MbF5dPBR0KcgOmd15SGX/wlO0=;
        b=JLVkzSnBQeFfiU4HMxv2UU7dVNEsSseqCIfqaJ/FGYw8YGXZRzoSTEVqh9P4Eg7m6u
         m6vmbdnAj/ICBDrJyJxEBo/k/cei/wWNxOFY0kv2s1d6cqv2MlBVkqIPBlyMzixQdsBf
         1x/2du5x5G81JQigrpGLIzHfqC4G4dtsH3LLGo51hbHj4NvMmYn2hMygpt7+v6muTm0U
         WVpofsmH3BI/BxWfALQWuXi6D1ef+h8lKhOsu6u6ZONIz8FQ2Qb0Vgt+p/Mg58tfOs9C
         NYLPgpHwyrVxBrFRQMBSizOT2S2BMM9F/hJzQ0JwiV5PsDcM0TvdT8Y0Ml/15rM7tpoa
         NcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nk4V/T2WhSqisMKpR6MbF5dPBR0KcgOmd15SGX/wlO0=;
        b=T7ORSf50uE2rDXILBRpvmgMp+GpAvAWXWvFiVT6s6ip+NTiP72BVCKpIGGrvjPJkKO
         92tXuJ0ZHJPRAzXfVBVHryRjpnIzpMJiPF2xxnIPLbZ9+QhxHI8M80uhKhsKuXSKYnOh
         YP44n0odipCJtQuh3CqTYi76nCOLTRY9qkjEYs+E1/AkPWDkd2AAw2M9ED5KS9GbHsJa
         byIJX+EzmDBALZZmM6QzKiGHJXTr0EO5387m1PLIEYLK93nRLe4i4vaO/kYlosBgKht+
         WIwLUvpc60PYXocqtDzsg6XvKd7Kgo1oHThr0VcT5+RN4Hs5jz/3K4KDCFNlgww6VKeK
         Et+w==
X-Gm-Message-State: AOAM533bAxyBf+aeECwprdh2PWUzHRtP14MoPJJa8JPt4jgriT1UMhlm
        4ylJii3IAjwqXnJhjrXxB7JrbiJ2AiCFEaM=
X-Google-Smtp-Source: ABdhPJxEUmqGxG8EHZtk/G2DXP+JxDtrizpejC3dsjsX4BgIDCIkC2e/Jl9c1iK8F3phcNeDnFzlPGY75ajQuM4=
X-Received: by 2002:ad4:45a7:: with SMTP id y7mr4653027qvu.184.1590692779025;
 Thu, 28 May 2020 12:06:19 -0700 (PDT)
Date:   Thu, 28 May 2020 12:06:10 -0700
In-Reply-To: <20200528190610.179984-1-saravanak@google.com>
Message-Id: <20200528190610.179984-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200528190610.179984-1-saravanak@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 2/2] regulator: Add support for sync_state() callbacks
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a regulator is left on by the bootloader or anything else before
the kernel starts (let's call this a "boot on" regulator), we need to
keep it on till all the consumers of the regulator have probed. This is
especially important for regulators that might be powering more than one
consumer. Otherwise, when the first consumer probes, enables and then
disables the "boot on" regulator, it'd turn off the power to rest of the
consumers of the "boot on" regulator.

Also, if a regulator driver is loaded as a module and the regulator
device has a few "boot on" regulators, we still want them to be turned
off after all the consumers have probed (if none of them have requested
for those regulators to stay on).

The sync_state() callback that's been added to drivers is meant for
situations like this. It gets called when all the consumers of a device
have probed successfully. To ease the transition to sync_state()
callbacks, it is never called before late_initcall_sync().

sync_state() callbacks become even more useful when combined with
fw_devlink.  If fw_devlink is off, sync_state() is called at
late_initcall_sync() or the regulator device probing successfully --
whichever is later. This is because, with fw_devlink off, there would be
no consumers to the regulator device when it probes.

If fw_devlink is not off (it's permissive by default now), then
sync_state() is called when all the consumers of the regulator device
have probed or at late_initcall_sync() -- whichever is later.

This commit adds a regulator_sync_state() helper function that takes
care of all the "boot on" regulator clean up for any regulator driver.
All one needs to do is add the following line to the driver struct.

.sync_state = regulator_sync_state,

Once that's done, then for any device that's probed by the driver, all
the "boot on" regulators supplied by the device will be kept on till all
the consumers of the device have probed. Once the consumers have probed,
the "boot on" regulators would be allowed to turn off if they are voted
on by any of the consumers.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/regulator/core.c         | 112 +++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |   2 +
 2 files changed, 114 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 941783a14b45..913d387541d6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1768,6 +1768,88 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+static void regulator_set_minimum_state(struct regulator_dev *rdev)
+{
+	struct device *dev = rdev->dev.parent;
+	struct regulation_constraints *c = rdev->constraints;
+
+	/*
+	 * The device doesn't have sync_state() support, or we already took
+	 * care of it.
+	 */
+	if (!dev_has_sync_state(dev) || rdev->sync_supply)
+		return;
+
+	/*
+	 * Wait for parent supply to be ready before trying to keep this
+	 * regulator on.
+	 */
+	if (rdev->supply_name && !rdev->supply)
+		return;
+
+	if (c && c->always_on)
+		return;
+
+	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS))
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
+	/*
+	 * Get a regulator client handle to make requests on the regulator in
+	 * way that'll prevent it from going below the state in which the boot
+	 * loader left it in.
+	 */
+	rdev->sync_supply = create_regulator(rdev, NULL, "SYNC-SUPPLY");
+
+	/*
+	 * At this point, we shouldn't have trouble getting a regulator. If we
+	 * do, give up.
+	 */
+	if (rdev->sync_supply == NULL) {
+		dev_err(&rdev->dev, "Unable to make votes on the regulator\n");
+		rdev->sync_supply = ERR_PTR(-EINVAL);
+		return;
+	}
+	rdev->open_count++;
+
+	/* If we can't put a vote to keep the regulator enabled, we give up. */
+	if (regulator_enable(rdev->sync_supply)) {
+		dev_err(&rdev->dev, "Unable to keep the regulator on\n");
+		regulator_put(rdev->sync_supply);
+		rdev->sync_supply = ERR_PTR(-EINVAL);
+	}
+}
+
+static int regulator_rel_minimum_state(struct device *dev, void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+
+	if (dev->parent != data)
+		return 0;
+
+	if (IS_ERR_OR_NULL(rdev->sync_supply))
+		return 0;
+
+	regulator_disable(rdev->sync_supply);
+	regulator_put(rdev->sync_supply);
+	rdev->sync_supply = NULL;
+	return 0;
+}
+
+void regulator_sync_state(struct device *dev)
+{
+	class_for_each_device(&regulator_class, NULL, dev,
+			      regulator_rel_minimum_state);
+}
+EXPORT_SYMBOL_GPL(regulator_sync_state);
+
 static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
@@ -1826,6 +1908,8 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		return ret;
 	}
 
+	regulator_set_minimum_state(rdev);
+
 	/*
 	 * In set_machine_constraints() we may have turned this regulator on
 	 * but we couldn't propagate to the supply if it hadn't been resolved
@@ -5188,6 +5272,15 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	    !rdev->desc->fixed_uV)
 		rdev->is_switch = true;
 
+	/*
+	 * I'm not too enthusiastic about this. I'd rather just go set
+	 * .sync_state() in all the regulator drivers. But let's get the rest
+	 * of the patch sorted out first.
+	 */
+	if (dev_set_drv_sync_state(rdev->dev.parent, regulator_sync_state))
+		dev_dbg(&rdev->dev, "parent sync_state() already set\n");
+	regulator_set_minimum_state(rdev);
+
 	dev_set_drvdata(&rdev->dev, rdev);
 	ret = device_register(&rdev->dev);
 	if (ret != 0) {
@@ -5729,6 +5822,15 @@ static int regulator_late_cleanup(struct device *dev, void *data)
 	return 0;
 }
 
+static int regulator_minimum_state_cleanup(struct device *dev, void *data)
+{
+	regulator_rel_minimum_state(dev, dev->parent);
+	return 0;
+}
+
+static unsigned int regulator_cleanup_timeout = 30000;
+core_param(regulator_cleanup_timeout, regulator_cleanup_timeout, uint, 0);
+
 static void regulator_init_complete_work_function(struct work_struct *work)
 {
 	/*
@@ -5741,6 +5843,16 @@ static void regulator_init_complete_work_function(struct work_struct *work)
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
+				      regulator_minimum_state_cleanup);
+
 	/* If we have a full configuration then disable any regulators
 	 * we have permission to change the status for and which are
 	 * not in use or always_on.  This is effectively the default
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 7eb9fea8e482..2e2208e7b771 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -451,6 +451,7 @@ struct regulator_dev {
 	struct regulator *supply;	/* for tree */
 	const char *supply_name;
 	struct regmap *regmap;
+	struct regulator *sync_supply;
 
 	struct delayed_work disable_work;
 
@@ -475,6 +476,7 @@ devm_regulator_register(struct device *dev,
 			const struct regulator_desc *regulator_desc,
 			const struct regulator_config *config);
 void regulator_unregister(struct regulator_dev *rdev);
+void regulator_sync_state(struct device *dev);
 void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev);
 
 int regulator_notifier_call_chain(struct regulator_dev *rdev,
-- 
2.27.0.rc0.183.gde8f92d652-goog

