Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A79C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0A72067C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BzhaLXqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCIOgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:36:13 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:27918
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbgCIOgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnigjiLEMboGCdT2uqW50C346Nj39btkGSwiZrFx/fYnxCYPR+xt77e+9oNFPTFb0jB9yH50PqqzgH5LWXq0yXOiJS3GnF1eHJB3yXnx81VYptvncXCpyp3V0q7GPWsVR2enWOooCG9LmEU0qK3FCJBOY1qdxdY/JP2lQOsFDBTxBmvxTwG1GcZS4v1aRTO5wMkvXhZhY94bAHtJuX5PrqzuxGL2TlU0cTbLGrUleOspuVdVR+CClCO3rDs8hGI0ZvFQKuVkV0X/YUmgILwpKficDu8FH4utspClydOpk7bNMyUCuVa9nlKv58J443EmZf98nHlU7xZMxaJcVhYz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq09/sQIiNENeUIMS+XUWlWvLaYLS4q0l2IQjh+cCZU=;
 b=gj5BagGUDEGe8viBlH6Mbya+fRZ2zV7LgGd/KdgEXaOHi1kbZaPhlY1i+gG0/V4QvS7FB92KvKoj781DljcZtUUv3lAa/T59OmSSzymQne9+pBBYF/Ou8PWXS+G7Eqvqdd/jhqzqu4juDFcqZiNH2tQPnfjo9Wf5cy8QF96+sLFhMSC6cSK4qV3yLKc7aeZ9nnGW0yTAT20Aa3YTFzeTwvGenVFM1a1/6UZxljCsMN5pHMIudvzOvvAdsw16kzbaEU8D+ddE2UlYTV3k1nM7e7Jr2VcTkrb7iUe8PN7fv/+3s3x3pKW5AtcCxi6buqLIOoUTmv6ns52Oz5UeXeXa+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq09/sQIiNENeUIMS+XUWlWvLaYLS4q0l2IQjh+cCZU=;
 b=BzhaLXqZier+FhgRFArMoSsk8Np/pnNsDr3Cax8k4RvY4mApRk/yYOwiX62ASrG6TSPENVFS8B+MR+NyEIO4CfD4SrIy8JCApQ1yXdC1rL9vp80cdd5E4Z/F9I/d4nRr2tjUNPdrnwJdA/gYZCZYJVdNqG4Is8By0ZpPlZhA6ko=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 14:36:10 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 14:36:10 +0000
From:   xinhui pan <xinhui.pan@amd.com>
To:     linux-kernel@vger.kernel.org
Cc:     nicholas.johnson-opensource@outlook.com.au, Felix.Kuehling@amd.com,
        Christian.Koenig@amd.com, Alexander.Deucher@amd.com,
        xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Correct the condition of warning while bo release
Date:   Mon,  9 Mar 2020 22:34:58 +0800
Message-Id: <20200309143458.18411-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0196.apcprd02.prod.outlook.com
 (2603:1096:201:21::32) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by HK2PR02CA0196.apcprd02.prod.outlook.com (2603:1096:201:21::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Mon, 9 Mar 2020 14:36:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 283322ba-d766-4778-2f25-08d7c43735b0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2800:|SN6PR12MB2800:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28009921CF2696EABD9F7DD187FE0@SN6PR12MB2800.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(316002)(66476007)(66556008)(86362001)(4326008)(478600001)(2616005)(81166006)(16526019)(186003)(8676002)(26005)(81156014)(36756003)(8936002)(956004)(66946007)(6916009)(6666004)(4744005)(1076003)(7696005)(52116002)(6486002)(2906002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2800;H:SN6PR12MB2800.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OunQ9Gs/Hx1Ghl6hW0osST0ipfgWJvINqT5tFmOc/rlh44khB3BfxxVSuW3ZPD+d5uzZbaqhovTWcC/uEZ/khMH/4QAYcH3WSVhD5z1sKwwmHA47JnuZO8BnA3uJ0aSZQdRP/6ZJ6WkrgYh48YPOrdwLRrRifWKTJ4zhTJCGk3RQflwDHVqE+uIAOTyMo0Q/z17dH2D9B4Th46FC8iVh8AWvNdSTTlR6aOa9GI8k9O5uKv2oHnsf6CXFpVDcyoPqZCBSzQjtDDK8pVixaAVrdpW8tbRaXcBkfindL3sXe56fjQGx2oyidNAqO+kR95mYyGbwSAwybW3FtypHLm7EWFPkR4rr8xGcsjwvzIYuCPP2fTq8VXzw+i9wyeDIWOD5KzzLZa7mK1rXhnS769HuDDYymfQndFIyw/xCgpXM33Imeq4U4MzfPC0QgH/5zUrm
X-MS-Exchange-AntiSpam-MessageData: 8N+4LhsuNvKNMJwATqqVpBjOyZIuskc90cDw6xR9DS8MMpM4pWbNCLzR2f0mOPpj0tqMEajJq6Ei+7WksCtdRBRAAskI0w7ByqzPfcEmX0+EjtKGp/8chREFDuHjMlQ7LoMeXwh1sy426FsQqTHoPQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283322ba-d766-4778-2f25-08d7c43735b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 14:36:10.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbu+w5Tp8icZPINOVio4/EA8Z2U5zWa3rzcAuXspm98f8CTA+7hKRuRLbsm1jUAE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only kernel bo has kfd eviction fence.
This warning is to give a notice that kfd only remove eviction fence on
individual bos.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 5766d20f29d8..e99f68af2bf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1308,7 +1308,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 		amdgpu_amdkfd_unreserve_memory_limit(abo);
 
 	/* We only remove the fence if the resv has individualized. */
-	WARN_ON_ONCE(bo->base.resv != &bo->base._resv);
+	WARN_ON_ONCE(bo->type == ttm_bo_type_kernel
+			&& bo->base.resv != &bo->base._resv);
 	if (bo->base.resv == &bo->base._resv)
 		amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
 
-- 
2.17.1

