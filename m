Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48287C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2CC20708
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BdIE51BM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbgIHQeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732036AbgIHQc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:32:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BE9C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 09:32:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so11407462pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=D+6OKvAnkUtzzW2cGDkKOGH7rrKsaKBarDqPQyHhqbY=;
        b=BdIE51BMbD2vJPVe5LWf9jcMVph9ArF3q5hwypOuhEoStuB4LfOeegz+pdZT9WDnvZ
         cU/VWPGrrEhR6rSHH8usFXpyne27RVDIe99CaJmtzJgMELgiHBZKACItfGUg35zziM3Y
         mO9ONKxuAfaqEDw88bCqSZOJEHamIcH0lVx0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D+6OKvAnkUtzzW2cGDkKOGH7rrKsaKBarDqPQyHhqbY=;
        b=Dzz2FtkPLj2pMMf2/YS7shxlI0r+GWBLqT26ISmYim+/BzT7VwNxM27M2BzxdvKMo6
         VDuks+ZBR+jfsVJVstnyk9JDtlaWeP645+rUUgC08rA3N7gWJLArk/xiE58JBCLuOzgP
         iwVX4fAqcO0tP8OVp0NNojphkvP7lLTGk0SLhSUqG714eurnqTWQTjBrTQi5yeXirGLg
         4prp+3oS6xX1hdHmLW7kxMlfx1mlygDAR9KKpqCmrs0IIY6kentXooVzwKoh1aHUUwAk
         jk1AIGfewFVectqhzI/k5LLTozrAvnpI6fnP/mf8vwXmwMCy4EVVnV/zZELg1LSoeHxJ
         76Wg==
X-Gm-Message-State: AOAM532ZzbMDjMIZtJOLuQ0QZrJoDNirOkxyfiwBcYrZ1KdZ2QJZ6rwU
        QKg1WDKv9UOVj5qPAQSbssDtoA==
X-Google-Smtp-Source: ABdhPJy/MwLs61JfBGoh37V+yP2UwAlE3gV9saHhDANE/meQtBZQtzbPVViRwvgkDgq95jo5/4KEow==
X-Received: by 2002:a63:d216:: with SMTP id a22mr11107158pgg.339.1599582775184;
        Tue, 08 Sep 2020 09:32:55 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b24sm15079186pjp.22.2020.09.08.09.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:32:54 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        james.quinlan@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v1] PCI: pcie_bus_config can be set at build time
Date:   Tue,  8 Sep 2020 12:32:48 -0400
Message-Id: <20200908163248.14330-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig is modified so that the pcie_bus_config setting can be done at
build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
pci_bus_config setting may still be overridden by the bootline param.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c   | 12 ++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4bef5c2bae9f..efe69b0d9f7f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -187,6 +187,46 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+choice
+	prompt "PCIE default bus config setting"
+	default PCIE_BUS_DEFAULT
+	depends on PCI
+	help
+	  One of the following choices will set the pci_bus_config at
+	  compile time.  This will still be overridden by the appropriate
+	  pci bootline parameter.
+
+config PCIE_BUS_TUNE_OFF
+	bool "Tune Off"
+	depends on PCI
+	help
+	  Use the BIOS defaults; doesn't touch MPS at all.
+
+config PCIE_BUS_DEFAULT
+	bool "Default"
+	depends on PCI
+	help
+	  Ensure MPS matches upstream bridge.
+
+config PCIE_BUS_SAFE
+	bool "Safe"
+	depends on PCI
+	help
+	  Use largest MPS boot-time devices support.
+
+config PCIE_BUS_PERFORMANCE
+	bool "Performance"
+	depends on PCI
+	help
+	  Use MPS and MRRS for best performance.
+
+config PCIE_BUS_PEER2PEER
+	bool "Peer2peer"
+	depends on PCI
+	help
+	  Set MPS = 128 for all devices.
+endchoice
+
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e39c5499770f..dfb52ed4a931 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
 
+
+/* PCIE bus config, can be overridden by bootline param */
+#ifdef CONFIG_PCIE_BUS_TUNE_OFF
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
+#elif defined CONFIG_PCIE_BUS_SAFE
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
+#elif defined CONFIG_PCIE_BUS_PERFORMANCE
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
+#elif defined CONFIG_PCIE_BUS_PEER2PEER
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
+#else
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
+#endif
 
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
-- 
2.17.1

