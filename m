Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D0BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2652A20DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="yRGF/20U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgE0IAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:00:45 -0400
Received: from mail-eopbgr70137.outbound.protection.outlook.com ([40.107.7.137]:3719
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729102AbgE0IAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:00:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaR0m3JEhgNCiQu2TKnMvPuqesHbkoFVygDoRts0az3eFV4/FXLt72vbig9W3r0ANPmUeYv7j6YTi5GHjc1aeHUNOYQMfhHrCLrfFXelb+pNAaVhvufsy+BO7YPzvOf3srh3ay3gRYXLZoOzrtBZ0zyc2ZiDgRe/9lqc259OYH8RL/glJNRZoGwWZcyzmPNHY1O6NYL4xjF7JZPYxkElxJoXizBxIxbdmhDo/P0VjtOW4Vx68yHC0kQvBPnRlcOna+8MCAVsnFW4tP0g/vii9fyZEaZ6pXigMalvGhwF6CHHWJbkVznMhl2yCOgZtG5CKtZBQH8bLP3YJ830kHHknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwgQXCSXKLNI1WWkRJRG3q6vpwY7955PidULhvCKtAs=;
 b=nR5mifx/e4P7N1nzaIjl5W6gslrOnZBHAhJShmWwUpXeXWCnpknAc54rJvqkoyx1YJoZ9WOoCg4t51DoFmJSh6rcZ6KtFX/7shV0nBjh9+B44q06rbnKRyCdtt+b6Vvri2M+xc/JqKV5gYq2qSu3jGZgfGo4MCKiw1QiTUfzYOMLOB+xOK+7axW6rHOZfsb+HvWBdhixpO2fvYtFNkbnWFGn7LVicNxoS0XkdiY6PYuMAXgd4CVdCPl4NFEyTe5/ETLv09qhhsSM6mrLREwky23HOEMc/6rpREMPie6BrZqJKG1SdXS6vCLyVvLf3sUy9K1e3lfUx2cXy/JPGYR5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwgQXCSXKLNI1WWkRJRG3q6vpwY7955PidULhvCKtAs=;
 b=yRGF/20Ub3+OLPpSx1CYxMK2BVx8KGJYNieui2PLFiSmRvIbTmastxQ8LPgUblSFmhSINmWJnI9PIWbOUeYQrHk/7jFFeagf1KHCAzL02dCh6fQHSy7w2DLXerudY7c5or10pjZ9cNJOtz5wKDQDKDbV0C7K7IzqwQJFHB/six8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5402.eurprd02.prod.outlook.com (2603:10a6:10:bf::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 08:00:39 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713%6]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 08:00:39 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     oded.gabbay@gmail.com, SW_Drivers@habana.ai
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: Fix static analysis error
Date:   Wed, 27 May 2020 11:00:29 +0300
Message-Id: <20200527080029.28989-1-ttayar@habana.ai>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To DB8PR02MB5468.eurprd02.prod.outlook.com
 (2603:10a6:10:ef::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ttayar-VM.habana-labs.com (31.154.190.6) by FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Wed, 27 May 2020 08:00:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [31.154.190.6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c48c97-4174-4b5f-dbe1-08d802140be7
X-MS-TrafficTypeDiagnostic: DB8PR02MB5402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR02MB54023C6297AA1E3E48D693CFD2B10@DB8PR02MB5402.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IeBvADB2uuV/NTwfOsKsLJX5ajAUW6p6ZNGZFKKPCeLVB+vthWN6cRx4JlP6Eu1i3xoldJ2VzAI08T9L01Xv9Bmu83iWoODHNXo+lVFgQyym/goOfpDYSp8kuDYvlmtke3XSDtAfw2inUaubaWfG4UjPVGtZxvWsyE+dmmqUU1d62Wg0IwrGtoWm/o0+w6mX59q0Si4PYNYNAY2Tkp3wLZhMajMNFPKvrQY8ivmM2ZOr5z/XPQpR91mJJrbpf17xCHn922+Z3auLu/PrEJq208yvRqkTE54ibx3MbyL9p8KnqYxpIKOOI0/X2ZRvw5FGGR8hq0VHe9P0EOf13qIeOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39850400004)(376002)(396003)(136003)(366004)(26005)(52116002)(6506007)(16526019)(186003)(66476007)(66556008)(66946007)(5660300002)(86362001)(83380400001)(2906002)(316002)(4326008)(4744005)(8936002)(1076003)(8676002)(6512007)(478600001)(6486002)(956004)(2616005)(6666004)(6636002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ercmpD9Rl7P90xdi0xcwn6i4yXrbV29RlJ6kks8xVJMf2BeDjVviFFgCw8PVJtoPEnn20hH89Ee/pQPJ05PUgi/sbO5hKZ+mSwDd/rNBkPMMLIuHQWzPlI8DcUxv46VYj0f+NwyUyiS9T4xNfNi88OlmAbw9lE8Z56JQbhC2tK1wFcj3o6udcDhF3aK2MOFZaF0VgpCtlTLWY/iNM81fbr6v/tloPYW9+uhVGQLOlhmUEZHtMdzfHYzhVnnPLF/59X3g5an3R7f2Il+ogpi7ZvaO+is9IxVM39kX2dTx9kN53qDGYcD3K5YVmJ8bn8uH1an3zJb4haBni/ddKje59Ji6bVJeV1o9rRd3ZyjMTrTgaAQdPdYhW6w8pHU94mRCk2hmrC/wC++VETlNUCwVvKV5v9NsBWET2k/Ze7O0jXQgaCTURcwL/q0rRYg6vRH8iAc9IIGLGWFIa44obV+cuPowhS3x0noRrJ8VbATdI1k=
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c48c97-4174-4b5f-dbe1-08d802140be7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 08:00:39.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zwg/L2OGoo3lra8JhwCm4yilFSbaMU79NeZhqAhe9eNq5NZAsnH15pG00Yo7zaDfD+/ZbQfjvTshwBkGySR4kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following smatch error in unmap_device_va():
error: uninitialized symbol 'rc'.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 4b8eed1ca513..47da84a17719 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1023,7 +1023,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
 	struct hl_va_range *va_range;
 	enum vm_type_t *vm_type;
 	bool is_userptr;
-	int rc;
+	int rc = 0;
 
 	/* protect from double entrance */
 	mutex_lock(&ctx->mem_hash_lock);
-- 
2.17.1

