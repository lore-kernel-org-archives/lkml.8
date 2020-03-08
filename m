Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732BC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B4A206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qv0rOsLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgCHNRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 09:17:32 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:42078
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbgCHNRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 09:17:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPMpNNocK8cG8qE4pVnvS0Bc8w+PgdOJicndZvPuAy5w2Nl+jRy+EQMBEa8TRKnUnAnnr1R7B8I33wEcG5ikc64sTDa02qQm4amepZZMydx0NUY3T/KefTsHZLuPx1oV876fJ8ZroKYeRzvomOKbQ16nXadiw3zlq1W9q7mz10qxzUJsI0HvOOieNvqC395Zc41WgxoeW05YVDjNW+HtqhfFUyKh+Z6nideQ4qDq65luyzW9YkkGOnLHs/oCb0EfW26ZYTQSzPtQv4wJI2s5vrfQLe99y0jeYj385Do7fIAODvh4GkbvUUc0mzStQF4+IdQUsQCXdaUWlgNrd/xxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGJkK6PVe2iCJ4Ci7r8ntyyPIQHFTuUp2a9v1Gcfnig=;
 b=k8MRyTne+MWW6lQr1ZRKK73PyJ/90SnkE0eoZgmcURNw4ObKZf71DLUTj9ael1jwngutB3BT6j5LwzHDbMDAXlKLKF6yJ4XL7l1aZ388G2D3L+hEHzPmuYYmJH84zPa8Emut23EeuiKvDpdT5ZIu4yj3SoFc2MoGGL43D/gn8lVxKm9BCymKpedWSM66A7dZropliPUXbS8MXpRZnakYbHeU2hHyLaKa4YKgPfsEFChWeAD0g/MM8AOcnwPevF+BQhWYiscD8Y5Yzf/R9IyZsLBpK2Xe7FR982GNnhPeIG5Rx027O+k2gArJscmCtvj0q+RhfiEQVQnFUJS+98ImBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGJkK6PVe2iCJ4Ci7r8ntyyPIQHFTuUp2a9v1Gcfnig=;
 b=Qv0rOsLp25zX7dcWznaXIpwq4FuTB9RJKok8Zas5UXt4ZxYjHlJOx/ZYlV069zaF0fdt3o5qrUet8ifC4Kp/4SISWNul8zGSH4p6tnkqxrSHyGZnJzZE2I3bv7LqAhjFDXh6TUVKuJFgBgT3sJ5c+aJ/JU2GR7rlufndJRvwMLk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6321.eurprd04.prod.outlook.com (20.179.35.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11; Sun, 8 Mar 2020 13:17:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.013; Sun, 8 Mar 2020
 13:17:27 +0000
From:   peng.fan@nxp.com
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] regmap: debugfs: check count when read regmap file
Date:   Sun,  8 Mar 2020 21:10:58 +0800
Message-Id: <1583673058-20531-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0135.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.14 via Frontend Transport; Sun, 8 Mar 2020 13:17:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffe537b4-dbfb-4d0b-55c9-08d7c3630c62
X-MS-TrafficTypeDiagnostic: AM0PR04MB6321:|AM0PR04MB6321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6321DDED501531200CE2845E88E10@AM0PR04MB6321.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03361FCC43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(189003)(316002)(6506007)(66946007)(52116002)(5660300002)(81166006)(81156014)(45080400002)(66476007)(6666004)(16526019)(478600001)(36756003)(66556008)(26005)(186003)(8676002)(6486002)(69590400007)(8936002)(9686003)(6512007)(4326008)(2906002)(956004)(2616005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6321;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eY6QaxtkzaxqN/PEQeWqxX5JJBNq6XufvBBc0i5WuINJ69MJKWCky5jHogG5llhLaDg7D1xsPww0QeGF9Da+SN+kjmSVNolq1u+eimGMizaroPsJc4jYSXjmjSkUljUq5ka1eIuIcg6r2/SEPS4wmn7hjsLkO0QQWC3GTWK3OKBbIuw/yeGDphV/+NCmEBuSpVdRg/b/iWK81hDe9JZc7gcK4zyaiWBgly2w4r5EhUGt98CBC/NQv2ObzpIvkYK+YOFLzYpO1CLOW3+amDvYe6ZGbKW2MVDnyGMCXCbRc5cYfjT+G526fmdoQorMBwQEr+6FczYDcFtgb6ivkOV0OE2ZYVUTt6Swwg1Bd0SNhQ7yxzrwHbHbP1ljU0Qj6WKXPBjhFEP8rwR48XSOyW3IUKZYhNPNDp4v6T+rfaM5vAARfijnehoiiz06mnxEVF+CFdEry3luO7fzgnObNi+vecWnFvnX+H2YPjF4++L3WZastmqlWU2EsSIuepku8xcV
X-MS-Exchange-AntiSpam-MessageData: xlybp++0DPzMsjOKdlQcTOCUZDleNcWp2568sacUSPMfyVHAjKK2qn8b9jeJcti+ysNolY9PLW2f2BDWqt3wfVxuONOCylAtkDJq+ELbUBsli5X2sgAWmUOghIMBbMtqfNbY8d13vaO1zsbkz9dS8w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe537b4-dbfb-4d0b-55c9-08d7c3630c62
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2020 13:17:27.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ilC9IYyKoyuxTsA+4YaMUzIjwgrP5GSCkJcseNaFbSiHbuGkddjAx6lhuQhLAvRYjXC9zOGBDb8OMAZ0JCD6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When executing the following command, we met kernel dump.
dmesg -c > /dev/null; cd /sys;
for i in `ls /sys/kernel/debug/regmap/* -d`; do
	echo "Checking regmap in $i";
	cat $i/registers;
done && grep -ri "0x02d0" *;

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6406 at mm/page_alloc.c:4738 __alloc_pages_nodemask+0x2c8/0xda4
Modules linked in: mx6s_capture ov5640_camera_v2 galcore(O) [last unloaded: snvs_ui]
CPU: 0 PID: 6406 Comm: grep Tainted: G           O      5.4.3-lts-lf-5.4.y+g54cbaf43e23e #1
Hardware name: Freescale i.MX6 SoloX (Device Tree)
[<80110770>] (unwind_backtrace) from [<8010b650>] (show_stack+0x10/0x14)
[<8010b650>] (show_stack) from [<80b3770c>] (dump_stack+0x90/0xa4)
[<80b3770c>] (dump_stack) from [<80130310>] (__warn+0xbc/0xd8)
[<80130310>] (__warn) from [<80130390>] (warn_slowpath_fmt+0x64/0xc4)
[<80130390>] (warn_slowpath_fmt) from [<80214328>] (__alloc_pages_nodemask+0x2c8/0xda4)
[<80214328>] (__alloc_pages_nodemask) from [<801f4ba8>] (kmalloc_order+0x1c/0x4c)
[<801f4ba8>] (kmalloc_order) from [<8061e360>] (regmap_read_debugfs+0x64/0x39c)
[<8061e360>] (regmap_read_debugfs) from [<8061e6f0>] (regmap_map_read_file+0x28/0x30)
[<8061e6f0>] (regmap_map_read_file) from [<803c0614>] (full_proxy_read+0x54/0x70)
[<803c0614>] (full_proxy_read) from [<8022c68c>] (__vfs_read+0x30/0x1c4)
[<8022c68c>] (__vfs_read) from [<8022c8b4>] (vfs_read+0x94/0x110)
[<8022c8b4>] (vfs_read) from [<8022cb98>] (ksys_read+0x64/0xec)
[<8022cb98>] (ksys_read) from [<80101000>] (ret_fast_syscall+0x0/0x54)
Exception stack(0xa868bfa8 to 0xa868bff0)
bfa0:                   03001000 03000000 00000006 70e0e000 03000000 00000000
bfc0: 03001000 03000000 76fa53d0 00000003 00000006 70e0d008 00040298 70e0e000
bfe0: 00000003 7ead45a0 76ea2cd7 76e2ed16
---[ end trace f0a1fccbc20d20ff ]---

It is because the count value is too big, and kmalloc fails.
So add a check to allow only max->max_register as max count.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/regmap/regmap-debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index e72843fe41df..a375cb2ebac9 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -283,9 +283,10 @@ static ssize_t regmap_map_read_file(struct file *file, char __user *user_buf,
 				    size_t count, loff_t *ppos)
 {
 	struct regmap *map = file->private_data;
+	size_t num = count > map->max_register ? map->max_register : count;
 
 	return regmap_read_debugfs(map, 0, map->max_register, user_buf,
-				   count, ppos);
+				   num, ppos);
 }
 
 #undef REGMAP_ALLOW_WRITE_DEBUGFS
@@ -371,6 +372,8 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
+	count = (count + *ppos) > map->max_register ? map->max_register : count;
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.16.4

