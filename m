Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B62C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C176C20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="xzIqo5En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHRMHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:07:10 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com ([40.107.8.121]:55936
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbgHRMHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:07:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrI6Eue+EFSoGebaXR7o1wPLhZgjguFI29qzKZoi0pWRh+1NOgYOCPRaDgqyICIrIgUs2YGPuPpduCQsBwdMmYxk4uk/jvhI2Y31dKoxuJnfvPEKyo3ST3NphvDy22V7KSRURWbxIDFurfS7S+HUrJeeYCQ15ky4pPonu1uU3Wqh58Q+N0QJITwnR9FhPCFREkdR/tVrxaOUWo/n5Jz133hA/z6BhWLLx7PfRr7CSXafmfT5zD8Tczktv58zDkxqeWUgbBECt4EDPc2jL1EmAMyeX3QrtZIOqNuhpnCxxUBt+9ZREnj21Ffb3aamM8MqssSaizPAD/S0Y4jnx06gMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX9PlpaQ+G37aMwfOPz0ongxsMFp69bU3OWhMl/Qnwo=;
 b=cyelc7krknN4Q9uul9SJjuNm62/Z5KaqndjB6+n8P3doxSD6jn3Oul8VFVr43nSVQ4FL2ZS83ugafhwZZHgdKzDefbgRnooNEBmk0Ws1O/prEbumFasBUB56nFGwOEfvzFuZP+NlMcwVNTD7DLtWv8+Bs4K/okAfXYcET/CksqxKtD+EKjEnBJ3FOK4Yo8KEPayNrsDbQ8SRX0tvCh9A6Eb92KfKE2aAaW/CNul6l9naL3NlL5EYoic8WXB317Uov4Yq8PXEc6zjA2+G4556L5nkzIbDmgmOfEoBdO/o+Um6T9yg83+YK0udLo2EZ6vWX8x15ykZ3xzQgVr/ixG68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX9PlpaQ+G37aMwfOPz0ongxsMFp69bU3OWhMl/Qnwo=;
 b=xzIqo5Enr7RwwdeKa9Ux6tuZgantR+PYqZPZQR9w60dAwK0/x6oOF6skuCMjqiSvk7Q6AnJlufTM0vp6W0HSEzwYLQy4iJXv61N6ig98JmuMEh4eDOQZrppkd1S+BSkuKnDOi17TuyGNIA2djkxSfFM3TueMug14CwAXhOfbSxw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5914.eurprd02.prod.outlook.com (2603:10a6:10:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Tue, 18 Aug
 2020 12:07:03 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 12:07:03 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     oded.gabbay@gmail.com
Cc:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: Include linux/bitfield.h only in habanalabs.h
Date:   Tue, 18 Aug 2020 15:06:56 +0300
Message-Id: <20200818120656.13823-1-ttayar@habana.ai>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To DB8PR02MB5468.eurprd02.prod.outlook.com
 (2603:10a6:10:ef::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ttayar-VM.habana-labs.com (213.57.90.10) by FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.14 via Frontend Transport; Tue, 18 Aug 2020 12:07:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [213.57.90.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 060db0e9-fc7d-4117-5a7c-08d8436f3809
X-MS-TrafficTypeDiagnostic: DB8PR02MB5914:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR02MB5914D042890A1F514E48C043D25C0@DB8PR02MB5914.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaLD6sBpusyapDN3uC7fxwXJxcO1W7IT3sjczghAIju3olXoQhEBOOn7EWXG04a2dX/Sn2XqebvWWGeLQEBe54/2scRaNLj5He3LC2KqY9ck081cP0dRuSQnb4/mYTqUKpXtn0d7nbk4o6Z/8gO7NESenZeiPIbjfNPtv/FFkEEWafbCjXKerjk0SQaBcesfhMt8W8H7dYgPzmC8C8ypbLwbJ0iDVLPYAssrslVlEESckbYzut86pznSFfOmlWXL9e+6eb8gl8Cic8q7MPouYj6sDDlsOjxu01DnH0gCtGGjEFgua3xUtX6WsCgzdk1R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(366004)(39850400004)(956004)(52116002)(36756003)(2616005)(8676002)(86362001)(66946007)(107886003)(55236004)(6916009)(6506007)(316002)(66476007)(66556008)(8936002)(5660300002)(6666004)(186003)(6486002)(2906002)(16526019)(83380400001)(1076003)(26005)(4326008)(6512007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mhD0k+Vqo8y5QFkcN9TiRerJKE1H2ezb/BUcJMe/rBor9CgZcHkRc0TdCX8I6irDudaxp+IviXE+thnGcDxcX181CiwOJao+c4Eo0Q/kQ0ta/OZl3sdCqpg411wPSp5mJed76VK0d/Z4Dbzrbq7AM+wFVNQ8vKUuUvoMLikcgn1pjOc8mH717m8nIaxwvi1P5A5V3yKdYOYbg/4E44BGs2IoYpSkDcqBjkUhwAn5K2iyZ7iPiHdob7+j8lOMhPTng9NgXDXyL0YdmAsswLB/Ztwu44G63+VDy01fxEgP8Gq6Nxlt/9LSeLsLyJ7phj07WoSZ/vrayGNJoz6zhtDgV+Q+lzVbyaoj8dpwy5gocdP7wzYxHPyuNQjV1fBfmgu46nZQLjs6hczUYJIUsWqCFCGbY1LQz8mVKV16UJe5qlkHOoTX3HgMoLENcEhf9PtmpDkHrM4So18G7oWvGTvdreBoJ3kkSViJtVBQiWKfo3tB8HS1YjxclKLESfrDBoUj3q8JmM9Z6jNe2o1ZrayHw9L5INnN2NF7QvAqL/a5kVwhvBXWsa+knVMf7oB1b+CNxkqoATGgNbJrtq2YFduRQM9N8sNOOB3XhfsLIwdk1EM5n8yDSSOfLwimgkRiQo7dhbzcnnn7st2CKqnUH0nCdA==
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 060db0e9-fc7d-4117-5a7c-08d8436f3809
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 12:07:03.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIVkxzRfoT3BC2ltTfx1edK7XDZlBBdkhhjQ0BHdPWaQ5yLhVr0if0Nfucm9c43Y+qmdK04m0qiAve3yUf3d8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5914
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include linux/bitfield.h only in habanalabs.h, instead of in each and
every file that needs it, as habanalabs.h is already included by all.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/common/habanalabs.h         | 1 +
 drivers/misc/habanalabs/common/hw_queue.c           | 1 -
 drivers/misc/habanalabs/common/pci.c                | 1 -
 drivers/misc/habanalabs/gaudi/gaudi.c               | 1 -
 drivers/misc/habanalabs/include/gaudi/gaudi_masks.h | 1 -
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index dbf214421ae1..0a422fd742e9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -18,6 +18,7 @@
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/hashtable.h>
+#include <linux/bitfield.h>
 
 #define HL_NAME				"habanalabs"
 
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index e2f9ba04b32d..5e66c98fb0d3 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -8,7 +8,6 @@
 #include "habanalabs.h"
 
 #include <linux/slab.h>
-#include <linux/bitfield.h>
 
 /*
  * hl_queue_add_ptr - add to pi or ci and checks if it wraps around
diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
index 7bd3737571f3..b054ed6c2141 100644
--- a/drivers/misc/habanalabs/common/pci.c
+++ b/drivers/misc/habanalabs/common/pci.c
@@ -9,7 +9,6 @@
 #include "../include/hw_ip/pci/pci_general.h"
 
 #include <linux/pci.h>
-#include <linux/bitfield.h>
 
 #define HL_PLDM_PCI_ELBI_TIMEOUT_MSEC	(HL_PCI_ELBI_TIMEOUT_MSEC * 10)
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e56f95e6c741..cbd8acceddbf 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -21,7 +21,6 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iommu.h>
 #include <linux/seq_file.h>
-#include <linux/bitfield.h>
 
 /*
  * Gaudi security scheme:
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
index 3d4f9aed41f1..504f3ad711b5 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
@@ -9,7 +9,6 @@
 #define GAUDI_MASKS_H_
 
 #include "asic_reg/gaudi_regs.h"
-#include <linux/bitfield.h>
 
 /* Useful masks for bits in various registers */
 #define PCI_DMA_QMAN_ENABLE		(\
-- 
2.17.1

