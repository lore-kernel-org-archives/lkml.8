Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C360C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CD620728
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="Zos5HIhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgCIFak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 01:30:40 -0400
Received: from outbound-ip8a.ess.barracuda.com ([209.222.82.175]:33384 "EHLO
        outbound-ip8a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgCIFak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 01:30:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47]) by mx14.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 09 Mar 2020 05:30:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtXHY0QBimlD417CRS4BbCbpALlU1wnUsFM+UgTM5g0ZsgFDq2ZybxonyfrX8VwiuUP3kdiiqj0QP65LVb5n0kFYLw6Z/QXVhnSGrclNAYgEBZFqmy2Wyi6KgZR6N9pTqjL4vLbfG+UHxz3i2jro8IM8mlkLHMfbNUegu+oF3LqwqQzJhJtaE5UzUkKsX1jQHKKFlWSeu3bEel7Sowh5aXCrjpN/dlFRt38AD582979ysEqDU9K/CvwfhlgMOzIn+iLOfR43ENaacQ5EbiLQ8Piczz9iHc1pxEnRHEqZlA546DYrBSy+Cd8gl09Y0yMFAlPwMdsy+v+AFm7RQJ6/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFf9ZtIpWPuQY9n7bSJYecWNMLG8qNF7yhkgkdieZMw=;
 b=e5JiD0ZeX+ptSVx6Jyj7jyLMq59CIrD6wNmiNKW1i4Xpv6sy6A0xd+BGY0vM3W8GlyiFr2gLyYsPdT5UBD4q/PI/vRamU7/hdte7k9ZbtuXjoBAlOUPu8qnk6mKslCI7TCebRqcoIFvBZgTvuxwegjP4QjjyOUaB4WE23mi6lBTZ3f7IVfhaIvL3qe22GE5xb5qkPe5ku43ykpLZookT6pwWkuZqOX90IkubszgEkW6+MdMDMcZkO1HoEqHgPyUIDuGM5j5ya9Es91mjYmC3dqqsDAv9OfU0VAsdzGTiJ6IGBhssZhJVGXC5RlrucmktAxUdmU3FQY8pOPqwD+Z3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFf9ZtIpWPuQY9n7bSJYecWNMLG8qNF7yhkgkdieZMw=;
 b=Zos5HIhkZXmeESnG9qt3exFZGHo1rf3iNITLxahY+P62CvwnMlDKXZc0or0YWhmVd6tevGfNKAm0cFty26cBW8u9KmfQqZ+A0xhYc8Q9gZGu0YrRC3AmQfyvwBH5wJns1Ls1S/SRrLZ4KdrnufkVD5jMWV7J3m8Z/bFhNQ9TKX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shreyas.Joshi@biamp.com; 
Received: from MN2PR17MB3197.namprd17.prod.outlook.com (2603:10b6:208:136::33)
 by BYASPR01MB0062.namprd17.prod.outlook.com (2603:10b6:a03:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Mon, 9 Mar
 2020 05:30:05 +0000
Received: from MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::31e3:fa7c:d1c0:ce24]) by MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::31e3:fa7c:d1c0:ce24%3]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 05:30:04 +0000
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
CC:     linux-kernel@vger.kernel.org,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Subject: [PATCH] printk: handle blank console arguments passed in.
Date:   Mon,  9 Mar 2020 15:29:15 +1000
Message-ID: <20200309052915.858-1-shreyas.joshi@biamp.com>
X-Mailer: git-send-email 2.23.0.windows.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0206.ausprd01.prod.outlook.com
 (2603:10c6:10:16::26) To MN2PR17MB3197.namprd17.prod.outlook.com
 (2603:10b6:208:136::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from D19-03074.biamp.com (203.54.172.50) by SYBPR01CA0206.ausprd01.prod.outlook.com (2603:10c6:10:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Mon, 9 Mar 2020 05:30:02 +0000
X-Mailer: git-send-email 2.23.0.windows.1
X-Originating-IP: [203.54.172.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07880233-f9e9-4b03-bf50-08d7c3eaebe4
X-MS-TrafficTypeDiagnostic: BYASPR01MB0062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYASPR01MB006259C96E684715190CEDA8FCFE0@BYASPR01MB0062.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(16526019)(478600001)(66556008)(66946007)(6486002)(66476007)(5660300002)(186003)(2906002)(26005)(86362001)(4744005)(1076003)(956004)(2616005)(316002)(81156014)(36756003)(8936002)(8676002)(81166006)(107886003)(4326008)(7696005)(52116002)(6666004)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYASPR01MB0062;H:MN2PR17MB3197.namprd17.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: biamp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7RJcD6m50PNXXOcqLgr/bkvxHrlbc+BtTHClL5DcBtLbWjTbOoTXCo/3xsRjSANdeMi5QpzNciOir+yrG73Tsv0yh6Z3HdwgqBegrFj8ANbVVOfuKdn6Ku4Z+NHBAfzYjgjt/Hj/izbkpkkoHKE09raY4TmsQ3a5X6svsGa8toXnBeThEqWGIlf2LBH/7g6vAoIUM1bKkwO6cdks/1kmVNzcR18jVWhx2v4f5sXnrIIUwGHvOexSV1hufhxxbCcJyF8B3FATNPqwY6w8+7/x/aWkJJV75fRHp5f7iGv7VAW/Wj2lgDBGu5F/aTqSkKNyOeThft7BLNYp9MJu4udN86TvqmDyb7wgWlnFr/CbTWj+DX5irUVrvzvVTnqq9mH0uzjxlL9uemKNVA1feg59hv58MDDLXJr39DG2VsUZRQD5fkWkX+7XcRDy2hJdEX0
X-MS-Exchange-AntiSpam-MessageData: 99qLcV8Z9wgOfX23aVQUVC1ArrdhA1Dh2CT1lWoeuGgscfQpcfZHHGq4OKMyrhKBIljZ/2aYfKAzujMuP19lJZkBle9FlsDDgr1lLt1+Gp/LZNyDSTmy5Q6BhnqOXulnUO/tWVX/WFY+nkjoI9hw7w==
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07880233-f9e9-4b03-bf50-08d7c3eaebe4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 05:30:04.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeNES1tNPIWOCVLE5OTM+IOKvj4O+MMVJQ2KI4gZrAblaCNYFfNupPV8yGLgwRKCMSsnJ6ZdQZivI3V4CXjaRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0062
X-BESS-ID: 1583731808-893026-32669-43041-1
X-BESS-VER: 2019.1_20200306.2355
X-BESS-Apparent-Source-IP: 104.47.66.47
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.222787 [from 
        cloudscan23-173.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 MSGID_FROM_MTA_HEADER  META: Message-Id was added by a relay 
        1.50 MSGID_FROM_MTA_HEADER_2 META: Message-Id was added by a relay 
X-BESS-Outbound-Spam-Status: SCORE=1.50 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MSGID_FROM_MTA_HEADER, MSGID_FROM_MTA_HEADER_2
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
+		console_loglevel =3D 0;
+		return 1;
+	}
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
=20
--=20
2.20.1

