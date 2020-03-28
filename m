Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F82C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701EC2071B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PhQhSw4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgC1Sb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:31:56 -0400
Received: from mail-co1nam11on2105.outbound.protection.outlook.com ([40.107.220.105]:37857
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727286AbgC1Sby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7wllvL8E4KTet3K+0qgYvvmRLPbMSSFFwLhWIvNIpgqZNV5HhunCR9XP8u+DFmFpf0AQNzggwmq+j+2QBGHX+KQdZcwPcQ5I2GbAq4tqeKNsezHZ63G88hrjyXenN3bPct82g1YwL+qs1tx0EJKHp891J3LQNYI2oUbi6J3lNmFaE/kBip0tuZjORdbiWhklzZIAWPrhL/6+ghLJV63Iken4LTgrCx2spuCHjhqREHyr0ctrNSFySRAbgmqt8Z4OzndQ9tRGjURWO1UBye+WBrgt/dxmLSxSHohxf9j2YAGGsWbcRc6z+/NfMm4P+FvYxX98B2C/RDdjeTwMSNNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/gkBkcFa6a+S7Gw0WirIGQRifjfKk9azTENeVmvEq0=;
 b=hE7a7qc5qHb8ol9gCi50H6/WulWmZtNkLd/r+vdbeQ3SVzmNxkKY4gaJ/zUxafsCI+zCcgAwIR70t5GP0dexi7jTsZs3cszFEubderW8nYFXVq4W/jwp0b3ZKo/DM/BTaU4i5TONVocrZPIiEeE9zGTWV5XYDVoMlE8P55fBcQcv+Kd6iUcnwIGhMKXHAO1r3IUrury3IXngsHbgvDjtDqhd80aGGDrS8ZSNCnX51D9b3sZp9FBiuYtIdoiUUqq5A5BYJ69r6z+jE2D9P6S1mVrWTJKUi+bX+N9gkduNc7ax+VVxvX87O1F4Md1An3gLNjgRBLTlf52U3RrBp+NVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/gkBkcFa6a+S7Gw0WirIGQRifjfKk9azTENeVmvEq0=;
 b=PhQhSw4xWAm+ylZb2i3S+XUNhlCRk2z09CYkPcEoAd9iTbuM04cFagbqv8OHSwT8XBmjCQ4UiEOWoeiVPYojZhV1OWTNTarylluzMYHwiBvQhIEoU45JZPKty+K1wGULi4YLiQPvGvLrE7rypnkY67cKbw4mbMJgUUNwQvOV8Wo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
Received: from BYAPR01MB5494.prod.exchangelabs.com (2603:10b6:a03:127::30) by
 BYAPR01MB5205.prod.exchangelabs.com (2603:10b6:a03:7f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Sat, 28 Mar 2020 18:31:39 +0000
Received: from BYAPR01MB5494.prod.exchangelabs.com
 ([fe80::a979:b2e2:fdaf:1ccb]) by BYAPR01MB5494.prod.exchangelabs.com
 ([fe80::a979:b2e2:fdaf:1ccb%6]) with mapi id 15.20.2835.026; Sat, 28 Mar 2020
 18:31:39 +0000
From:   Hoan Tran <Hoan@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lho@amperecomputing.com, mmorana@amperecomputing.com,
        Hoan Tran <Hoan@os.amperecomputing.com>
Subject: [PATCH v3 3/5] x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Date:   Sat, 28 Mar 2020 11:31:20 -0700
Message-Id: <1585420282-25630-4-git-send-email-Hoan@os.amperecomputing.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:903:32::23) To BYAPR01MB5494.prod.exchangelabs.com
 (2603:10b6:a03:127::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from engdev037.mustanglab.us.amcc (4.28.12.214) by CY4PR13CA0013.namprd13.prod.outlook.com (2603:10b6:903:32::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.9 via Frontend Transport; Sat, 28 Mar 2020 18:31:37 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8d6d229-6332-44f9-8341-08d7d3464113
X-MS-TrafficTypeDiagnostic: BYAPR01MB5205:|BYAPR01MB5205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB5205DA9091ABEB7C4C27C4CFF1CD0@BYAPR01MB5205.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03569407CC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5494.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(136003)(39840400004)(366004)(346002)(6512007)(7416002)(107886003)(16526019)(6486002)(26005)(81166006)(4326008)(8936002)(2616005)(6666004)(186003)(956004)(8676002)(81156014)(316002)(66476007)(52116002)(6506007)(66946007)(66556008)(86362001)(478600001)(5660300002)(110136005)(2906002)(921003)(1121003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVKo0fNEyEQjMd0nAUq29RkKT+yjJWFOoVRc4doSzt/FZRdTJMiMtNJJLpzNavGZnAt5mZAU0G2n01kxyD0Ai6B5LYiolpjudVwpO9NfdnClP3mozWQYtvGy86LP+DfouusLc4eIfpCQSK5yv7Ihp/IKNSD6kJnIPn01pzL89UPN10ZZ5mc69LRikmHATlUH5DkxpHysMsRUWplSsbyE/xAZ6hisdo76A1kaMcUor0FXxUI3WwaVCC8TkYftZQH8FeskunLKEETQS/k/ydhL6va/5xSaa5I4p8CqmybDiwQsrDKGiaWu8V3olbS0ES3R4by5rBrMoTAkw9+BOeT2Wj/zTyS0IBORH/bdqLM1vqn5nD5KxK8RgjdEtlh5YEVdPlohoL3WOsMqLNQlR5JGo8YAp3y3hmMnUMAV7CH+RwLPdDJoN1OPlwrZstA0yQ8xp/B7aF0VkM2tjQP/N9z/1O5Bmm3qYrKULi+673kuHqZRUSU5Q1EF+RNQGUX5GgUf
X-MS-Exchange-AntiSpam-MessageData: ti6mu5uqT1IczkB/3/V/ZTlz+i0K/DXXcpm3OdnR36fSoW2d0j+JcVwfYId9HoUnyl6UwCXVtx+nPuXaH5XEKNblFXLi5Ll1snFM53H4U+r9hixP2z+r/6kk0wdO+Y4OiguK7/lo0OanevI39Uz/qg==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d6d229-6332-44f9-8341-08d7d3464113
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2020 18:31:39.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUYFwzkNh7CMfPLX+4RfDiZyB6NR0GUcf2MtHSJrAax7kM5urrIbhcZM7/jvr+hwZqQxqUw8jCBk/jBsMOxF81O5mzFz/aZtsphyccB4+KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_NODES_SPAN_OTHER_NODES as it's enabled
by default. It is now enabled for x86(32 bit) configurations
and do not depend on X64_64_ACPI_NUMA config.
Because of that, on NUMA enabled system, early_pfn_in_nid() 
function is called by memmap_init_zone() during boot-time.
It doesn't affect the performance at run-time.

Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
---
 arch/x86/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e89499..a938738 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1581,15 +1581,6 @@ config X86_64_ACPI_NUMA
 	---help---
 	  Enable ACPI SRAT based node topology detection.
 
-# Some NUMA nodes have memory ranges that span
-# other nodes.  Even though a pfn is valid and
-# between a node's start and end pfns, it may not
-# reside on that node.  See memmap_init_zone()
-# for details.
-config NODES_SPAN_OTHER_NODES
-	def_bool y
-	depends on X86_64_ACPI_NUMA
-
 config NUMA_EMU
 	bool "NUMA emulation"
 	depends on NUMA
-- 
1.8.3.1

