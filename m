Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E975C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD51620753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VxF/e6+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgDIPen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:34:43 -0400
Received: from mail-eopbgr770087.outbound.protection.outlook.com ([40.107.77.87]:47335
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727736AbgDIPem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:34:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/E3N7+NiXKVhm1jh3s7yDP37f0XIVQzmS7Xr7wjmrGciLxjnDuESfcQKjtzt8WY8whbGqsvxjtpIWpSvotFu0OydNnlchV/dkknnOeMwNLsgHd8cX2gEv1KK9MKMXy5n9GpEFWQOW5jH8oMEmlOdMDXoR3Cj/ocSOB5uwybR0SPXOQZB23GE323Seuc5uznKWng6SfxSONVy//GHHSMiggKWzS2Gw6OQR0xKyhFMBp0gCRxPJ6Y4KQfAmcYW0s5S0lptlSC47O+O3u4NvfdWYtkxzfWS40vqTQP5rkjO0I1okX/UDUh2hBLT/irOrmzanCKtpH/UzZu07vuvWx3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUaGPwvapDZ5m/Hv/Jrz8LxUDzIVK7WSAib6pMmyn/0=;
 b=GlL+xBP4fCC12Mk3atB9bSfRVO0vd0PSSDrFEjfJEUgKzaWJ47gvpBpxrsD1sD6hlSeNGQkMRvOOBpuRWrgUgDTQygP69axTjFfqmzMOxb6UnCYbW/wWQsGeBRfuY3cTfzIveVb18M2goek5zw2hL18RSEaISglDTt5hSk3xJykUo7mVFrtG4nvwoncSfx1iAj/cHkacad60lYus0++Tn8bKwR4SL1+hEzeWMtAdz1SkgS9MwFKKH6CsysUxuFr8r0QdkBuVc1HZnrsb/x/08hENEqdiTuvZjc//onhHuVjDZ2Cj2Z6+/pGzxiL5B0K59BUD4PTdjOW6Px2glTUmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUaGPwvapDZ5m/Hv/Jrz8LxUDzIVK7WSAib6pMmyn/0=;
 b=VxF/e6+CulkAridqRMB7DGu2U7CCj2Z+qZVwO2cTd9DLun0ybJA7H4Fo5ifyiSZU1E+nAgZ1CgddwGamKfNLAuiQSf2UXId8TX9AwCiVuEHe0oNgBaSDxOjK2jBFmzSYfx8iJPvahxiMuiTso0jJ38lp2dKP1u+oV2MZi1znxsE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=John.Allen@amd.com; 
Received: from SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23)
 by SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 15:34:39 +0000
Received: from SN1PR12MB2448.namprd12.prod.outlook.com
 ([fe80::84b1:614a:c244:424d]) by SN1PR12MB2448.namprd12.prod.outlook.com
 ([fe80::84b1:614a:c244:424d%3]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 15:34:39 +0000
Date:   Thu, 9 Apr 2020 10:34:29 -0500
From:   John Allen <john.allen@amd.com>
To:     bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: [PATCH] x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE
Message-ID: <20200409152931.GA685273@mojo.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: DM5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:3:c0::34) To SN1PR12MB2448.namprd12.prod.outlook.com
 (2603:10b6:802:28::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mojo.amd.com (165.204.77.1) by DM5PR16CA0024.namprd16.prod.outlook.com (2603:10b6:3:c0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 15:34:38 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f37305f6-d587-4cd6-d653-08d7dc9b83ef
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:|SN1PR12MB2381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23813632557D5D6765F57F099AC10@SN1PR12MB2381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2448.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(52116002)(81156014)(2906002)(26005)(8936002)(7696005)(33656002)(478600001)(66946007)(8676002)(81166007)(316002)(86362001)(4744005)(66556008)(1076003)(16526019)(186003)(55016002)(4326008)(66476007)(44832011)(5660300002)(6666004)(956004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVdti5iJm3Jl/v//KSoBl+GeacIKsEtzbg7ZBi5b/YztESZfBeKJWqjG1+X3kG06scUbZ0pCUH2HPSi7kYScX0ZP+BZG/UNOSoSb5QDzqxeO0ebzHyUaw43Uao8Up3ABl46HyLu595EtsbUNfUwzqWo+lkP5v//U15+Vwwll/QIpeW8zIXG1FgYC9UyGljJWCEEj4Cv6vhP60kVsyzdfInrx/A4LItv4u9EnZLRA4Ojr/pRD4uyTAQjMgt7tR2ywgYawgcgdt0gU4bBmxOlGvJa+TGGfSB5NkBqyOk79PCgiRRmT/WG7TzU8kUBHLDq3Z8jamzCBWPr2yy0Tz0B1j0IcBjV2Al97d6iKDHoU1stUpHQBcBLDbff/j1O9ZLXUVAqCRrMsA9P9bm2GQJDGa2U0zTF1rlX18SFDOBkUUl/LlwV1tnE1kpH8HqSVhEDh
X-MS-Exchange-AntiSpam-MessageData: SL2ZcEvQ8wr+/AisDk+l6tAr5joTVm6BhYHcMGeIVMGrqP2Gt8pBmb4dTY4KzsNbHup0iAm7/ua+t3/v9KuzsONvBm7bW6J+vF95OsvFQNLcPH82iukPtRqG8UriiAeP4p0NPTwQy7sk172JldOBNQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37305f6-d587-4cd6-d653-08d7dc9b83ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 15:34:38.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8Xy0F+2CIOESTayCj6IMO/Wx04Uv1Y2+eq8a27prpl3zoI1DkPel4WAQlWmBETsLNYNQCOuDDcdmocd0W9k8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Future AMD cpus will have microcode patches that exceed the default 4K
page size.

Signed-off-by: John Allen <john.allen@amd.com>
Cc: stable@vger.kernel.org
---
diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 6685e1218959..7063b5a43220 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -41,7 +41,7 @@ struct microcode_amd {
 	unsigned int			mpb[0];
 };
 
-#define PATCH_MAX_SIZE PAGE_SIZE
+#define PATCH_MAX_SIZE (3 * PAGE_SIZE)
 
 #ifdef CONFIG_MICROCODE_AMD
 extern void __init load_ucode_amd_bsp(unsigned int family);
