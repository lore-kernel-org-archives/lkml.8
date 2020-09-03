Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB68C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3142C207EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uMWQ5kqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgICJgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:36:46 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:21184
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbgICJgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:36:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbmbQS6CGe8/DbTwMd/qa6pPHliipLxUJwhLF4speCUafoQe1ox+uPNpJf+IU4nKzZC1ErdD8pHv5QN8oh66Ukf6dQYCdNr9UJP/fFIieWgQksUBjePh0BGi3PwIEWhXlw5V8M1yYR69p5/6PWHWLEYv6haa5vpCyfjv/aSosHUuyCiXZS0UEOGuzVzxWfpenN8SS8PAAkz2Qx9cNe8x3pGFm84gq2qEZC4Dke4DrlzbuuPHgP6iu3jGeWx7TkE+hbvDD/wtCjHavylRiphh6sqN8oElN9MSYGot43L6ibD2lL0ndNuUEisPv9lQVAGlGvlCIsI8ts1HZibnzkyI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY3LslNR8hr0PRpgByMbcRmSD9+Y8q+3yYB0cQfxQx8=;
 b=WD+P6wPfLMAGSDpZ5urSSOqTBAnMBv4hIcBbs7RZ58NgtHoJ5PAC7kfnqu56kTdfbfbJD47BDcTPzpIlYASHz1GYSczOVawTGt4MlRp2guZEDo5JyJjNYV1hpWn3BveAU/qGkn0oSzuao71r7ztJGvQC1Ayshw3e69XALXmole5Rwm6aVnbyBmYR2OzbzLou681/yJaUXnsELkb06yMB/8Q5bssrtwCjiE9PFoK2fm//G2dsuyDqj5d3DGzJl/rI82pZB/a2fZMj1E/N6IVzKvf+fGKaC59N1n91g9eC1A5NB25/I24YVtvBAZmTPfMuzcIjEVpe0raZtokNInJmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY3LslNR8hr0PRpgByMbcRmSD9+Y8q+3yYB0cQfxQx8=;
 b=uMWQ5kqZyr2vrryLAbigPAGwo4oUluI6+GTfYBpuea3obAqK4XuYkz8wibEnrZpcC3iGjMxVrS9COWGfaGgnucSpFQAAzIN49n6371Tu72xnWaPXtNmGr0Wjmwc+08tnAL+WxMpTXS4xXhESAgMN0cpIY86ljQxfEIeNSro7f5U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) by
 DM6PR12MB4337.namprd12.prod.outlook.com (20.180.254.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Thu, 3 Sep 2020 09:36:32 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e%11]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 09:36:32 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, sean.m.osborne@oracle.com,
        james.puthukattukaran@oracle.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, jon.grimm@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2 v2] iommu: amd: Fix intremap IO_PAGE_FAULT for VMs
