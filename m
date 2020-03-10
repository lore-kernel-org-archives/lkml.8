Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E697EC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C89227BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i9w8VsHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbgCJUzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:55:42 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:6092
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727496AbgCJUzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:55:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYnlnLapU9noPEjK/9RWf2/74LAjnfElUDyTFaB/MQ8LbkD3nlsKG6o1Tn/2XRyLYPafPanickeEtAMvJoNhfCaMUaq8QXr27ZoWA+TxDEYuURs/sxHs6cmME4bQGrW1k9xZAvhBe/A/J1AiswHosv5Zzprei6m6SVpSsclW+H0Rag8krN+uz47dWnFzpKDLt5UUbSu4RpOJyvarEJm/jCYZXF/X0YUTQbzha1ylY529avf4s4zq+3LwLoDZw2RlhxtBZOF0KiM+D6+GBXwY0QkqiSBH/e1e0/JQwTwTPvsxzHEh13XG5Xb6DK655gRMg+hsqfYt2Korn423BlGc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NH075+zFNvlnqWVy1IhzqbRw6HT0o832CSe1PdyReY=;
 b=VaTMqCOnzzMUfzXs98Cvk2oL9fbWWAGWn6C/yyd/jPZR/67X0eeal0C9qYsfB8BDhOzx6L/oU2h/Q2I/0hd7ENvlfviUg7KorlsTDPINzzEn+EdBU6pYPxYMe6MaqO0fYce4C9LXO9N9ClL1rJj8qhu+d+AEYW3JEwajDfXW9T88PmqvH8e15dgvb6FYo6gKv5WyDgv4aG65neltx2fYFysoe04YkWPld6A0SnEPdYy4MXobzAIq91kIot+IxhZ0HDwWl7SUAREpieaMlfL5NTAb0MPVMu2QbqXvebYJlwWoZ48YZl+DVhxSBI/ibE5tFw7IQHJXCDNyZ3CMssXE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NH075+zFNvlnqWVy1IhzqbRw6HT0o832CSe1PdyReY=;
 b=i9w8VsHiXELW3mPIWphmjfif5d6ANPF+jHbCxnujy0MfPXw3NsHxY4mtfvYBj6YUW+V+MSBETU57DlYsvmOFoeRr7hjCnwrdgJnK6Mol/MLdJkr1MRz4eATUVuDf9cHwiQm36IPPsvhZ/stkw2BtSI+C9f/qWgoMotQzEZBxTC0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22)
 by MN2PR12MB4031.namprd12.prod.outlook.com (2603:10b6:208:16e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Tue, 10 Mar
 2020 20:55:39 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6%2]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:55:39 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 5/5] ntb: hw: remove the code that sets the DMA mask
Date:   Tue, 10 Mar 2020 15:54:54 -0500
Message-Id: <1583873694-19151-6-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::24) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 20:55:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e056d8b7-da72-45a9-5d0b-08d7c53563b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4031:|MN2PR12MB4031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4031BC4DD1FAEBE837F83A39E5FF0@MN2PR12MB4031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(189003)(86362001)(316002)(66946007)(6636002)(8936002)(956004)(8676002)(5660300002)(81166006)(66476007)(66556008)(52116002)(7696005)(2616005)(4326008)(478600001)(6666004)(6486002)(2906002)(81156014)(26005)(36756003)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4031;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Psv0qwJXY1m3r+5g6js0LtU+d+WTjLEDu42Pp9w9oUX2cq9omnLQ4PFh/UTXOhEqWjE3NxoZ5bZsubj878LnQrFnClfOztVcJv9LzrmYA4TuNQhxsjKDvGxEw2IP/yUvWUMLTwL9SDdR2JX+bWGv2kjGfNdkZBF8+JKhGSpozP7M64A3STFnxE5+FZlQFXavCoRBs7RuPAXEMgFaHLEfBKmLbcoSDk0daXI4JL9u4FYp8A+RbwhiyTA7psmo8Z2fw7xFpEixTFAbegX8OBs9ymSy7qmo6/s8ULFKy29+UmpIAIThoIhmgA/+8bTC4ljENDPiaoNjTxQnPs86jiJ2+LDL8NU6mfy1WY+j4Vkf0sXC4E18Bnx6Xh0JSuQvOMkR2tSeZVkugjpX7huUrttfuaSSLRJlN6uksLTwGUoV6bYQjS6m0Xo4I1hXb44V+aY
X-MS-Exchange-AntiSpam-MessageData: P1W37DlnuRM+XKiDl9mvcBsIDmU4Imx//VH45ibVk8XRiMQa3hZgbluURwV/8V6J5CCNeTtftSWPjMUYuiA+9fw9MODdJvr3rKE6St3GKSStwUW1Q+d0uLtx+YvaCiK3jnP+ysS9q6zl3KuCEXa6Ng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e056d8b7-da72-45a9-5d0b-08d7c53563b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 20:55:39.4436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJWy9a4mFivTx5w8wziyhYAaoBwb8vgecIoZyo+qWdCxEYXUrWWYo6LH7DTGm2I82fYeYAF+meyp9XZp4gbPAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

This patch removes the code that sets the DMA mask as it no longer
makes sense to do this.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c    | 4 ----
 drivers/ntb/hw/idt/ntb_hw_idt.c    | 6 ------
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 4 ----
 3 files changed, 14 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index e52b300..a3ae59a 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1020,10 +1020,6 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 			goto err_dma_mask;
 		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
 	}
-	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
-					  dma_get_mask(&pdev->dev));
-	if (rc)
-		goto err_dma_mask;
 
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
 	if (!ndev->self_mmio) {
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index dcf2346..a86600d 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2660,12 +2660,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 		dev_warn(&pdev->dev,
 			"Cannot set consistent DMA highmem bit mask\n");
 	}
-	ret = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
-					   dma_get_mask(&pdev->dev));
-	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to set NTB device DMA bit mask\n");
-		return ret;
-	}
 
 	/*
 	 * Enable the device advanced error reporting. It's not critical to
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index bb57ec2..e053012 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -1783,10 +1783,6 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 			goto err_dma_mask;
 		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
 	}
-	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
-					  dma_get_mask(&pdev->dev));
-	if (rc)
-		goto err_dma_mask;
 
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
 	if (!ndev->self_mmio) {
-- 
2.7.4

