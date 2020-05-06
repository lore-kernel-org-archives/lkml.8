Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E222C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B1C206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgEFEW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:22:28 -0400
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:49367
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgEFEW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:22:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWUnm7MaIg30po8cR9Mqasb5bVNTe2ZV68tfeSk3ya0Phdk0T96Qxvy05xbLbnmyIPZNLjDM6CO5kVYuqopodzF+JY9PNBgxOxBiHPU6ik2+Oxb2ylNIoTnP3cNIzh3Q1Ot7SYceVdiyIaULRvv0e5HzsEskJ1SL86INL5eaelW0ZXz3XPj1gqaIFnkfE65BNyk40IuF2d29r7hfPoi1FeU6mO26rCoojcfslAqYEPYwMbvERwkS39C/sQuCF/g8Fiujh6b6dh+6Yg8foYrH0YjMenq7hvnmf6izR5tiIEd+86zmj0lrUqntd0pXvlwgedmNiI7bWBld2Z++wfYH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5TRbehMvGkjXSn7TAU2whsQAM/aRFYEGYzIWF2R0mY=;
 b=PpP7ebiGBoRRVYd73nF11lz2zK8trfwbvchNozCTg/WlNLQ7k99lGJxr9f7gsFDAUTWn+yJntbL/44t3mNbqO1wLZXxjf7hnBWXD6Pa1xe57hgDAex6vZuMwoE0UItxOzYAqxUZYXHYSq6BSJ414Ww8jpK1jbiLuYvBO6fZe0TKwO51D8w+7AVzDxbf4gXkjC01n99lKA47I0wUHQbJBL6EJf5z0Sqa7ReGg/f6uG1RcMYei1uv0nANPr+GQrb4MxrqnaWgI4rJ7JOYO1QkYzkP3HatZ5yv19/ojjEmiCq137fj9h8TO2LUqyUQ+yB/jyb1rLvvqlC3V8M3bYl2/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5TRbehMvGkjXSn7TAU2whsQAM/aRFYEGYzIWF2R0mY=;
 b=QXCKib3XnDTSqb2n+fz4+oQ5Nq89BiUAr+1xYDaSENFay1xkcFsNxcPdnYZldxGk1nvP/9DNCVOQf+pyGcGRZ3TA4qoIYq03BfEufPq3RIRPsk08FP9nglwh2fddp0LdoyPEBT5/6sf+KPKneik7xtJCIQ0nRZv/N3i9/usXpAY=
Authentication-Results: kudzu.us; dkim=none (message not signed)
 header.d=none;kudzu.us; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28; Wed, 6 May 2020 04:22:22 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 04:22:22 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 0/5] ntb perf, ntb tool and ntb-hw improvements