Date:   Thu,  3 Sep 2020 09:38:20 +0000
Message-Id: <20200903093822.52012-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:5:bc::15) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by DM6PR13CA0002.namprd13.prod.outlook.com (2603:10b6:5:bc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 09:36:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8a9dc3e-2d15-4f0e-2936-08d84fecd7ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43371220B45961A6A494888BF32C0@DM6PR12MB4337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dVDKHPVuhnOksT1Ohb3ZB8//mOfpXrxcTR5QhsjNHGAnNdl5AlZNEHRp6His5+qyPiOse6JAm0xO8vMKrryjDQ8vA6mFywNMnPCqDyv6QQ90rY6CbwlVgSx5RtZQQ5X8u3zpAcm7IsgPilGFbM20h1koLdQQdx+PjRa0rhYhKh/3wr+7+zltsL1Kui+5ASF9yHhZEXR3m2adO6gZtX11uJaRWqU5ssmveqhxR4d6EBYHdeaKqABGhyJXAg65nWKEviyD/u+wMiq1wqaCmuWxVRoemBo8QOcumU1mDh9BsFC81OmDMDKuM0E+uWNCz3ecHjIaHNg9ckogupqbPnduFw5id7XsqC6INzJGNJy/51zgrC1jwQw+zVfhuV2eJUxtIMMRez8WK52iC1ibq+gJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(83380400001)(2616005)(1076003)(36756003)(6666004)(956004)(2906002)(478600001)(52116002)(8676002)(8936002)(316002)(5660300002)(4326008)(16576012)(86362001)(6486002)(186003)(26005)(66476007)(66946007)(66556008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3ygaCXZXdn5qsJSEcZrkYmfK0sTr9c+Dpxa4OqJ3GBfQXoZMOLTBZJk0Pd7V8bPk0uL/P3IWtmTWMCAWVR/6vB4kwpne8otKmexXA750E2EXZREHeKxO5gz52aY8seKgi4tIcaeCE0eBd2Jq4ZWA+VLFeZeZLDrv3JMW/U66ryGcXFp4vn/sE583V86oaSMBF5S0Ikhb020khTYL4SlRrCiPZ8+s5FhbEcpMYZpFLRwhufrqR4cqIv27tU16nTkvwZMtWaaPzrQ0zesqDYq+iF1hmszZ38qDry7KKPVq5k2zXvOekpCrVeTJ8mS/WpVf70jsXmJQcFhNqnJq6HpnlntuYSsWmoSK7azp5fLlhPl37iTt3wE25zo01n/bjlpA0at8bSZPLHRgIuvQcFCml7W1/EBsja4SIog/jMSHEwq2G+kUwkqUG1Gc6jNCWZwBr2HZwqGJNhCsTFrxl6yxeU1eQnIhG5X3HfLL+/qKIbsVwzRQ3/W9J/vxytSc/y1QdIvOs4ERHJrbqx53lPSGUJel7fC+BD/Le3mqIZNzihATn3lZoyxFbIHUPqrJCVYYuOZT8juqwpOPmBre3X8Ux4CDjtH1lh6kTV6EFDqv0ocnAMBnARcDRcnw3Hk/+WfyybubvheHpAuWV3di7VHfxA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a9dc3e-2d15-4f0e-2936-08d84fecd7ca
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 09:36:32.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cs++eoRbaFJiXNI/s4OFZ+/d+iQggRvnkwXq+FHp2UJwJvWO4EEsh93xAgYMfhwkeB6ubJSSCIfi6Tv10ZbS+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt remapping IO_PAGE_FAULT has been observed under system w/
large number of VMs w/ pass-through devices. This can be reproduced with
64 VMs + 64 pass-through VFs of Mellanox MT28800 Family [ConnectX-5 Ex],
where each VM runs small-packet netperf test via the pass-through device
to the netserver running on the host. All VMs are running in reboot loop,
to trigger IRTE updates.

In addition, to accelerate the failure, irqbalance is triggered periodically
(e.g. 1-5 sec), which should generate large amount of updates to IRTE.
This setup generally triggers IO_PAGE_FAULT within 3-4 hours.

Investigation has shown that the issue is in the code to update IRTE
while remapping is enabled. Please see patch 2/2 for detail discussion.

This serires has been tested running in the setup mentioned above
upto 96 hours w/o seeing issues.

Changes from v1 (https://lkml.org/lkml/2020/9/2/26)
  * Fix typo in comments and commit messages
  * Fix logic to check for X86_FEATURE_CX16 support in patch 2/2

Thanks,
Suravee

Suravee Suthikulpanit (2):
  iommu: amd: Restore IRTE.RemapEn bit after programming IRTE
  iommu: amd: Use cmpxchg_double() when updating 128-bit IRTE

 drivers/iommu/amd/Kconfig |  2 +-
 drivers/iommu/amd/init.c  | 21 +++++++++++++++++++--
 drivers/iommu/amd/iommu.c | 19 +++++++++++++++----
 3 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.17.1

