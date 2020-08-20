Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AEEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32B922D2B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915440;
	bh=+Nv6csKMBWGiy1e80R3z4GTu13tZAaLYToez1KLYUvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RWkcT5+0U/99KIrkPzD6NkvD3MDzoVP84ZvF9WK6v1xt6WJevJke5N5pJoM8JxKBS
	 I0sHgO2ocwwiBz+XtXLEo6aXdJl6qKCYg5ClfUKyzpRS4t93EBkrkjJM7MgCFG/+09
	 gXagKW/3dNfDU6BO4phf1Z/8irYX0K5Dekc7hf6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHTJX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgHTJXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:23:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D392222CA1;
        Thu, 20 Aug 2020 09:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915428;
        bh=+Nv6csKMBWGiy1e80R3z4GTu13tZAaLYToez1KLYUvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSymhzh1yPS8Xodu6Ebw98PWFdd76/eesMdjQJnTdKOwAKW5y7qsZpP0UL8UhSvBh
         2Oyl6MRGfALtz4m8YAlmWWC2+1uko2kg9IZHPmDNHLBdkC/m1ElNIR/aPk1o6WgNuv
         UFSfpWt20TlFSxwM0FdGq5h0qijc4Kj0UbMs1ZAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.8 010/232] PCI: Add device even if driver attach failed
Date:   Thu, 20 Aug 2020 11:17:41 +0200
Message-Id: <20200820091613.211090802@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajat Jain <rajatja@google.com>

commit 2194bc7c39610be7cabe7456c5f63a570604f015 upstream.

device_attach() returning failure indicates a driver error while trying to
probe the device. In such a scenario, the PCI device should still be added
in the system and be visible to the user.

When device_attach() fails, merely warn about it and keep the PCI device in
the system.

This partially reverts ab1a187bba5c ("PCI: Check device_attach() return
value always").

Link: https://lore.kernel.org/r/20200706233240.3245512-1-rajatja@google.com
Signed-off-by: Rajat Jain <rajatja@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org	# v4.6+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/bus.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *
 
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER) {
+	if (retval < 0 && retval != -EPROBE_DEFER)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
-		pci_proc_detach_device(dev);
-		pci_remove_sysfs_dev_files(dev);
-		return;
-	}
 
 	pci_dev_assign_added(dev, true);
 }


