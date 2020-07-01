Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4138C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EAB20775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oppoglobal.onmicrosoft.com header.i=@oppoglobal.onmicrosoft.com header.b="G5Vmq7+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGAHBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:01:36 -0400
Received: from mail-eopbgr1310085.outbound.protection.outlook.com ([40.107.131.85]:54539
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727959AbgGAHBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAOcqkdaSdkCLJKJXAYQEwz76zZVfvWyYH4w1M3w51AFOyNOuDsO1l0IM4wK2ujfWX2uaNvNzGTGchn8c071V000+X+FXuNgYuCNAJQWDuVR8wWQANRWRqFJLhPLbUHa/3PbMvo2P7AiWaYRbyQQ8TjnMwTVj+TdUWO0sXYLMKSG1NrPOCNT/bYEU77Cp4e2121TrHVfaUjNdDY6IpOZ51CbPdyGMCEwOBQbtaRMS7P45p5eQbvaO1kx3SFSZwoLHy3H8fZuaC2oT4OOFd0W7APdb1F+Agkd0K0XOHzR3PX3outTRi8Y/0xPNOe1fpfAySkYnkXLKz4Q1tgZ2BtEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+iiegB7SmB9uLlhXYIhizTg8WDqm5mOCBNgtxKG25Y=;
 b=OoIOVHdCPrdkyoZvqD1ZsCgA2QHVtzaZoCzVLAUAOIZs0pKUkDmBVIUpCUhzkhvcD9xL0oW4WkroA3TuaEhZYMPm0YDbB+mBJgt7q0510gojoffiRx689yB3SBWy7EUnSAnC2A8GXObLteP+IJevq3rnCCl36Fb+6LMd7fh7wqTnzmo4J7DNyxOES84yThEhoibJ/rIFSXHCyyJBg93rYxBfWbty+jr/YYdHXYvrzX+VW6glktDyC/7af91S4VLprzUMoNCayK7xh3/BDXQMm97tQsAnpuHKOs9lCluqPfdnmzYS/nykJZ98q9wrtWsp9vOZWhHr6/G4AeCkh+dRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+iiegB7SmB9uLlhXYIhizTg8WDqm5mOCBNgtxKG25Y=;
 b=G5Vmq7+b7RQaeimbtemAkZIC4vWTDf0muTRF8252D/Hb6UHjkQ+oEZHozzAzic/9WzCkChefpqEeBls/EWdZpn6E/EJehN4Mal55q0k8Z9KUWSm4IUEyNjpAORIJpA91qEHlx53+JcM2q5f5B7vlP60y1Orf2FeOJ3XB23TaJxo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HK2PR02MB4033.apcprd02.prod.outlook.com (2603:1096:202:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Wed, 1 Jul
 2020 07:01:30 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2%8]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 07:01:30 +0000
From:   Peng Hao <richard.peng@oppo.com>
To:     maz@kernel.org, catalin.marinas@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Hao <richard.peng@oppo.com>
Subject: [PATCH] kvm/arm64: Correct incorrect function parameter specification
Date:   Wed,  1 Jul 2020 03:01:12 -0400
Message-Id: <20200701070112.384151-1-richard.peng@oppo.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SG2PR06CA0156.apcprd06.prod.outlook.com
 (2603:1096:1:1f::34) To HKAPR02MB4291.apcprd02.prod.outlook.com
 (2603:1096:203:d3::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.adc.com (58.252.5.74) by SG2PR06CA0156.apcprd06.prod.outlook.com (2603:1096:1:1f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Wed, 1 Jul 2020 07:01:29 +0000
X-Mailer: git-send-email 2.18.4
X-Originating-IP: [58.252.5.74]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 601a0574-40d2-4ae9-b5c6-08d81d8c94d4
X-MS-TrafficTypeDiagnostic: HK2PR02MB4033:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK2PR02MB4033133F6B75051378438C8EE06C0@HK2PR02MB4033.apcprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1g/yXVyJdWKufZVBb+MYrDWxs0gjOTNIqik3N2gQHDjhTniMIHlImn9nsapQnPr8qUDFA8PUC9vAQa8YYxxxOBs4JkKloIDoGb6+8g889gPsKVrCtFYeTkBi6FmG6oF6mVBfNRGd3BjHqWL9vl14j/dg2NUCvAgu0aNrlzPXaW8wXxhRl6RxohFmnNbeeIJbEZuzc4IzsaBEoHcZt/+p88xq/kjkNFs6bDNlq1xHu8NrTwGOLq4ISN3OV3G6XoETNmzxLWSci2i1HEXE6daUT8WMsL7j9ubRmflXuPy7gAmsaMERMl1CdVB46PDsusszV6FQWDsJtvNb70TqD2Wy3ZkELaD9INPMffT0ugVNtrAgvBM4I7l/npzY/4LbXLtIv5HcZeAtKN7VYaFR8WIUWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(366004)(346002)(376002)(136003)(86362001)(6506007)(26005)(52116002)(6486002)(186003)(478600001)(16526019)(36756003)(66556008)(5660300002)(956004)(2616005)(66946007)(1076003)(83380400001)(8676002)(6512007)(6666004)(316002)(8936002)(107886003)(2906002)(66476007)(4326008)(1670200006)(11606004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JF6HQBJiCTRN/d2YW8Qbplf6eqaELivka0dXXlhyXc1N9hjgLJETMXUeRSyqJnGbr87N7GtZW2zQBxjdYPYodzVZ8g54SVW2vAj5dYdHc7+SHdpeyeTmydIjO4kKX/nyK+kzozrStZErQ3bRPXZwW0R1L2G6Y1jEko1iaekJI8cAe3sYwiyX7x4fRW40msCkgSJS345MrSJ37kmUdxi/zim5UzcjaF8uxiUpp2lhsLggY4rYRNVD6XuqN7aOkd1hkprvcyRQIg6QtL+gQlzCUyc0letfT0jWQouJEDU+rqZsUUOC7BoOUV3PK7SP9i31rrPT+nJfYmsZGHExQ+kc8vpxklV9ML5MkwcX6Kay5aW+AYl4LtPcSwghyCfoPl/a94BFJdXezBaqzEe9I8lZOldyU+Nw2meliJ+ysUl/i3A+SxI0qtGF//6INvsW3EeyQ7EPI92lYL41A/+rE+DZuWQnY4f9AsqzAIxV0470zLc=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601a0574-40d2-4ae9-b5c6-08d81d8c94d4
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4291.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 07:01:30.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnwxqpIZkoKEUzqgGMxTAXslPEoGtUPBDyK40195Va6VLKq2D7Im+KzEcwWiS/5naic2LvMqUfH0iY1mv28VWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR02MB4033
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
  * update_vmid - Update the vmid with a valid VMID for the current generat=
ion
- * @kvm: The guest that struct vmid belongs to
  * @vmid: The stage-2 VMID information struct
  */
 static void update_vmid(struct kvm_vmid *vmid)
--
2.18.4

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
