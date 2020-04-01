Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9464AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E002071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="X4xcbcgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbgDAGxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:53:09 -0400
Received: from mail-mw2nam10olkn2065.outbound.protection.outlook.com ([40.92.42.65]:55393
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730426AbgDAGxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:53:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLwZGDN42h11ZoI/NLp39HPJpu8Uz8URT0+eSFw5RVZHX/FCy0LbkUneNJN/iL65ZbM/EzhRVUbmtII2NH4Oiyd0HBmk4G9e4HlZpr/uzA28ofOGwMk1kosZQN7+QjQEcwhpKNENdd3lcdjBvKCiuHKSh4gLPzfj4s9t75CZ8ieJZXZv+BnBJmmhVXNDB2i17ErOE1Qu3ljbTdnQYBx6eCe4hTz7P4q3N1JRNXZV5mHKIMme+fFm75oQy+usBvzEquxGz13erlxRisiUbVTNfWvAT/XG8HHRZ2bp/2ee1FigbJU/Fh01A9Posql0Ii1OZ2gqObBHTolBZKA9Uo182g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh3zBpkMV/n9dob0IgytRzBV+W2X4eu07FXckX2VrVE=;
 b=mAlXTFlcoCJU44o+0SRUxBlMqpeUCC+Li3gsjWunTdcGd6J6jCkEqE2K7SeYbwjpiMew/+RCtTQG/vcAl4VIVi6EeUnmJ0uVanGv7zR5cyG+I1R8fVdStGAzzm7VGKVAXHHzdBDfyczEe8GV7slVrwWA2InKsHZpa13NYSn69YR+i0vHyZ3kQpF4EgdVj32i7tUKqvR/ZWH/mB0pFz6C+7gB/UJH5K/AxS/X7YEjhiuRngX2pu/I65ttujx4Sbdq8jclZitiQVsOqL2gbF2cSDvHYw5W3owxhTJ9ano1pFAlevy+R2cdPliDJxK712y1DKO56Ev3wEfTjHZBAMHrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.com; dmarc=pass action=none header.from=live.com;
 dkim=pass header.d=live.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh3zBpkMV/n9dob0IgytRzBV+W2X4eu07FXckX2VrVE=;
 b=X4xcbcgM6R06PivY1fd3D/01RADtnnCgZ+qPgHvQLHuLZCpY7Bq77ylZKofKQxDsN9GnUQW7mBQrlubVKlvpR/g72w5jLrqR14neWBcU+B80FEWzkN7TrB5wSED2lk7+AWVgBozGu3aXKyPdLYdTnJLhMGvxvQfFZ7iru2dFeZDdVYEZgofPIjsv7Mn3LFcOIrFOe9RRfehsj72btO/ZtDbPgB0hZz8E7P1GJxEWB7dgGjNRCcpVifyCngMNap6ZB/gsuqws+Tq253/23bMT02zkVV29FkdMgEjpVUIAeLUHNbAwqtpPkhhXr0OprCoWFyX5PkAQz/C7TXJ8c7gzwA==
Received: from DM6NAM10FT030.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e86::47) by
 DM6NAM10HT068.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e86::344)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.17; Wed, 1 Apr
 2020 06:53:02 +0000
