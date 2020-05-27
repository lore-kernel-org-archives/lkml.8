Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D4FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98EE207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5bYfLWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbgE0HlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387487AbgE0HlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:41:12 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A586C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 00:41:12 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p5so17983790qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4ZgeB2AItrP9nS2Fq643R0Cpp2i+TEvZPbSBjX/I4FQ=;
        b=h5bYfLWCLeXxVWptwcOnDYOOm4U6jo/JL6rx3b7UJpapgzSxe1G/H2zDmA6C2zuwLI
         g/s3NTI82JvAROQ5OAQKbJrNSOzEPLsLjfSn+KEif+dEZOPRsnUzOst2hx5VTMCBvELQ
         0kLwFAHpuSZKym0H/GV8f8aSp6+eWE/7rIFxmmMGiAmjlRUpADuqKLdVZnHA27tv32VD
         aqbWkqUtB/2S20bSPMNV6MnFFbbvW7x1c6tjQndTS3XMIGzh4+C8PomUbEGF2epZgWc6
         XEyAbjVp3zLUd3aYRH6EFTJ+T9sIvtn8bIAIJrha/1vrlwUVkREqqAXiq2cvGOLF1mev
         7m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4ZgeB2AItrP9nS2Fq643R0Cpp2i+TEvZPbSBjX/I4FQ=;
        b=ooXnBABknAp/d6k2G9izjtq2XqttxgB+r19y8B1kN5ficfYWWxVuETl+2ppf/M7h5s
         soAZZEcGejPA4YrIwET2I7XX18mz4wrHjGp4d2RwVa9Nc64lh+L1kfoyeQ8AKBPVaxel
         JxWwpjhck7+Ip8vESzOnpHyiO9WEwRvr0zLXOJgpmRFRxBMSVjYEULL4roGIY8L0hnsy
         /1YdLlXbhEQQjGHXRuH48YNcfo3u+ymdaWlbKE4ap8h9jGFviG1Cx6EPyuDYle6Znlhw
         o8kazZAbL2stHHjb1lMO/RQgwShMjqHnlOeCaXheLncYCRlyS2csbi/mDepmiFT5QXnX
         p7sQ==
X-Gm-Message-State: AOAM532/zJPuJ48Oinr2yH3aV52+DfhszX7UWlhWqf0/YDL4akS+fZic
        DzmMG197aJnyyUNss2HpbGQNadqz7m0aM0Q=
X-Google-Smtp-Source: ABdhPJx3zH/Wsq+hDNYznjjmEJs1ire+kKNL/Cg4Wj6Dw9OQfXFEGZQgFi+jMYcI2m8XtPWxlCXF/rtEXy4T+xQ=
X-Received: by 2002:ad4:43e3:: with SMTP id f3mr23491167qvu.115.1590565270119;
 Wed, 27 May 2020 00:41:10 -0700 (PDT)
Date:   Wed, 27 May 2020 00:40:56 -0700
Message-Id: <20200527074057.246606-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v1] regulator: Add support for sync_state() callbacks
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
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
Mark,

This is just a first cut RFC of how I think this could be handled.  I've
implemented it based on my limited understanding of the regulator
framework. So, I wouldn't be surprised if I've missed out on some corner
(or not so corner) cases. But if you point out the issues, I'd be happy
to try and address them.

Ideally, we can just do this for all the regulators, but we can start
with an "opt-in" scheme where the older behavior is still preserved if a
driver doesn't opt in. I'd also like to remove the arbitrary time out
that we use today, but that's a super long term goal because I know you
have some use cases which might have time limits (and maybe, we'll just
end up with only those drivers opting out of this scheme and sticking
with timeouts).

Also, with what I understand of the regulator code, I think we might be
able to replace/drop the "supply enable propagation" code with a few
tweaks to my patch. But I didn't want to do them in this patch.

I've tested this patch on simple on/off regulators in real hardware with
their drivers compiled as modules and it seems to work correctly. So it
at least works on some level.

Let me know what you think.

Thanks,
Saravana

 drivers/regulator/core.c         | 64 ++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  2 +
 2 files changed, 66 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 941783a14b45..373704b9014e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1768,6 +1768,66 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+static void regulator_hold_state(struct regulator_dev *rdev)
+{
+	struct device *dev = rdev->dev.parent;
+	struct regulation_constraints *c = rdev->constraints;
+
+	if (!dev_has_sync_state(dev) || rdev->sync_supply)
+		return;
+
+	if (rdev->supply_name && !rdev->supply)
+		return;
+
+	if (c && c->always_on)
+		return;
+
+	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS))
+		return;
+
+	if (_regulator_is_enabled(rdev) <= 0)
+		return;
+
+	rdev->sync_supply = create_regulator(rdev, NULL, "SYNC-SUPPLY");
+	/*
+	 * At this point, we shouldn't have trouble getting a regulator. If we
+	 * do, give up.
+	 */
+	if (rdev->sync_supply == NULL) {
+		rdev->sync_supply = ERR_PTR(-EINVAL);
+		return;
+	}
+	rdev->open_count++;
+
+	if (regulator_enable(rdev->sync_supply)) {
+		regulator_put(rdev->sync_supply);
+		rdev->sync_supply = ERR_PTR(-EINVAL);
+	}
+}
+
+static int regulator_sync_state_release(struct device *dev, void *data)
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
+			      regulator_sync_state_release);
+}
+EXPORT_SYMBOL_GPL(regulator_sync_state);
+
 static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
@@ -1826,6 +1886,8 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		return ret;
 	}
 
+	regulator_hold_state(rdev);
+
 	/*
 	 * In set_machine_constraints() we may have turned this regulator on
 	 * but we couldn't propagate to the supply if it hadn't been resolved
@@ -5188,6 +5250,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	    !rdev->desc->fixed_uV)
 		rdev->is_switch = true;
 
+	regulator_hold_state(rdev);
+
 	dev_set_drvdata(&rdev->dev, rdev);
 	ret = device_register(&rdev->dev);
 	if (ret != 0) {
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

