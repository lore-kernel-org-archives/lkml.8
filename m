Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA82FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934002078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xEC+B9N9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHZSzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:55:54 -0400
Received: from mail-dm6nam08on2068.outbound.protection.outlook.com ([40.107.102.68]:61280
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbgHZSzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:55:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFDstxKU3gmQkvTC6x/5jm0R7NTXre2DvycczkH1/r1LfiBxsVZXbZPuvW1HN82LhP2ZbOGSrjnm2pw1ACAl5ZnWWRJu62xCIZKf+Uw2ktLXCsAI76TYCD3/tij1G9vEoQD4gQg0G52gn4F0CtHMtFHJi+B77KhO5EqWgV4N1EcHrE0ZHIgeRdokbn02KQGM0tN7N8HB1X5rPomwzwE7TwH+wHAsmrZbUyiP3GR+dX8qVAkSxFlIrJa5YoaWADb+nkMQd5T867NYcb3+CVOc11OJoQ0JEi2UluoyP2IsBY2AqnAwiNJi+komOfY248vKJMHWOhV1NS2JjgwHj2TAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P4qKLtIbuJJ6rroXIW7pCSk1KYwY84mX2QWnuTPhAk=;
 b=fgd1T5r8zbsJG8CbRSS/juPVIdaiuQkzVGld9qhK8dmOSBz/4iDbmeeYsLEVVNGIT8ekr+loIKveDIpkYfay9yFWBdrAbUhR5dfaLYZvL2FnQqK/Mq0/7UYXQcM1FLy2IFV7qocUJGUuGPdO32NCb5mFZXo5trjUNS5tdo1A2Sdcv6ZXvkF3A+VhFWV8r5mQiugY6I+/2mzDMjZUHyu94y5eNuay92Nheqk4XQkRsXO/wFnE1wVzedXCbSe4D5XWxadGiQmh9XVGjak3/0ne649KBGVEEDtxq5WgsSGBZaK1BxkcngMZ3Lvn+JlmZ8JJcJwd3G+uGmA+4pazdYeVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P4qKLtIbuJJ6rroXIW7pCSk1KYwY84mX2QWnuTPhAk=;
 b=xEC+B9N9nSZlltgvUMcLBFYjeDjPkX0WnhUQO6ycGlEtg1AcEYp9uHtdrXRgMzXrpNQYJEwyP/a82SrgcIueiAA61d5EwYJKRFgVrem3q9RN4VHZ/O6PVEwRIKhb8gg1mttFvYOyOxffTVnUBIDIx4lcQXVSEBgwGDx4sP23Vtk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 18:55:49 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c%7]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 18:55:49 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        YueHaibing <yuehaibing@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [v2] ASoC: AMD: Clean kernel log from deferred probe error messages
Date:   Thu, 27 Aug 2020 00:24:20 +0530
Message-Id: <20200826185454.5545-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::33) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MAXPR01CA0091.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 18:55:45 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [171.61.65.59]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb1de7dc-3a8e-4f05-aff6-08d849f1a59a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3435ECD1FBF9D864EC408077F8540@DM6PR12MB3435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: np1CGERMzHqKQqpXsHK6079T3Kl5cfGmK6G+8VaSJVDFzrcuDaOl3yI1UDMsOP9yy24Z4C7GNkZa/XlXIRuhGsNV3f82e/wkNIEv6iwbw3VeCQ+doj02N2sm8hA1uO6QwQY+np4d4zIQsBgtsDgeUfZbHQn2rtdwVpy21w145F2tW/8tthQD4jxS0FGbnC6Df5FifS3zi1kHgm79Msph4d8YzdswOZw1ZEbD4e3BSa9tPPb/pSR3SJQcuebG+ZHP1lT5RSOwn+9qv2S/G/UVILMG+PjYkk9UiDIuleg/GMqmOiyqmTtp0pOFpRAzqkRWKkw7P3DjZBrWpUd5ydscVk+Zv7gR63oz2V46RBTDyVULYpUIj2arEJjD+ZF37M59
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(83380400001)(15650500001)(6666004)(5660300002)(1076003)(2906002)(36756003)(6486002)(44832011)(478600001)(109986005)(4326008)(66556008)(2616005)(956004)(66476007)(86362001)(66946007)(54906003)(52116002)(8936002)(26005)(16576012)(8676002)(186003)(316002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 76aAp9BanvWU3wtp8sPtVMBHltDJxOnAOhR1NjpF3niX+XwMWny3sPZoK3NkkE8AtaKHy1fU5pLm7mRnjr5tsbN84aYKDilNk9UiD0ecYQhCbW/PwZpGKUB+suvByZZSc+ReXqh6zcVlKvaSCBziBtH8CPWprAwPoiInscuFeLHv5PAJDxLZejfZjw8a0HiQhQlpXu4gQqsd6o9PRRCx/u7e50TBsC5UUbSQ+k43nMdOzKo9kPTvtS4HryE/8pQ7PMBSa1zC67ZRQ8lRnUeQr9UFcfrDywFyGhLIGd7EbEso7Mq8Wt/cs0UHM5ST9qIkz6g7pxsrCj+Q0s+/X3+7HESdqY500OoHMaBKzxRat/kEufv8CK7zUsjtw9EG6ztsBE2OWAPiFWLIoFU0ZaXz9RC/e3V32joQ+jLYH5H926c5sF1uM8keCg95TBJd6BFSgOaAUtIaiaqc9Mr3TUox86IK1fFfWJmLCCByJl1mxtb8TmrERduv3yZZ/rXl06TwuNr1qcC/RkobENlwSHITo8vnSbIyrjdOpCYyec9mI7t/8cQFmvVb7qv/HkSpujpVOmr7504xp2CrxDe1bHkH+W20koTRudLVylSp3+zQSy6qHloryNk1auUR6p0m05AqXb4ATuta1Z4Qg0DfYZdFmQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1de7dc-3a8e-4f05-aff6-08d849f1a59a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 18:55:49.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4A1lH6ZT+splmlpxI5upgVNmz2U0jqpYKYhZAxJhoH7SypY8KUEF6VAriLVJzJydMWrzASZgaC00Ce0FE/XVqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3435
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the driver waits for DAIs to be probed and retries probing,
have the error messages at debug level instead of error.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Add a debug level message for -EPROBE_DEFER

 sound/soc/amd/acp3x-rt5682-max9836.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 406526e79af3..1a4e8ca0f99c 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -472,12 +472,17 @@ static int acp3x_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-		dev_err(&pdev->dev,
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
 				"devm_snd_soc_register_card(%s) failed: %d\n",
 				card->name, ret);
-		return ret;
+		else
+			dev_dbg(&pdev->dev,
+				"devm_snd_soc_register_card(%s) probe deferred: %d\n",
+				card->name, ret);
 	}
-	return 0;
+
+	return ret;
 }
 
 static const struct acpi_device_id acp3x_audio_acpi_match[] = {
-- 
2.20.1

