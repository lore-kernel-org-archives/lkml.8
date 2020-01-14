Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7ADC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEAE2467A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L02tMrWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgANXLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:11:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39123 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgANXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:11:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so5865637plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 15:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CS2jApvFb3S3JDzvv3Eoi/FOtO442LOnLZxI8A+XLvU=;
        b=L02tMrWZj0xaO61Jny+KX0dMMUNf/Qi1ZERiYigEZzD76rIz/gjTNOLKviF/9STrA3
         dXJhrhdJ3Ss0R2DI3f/gFnS0EjQNtVIgSKDw8ncpqqQbakkyvMntRS77GWcLfOzr3tBi
         8P7+TwI6GkNhqGefgxqgGyQZhYTyBT6ZDyE0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CS2jApvFb3S3JDzvv3Eoi/FOtO442LOnLZxI8A+XLvU=;
        b=rjTgBxTNKf7mfp9kNRdGtdDV2NucVJz5iARKaG1kJO7C6VI8bk87YJICQU9/2hb8QC
         we4AvbIrFEZGabII3UT3xJ/TctlVqoFq4HwZ2YRjwzelBr/84Fn8kEoM8+/3D2xu538U
         h2GiEb8pD6QbEmLnj7JNqC1xKru1pZXZLr0dQAQwKDuUrxhKfcclAutT9WoGL9YkedxH
         yxB7g+CFEfPawLLBs/XsS22t+StaoNMdUOIQA9ZILX2n7GIkQ2j1mOwgeYw+PGuA75zM
         N8+BOlfB7TQm4YLYjFfdqw12tOs0HBhN770iLySlTjR+KKiMtEdydbkvJD8nblmUNsGE
         iClw==
X-Gm-Message-State: APjAAAUeY3qrO/CKckn3RXSUzJs0y35O31w9r6qp37mo9qeMnExSoc+3
        RQfV54rshiZValrSlFljyrt/vQ==
X-Google-Smtp-Source: APXvYqynG6l761uuqSHEb49BAp2s5XUbDF125f8m/zx3CsoIimwVjlhfUtEyMjC6RefIdJ8xyoPSIg==
X-Received: by 2002:a17:90a:31cc:: with SMTP id j12mr31131379pjf.103.1579043465324;
        Tue, 14 Jan 2020 15:11:05 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z19sm18707231pfn.49.2020.01.14.15.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:11:04 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Brian Masney <masneyb@onstation.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH] gpiolib: Set lockdep class for hierarchical irq domains
Date:   Tue, 14 Jan 2020 15:11:03 -0800
Message-Id: <20200114231103.85641-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see the following lockdep splat in the qcom pinctrl driver when
attempting to suspend the device.

 ============================================
 WARNING: possible recursive locking detected
 5.4.2 #2 Tainted: G S
 --------------------------------------------
 cat/6536 is trying to acquire lock:
 ffffff814787ccc0 (&irq_desc_lock_class){-.-.}, at: __irq_get_desc_lock+0x64/0x94

 but task is already holding lock:
 ffffff81436740c0 (&irq_desc_lock_class){-.-.}, at: __irq_get_desc_lock+0x64/0x94

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&irq_desc_lock_class);
   lock(&irq_desc_lock_class);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 7 locks held by cat/6536:
  #0: ffffff8140e0c420 (sb_writers#7){.+.+}, at: vfs_write+0xc8/0x19c
  #1: ffffff8121eec480 (&of->mutex){+.+.}, at: kernfs_fop_write+0x128/0x1f4
  #2: ffffff8147cad668 (kn->count#263){.+.+}, at: kernfs_fop_write+0x130/0x1f4
  #3: ffffffd011446000 (system_transition_mutex){+.+.}, at: pm_suspend+0x108/0x354
  #4: ffffff814302b970 (&dev->mutex){....}, at: __device_suspend+0x16c/0x420
  #5: ffffff81436740c0 (&irq_desc_lock_class){-.-.}, at: __irq_get_desc_lock+0x64/0x94
  #6: ffffff81479b8c10 (&pctrl->lock){....}, at: msm_gpio_irq_set_wake+0x48/0x7c

 stack backtrace:
 CPU: 4 PID: 6536 Comm: cat Tainted: G S                5.4.2 #2
 Call trace:
  dump_backtrace+0x0/0x174
  show_stack+0x20/0x2c
  dump_stack+0xdc/0x144
  __lock_acquire+0x52c/0x2268
  lock_acquire+0x1dc/0x220
  _raw_spin_lock_irqsave+0x64/0x80
  __irq_get_desc_lock+0x64/0x94
  irq_set_irq_wake+0x40/0x144
  msm_gpio_irq_set_wake+0x5c/0x7c
  set_irq_wake_real+0x40/0x5c
  irq_set_irq_wake+0x70/0x144
  cros_ec_rtc_suspend+0x38/0x4c
  platform_pm_suspend+0x34/0x60
  dpm_run_callback+0x64/0xcc
  __device_suspend+0x314/0x420
  dpm_suspend+0xf8/0x298
  dpm_suspend_start+0x84/0xb4
  suspend_devices_and_enter+0xbc/0x628
  pm_suspend+0x214/0x354
  state_store+0xb0/0x108
  kobj_attr_store+0x14/0x24
  sysfs_kf_write+0x4c/0x64
  kernfs_fop_write+0x158/0x1f4
  __vfs_write+0x54/0x18c
  vfs_write+0xdc/0x19c
  ksys_write+0x7c/0xe4
  __arm64_sys_write+0x20/0x2c
  el0_svc_common+0xa8/0x160
  el0_svc_compat_handler+0x2c/0x38
  el0_svc_compat+0x8/0x10

This is because the msm_gpio_irq_set_wake() function calls
irq_set_irq_wake() as a backup in case the irq comes in during the path
to idle. Given that we're calling irqchip functions from within an
irqchip we need to set the lockdep class to be different for this child
controller vs. the default one that the parent irqchip gets.

This used to be done before this driver was converted to hierarchical
irq domains in commit e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in
hierarchy") via the gpiochip_irq_map() function. With hierarchical irq
domains this function has been replaced by
gpiochip_hierarchy_irq_domain_alloc(). Therefore, set the lockdep class
like was done previously in the irq domain path so we can avoid this
lockdep warning.

Fixes: fdd61a013a24 ("gpio: Add support for hierarchical IRQ domains")
Cc: Thierry Reding <treding@nvidia.com>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpio/gpiolib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 967371377a9d..dcdbdddb3396 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2040,6 +2040,7 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 				     parent_type);
 	chip_info(gc, "alloc_irqs_parent for %d parent hwirq %d\n",
 		  irq, parent_hwirq);
+	irq_set_lockdep_class(irq, gc->irq.lock_key, gc->irq.request_key);
 	ret = irq_domain_alloc_irqs_parent(d, irq, 1, &parent_fwspec);
 	if (ret)
 		chip_err(gc,
-- 
Sent by a computer, using git, on the internet

