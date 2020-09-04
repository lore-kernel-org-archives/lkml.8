Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D017BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D372074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Pph0ChKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgIDPrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgIDPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:47:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF73C061238
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so7155735wrn.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RT9K0p4g9wsam9mtLvU8jWCbdg1QlHE5npCSk6GRJVM=;
        b=Pph0ChKqHgqs9PaK7532rJDYq8CCuzL49IHbUNNh8wkzPBANz7SFZRVpe8XZ6089Dv
         w6hesKYtcpQT4Xn0LXDDkAAwnHY8SkZfl97hmrjQg1ejNa/IDYgWLvxD72t0bCCu1ihU
         Kia91DKj1cbhCQ054PEtqNZgjWU4xEvuzZbzThXH6fhadPW3xJHoOT4GOeXDsdpt4B6Q
         w8yhwq243s79jSf7dIZgRnGMtn09vLqHQF/2Gw1s+Xxbhg4FS7Q6bC3r5oFPgFrePT8H
         Rkc0q0bYUHSe+Yf2WE7b+liCRpH0L24hIZ43cjEjsbBKorpi1qb4JDcLyq2SkhHPkXug
         aKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RT9K0p4g9wsam9mtLvU8jWCbdg1QlHE5npCSk6GRJVM=;
        b=oRoixEkJy296lvyoly1sJ0stP+rubysmLWT37Oq1YtGCozkFtZphrkC9aYKEQonG3T
         2J89HPRs9lpHBxnFSwgl5Ra4zZ1ARqeG/jnZ5ZL1taQMPM2CKMNTwjsNNPn0u1ASwtBE
         OcqnNza9nTv44K6l97SHfFMeiJTl1z0CCgQj7yVFN2heuJmyakBHJLkqC40RhCLQhx0L
         mSJezVw7xm7T3AN7rCqFqEaz+3Ou6FksVY7HMNJCbOrMcYwLJFUgV1oCEn97xcL1dAJU
         FZkpAQLPWVfRpSyyul+qU+SSRUfXpwGKR4uSyO9SyAn2TzPi8ff5b8PJtRhr42HqaQlO
         9ibw==
X-Gm-Message-State: AOAM531ytK9yQqQ6cJBCf3dEG/wYr9biniEj8lBlmUKaofHYg/iKGjRg
        ByWE3AGyPtVCPSvPyzHonrw7bQ==
X-Google-Smtp-Source: ABdhPJzwm1LPWjidY+W2eWt031GEhqfqEZ4XCSVhfjqUt9KC+wqwPvwzW1Xvz1lIpyZuwTS8CeLJLw==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr8315397wre.361.1599234413434;
        Fri, 04 Sep 2020 08:46:53 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 19/23] gpio: mockup: add a symlink for the per-chip debugfs directory
Date:   Fri,  4 Sep 2020 17:45:43 +0200
Message-Id: <20200904154547.3836-20-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We used to have a symlink named after the chip's label linking to the
per-chip directory named after the chip's name. This was removed by
commit d51ee07a8de7 ("gpio: mockup: don't create the debugfs link named
after the label") because there were no users of it.

This changeset proposes to reintroduce debugfs symlinks but inverted:
the link named after the device name points to the directory named after
the label. This way user-space can dynamically create a chip (once that
functionality is available), detect its creation over uevent and match
the device name to the label by resolving the link.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 7df990662c17..bc4609e047ef 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -52,6 +52,7 @@ struct gpio_mockup_chip {
 	struct gpio_mockup_line_status *lines;
 	struct irq_domain *irq_sim_domain;
 	struct dentry *dbg_dir;
+	struct dentry *dbg_link;
 	struct mutex lock;
 };
 
@@ -355,6 +356,13 @@ static void gpio_mockup_remove_chip_debugfs_entry(void *data)
 	debugfs_remove_recursive(entry);
 }
 
+static void gpio_mockup_remove_chip_debugfs_link(void *data)
+{
+	struct dentry *link = data;
+
+	debugfs_remove(link);
+}
+
 static int gpio_mockup_debugfs_setup(struct device *dev,
 				     struct gpio_mockup_chip *chip)
 {
@@ -368,7 +376,7 @@ static int gpio_mockup_debugfs_setup(struct device *dev,
 	gc = &chip->gc;
 	devname = dev_name(&gc->gpiodev->dev);
 
-	chip->dbg_dir = debugfs_create_dir(devname, gpio_mockup_dbg_dir);
+	chip->dbg_dir = debugfs_create_dir(gc->label, gpio_mockup_dbg_dir);
 	if (IS_ERR(chip->dbg_dir))
 		return PTR_ERR(chip->dbg_dir);
 
@@ -377,6 +385,16 @@ static int gpio_mockup_debugfs_setup(struct device *dev,
 	if (ret)
 		return ret;
 
+	chip->dbg_link = debugfs_create_symlink(devname, gpio_mockup_dbg_dir,
+						gc->label);
+	if (IS_ERR(chip->dbg_link))
+		return PTR_ERR(chip->dbg_link);
+
+	ret = devm_add_action_or_reset(dev,
+			gpio_mockup_remove_chip_debugfs_link, chip->dbg_link);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < gc->ngpio; i++) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", i);
 		if (!name)
-- 
2.26.1

