Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB38C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFC02084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgCFQPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:15:55 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40108 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgCFQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:15:55 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026GF3xf021741;
        Fri, 6 Mar 2020 11:15:53 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yfnray0m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 11:15:53 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 026GFq4h039529
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Mar 2020 11:15:52 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 6 Mar 2020 11:15:51 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 6 Mar 2020 11:15:51 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 6 Mar 2020 11:15:51 -0500
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 026GFmB8003555;
        Fri, 6 Mar 2020 11:15:49 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] uio: add resource managed devm_uio_register_device() function
Date:   Fri, 6 Mar 2020 18:18:52 +0200
Message-ID: <20200306161853.25368-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_05:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=890 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a resource managed equivalent of uio_register_device().
Not adding devm_uio_unregister_device(), since the intent is to discourage
it's usage. Having such a function may allow some bad driver designs. Most
users of devm_*register*() functions rarely use the unregister equivalents.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio.c          | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/uio_driver.h |  9 +++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index a57698985f9c..6e725c6c6256 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -996,6 +996,44 @@ int __uio_register_device(struct module *owner,
 }
 EXPORT_SYMBOL_GPL(__uio_register_device);
 
+static void devm_uio_unregister_device(struct device *dev, void *res)
+{
+	uio_unregister_device(*(struct uio_info **)res);
+}
+
+/**
+ * devm_uio_register_device - Resource managed uio_register_device()
+ * @owner:	module that creates the new device
+ * @parent:	parent device
+ * @info:	UIO device capabilities
+ *
+ * returns zero on success or a negative error code.
+ */
+int __devm_uio_register_device(struct module *owner,
+			       struct device *parent,
+			       struct uio_info *info)
+{
+	struct uio_info **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_uio_unregister_device, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	*ptr = info;
+	ret = __uio_register_device(owner, parent, info);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	devres_add(parent, ptr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__devm_uio_register_device);
+
 /**
  * uio_unregister_device - unregister a industrial IO device
  * @info:	UIO device capabilities
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 01081c4726c0..c5a306bd458c 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -123,6 +123,15 @@ extern int __must_check
 extern void uio_unregister_device(struct uio_info *info);
 extern void uio_event_notify(struct uio_info *info);
 
+extern int __must_check
+	__devm_uio_register_device(struct module *owner,
+				   struct device *parent,
+				   struct uio_info *info);
+
+/* use a define to avoid include chaining to get THIS_MODULE */
+#define devm_uio_register_device(parent, info) \
+	__devm_uio_register_device(THIS_MODULE, parent, info)
+
 /* defines for uio_info->irq */
 #define UIO_IRQ_CUSTOM	-1
 #define UIO_IRQ_NONE	0
-- 
2.20.1

