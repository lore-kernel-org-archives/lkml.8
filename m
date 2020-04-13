Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B27FC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327892072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="ZnMPCZNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgDMPnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:43:31 -0400
Received: from mail-db8eur05on2098.outbound.protection.outlook.com ([40.107.20.98]:11649
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728597AbgDMPn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:43:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6rlkU/kHKD4TEIjrwx2IH7AjTKQ2RbTwXM9WYARisp+pV/46RWfAaYvdL8RbfWN3wyIr+j4UMCNwbFYoqllFKotos8WNTvaGb5FkaryUbOZaAu5di8zJc0EE5JwV7qouElyYlIrzBLPwZOrZZe/lDfRteuCbdLGOi3COMiEnR1Xvicnd+1qo5gbyiIMDkr/Rbtx6RAnaU3u1vJ0EPWwysDXLnczoRY49ZbbG6zrrvKv1lFY+q9SOgB4HQADPN9tTXyTQyScZLVsVA0FLbZgIiQJwaZZgal2F4EvRFIWV/MPB7OVZhjOJTWNpd6NLlOAUmXm0N0T9HXn2TktM829sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ddXb6IjnAUTvKtR+n8DdiwhMh0/iXKbtFOQnU3kBXc=;
 b=UmGNU8eQHAgiRHyYbN5F7Ud2ROrrHJHv5AmbqHsmhu8l1bJeQI5zLrLNtGmVnQnidtdMwGUDhuTDuJuiRVMTBtgN9tAxySrZIoAh02VrrrEEvbVkJo4Ulit4d7Qx3NJvkkfUDCXCdy4u6CKl/+RyEJk+Sc7lVCY5m1EbzqXQ8d0vgQHfoTlme1Ty3IO9fHdAf8kEjApIcgHVY+/2FIHMlVvKKmbOSH8KE9ZU55YX2W99+IbLCqDBDiwjwwo7koxGBp7ZTOl4dWTb31KkkL80ewz0H12OH3557HBcLQN2eOWJoqiSADGSm+KqfxJoCdwJ0aaaQFVIHn1BuPa5qxblrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ddXb6IjnAUTvKtR+n8DdiwhMh0/iXKbtFOQnU3kBXc=;
 b=ZnMPCZNyIw6xoCqwVolpfxLLhGdTjOjSRj4bnnLPoXxWCSdtITsYjniXS9qjL+yhwbbZ7LAO3iRIhUk5PHbrrmi+GBxjOKay4dQTMbfuNVGs6/vecAfZaHUmnks5L1I3/yVNO2cK+tZ/b3qcEFTcWFKgJ5AvEsnBhjHgLL3AZpU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=v.minet@criteo.com; 
Received: from AM6PR04MB4230.eurprd04.prod.outlook.com (2603:10a6:209:41::33)
 by AM6PR04MB6599.eurprd04.prod.outlook.com (2603:10a6:20b:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Mon, 13 Apr
 2020 15:43:23 +0000
Received: from AM6PR04MB4230.eurprd04.prod.outlook.com
 ([fe80::f151:2536:ba90:6629]) by AM6PR04MB4230.eurprd04.prod.outlook.com
 ([fe80::f151:2536:ba90:6629%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 15:43:23 +0000
From:   Vincent Minet <v.minet@criteo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Vincent Minet <v.minet@criteo.com>
Subject: [PATCH] umh: fix memory leak on execve failure
Date:   Mon, 13 Apr 2020 17:42:44 +0200
Message-Id: <20200413154244.18583-1-v.minet@criteo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2PR09CA0010.eurprd09.prod.outlook.com
 (2603:10a6:101:16::22) To AM6PR04MB4230.eurprd04.prod.outlook.com
 (2603:10a6:209:41::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (5.196.75.236) by PR2PR09CA0010.eurprd09.prod.outlook.com (2603:10a6:101:16::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 15:43:22 +0000
X-Originating-IP: [5.196.75.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6532f9b9-13c0-4b69-f9c0-08d7dfc1660c
X-MS-TrafficTypeDiagnostic: AM6PR04MB6599:|AM6PR04MB6599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB659977074E5484FC385E2A9590DD0@AM6PR04MB6599.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4230.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(36756003)(6486002)(8936002)(66946007)(66476007)(478600001)(6916009)(2906002)(6666004)(8676002)(81156014)(66556008)(16526019)(26005)(86362001)(186003)(52116002)(5660300002)(54906003)(316002)(2616005)(956004)(55236004)(6506007)(107886003)(4326008)(6512007)(1076003)(69590400007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzXq3Ff5BnbIgxmDkgRQgWK0L3PuZj/ysOLlpzquOpFAp3QROKAvZh46llUYpoPuWQ3g9N8HAZnAuDHAkdBSz7gJgAhLt0TZD3NgrfwvQ+JaMV3F5Dl2kNP/BD36huF52bFQMMw1HeE71R+9U7pbuAxGjEVRzuFgTduKRH9i1GXD5vzKwwky3c3qlin8OYXYmF1wCora1ZXewX5LXtJ2lnj1HHnqnL9TJmCTS5hxx9m6T12aPKjS6Wd1sTtq729i3agwzIrE7rXWZmYYNHMw7J7zLMY1AmllzEg2njoEpodtJ1XtMU5rc0fdfyJrPupRlM6RXdKkr3gg0s1ToEU4kIpSV43Eqx1IfOaKoh+AZEwAnkxngIA5ZJISQzsM36zMH3J5w/v/eoAB1L//Dlm0uqCxaBdOYFac2HxhOfVQ92x5T9Is5+5eMH4Con5YgqbbIJigrGO0YTP5TspsarpyCf1b5y4dBOJ8zoo2exPcgvmAVTHSPqVPNvqZSgnUrnmu
X-MS-Exchange-AntiSpam-MessageData: 4oFjgn+HuaEjKhhjo8H8fKSdA0eqTa2BHZJUgOO+ITs18FanXB+9qZnS872JS3YbcO5MC2ikTsC2w3oE2BPaHXIhNf2ypdcwqu4mNNgD9ETN9mLf0aXl6rbC1KvNhx1yRmMCfd8v7w94IVSNVk69YQ==
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6532f9b9-13c0-4b69-f9c0-08d7dfc1660c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 15:43:23.2681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2P5RF1PRmC1HRwB8nBHybNE6aS/AgMFS1UDA3W8YuZlpHBcL6/YR3mXtwHm4jpQYJboQS6fl2uOvv5LwCDh23Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a UMH process created by fork_usermode_blob() fails to execute,
a pair of struct file allocated by umh_pipe_setup() will leak.

Under normal conditions, the caller (like bpfilter) needs to manage the
lifetime of the UMH and its two pipes. But when fork_usermode_blob()
fails, the caller doesn't really have a way to know what needs to be
done. It seems better to do the cleanup ourselves in this case.

Fixes: 449325b52b7a ("umh: introduce fork_usermode_blob() helper")
Signed-off-by: Vincent Minet <v.minet@criteo.com>
---
 kernel/umh.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/umh.c b/kernel/umh.c
index 7f255b5a8845..20d51e0957e0 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -475,6 +475,12 @@ static void umh_clean_and_save_pid(struct subprocess_info *info)
 {
 	struct umh_info *umh_info = info->data;
 
+	/* cleanup if umh_pipe_setup() was successful but exec failed */
+	if (info->pid && info->retval) {
+		fput(umh_info->pipe_to_umh);
+		fput(umh_info->pipe_from_umh);
+	}
+
 	argv_free(info->argv);
 	umh_info->pid = info->pid;
 }
-- 
2.26.0

