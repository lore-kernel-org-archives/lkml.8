Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F67C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDEC206F1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 15:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JH5AUrY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgF1PSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 11:18:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40723 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725970AbgF1PSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 11:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593357502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=VIiRpg2HMcYH3miez2YP0TJHh+8l2/Xf7TTOHwjLZVc=;
        b=JH5AUrY6YV11wRbz1xBJ1h899Vtc3NdZSkdBLHbIZA9lWFmI/Wwmqe4hueflcvpWE2RlQy
        0Y5M2YhKvAaJL8wcItywwiAVqhODiQk1yP9u8qBzIqbjh2npDtaGhOAcXFcJG3vmKALKDS
        yZVfyg1YRkJrMYj09ky23gH8CusdZ+g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-qnWlTHZjMfqC4rt6_IBwtQ-1; Sun, 28 Jun 2020 11:18:21 -0400
X-MC-Unique: qnWlTHZjMfqC4rt6_IBwtQ-1
Received: by mail-qk1-f198.google.com with SMTP id f4so2163181qkk.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 08:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VIiRpg2HMcYH3miez2YP0TJHh+8l2/Xf7TTOHwjLZVc=;
        b=ibCbyogs3VwgjWcsU6g4MyX7HGw7n47SNX4X9oGA0dMZK0YDwAlbIZzLC0MyKQiUS0
         vwSpBJd3dco5fG0vZm/6aNFn4VorTNStHN6uST4uUNOc7jh8LwkNUmBt4TKa88RcHDkg
         /7lR6rg+WWM+FRCLd5VS6Ls6KsLgHQL6MdxDs1jgGdb448+/hmh57NxHCKtFyi3SVS7R
         Whqk/jmzUxNqrVZWg91ojEcY6zVJdH91Oom2xVa9Z0lLC2D6paRbCib69SpNo3wlAsbO
         +1cDFtsj3gZpTG/E/lQ0+4ZKa4gB0kgxrivTTFETwRzin/RKO5q8iJhgHM8jcfIW1ehH
         OAew==
X-Gm-Message-State: AOAM533fam+KfYf+KP5ysDABURTkH8PnTbVPuqFx/UhTPbPwTGot2oU/
        kvjRJkmMNMofp6R7xGynS8fWB8iF8KONkymR1QB4eQ8ULXooqdZdwPGEe6x2CG7RGnHcwJOa3Tv
        mIvIS6Eo7WGpzz071Xo2iMa+6
X-Received: by 2002:a37:6388:: with SMTP id x130mr1227803qkb.220.1593357500168;
        Sun, 28 Jun 2020 08:18:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYwcyPZwjUj8AFBJ+MhLk2JfZrttXkDX3IvfuM3nkex36XoZj769AGHUhO6+omwCCFp/3c2g==
X-Received: by 2002:a37:6388:: with SMTP id x130mr1227788qkb.220.1593357499916;
        Sun, 28 Jun 2020 08:18:19 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o15sm13755578qko.67.2020.06.28.08.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 08:18:19 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Date:   Sun, 28 Jun 2020 08:18:13 -0700
Message-Id: <20200628151813.7679-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

To use a dfl pci device, several dfl configs need to be selected.
This is tedious and error prone.

So automagically select the needed configs when FPGA_DFL_PCI
is selected.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/Kconfig | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 7cd5a29fc437..4b9e05af5426 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -138,6 +138,27 @@ config OF_FPGA_REGION
 	  Support for loading FPGA images by applying a Device Tree
 	  overlay.
 
+config FPGA_DFL_PCI
+	tristate "FPGA DFL PCIe Device Driver"
+	depends on PCI
+	select FPGA_DFL
+	select FPGA_DFL_FME
+	select FPGA_DFL_FME_MGR
+	select FPGA_DFL_FME_BRIDGE
+	select FPGA_DFL_FME_REGION
+	select FPGA_DFL_AFU
+	help
+	  Select this option to enable PCIe driver for PCIe-based
+	  Field-Programmable Gate Array (FPGA) solutions which implement
+	  the Device Feature List (DFL). This driver provides interfaces
+	  for userspace applications to configure, enumerate, open and access
+	  FPGA accelerators on the FPGA DFL devices, enables system level
+	  management functions such as FPGA partial reconfiguration, power
+	  management and virtualization with DFL framework and DFL feature
+	  device drivers.
+
+	  To compile this as a module, choose M here.
+
 config FPGA_DFL
 	tristate "FPGA Device Feature List (DFL) support"
 	select FPGA_BRIDGE
@@ -191,21 +212,6 @@ config FPGA_DFL_AFU
 	  to the FPGA infrastructure via a Port. There may be more than one
 	  Port/AFU per DFL based FPGA device.
 
-config FPGA_DFL_PCI
-	tristate "FPGA DFL PCIe Device Driver"
-	depends on PCI && FPGA_DFL
-	help
-	  Select this option to enable PCIe driver for PCIe-based
-	  Field-Programmable Gate Array (FPGA) solutions which implement
-	  the Device Feature List (DFL). This driver provides interfaces
-	  for userspace applications to configure, enumerate, open and access
-	  FPGA accelerators on the FPGA DFL devices, enables system level
-	  management functions such as FPGA partial reconfiguration, power
-	  management and virtualization with DFL framework and DFL feature
-	  device drivers.
-
-	  To compile this as a module, choose M here.
-
 config FPGA_MGR_ZYNQMP_FPGA
 	tristate "Xilinx ZynqMP FPGA"
 	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
-- 
2.18.1

