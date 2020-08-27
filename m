Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93471C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F462078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2HbHSigW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgH0FnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:43:07 -0400
Received: from mail-eopbgr680064.outbound.protection.outlook.com ([40.107.68.64]:46486
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbgH0FnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSAGoMTkI4ydnyHsHlbHFIP8yD+8CRlb4ahltbPYwGKbyqGGsyoQHCNG98sTIofYC/xrUDLg3aIyyjfUB1k+bYiI7yA1Dql70RJGyHyZvU5IKweGKO0ucKXcEJi/wJd1ciLWADxjUnCJ1enkzBG6Hpn6Ij5NGZ8Rt3IcSGRlAR/breIbCrICniOU68x+9ghNG4FgoCIL8VXknYi1qYGI5IUabjJOWocmHxm3SstgH8CGA974QTW25wqL0o2ck5tFcLlAmsNhbE2czqzsFPgua996Rzp93lq7sScmmg3tAsWxghQwbYG9/xpts3eH6u2jJFhWC2GO+6eoUqCTKEQ9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4dWaQPxp1nh12mKbV4tYejvwCJbpAwC82bLuB38mV8=;
 b=DweKHln5gEJqDVOPn+yZSj4uvAKPN2zkFmW+YsYs6fP3fNIxbp1u9RMqfTOn8QkOodlQIzoz5p94Ez6UPaX/Nimqcltr1KM3JA+d+wpuE+5NiPl6ca5usruIvqFkj2w5hNS0RD+O0POwejRuu2ZsfO9bzaJdBlZPmoDQDV+Jwcj76q4NO+4h0X5lkkh15K7ssdPyiEsxthxkLXVRb+V/jCmx9VOosk1ZHm6hT1kKpl21ATN6qFscLnhMNzcpRcc9QA5dZA+bwfVxSpFDbMmLp0qD7cD8k6sPYBtBDKR/2U+YkDUtbAmDfM0ReAF1zOJThVYiT6rAHbXc0BqLCUl9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4dWaQPxp1nh12mKbV4tYejvwCJbpAwC82bLuB38mV8=;
 b=2HbHSigWpxTbuhWw7UrRkzc160HCRyNtfI0pdYtb82wp4Yg2Jlx8hitNO2pC7dUB6PPvE6h8KxwgaBo5vjs/MWqALdPPbMe+apYRzd9DwBBD6yte7+mPABpcsp1SiO48wg6ylg/vP09jySGcqyYqCEeR0Xsl5th242OMPOCDbCY=
Authentication-Results: ladisch.de; dkim=none (message not signed)
 header.d=none;ladisch.de; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR12MB1224.namprd12.prod.outlook.com (2603:10b6:903:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 05:43:02 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::f873:6fc3:45c4:2106]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::f873:6fc3:45c4:2106%12]) with mapi id 15.20.3305.032; Thu, 27 Aug
 2020 05:43:02 +0000
