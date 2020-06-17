Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D85C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D717821527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Nc8lSrLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgFQQpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:45:33 -0400
Received: from mail-m963.mail.126.com ([123.126.96.3]:46694 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:45:33 -0400
X-Greylist: delayed 1840 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 12:45:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=o8xG9c5meYjmWWp/0P
        CIRTjcybBm99Rz8hWdqIX3rqc=; b=Nc8lSrLpxgUUZ8guUoDste63Jo8KN3etGZ
        owl9by6etAXJQd8L1mWLxod0JSqJCuzQ8rXRAxQMFYO+0It2sDBgwm3hpdZYv651
        GKZEtl8ybzLnjGStiiFSAaf4kjNPjtUjulEfDllnUxv768kFcBQttFWf/fzwP5z1
        N+MC7VgN8=
Received: from zhixu-home.lan (unknown [114.249.228.138])
        by smtp8 (Coremail) with SMTP id NORpCgCHqIDHQOpeLmgYBA--.75S2;
        Thu, 18 Jun 2020 00:11:52 +0800 (CST)
From:   Zhixu Zhao <zhixu001@126.com>
To:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Cc:     Zhixu Zhao <zhixu001@126.com>
Subject: [PATCH v2] staging: gasket: core: Fix a coding style issue in gasket_core.c
Date:   Thu, 18 Jun 2020 00:11:27 +0800
Message-Id: <20200617161127.32006-1-zhixu001@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: NORpCgCHqIDHQOpeLmgYBA--.75S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw13JF1DXr4UJw4DXw48Xrb_yoW5Kw4xpa
        y8Cas8KrZFqwsIqr13JFWYyrZxXr1qyryjk3yfArWkJrZ8ta48Jr48GF18KayIyFWUZr47
        Wr1DJFWjy34DXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRBc_hUUUUU=
X-Originating-IP: [114.249.228.138]
X-CM-SenderInfo: x2kl53qqqrqiyswou0bp/1tbiZwhGfF16eKkEXwAAs4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A coding alignment issue is found by checkpatch.pl.
Fix it by using a temporary for gasket_dev->bar_data[bar_num].

Signed-off-by: Zhixu Zhao <zhixu001@126.com>
---

Please ignore the last email (if you received it) because I forgot to Cc
the mailing list. Sorry for the noise...

Changes in v2:
  - gasket_dev->bar_data[bar_num] was used everywhere. Now replace it
    with a `struct gasket_bar_data *data`, making the code more elegant.
    Thanks to Joe Perches.

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

