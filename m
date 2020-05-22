Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EEFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53172072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="GV4eylSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgEVHOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:14:47 -0400
Received: from outbound-ip8b.ess.barracuda.com ([209.222.82.190]:47974 "EHLO
        outbound-ip8b.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728137AbgEVHOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:14:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104]) by mx2.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 22 May 2020 07:14:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3gVtoO7z7ReeJb04Ica5NlNqamdwEPm8xWZpaiAR3P/1ddAl8rgpqJ2mssabg7ioaTCjO6vUn8WO5+aZtL/5yMcVc/t+ekReK4ApT/75VQsFTutwttxU3YMt3DSYbJAlr29RHXSSZi5QxJ7C1QR/H2u6zvqRA5l/0GL6ND76cn7/Li73eOFAcRJxQnA2TcVjxUVXOYicirAA09Scc7BRUu3iiJbqJltqIa4V8YeeD4L602gkfQ8tnJ59GpnYn8ODKs3EeIydoFM7zB1y4i72iLHnatrhC9rgrAcccUrtQIqGQVo2kj/kU9vhbfp2OjSwXo0j5ypYsZcR0U9W0a6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1ElRajXieyZM2RIf2Akwl4LiC5pfU941hcD5MHKnk0=;
 b=Oab3b9SZmdjEsMIIUR5NwfZGIcSllXUwaaoTOpBcUxF5WvcjIsc3tWVWuraz4GUnjnrJJhnQJvu4dnHWckmOYSEEk/ZnUEkAxT83SDVh2S+41QJUZeZxWyxlTtA2l6a6L/7nDh4MJ6uUcve3aQvV+wsnV/e4PFBVMqHP8sYdkJedPDh3IKeoq/ngiKyxTRyevqYiUSI/xHh3VCaYLnmKnMY+VPfXismTn3FLHN7ZslgX+BdRhsl4KHhzAlofritXmUAyhankmG4v7FYKpqOVZ6qZIIBxVW7L5GUuf1kI9r+kD5peWTcd9uM7B0ye1YbzUWatItW/npNbl9dcE9HIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1ElRajXieyZM2RIf2Akwl4LiC5pfU941hcD5MHKnk0=;
 b=GV4eylSAglKqOrydJvZbphLJLWn2ixeS36orCwTTyj6xB1tvZ3r2N/QFvzlwXo02WDcXhk9bgyrXyG5OV314QO6zdq2gsVCqRdWbavSBR2Ik7R/Y/BopyvV55mMYMExTvd/WNsEYsWRgxMZx/iDcsyVypJRZEhyR3F+TMgIMzY0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=biamp.com;
