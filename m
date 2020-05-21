Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0BEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6EB2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hC8Blm5H";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qMP9aTG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEUNeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:34:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49417 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgEUNeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590068053; x=1621604053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nJJH7qKpWaTWZpqnM6zCpFB04zk2b11haAfYaSUb2/c=;
  b=hC8Blm5HmbNquTHFWJ+ENnhyhikHCeN+toseEjHjeGG9a7yD2kyRL/vQ
   h0a4f6O8HMWrwzgPCtnh+nhyjpcXtubqOVrsIDJYjxVoK9tFeEZ72O+33
   fsIRLUWllWs/JTmZzVZVyrhdb1BlwwPTmL/PuPr1QN85G7pfWp/aIWkAZ
   019itl/CR0oa84/XsDrmENm2SjJ5dPzKWGORnNMohXn4NI/xqFKshM0NN
   nqIvthzS01ybBYOJgDDMCPIqa7ti45oUip8kZBPbJ5CM9RuFEgEF0lR98
   ppKnJ97IXccewr8A03eTIKZStCyY03XhNZjLZ8Uh70OhaJkKIwVIUULrt
   A==;
IronPort-SDR: CJWpRDpodX/S+CJ4GQ5UGznAZi+oFyPOipiDIFvc0bGI46yL0bLbppxSZq+OSUYr9xkESzQYsX
 YjT+tEUuSigeMP2Ry2YTAyDXCrsOLNlen3vQPKZbfAKsdL8/ivrYh/JUBuG1npITFlWhWBakDu
 3B8KhMt/OyhYxtBYtVqMaS5PqcHH6BYgBB2oA011L8XGmaYWXN75QTxIqdgkAmPaKhKTZo1dcL
 lTpZ+z3yccP7e31QsR/GBdv1deLcqfv21FB7b48FgCQwh6M9aMaH3LJ0AduiS+2s9+cxKAAV/m
 Yy0=
X-IronPort-AV: E=Sophos;i="5.73,417,1583164800"; 
   d="scan'208";a="142554139"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 21:34:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF1/D8Junh9RiIGKLG/E9+ogsDtEtFt4/Ew0YoF7iWwoL6GzKY08YRAe7FDir/SZf5qbM86ZLvjQtA9z5VodfKq6ZuMzV++1AEc66e4sahVrNalcmwHli4n6KV/vvV1mizUFpBl45eWAy+ud3phbaPl6Bm3ZvUNQUSGyKMwrMDHEABptgwoWU4w45OMw+416ostWo0UjAXwUz02BHvvCwdrAaypW+Q7xqVuOxto1J4qGr82VfDpUVAiU1aQ9CcDY8dJDAoNbHsdrYrqyLV+EdV0/fV3egt8JEmobnmj7lO29r/w8eyDLkM8K3783RE7DpBGWtKaa1WNbAPc+4Z3/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZEhRiYIYcIHJf5Y/gEWGyFEj2Hhz8fJlrML0+g2VNA=;
 b=HLbeWsn2D6vDW6KFXeSKD9iN18UDmHerDuGzlw8Wx8FU+7RQfEz2KsoqkAXHEibtc6OWaxOGCLWCsTXKt2KW/2wEyZoPe3AsrHXzjrPEWrojW2L/o4hLlJHMWFjsVggVd/MhK5WfNNbbW4j124tEITGTL5Dh6JBB0GNaaZIkhx7I+OXTHl1wRSQyvZRSEYVhclF4MmbEH3TJlqyvUyJJC5LCDubR4k+n/qogAur4pllCIfJIC+gYvsS1bVKR7xbgi84mDOkXIhxsYjjJPEWWIAX3cJpwc02b6NGIJMWwOzJq93lrqs7rSpDnkxw3nsRwstiUUzrvkt7Mcq96fAQLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZEhRiYIYcIHJf5Y/gEWGyFEj2Hhz8fJlrML0+g2VNA=;
 b=qMP9aTG7VkmQ388UrawUBFQGrL8NzOIPPWJn/k5lyLbUl1OEtxho/h4aNO4irsvl3kmlRWkLEkr4GcXjafR/IFihsdEeSwiC6dsrtm2/37FgwAKRtpeVGyqOgav0bsLakpHqifXlY+eHa2l5sd7jkRs5yCEgvkn1nc3+4Bpvapo=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5292.namprd04.prod.outlook.com (2603:10b6:5:107::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 13:34:10 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 13:34:10 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v5 6/6] RISC-V: Force select RISCV_INTC for CONFIG_RISCV
