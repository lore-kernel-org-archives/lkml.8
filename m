Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE2BC2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932CF20672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="cNa/Exsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgDETXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:23:09 -0400
Received: from mail-bgr052101131039.outbound.protection.outlook.com ([52.101.131.39]:36883
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727677AbgDETXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:23:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQGwwEzzUONWWDNIGiyOpEzlbVVzbEBLK81s3notM6Ug/bEwUR5d5l0C5KactrSFXSLdq+IJwfWwQpecMRTV6FAX/+JhVqL2N6kuCwPlN1VclqRK9wZXlyY0k3d83pRWxPIU9WqUBZ2AN3CYWGHabdtSy4mkceAyKvc4dO02zb7udfcH51LLvfMpMp0r7Vubz6vKmqoUqc2Nt1xcO5XmhPq1RUIIKWOb/DQjJMFYE69UsI3XTjxXqBUkwg2hU6AXcD18Qr0M9zpS3ZC5yJJB7ZcwAprEPM/XXiTeU8e1p2G3dS9yE8fi3kutYYKw9Ra9ZjbEPhFFspW5rfK+z+GZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oei/HXHUctjpPeooJUQPO8FgYTE406Y1Muz/h8PRie4=;
 b=IfCa4Uo1RBIvuhpQlxV/RIxhZ6NySW/ZXnRSCT+4CnJJ8aW4HAwirgT91wi2rlzhFM7+ccu9tER4w/2HRWQXkqaYYv3hVdzQ/8V/w0wcA+WxFLgtuINbXlgVcb8c57r9rd139lsjxucXomA60akXY9VygoOQUAiaKts4Cd43YGZ577PRO7A1UfvN1M7X0vjF0xcDmmJoC+2+21J7EFLdCL+bVVN5d5K7hnNptUWv/qfELNHOKw2+b105fdmb8SM674fvy3Nnex3uJRS8UoQQmbrXRGHgennEC1I89FjzcK2CqpOY2DMR3MzdG5z7+am+Mj+hPqBJlOGB1t4zbqrVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oei/HXHUctjpPeooJUQPO8FgYTE406Y1Muz/h8PRie4=;
 b=cNa/Exsc1mv82j3E5JYggWe92ueLxuKG2+gFbEyijw0r105hjzPpE4DOeZoxB7gJF2uWG9SFZJfODXgGkfmaY659JwiJRhMrhmGrow/HT46rOJVSs6tl3Jcvv0kjNAoxfvzmau/KLGZC6KA2hIFsTXUaNdrFnfkFlCIRzHwQnsA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
 by VI1PR05MB5373.eurprd05.prod.outlook.com (2603:10a6:803:b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Sun, 5 Apr
 2020 19:22:54 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 19:22:54 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     devicetree@vger.kernel.org
Cc:     Paul Barker <pbarker@konsulko.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/6] dt-bindings: pwm: add PWM_NOFLAGS definition
Date:   Sun,  5 Apr 2020 22:22:41 +0300
Message-Id: <20200405192246.3741784-2-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
References: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::27) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by GVAP278CA0017.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Sun, 5 Apr 2020 19:22:53 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4e92dc1-3b75-4e52-96f3-08d7d996bd4c
X-MS-TrafficTypeDiagnostic: VI1PR05MB5373:|VI1PR05MB5373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB5373745DDAC23225D23116E6F9C50@VI1PR05MB5373.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR05MB3279.eurprd05.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39840400004)(136003)(54906003)(6486002)(55236004)(81156014)(2906002)(8676002)(508600001)(86362001)(52116002)(6496006)(26005)(81166006)(316002)(8936002)(36756003)(6666004)(956004)(66946007)(2616005)(1076003)(186003)(16526019)(66556008)(66476007)(4744005)(44832011)(6916009)(5660300002)(4326008)(23200700001);DIR:OUT;SFP:1501;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4kB8VhwXEbk3p2tfyksV1hda+DLeWCr8GOfvsZTOwhk1oPXJ+b+gm3kxEym6n6gcv7awfdRMMVZEcOkYkuPHrfoHb6DEnA/R/Ny7qIg6AgCocgA6n5VULBkC/wGq2OA3pfTTix0ggdGICtkj+BPThTnj78L203kiibDZygV/GInwMmI+xe4nqH2GcgcfSbtwXhAfEzWBFyKk3o1coH1e2Q79rYzBdBylYMhP05X6Mp9tR8pDlnadhVxYN2wUElrjkbYD+/5sF27Q6GKxHbpd6ceytyNvjl3kpfBTz0O2PwlRRWVtazEOwAvyA/d0CFi2IwUR5z9XzOvaODypZbOqnnTz08EteU7ga00gJUJVM5+BXI7mX8mfGQOf6TThQ9azt3Dyn7WG9t8/rGCOH0nPJYtWDQwkfpHBBgES0LEQbIrq51Ub8sEj4wFxWUZ3lna6ErWjo98Xy3IajbFt+5T3iUzIkrVxGKS++z0OGXtDywTORnrUObXbTPpIQedHS2C0kD0yvf6AjcTVcYGr6B1NR443Q5vs5X2ez8TJvqFL7B7UPqWize21GYRpBRjDkY3RgC1ZMZ9sc2YrQ28LxZiyRZp1C2HooqifcdD4hkgkj0zJ6aM4WnHw8ptubFX6UTgR+IYwJpToegsAGePHa5YpI8U4oitLXJqLwBLHzWhsg87tGpdO/YS6bTYEcDudXYV+zElvhHlWmRZqOpH/k1michbp89UcTWtRzGTO50IvvNTnSFM4yeAXe8nHua9K9bOnzTYj6k/aWPFU8MUwPbkZQ==
X-MS-Exchange-AntiSpam-MessageData: RwyEA3b6hyKuWdSKMnudQsqMprY4Ns9mzLUyhvXIiyBzRw/gCOox6GlVdJMlcBg6zxiHHN0zzwXfzZywYcqjy3hgtGTmqke7z7jLNz3U8Z8Sm7oux39TOP0GeP6pK8un94GVE67Sgo3BQzhm6EbDWA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e92dc1-3b75-4e52-96f3-08d7d996bd4c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 19:22:54.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhF+iCDgr9c2q/uttVlCk80A6PGKIP3QJx7sBvxWFKRoszzxu29DfCpL/P+/DaU2KKJ2PibS6czwREsifigaca6k20BHZNlwVbw2aBW/P5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"pwms" property has the optional 3rd cell for modification flags,
i.e. the flag for inverted polarity. Multiple pwms instances in child
nodes all have to have or haven't this flags property. Now the value
"no flags" codes with the raw constant "0".

Define the PWM_NOFLAGS to use instead of the raw "0" value.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

Changes in v2:
- Rename PWM_POLARITY_NORMAL to PWM_NOFLAGS to avoid possible
  conflict with enum pwm_polarity in <linux/pwm.h>. Also, this name
  reflects the sense of this value more precisely.

 include/dt-bindings/pwm/pwm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index ab9a077e3c7d..f4cc763e159a 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -10,6 +10,7 @@
 #ifndef _DT_BINDINGS_PWM_PWM_H
 #define _DT_BINDINGS_PWM_PWM_H
 
+#define PWM_NOFLAGS				0
 #define PWM_POLARITY_INVERTED			(1 << 0)
 
 #endif
-- 
2.24.1

