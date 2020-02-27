Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4BBC761A6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B112084E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811795;
	bh=+wD6czIUhxuJuyD9X9uh5dT1pP9vh8/2qPEPFFBPEDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zcUFxpiuJY/B3kfKSvTp5cYe6oja1NZZvsslS7xHSkfKUTssfhEePBRnmP9grmOLn
	 /qwLKhvy1i2osr5yoFsCwpNjDifGGsHIFs1JAa5Ow7gz0+P/XZ0JOmNCDLbqi4Sq2t
	 b6XUY6hbnqvkDTcrQfHpp2KTxsvXSSvYUFG2E498=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbgB0N4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732144AbgB0N43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:56:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 993B92084E;
        Thu, 27 Feb 2020 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811788;
        bh=+wD6czIUhxuJuyD9X9uh5dT1pP9vh8/2qPEPFFBPEDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhR/dRE7OAsI2tL3j2DRJO9YThYbjBwdid6+oudWDMmJYsCbJNy+ePxQc34APoykI
         AhwPUC45yZ0HYvdW7SQ0OQyiACEkRRaCbvy9Jc6CXEU1oOeNO2mkpBiw2acAaysDWf
         7DSVHGtDwn37T162n4UPZGS73rY6dpgnDh9E3T1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 074/237] PCI/IOV: Fix memory leak in pci_iov_add_virtfn()
Date:   Thu, 27 Feb 2020 14:34:48 +0100
Message-Id: <20200227132302.582687031@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 8c386cc817878588195dde38e919aa6ba9409d58 ]

In the implementation of pci_iov_add_virtfn() the allocated virtfn is
leaked if pci_setup_device() fails. The error handling is not calling
pci_stop_and_remove_bus_device(). Change the goto label to failed2.

Fixes: 156c55325d30 ("PCI: Check for pci_setup_device() failure in pci_iov_add_virtfn()")
Link: https://lore.kernel.org/r/20191125195255.23740-1-navid.emamdoost@gmail.com
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/iov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 0fd8e164339c3..0dc646c1bc3db 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -179,6 +179,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 failed2:
 	sysfs_remove_link(&dev->dev.kobj, buf);
 failed1:
+	pci_stop_and_remove_bus_device(virtfn);
 	pci_dev_put(dev);
 	pci_stop_and_remove_bus_device(virtfn);
 failed0:
-- 
2.20.1