Date:   Thu, 21 May 2020 19:03:01 +0530
Message-Id: <20200521133301.816665-7-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521133301.816665-1-anup.patel@wdc.com>
References: <20200521133301.816665-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::19) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.72) by MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 13:34:03 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b7e5965-f81c-4bc5-40c3-08d7fd8ba45a
X-MS-TrafficTypeDiagnostic: DM6PR04MB5292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5292E612F8392187834592B68DB70@DM6PR04MB5292.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8WZDJLZmJhtTKTUAC19xDWg/gnBvfL71uG4pd8yjab0GXpmeNnM3SgX9VtXA4GBY7EjvhJ9zJgNpP7vXRZag8tt4XPR+wsH9ftFipgISPz7rKWECl5Vt7XVZdhM8cxDTIcG/1pl8kAWG9QDNd/VGNMqoN7hn4I/lhC3O93sTdBmj/sjOOtjsq4tNctJa03v724dVljA9OrF1JiJnycKOseoNpyKcnjgI4NKYC2zUONHkxQ8qbSBF/nlFZgmmGLiR7WJTd21Dpt04KDII7Jm0KqoWMTxT+LbWx7dkjvAJ9B2vThFFInUuhtIygb9hdz6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(478600001)(7416002)(5660300002)(8936002)(86362001)(8676002)(4326008)(8886007)(55016002)(26005)(7696005)(186003)(4744005)(1006002)(1076003)(66946007)(2616005)(2906002)(66556008)(956004)(54906003)(66476007)(52116002)(36756003)(44832011)(16526019)(55236004)(316002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: sGwvgAS7gAjP62nv4FIF5IatnTA0rvUSOXCeDY4HT8a+FbLZJiDDcivGmN8HqEVsm67Fb1LP5Eu4ke1jRXUOoqKxJfp107nL51mAhj6rvXGsgqPERLCWKmQb3bMKT6GI3Z+6kDK9DJ2tpUQ4FPlEUji09vOXv1kWmffN9gE89zZ0SQ9b5iPYoYXaC/pleFDvf0dV+kK3tqXyFdnKrw8QKCLinOjJ9DZc+G/3spqpI4MRLQJ+/eAZ6KsrcN9FXrC/2BWN9Kuu6W4iqxUbh33nGS57Sbkl5zcvIe1jE/CPjxC6Q1nIvHMQXT0+GEkRzT0K6mSeOY9g2p4svoaIudfSJC78bwEgvjiftORG7MmxP0M0vcUY7z5vcO8Om/LB2lp1RdvZ1FcwmHysMSEdAu20eWeWY5aEZGBDmuk4PVC691/Rix6L3xwh312mTW2unbVOf8LZU61laOj+c2fIONMVQYKpZLTrH/DyoqqjkJNg2GA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7e5965-f81c-4bc5-40c3-08d7fd8ba45a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 13:34:10.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4fhoZJ0fMhOfhgMp5Ak8Xs73pz3WTG5r8CY2KccCY4Eowli6fkkSzd9j2MzznUNE9/JMTaAbUIC+1OajnXVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V per-HART local interrupt controller driver is mandatory
for all RISC-V system (with/without MMU) hence we force select it
for CONFIG_RISCV (just like RISCV_TIMER).

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 822cb0e1a380..2cf0c83c1a47 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -51,6 +51,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
+	select RISCV_INTC
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_ARCH_TOPOLOGY if SMP
-- 
2.25.1

