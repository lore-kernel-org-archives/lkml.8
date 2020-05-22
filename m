Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B075C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EE620679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="MuHFHCpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgEVHCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:02:16 -0400
Received: from outbound-ip13b.ess.barracuda.com ([209.222.82.195]:54256 "EHLO
        outbound-ip13b.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728181AbgEVHCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:02:16 -0400
X-Greylist: delayed 1236 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2020 03:01:49 EDT
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174]) by mx1.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 22 May 2020 07:01:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+ZeG3H0V/N6wzJgE8ZK1XrGaPEawv2q5G7hdktUzO1+gWsDp3vbNg/ws7vdo4G4eRBGpc8o8slxpJmo2Hva7o6N5KwmQcDxtIdLf5SjeVk35viQdyylHFrRiOZKW2XDiECzGvYzAYgTcOUeqIKK71P06cjclGzMayzFvEtLib6HoAYgEoLE1wTSWS3NAdzQ2wTGbxXdiTIllQ4qetDvk9arfiyyj+jMXS8U7OesKE3slKU8ZOrGReqMB2wZW3sZ+W+lesx83A+graO3XHzsOb35/awv+as7sGqLcUgAstVSr5vj7sYRvah0mfYDj9STbn6CRdA1g9+91K324ZC38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1ElRajXieyZM2RIf2Akwl4LiC5pfU941hcD5MHKnk0=;
 b=X9bGx1IyRcBZtClMtyCXS3fMYJAT1CPf88neHrZg9yupLXJuVo1/N6Hvr8yhTTYCT47bBsW+gzkqUYVDbmYlt9ATypqhgpwaOP/DdlTGdPo+5IkDlfyGL1L8UFmHX3qalYs7HeZomYBXaKKcl8uigFG29nmjT2mgXICsb3QbHW/2AIcC+CK2jn1rWThK4K9Oct4/neL2zw24wlLMOsaYXzY3UQh4IOgQfFAsXI+54U/GAEcoab/mEhucQqKynBSHWt8HFGuAqddzRBsVaayRj4rbyfayR1LFoiXqRgBmxhhCEz6B+a4JFTTEZmn11pcUtDdXj2r91x3xBcAl2+7RiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1ElRajXieyZM2RIf2Akwl4LiC5pfU941hcD5MHKnk0=;
 b=MuHFHCpB/EYZjwni/VAeUp3nC55yT5ZXXQy7NqbkS9fe8AnGsHYoOVjqdKe35niisaKzw5jeguR7k0i+Iw1kS4cYcEiXBEFVFtC4NM8XPUW6jCanXM+BQy5vAAUp6Y5StFMkXXfZBjNUlQw2d3ycAtPgOtyS2KJmP3vHptquB5M=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=biamp.com;
Received: from DM6PR17MB3420.namprd17.prod.outlook.com (2603:10b6:5:1de::18)
 by DM6PR17MB2427.namprd17.prod.outlook.com (2603:10b6:5:63::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 06:47:17 +0000
Received: from DM6PR17MB3420.namprd17.prod.outlook.com
 ([fe80::8ca2:ccfb:f717:a7ad]) by DM6PR17MB3420.namprd17.prod.outlook.com
 ([fe80::8ca2:ccfb:f717:a7ad%4]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 06:47:17 +0000
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, shreyasjoshi15@gmail.com
CC:     linux-kernel@vger.kernel.org,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Subject: [PATCH] printk: handle blank console arguments passed in.
Date:   Fri, 22 May 2020 16:46:40 +1000
Message-ID: <20200522064640.1840-1-shreyas.joshi@biamp.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0157.ausprd01.prod.outlook.com
 (2603:10c6:10:d::25) To DM6PR17MB3420.namprd17.prod.outlook.com
 (2603:10b6:5:1de::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from D19-03074.biamp.com (203.54.172.50) by SYBPR01CA0157.ausprd01.prod.outlook.com (2603:10c6:10:d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Fri, 22 May 2020 06:47:15 +0000
X-Mailer: git-send-email 2.23.0.windows.1
X-Originating-IP: [203.54.172.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e9e5f2-9e79-4112-c958-08d7fe1bf7cb
X-MS-TrafficTypeDiagnostic: DM6PR17MB2427:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR17MB24279B78B50D73FE4F6523B3FCB40@DM6PR17MB2427.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBCbK5M3PtMlOuOckzVS4h+aQslcltYNnuI4jd8hKpwsyci/RBKy/RtIKPGE1qmXkiZ1kJHqXwRupgY2bwQTNOkFYYne1teYh0N0/9MQwHEvPoqJgDxg+v/0NI1c/fDOhZfcZTuQGH8G3OqguX8PK6wbg91tZVAOizsZbxSae4YoG93Ci2KJERsHruy9RVXuV68SqTnsLaIN5vUlH8aogP3u7IYuvYmkvf+4Gfys1ihOSY7b2Ck5ME8ueldkyjUZP13E95s7m3b1YnduO7V6sNug8THPlc9zM5gSeNAjnjJ/UKa0pJVvNiJ+gtKuDEC6kO/yHYDW+5tyCjwHlnAJrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR17MB3420.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39850400004)(376002)(396003)(346002)(956004)(6486002)(26005)(52116002)(6666004)(316002)(186003)(7696005)(1076003)(66476007)(5660300002)(107886003)(86362001)(478600001)(66946007)(66556008)(16526019)(36756003)(2906002)(8676002)(44832011)(2616005)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: qpCazYjoFW+wyCXWEYShnqGDy8ikQ/KZ3BwulNE+AxVLBU5Kr5keNdWxcANnn62o9qxbZGCP0MkX/KjoP27kV8+K2yu9bCCpFz5Y0S0slFcVAvPiUYLFt+fCSjNSQGLrRoSnPKV3VOXYEsLv1kl8+/FjK1Akj6A9OEHSZrIVD5h4xgtOVRE5+TVL5GdI0Wz1S/OON0Syp32GI341RYGd6Kibswc305y5YnOiKOxE8MaHyCjOYSqiUx4gxi94FTfmPTZEbvmv9bYiet1IdOirVweOQt3MhdRV5Bo7bvQUNkQNtjFcc46ADtH2nsVZBvHSMFw5xaIE3nZyWUzq2kOYcup8FBpyFhroxVCYYq4I/dTqeowPetxYZ6a95M4Z2hHuiInUtltPFJBkTmQsDMcz805391fpEVuGVrrKWC4kAUowFbEuPFwPfhEk4SH84lUcPMncCbQYhD2NH9pOXHiHmwDxlXVSTsTRwdw+4C2qi7c=
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e9e5f2-9e79-4112-c958-08d7fe1bf7cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 06:47:17.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEIlHcLmPa/uWz2kjy3Dimxr6pCk92bQhlLeSaWOqDsQWFj3IKAwbyRZ+TqrFmN7Ym0yHk90umlxWynKnhgG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB2427
X-BESS-ID: 1590130901-893001-4141-32112-1
X-BESS-VER: 2019.3_20200521.2236
X-BESS-Apparent-Source-IP: 104.47.58.174
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.224285 [from 
        cloudscan19-177.us-east-2b.ess.aws.cudaops.com]
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

