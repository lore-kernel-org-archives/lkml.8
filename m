Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAFAC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCF32468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814639;
	bh=l92YRp2hrO486tqbN8RnprRK8i7utwrkSIwetpc6F7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DPF9ZkHHdINJX9UHtgqInsCov4WaljWTVlsGYUNB/l7SSP+v8GWnmtAzI+mZM9m4l
	 UHH3kCIWvoXfWdt9su/URmq6m6Eaeb9jy8tiuLq2BHdtXs2yKuPYqhHXUH+WQVsq6m
	 xB59vuSRYEMmNbG7reFOyFKBMnXDtDM/t1POFn78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgB0On6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:43:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730912AbgB0Nsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:48:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C74720578;
        Thu, 27 Feb 2020 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811320;
        bh=l92YRp2hrO486tqbN8RnprRK8i7utwrkSIwetpc6F7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSZq+C4aw+vBFwe4tW1deABMfqeYRxwN0KOyXHq9KRgtVRY8vtHFn2R2Gila2tH+H
         r479eGrKr/yHvLeFr8TjgziVIgGtpQ+Nz0QvRswaaq/pV8GvfFxVd7bWJoS/8lfiuL
         3lho230FH380FsFF2wj+b6IiaPllFolkughagJYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 048/165] PCI/IOV: Fix memory leak in pci_iov_add_virtfn()
Date:   Thu, 27 Feb 2020 14:35:22 +0100
Message-Id: <20200227132238.204423184@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
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
index 1d32fe2d97aa7..9ec3cb628b0b6 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -181,6 +181,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 failed2:
 	sysfs_remove_link(&dev->dev.kobj, buf);
 failed1:
+	pci_stop_and_remove_bus_device(virtfn);
 	pci_dev_put(dev);
 	mutex_lock(&iov->dev->sriov->lock);
 	pci_stop_and_remove_bus_device(virtfn);
-- 
2.20.1



