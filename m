Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BB6C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB47206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bJhpgXxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgC1Sby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:31:54 -0400
Received: from mail-co1nam11on2105.outbound.protection.outlook.com ([40.107.220.105]:37857
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727307AbgC1Sbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:31:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDWcLUiYdVbmmk9244F99Yej5dzQ3VqUFptkMkx3JPAGxSlZKc6ICpImnvzf4YGiY3gNGFzFOvNwj9cGgWSJUIZgnbLTzHMLQ4nHoGsjb8xa4NOC0/oGuBKTXTg/tlquNbYMBkP2g/1Ep89kGyOOJRJLx+nrTbye2l1Syilpze/79Y6oQCtpRJ0QGacWMQKE1mfGI2kiioA+3jTqS4ZRHypuj8QT+2bIG1aRhUKbNgx8zVvQHEavRu5ji8rqQe+lyPYulBjBABhuKTXRhySmqpXeboS55+sSnEzwaApHKXQd/e3c90J1cnC6sxy4kHpzdVxZzdq5eUx5ACp40zD6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjVQ/uaBIJ19PqNoBkM7nhlQleLo1yXyrpNO385VDjc=;
 b=bMz0fgWecoJKyoSJFrdhnbFbY8Y1z8ye58eiVylI3S7ty3yuss5OryPXyneJ4chClcKTHh65dL8u3lHeTQzQoqjpk9MPbQ7/4J8fB1x1MruImw66fz/fi8iTIFpWvaB/z7LuIYV+gS4N1LoCM9sRjvA2SwmbYPMdAD5xJHL8jK3l43iK1pgCFDxuiHNE+Wb0CrrNu8ngRs2hGD2cvXKPoYkCSwC+MT7ubY3w5kT8tU5CGF6sZHy150d/2431gP58RFAgClgMGcxVKWQwGYDM127cWkqMbB0c5tfaPndYvv39V4UXlVoNaA1Ddme6pkXdhdwiJA784GCNXs5OK1TPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjVQ/uaBIJ19PqNoBkM7nhlQleLo1yXyrpNO385VDjc=;
 b=bJhpgXxRmmrmqdaLdauM2xUEHeid5rb45EeWULqNWCGET4gH1VABsgrzO9yvVyJPI+fgVdj0Fp0O9MI97+T7C3I0TNpbtRvQtZRVhOE4VTYjBYcDdLmMEJTqndPxuRHRwPZm33WN88DnlnG8I35eM8TruvFLWS8KWGC3muCteI4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
Received: from BYAPR01MB5494.prod.exchangelabs.com (2603:10b6:a03:127::30) by
 BYAPR01MB5205.prod.exchangelabs.com (2603:10b6:a03:7f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Sat, 28 Mar 2020 18:31:37 +0000
Received: from BYAPR01MB5494.prod.exchangelabs.com
 ([fe80::a979:b2e2:fdaf:1ccb]) by BYAPR01MB5494.prod.exchangelabs.com
 ([fe80::a979:b2e2:fdaf:1ccb%6]) with mapi id 15.20.2835.026; Sat, 28 Mar 2020
 18:31:37 +0000
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
Subject: [PATCH v3 2/5] powerpc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Date:   Sat, 28 Mar 2020 11:31:19 -0700
Message-Id: <1585420282-25630-3-git-send-email-Hoan@os.amperecomputing.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:903:32::23) To BYAPR01MB5494.prod.exchangelabs.com
 (2603:10b6:a03:127::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from engdev037.mustanglab.us.amcc (4.28.12.214) by CY4PR13CA0013.namprd13.prod.outlook.com (2603:10b6:903:32::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.9 via Frontend Transport; Sat, 28 Mar 2020 18:31:34 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea46e873-041f-48b0-164f-08d7d3463f98
X-MS-TrafficTypeDiagnostic: BYAPR01MB5205:|BYAPR01MB5205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB52050A0B9C2CDAF1C5B773AAF1CD0@BYAPR01MB5205.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 03569407CC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5494.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(136003)(39840400004)(366004)(346002)(6512007)(7416002)(107886003)(16526019)(6486002)(26005)(81166006)(4326008)(8936002)(2616005)(6666004)(186003)(956004)(8676002)(81156014)(316002)(66476007)(52116002)(6506007)(66946007)(66556008)(86362001)(478600001)(5660300002)(110136005)(2906002)(4744005)(921003)(1121003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnQ9O4/9RaN+55U7qI3FtQuurwZ2oheTnrJySffzSG1DGVMxszQGp+E7QLRJwb6clHUSa70oal4ziiStljmuLaosuKlQry5EZ3Ky1Ny9frgEmbNpABtRzhTWFIRuqVcrM15F7PF5mN49Jzty0EDA4nYFwim8JhoZicd+R5/xhpq/8/gp66V6uceErbN1GbQHtJgHFvbNU2hFcgo/AOWPE41RCSGhK+f2vogVqV4ZOp08KNr9XqUhTsAwSGxKTwaMoPw8kZz3KgNFPpmmMGBKe5Re938vDdu0KfULXERfhgi55wBV9NqbFw05WfUzCmdihWk4rbjkqPfj1GbXwjacIo+9RpkU77Fv8dTSg/jJ2mShasaM8JYePiaksIdRkmKq3JHMkXjudZd0RlAAkJEmSacKAXzY1NWm1jJ4/6H65xFGZGSP6dYB5ejzygrXnV9VCj3nKT1sUr6Hd+tcG1wYNhoY6bghWxaeepcfatG5uBYM9GHVnNpXjdhDEL68KHZg
X-MS-Exchange-AntiSpam-MessageData: 9mIHvr08bz9lai7JZ8QsGYMRdIa10iPgkLj96ciZMDJqBliKcSHqIWAG4MwXiHDUqZUiFVgell4ZfI+L+R4h7asghi1xtFVMfEDGibgpUnsjcJiKwSuUdOl6a38YrC1wow49o/7AkXJRvtHKkm6yDg==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea46e873-041f-48b0-164f-08d7d3463f98
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2020 18:31:36.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSxY5CrOZ2+MVvfPQwfaaD0CgWIOuLYUbiRJ3iHoCsk5/knbW4wHO9sinbRW3irFsmTk8HIRZUYbSUuhtRWV2LFpPleZlXdvfS3jju8X+QI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_NODES_SPAN_OTHER_NODES as it's enabled by
default with NUMA.

Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
---
 arch/powerpc/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e2a4121..4af2699 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -686,15 +686,6 @@ config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
-# Some NUMA nodes have memory ranges that span
-# other nodes.  Even though a pfn is valid and
-# between a node's start and end pfns, it may not
-# reside on that node.  See memmap_init_zone()
-# for details.
-config NODES_SPAN_OTHER_NODES
-	def_bool y
-	depends on NEED_MULTIPLE_NODES
-
 config STDBINUTILS
 	bool "Using standard binutils settings"
 	depends on 44x
-- 
1.8.3.1

