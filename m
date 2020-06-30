Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4548DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E5020774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKxB00K0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390187AbgF3RRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:17:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390153AbgF3RRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593537441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=n3ZPjfnJ/ASkDBGa8iMOc6QkfcTimtat1V0+GirAcgg=;
        b=FKxB00K0BSdi8KOjD64w17APJrz6XhnnJvzWCAriiNB23p+I9cHhOme54E8ZQDa6fx1vJ6
        m9KVP3aoTuZcE82MWSyekmJBx/678YxyX+DPFeg6ncChT21uI/mO9jhnci/k48oLNG8/kg
        Ck+XBbccwWdHrwPTn1+n/DFThs2Aqr8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-blXYnQGiNdyPsD_eMxordQ-1; Tue, 30 Jun 2020 13:17:19 -0400
X-MC-Unique: blXYnQGiNdyPsD_eMxordQ-1
Received: by mail-qv1-f72.google.com with SMTP id v10so4134118qvm.17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n3ZPjfnJ/ASkDBGa8iMOc6QkfcTimtat1V0+GirAcgg=;
        b=LiVgx2xDfR94tSIPd5xG3KMPvgiWBJ05Kcx6P4waT15ykjboPQQa4TlSobLaphacsM
         QN0NkB8KJya0Tm2rVhTONvZQp6KM/caRZIrLXTRjhAhtIvWPH3hMFWze/qBiqV8BzRfD
         0BBG95uPtj0JZ/BawK67c7QMWKDiwnJymmd4a0fxB//i5vHxS+EX/jwV+UuuzwOWb2bD
         st2y4rvvTcbZ1+5Zxgzh4aTQbw+XAnb50U5RZKWACR2dKE5V7HIyx6sZ+Dbx4naA2HlX
         A1gyPDF4lm1sV8kP0CaFiHzdFKWKOqs5Fc2r/j7RVwxtxZIq44Y+Pu2cHom67rKRIO4v
         rJaA==
X-Gm-Message-State: AOAM532ORlGK2UvN0cUYOXuUWBCSamsdOf6V7NHl0iNPuNsXiZuaYPYZ
        QJqhMDp6aF3ey0NYZIpXLymw0+r6yPSSDZPp6SfVFwf5vq89tZTReG8uxk7o20/WQx0thqhQw0n
        9Iu9TeacW6vBC4pqsufOWCSjB
X-Received: by 2002:ae9:ef83:: with SMTP id d125mr20933794qkg.287.1593537439264;
        Tue, 30 Jun 2020 10:17:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4Rf6dlYjlg1ZOz83/bf/I+qHA2gJJyZcdyRaH7/vXLLfV7DTSG6gGjxZZf5mVUAEO1jvfJQ==
X-Received: by 2002:ae9:ef83:: with SMTP id d125mr20933758qkg.287.1593537438856;
        Tue, 30 Jun 2020 10:17:18 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w44sm3790774qtb.22.2020.06.30.10.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:17:18 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [RFC 1/1] fpga: dfl: RFC PCI config
Date:   Tue, 30 Jun 2020 10:16:56 -0700
Message-Id: <20200630171656.20151-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200630171656.20151-1-trix@redhat.com>
References: <20200630171656.20151-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Create some top level configs the map to dfl pci cards.

Autoselect the parts of fpga that are needed to run these cards
as well as the other subsystem configs to the card's subdevices.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 Documentation/fpga/dfl.rst | 33 +++++++++++++++++++++++++++++++++
 drivers/fpga/Kconfig       | 28 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index d7648d7c7eee..3a872bc8e3d3 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -500,6 +500,39 @@ Developer only needs to provide a sub feature driver with matched feature id.
 FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
+Kernel configuration
+====================
+
+While it is possible to manually setup a configuration to match your device,
+there are some top level configurations that collect configuations for
+some reference pci cards.  Below descibes these configuration as well as
+what other kernel configs are needed for proper configuration.
+
+FPGA_DFL_PAC10
+Intel Arria 10 GX PCI card, PCI id 0X09C4
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  MFD_INTEL_M10_BMC_SECURE
+  SENSORS_INTEL_M10_BMC_HWMON
+
+FPGA_DFL_D5005
+Intel Stratix 10, D5005 PCI card, PCI id 0X0B2B
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  MFD_INTEL_M10_BMC_SECURE
+  SENSORS_INTEL_M10_BMC_HWMON
+  INTEL_S10_PHY
+
+FPGA_DFL_N3000
+Intel Network Accelerator, N3000 PCI card, PCI id 0X0B30
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  MFD_INTEL_M10_BMC_SECURE
+  SENSORS_INTEL_M10_BMC_HWMON
+  INTEL_LL_10G_MAC
 
 Open discussion
 ===============
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 9d53bd9094e2..b657de20bc98 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -138,6 +138,34 @@ config OF_FPGA_REGION
 	  Support for loading FPGA images by applying a Device Tree
 	  overlay.
 
+config FPGA_DFL_PAC10
+	tristate "Intel Arria 10 GX PCI card"
+	select SPI_ALTERA
+	select MFD_INTEL_M10_BMC
+	select MFD_INTEL_M10_BMC_SECURE
+	select SENSORS_INTEL_M10_BMC_HWMON
+	select FPGA_DFL
+	select FPGA_DFL_FME
+	select FPGA_DFL_FME_MGR
+	select FPGA_DFL_FME_BRIDGE
+	select FPGA_DFL_FME_REGION
+	select FPGA_DFL_AFU
+	select FPGA_DFL_SPI_ALTERA
+	select FPGA_DFL_PCI
+	select IFPGA_SEC_MGR
+
+config FPGA_DFL_D5005
+	tristate "Intel Stratix 10, D5005 PCI card"
+	select FPGA_DFL_PAC10
+	select INTEL_S10_PHY
+	select FPGA_DFl_HSSI
+
+config FPGA_DFL_N3000
+	tristate "Intel Network Accelerator, N3000 PCI card"
+	select FPGA_DFL_PAC10
+	select INTEL_LL_10G_MAC
+	select FPGA_DFL_N3000_NIOS
+
 config FPGA_DFL
 	tristate "FPGA Device Feature List (DFL) support"
 	select FPGA_BRIDGE
-- 
2.18.1

