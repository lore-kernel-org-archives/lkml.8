Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219FEC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBEAC2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XeWABSLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgICJgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:36:39 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:21184
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbgICJgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:36:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4tCgIYzRcR84b0i6qB/u5uMbNcpil/LFPsYW4xieG5KwOAaPLItB5hiJMQsmUiVjrWeh/fG1ur8EUvL4Svt1vUgRWztLIf7kdVYMpuT0UurOrNreXJEEGy8nr5nGaZ2uBoqFxfNIQe4mRc2s1TWk+mzu3UrzUfH+M/vytdjwsC4kSI5a+shjq/MspK5trK97afRQ6chTqqYniscQNJEWNokM0WAr/V7nTXirFnGYzQaX4hBKOgMO6STVfTTd6SX9kpFdVmdkf1AUMR0pwv/zIMwxRczSuuyweVeC95ueqqUUCgnDotGnjQw0+fkr/8HpF4sRuq/KBnryd5XUUupiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fh1IbpQbVRLr47AFj3fFcM6QwfMaWWYkpTJGi+vdeA=;
 b=OKNegXEO9higvqgBb2DEoTgZ069f5bd1eppSowC61yM7Oce/x/ibsWeVAxpLiOWVi+O7T+VkyWNtgPH98YqYe+O/CvWBpufqMkolYS57HAXITyxvtTfOWBOvZtYFG4KwVZsMEaXvYtkIweuguX7EeE+HvNTsz4eLQh4o/KxsyHaP7Xs5UyvUoriO+GCKrO/9BW+TEmgm5W1q767aiy+bIPMMhv87CeyM0HqCgA9oiDJbql238hPtiYsyuqneBpg1lkLhKLzsMdFqlRkxgZARXcFx4FqbUYMwLAO/5hocXmQddCM5itFlIGjpWwsNf5IKZl5edl9nXDRKWSKRtrpiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fh1IbpQbVRLr47AFj3fFcM6QwfMaWWYkpTJGi+vdeA=;
 b=XeWABSLIX8SKE2ZGe1NmSq/nfHbdn9zOe1r1rdGkw4vUakj4OpqXd8qmJtXgXzwHZoCmsfIM2xNiEJFXnU+GOf6znn8r4HNb7GTPVSrvnZ6ZRlPGHZk7nS+DRewfIp4LfehtudFSqGgPezaKjerixDQY0XUHrOwEHjvdNEJ98/8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) by
 DM6PR12MB4337.namprd12.prod.outlook.com (20.180.254.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Thu, 3 Sep 2020 09:36:34 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e%11]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 09:36:33 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, sean.m.osborne@oracle.com,
        james.puthukattukaran@oracle.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, jon.grimm@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/2 v2] iommu: amd: Restore IRTE.RemapEn bit after programming IRTE
Date:   Thu,  3 Sep 2020 09:38:21 +0000
Message-Id: <20200903093822.52012-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903093822.52012-1-suravee.suthikulpanit@amd.com>
References: <20200903093822.52012-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:5:bc::15) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by DM6PR13CA0002.namprd13.prod.outlook.com (2603:10b6:5:bc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 09:36:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2140b5b-da71-4022-3db6-08d84fecd860
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4337E290E63CEBD622FE3FE3F32C0@DM6PR12MB4337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyRNiSbbgV+pZHGVhlakLOWZRCF79EAshACfKRkHeRSFLqFykA387lpx40QbJhBWh12DJOd56iE6ds02Zq5koyzxqOhJ8ROU0llueDevZFJAZKPtdPkMET26smfz114MTlMY/ZZRLDcotEdGcDkGdr4SseeTZLZQkefq2AcwFTaRYCke80oL5d+eaNZotb6fU6USUZeACPXWmDpJf+pWhlSONwRWOUAIV7rhIGZp2D7yys9F82hBYhr5ybs0Vwy5bEDrh8Xuv2a4SibPH+XD8xJGfeex3S2McYOSVZCHMhdKEeBw0b21k/0Tzwi8cJ7oBjlZlxFUvmL1ewLXFrEtjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(83380400001)(2616005)(1076003)(36756003)(6666004)(956004)(2906002)(478600001)(52116002)(8676002)(8936002)(316002)(5660300002)(4326008)(16576012)(86362001)(6486002)(186003)(26005)(66476007)(66946007)(66556008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8KgalJO/MrzT9cxP8B4y3PqzbeF2FNMESIbG5t4AvV00F+l2BokGuIiWVoUYPDtMt7LIKcwU3GvLoFjxcwKQam7HET1yebiV3Dxio9i4adV7gkN4TD2G7RkPWsJCcMPrQFufYDzxI+0gLmDPetZIcXSYMTQNKjvyhc+4PhsPKNF75145l+rxeIjpnOx/+ujXaLdhPbIrE/rjCHqThM7uZjbIT0LPVQQrPkcFw2C4yJvONJ1BgGiT1iDwDODefDnn9bsagqX3TQr3C2T3wqEDQThTlZoGVdyEI4fwF3S0hdbl0RpIMzomp+L1zdzrpyv/BQ0gLXF1mokqSg+4hx7le0+FVHqIzbpMB5aPTVllRGTEh/NQKo7k9DLjK1xCnnV+LGuq3xMvCtNVwinF9xK1HQarIUTDqT3ZxlYPhnYMet7Mw6q3UhLxP/YQJG31GuS/g7Y8A7JWPeWsAr715qwgdiLinX8l7cT9mZ62r3FMKQKPHDpisWCqWJoSmuiTHo0acPqyg2k34DRcSYOSIwFqehCayNJK5sPjIfycoFQ+b302mdree7h8zEUVaHFho8ASB4svdN6orr5z+Nic5O5PBVD9+AcICt72Ym/C/Vg+blP6VJs2pKySfHAiq4gPCIYXUCIYGrE4Iaju6KwdoCS/Iw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2140b5b-da71-4022-3db6-08d84fecd860
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 09:36:33.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Um1iKhsueFiQFaEoVmrR2w/hWrBG8S0sbE08e4Vxkhtxmioke4MdJ4yWE62hQVixt5ggaVd7EMFiTlPbuYqF6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the RemapEn (valid) bit is accidentally cleared when
programming IRTE w/ guestMode=0. It should be restored to
the prior state.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Fixes: b9fc6b56f478 ("iommu/amd: Implements irq_set_vcpu_affinity() hook to setup vapic mode for pass-through devices")
---
 drivers/iommu/amd/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ba9f3dbc5b94..967f4e96d1eb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3850,6 +3850,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
 	struct irq_cfg *cfg = ir_data->cfg;
+	u64 valid = entry->lo.fields_remap.valid;
 
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
 	    !entry || !entry->lo.fields_vapic.guest_mode)
@@ -3858,6 +3859,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	entry->lo.val = 0;
 	entry->hi.val = 0;
 
+	entry->lo.fields_remap.valid       = valid;
 	entry->lo.fields_remap.dm          = apic->irq_dest_mode;
 	entry->lo.fields_remap.int_type    = apic->irq_delivery_mode;
 	entry->hi.fields.vector            = cfg->vector;
-- 
2.17.1

