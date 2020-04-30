Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE958C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875F020656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o56zb6Gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgD3NR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726520AbgD3NR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:17:26 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13DFC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:17:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so6432234ljl.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V+fhiGMWXvrFT59CT1ihId3ZiqpjXsQYR8v/4F83/q8=;
        b=o56zb6GlbouKCLbb5m0nGOJ3cqQru384VPYgr8/VyrCkbAhWnLv7zr5bAVVJNEkr4e
         ESbokYk5Tg2ubsW6RYgRNLUy0/qKAi3TGzTzq+JzRO98OPBkjvMOCPVNOVzr+dQeAkLi
         htAPQCRn8VQ/pGVyh445PNB+62hgkOj4S2PKi7p0dEaBF80aRQD/6uzWeqLjCRn/Nmf3
         gJSlKBDDlFSJfhUm2NZYqweBH6lKnT2n27iC9sTfO6f8eTWKlS7R6QGYtU8VJqfsxAim
         xb/rbbbdGtAJQp3f18CDd+dcJiZX2urrLKBcx58Xw17ZdJGlaYu9fNP/9wM8RWmeAYVV
         k2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=V+fhiGMWXvrFT59CT1ihId3ZiqpjXsQYR8v/4F83/q8=;
        b=TXuO2/lCMx4rPGHt3muFUxpcnXj7sahdGzSBOPm7hiduJnWY9tbI3Ch3pkuqC7rQSY
         0lKC9EHc0dkkmCSafz4ncsIn1TH+j7tWWxL190fvZ9QAcbT42XFQxSmqaTejKDFRdYQ+
         maf7u8Uo+p05Ru6dpYVWSWcieCXtj4UODGSYB2y8tzm9y0RERacOw1Ce7dwtaXTuThFy
         ciXnHno1QRu1fZybLHtFooZEyDDqIU+lYQ3wNc17+7EVovKF1WYnuwx6LiVTY5smJmQS
         BgCiXXx9EoC08bzrqFXtUq7VQgyKRAxY6tsZ1laQWTO69VQ97e+ZrYzx/P61xRWBajby
         VLPQ==
X-Gm-Message-State: AGi0PuZpzVfuKjN063q7cf6oM6fTs5ODmGCzDN52n88hWgW/3Yo04JJN
        le7L7FAm8qfP7cRp6Tcc8T0=
X-Google-Smtp-Source: APiQypKA/qrPlrZLglJd7F4eO2uj+xhCOewn903PevHnYFKc9s7h1LzTk6l8wCp7XjJ1PHQ6KCqWkA==
X-Received: by 2002:a2e:b17a:: with SMTP id a26mr2083581ljm.215.1588252644295;
        Thu, 30 Apr 2020 06:17:24 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id l9sm4286771lje.57.2020.04.30.06.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:17:23 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Alban Bedel <albeu@free.fr>
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH] mtd: Fix mtd not registered due to nvmem name collision
Date:   Thu, 30 Apr 2020 15:17:21 +0200
Message-Id: <20200430131721.360064-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Ribalda Delgado <ribalda@kernel.org>

When the nvmem framework is enabled, a nvmem device is created per mtd
device/partition.

It is not uncommon that a device can have multiple mtd devices with
partitions that have the same name. Eg, when there DT overlay is allowed
and the same device with mtd is attached twice.

Under that circumstances, the mtd fails to register due to a name
duplication on the nvmem framework.

With this patch we use the mtdX name instead of the partition name,
which is unique.

[    8.948991] sysfs: cannot create duplicate filename '/bus/nvmem/devices/Production Data'
[    8.948992] CPU: 7 PID: 246 Comm: systemd-udevd Not tainted 5.5.0-qtec-standard #13
[    8.948993] Hardware name: AMD Dibbler/Dibbler, BIOS 05.22.04.0019 10/26/2019
[    8.948994] Call Trace:
[    8.948996]  dump_stack+0x50/0x70
[    8.948998]  sysfs_warn_dup.cold+0x17/0x2d
[    8.949000]  sysfs_do_create_link_sd.isra.0+0xc2/0xd0
[    8.949002]  bus_add_device+0x74/0x140
[    8.949004]  device_add+0x34b/0x850
[    8.949006]  nvmem_register.part.0+0x1bf/0x640
...
[    8.948926] mtd mtd8: Failed to register NVMEM device

Fixes: c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem API")
Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2916674208b3..29d41003d6e0 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -555,7 +555,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 
 	config.id = -1;
 	config.dev = &mtd->dev;
-	config.name = mtd->name;
+	config.name = dev_name(&mtd->dev);
 	config.owner = THIS_MODULE;
 	config.reg_read = mtd_nvmem_reg_read;
 	config.size = mtd->size;
-- 
2.26.2

