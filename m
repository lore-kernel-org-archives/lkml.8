Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77966C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF7720707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615407;
	bh=2CO5k6vD6czG69Ma7ay0a21TfHP8pfcgA+9/BvVhWII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QA1MdUTN0JcE8Z4iO5R9hbGRQ7BA3i6YIJgq4OZntHjThPlqm4nqUJUTrjaetECnT
	 /JPX2ODNBFFLc7mdAx6NLofEfJBXQOp6qKPdcuQJeO5Uk0bZDhpX9Aen8qNIjgjGuG
	 EHyZPhfuXG6WDGBgVhEcNNvGX0wqME1C9M5US6nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgEDSD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731501AbgEDSDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:03:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342CC24958;
        Mon,  4 May 2020 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615403;
        bh=2CO5k6vD6czG69Ma7ay0a21TfHP8pfcgA+9/BvVhWII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vw8dIc+q9ATiB3tceLYXjF1sLR7YpAixuPvsu60XmdtQov4au/23F7bBrV/erDW3C
         CCqF0BRBdKm6bbLAZj+bThLgFIat38gRUKtAS/L0otyy6R0CwLHBIdXykjPtDaM7yu
         LSBqzCLcbR8czJNgeDGucZAsErw3Bm3ZlzXT+LKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 5.4 24/57] i2c: amd-mp2-pci: Fix Oops in amd_mp2_pci_init() error handling
Date:   Mon,  4 May 2020 19:57:28 +0200
Message-Id: <20200504165458.452156495@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
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


