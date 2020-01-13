Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867CCC33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504E621569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="Zc09Cu1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbgAMGjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:39:04 -0500
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:6111
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732311AbgAMGjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:39:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4iQxI3/bju0B0B+1YjMnikB3XlIx7fNGKdBRrm+K5bmW7fZ+WZcA0Am2Q9eYkrekX+aNwpR7hDQv4OiJjkm4d005QxRE50Edn9Bx2J0VNEE/xtaC2XC5YUdwoNN9wqVTNWlqWGKIY09biCz9DE52wTuoqBoThXTaQuBPsqlaGMUYfCqmCbCPqtAeyjmoXjcNm981RdPuqDbXSWLHxXHy3BRblya1TgQKtjLL4iisrv/VaL0xxohzoFM3bXAiTY08fkDcKtgEo5J2v6irFLZqYRqirzKrLWvgUc7sMVEFEFGYFoxAYGUScf4niA5WzdnpWEyWXK6Vfk9OwMNaeH8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K/TKNzZYRSZNQkHxVC9JH2J13VtcBlz5SkUO0rfFp4=;
 b=TAj7lgTVzHZEUpD5uPTl8JUKqzyuvYTBzaf0h5RU9FRhhP6QsSZkiLmdIAyqh5muXjZ22RL+nJnVIAYLkF34svD9xcaOrgwge/VbrhNTZ0OAnop0GRsv6GNPV9d+yuv4cMOGWisMFxkF5zB87c1cZsJCV5shoCx9NLL3y7T36fRywh7HLX7cT4R2S6fAD0rABavRxuGKu+R11U+qyZXUueTLriu/D3sDObaqO7ApxQ4zoo/2EGtfn5gNmiBh3duJKqQsxUYiyeuDeSC4fSTwYMPYCkpparpCeL9CMTQ4rCPWZ2FlK3y8N1qAY2EZTpZCsK2yg/oYijUDMy67VPnURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K/TKNzZYRSZNQkHxVC9JH2J13VtcBlz5SkUO0rfFp4=;
 b=Zc09Cu1zwDPK6J0HUIW/WFihTJDk86asRgF2UqNEUqEyjsbnuRj9ZHM5Mjn7hSE8bcRU4svs2oPpwphZ6w2y62xJEfYvp3rUBBUETPJQFqFT8otohZ7LpfhqiGbFYgH001vCsk7UbiqPlDgecfQerI5/26/ogaSfM6pWmG14trM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3317.namprd13.prod.outlook.com (52.132.246.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Mon, 13 Jan 2020 06:39:02 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2644.015; Mon, 13 Jan 2020
 06:39:02 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, allison@lohutok.net,
        alexios.zavras@intel.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, bp@suse.de, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v3 1/2] riscv: cacheinfo: Implement cache_get_priv_group with a generic ops structure
Date:   Mon, 13 Jan 2020 12:08:19 +0530
Message-Id: <1578897500-23897-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578897500-23897-1-git-send-email-yash.shah@sifive.com>
References: <1578897500-23897-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: PN1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::21) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
Received: from dhananjayk-PowerEdge-R620.open-silicon.com (114.143.65.226) by PN1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.11 via Frontend Transport; Mon, 13 Jan 2020 06:38:58 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [114.143.65.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a38ee44-dbaf-417f-4561-08d797f346d7
X-MS-TrafficTypeDiagnostic: CH2PR13MB3317:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB331722C8264A3ABDE67D56A38C350@CH2PR13MB3317.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39830400003)(136003)(346002)(189003)(199004)(66476007)(2906002)(6506007)(66556008)(66946007)(26005)(186003)(16526019)(44832011)(5660300002)(2616005)(956004)(86362001)(8936002)(36756003)(52116002)(7416002)(4326008)(6666004)(6486002)(81166006)(6512007)(316002)(8676002)(81156014)(478600001)(107886003)(1006002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3317;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xd28e0eodB5pyxZ7v3ZoL08X79MQbOpM5AGj8j/51b2/xDWjdBZa3Ty926EVH0irIWrtFvqPAZ5angy7WKozT6RhqWCQiGoynSLoPBuHmqcMCMyIzRNgCVIHQmqA9pfJTvaIo03kBEcWoHic/M5ur7m4l1ITIdHQanGhO7zAIpNfidP4YVeHU0+st8pVKnhDw+8NJqV7VL5OPNb+iG0KIpnD8iFSw19vjNgEzIwR+hp4YvDsXbNe+AYgtyF8iiaVKIplz9f6zSiIiCzGuPj2JA1c8UMzNp/3aOorLScSES5oTsZvjcwiIfDlFCF45UAVCnKCiNtPnTBdmMXttvd+gRpdQfd7Rgt4gIDpc3Kp2ej0PQfYfsGDvbZ8NweuLT2Qy6cPGIaYRD64Vy/F9nMAx0BdiklvYS/moTIaHRH4Hm7Pqj7UHlETDtYJFuDHs7dviblE1wJ5+fuq9yuInhV5rU7TPXqJR4hcPr9JHBF/dGo=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a38ee44-dbaf-417f-4561-08d797f346d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 06:39:01.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW2MjdbVB3XGVzPeipl/iEC32D574Mwlpv3mmQIb/Awp9BfS9gXMUq6HF45+1Po7nAHlj4Fj/uZLPyI6vaNpHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement cache_get_priv_group() that will make use of a generic ops
structure to return a private attribute group for custom cache info.

Using riscv_set_cacheinfo_ops() users can hook their own custom function
to return the private attribute group for cacheinfo. In future we can
add more ops to this generic ops structure for SOC specific cacheinfo.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/include/asm/cacheinfo.h | 15 +++++++++++++++
 arch/riscv/kernel/cacheinfo.c      | 17 +++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/riscv/include/asm/cacheinfo.h

diff --git a/arch/riscv/include/asm/cacheinfo.h b/arch/riscv/include/asm/cacheinfo.h
new file mode 100644
index 0000000..5d9662e
--- /dev/null
+++ b/arch/riscv/include/asm/cacheinfo.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_RISCV_CACHEINFO_H
+#define _ASM_RISCV_CACHEINFO_H
+
+#include <linux/cacheinfo.h>
+
+struct riscv_cacheinfo_ops {
+	const struct attribute_group * (*get_priv_group)(struct cacheinfo
+							*this_leaf);
+};
+
+void riscv_set_cacheinfo_ops(struct riscv_cacheinfo_ops *ops);
+
+#endif /* _ASM_RISCV_CACHEINFO_H */
diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 4c90c07..bd0f122 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -7,6 +7,23 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <asm/cacheinfo.h>
+
+static struct riscv_cacheinfo_ops *rv_cache_ops;
+
+void riscv_set_cacheinfo_ops(struct riscv_cacheinfo_ops *ops)
+{
+	rv_cache_ops = ops;
+}
+EXPORT_SYMBOL_GPL(riscv_set_cacheinfo_ops);
+
+const struct attribute_group *
+cache_get_priv_group(struct cacheinfo *this_leaf)
+{
+	if (rv_cache_ops && rv_cache_ops->get_priv_group)
+		return rv_cache_ops->get_priv_group(this_leaf);
+	return NULL;
+}
 
 static void ci_leaf_init(struct cacheinfo *this_leaf,
 			 struct device_node *node,
-- 
2.7.4

