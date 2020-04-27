Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424D8C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1102620B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="pg3K9f3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgD0Sjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:39:54 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:2702 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725995AbgD0Sjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:39:53 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RIZEqR029933;
        Mon, 27 Apr 2020 13:39:51 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2050.outbound.protection.outlook.com [104.47.38.50])
        by mx0a-00010702.pphosted.com with ESMTP id 30mjqsp43p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 13:39:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKKDt1iNJwZjiTNFEjfKokoLoKNImEEgH71TfP184EJW3ZPNUZWAaP3iq7UtDqwCFR5WmraaKwxmYlJgo0Lp/2d8X9FNvvYtG3fMHpk6ImM/CN5MqCiSVURW4YXM/xOapW0M0iNbsylnnFUtf9nytHxaziEt3RxB+gnqvlN3XrRKHwkmD0cbnidPVOKiUcK1wKhb8yjUewd3lICo7ASSFkhF2CHzfLT7XaIeNgiJoM0ISQVcc+2JfW5pzPnlCXVnTsKYnjeXkm8R9pI5n+1+7LvZfkxAbpglCIBcvf1o7xz7Y+tZzYqGOHQhO7LXzY+QAkLZt9kin7SW09/gFUMgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3JNIqh1qL0nisXtmv8WIdBrS8dQGoHvB0+ISXTFWmQ=;
 b=UAqwuvKdRdAbKKkTJz5P7EJLS+ohuOU/eQw0jC7fS+a6FqJXjwKSVLdK87yBgf7MoWqte9iYrtyAcnO9p2iAXd82kDHB2i+fud6AndTTJ/vzruElR7JhVaHOI9O90Sc6AnoQE9lebYdP/qUmGIldmSN8zxuWBlsenRf+q0FYDPXeyw07RfiYO5ad18iNB9FibKziWXheCePObxgBb8wzOl/qlLlaw65FHVnh/Wftavfu3qTGegIMDNEMmpmH4za49g2dkpaOMPOdtJuSHSqiswRXdSbpOQIPnidYwWvzjNVnUrvHMaRdAbaTH32Kjp85B8u/uGuBrC344ChM61IJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3JNIqh1qL0nisXtmv8WIdBrS8dQGoHvB0+ISXTFWmQ=;
 b=pg3K9f3/U9XsuRfks4XgfLaagArbdWla95lB0alKDhAh2CMXuCebrc7/kDwpvVNg5Ngh12k3Mv2wix/lno152QRyihsyPZldYxSQ9r4oZz+rzLFAcmFmX4T0gL0ZnBfJOntfz+O2S/P2GpZULYppcOTCPvy53N3bADMqiUyCtc0=
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3518.namprd04.prod.outlook.com
 (2603:10b6:803:4f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 18:39:49 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::ddad:ff15:a204:e717]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::ddad:ff15:a204:e717%6]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 18:39:49 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Khouloud Touil <ktouil@baylibre.com>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: ensure sysfs writes handle write-protect pin
