Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A58AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C712073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615560;
	bh=2CO5k6vD6czG69Ma7ay0a21TfHP8pfcgA+9/BvVhWII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pIsjxJbCaimQ3jbefRYa1uocUZ2w2rf6r5NX9Zqp4PblVuWfS0zAdJKjIwQbWgqHj
	 U0NLssbExcOtIqiK1D4ATbqmKkrW1whbkmV2phCVLA846WGfrT8E4MW8RAYAEb7bkg
	 RQDyBtXmj5QWfB9bEefVrSjVejIY2jOrNPB0NPlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgEDSF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731884AbgEDSFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:05:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 239CA2073B;
        Mon,  4 May 2020 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615555;
        bh=2CO5k6vD6czG69Ma7ay0a21TfHP8pfcgA+9/BvVhWII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNkSM6sUKaGhjZq18nq/I2IH86R+LuLIsrKsX6I3AQFhRq/JX1HIANrJikdE6Qz/3
         PfHzyxgOAdLHkV6GFIOvTiQiu2k27KbTqqKRMh9RenpBtwRa+7v1Lt/bWgt7iMddQy
         VpuFY1+2E2j3aOR6YY+7tJPVq8X3LVYs8trwhvnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 5.6 28/73] i2c: amd-mp2-pci: Fix Oops in amd_mp2_pci_init() error handling
Date:   Mon,  4 May 2020 19:57:31 +0200
Message-Id: <20200504165507.147011198@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit ac2b0813fceaf7cb3d8d46c7b33c90bae9fa49db upstream.

The problem is that we dereference "privdata->pci_dev" when we print
the error messages in amd_mp2_pci_init():

	dev_err(ndev_dev(privdata), "Failed to enable MP2 PCI device\n");
		^^^^^^^^^^^^^^^^^

Fixes: 529766e0a011 ("i2c: Add drivers for the AMD PCIe MP2 I2C controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-amd-mp2-pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-amd-mp2-pci.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
@@ -349,12 +349,12 @@ static int amd_mp2_pci_probe(struct pci_
 	if (!privdata)
 		return -ENOMEM;
 
+	privdata->pci_dev = pci_dev;
 	rc = amd_mp2_pci_init(privdata, pci_dev);
 	if (rc)
 		return rc;
 
 	mutex_init(&privdata->c2p_lock);
-	privdata->pci_dev = pci_dev;
 
 	pm_runtime_set_autosuspend_delay(&pci_dev->dev, 1000);
 	pm_runtime_use_autosuspend(&pci_dev->dev);


