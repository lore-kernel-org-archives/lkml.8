Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5D1C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC0B2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585735367;
	bh=kdG/MIYOyVJOcr2AlxFgrDLuQGPc02/urOpsa5gIeVY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2SwxeYs3Akf7FR1LDbKZ+t1eYk2Qg2WCuhK3jvbSJCCZJYhHXYfxpcYWFo9kO7STx
	 WcUOIRUXsaVdwveDKXJj/5+WrFG4vjVtLKoCYCtE9DJOPTBEEdVbaEzR88GJ3szxM0
	 iWUM1zJswTL4d4ArB5vfYEXr3bhoZpNu/MlBhIeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbgDAKCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:02:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38616 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgDAKCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:02:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id f6so6453024wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+NuImXGHyqbLPK7qk/fnkfWqM1yyeCrvbhKbbFgkRc=;
        b=oot5Z84iQ4jUrqJYRboYktG3gU9Haj44tI1yaaGljmhLIoEMvdnibdKelSQN7PFE4B
         Tjl9uM1ryHmnSSRmIoKd1CX687Vvnut4wzTnw3cdP+CBS1cqhEynafno66BJ48ZIsscx
         UaTxlVafAxxqSbZCBoQ2tN6zLWskyDcH74ujTO7oJx/GbI97kAgXL6iCKd1mbZAGsnG3
         lYl1DP8oP7qnl39/Yg446URe6DflVYJhw6l5CrRgHjjJrYjGPRP9+WAU8xL1RJI4uIWO
         PP01w4wQLrr98mWPxzUTALegvP9BM/pIAWKMYGeZQ9oNaejoU0OhJlnjvDy/+vsgUwJf
         BnGw==
X-Gm-Message-State: AGi0PuY6MNf4eSauyMrJwERXnKJGP34bBGz6fNqhZMYZEwQbUrqd7uv+
        QQGJsvKdWpoan+XwjYgWl0w=
X-Google-Smtp-Source: APiQypIWkniodw9O1D8mDGzIsjhoH6bNEgJBg8D5BpaUzTdYR6XpQEs2xXMX+iFlm/oIBarcX4mQeg==
X-Received: by 2002:a1c:6505:: with SMTP id z5mr3761401wmb.137.1585735363958;
        Wed, 01 Apr 2020 03:02:43 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id f62sm1901272wmf.44.2020.04.01.03.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:02:42 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH] mtd: Fix mtd not the same name not registered if nvmem
Date:   Wed,  1 Apr 2020 12:02:40 +0200
Message-Id: <20200401100240.445447-1-ribalda@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the nvmem framework is enabled, a nvmem device is created per mtd
device/partition.

It is not uncommon that a device can have multiple mtd devices with
partitions that have the same name. Eg, when there DT overlay is allowed
and the same device with mtd is attached twice.

Under that circumstances, the mtd fails to register due to a name
duplication on the nvmem framework.

With this patch we add a _1, _2, _X to the subsequent names if there is
a collition, and throw a warning, instead of not starting the mtd
device.

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

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 drivers/mtd/mtdcore.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5fac4355b9c2..7653d45a470a 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -28,6 +28,7 @@
 #include <linux/leds.h>
 #include <linux/debugfs.h>
 #include <linux/nvmem-provider.h>
+#include <linux/nvmem-consumer.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -545,13 +546,34 @@ static int mtd_nvmem_reg_read(void *priv, unsigned int offset,
 	return retlen == bytes ? 0 : -EIO;
 }
 
+static int nvmem_next_name(const char *init_name, char *name, size_t len)
+{
+	unsigned int i = 0;
+	int ret = 0;
+	struct nvmem_device *dev = NULL;
+
+	strlcpy(name, init_name, len);
+
+	while ((ret < len) &&
+	       !IS_ERR(dev = nvmem_device_find(name, device_match_name))) {
+		nvmem_device_put(dev);
+		ret = snprintf(name, len, "%s_%u", init_name, ++i);
+	}
+
+	if (ret >= len)
+		return -ENOMEM;
+
+	return i;
+}
+
 static int mtd_nvmem_add(struct mtd_info *mtd)
 {
 	struct nvmem_config config = {};
+	char name[128];
+	int ret = 0;
 
 	config.id = -1;
 	config.dev = &mtd->dev;
-	config.name = mtd->name;
 	config.owner = THIS_MODULE;
 	config.reg_read = mtd_nvmem_reg_read;
 	config.size = mtd->size;
@@ -562,6 +584,13 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.no_of_node = true;
 	config.priv = mtd;
 
+	if (mtd->name) {
+		ret = nvmem_next_name(mtd->name, name, sizeof(name));
+		if (ret < 0)
+			return ret;
+		config.name = name;
+	}
+
 	mtd->nvmem = nvmem_register(&config);
 	if (IS_ERR(mtd->nvmem)) {
 		/* Just ignore if there is no NVMEM support in the kernel */
@@ -569,10 +598,15 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 			mtd->nvmem = NULL;
 		} else {
 			dev_err(&mtd->dev, "Failed to register NVMEM device\n");
+			mtd->nvmem = NULL;
 			return PTR_ERR(mtd->nvmem);
 		}
 	}
 
+	if (ret)
+		dev_warn(&mtd->dev, "mtdev %s renamed to %s due to name collision",
+				mtd->name, nvmem_dev_name(mtd->nvmem));
+
 	return 0;
 }
 
-- 
2.25.1