Date:   Tue,  5 May 2020 23:21:47 -0500
Message-Id: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 04:22:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40f3576f-182a-4ba8-fb6e-08d7f175121c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:|DM6PR12MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4092788B26965AEE9D7D39ADE5A40@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdQC+LwTva08m/wYOoMdsM7nVSs9KesSLrC1oUOAEfsQlnCN35HxpwfBOOGkKjyQQEBGqmTc+A60yKjDRhz2O+lUtmZaq6EsJG++LqiJvcR1sdkn0cCTnWvC/JSz2cG5L6vLgv4SyQGem6/F9dW9GwbFR3t6lr8Tb62Fkj1r23uTcmtNXYitmERtN7rNLLdTVuI05gvBnuVuOUewVv7800GQse3wYUg6GE7sSo3TrwZj68byodyP9nCY2NrZbqEqnEF/dfop8SCPnIYktE9xFvLWpKZoIvSxL3teso2Y30f5jciGRGlo9Re3629SIqKC6lU3MNGJy8osQ/BiLuEKpSDFLYRuYG34FhvcYkvJq+FQtdi6UPv6CIaRjPyOcfrcKQyjd1yVcpgMyTJqld/hjpEBK+YlCHbuIF6IzBchTuGQ/G/Xa4F+Cablvb4rBsow7OrplphD5OkErJhnm5Y3Rk0PxqkoinFgrqG5CBJkaDzBwdSM88oYPK73G59LJUm10R1ELUA+a6+sMwDF3rDuUreYFj3JKokOXCmXOjNa8at89P6v1eLn/KEgb9dwaoh4CbRsfnwDjskNiU9Pfb3lxhQDiOQqgRHCEjpdMiGm+hQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(33430700001)(4326008)(4744005)(33440700001)(966005)(956004)(2616005)(478600001)(5660300002)(2906002)(8936002)(36756003)(316002)(6636002)(66556008)(66476007)(6486002)(7696005)(66946007)(52116002)(26005)(8676002)(86362001)(6666004)(16526019)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TeKNUXW4zrli+690dDAeJtP9+QDzuDcPmyqfD9QIBp+/ZB6cb6sMZlzEwxZLf3+37L+YLuA/qQlo/+aMY/rPVyXlsuuHel5pXrtgAWmkJ7Xx2PMGSOG5NHHldEA6ywQkLO9z6khp6vbCJTGYyavikFYiyGOd/5xbePKjLoI0L0GfSvoasrWc/EUTsYIpBZSqtu6WQT6KIhJFfq1UU35qx4TRD2abqngZazdEjJgkYe5M1grPtHDcxnMeAp1jht4R7gEWtZXaOumS4ISKsklHfklmmu5/C0VO4s7eYNTQNhYxbuV3evXh3RgD+VUNcIP2Omd0Uo05awCGLnYigqJZGSX290gGSgDuNCZDF1Zd3l77GzUf7jBmqO+HskKDQqcKCDKGdsIrIAB5f/e5eT9hlhp5LdYPNnLiPKEh94vYG/Yjv/tey2471Sbyf7I1FrhZs2icvNAEhaujQ2rI7WWntSWU3rkqPszhGT4QK/yg7RU1CEa1q3PRjvzPLkD+atQGEMh7zPUfBpYHw0BUjQ+G5iWF9xfCPQiWf7yGQbN4+/RTJMw3Bfpz+gZxFriLJLufDsALWZKZhsTXbC7DS1cBZxKIVYkXB3y92QuMgOkJm8qVdEZx6zcCZovlw1YjVUJwRo/FeXzFtOS9cvX+qvyFZKvVvl9FgCCm63LeCD9Vpv08RF/n/q2vopAMipx039tSaqHjk39Zbx9D7jf4DG0J8ztULMSyX8frHJ4uxIJG76NdKncFnX9PayzxJ6YkqoXN+FhjU1W7dXIdNmhVJeSiLN50crPBkjO4V7Gc5Q4lO6nihtHl8YhET0cCuAykTtNy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f3576f-182a-4ba8-fb6e-08d7f175121c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 04:22:21.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2MR8PItnzGgLdbWDmJGMTeyvwvosqte5M1rHd7Csp0Qtpdlep6dhy/8BAo75y0evtC+e2LVF6mFQKITzPTJUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: 
- Increased ntb_perf command re-try sleep time
- avoid false dma unmap of dst address.

v2: Incorporated improvements suggested by Logan Gunthorpe

Links of the review comments for v3:
1. https://lkml.org/lkml/2020/3/11/981
2. https://lkml.org/lkml/2020/3/10/1827

Logan Gunthorpe (1):
  ntb: hw: remove the code that sets the DMA mask

Sanjay R Mehta (4):
  ntb_perf: pass correct struct device to dma_alloc_coherent
  ntb_tool: pass correct struct device to dma_alloc_coherent
  ntb_perf: increase sleep time from one milli sec to one sec
  ntb_perf: avoid false dma unmap of destination address

 drivers/ntb/hw/amd/ntb_hw_amd.c    |  4 ----
 drivers/ntb/hw/idt/ntb_hw_idt.c    |  6 ------
 drivers/ntb/hw/intel/ntb_hw_gen1.c |  4 ----
 drivers/ntb/test/ntb_perf.c        | 23 ++++++++---------------
 drivers/ntb/test/ntb_tool.c        |  6 +++---
 5 files changed, 11 insertions(+), 32 deletions(-)

-- 
2.7.4

