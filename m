Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C7EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C17820578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="N5OuaLw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbgGONgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:36:49 -0400
Received: from mail-m963.mail.126.com ([123.126.96.3]:42876 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbgGONgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Wsk0EW3NKnQYOliQwG
        GUlcFkMt5BvGU9p5h2zd+faXo=; b=N5OuaLw4bFTclyFje8Met8ZM2lbSoccaQd
        xTg6Ww313Ba2mJImdtGCLgLqX5VJdfjhd+m3Ml+P7Fs4Finu9IbdZMGulskaeNvu
        GB47ZVQ5vDT9dMsn9zFWG/f1lPyB1bKFnqtjpcaW0TsYWe/MhEmo6KzRbfbcltLy
        qn8xbDu6g=
Received: from zhixu-home.lan (unknown [114.249.221.156])
        by smtp8 (Coremail) with SMTP id NORpCgDn7f3qBQ9fWhQlAQ--.2826S2;
        Wed, 15 Jul 2020 21:34:36 +0800 (CST)
From:   Zhixu Zhao <zhixu001@126.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        joe@perches.com, linux-kernel@vger.kernel.org, rcy@google.com,
        rspringer@google.com, toddpoynor@google.com,
        dan.carpenter@oracle.com
Cc:     zhixu001@126.com
Subject: [PATCH v3] staging: gasket: core: Fix a coding style issue in gasket_core.c
Date:   Wed, 15 Jul 2020 21:33:13 +0800
Message-Id: <20200715133313.16327-1-zhixu001@126.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617161127.32006-1-zhixu001@126.com>
References: <20200617161127.32006-1-zhixu001@126.com>
X-CM-TRANSID: NORpCgDn7f3qBQ9fWhQlAQ--.2826S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw13JF4rCr48Zw15CF15Jwb_yoW5KF1kpa
        y8Cas8KrZFqwsIqr13JF4UArZxXr1qyryjk3ySyrWkJrZ8ta48Jr48GF18KayIyFWUAr47
        Wr1DJFWjy34DXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRBVbPUUUUU=
X-Originating-IP: [114.249.221.156]
X-CM-SenderInfo: x2kl53qqqrqiyswou0bp/1tbiJAxifFpEAOdvXAAAs8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A coding alignment issue is found by checkpatch.pl.
Fix it by using a temporary for gasket_dev->bar_data[bar_num].

Signed-off-by: Zhixu Zhao <zhixu001@126.com>
---

Changes in v2:
  - gasket_dev->bar_data[bar_num] was used everywhere. Now replace it
    with a `struct gasket_bar_data *data`, making the code more elegant.
    Thanks to Joe Perches.

About v3:
  - Resolved all comments in v2. Resending it...

 drivers/staging/gasket/gasket_core.c | 29 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 67325fbaf760..28dab302183b 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -261,6 +261,7 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 	const struct gasket_driver_desc *driver_desc =
 		internal_desc->driver_desc;
 	ulong desc_bytes = driver_desc->bar_descriptions[bar_num].size;
+	struct gasket_bar_data *data;
 	int ret;
 
 	if (desc_bytes == 0)
@@ -270,31 +271,32 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 		/* not PCI: skip this entry */
 		return 0;
 	}
+
+	data = &gasket_dev->bar_data[bar_num];
+
 	/*
 	 * pci_resource_start and pci_resource_len return a "resource_size_t",
 	 * which is safely castable to ulong (which itself is the arg to
 	 * request_mem_region).
 	 */
-	gasket_dev->bar_data[bar_num].phys_base =
+	data->phys_base =
 		(ulong)pci_resource_start(gasket_dev->pci_dev, bar_num);
-	if (!gasket_dev->bar_data[bar_num].phys_base) {
+	if (!data->phys_base) {
 		dev_err(gasket_dev->dev, "Cannot get BAR%u base address\n",
 			bar_num);
 		return -EINVAL;
 	}
 
-	gasket_dev->bar_data[bar_num].length_bytes =
+	data->length_bytes =
 		(ulong)pci_resource_len(gasket_dev->pci_dev, bar_num);
-	if (gasket_dev->bar_data[bar_num].length_bytes < desc_bytes) {
+	if (data->length_bytes < desc_bytes) {
 		dev_err(gasket_dev->dev,
 			"PCI BAR %u space is too small: %lu; expected >= %lu\n",
-			bar_num, gasket_dev->bar_data[bar_num].length_bytes,
-			desc_bytes);
+			bar_num, data->length_bytes, desc_bytes);
 		return -ENOMEM;
 	}
 
-	if (!request_mem_region(gasket_dev->bar_data[bar_num].phys_base,
-				gasket_dev->bar_data[bar_num].length_bytes,
+	if (!request_mem_region(data->phys_base, data->length_bytes,
 				gasket_dev->dev_info.name)) {
 		dev_err(gasket_dev->dev,
 			"Cannot get BAR %d memory region %p\n",
@@ -302,10 +304,8 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 		return -EINVAL;
 	}
 
-	gasket_dev->bar_data[bar_num].virt_base =
-		ioremap(gasket_dev->bar_data[bar_num].phys_base,
-				gasket_dev->bar_data[bar_num].length_bytes);
-	if (!gasket_dev->bar_data[bar_num].virt_base) {
+	data->virt_base = ioremap(data->phys_base, data->length_bytes);
+	if (!data->virt_base) {
 		dev_err(gasket_dev->dev,
 			"Cannot remap BAR %d memory region %p\n",
 			bar_num, &gasket_dev->pci_dev->resource[bar_num]);
@@ -319,9 +319,8 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 	return 0;
 
 fail:
-	iounmap(gasket_dev->bar_data[bar_num].virt_base);
-	release_mem_region(gasket_dev->bar_data[bar_num].phys_base,
-			   gasket_dev->bar_data[bar_num].length_bytes);
+	iounmap(data->virt_base);
+	release_mem_region(data->phys_base, data->length_bytes);
 	return ret;
 }
 
-- 
2.17.1

