Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F2DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1A5206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oppoglobal.onmicrosoft.com header.i=@oppoglobal.onmicrosoft.com header.b="p0ozcwr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgGGLqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:46:32 -0400
Received: from mail-eopbgr1300051.outbound.protection.outlook.com ([40.107.130.51]:14976
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727800AbgGGLqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:46:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnRg9yh1CVHY7Pc15VYYWfZt8+XEHsJlkjG4jNqh5QnDBC2ZZrbjpos7vtQj7QYGIKGHazLm6cJrT2bq0O0I8Wy3s2C4gaR8BDx6CkLsIqqYNvexTvnrGDA8qSX4ZCJjyjmn10kEKK4PlLAAAq7sV97Ei/kOe9vy/9nOCbjmFNcOfP56IqkJW4vs/sGYwXLgoboNRaFxJ4uuYTxG1Gee39nKNtpZq9IQkqwlfe882rYsdiX7Of/KjwxC7QYHDz/tnAc4TM3CHYVrpOyY6bLah0mMMr2sJduBem4s8sF2XcGbK7ONEA+9ASoEyiohutbZvRmIoGsVG90ofj9wdshntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9MsM2h7wNcto44n6MpPc1JPDWoxMT4UxiINkCMcq/o=;
 b=IBn7ISaGx6RegsumFIAGEIfvvHn8EXDi66H0TeFk6hgexgy1uDIjZLM5D3dNO2/dMXMutyLceVvQ4aHKWlX+DVCS0E/vEZBxWLrcp799z0uUEqPgwJhaaME/zxpLnC4tNtf3ejuhPyukp1rweVJ5qNqL7oww4Lad2hxAlePxo934Ddw0LhbkiMotOA9NJzSKZ1wxaPiC80dw7RJBG26w5hIaNqPH7LUQDA0RVVRxOhy0+GIwfr9G6ifKKmdMpEp9Kgh/yNIQktbQpWwdfBDR8Y5zhjzI6t2ypSEg/u0oPHM1XzZABx4EvldWAo5+hTKiDknCdVDjb6ak9Rjz4HcUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9MsM2h7wNcto44n6MpPc1JPDWoxMT4UxiINkCMcq/o=;
 b=p0ozcwr57L9Z6+vws9w0UoLQnr0eMg7cmektQ2C2xj8dSTgSpdDh6aTEbad2bA4/9SzNPLwygPBDVEEWI1j2RAaHGwu2nXMlTTzs/+sWoANom8935ss76MrCAfATmRIAnRK/CozUL2mUx6kj1BqD84JiTzZy09ICYO829IZJPnE=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oppo.com;
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HK0PR02MB3475.apcprd02.prod.outlook.com (2603:1096:203:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Tue, 7 Jul
 2020 11:46:26 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2%7]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 11:46:26 +0000
From:   Peng Hao <richard.peng@oppo.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Hao <richard.peng@oppo.com>
Subject: [PATCH] arm64/module-plts: Consider the special case where plt_max_entries is 0
Date:   Tue,  7 Jul 2020 07:46:08 -0400
Message-Id: <20200707114608.24197-1-richard.peng@oppo.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To HKAPR02MB4291.apcprd02.prod.outlook.com
 (2603:1096:203:d3::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC-Hyman.adc.com (58.252.5.74) by HK2PR0401CA0011.apcprd04.prod.outlook.com (2603:1096:202:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Tue, 7 Jul 2020 11:46:25 +0000
X-Mailer: git-send-email 2.18.4
X-Originating-IP: [58.252.5.74]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 673dba95-0614-47c2-f603-08d8226b6154
X-MS-TrafficTypeDiagnostic: HK0PR02MB3475:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR02MB347572FBDECCBB7CE468496AE0660@HK0PR02MB3475.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muJpT4XAv6eB2XBYGf97DQDVLNV36KsU2gYBMs68oCIldVPdf2uUXnof7RiA/PQjOmw87dWMLoog2fc+d/NkgdhPFAMYGjWcvyFs8a2H5Zh64XsCtyYG42bhRqwJY/yV6Ho9nLDQbBYF6UEf6B4kAO3O2X7j5wzYB79CwgM09YsenMSD018ILO+vo25ym+ynFX5oXKxASLLsolWne0X7Z8Gdm6XcQri0il1g9A+mjCj9DFaGBdEFzRKo32emZvVZHW1JGdc6P58eA3sXLcbSu/KE4jws4YvAEfqrYJB5d2eC1ZmZ4n5Saus/BQszvJUJqj+024x2sLGw6SyyWivST7Wcq5hDibz8p3s8OXDuyGCDZmfEhNRG5MXrnDjt/u/ho6u5ZJXXcjN5z0APdM+dMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(39860400002)(396003)(346002)(1076003)(6512007)(107886003)(4744005)(2616005)(316002)(956004)(66946007)(52116002)(6506007)(6666004)(66476007)(66556008)(83380400001)(8676002)(2906002)(86362001)(5660300002)(36756003)(6486002)(26005)(186003)(8936002)(478600001)(16526019)(4326008)(1670200006)(11606004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8+DAgTHE+x1OWvf1vImcmLEw1QRoLEC952sFgIEUsLQZGKCAwZw2LJoZmXuLhAVHbXv4UXj8Qir1HG+Cpm5NBO2zqkIQZ2ENnI0vXmubb2D8CorcQEeHd/hari9DIxKcbcUT6F9qYVe0Gb7l/9G6aO5V/vPq0H6VO9K0dTQghIPv3jGPJpiQzBffACoOQYiN56fAaQpkBWU3NxYU2dHlg2l22EY9AXrOul1EKEs6wzgTMACiP1swMo21fLFWFDVvXhbDSly9RgDqYPT2cu5A1a1zDsccYA0dcFqAdlszRHHMGLQ7jbQkYin6rXVfy8sxiUsXAY2laIQaPoXUEnukM4TabrsLta3TYl5VdVsUldhD51FNpqLbas+6fAbqzotjXs2WHTZ6JSR+ybBA6svdp1rJzPYGinPvRQUsSiWwgLvbaG5BTdjLDIJug9qCzJKvUTGxHw8xWHXj1L4tYLtUar4O1Zl0R3gCUW9VRQeHp7E=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673dba95-0614-47c2-f603-08d8226b6154
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4291.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 11:46:26.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CypAJZm9zK5Ypr7Vf1N5RJNLjmJGpxDumyrlQR1mqSCZXy57SbhncGCeEkWMNFPPnAVCmyrh3fJ2WxUQLTwPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB3475
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If plt_max_entries is 0, a warning is triggered.
WARNING: CPU: 200 PID: 3000 at arch/arm64/kernel/module-plts.c:97 module_emit_plt_entry+0xa4/0x150

Signed-off-by: Peng Hao <richard.peng@oppo.com>
---
 arch/arm64/kernel/module-plts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 65b08a74aec6..1868c9ac13f2 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -79,7 +79,8 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
 	int i = pltsec->plt_num_entries;
 	int j = i - 1;
 	u64 val = sym->st_value + rela->r_addend;
-
+	if (pltsec->plt_max_entries == 0)
+		return 0;
 	if (is_forbidden_offset_for_adrp(&plt[i].adrp))
 		i++;
 
-- 
2.18.4

