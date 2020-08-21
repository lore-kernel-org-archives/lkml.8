Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CE1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4147F20738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzg/U2i4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHUHFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHUHFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:05:45 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E0C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:05:45 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b17so782142ion.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=45HTNE+kjKnW8wEngFX9xy7A5Sni9u8tAXo5tgjFKbc=;
        b=fzg/U2i4I7uzPE0e46T3VYIY5yXwu8LbUaHlrTGvjC/tFfiMbF5HwpEc8L3dNS/VMe
         Key4vgwQo4i+Zryqr73elVrqTZT44LVzNFBneIdynlgqxj7u43V3ZPWF8d2Vmi6IvH5Q
         q9h8isEbeFE2omd9XkTNDoELikh0+Esq55myBAJpu6aYg2U67kCzyqELt0PFzQb3OkDH
         4LhawxlfKNGlnDQs0RlCcekLx5oj2Gyug5xuCLWSc//0k9I0wusnG5sEDGQpNXJAzfKu
         hxRx9QsP23icqB63WpN4cWjbFn+HKvmNqrEsafAZezL9xfMvtW3C4r/Bh1eVeym7ePYj
         0nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=45HTNE+kjKnW8wEngFX9xy7A5Sni9u8tAXo5tgjFKbc=;
        b=K++W+BXcheD0d1DFedJRQzuI/lSrcB6g9Egx5C4zWGlZDMuIMH/sKNgB8mdxVVNB1y
         LrCg9tyd3KHApOVKURA0Is8zRdor8FKNeeG0UbxvH6CH+ra177bNOcO6VMjP7scR9r09
         QRX0OaEyK/LCwHXmngnSA0gJaTpbQ2KUL2yCIH1UfSQPLlge9wwcPD+9USsZqw184ORR
         HHZux2DpR7DSk5qO5jD74lhpr6G1HBPVCFhhcWzl8pt7eSoy2RAWdMHtF93iN9J6vjS+
         z2B9yZTef5jYN+VWYaR8aXqMhhP9pMOIIGg3WsW1LGSHQwyuf+9AWKmwczbOTh4Du6SG
         cq8w==
X-Gm-Message-State: AOAM533/7xUCq2RddB1gvYmCf3J/6shZX3ivXfA7PFJrgoKeevawmJ5W
        uF3TIKH/2gUP+XlS32zawhc=
X-Google-Smtp-Source: ABdhPJydn7iUdZDS/GahCuVNQWnzTcKi76r5BqV1bRNJcHQUJc5DaBlNuqo7Axc8VCsVMqA/A7wjHA==
X-Received: by 2002:a02:e4a:: with SMTP id 71mr1340161jae.133.1597993544957;
        Fri, 21 Aug 2020 00:05:44 -0700 (PDT)
Received: from localhost.localdomain (x-128-101-215-112.reshalls.umn.edu. [128.101.215.112])
        by smtp.gmail.com with ESMTPSA id y14sm637225ilq.72.2020.08.21.00.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:05:44 -0700 (PDT)
From:   James Bond <jameslouisebond@gmail.com>
To:     jameslouisebond@gmail.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ryan Jackson <rjackson@lnxi.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: ck804xrom: fix missing pci device put in error paths
Date:   Fri, 21 Aug 2020 02:05:36 -0500
Message-Id: <20200821070537.30317-1-jameslouisebond@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_dev_get increases the refcount of "pdev".
In the error paths, pci_dev_put should be called
to handle the "pdev" and decrease the corresponding refcount.

Fixes: 90afffc8bd79 ("[MTD] [MAPS] Support for BIOS flash chips on the nvidia ck804 southbridge")
Signed-off-by: James Bond <jameslouisebond@gmail.com>
---
 drivers/mtd/maps/ck804xrom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/maps/ck804xrom.c b/drivers/mtd/maps/ck804xrom.c
index 460494212f6a..16af8b5ee653 100644
--- a/drivers/mtd/maps/ck804xrom.c
+++ b/drivers/mtd/maps/ck804xrom.c
@@ -195,6 +195,7 @@ static int __init ck804xrom_init_one(struct pci_dev *pdev,
 	if (!window->virt) {
 		printk(KERN_ERR MOD_NAME ": ioremap(%08lx, %08lx) failed\n",
 			window->phys, window->size);
+		pci_dev_put(pdev);
 		goto out;
 	}
 
@@ -222,6 +223,7 @@ static int __init ck804xrom_init_one(struct pci_dev *pdev,
 
 		if (!map) {
 			printk(KERN_ERR MOD_NAME ": kmalloc failed");
+			pci_dev_put(pdev);
 			goto out;
 		}
 		memset(map, 0, sizeof(*map));
@@ -295,6 +297,7 @@ static int __init ck804xrom_init_one(struct pci_dev *pdev,
 		if (mtd_device_register(map->mtd, NULL, 0)) {
 			map_destroy(map->mtd);
 			map->mtd = NULL;
+			pci_dev_put(pdev);
 			goto out;
 		}
 
-- 
2.17.1

