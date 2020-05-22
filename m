Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7E1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7642073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="TYANjslN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgEVHIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:08:55 -0400
Received: from outbound-ip13a.ess.barracuda.com ([209.222.82.180]:56042 "EHLO
        outbound-ip13a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728434AbgEVHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:08:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109]) by mx1.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 22 May 2020 07:08:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTSmVi43X+9c/05pjN6pbhzk0aF0rmMLQ+5n/dYCDoDmzjgUhqKfktX3AgDGo3I6OesOJAopwuakD/sMopLUBfkgKm59D28H3iLNqTv/BKeOC1AEkxpkK2kKZ36H14xKFM8cZk17fu07Q6+Ma6neH/Q66XrgDhX1FrqVLu5XLygqJ2mKMEjwQWK5JAEV9hE7V3ptzsKF2lSCr4JFiIqUQ68Vfl4zLGwjATSmSBYQqu+mEyDKRqRp0U8/n8VC2mhAyN6k+Ku6A9itYg7NW2aoZzNrp5Tywe8o9O1o98VWFfBjqE2ug9EGMUwKIaIPC3rmnpNGlANp6L5H6/sjMN50jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1ElRajXieyZM2RIf2Akwl4LiC5pfU941hcD5MHKnk0=;
 b=kgTNTNR89hgGIqBB/fx1yVlPfVfJwb6wu8qzCpCZ3rMb9vRsYSPTzJqUZ5Lt/caIytwfxZZf2hW5EW7CPL4sK9is0NvC5ATtuTuuAGYbaTCpMIq8lhP6qotgIy/WKyq5dc3ZApiWuz283n3NBt1Nn705I5Gltw06OUpYY++oFsfx1ISu0iqvnOG92laGRZBGyj5z4n83cxqtI6KAut9wZfT1GmXotuQUMEz5b5X6p4wXVF691GOCAcgCYsdUqk1ru3Ho0FVDLMGC6dm/jxNs5wzSo2KB3TXD3G5j/jmQIEG2YhAwuVHkdPYzQf+rZkhgaLQ2ZpqCmfbq7vGAXe4W2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1ElRajXieyZM2RIf2Akwl4LiC5pfU941hcD5MHKnk0=;
 b=TYANjslNBKtuhqmVuAaTngAT6WpLmXmjCUyWvfIA+y3pr4KMbjJd6CkwFvrgllCZUX6+5xU04/mlyCARwX1VtOYfUTJ1DPQEvHvNb2sZk5T9gYz5KczeXqIWQFS/4oOo5jvJFm6FlW+3SaytvOhj7Mr5yzSGroPmr6D0rTbKPbE=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=biamp.com;
Received: from DM6PR17MB3420.namprd17.prod.outlook.com (2603:10b6:5:1de::18)
 by DM6PR17MB2427.namprd17.prod.outlook.com (2603:10b6:5:63::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 06:53:24 +0000
Received: from DM6PR17MB3420.namprd17.prod.outlook.com
 ([fe80::8ca2:ccfb:f717:a7ad]) by DM6PR17MB3420.namprd17.prod.outlook.com
 ([fe80::8ca2:ccfb:f717:a7ad%4]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 06:53:24 +0000
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, shreyasjoshi15@gmail.com
CC:     linux-kernel@vger.kernel.org,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Subject: [PATCH] printk: handle blank console arguments passed in.
Date:   Fri, 22 May 2020 16:53:06 +1000
Message-ID: <20200522065306.83-1-shreyas.joshi@biamp.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0032.ausprd01.prod.outlook.com
 (2603:10c6:1:15::20) To DM6PR17MB3420.namprd17.prod.outlook.com
 (2603:10b6:5:1de::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from D19-03074.biamp.com (203.54.172.54) by SY2PR01CA0032.ausprd01.prod.outlook.com (2603:10c6:1:15::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 06:53:22 +0000
X-Mailer: git-send-email 2.23.0.windows.1
X-Originating-IP: [203.54.172.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71453f99-ee4b-4747-45cd-08d7fe1cd2c6
X-MS-TrafficTypeDiagnostic: DM6PR17MB2427:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR17MB242780702A5E25C3EC35C3DAFCB40@DM6PR17MB2427.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVM4IGjNe7MrCtbF8pJ1fnoE+0N+c9rLzXkh0OswIDceXgJUfHg2dYWnBfUf3ciOdoNd8u3JqgFxrF1jYsQFke+u4ThCfC6jCt8eQuPZsKFwrXWPet/RyjRH4NkjE3+7fTmEkx2scY4MJlYFsoFR9/2wrVMfN2gWJT8QfPtrVwHry/xJRG0x/7TX5CsAPnAXCUe6u6LkW45qE6qfqhtmBbBFF9YuCuLA1NmECPXVL1cVuyV28HnryWxkcnVEj6CXtqVawZ6anueLa4xdlzMe1nDdOvyyYmcEGtSlyl9VObMCZcxNhvxzbU03wtPA1Mm4PRei9+5rk0U+ti66xs/SwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR17MB3420.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(39850400004)(366004)(136003)(2616005)(2906002)(8676002)(44832011)(36756003)(8936002)(4326008)(6666004)(316002)(52116002)(7696005)(186003)(956004)(6486002)(26005)(1076003)(478600001)(16526019)(66946007)(66556008)(86362001)(66476007)(5660300002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5kPJQXsAZVy3Biz+FfABwES8TC37HI80Blm0qfB7dv5lZTQvhyHiZjoNrISvUpB6Rlt6/SgAw2Y9epElQP0FKOvttbJa3EjRO3dU+If1LOvcmgfo+lHCOiwHcu/NEjCBTiro0Oo4okSieLaEtjBQBiNFxQ5FawD/0N9VOTcwqn5RPalVfpRsjv/gHIAPHAHQ0OS7EMPpYK2etz7nNdVkH/woCinNRY3peUobybbGGSsXoFo8lP6C2/7ljYcWsblTENVb0WtBC0WjZG6/IbDkKJ++TzGyo4295yuBOqFSjJWvGHEBwvgzYJ2GQFCtoEn0+EGVd7cy2k/le3CFjH9t/5hlRxbdUehPSYD3IvEZFF0PfNbA3Hfql7SxZ9iwLv83cVGxMxPCznHSYB2xttNqaWB86F9jdIZjKCBJa7dg1c6QZtW3b4xVF4bYoVspFoaXvLECZI252xcmbqny99LRqtCs8EYXs6WL+urjxa2VqEI=
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71453f99-ee4b-4747-45cd-08d7fe1cd2c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 06:53:24.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FM6lermml/CFjOTZKrmzGGiGah/8omAx5PYPFc4iojh3tFNbKriEWjLdnk3cpoIrw1Jh32f2jzX0+Yf7hsfiqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB2427
X-BESS-ID: 1590131306-893000-25184-32552-1
X-BESS-VER: 2019.3_20200521.2236
X-BESS-Apparent-Source-IP: 104.47.58.109
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.224285 [from 
        cloudscan20-103.us-east-2b.ess.aws.cudaops.com]
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

