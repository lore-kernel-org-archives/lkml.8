Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8B1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FA120774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662984;
	bh=JkD+MiY/FPpyZmUTHCm6tsWL4xVIOLfpF+zm5aPlmO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dk0HK5Vq2zMHL7UAs29G7Xw1yh7q16oyxUnBptIR18znXq3POMz61d16ZLfx/KjU3
	 HV0upke/Ar/OCBM8fKplfnDPzZ+T5e79BXEtfi5dXZshYMAqaJIzmBoxFxZEZwlAUx
	 xzEjFxs0r/G67JfI9tyvpHGoArxzsmoAKqRgEzd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgFIAgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729744AbgFHXOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A400F20C09;
        Mon,  8 Jun 2020 23:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658051;
        bh=JkD+MiY/FPpyZmUTHCm6tsWL4xVIOLfpF+zm5aPlmO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evVcRwsUpGQgJBRFlw/B6/wxoKplWx71kOGcPFIDyQjm0sJUO+dTJOCKqsMx63VmS
         TjYIodhGXOXwKQ2fDXlyEfyJEf13GcyDgRNt2Tc8muhkPH16gmXTY5Xy34TsQDVtrX
         oWoSc00ZKRSbEucqlBaECyrRXjV/0RREjc49R9uY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 099/606] mtd: Fix mtd not registered due to nvmem name collision
Date:   Mon,  8 Jun 2020 19:03:44 -0400
Message-Id: <20200608231211.3363633-99-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 5fac4355b9c2..559b6930b6f6 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -551,7 +551,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 
 	config.id = -1;
 	config.dev = &mtd->dev;
-	config.name = mtd->name;
+	config.name = dev_name(&mtd->dev);
 	config.owner = THIS_MODULE;
 	config.reg_read = mtd_nvmem_reg_read;
 	config.size = mtd->size;
-- 
2.25.1

