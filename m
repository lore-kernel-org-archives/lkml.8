Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB2C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB86120719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Giw12tZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgCZHIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:08:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39730 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgCZHIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:08:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id a9so5750837wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=usE/ys/z8ZrEvebTD5q/zOIViwN/Qr3bNxaYZNYeDg8=;
        b=Giw12tZAymXDFbxQpbLEzz6w7r0O1eeZFHByJRUEwF4s3fssUnmfVK37HovY8MSG8g
         aB0CYd0nDge3IebAXKcKCn8DL9FO01QrQqv4ZQkSxBXz+3/jUAxHH7CjlMq4PusOsrRa
         AIAUX+paTRcoYbFPrM7u3LFEUrqEoZNo+GqDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=usE/ys/z8ZrEvebTD5q/zOIViwN/Qr3bNxaYZNYeDg8=;
        b=HSvyzHs1dAFgc1sXgLrng8TSJz4DkE1/E48WdpvZ3Xk7JcNtfopbPhp3zsEf1Dbgfl
         Zsbj2EzHko08yEmBTTqLpKLtnOJ3YHgM+DX9cNdDtrB6LqAJlddOyr6MSnAcdtnBIDd0
         oKJSLpim4KjNkf/w3sbaiP1I8MeyXGvfnDo13F9hvI1azXDpF7NYUhsC6h39R52v9M0t
         Do4VsmMLWa+XiCA0QE+KLP6RMlWahclpvBIzaylzcN6lgGPma1UxzaCkcuIZumCLAV0D
         AE9w/tt8Ivq60FK4slwjnWQoCk3dXUyK2IKMxJJqizeTckDoVDyiXnkOREgH2Cyn6BUI
         OpHg==
X-Gm-Message-State: ANhLgQ1Te+RALPr2uPc5Cvr4XEfd9/PRpg8n0W4O509tw9xsmHknEVat
        o5/ie4udF9lmDytbFheyatB8yQ==
X-Google-Smtp-Source: ADFU+vtzb9hNfI+ksv6e+V0DXN1iXSfAh7FZDOiwNKmj5UxnWCz/9VDiia75rLzG0tKw11MssM2Gsw==
X-Received: by 2002:a1c:8090:: with SMTP id b138mr1644314wmd.55.1585206491567;
        Thu, 26 Mar 2020 00:08:11 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u8sm2129446wrn.69.2020.03.26.00.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 00:08:10 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 3/3] PCI: iproc: Display PCIe Link information
Date:   Thu, 26 Mar 2020 12:37:27 +0530
Message-Id: <1585206447-1363-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585206447-1363-1-git-send-email-srinath.mannam@broadcom.com>
References: <1585206447-1363-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more comprehensive information to show PCIe link speed and link
width to the console.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index e7f0d58..ed41357 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -823,6 +823,8 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 #define PCI_TARGET_LINK_SPEED_MASK	0xf
 #define PCI_TARGET_LINK_SPEED_GEN2	0x2
 #define PCI_TARGET_LINK_SPEED_GEN1	0x1
+#define PCI_TARGET_LINK_WIDTH_MASK	0x3f
+#define PCI_TARGET_LINK_WIDTH_OFFSET	0x4
 		iproc_pci_raw_config_read32(pcie, 0,
 					    IPROC_PCI_EXP_CAP + PCI_EXP_LNKCTL2,
 					    4, &link_ctrl);
@@ -843,7 +845,14 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 		}
 	}
 
-	dev_info(dev, "link: %s\n", link_is_active ? "UP" : "DOWN");
+	if (link_is_active) {
+		dev_info(dev, "link UP @ Speed Gen-%d and width-x%d\n",
+			 link_status & PCI_TARGET_LINK_SPEED_MASK,
+			 (link_status >> PCI_TARGET_LINK_WIDTH_OFFSET) &
+			 PCI_TARGET_LINK_WIDTH_MASK);
+	} else {
+		dev_info(dev, "link DOWN\n");
+	}
 
 	return link_is_active ? 0 : -ENODEV;
 }
-- 
2.7.4

