Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7F8C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FF224656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uVIpAFmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgAOOOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:14:21 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38048 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgAOOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:14:19 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so7763658pje.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gt6F4uTsWktpFFyX7CiQDNWqBR7Eg8dmS5mipvr7KTw=;
        b=uVIpAFmd6iprxfTy28Obl/jazf2tlIos2uTiAZBgwcDBz+3vvvMkRyeviyyY2UMM7C
         GW+vdPPOaxlHMB6D5wJW168wbl5t/fR260nHisVeCOhNu4tAQuse+tfzv4bmfdbhQeC2
         qFcrcl8RukC+2AF5PWnwLkFDs5LE9lgVgMSDDUJrtOabLhR8fWUGLXMUJBTSMgGNQ5lx
         SBE0UNlJOAFXqxcM+X464j+hHJXj0lYAilwpJftSueRHiyCJeTWvA8MXslELoR01JGbA
         uI7aCFSf23kkvX722CgrN7MZeLI2NPmEO0jN3/BjJbkBUN3Cjoo+V/71k2aJzxe1jkwz
         CfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gt6F4uTsWktpFFyX7CiQDNWqBR7Eg8dmS5mipvr7KTw=;
        b=VeihLvcIDMnZ/qJgl01vjv4e5KgILQ6aYQe6okbMewmKCep666SCJdEtoV95NQKzzH
         t8L5WYataQfXU6nm3Cor1cI1JbpcAKta9Q+kOtvOs/0FmOXPT/OvQn0jGaEPk2yT86jV
         hJvTinlx/3XDss1JR+mfCNo1xvHyKVPfZucHYkSyMEtYu8Ga0DL3coAhVwnYcB+G/XSr
         HCwb5x33IJ47Rb5Ttd7UOfv9y76BBW7rJdaufOO+rx09yQ5x6o4L3Q1remw4MbmhULKu
         41sKfCcfslYcEo4r+HIT8vhf5CsIRu6HSptGW8BgMQeTfwMrFVH6nOY7UgYr3Wj8+qd+
         Pl0A==
X-Gm-Message-State: APjAAAW8VUyblIHognGasVHQsV0/zTWq2g5GZDv2lUNOjy+cxNDWs/DM
        cBkRU959AwqP7Db+HWR7/8JF/w==
X-Google-Smtp-Source: APXvYqw1WVju2xcX7lOnVABkuUPrOjdfIgwbmNj8fzUvwYrfsT29oM2IUDuh72sKOdrUgFxHL/6b5Q==
X-Received: by 2002:a17:90a:1ae9:: with SMTP id p96mr36512294pjp.8.1579097658957;
        Wed, 15 Jan 2020 06:14:18 -0800 (PST)
Received: from localhost.localdomain ([104.238.63.136])
        by smtp.gmail.com with ESMTPSA id a15sm22591980pfh.169.2020.01.15.06.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jan 2020 06:14:18 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v12 3/4] crypto: hisilicon - Remove module_param uacce_mode
Date:   Wed, 15 Jan 2020 22:12:47 +0800
Message-Id: <1579097568-17542-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the module_param uacce_mode, which is not used currently.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 31ae6a7..853b97e 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -298,9 +298,6 @@ static u32 pf_q_num = HZIP_PF_DEF_Q_NUM;
 module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
 MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 1-4096, v2 1-1024)");
 
-static int uacce_mode;
-module_param(uacce_mode, int, 0);
-
 static u32 vfs_num;
 module_param(vfs_num, uint, 0444);
 MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63)");
@@ -796,6 +793,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, hisi_zip);
 
 	qm = &hisi_zip->qm;
+	qm->use_dma_api = true;
 	qm->pdev = pdev;
 	qm->ver = rev_id;
 
@@ -803,20 +801,6 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	qm->dev_name = hisi_zip_name;
 	qm->fun_type = (pdev->device == PCI_DEVICE_ID_ZIP_PF) ? QM_HW_PF :
 								QM_HW_VF;
-	switch (uacce_mode) {
-	case 0:
-		qm->use_dma_api = true;
-		break;
-	case 1:
-		qm->use_dma_api = false;
-		break;
-	case 2:
-		qm->use_dma_api = true;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	ret = hisi_qm_init(qm);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to init qm!\n");
@@ -1015,12 +999,10 @@ static int __init hisi_zip_init(void)
 		goto err_pci;
 	}
 
-	if (uacce_mode == 0 || uacce_mode == 2) {
-		ret = hisi_zip_register_to_crypto();
-		if (ret < 0) {
-			pr_err("Failed to register driver to crypto.\n");
-			goto err_crypto;
-		}
+	ret = hisi_zip_register_to_crypto();
+	if (ret < 0) {
+		pr_err("Failed to register driver to crypto.\n");
+		goto err_crypto;
 	}
 
 	return 0;
@@ -1035,8 +1017,7 @@ static int __init hisi_zip_init(void)
 
 static void __exit hisi_zip_exit(void)
 {
-	if (uacce_mode == 0 || uacce_mode == 2)
-		hisi_zip_unregister_from_crypto();
+	hisi_zip_unregister_from_crypto();
 	pci_unregister_driver(&hisi_zip_pci_driver);
 	hisi_zip_unregister_debugfs();
 }
-- 
2.7.4

