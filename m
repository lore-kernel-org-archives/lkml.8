Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F0AC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282282072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="TPxaGr3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgBQOLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:11:33 -0500
Received: from mail-db8eur05on2111.outbound.protection.outlook.com ([40.107.20.111]:6208
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728395AbgBQOL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:11:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW5QkjWUGr1AiZRfgM9m0t1fBy6YT80UcbMZJA/KgyRCt5xoptrgQXlgcX/4Jg141sAZRxuFafogfIvbqeYL/NYfmSsxODyJ9s7mXeW6JSWT3A/OSfdQ5P6WPKfpZ4l+mZrggP56YXXdCZrYg8Zzs/qBvLCyynMaGByfepK9GhAVIs5KGzGf6ECFpzndzdGGvck56Zh1tTYoXh3AialtvNYDcdHjFfwJk0adAKWe3O2HWvAbdDlEt6n+0WcYgdmgKoxY6z9A9RXf7EWIHHZYN3RzRISho4+tj3NyiJtVNUBj/Nphxh9Ioc8Fo1caVgx9scBOhcY8obTdN4fKBDtm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpBzFUt8+CR65vQxJPaFhhfjVPFQlNmvgc4okBd60a8=;
 b=Orhax7z9Yzljl9P/35EFxdk9bG/9UH00thM3u+G2wl03XZ5fha1Nk/1Kg6qgYb0G7TUUxM6/SFufW886GJYfKo++juvTfYFYba91edoSFMWebNQ9yoXU3BNAC1SI3BRlEmLvb8W/MNEN7AFzSqMQ6OxNrL8/W3KNWbK+9mZU515vT4wAqwRcqaa4BwStWj1Fc4CTEnz1NLr7DG2UJflos3LaUJCxmQzZPbDRBW8yJGGwnhTQX2Gl/vO2cY1TxU6C9nW2zQybNtdJsEIsFNA5Egr/Hdf13e77SZUE+MtMmQ75jxU0+t/hw9L8KIrcYH2q2MpT1rGD87VCaKef4a5/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpBzFUt8+CR65vQxJPaFhhfjVPFQlNmvgc4okBd60a8=;
 b=TPxaGr3QWsYq/MpIxtyJIl+0HjNcyjwqU4CB0lIOXW+jn7AjXUQtbpB6Qjh+xSErAkqXWqMhmpNKhauaSwBUMV/soCFe7TE7/ONLSYMG4lKQSeFXSs0K/uJFJsSydSeQydRVYQMTTyMlC6ofPlyQ547wx0SvFEtjDs7KzFxHmC4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from VI1PR07MB5040.eurprd07.prod.outlook.com (20.177.203.20) by
 VI1PR07MB5056.eurprd07.prod.outlook.com (20.177.203.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.12; Mon, 17 Feb 2020 14:11:26 +0000
Received: from VI1PR07MB5040.eurprd07.prod.outlook.com
 ([fe80::20c4:7ce8:f735:316e]) by VI1PR07MB5040.eurprd07.prod.outlook.com
 ([fe80::20c4:7ce8:f735:316e%2]) with mapi id 15.20.2750.010; Mon, 17 Feb 2020
 14:11:26 +0000
From:   Alexander X Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v6 1/2] ARM: PLT: Move struct plt_entries definition to header
Date:   Mon, 17 Feb 2020 15:09:54 +0100
Message-Id: <20200217140955.211661-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200217140955.211661-1-alexander.sverdlin@nokia.com>
References: <20200217140955.211661-1-alexander.sverdlin@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::14)
 To VI1PR07MB5040.eurprd07.prod.outlook.com (2603:10a6:803:9c::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.32.181) by HE1P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Mon, 17 Feb 2020 14:11:25 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [131.228.32.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc0d8d86-0914-469d-620e-08d7b3b3467a
X-MS-TrafficTypeDiagnostic: VI1PR07MB5056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR07MB50564DAC79BB411F1582383788160@VI1PR07MB5056.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(189003)(199004)(26005)(6506007)(6666004)(4326008)(86362001)(2616005)(6916009)(52116002)(1076003)(956004)(478600001)(54906003)(186003)(6486002)(8936002)(8676002)(2906002)(81166006)(66946007)(81156014)(66476007)(5660300002)(66556008)(6512007)(36756003)(16526019)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5056;H:VI1PR07MB5040.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aF3T1ik8F0yERWJ5XH+vUvkP7KzhNgvcSV/I54yXblaaEEAACjXBaNS8gewSc5qcULVdWOlfv4U5iNH8KEdkHJFi7iRpdk/Uevl6ZtqA/DAfqMXcCKSR8/0Ac4fwGiMrQUw4neaaio2MICV255YzjrNUGxKTKqjDVj7FnNzzf6JyvW8bH/Xfep63PrW1CB2AOzEYQWw1HJJimcaw0w9bvpYSBUvrLW2eA/r2VDtDELgsl1yw9nmEW4ZTiEulVw8Od9vxAe2GYP3iWuJ0Kog+fTqrqHjtCVYB+5/YsRCye3yQyVp/rxuAFrtcyIl+HLuyoFd8sV7fSQzyN5bhbmEybvmHl2CN1C+JB5i02aqTYy6DATBLz/jT8zYn99f5Sjt/FAZNWqzSt4S2TTxbqo8OESwKMKVdD/h3p2Q5sR/MZtCcz30wFm0yMJ9EBm6ZDlSo
X-MS-Exchange-AntiSpam-MessageData: BolKjEGMaWQS6yXj6LXZeOZme9HnpCTbym5BHIclgHphHpfduE/4DB9AllFjbEKYoWjdyExQqmsVQqEAQN42ZsQX5HXaFUKxdHvYg6hSLW96hJc8EXjT5RQGnTjCfNO4VcEQhgveK0E/FWEYueg4lA==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0d8d86-0914-469d-620e-08d7b3b3467a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 14:11:26.0267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1inIrjm18BcNlFdlRe61x1JH8+VLbc5XqIgpbOwJuN4SrIHO65JErZs8YF64w5HrWeWFbcnr4mFpN+BqPvcEMpcxoHh07OA1oajnrWu07vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

No functional change, later it will be re-used in several files.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/module.h | 9 +++++++++
 arch/arm/kernel/module-plts.c | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 182163b..78e4c16 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -19,6 +19,15 @@ enum {
 };
 #endif
 
+#define PLT_ENT_STRIDE		L1_CACHE_BYTES
+#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
+#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
+
+struct plt_entries {
+	u32	ldr[PLT_ENT_COUNT];
+	u32	lit[PLT_ENT_COUNT];
+};
+
 struct mod_plt_sec {
 	struct elf32_shdr	*plt;
 	int			plt_count;
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 6e626ab..d330e9e 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -12,10 +12,6 @@
 #include <asm/cache.h>
 #include <asm/opcodes.h>
 
-#define PLT_ENT_STRIDE		L1_CACHE_BYTES
-#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
-#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
-
 #ifdef CONFIG_THUMB2_KERNEL
 #define PLT_ENT_LDR		__opcode_to_mem_thumb32(0xf8dff000 | \
 							(PLT_ENT_STRIDE - 4))
@@ -24,11 +20,6 @@
 						    (PLT_ENT_STRIDE - 8))
 #endif
 
-struct plt_entries {
-	u32	ldr[PLT_ENT_COUNT];
-	u32	lit[PLT_ENT_COUNT];
-};
-
 static bool in_init(const struct module *mod, unsigned long loc)
 {
 	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
-- 
2.4.6