Received: from DM6PR17MB3420.namprd17.prod.outlook.com (2603:10b6:5:1de::18)
 by DM6PR17MB2219.namprd17.prod.outlook.com (2603:10b6:5:b2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 22 May
 2020 06:41:07 +0000
Received: from DM6PR17MB3420.namprd17.prod.outlook.com
 ([fe80::8ca2:ccfb:f717:a7ad]) by DM6PR17MB3420.namprd17.prod.outlook.com
 ([fe80::8ca2:ccfb:f717:a7ad%4]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 06:41:07 +0000
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        pmladek@suse.com, shreyasjoshi15@gmail.com
CC:     linux-kernel@vger.kernel.org,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Subject: [PATCH] printk: handle blank console arguments passed in.
Date:   Fri, 22 May 2020 16:40:29 +1000
Message-ID: <20200522064029.1510-1-shreyas.joshi@biamp.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200520115023.GD520@jagdpanzerIV.localdomain>
References: <20200520115023.GD520@jagdpanzerIV.localdomain>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0022.ausprd01.prod.outlook.com (2603:10c6:10::34)
 To DM6PR17MB3420.namprd17.prod.outlook.com (2603:10b6:5:1de::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from D19-03074.biamp.com (203.54.172.54) by SYBPR01CA0022.ausprd01.prod.outlook.com (2603:10c6:10::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25 via Frontend Transport; Fri, 22 May 2020 06:41:05 +0000
X-Mailer: git-send-email 2.23.0.windows.1
X-Originating-IP: [203.54.172.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bf71600-ed6c-45c7-74ad-08d7fe1b1afb
X-MS-TrafficTypeDiagnostic: DM6PR17MB2219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR17MB221919725FA2976AD8BB2659FCB40@DM6PR17MB2219.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVCqE/tbjwrKSRHl8OtfyyPe7mZXSuoHMFqPSCh2/Y7PTkCA+mMYYP77NipWuy/3uuv6IKCgonbT1DQmcOhokbjXSXI8N42g58P/AD1sduvnvaY/54EvMpXhOkARVOPfLSm8/d1hJi/BtiUWkvNx/uHLvrz5SHvBUDIq0CYLdTDteGxim2dqNR3g+xWdBIR6KQ/ot7+RVXF4OWhB0EqljBPN2Y3OQSrE6F+XbGFskzZTF8hSpVNKm20spZNOr16AYR+iDpPTKmL5y8A9XvzYJXPBIj01BO4oNo6mniUtFxvkuL4JhiUwj5BQtuGOMhyvHKnZJysBqkHUa2mMpOhc9JdQF5cLcsEbhNZs1NMMJA3Pb0CzBlmk2keB0CVybuvDRivuIztmulq8V7V2JiIGfUEKOXFBn6nq0yskinTEUPkzzXhzLrSLUsIlvsldhnkU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR17MB3420.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(396003)(39850400004)(376002)(66556008)(8936002)(4326008)(316002)(16526019)(956004)(186003)(2906002)(44832011)(1076003)(36756003)(7696005)(52116002)(26005)(5660300002)(107886003)(66946007)(66476007)(478600001)(6486002)(8676002)(2616005)(86362001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: VwIaJZbhOIIWWl0jDfA56+95cRj5fOPwXub5C88RVIzdINWPcadJpauTp/pxaWaeS1ZRYf8Ni+v/bHV/z4Ou840JWzpFjd3ZuDYuHXwxnybz4NNfuXyEfKlKIXOcGcxVei0gubmp84hoOqBXk/Qof1b38EB2AGpetdDchm+PIqoHk6snjJrvYdW04HQScKP94qqjAKVBovDkvjsal2rHLe+xwmAjqn78p+9b843SdGybRWqd0yMM9P8YFoA1pJSzSiwSN9UIx9xPHy4imRXW/1sWt5+XH6aPa640MF6Vg4Ta5TEoWTmqT2iZVzaKgzanLr84jHUcX02XgBiUDZtU+kd7dpSusj5/pnadpMy4x+C8K1OrdRnX121JX+uBfiXrOnjng6y0PCZeQCj1Z3eBoBcGJsvKvKoukM6A304EVtD8rBbuUtOmEEf+KRmVKbAEysjQFau5C7rTCWWAWwIbjc5R8cIzVWGGIX5vA3lwhnI=
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf71600-ed6c-45c7-74ad-08d7fe1b1afb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 06:41:07.4668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8d89IKB5vMkXpO88YWfSyJHu2XGmRB/PWYE1Vn/tDSyC/GoCrSMsQyGcLHfkNgcBkKdXuwKafAEZU0s1HYMjuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB2219
X-BESS-ID: 1590131651-893003-411-33202-1
X-BESS-VER: 2019.1_20200521.2236
X-BESS-Apparent-Source-IP: 104.47.70.104
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.224285 [from 
        cloudscan17-63.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 MSGID_FROM_MTA_HEADER  META: Message-Id was added by a relay 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        1.50 MSGID_FROM_MTA_HEADER_2 META: Message-Id was added by a relay 
X-BESS-Outbound-Spam-Status: SCORE=1.50 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=MSGID_FROM_MTA_HEADER, BSF_BESS_OUTBOUND, MSGID_FROM_MTA_HEADER_2
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If uboot passes a blank string to console_setup then it results in a trashe=
d memory.
Ultimately, the kernel crashes during freeing up the memory. This fix check=
s if there
is a blank parameter being passed to console_setup from uboot.
In case it detects that the console parameter is blank then
it doesn't setup the serial device and it gracefully exits.

Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
---
 V1:
    Fixed console_loglevel to default as per the review comments

 kernel/printk/printk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad4606234545..e9ad730991e0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2165,7 +2165,10 @@ static int __init console_setup(char *str)
 	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
 	char *s, *options, *brl_options =3D NULL;
 	int idx;
-
+	if (str[0] =3D=3D 0) {
+		return 1;
+	}
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
=20
--=20
2.20.1

