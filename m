Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFA9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D5A20784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585810802;
	bh=U5P7xI8x8ZbCv0KOMtfFXHNpxF/ZFXmpAyoHBeYDtX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y48gHth25MqtuQKCn4aMVr2l2PRAncngoWWnc8yPucxLJSw+cDpi+yNf+55Ml3XhP
	 41AmPoTsBAdZYR7VsweKJZsq6bwU6ppN9807D6QQ25uwC4kti1N5Vm4V9lxqYubK2I
	 e171GYxppfElIn19AgSKZ2ZvSC7PdbgmegHSEfls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgDBHAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:00:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36360 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDBHAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:00:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so2837574wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 23:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCofxMPDs+Zd4BbgfZ7ibIUeNBtVsSVyW+wJb6YyFJ8=;
        b=n1B5GqmqEMV/SDn5Ibkkfoc0CxFitixX9kxhbLz/S+US2dBX2zZX5/6gJ83Q1AwLQg
         mWLOREFxDz72orUhjFRoGFigUryqGDZnLQpGtbn3M9ho4QLb/0+q0Fu6D/naaXbTGCqi
         +BJiyhNXHLXMehGJo5zlCr2uCxT/eo5SJ40DccsIOxzsqKvPtP/d6Ocr06nq2qk3XDvY
         lANdgyX+NUSdsvW2i3OPYbSbmuFE46slaLnC9qkJWzhuO2a8CswQw9v8pV3JI0JDTRKc
         e13LRoP7t1P2neQN+Z1IMFPX2aJywHCCQl5tyySEbs8oWjMN69LUK7imKQd1GeLXFCSl
         4qbw==
X-Gm-Message-State: AGi0Pua7vuKUkH7QtSNlPMslWca7X3Sl1HlMNeV3AvI0Ftj3GF3ZDrCX
        5e4kladNwvRxfxoWlGlTJD6YYK0nyG0=
X-Google-Smtp-Source: APiQypLwQtoVjWULEf+yed7mqTDJiM7gup+0FRSZGu4ydIXuDTxy7zf0dIDl1fis4S2XMMpjtDgRew==
X-Received: by 2002:adf:8341:: with SMTP id 59mr1908286wrd.314.1585810797389;
        Wed, 01 Apr 2020 23:59:57 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a13sm6214221wrh.80.2020.04.01.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 23:59:56 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v2] mtd: Fix mtd not the same name not registered if nvmem
Date:   Thu,  2 Apr 2020 08:59:53 +0200
Message-Id: <20200402065953.9974-1-ribalda@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401100240.445447-1-ribalda@kernel.org>
References: <20200401100240.445447-1-ribalda@kernel.org>
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
v2: I left behind on my patch a 

mtd->nvmem = NULL;

from my tests. Sorry.

 drivers/mtd/mtdcore.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5fac4355b9c2..7a4b520ef3b0 100644
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
@@ -573,6 +602,10 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
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