Date:   Mon, 27 Apr 2020 13:39:14 -0500
Message-Id: <20200427183914.333587-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:5:60::39) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.phire.org (66.90.216.181) by DM6PR10CA0026.namprd10.prod.outlook.com (2603:10b6:5:60::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 18:39:48 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [66.90.216.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f50a693-0c7d-4891-7bf1-08d7eada5d6e
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3518:|SN4PR0401MB3518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB35182753482FEB38CCB19A3187AF0@SN4PR0401MB3518.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(86362001)(66556008)(5660300002)(6506007)(36756003)(6666004)(2906002)(44832011)(52116002)(66476007)(478600001)(316002)(26005)(2616005)(8676002)(186003)(54906003)(81156014)(16526019)(8936002)(6916009)(6486002)(4326008)(956004)(66946007)(1076003)(6512007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfAButWpQR0xpuJpAMDi9sjUPRRv/VwUntfsFWMn0WC2sTv1OFcUErQ1CKHw5avzFfzjn196fSr7gjn3d1UEEVtghyNroXTbDcZZtUeypaesmsjVpmEJ6pQnYo5LA2qQkA9k/pt9HF3FrTPUsD/8UUM7bTfsqjrvB88KdB0CL/58xuYeBHMSk6LUvH31Ao4fJjsob8nrUnqt9kzktJFX8x0kXInA6S9sI/1/eDBcHOtjzcrpZ/06fyl+Duv/AGJwFQ3ypC5qoRsBL4ELjmSKaOktkhDGrpUr4xnwqeSiju0SH0cHEAXh7UGeZeUh0ZRAj9er8ajKS/4Ac+hroNgfxLOszU+ObJGzotQk+6ptOUp6Ik1FtsblAnVPQ3r46hcD8+Vuw2lDo4QioJZoJ/pbTtB/LMLuIK23AZwkDdjEDyXmHNklU4vs+mM6ZztOkxM4
X-MS-Exchange-AntiSpam-MessageData: UzcLZy9wtrYADGQXb2k0SFM0mlklFXarM6aWjzZxOQHTtc1otxnvgsfL0CSqlknZZZN5m9O7uteZAsBSLSOvy11A1Gp9jG47C1vhw1JNJ3HoylfgHaDlvlWJwZKLTC30YWU53lJhb5DYDzUPePQposmTeTH8ILpq/nwx+ud4wZ+VOxXTTWY5VKbJvaWSwVfVZ2GzK0BClgTJKKCUxE2HrR0WpN40r7nYvdBRmkUw0MxcZLcbdqmskj6ODxm3t7I2TtGuULmRp2XiS72RftObwHR8W8P6J53rLyf0gCZxWSPH74CZLdZ8h7RLPcSOfCgIspIRLykEh4SpnEYOg8Ww9nRt9C997x740xsJf053BfepWy8/iscaLAwLO/Rsd6fYFHZ0khqNgFoFyxaItRM4w7Noi4lcF5GxO6UvVwhLCAAazaEo/J7uXjo7Jnfuu6xXwdyIA/tIrYEbPBqinIDHq+mMgSu9z8ULktbxRAgXYAYxFpZrZP3+ph7h74/Fkprw90TZ9qupLov9pIA69UuKrQg04KGoZOawO5FsYl5FJTfFLrpcELao9iljDk9VHsTNawt5kv0jXtVBxcz+XWNSw9qAFchISknXjUb4BQnL1fYuixUVQSJ1PXUL1hrH533u+loYykqeFdwY34qThxJ2LAEKU7Fzio9S15OGC+qT+9fxuLxmG3bNEFf13Rx5VkhfZ0n58sVNi2YU2gjvspJyRjQYYW+SLrH1cDruUkEAJw3d298+MQaUBsA6wucq2iIAgMkfyFzBPQ2IRO3v0BiDynlw3LlhqyC8FYPb631i6YQ=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f50a693-0c7d-4891-7bf1-08d7eada5d6e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 18:39:49.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHf5O+LETet/ZrvY1dd/Y2Ll22j/XHnj4yazvEbA5gd2Tp/0fgAhFSZ8wIrk45BafijXtu929pDPT9HN564uZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_13:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 clxscore=1011
 spamscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004270149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2a127da461a9d8d97782d6e82b227041393eb4d2 added support for
handling write-protect pins to the nvmem core, and commit
1c89074bf85068d1b86f2e0f0c2110fdd9b83c9f retrofitted the at24 driver to
use this support.

These changes broke write() on the nvmem sysfs attribute for eeproms
which utilize a write-protect pin, as the write callback invokes the
nvmem device's reg_write callback directly which no longer handles
changing the state of the write-protect pin.

Change the read and write callbacks for the sysfs attribute to invoke
nvmme_reg_read/nvmem_reg_write helpers which handle this, rather than
calling reg_read/reg_write directly.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/nvmem/core.c | 52 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 05c6ae4b0b97..a8300202a7fb 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -66,6 +66,30 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
+static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
+			  void *val, size_t bytes)
+{
+	if (nvmem->reg_read)
+		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
+
+	return -EINVAL;
+}
+
+static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
+			   void *val, size_t bytes)
+{
+	int ret;
+
+	if (nvmem->reg_write) {
+		gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
+		ret = nvmem->reg_write(nvmem->priv, offset, val, bytes);
+		gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
 #ifdef CONFIG_NVMEM_SYSFS
 static const char * const nvmem_type_str[] = {
 	[NVMEM_TYPE_UNKNOWN] = "Unknown",
@@ -122,7 +146,7 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 	if (!nvmem->reg_read)
 		return -EPERM;
 
-	rc = nvmem->reg_read(nvmem->priv, pos, buf, count);
+	rc = nvmem_reg_read(nvmem, pos, buf, count);
 
 	if (rc)
 		return rc;
@@ -159,7 +183,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	if (!nvmem->reg_write)
 		return -EPERM;
 
-	rc = nvmem->reg_write(nvmem->priv, pos, buf, count);
+	rc = nvmem_reg_write(nvmem, pos, buf, count);
 
 	if (rc)
 		return rc;
@@ -311,30 +335,6 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
 
 #endif /* CONFIG_NVMEM_SYSFS */
 
-static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
-			  void *val, size_t bytes)
-{
-	if (nvmem->reg_read)
-		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
-
-	return -EINVAL;
-}
-
-static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
-			   void *val, size_t bytes)
-{
-	int ret;
-
-	if (nvmem->reg_write) {
-		gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
-		ret = nvmem->reg_write(nvmem->priv, offset, val, bytes);
-		gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
-		return ret;
-	}
-
-	return -EINVAL;
-}
-
 static void nvmem_release(struct device *dev)
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
-- 
2.25.1

