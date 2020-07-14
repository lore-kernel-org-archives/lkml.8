Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C94C43457
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB1F21D6C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yr1SJcM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgGNOvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbgGNOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:50:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9361C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:50:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so22197579wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sa7IFFvEjkUEYkKGNfZ4AaOfAhDNPotc0mtcZbr7pMU=;
        b=Yr1SJcM2AwK2hW8wKdiFtlaK6rKbZ3NlkGx8d1Od6cqVH4nDmmoGCDQVhLHIDws+3d
         2OVvC3aJXzU/ZjRq+haMRmCsqS9W94aOftUL13uUTXk4ZnJIiwTbqrjSFcSQ6+MBToTA
         Wlf9HuAi0Aza+9dtw/LHZF7rOTCDvLKrgawrfm5e6w/OV2eflKYPT6fW2ypIM7ewVmNc
         6sZcE8UtKJDkeu8wqVxcoXJajhBkeReoa/7FhnEB2BS2H5Z5vYRvhfarz4C2XXTsWwBv
         aBmWOuw/i4Vdi3oCKJV1Zdhv/857tPWI3NzjMDJuHyaPTGpybciaeB3NKBD0sTczkWGs
         so9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sa7IFFvEjkUEYkKGNfZ4AaOfAhDNPotc0mtcZbr7pMU=;
        b=Ww/y2pmvBxIGO2YOYTGzIPoSR7RXp0hrRpPh3ywuvdrmWjeGM0oBB5VdR83JnkDQNx
         wil8pgDvDdUlvwrPE63OyXDLfUGw298OhohUVBUp1o5C8kyQI9KHC/0/cxJTXKh5/UHq
         y7E3xEaxukjnGkZA7+l8+OCiGLF6QhmzmBr0v/KEQwFFs5vganAF7Aisq08wXL2NV7dW
         X7HQCluRyh5oey7pIbx+ko9KRPyJyqNHY2kY+ocTlscgMWv/m9Fsof4gZYlXjBd0bLcM
         CAR4vYFg72rMhHLaaFjjEl1+dWHyD4qkszx4yuwNX//KBicmjPpAqyQHgAhEvWnoaVd8
         J9XQ==
X-Gm-Message-State: AOAM5339UZpyS/zIouNMFFNJm/XmfxqkqOJqf2412Yd7p5KQT1zm62Z+
        X7aX+I9Z2NnEhcVj24zxTUmJhyynfR0=
X-Google-Smtp-Source: ABdhPJzNf9Z+WHkT0D9c7/YKzZVAjpjagqUFxoxaf/blhTxuH25LgfvUKpph8N2tIaWR9WV7qZZ8hg==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr6084464wrc.218.1594738257584;
        Tue, 14 Jul 2020 07:50:57 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:50:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to shared header
Date:   Tue, 14 Jul 2020 15:50:41 +0100
Message-Id: <20200714145049.2496163-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If function callers and providers do not share the same prototypes the
compiler complains of missing prototypes.  Fix this by moving the
already existing prototypes out to a mutually convenient location.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototype for ‘check_astate’ [-Wmissing-prototypes]
 109 | int check_astate(void)
 | ^~~~~~~~~~~~
 drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototype for ‘restore_astate’ [-Wmissing-prototypes]
 114 | void restore_astate(int cpu)
 | ^~~~~~~~~~~~~~

Cc: Olof Johansson <olof@lixom.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/powerpc/platforms/pasemi/pasemi.h    | 15 ------------
 arch/powerpc/platforms/pasemi/powersave.S |  2 ++
 drivers/cpufreq/pasemi-cpufreq.c          |  1 +
 include/linux/platform_data/pasemi.h      | 28 +++++++++++++++++++++++
 4 files changed, 31 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/platform_data/pasemi.h

diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index 70b56048ed1be..528d81ef748ad 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -15,21 +15,6 @@ extern void __init pasemi_map_registers(void);
 extern void idle_spin(void);
 extern void idle_doze(void);
 
-/* Restore astate to last set */
-#ifdef CONFIG_PPC_PASEMI_CPUFREQ
-extern int check_astate(void);
-extern void restore_astate(int cpu);
-#else
-static inline int check_astate(void)
-{
-	/* Always return >0 so we never power save */
-	return 1;
-}
-static inline void restore_astate(int cpu)
-{
-}
-#endif
-
 extern struct pci_controller_ops pasemi_pci_controller_ops;
 
 #endif /* _PASEMI_PASEMI_H */
diff --git a/arch/powerpc/platforms/pasemi/powersave.S b/arch/powerpc/platforms/pasemi/powersave.S
index d0215d5329ca7..7747b48963286 100644
--- a/arch/powerpc/platforms/pasemi/powersave.S
+++ b/arch/powerpc/platforms/pasemi/powersave.S
@@ -5,6 +5,8 @@
  * Maintained by: Olof Johansson <olof@lixom.net>
  */
 
+#include <linux/platform_data/pasemi.h>
+
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/ppc_asm.h>
diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index c66f566a854cb..c6bb3ecc90ef3 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -15,6 +15,7 @@
 #include <linux/timer.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/platform_data/pasemi.h>
 
 #include <asm/hw_irq.h>
 #include <asm/io.h>
diff --git a/include/linux/platform_data/pasemi.h b/include/linux/platform_data/pasemi.h
new file mode 100644
index 0000000000000..3fed0687fcc9a
--- /dev/null
+++ b/include/linux/platform_data/pasemi.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Linaro Ltd.
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ */
+
+#ifndef _LINUX_PLATFORM_DATA_PASEMI_H
+#define _LINUX_PLATFORM_DATA_PASEMI_H
+
+/* Restore astate to last set */
+#ifdef CONFIG_PPC_PASEMI_CPUFREQ
+int check_astate(void);
+void restore_astate(int cpu);
+#else
+static inline int check_astate(void)
+{
+	/* Always return >0 so we never power save */
+	return 1;
+}
+static inline void restore_astate(int cpu)
+{
+}
+#endif
+
+#endif /* _LINUX_PLATFORM_DATA_PASEMI_H */
+
+
-- 
2.25.1

