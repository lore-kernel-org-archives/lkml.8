Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ED7C4725C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E83206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eAFYCOw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgEFEWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:22:32 -0400
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:61966
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgEFEWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:22:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhzo+wU5+r8ChKxIHmnxWXK0ijqrLlkcXNF64j5pdigS4J5ztV6NeTyILryKUiPkZxYp+16Xi/rWyZ29PDV5wnjUqdtbM9B2vSd9G38+uZKi4AGwVL0KRzUtRe8Qnhz8miLqavPJ3y/rdudy9A7i3al3relVFd+z43UGjkLWZ8bR+YZydx1t498iH61Im7euBTwHFzh0yp3oUKZ/Ji1NRLwTHu3d6BHdCteYg8CMZMpk59ETb2m0bKiueuhFU4OG7H7ZVEcwg7TqPqd/UirEOQ+KqqF/RERIUFNwbKA8KRbJj9ussyjooPxvAL58uyt7rRROFPl+cdSlFJhxCOOq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md+OW3jup0sBPcPCHUVGgrXZ6HoBl7TcYSq92ojBqXU=;
 b=goML+Aiouj29JDfitQG49RDFOFsC+a2QO40W6dQ4YuE725j9M95SQl7tx9z9Ha5LMhDIcw8TjD0huEYQHk1QGZR7PoVb0Mt7yQNumZvnt6DDVQEZqRqLJui0mwrjFIByb7A0Ufc3hVn8kiif7u1ErXiqxJDDV/2+MXk8oheYgXFxV4cND167LT+rPFK+4ilD2vHW7VztlOLqT9/JAczJucUm3kw/eJ1/OIjDy0hpSVSiPHlxRt1/ytuRXsNk550AcaBJgyoyBYaAHVBTXKCLpMwcoWkc0c/p2Bvrg2zmi15h1a8aDC2OUQiprrMDZEwD8xzHf9KZ1JaCMUbM7cFS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md+OW3jup0sBPcPCHUVGgrXZ6HoBl7TcYSq92ojBqXU=;
 b=eAFYCOw9ZBS9sIiPGuifqb7OQu81uhPge/Fzzpdwc7QASxghuG77PVpz4N/OL4AMhPEzwCBzexTsSF0ilW8zEzDQ8rPvibkNxoT0hl6BeNcHooqhMOae0utxtqjG7k0nJ0Ip/NzqNJn+98KM8219aUr/aTPMnKHKzbtVtI6bJxc=
Authentication-Results: kudzu.us; dkim=none (message not signed)
 header.d=none;kudzu.us; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB3707.namprd12.prod.outlook.com (2603:10b6:5:1c1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26; Wed, 6 May 2020 04:22:27 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 04:22:27 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 1/5] ntb: hw: remove the code that sets the DMA mask
Date:   Tue,  5 May 2020 23:21:48 -0500
Message-Id: <1588738912-24827-2-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
References: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 04:22:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 703baaa5-53a7-4cbd-1203-08d7f17515c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3707:|DM6PR12MB3707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB370770F2E4A4D64472E44565E5A40@DM6PR12MB3707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GR1PlYI/8qBh4vDhwyo4DleVSrTsxxly+Pl5x/xbu57D1shXtmCSicTPoH2PhaVu8p5UxkUv6M45Wm0bYSImn2dY0MG0ECaYxZSSMs98gbywmNLhqeirBho1eKLtfG6kUX59XQ/Mrl+JaJECJVFZcO/55dbUWhLt+TKqBCpbDu3SRw8tpfcxDd8CT49KLpZ5v6+xdX76/n+jBuH8NwBi3BEOVdjSELE0BuMgt5sekgy+fyktDViWHgAp6MEaOl8ZXo3ptyiF6dD/Uwy17jQ0mjh8YJuHgviGeAS/ntYnbL38e3BLoLMC07tQ2dwSscoL5JBnwEDH4slfxWTZfqGqpW3BsxnjbOdZbPWEFa594ay7zkbL6DM4nnjql9xqNpS6X6431w0axxTEiUtMqzVpELG1xxIA19yoK53oORJmj/j8omtR2JdDockuTKB2f0FSyV4bNe6njFZA3TYjhphSRVahiyQM2ZDcD/iZ/ToZ3xZDoC1NefdBBB/kNxxevofR8gwDGptaQFOM0iEUj4orhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(33430700001)(5660300002)(478600001)(6666004)(4326008)(316002)(66476007)(33440700001)(86362001)(6636002)(66556008)(8676002)(8936002)(52116002)(2906002)(7696005)(36756003)(6486002)(186003)(16526019)(26005)(956004)(2616005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Luf50LP4FC+5Ort6zG8Af4bW/fyQXJ+YasVUJgUhF1eH/adUb2ZQsH9QTFECdfYcXKHmmTvb7rEATWURCDewhk9L9Fb0IXcB2KiPOBN4EMXVgUUZNKKEGrlNB7/PlzYJjzDPFMCxzY65CVaGn3RreINlYo7yEJ23NC6HPZJoijWwi0t29yUeqM7EyhiT1mwZBLPqMVGNvvaS/MRjGfm3fsymVGThTtCYSob9vTmRsdS1Ap5EqHLVA1iaU0SaKuJz0/Z5FEqBpCaQWQ2dJbbLIFgLbZyU8l9+ktgMoq6fANKgkTkkIujZAMgg2qlnkF5pWE19Hmc3kiNZp6CaMNJ1xyHdSTRXrdle4Vjk0aO6DkSsfBeaZEjqgTmNilZXCnnVEbJOCSAA0xghxgIAe4taJWKoNAcIHOwZJVVZKvJvdunQCcFb+aJJEF3oKxHjoAC+yV9cV4zu67j3afK40FpumD81rLc7U4ENwsUAJOWbV678qCKD9pidPSQHAaLkn9bEABTf5PdD7oeCua2VeUZpOAy/2WSLMfw6NitX9mujnhtojyhVynOMdYsQz3ji+NNI2Q8/j/i7a0qPMAI1X2qayIAmEykMn8eDbHdFCQ6vym5OjBE/Qpw3c1iCS9EEOBacFLfSLuTFkEZybcNPQ24Qe/NEi/U2GdNv+Bjdf/gqgcUJUWbDaVi7cceuPPaCHR0LIpH7RfGTejkKVPAL1f91TJnmVOjTyL2HAwzk1Yw/PHPNnlGGLrsnRown+tV4ogznDG2mIBULnrWv6pGXAg//xQh2snT3+sNGl1QEdG51Q20bIyG10hpPzFQZHrC6XwkY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703baaa5-53a7-4cbd-1203-08d7f17515c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 04:22:27.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEptR/cBdYnd9wswcTCKlWay8pirRKX4yuRBTGA4wW/T1SOIlpkv0nWXAsqgD3sIxHKS6/Reaxj2HLPgvj9rFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3707
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
index 9e310e1..88e1db6 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1191,10 +1191,6 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
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
index edae523..d54261f 100644
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

