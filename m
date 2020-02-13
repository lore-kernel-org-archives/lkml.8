Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48D2C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE3720661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609023;
	bh=OX2mU2y6CckTIoxTMdqRt0FLdbgG5Mxiu3qKKvGq6K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIKsKGwVOIXdECESQXkIgqDljH4DeeyAyaeTt+5CBN+ubAYhEKcZMjAXwzLrg3DgP
	 fa66cpjyUdX+4bnntBkVp3T5fGjRPmoIF/nv43wE+/W3twWNAjNH7HlAE+bTodr+6e
	 9CELnN2YxypCcBlUNA7J6MabCX0GgrpV3Guj/xJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbgBMPuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387574AbgBMP03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:29 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA62E24676;
        Thu, 13 Feb 2020 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607588;
        bh=OX2mU2y6CckTIoxTMdqRt0FLdbgG5Mxiu3qKKvGq6K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKFlKb+uXjxT6vlzsuix29X9JwVWZSFn2jBT/K5ZsOqyKns52vd8iTMB8RRsN6jpv
         YgWGAcqroyuLnhkUAq8JMNS068bUs4a581YsD8ManIM/YTEBdnwWatz3f3rjDEpnKm
         ua1DXb3nSXA7P8lkPRQSHJmzoc0BchdgsefMzWwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.19 08/52] PCI/IOV: Fix memory leak in pci_iov_add_virtfn()
Date:   Thu, 13 Feb 2020 07:20:49 -0800
Message-Id: <20200213151814.280321022@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
References: <20200213151810.331796857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 8c386cc817878588195dde38e919aa6ba9409d58 upstream.

In the implementation of pci_iov_add_virtfn() the allocated virtfn is
leaked if pci_setup_device() fails. The error handling is not calling
pci_stop_and_remove_bus_device(). Change the goto label to failed2.

Fixes: 156c55325d30 ("PCI: Check for pci_setup_device() failure in pci_iov_add_virtfn()")
Link: https://lore.kernel.org/r/20191125195255.23740-1-navid.emamdoost@gmail.com
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/iov.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -188,10 +188,10 @@ int pci_iov_add_virtfn(struct pci_dev *d
 	sprintf(buf, "virtfn%u", id);
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
 	if (rc)
-		goto failed2;
+		goto failed1;
 	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
 	if (rc)
-		goto failed3;
+		goto failed2;
 
 	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
 
@@ -199,11 +199,10 @@ int pci_iov_add_virtfn(struct pci_dev *d
 
 	return 0;
 
-failed3:
-	sysfs_remove_link(&dev->dev.kobj, buf);
 failed2:
-	pci_stop_and_remove_bus_device(virtfn);
+	sysfs_remove_link(&dev->dev.kobj, buf);
 failed1:
+	pci_stop_and_remove_bus_device(virtfn);
 	pci_dev_put(dev);
 failed0:
 	virtfn_remove_bus(dev->bus, bus);


