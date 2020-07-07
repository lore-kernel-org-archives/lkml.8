Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77050C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0092075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="DtpXBpFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgGGVaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:30:08 -0400
Received: from mail-eopbgr60125.outbound.protection.outlook.com ([40.107.6.125]:47876
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728357AbgGGVaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:30:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An1jcBH/PoQ8+EJK+60J2DDqKvpg5nwpEnwDUiw0oWJmvnKmFWkhgVJmuov8CTZPaTmEianYz8gOFYXnKpyr0DkPitrrA2ltwZCNLCpLDD42Yxq+NZ+HKtGtgpoR0tS5AAkRMcBUPto072RW6tKGT5AcgcLl5Gt35H/xRGphjGYykKEWF48F1yESPsVUlDZ25cFeGs96vfEyQ4hr9CSmFuzkKeCSPzzq4JjBG1Rnc2sxv5GbiwVYZmmMyohEmpjytLbcLQLFqfjV0MWANTHGrZ9PilQMn8LIjjEcgSDdn8DKhISmHX9prdRE3IxQxn+Mc9dKQmDLEQtiSbY+X53dXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmNE258fssvdq+/sy+F7y8f/T/Q3TkADVouTR/EdlNo=;
 b=HRSRJPt4+uOeBk3X8wZtQLPUwZSXZL9zM3HEyhh4AobmCX6bFu2S6KmGTQ+IDjz6HriXRqP9UQ36KJISwYotNb2LPaO8bzj0/l08GykDV98FpIBad8NRPAGp+Dh7Oua6tVIRSJH2Xp3T3VlwAU2TA+xkWSp5lgrxDwNXKr7MBlOFfzKLb3ZA+pCoB6OuQAbyo7GFcezRYybb/EWBVZE2wjXhp17e28PrZJNmnuUCcNSSWMDJo5FFGMiEmKi+cwgiMLlu6GFKwRoagiEWBWprxE8PjvdrJPv8zJBeev2spQF1ExBH1jGXkSWYjSqg7HGz0oxWN2nvk+AstyauJIhw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmNE258fssvdq+/sy+F7y8f/T/Q3TkADVouTR/EdlNo=;
 b=DtpXBpFhG1bNv2j2FPLWKGIIsubpwEur0D15i31tlGihdI7b2bsx9LcxSykVvzM+vDirsih8RkCv3Oxrlg1uSEPX+RzNHTsgWv6HgFdR5R6pfG+D2HCdplOQiLu1++qduNZSZF5HKFBZ92bSXmbmAt+9S5wQ8VSxqSy8ubsjaX0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM4PR02MB3058.eurprd02.prod.outlook.com (2603:10a6:205:3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 7 Jul
 2020 21:30:04 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e%7]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 21:30:04 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     oded.gabbay@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: remove unused hash
Date:   Wed,  8 Jul 2020 00:29:54 +0300
Message-Id: <20200707212954.26487-1-oshpigelman@habana.ai>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0138.eurprd05.prod.outlook.com
 (2603:10a6:207:3::16) To AM0PR02MB5523.eurprd02.prod.outlook.com
 (2603:10a6:208:15e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oshpigelman-vm2.habana-labs.com (213.57.90.10) by AM3PR05CA0138.eurprd05.prod.outlook.com (2603:10a6:207:3::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Tue, 7 Jul 2020 21:30:03 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [213.57.90.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4bee929-ebd7-413b-b447-08d822bce962
X-MS-TrafficTypeDiagnostic: AM4PR02MB3058:
X-Microsoft-Antispam-PRVS: <AM4PR02MB305831337EB289E76A0DD952B8660@AM4PR02MB3058.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WbWPIQCnlrAi/Iw3lMrMk1xIFwxCh5ODJvT0/RzVUj6mMJ5WsnPT560JrvKFcl9uR6LErJzfLfcGMr8SPY3EfEVxfCBGkjY1g9AlZYVb9+ynInDiG3cPF21jIeK40YDjZkMkQMX/22QYP2tC28IkdKVp071AHC6MG6Tmro+VUMQqxDvThhomCvKaMwjJJDsnL2WvoevgIdpauPtcHJpFY+FCmxdF+dZ7fMF4y1cfERL9OzOswKQ91LN8Gw548el7a40Bjt6FRXtSF1Vhs+rrwXVrwfl5sijGOs+4i+JMjWTXxVUcgkpFl7Ee33p+QYSNXo88tYhZHKdE0o/y1ONEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(396003)(366004)(136003)(376002)(346002)(1076003)(52116002)(6486002)(36756003)(83380400001)(186003)(8676002)(16526019)(26005)(55236004)(6506007)(4326008)(956004)(478600001)(2616005)(6916009)(316002)(86362001)(2906002)(66476007)(66556008)(8936002)(66946007)(5660300002)(6512007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: flLZGA34U6w5zBmgREjSsrntPwM2W219R5C4JvNk3cIe+Kstjg+n2A/AIegQE25ev+QcaHZRq4ASqQUNFGYRz2CR/H9gzdirPYPkxD+CkHolhtsFn/fUsdpAuOH8Z7op8JRPL8VOzRrM2NsAmSqCtXxc8P12CxnA5lQ9k/WObmrpUDWWjUPFqRuhv6zIB3Jkr+kcJm0Gicz7ILbEESAndJvGS3g++afg8ye8/NG++wDaaJE2itPKnQN7emNJvi0/3WI9Ms3fjVqDPrxZD2Ns6ShomvOtMdvgYQFzMhJGG5KozvnE1bejTnBeq6p8J7rRh+OnS2XnCJZkRXLdpAKnEKGaajwLPqYVtCvGVCsmcj6gRFWif0kkkGf6N9bCPg3nQBAJK3VyHZGcAZvg2TvYXK3nLwQx0lIxzWkaXL/ARBr1JGolx9S5zjLTMkMtycSP38WbLlDBvrNtnSii1O15YxUMTKlTMM8bFJcdWu1L0qQ=
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bee929-ebd7-413b-b447-08d822bce962
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 21:30:04.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/A+5LUbxQZ+EWKvG/B/J+br5i4R/4Gma8uwMHfZ5eg8FkhKifFQC8eYwgVXfndCRZH4vi6z0UuTo/lrZaLeEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB3058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an old hash that is not in use anymore.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/habanalabs.h | 2 --
 drivers/misc/habanalabs/mmu.c        | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index a61aab09778c..ea0fd178accb 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -780,7 +780,6 @@ struct hl_va_range {
  * struct hl_ctx - user/kernel context.
  * @mem_hash: holds mapping from virtual address to virtual memory area
  *		descriptor (hl_vm_phys_pg_list or hl_userptr).
- * @mmu_phys_hash: holds a mapping from physical address to pgt_info structure.
  * @mmu_shadow_hash: holds a mapping from shadow address to pgt_info structure.
  * @hpriv: pointer to the private (Kernel Driver) data of the process (fd).
  * @hdev: pointer to the device structure.
@@ -814,7 +813,6 @@ struct hl_va_range {
  */
 struct hl_ctx {
 	DECLARE_HASHTABLE(mem_hash, MEM_HASH_TABLE_BITS);
-	DECLARE_HASHTABLE(mmu_phys_hash, MMU_HASH_TABLE_BITS);
 	DECLARE_HASHTABLE(mmu_shadow_hash, MMU_HASH_TABLE_BITS);
 	struct hl_fpriv		*hpriv;
 	struct hl_device	*hdev;
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index a290d6b49d78..04303950e630 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -502,7 +502,6 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 		return 0;
 
 	mutex_init(&ctx->mmu_lock);
-	hash_init(ctx->mmu_phys_hash);
 	hash_init(ctx->mmu_shadow_hash);
 
 	return dram_default_mapping_init(ctx);
-- 
2.17.1