Received: from DM6PR11MB3531.namprd11.prod.outlook.com
 (2a01:111:e400:7e86::4c) by DM6NAM10FT030.mail.protection.outlook.com
 (2a01:111:e400:7e86::224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 06:53:02 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:D4066505403CAB775679B1C29494D8F4FAC8AB048DBCA2485858ADB8927FC8D8;UpperCasedChecksum:D30F6461EB32CA0700430A7E6720455E84BA53986A84799A256448E821CCF462;SizeAsReceived:7534;Count:47
Received: from DM6PR11MB3531.namprd11.prod.outlook.com
 ([fe80::c844:3598:abc4:cc3c]) by DM6PR11MB3531.namprd11.prod.outlook.com
 ([fe80::c844:3598:abc4:cc3c%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 06:53:02 +0000
From:   liyueyi <liyueyi@live.com>
To:     peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, liyueyi <liyueyi@xiaomi.com>
Subject: [PATCH] kthread: set kthread state to TASK_IDLE.
Date:   Wed,  1 Apr 2020 14:52:15 +0800
Message-ID: <DM6PR11MB3531D3B164357B2DC476102DDFC90@DM6PR11MB3531.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:d0::26) To DM6PR11MB3531.namprd11.prod.outlook.com
 (2603:10b6:5:61::21)
X-Microsoft-Original-Message-ID: <1585723935-31322-1-git-send-email-liyueyi@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from liyy-linux.mioffice.cn (2408:8607:1b00:a:e654:e8ff:fe9d:faec) by HKAPR04CA0016.apcprd04.prod.outlook.com (2603:1096:203:d0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 06:52:58 +0000
X-Mailer: git-send-email 2.7.4
X-Microsoft-Original-Message-ID: <1585723935-31322-1-git-send-email-liyueyi@live.com>
X-TMN:  [eaChkloj45/30i8GXw4LQVukpDMV/CdIpq8oKlad0ULKstC10cd+/p8uUDzbwBNQ]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e62b01c5-b03d-4b6b-03f6-08d7d6095257
X-MS-TrafficTypeDiagnostic: DM6NAM10HT068:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIyk5P64tECo4bXN5gXpApoiCiqRpMhT/oNkLUWhG4w5313Ykf4UYfLGTTGJAVQ+ZtoL0JgQ6dt6/3CnuQiR9asBENJ8c5avNVzDyCHtf1HWBF06Vl15YMPgYp0D5lDGOsUd0Jp1XYIPtnKzCvtMSzMauXzCIahA//sTRGM93DDLRrWqY9QD7AviDD4zpGac
X-MS-Exchange-AntiSpam-MessageData: wOdeWQWALWV2KT8nzPV1Xt+nt0UaqE7558TcnmoHZamM8+xV8TUkXXMp9uTMFsLul62Rtpl0LCDttSWIU1Gax+Llkm7+NCIcr5n90mslPFZMxbW+2uEPuhJP0W67oyAbAIi6X64StEdW91NQShdC4CS8f2pwt4cO3VOGDxnBgZoY5klxCDmQ1zrzeOHGCZZJMgvMB5dv0ER2NcA542felA==
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62b01c5-b03d-4b6b-03f6-08d7d6095257
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 06:53:02.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM10HT068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liyueyi <liyueyi@xiaomi.com>

Currently kthread() sleeps in TASK_UNINTERRUPTIBLE state waiting
for the first wakeup, it may be detected by DETECT_HUNG_TASK if
the first wakeup is coming later. Since kernel has introduced
TASK_IDLE, change kthread state to TASK_IDLE.

Signed-off-by: liyueyi <liyueyi@xiaomi.com>
---
 kernel/kthread.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index b262f470..f841419 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -243,7 +243,7 @@ static int kthread(void *_create)
 	current->vfork_done = &self->exited;
 
 	/* OK, tell user we're spawned, wait for stop or wakeup */
-	__set_current_state(TASK_UNINTERRUPTIBLE);
+	__set_current_state(TASK_IDLE);
 	create->result = current;
 	complete(done);
 	schedule();
@@ -415,7 +415,7 @@ static void __kthread_bind(struct task_struct *p, unsigned int cpu, long state)
 
 void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
 {
-	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
+	__kthread_bind_mask(p, mask, TASK_IDLE);
 }
 
 /**
@@ -429,7 +429,7 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
  */
 void kthread_bind(struct task_struct *p, unsigned int cpu)
 {
-	__kthread_bind(p, cpu, TASK_UNINTERRUPTIBLE);
+	__kthread_bind(p, cpu, TASK_IDLE);
 }
 EXPORT_SYMBOL(kthread_bind);
 
-- 
2.7.4

