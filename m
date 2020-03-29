Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4C7C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504AD20774
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncVvgdou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgC2WHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:07:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgC2WHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 18:07:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id m11so13052629wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1LHaTJUSb6YlKNJo8uEXGOXHLnntD8wG0lKLYJJal8o=;
        b=ncVvgdoulw7o7+hBR1P2C+5Gs5JoBGlqRw0Sy1xicTm6q81nvOAS+m7a5UAWRL9hRH
         yEbh65k8Qx8xlZhH0t43wKusHLa9vKtTn3P+o7chr1k8b9HOg212dwNDe5UIqqTkPvM5
         NjK59RhAv/AjjS9C+ePeOxUTr8KWfjEGW0BnrhZMLZGYwJHih6Qa7NlJ/q3h/TBv2CvI
         qzt8o6Axgo5Rp3OXRAuFzRgZOB7AaPhJpa0QD51Rx0V4DJiIolUALmRUp3al9xzVNBGD
         TgMdtaHIkMZxLrKJPW3dDuRzt6b6bi9q5B+CInP1E93ReaqlZkh762PlTAokY1xMgBP/
         HxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1LHaTJUSb6YlKNJo8uEXGOXHLnntD8wG0lKLYJJal8o=;
        b=Dy0BnKZ026E9BIhvzy9ueopaZGFrjOF60mSEKIOaW+YUvhv2gIs99AlWGOWJ3s1PfH
         EqXmLJ7W5B0kGuec9ddNLIE0TRHNR3pqfo42i5Q6rGb3E/sU9UHV/XBDjiC+N5vwShkV
         a1HChE2M100rZ1+xQevR2F7Dp/tO5bQHfUOcg2arKLXuDbgqvzmOzV8jTjddata5Gqfj
         V4AcEiS1u3S/0lVugPJELwUGefW2blmirslGctLAqG3WzUQ2PDaHn0mzEK+CiJUv7pCc
         7YRfqz14piA7PANjNR2SUXqfgC17EbVyihrw54ZhhWLymg4skVIQxFbzE8zmmvItiF36
         LZKw==
X-Gm-Message-State: ANhLgQ0xGtp/d3CRRL4PkU5gde7CZxQE2GpU0FXza/Q2DVVGdUZ4aVk2
        Vq62Nu2mMZOyhlBr0nnS451WHQ==
X-Google-Smtp-Source: ADFU+vuZAg1AC05bxtW27+WzlliBGq0FOpLpXh2o2GNXEgxWNashf38ZSEyqqKofOBjuURsc40gIDw==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr11842551wrt.92.1585519639340;
        Sun, 29 Mar 2020 15:07:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:78b1:4459:6959:42d0])
        by smtp.gmail.com with ESMTPSA id j188sm20026740wmj.36.2020.03.29.15.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 15:07:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, robh@kernel.org
Cc:     daniel.lezcano@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-pm@vger.kernel.org (open list:CPU IDLE TIME MANAGEMENT FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (open list:CPUIDLE DRIVER - ARM
        PSCI)
Subject: [PATCH 4/4] thermal: cpuidle: Register cpuidle cooling device
Date:   Mon, 30 Mar 2020 00:03:20 +0200
Message-Id: <20200329220324.8785-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329220324.8785-1-daniel.lezcano@linaro.org>
References: <20200329220324.8785-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuidle driver can be used as a cooling device by injecting idle
cycles. The DT binding for the idle state added an optional

When the property is set, register the cpuidle driver with the idle
state node pointer as a cooling device. The thermal framework will do
the association automatically with the thermal zone via the
cooling-device defined in the device tree cooling-maps section.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c  | 5 +++++
 drivers/cpuidle/cpuidle-psci.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 9e5156d39627..2406ac0ae134 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -124,6 +125,10 @@ static int __init arm_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	ret = cpuidle_cooling_register(drv);
+	if (ret)
+		pr_err("Failed to register the idle cooling device: %d\n", ret);
+
 	return 0;
 
 out_kfree_drv:
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index edd7a54ef0d3..8e805bff646f 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "CPUidle PSCI: " fmt
 
 #include <linux/cpuhotplug.h>
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -305,6 +306,10 @@ static int __init psci_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	ret = cpuidle_cooling_register(drv);
+	if (ret)
+		pr_err("Failed to register the idle cooling device: %d\n", ret);
+
 	return 0;
 
 out_kfree_drv:
-- 
2.17.1

