Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E091C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 08:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D8A20738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 08:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="YO7vvYr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgGSIAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 04:00:15 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com ([40.107.4.94]:40930
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgGSIAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 04:00:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deyVSXqbMOekOFpYrhEcOeMeegyS0lVkfXQoo88jfxcMzzSj8PPpZ/yA8sIiAPN34pWhopVVA2f2bjfQ+ZhPu3G6xC1LqKDCyx5rj0n6G0So3i5HuTuKat5dNKtdBU65CQfUiQ1WnvW7KPWo1MZ+yQdLvEvnI3KBF0Mz4Uu8J9Ml1ZWjnI/nkQnvEImVEA1PafEkRcO2XOInQNpxYym8v351fmOpSB1md/BgOlnljpU2EELJp4oj0kZeLvF0ap7JQWLxeAk8M2FsCLy8ieVor6Bo6OfDM8wXnIHnxQu99dRyKr4FKMYuUEEASBmYfnggHwMa8g7qh6YQQOn6cjFqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/d0vnu7/mCXMwdnbSjpZvp3rtnDvyPj9MvSuF0CA6M=;
 b=dAyeA4L0UbOx43bWjnPi48IDSrx9eTOJebkJNsVayVA3pq979bA5bthrksFjlpwFsVRBY0Bp1JM2j9mJyg39gKaKJt0uksJYk/9ynGua3CxoTc+DBw9yNcge3DzLrB5y0lM7ByFUbIOe3jinvv0ksh27xLO5fuxuNRWnAccboZ/ue0GNlcxsrnrLhjpXZBh+v2tSof2MZ7VtHTejIX8op0Z4ZfCAcylsujo3zfgXAXjlDYL6Yu1SXYLKVTJoOd5HdtMnNR+zT7YCosSEyJKhoqB8ow1BcUu1lLvpQzxgVxJ2LfCMovOYmrrT46Ss/145I3NXNttGu8Kp9p1LnGuvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/d0vnu7/mCXMwdnbSjpZvp3rtnDvyPj9MvSuF0CA6M=;
 b=YO7vvYr0Ly4kksrbiVltTwaQWkE/Er1wTMys/aadKnRsn1ZZ0kWBHvbeiOlSFSGs+rmJ1mGgOTAWzBBd+SNOYBHDsPZcidWJ/t7+qpbMyrpa4eBAB39qH8lotr2kh9FhuXz6b7nL/lUC22OndOFu5Bi0tBMk7Iud/IQbQp5Haw8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB6PR02MB3238.eurprd02.prod.outlook.com (2603:10a6:6:23::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Sun, 19 Jul
 2020 08:00:11 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3195.023; Sun, 19 Jul 2020
 08:00:11 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     oded.gabbay@gmail.com
Cc:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: use no flags on MMU cache invalidation
Date:   Sun, 19 Jul 2020 11:00:03 +0300
Message-Id: <20200719080003.19692-1-ttayar@habana.ai>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To DB8PR02MB5468.eurprd02.prod.outlook.com
 (2603:10a6:10:ef::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ttayar-VM.habana-labs.com (213.57.90.10) by AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Sun, 19 Jul 2020 08:00:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [213.57.90.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c2c3f8-91ce-413f-4bc6-08d82bb9c2c4
X-MS-TrafficTypeDiagnostic: DB6PR02MB3238:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR02MB32388A9BF5F0AB9327A6001FD27A0@DB6PR02MB3238.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KvKwbL9cgF20jkllt6TAKloUH7HyQAE4nUXg9aBYNoBpKPCV7apP9/ZhPH7Y7KPRGBRERt6cKlUs9lxY3S05Nw4xxRwxjrfLDCumyF/USDYPU6Wn161s/dPL7KJP/rvf/wK4hNqka+zt0y2RU3jGp+MUOcvdZwKvSTUPG/5OMj5Zx+DwFxHrDoGqztopT8+3I3l0+cD/BiGAP0ARf2w0ZvlRqhVHciOgU1w3KtToYgrg0yjinzujpbi6ibwih6o/4vPet3Gjmnbjb52UQ7LDf9sxdmNxsOGuOAtVGdmvkIX0dCPgDALZAAWrGIV4Du/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(376002)(346002)(39840400004)(396003)(8936002)(83380400001)(2906002)(316002)(5660300002)(956004)(55236004)(36756003)(2616005)(6506007)(478600001)(107886003)(6916009)(86362001)(186003)(4326008)(26005)(16526019)(52116002)(6666004)(1076003)(4744005)(8676002)(6512007)(66556008)(66476007)(66946007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wVSa6xICJoYEN2kExaJsQrgdBHtODSqHc+K6eYQpmWQs2VUdJ0MhckqcCS1Rn5mQDRVPvQvDgOJ2jPP3ZsRVNI04L8dplnlIhn1t7Un/Atn18u1B2sydXBv4uAbD40KF0SZwuKKKvEJH/bAINUagzhfLMQr2UvmHg1R1zKXmp1ebViHNTMQlRlRF9mTMK+g8K0yclFyCwslucmiyy0+DEu3P/gj0w66/2iZ6IGkUU7SK0ETE2GuGFJVplY7da4n9il3OpHBN9joIBrxPajXgDerjRVvv0KYfhmSZBjIFmEaNSeuVm+J/6MLgujMiNGiWdlUw1xZ8E8BkhDiQgO7AK4DUEumoTiNelmVswia3rf58UwIsFDmVFVO3MRXvZ6QVGQ5PDI2U9qkh1aqKTgsTschCpW7a1NBuMHqA8pC0zqaNs6+aFqxhQXS+VU+1K98e9PfFflb76rrQR9Cky32OIg5nPTEaurSf3lAkplOFukY=
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c2c3f8-91ce-413f-4bc6-08d82bb9c2c4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 08:00:11.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmrLVwwJM4hsG8Ni2q5TRCBZyuR9u7fDJLnKdqFs6vWIELF1Ot0eP5kQR+fqL5kR+l6ycDHGEEsd7/Rwr6fQMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gaudi_mmu_invalidate_cache() doesn't use the flags parameter, and thus
it can be set to 0 when the function is called in the gaudi only files.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 86cfaf73ad74..4a1a52608fc0 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2646,8 +2646,7 @@ static int gaudi_mmu_init(struct hl_device *hdev)
 	WREG32(mmSTLB_CACHE_INV_BASE_39_8, MMU_CACHE_MNG_ADDR >> 8);
 	WREG32(mmSTLB_CACHE_INV_BASE_49_40, MMU_CACHE_MNG_ADDR >> 40);
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true,
-					VM_TYPE_USERPTR | VM_TYPE_PHYS_PACK);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, 0);
 
 	WREG32(mmMMU_UP_MMU_ENABLE, 1);
 	WREG32(mmMMU_UP_SPI_MASK, 0xF);
-- 
2.17.1

