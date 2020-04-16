Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8337CC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBBD2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBCZkMhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407855AbgDPQ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726458AbgDPQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:28:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E992C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:28:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id np9so1611940pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DH5AjWb5Y/HC4rBu1O6z9vHzFuPiXlFK1AmlrEvjj1A=;
        b=WBCZkMhS3gdLHak/VSo4Xn0s/nbTSmpk9Jj0cxWCDrvXpC+EtwYAWxrMqTLfbp/mBk
         lVhRuPFZSZ4YZz9o+xTcibUa4jjgvuNb6GjWx0qXZQy2QWygyA8QlM9ls8a+5LQ3uzaj
         MdThyYXqnpiDcsja+9uKGNwJE/mGRRDkcCrUFhv6LQ8BZM68dwp1p2pidbzLHaR/7pBq
         rRdhCQE+ADVVWwV5TOGE3fBEIVE049HgxmWxVIFdF+V6vgHr2LLzNP2gRg7ZeEa7uzyU
         1tXqrKcwWHDW5Te5aP9gsil2QL2f2pPEhzmRy2v/GzNDfnzOnN+vpwJVErfbojr2DCF2
         dvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DH5AjWb5Y/HC4rBu1O6z9vHzFuPiXlFK1AmlrEvjj1A=;
        b=RE70sp11hzpbTW5Tab4ZT4imDrWKMJm2Y9ZwKnMw2TqY/hAH3hsEqSu39DeihOJtNa
         KO48RAZeOMg53WCaVpgfvv86PNVNViVzktUFDSrJ3G69ArdtZM5bBatx2Io+9v2q672n
         evJd4iUgSmngoqISLuJlK/tI+dBNlDyPbHSlGwicC/73dFSYkGe/a+sQMKzig2vjO77u
         B1uOUw4TodGXE5vcRJZxSqR9kFbhfipwfy/fkTt1LVtNY153uJ9sx1PNYj41+RpfEF9P
         HynSzHACaI9KWo4xao8Mpx/HHR8rMhazMs4VyXspLJ1q/J6xJCLQJHNtw4/NHK+qhAhl
         Uv3g==
X-Gm-Message-State: AGi0Pua9LH4iYSbSSCNs8c8pULXV6dOVHHzvP+Sc8CzzEy10iPmC+kI7
        +xlVl2kxW/3goI0914dOLo8=
X-Google-Smtp-Source: APiQypK+z6rTLn+Bg3ChLHHVM5q18C6AjRuYYDu+Bu2MYmSnhwHnf0s/QBnuXaHNwo72Z2F5ZXpxzQ==
X-Received: by 2002:a17:90a:10d7:: with SMTP id b23mr6238055pje.111.1587054527623;
        Thu, 16 Apr 2020 09:28:47 -0700 (PDT)
Received: from minnich.svl.corp.google.com ([2620:15c:2c5:3:65f9:fd8e:a0b8:2917])
        by smtp.googlemail.com with ESMTPSA id k14sm17411082pfg.15.2020.04.16.09.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:28:46 -0700 (PDT)
From:   "Ronald G. Minnich" <rminnich@gmail.com>
X-Google-Original-From: "Ronald G. Minnich" <rminnich@google.com>
Cc:     "Ronald G. Minnich" <rminnich@google.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: add cmdlineparts to intel-spi
Date:   Thu, 16 Apr 2020 09:28:28 -0700
Message-Id: <20200416162830.183725-1-rminnich@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel platforms, the usable SPI area is located several
MiB in from the start, to leave room for descriptors and
the Management Engine binary. Further, not all the remaining
space can be used, as the last 16 MiB contains firmware.

To make the SPI usable for mtdblock and other devices,
it is necessary to enable command line partitions so the
middle usable region can be specified.

Add a part_probes array which includes only "cmdelineparts",
and change to mtd_device_parse_register to use this part_probes.

Signed-off-by: Ronald G. Minnich <rminnich@google.com>
---
 drivers/mtd/spi-nor/controllers/intel-spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index 61d2a0ad2131..132129e89d07 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -894,6 +894,8 @@ static const struct spi_nor_controller_ops intel_spi_controller_ops = {
 	.erase = intel_spi_erase,
 };
 
+static const char * const part_probes[] = { "cmdlinepart", NULL };
+
 struct intel_spi *intel_spi_probe(struct device *dev,
 	struct resource *mem, const struct intel_spi_boardinfo *info)
 {
@@ -941,7 +943,8 @@ struct intel_spi *intel_spi_probe(struct device *dev,
 	if (!ispi->writeable || !writeable)
 		ispi->nor.mtd.flags &= ~MTD_WRITEABLE;
 
-	ret = mtd_device_register(&ispi->nor.mtd, &part, 1);
+	ret = mtd_device_parse_register(&ispi->nor.mtd, part_probes,
+				       NULL, &part, 1);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

