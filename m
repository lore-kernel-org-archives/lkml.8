Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B932C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5845920772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oppoglobal.onmicrosoft.com header.i=@oppoglobal.onmicrosoft.com header.b="gtoAOYc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgGAMHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:07:32 -0400
Received: from mail-eopbgr1300053.outbound.protection.outlook.com ([40.107.130.53]:57571
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730237AbgGAMHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:07:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWcHHONCjw8asEUVtazopKgz6uy40cafhf1WpHYltquob9vFWfnsisvYmDlJDMUlSnlNpJZMrAKK7aveTCcZnzO4L9xVe9Pptx/X9DmZaaaj+6K1xShzlJnYyeDS6jpINdm3+FU3Bt4GQqvOTuY/Lp9tAHpa5piMJ484QSv4F4SQRmuBWXJlngLI2PQWcSPNF8jJ06sfi548tZK/2OzTp1KI9PHD7FnpX2F0zyoE2WOmsS7HfV+jVSgoVX7CvkuQtbFO/rzPylcsc80CdQfjla46jUyZjI4CV62YDX8KElA1Rgc24XKyok76mRq3GSnBMOd3ldCL9xRo6oEkKWMnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbH0Ilqn7zfLt19lTiSP+0ze/JdwzN0ZZkKWgGnFSME=;
 b=F9OneUHmisJKucXAHGqiGdYwPRjgjSfrGo3GiuIHnmLKc0+wMPQ3GJPyNr+UU7xx39H8BM4aQ/3xe/+z7fvGBdbTx1+ez95NidztfR8IA3siZCiZcM6IahrQf2GJ26l3PeTwMZwz/xxsBCy5nsJEe7b3DaF4/0/2MsQ/oNPFO2QrHWTZx25uSfFMZWcz+pW5/NuYO6WBMFO3azezh1S6wzQEibf0AtIi0KyJfUpyZKblwDmakoxCLcAg1IFAxRnVtBq9dk09msFBSHddSmmnblxupWdYQB9rf712joPtCJKUhvWnMcHkTT9j/hkuAKua9mU/FVsg/h4KGT9tObUuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbH0Ilqn7zfLt19lTiSP+0ze/JdwzN0ZZkKWgGnFSME=;
 b=gtoAOYc7WjGL2bdaSz443wWqVrKHP8LI1jfopQYJcITYGm6XkvmLehl0jRMp3Jr8ET9SIwwdx4k4+/shkSyIFHyU4zTFYANYT1TT7LKipGuhrWY1hM6LjjapLoC/EGSq9pZv+FtOpu3UlxJ4MEIFa6cECHW/M1dSkXXzyd3qVzA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4299.apcprd02.prod.outlook.com (2603:1096:0:7::10) by
 SG2PR02MB3436.apcprd02.prod.outlook.com (2603:1096:4:4e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20; Wed, 1 Jul 2020 12:07:26 +0000
Received: from SG2PR02MB4299.apcprd02.prod.outlook.com
 ([fe80::d443:af5d:c26d:86b5]) by SG2PR02MB4299.apcprd02.prod.outlook.com
 ([fe80::d443:af5d:c26d:86b5%9]) with mapi id 15.20.3153.020; Wed, 1 Jul 2020
 12:07:26 +0000
From:   Peng Hao <richard.peng@oppo.com>
To:     maz@kernel.org, catalin.marinas@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Hao <richard.peng@oppo.com>
Subject: [PATCH] kvm/arm64: Correct incorrect function parameter specification
Date:   Wed,  1 Jul 2020 08:07:09 -0400
Message-Id: <20200701120709.388377-1-richard.peng@oppo.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To SG2PR02MB4299.apcprd02.prod.outlook.com
 (2603:1096:0:7::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.adc.com (58.255.79.106) by HK2PR02CA0184.apcprd02.prod.outlook.com (2603:1096:201:21::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Wed, 1 Jul 2020 12:07:25 +0000
X-Mailer: git-send-email 2.18.4
X-Originating-IP: [58.255.79.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57bc2fd4-e6f3-4b8d-1034-08d81db751fb
X-MS-TrafficTypeDiagnostic: SG2PR02MB3436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3436E85954248FAAEE966E07E06C0@SG2PR02MB3436.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKqKmbc3xm6Y8ok+91598g2oPBBJQZFGYW+eAZJGTmmfFVVmMXRpFho3++m2JVxLFoXZRCGRNLmPfg9ABVXWbIhkEyoe7Xkydrm+QZkrTR6DbwvDtSB/hfUgNJM1uI6fMCdj8wu3u31sa1xA8WAfpehu7Smd47YqnHG1CHVJ0yoIyQeMXEm6wKZ2Os2tLxkTL3f2lNFT3MnMl6Nf2EE4gyTd36ZT3atxSTNhtEwnOvfGjYaEw/phThs1uTR6VNTfIItDu4iKqCaA5v6jaXz9G5XwhtgIN+dOb0G/wbm/CzCzsA6gGlpH+k9AkeCByxG81hlMuVJfcbBchR4sZNJzEKSjz2BMToYFs9algZKibJ0ta7pZcdXNC7O1EwPZsiYXT9L7RvNJNPBXTYt1hSRCYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4299.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(107886003)(1076003)(956004)(2616005)(6666004)(36756003)(6512007)(66476007)(66946007)(66556008)(4744005)(86362001)(6486002)(186003)(16526019)(8936002)(5660300002)(4326008)(83380400001)(6506007)(2906002)(26005)(498600001)(8676002)(52116002)(1670200006)(11606004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HrQcgKVymwSqCDD8i8fY9KYwpPFWzSD0b23WMebz6rmMLm+wvB303Mmd5PCeoV1LNrE72LMZIwKD6PM1CO18OC5QRoQWCRmV9bnSrtfgJ6dbgk3EvSnN14O4NGiUxlU9XAYXWavZ2QIfbRFxne1Re4DmmH3gzV9f52KiulgX8seuLYJd15LLDXZc6xc/RgYSpBLkv+2+ds1MC+wr+janJJIrmV6zMPgscFUvIhtt31QsEn99D1WpmVhkEYEqaIggS/eRGCctMEh4NWvT5ioOPH9DCwA4K3eZRrPwwyZSnJwP98QU/G95gtA5XjkFy9AuPOWxTx4AdoH4ppmzvhRxiXTKczbwph5ialaXddJPHiUTL3rIVp3kPL4IQojq58n++NAxJgO9gDwkJmhMUf8FNFdTQJEBMgQpiLUTahsJncQ+LSuGX747xfLFv8vS1mZzq0zJm9UL1ZwsgI4lU3pX0Y2ESI4dvyAzcdDXdrOp7JU=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bc2fd4-e6f3-4b8d-1034-08d81db751fb
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4299.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 12:07:26.5898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKsuvTjGYIqXBr5f0JV8ckC8kt5SfYf5UmtqOp0UMXEC4f6qlHEufvyAB5GWP7IwAxS4d43zuoD4DEcaNhqYeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_vmid() just has one parameter "vmid".The other parameter
"kvm" is no longer used.

Signed-off-by: Peng Hao<richard.peng@oppo.com>
---
 arch/arm64/kvm/arm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 90cb90561446..5bf9bf54b22c 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -466,7 +466,6 @@ static bool need_new_vmid_gen(struct kvm_vmid *vmid)
 
 /**
  * update_vmid - Update the vmid with a valid VMID for the current generation
- * @kvm: The guest that struct vmid belongs to
  * @vmid: The stage-2 VMID information struct
  */
 static void update_vmid(struct kvm_vmid *vmid)
-- 
2.18.4

