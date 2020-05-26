Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE38C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5068220721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521142;
	bh=6G7FxhEWXSFv1NxrluAp194HnleDzxBzzEXhmI0ugdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yJAysw7XHdE1Aop+doe+ux6ekwJt15xWWHPmRcLidcZYUn+Tre+HKCTcDtuLVmc1O
	 Sl9WZYyopEq8JHelcwxdEfTHn1k7jcaHqc65MlalGRQgvu9lKmMUwWU1W357FiZ1+b
	 XXbHr0CeMNTLGGkJ/yrt1UHHQHeovOSll6jzrSvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403985AbgEZTZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391647AbgEZTGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:06:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A75208A7;
        Tue, 26 May 2020 19:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519993;
        bh=6G7FxhEWXSFv1NxrluAp194HnleDzxBzzEXhmI0ugdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=suOrbugv3AJQYjqHCuU/6akj5xTmY7xh0DWgV/K7/VM0iypn6KMJzS5LKMLZ7poEK
         tg3XHuI/OgDSpTQ0rhACClm+62WzNtuOBdKr86DM7K39cNNNu4TOOq1aORhVqDdv4O
         iHkUqRqOM2iI13UjUBxm1/I1UA6/vwvTJ0UmNMEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 017/111] mtd: Fix mtd not registered due to nvmem name collision
Date:   Tue, 26 May 2020 20:52:35 +0200
Message-Id: <20200526183934.276047408@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Ribalda Delgado <ribalda@kernel.org>

[ Upstream commit 7b01b7239d0dc9832e0d0d23605c1ff047422a2c ]

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
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 6cc7ecb0c788..036b9452b19f 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -563,7 +563,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 
 	config.id = -1;
 	config.dev = &mtd->dev;
-	config.name = mtd->name;
+	config.name = dev_name(&mtd->dev);
 	config.owner = THIS_MODULE;
 	config.reg_read = mtd_nvmem_reg_read;
 	config.size = mtd->size;
-- 
2.25.1



