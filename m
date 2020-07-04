Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F44C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 19:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A482065F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 19:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Z/EbyJVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgGDTvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 15:51:31 -0400
Received: from mail-vi1eur05on2122.outbound.protection.outlook.com ([40.107.21.122]:50881
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726153AbgGDTvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 15:51:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcR4I9wmaf7N1bdz2+o65gxPI2SULZpYYBwJlBZspflbYSj4qhnZHKb2eif26LaP8hvGhlRiMZkyA599rGuTAJoyBkhLOCBQV4uxEZC8uRQzqbJ1OVC02EVlZMJrr40Us/wCNIB/wL+fC1APzXXGemoILeqejEnRWpTljpuqHql6QceHfeEyIHxe+uSrz4AeKRXNXc4wkUHB3y2ZbFMHc+Lkg7xRxBOn62wyxlSB2yGX55DpOo6YwiTTvsLnRyCc5vXT6Q9OgEImylxZ8mgndDxjQVNkEmoNfSnyUnbRn+T05xD5PFqGa+lecjILeyBUOr7dRKJJi31lUD091EXWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P9wgpTAINi7FlZDMzG43VjQtQENuXfeRzr2H7Q3txw=;
 b=dDz9v96OSKz6GMc5E9HtwvZb1A83LhfkiIFvLkzyiTun5PLJT8xILnfI5ClYwarF29qnuZI9USe9ZROMnTEmfu6uVqkXzDgedZqmO5raaPnt6C7pRByCeV1uMqn6tB3o1mNMglB+jLh0pUC3ihNZmK4E9Fr80/uiaLbqkMU9eViHWJOUTwTEd+/He9kU+7BQZj2mmSFuJpMEgSAKAXNX3qDJE3PyPyBd3x77/SCEc39XxRMMz0Sj7oDwDOsXWSYxVf1weifPo+rB3RI8qzySQvYR0tC9RJkkQa41O6Tth/0wB0AbBoKhyOrBCZCm1mjvZn+C1Tdd3umyjZ72PvvPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P9wgpTAINi7FlZDMzG43VjQtQENuXfeRzr2H7Q3txw=;
 b=Z/EbyJVPcCL+oZy3x4Z5eHsH5ehuwmJNejRY/uCFsE4/g9cumVxiuJ300mbpYJZAQogk3a3WUPVVrS9UNMTkTFXPPpL76XM+4VJ4gExVCwF14MjnV+XNEJxslcIY5DV+4NOgpSExPdc84+1ig5UIlTKqchIbIsEKRlX+alpiFtE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM4PR0201MB2177.eurprd02.prod.outlook.com (2603:10a6:200:49::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Sat, 4 Jul
 2020 19:51:27 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e%7]) with mapi id 15.20.3153.029; Sat, 4 Jul 2020
 19:51:27 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     oded.gabbay@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalbas: rephrase error message
Date:   Sat,  4 Jul 2020 22:51:16 +0300
Message-Id: <20200704195116.19669-1-oshpigelman@habana.ai>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0075.eurprd07.prod.outlook.com
 (2603:10a6:207:4::33) To AM0PR02MB5523.eurprd02.prod.outlook.com
 (2603:10a6:208:15e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oshpigelman-vm2.habana-labs.com (213.57.90.10) by AM3PR07CA0075.eurprd07.prod.outlook.com (2603:10a6:207:4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.14 via Frontend Transport; Sat, 4 Jul 2020 19:51:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [213.57.90.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d412362-6be9-459c-b91c-08d82053a3a5
X-MS-TrafficTypeDiagnostic: AM4PR0201MB2177:
X-Microsoft-Antispam-PRVS: <AM4PR0201MB217741C6D60B4DF45D687E0DB86B0@AM4PR0201MB2177.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juQJ47Z5jv6E0XVdt1hmh3cOuWsAJzWMOpJEDbk0SUW2RXWIlziDztN+o1OuzT/mUxSUQl8hlIlMly+qhaQzeAjGyM9+cgziSSnI96/qNkvAAS4NoSfLw/cIFEKZhqAkxrnh79B4wyMBkHYiASs5dMy/UAJ11T4V/tyUn0e90c6xwSGLYSFUATcHu06Vp2T+KZPQK6kdur1BwefxpySD9zlDbU0KirRcIfj6E0IveBZ3JAIdTZu8t/NGaH7cKe8AfWlZnJ0QyiPQ4Gi/W6cwXfmjPcD+eYaP8lVtLckfGeygn4wVa2ekq/92j6Ulz/CdkvzoHUAAQIiPg6hUhdW+1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39840400004)(396003)(346002)(366004)(136003)(2616005)(478600001)(316002)(4744005)(956004)(8676002)(52116002)(6486002)(16526019)(66556008)(66476007)(4326008)(66946007)(8936002)(6506007)(36756003)(83380400001)(6666004)(186003)(15650500001)(26005)(5660300002)(86362001)(1076003)(6512007)(2906002)(6916009)(55236004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6hvP8fcp1T2sDLx6qQNkZLZfYzG+p4uxpZ97HoFwPJFNoloURNAX81+iFKX//4AtMyJ6v4JGBVSKZbEr/Eq+oXOMYV/c9YT7jMhuJRhZ7JpR8Sj6Cv97mrc2bwiDdRzbIFXj+nN7i35T+oAiBfFY87QxORutvvFpq7TSOsBUP6kUfk5xe/7eMAbPx0uxz9KZYtH0cXj21GaUlAG3YaTmWQjq0zkdUtPvPIPKnYaUpozNCqNUv1kakbDSadQlB3MOw/FwarTEVF90XWe7pnGzbwK11rMhUE0bx/iUXtMikhfeWXRoU6QUcn/9AdcaRfX/gpojjkyYcJCHvQjjxOeoHZa3b97+cBVtwzU69p61WOiecK63SG0MOngS370flYIjKiTlojs/+QljUQ80tPuVogxFaL8Nnlzcw5uZ6RSsVEPD3VhAoYhqTgu50pXlxNhls8y4fh4NH/vRVbNAfYA3Ea05offI+yjb0ma6+tZkDkY=
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d412362-6be9-459c-b91c-08d82053a3a5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 19:51:27.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cb1l3jXTUcIpnWYhdR/9G1a6eEcm1YIeOv4hUwe76xOBI3lp8giHmPaUTZylc8a5gCes+p1A5iUtUT9a0kPJTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0201MB2177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rephrase F/W error message to make it more understandable to ordinary
users.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/firmware_if.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index baf790cf4b78..171baa2b56b0 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -566,7 +566,8 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 				"Device reports FIT image is corrupted\n");
 		else
 			dev_err(hdev->dev,
-				"Device failed to load, %d\n", status);
+				"Failed to load firmware to device, %d\n",
+				status);
 
 		rc = -EIO;
 		goto out;
-- 
2.17.1

