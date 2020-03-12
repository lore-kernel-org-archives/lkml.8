Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F12BC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605D920716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="Krb929b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgCLXvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:51:11 -0400
Received: from mail-db8eur05on2114.outbound.protection.outlook.com ([40.107.20.114]:5665
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbgCLXvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:51:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2iLYzunss2IZMjndq76q4qYeFzI4udifRo3do5EjzFLP+F74pE6DaWDkjKg6guT0zkEd5WK91sQGI71JH7t1dlqO50pJYnLG0rJOSfL+yTqFEej5HwnCwqxYSUG52f7vz4tM91/FY4EIH6wBrkiXf/oERjC4z7LoEAgKcq/6xJkSrB5EReZ1xp7Er8wMHQ4lZxpF7XiNo5UC5M5EckB5PLpP6kp6HwTVmW5Ej5J4uQqM6sh2ujXRriiJXtSeSfEPn2Onp1Y8+zDeQK3PtmyODToe9vnRGFrrp91cJvMNMWjm9tdCteg5V17Z01gA2eOxR6Fov/ASdTipFdlBCWRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RrjX9oollmi3j610aXwuIJaWxiUoTPcBNdD+1H3tyM=;
 b=DKB700abdU0LGRroAgZApc291o1O7wLiMwV+2Dd049A3Y/2OlxZLVmxNunkzGNTxByk6/TMMWw46C5RQy63bXdooURbYuzEnmxJYLFo2CLdfRHR4WWk1bVczI91h/7YynFnNiWjthajVUtf1plouB0My2x012YoU0INSmd8RJIFrIjMUG88da3RDqhCoARLJoaiE7+7VpOVi6QETNazvvakx3r0NJNU40ds5Oo7jMwpWUyN7+EqNO3RFXuO07A1ZoSoB/sazeZHOl1Q0FRDs+J13qH/+JxQODSe2FFj7/Qx9ekSiBmrftXhGN7n7e7ZC0OqQl58dGb27GCjAlgGOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RrjX9oollmi3j610aXwuIJaWxiUoTPcBNdD+1H3tyM=;
 b=Krb929b0fTlYRCMw9478Rz2a9JiKLFG726AYTR/je6VvzyUA30yNsO8snw/ovBAg5yhtghPPK7nE5YOT6KGkV3kGdc3eskS780VOr61b0NX6YwZEnzGQnUAhhxeeLET+v+wpw0dHQGQQGLPy1DWroGKIctJYNfz1XwqAE1zK+hk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vadym.kochan@plvision.eu; 
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (10.165.195.138) by
 VI1P190MB0159.EURP190.PROD.OUTLOOK.COM (10.172.81.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 23:51:07 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::f983:c9a8:573a:751c]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::f983:c9a8:573a:751c%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 23:51:07 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH] arm64: Kconfig: allow to change FORCE_MAX_ZONEORDER via custom config
Date:   Fri, 13 Mar 2020 01:50:37 +0200
Message-Id: <20200312235037.26072-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0081.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::22) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P194CA0081.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13 via Frontend Transport; Thu, 12 Mar 2020 23:51:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d0c30ce-7c19-481f-28c6-08d7c6e03b76
X-MS-TrafficTypeDiagnostic: VI1P190MB0159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB0159934A1CC2CC2A2FE6BEEB95FD0@VI1P190MB0159.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(366004)(376002)(136003)(396003)(199004)(52116002)(1076003)(6486002)(2906002)(316002)(36756003)(6512007)(110136005)(6506007)(186003)(2616005)(16526019)(5660300002)(8676002)(8936002)(44832011)(81156014)(4326008)(956004)(26005)(81166006)(66476007)(86362001)(508600001)(66556008)(107886003)(4744005)(66946007)(6666004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1P190MB0159;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: plvision.eu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmslrrbVRW8nrqpXty7UJjUf5dZD4wrHAXgToHm4spnORU369mikuKgM9riOt1najkTos+M+m6Rh+xGgyphBWuZddVKYzOvA4LgcH7BYQVj0PJeMXfmxzg274Z22lEC+SuUQ3DSHE9Jb+3Bw5NV3UNSc/1NEjbPhnqvpkeVhbt+UxSSC8JPv6XyxYHpcGxeuYkHlaWnpZhzE8NfZ7XlRgHZ1GRr249tylr9pPZ5stYpVdQFGIm5NUx1AgSLV2MTNT42Gdtr6pqElwyiq7y/LQh7+h3NKLQeYxhwQQrvvG8+ptBh8yB9PJna6pNhdGapbAbExljPCphyfTz2qbj9MwWb1ilRKPY6tI4gLsdJuIsSOr9qSBEVBI3SorTYI93ThVDig3tNJlKN7p4WHZOFYyS2p0C0kangOJ/zPzNCxnFtyKzWpybAs10Mj1C1YZ6oN
X-MS-Exchange-AntiSpam-MessageData: qtazSyjPjcGYhz/UFC2188EvtdtnP5Z3a0KCQ7wm0JTr6HG/Df4e98UHzZugZS+rkAZE0+rRgealQBj5EnahvLAvpvUVUCOgxLDwsoRhSpnMq/cPQVd/EkjHkge/dlIWosTvco5KApqrgsjvSOIGZg==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0c30ce-7c19-481f-28c6-08d7c6e03b76
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 23:51:07.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vd4ZOlqJv0qlL7T1ZsygMoEnsehNOvVshiZg1TZq14rGD8CffmAy8MsIonuIyG84/DWQNm0gYOHACZBgexffavhqY4Ncor+4lTqEf4OvRPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing config option name which allows to change it via custom
config.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0b30e884e088..d974f31c3c18 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1120,7 +1120,7 @@ config XEN
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM64.
 
 config FORCE_MAX_ZONEORDER
-	int
+	int "Maximum zone order"
 	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
 	default "12" if (ARM64_16K_PAGES && TRANSPARENT_HUGEPAGE)
 	default "11"
-- 
2.17.1

