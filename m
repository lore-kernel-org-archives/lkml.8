Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE02C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D19820658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bUMpLgnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBCTza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:55:30 -0500
Received: from mail-eopbgr770134.outbound.protection.outlook.com ([40.107.77.134]:45735
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgBCTza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:55:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0UXBFBNoB7pShZLHO8p7G2cyVALhsLxU4r1HI9um71pDEKj97vvjT+yLbPJs14Bg4ajqPKrBklFbP2cTnnfXxUSpCCmnXSEIdVtooLtD4BRTFcV8wnsbmx54O2NZcY0fzuZ8w/4F1T7nNEY3QtwVkUR4ZA9VjMNL18sDpn3XfETww0I7I3tBdfmoJpnjLw07b1YimgyakJ6gtnTVj0CtoebxEh8D7NUv6pM98JYvbd3dcR98bhUYyD23Glk2bGkcWYXIDVSP65/4hGTHLWrT4tDq/39wO3cK9kBsPOHBf9npFod7xP+WFh6/vqN/kOkVEk02NCWcX5Jcr0QtnSvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgcSFwvhOVVRLqDHPFmOhT9wNQ0jQz4i5OuW31uoSGk=;
 b=PNvqg+ZUjCmrr6TDqox0/iUT6TG1KHzGNi7kfshe3eJGHE2Q7uG8eZzntyEcbXQWoE0wi7DtylUoCXijumajC1vdtiIEwJyTAJQgxr2q5Iuqf7a0v9XlfdxRzddQFITfXVKKOXVYgl+HudcxhQ2SjJ+7l11A6rTlSpyV6fuCCB2oQbKUEGTDqpGrw1GQlvU4i76DDJCA8iV9KdNxHvFm9rlPzfVeBQjCu7D74R4Z8qAXVJ5pOH3HjwMMnFjm5W0kCJnaG0yvPx5V4z5Y7q882wBQgtX0PBRDrvg8enqn6xGjYwA2zlq/aPKxFlltxRLE3ICsO2oHhtY3oqfvf3R9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgcSFwvhOVVRLqDHPFmOhT9wNQ0jQz4i5OuW31uoSGk=;
 b=bUMpLgnPdTGVGA41V0qYw26S1kY9b1XgYqXv9UuCbCXVbkzmJaeCHEyzufWiAI3OO8MEUNxOLq1WYp/6mjcR6I4Ib+M3KoCy4+oQxNuVAGEl/QxgaLxoxb6Ua6fK0j0Vr7JMMmIO/Yoh2zi2NjkNcFejZXtAfyndC2iOIKYqCP4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
Received: from DM6PR01MB4090.prod.exchangelabs.com (20.176.105.203) by
 DM6SPR01MB0023.prod.exchangelabs.com (20.176.117.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34; Mon, 3 Feb 2020 19:55:27 +0000
Received: from DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::e148:5333:b3b1:b153]) by DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::e148:5333:b3b1:b153%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 19:55:27 +0000
From:   Hoan Tran <Hoan@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@os.amperecomputing.com,
        Hoan Tran <Hoan@os.amperecomputing.com>
Subject: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for NUMA
Date:   Mon,  3 Feb 2020 11:55:14 -0800
Message-Id: <1580759714-4614-1-git-send-email-Hoan@os.amperecomputing.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CY4PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:903:117::30) To DM6PR01MB4090.prod.exchangelabs.com
 (2603:10b6:5:27::11)
MIME-Version: 1.0
Received: from engdev037.mustanglab.us.amcc (4.28.12.214) by CY4PR02CA0044.namprd02.prod.outlook.com (2603:10b6:903:117::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend Transport; Mon, 3 Feb 2020 19:55:27 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a165989c-0d51-4c9c-7d8a-08d7a8e3040f
X-MS-TrafficTypeDiagnostic: DM6SPR01MB0023:|DM6SPR01MB0023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6SPR01MB0023E8F6B2E9EED38F396437F1000@DM6SPR01MB0023.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(39840400004)(346002)(366004)(136003)(189003)(199004)(66556008)(26005)(4326008)(956004)(66946007)(107886003)(16526019)(6512007)(86362001)(52116002)(186003)(5660300002)(4744005)(66476007)(2616005)(6506007)(316002)(6666004)(6486002)(81166006)(81156014)(478600001)(2906002)(8676002)(8936002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6SPR01MB0023;H:DM6PR01MB4090.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnICTzxcqrErTymH5egEdm3QaQZZ5q3YHQfN5Qx1i1M20hSyH44DiGa7Q7kgsaO2jc6NoCQGguxmb1SIy+jvxUbjDvZEua2sjw67yz5XU48WR6MVjS87/rioSXNc3y0WVAwwXJwlqUvl0GL//XHp3XNAn77fkryTw4oX3gaIZV08k/Gt30wXOK6u6jjdhwd01nVVweZrlnRjhrOnlfFcuelOkSbLLfGTpj4b5YN2r4OgkWeNXbz2SLdtmdpQJXkXUlLIn0KQVQcttjf6ztmKvdTB1V48EQPiNI3AYpOR/5frU7bKTlOrc0oQg0xsVeBd9PualnN6LdETTxTxAxDiWY4/WGv2k9W27GcpzFLv6DkpubzA80JbGJtZU3j6C/SCa4kRJRXDaRKEprIzeJe8EvlVZdkV8PuhwoDUcq/9uKYONGOO7HrT935KQZu5cehA
X-MS-Exchange-AntiSpam-MessageData: 9MRghyd7Ci2EUfz4W8EmzAzI1nhXb2Tk+YENUHeYEXv8kI8y0Mz1uHNhezm5ntsLaCii2VehTNerl6Cx+JBx2zMNi1UGE1/gQcFShw9ABN18CHksUV5Mw19bH1ArRfi8/SJP+rXHosE/8aVohMUU1Q==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a165989c-0d51-4c9c-7d8a-08d7a8e3040f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 19:55:27.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1KFyvnbnULvfaTKh9JwOatFlo8iOD8tAS1beG/56eCsra8f2yDvh5RQA/aOL/QkwTEu1kGnSwpmOdVoHz068CCUWld+1KcTUbJRjs22F9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6SPR01MB0023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NUMA nodes have memory ranges that span other nodes.
Even though a pfn is valid and between a node's start and end pfns,
it may not reside on that node.

This patch enables NODES_SPAN_OTHER_NODES config for NUMA to support
this type of NUMA layout.

Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
---
 arch/arm64/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e688dfa..939d28f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -959,6 +959,13 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 config HOLES_IN_ZONE
 	def_bool y
 
+# Some NUMA nodes have memory ranges that span other nodes.
+# Even though a pfn is valid and between a node's start and end pfns,
+# it may not reside on that node.
+config NODES_SPAN_OTHER_NODES
+	def_bool y
+	depends on ACPI_NUMA
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
-- 
1.8.3.1