From:   Wei Huang <wei.huang2@amd.com>
To:     lemens@ladisch.de
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com
Subject: [PATCH 2/2] hwmon: (k10temp) Define SVI telemetry and current factors for Zen2 CPUs
Date:   Thu, 27 Aug 2020 00:42:42 -0500
Message-Id: <20200827054242.2347-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200827054242.2347-1-wei.huang2@amd.com>
References: <20200827054242.2347-1-wei.huang2@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SN2PR01CA0075.prod.exchangelabs.com (2603:10b6:800::43) To
 CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN2PR01CA0075.prod.exchangelabs.com (2603:10b6:800::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 05:43:01 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2a0344f-df4e-4df8-4311-08d84a4c0fd3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1224B5B1F1C1B30A9BC6602BCF550@CY4PR12MB1224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEiuIG4umQFQbpt+dyH08sUuLX8/VbD1Ra8N0Wuo+haMgEDuLWj+Zm2lYYZ88DnfvFV9ed79+iCvhEGE3YKik52ydq5m91ttP5IvWr3zBIvafIM30EH0cr+R9HFj53iIgNvwzUF4ZmXeL+kHZ7Xe4YQ6MxyIdfLBGoV1TPQg3UFn/btKgq9cKdC/3NPJd78hK4tm0aLff8Jln8SrA1FRT8EMneLe/Y3nKtwrqLbSH9P0V2AseR3+ex2qriaeZTM7DJVMs6K62wW7TKbheHqcsb4oQQjQz8FMuW6pI/lGGFDa11Fn+Pt/x30XsW9qjxMkVY4phj1wJLqWpMP8VFkclQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66476007)(6916009)(66946007)(66556008)(1076003)(2906002)(478600001)(8936002)(4326008)(8676002)(5660300002)(16576012)(186003)(6486002)(36756003)(52116002)(316002)(26005)(2616005)(83380400001)(6666004)(86362001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fEAzo4qJ/Db5/KPJ1D3RVao4dyc5QVxM6dwkIIy/1u1HfSpdV7seQP8otPbY++nkFKZ3VrP20BUQf+ClTk6LKSVB0jYR7Jwi9pshyDjDy3KciRG/7x9AEMEvc6MzbeZmPy0N+zo47eNmOb4ziWw887MKqlJHFk7QB/tBznHmmE8AdhWXPejOiUG/89pUiIOV0F9prkBdYVxzGASOv5UrmVy4NQEPZEwAAoE83+aesq5vc4UjrHhqEpK3EfDUb6c0pPd9tQuEMNRQIbzZJw11HdXu66iTeTScY5ts+jses0Lcy5FrqBSCuBBiLmLVHzM7zTEHR5S6QGjVCrkYDU1PxOBJ+vWzFp1ZrVh1BFa3PuEVP/9nbPXI8UM60I2fhdEwnKULviUicCGHktwe2D8FfZuUhEwqSl7sCfOwK+detO3x7PRaVzL8OWnJCvFu3agQt8qoSGGkRr9uzZr2U1fXsssGYW6EXy6gvyPTdJE0GFX34IgPHRuZp+UCkgrXsTNHqWQLJGMlzQ9wZ76tYkvbcHDUqFgGLKMQc/hCzpY5vtfqJqjsXQU6gUNhRdGI/+qazjdqJG9sNJPSBAhrc/wsc2L7hqv2xw8zwH0nqX0/kGAFHGK0mh2X8WAi2SLIRrNj5wIM8F9oBxyOJxLxIpugkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a0344f-df4e-4df8-4311-08d84a4c0fd3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 05:43:01.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFh1qrKN3GciBiF9zPStYLCqoTOfSrtRQ7ivVpbwlYGCmMSuX2uqVTAbdjS70yyq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The voltage telemetry registers for Zen2 are different from Zen1. Also
the factors of CPU current values are changed on Zen2. Add new definitions
for these register.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/hwmon/k10temp.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index f3addb97b021..de9f68570a4f 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -88,9 +88,13 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 /* F17h thermal registers through SMN */
 #define F17H_M01H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0xc)
 #define F17H_M01H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0x10)
+#define F17H_M31H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0x14)
+#define F17H_M31H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0x10)
 
-#define F17H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
-#define F17H_CFACTOR_ISOC			250000	/* 0.25A / LSB	*/
+#define F17H_M01H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
+#define F17H_M01H_CFACTOR_ISOC			250000	/* 0.25A / LSB	*/
+#define F17H_M31H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
+#define F17H_M31H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/
 
 struct k10temp_data {
 	struct pci_dev *pdev;
@@ -580,17 +584,17 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->show_current = !is_threadripper() && !is_epyc();
 			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE0;
 			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE1;
-			data->cfactor[0] = F17H_CFACTOR_ICORE;
-			data->cfactor[1] = F17H_CFACTOR_ISOC;
+			data->cfactor[0] = F17H_M01H_CFACTOR_ICORE;
+			data->cfactor[1] = F17H_M01H_CFACTOR_ISOC;
 			k10temp_get_ccd_support(pdev, data, 4);
 			break;
 		case 0x31:	/* Zen2 Threadripper */
 		case 0x71:	/* Zen2 */
 			data->show_current = !is_threadripper() && !is_epyc();
-			data->cfactor[0] = F17H_CFACTOR_ICORE;
-			data->cfactor[1] = F17H_CFACTOR_ISOC;
-			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE1;
-			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE0;
+			data->cfactor[0] = F17H_M31H_CFACTOR_ICORE;
+			data->cfactor[1] = F17H_M31H_CFACTOR_ISOC;
+			data->svi_addr[0] = F17H_M31H_SVI_TEL_PLANE0;
+			data->svi_addr[1] = F17H_M31H_SVI_TEL_PLANE1;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
 		}
-- 
2.25.2

