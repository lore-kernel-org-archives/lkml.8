Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361A6C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23482073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="RthlQCuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgAQNr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:47:29 -0500
Received: from mail-eopbgr60122.outbound.protection.outlook.com ([40.107.6.122]:8880
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbgAQNr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:47:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npNqFKFgAXEELmp8SQG8oupKkfzFQzBHpH8dNcb5Clyu9XFsKjxZP4LlqGGlBekQyo8j8AHUzj6hLltIa/nWLoESr8EJCPbqo003ON1yxmOFpAAeJ7RIKanl+BTi0GK3zGG926LhmnO5SkVc2gSukkm6KAU6cIaCxAZUuSyC3x4lNsEKQ1BORjzs6HG4N1JlW60HOc2gmQI4AVYiKedRyivJ0k+JkUZLtCn2oXyw1HAa1uQHW8uJCZQL4M9ZAMLgJjhRgW8N7No+UabXRlteSQ4wlJe39tJ19USlCbGHFoWdcmCc4zuHn5rr8IDEZQEDqGJpkFgzEg/Ix1OJEE12lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0rYb0ssai2BlMYsYJ0Oda9qkAQpWDFzzEE75HJMHJE=;
 b=VDyOLUCLDXiy7q8y2FVTmrQPaxwO8+iAl/O1qT1A8qqn//J+WnHsCyp93c8H/eq07BV51GOpHyNE6B92z5okeOmhjU/FAGF5MFRM6spkcwCwKstGclEBopI5O+Ag/ex20RK4QHQY7ncvvgb05y0Vb5DjzLPlHMnd9pUO+4t6ahkuGVkU2/oAWNkNWE5sVMJl9jHrPIBCQSjNE1Q/Q96OG4Bq3XXz143M9zXaw606F5l0e7ytyp9Jbr7cRofOHfPoCIwqjiK4PW+RwhRJr7fXOOSNQWsIKqd3TdYWmpVt35VepOEbxffy/HoeVkvpXFsBYONhi7Fjw+1nBzTAmsJezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0rYb0ssai2BlMYsYJ0Oda9qkAQpWDFzzEE75HJMHJE=;
 b=RthlQCufHauUdHK7Liveyhd0bPrrCYbpPgT/dBezTp1b2oBkidnb4zM1rmw+D3UJVgAtaOuTLU44e7i6GHON5/A+oQaauLi99E1WK9PrepmqxTW8MtIx9NXfC8l7QcV06hOxmeZ54mNBmtuViONuB6scFjy9J3ChXI9g8zwAzDE=
Received: from AM0PR07CA0001.eurprd07.prod.outlook.com (2603:10a6:208:ac::14)
 by VI1PR07MB5951.eurprd07.prod.outlook.com (2603:10a6:803:c4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.12; Fri, 17 Jan
 2020 13:47:25 +0000
Received: from VE1EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by AM0PR07CA0001.outlook.office365.com
 (2603:10a6:208:ac::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.6 via Frontend
 Transport; Fri, 17 Jan 2020 13:47:25 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT029.mail.protection.outlook.com (10.152.18.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Fri, 17 Jan 2020 13:47:25 +0000
Received: from lfs-10.localdomain ([10.157.83.243])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 00HDlNkB013062;
        Fri, 17 Jan 2020 13:47:23 GMT
Received: by lfs-10.localdomain (Postfix, from userid 69031427)
        id A042D82465; Fri, 17 Jan 2020 15:47:22 +0200 (EET)
From:   Benjamin Bouvier <benjamin.bouvier@nokia.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bouvier <benjamin.bouvier@nokia.com>,
        Patrick Lelu <patrick.lelu@nokia.com>
Subject: [PATCH] x86/reboot: Enable restart_handler mechanism
Date:   Fri, 17 Jan 2020 15:45:35 +0200
Message-Id: <20200117134535.7224-1-benjamin.bouvier@nokia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.17;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(189003)(199004)(81156014)(81166006)(316002)(2906002)(5660300002)(42186006)(6666004)(1076003)(54906003)(70206006)(36756003)(336012)(86362001)(107886003)(4326008)(44832011)(478600001)(2616005)(356004)(70586007)(8936002)(26005)(6266002)(26826003)(186003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5951;H:fihe3nok0735.emea.nsn-net.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29bf7b92-9925-42ea-ea2f-08d79b53c906
X-MS-TrafficTypeDiagnostic: VI1PR07MB5951:
X-Microsoft-Antispam-PRVS: <VI1PR07MB5951D9D67488B609605023B181310@VI1PR07MB5951.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0285201563
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyL2bxCYiS5S0FQ/ATEHUpaGPaAvkcjJIMycpHwWPEzyZklIKodfD82iUKLJo8Ppg5U/L9pkVpuzdBHzKsd3OIyWm7r158tgNPOTtxG4GV73vJGQZFIqgg8OVsJTaidYNKPEM3N7wlpHBfeXK4n7VgEMtu8FB0sOMjkqFCHpVgx7eICZxdBHeYNnXkpbITl/XJr2oMO8Ta0c2zgb74V6hU2TelwIMhdfWYUjrZIFac8od6c536UjqWzcJct8g3+Ugh4vMdPhabec31mVPElwmH0QrVa0SKDsBKW7jbyqCCIJQiNpQQaC9MqZLU0qsNye3+dqxW3b5M1HDmwcEYvpO4jnfN1xx5YnjGo/smwJ6ddwr52YNJJdD/ncXUiXsC8UmDGC05F3kS+3IkBpGh/Ez7z9yvnb0JRI7Az8qgUN/Qjkme91QlevGcEyR9FjCy9x
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 13:47:25.2598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bf7b92-9925-42ea-ea2f-08d79b53c906
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers may want to register restart_handlers for case where an external
reset is needed to reset a complete system and not only the processor.
This case is currently missing in x86 architecture.
So include call to do_kernel_restart() to use handlers registered
through register_restart_handler() API when the processor restarts.

do_kernel_restart() cannot be called in machine_restart() as required by
documentation as final step, because it will never be reached (restart
having already been carried out). So call is done inside
native_machine_restart(), and only here to not let drivers managed reset
in hypervisor case where function native_machine_restart() is overridden.

Co-developed-by: Patrick Lelu <patrick.lelu@nokia.com>
Signed-off-by: Patrick Lelu <patrick.lelu@nokia.com>
Signed-off-by: Benjamin Bouvier <benjamin.bouvier@nokia.com>
---
 arch/x86/kernel/reboot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0cc7c0b106bb..53c3d5a3f89d 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -718,12 +718,13 @@ static void __machine_emergency_restart(int emergency)
 	machine_ops.emergency_restart();
 }
 
-static void native_machine_restart(char *__unused)
+static void native_machine_restart(char *cmd)
 {
 	pr_notice("machine restart\n");
 
 	if (!reboot_force)
 		machine_shutdown();
+	do_kernel_restart(cmd);
 	__machine_emergency_restart(0);
 }
 
-- 
2.21.0

