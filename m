Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AAAC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E763120838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="V94lJhhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgD3J7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:59:21 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:37818
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbgD3J7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:59:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=modYXQGQcyDQ2xfFapaVudJriEnKSztlssxbG2mRLZA5mNykI843NQZdqqlBbj67Tv+XZKn28up87aU85up0pMHljJQUXCkFdoMDtPS1p3q0G60spZA2JAm602nC9gDr5Z3Y3th3HL0bcN2fh4X3Y8XUHYyHRwAz309XZ4XWlVzOSjbCZNcheEi3mfLLpK/93aaDQQIqhmeLT9mTsUtDMsIVgOz7b4638gyw/A27M+S4Z8zph06fdd98cb96osRuJA2/cARRofO/gFz57nVGn2II+WBHxJY0UdDCkAJPB4MPhG1LpVUK8qPwUnJOrfYGfksraT6vJWePnN646s8AxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO5KEr/c0V47cntzr6VM8XYrvXQmDezAE3ACOoAylNo=;
 b=WKK2bD1xozB//Iof4LgxtH7Kh3Y41XvByD4S8WwvhpZZSopVeRcts9wivFsK6WRmqAOq6OR6JAW831G6JucKn7nKrGnpucYAZGMlMfoM8WT6aVjTsXXZthlPREAfsRdBXib+HUlMvXFdmKlzUGfWd7ajXaD1otYVtdwWiQMqsJG5W0nMn0Dpw3wAWU+ictVp6NruYz1QY/s1mrPDyMknU3lJ/UqyXmqGiD45T0uA1uMzCVI/q9zAZ6S6lx5LIOLo2rGOjLuGC6QCWWbJJg4SXAs+0xVHCPzdn7izLt/rgw4Rrlih4ezuDlwCRR4GrngfWZ9IuosoEZzV7lupa3JClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO5KEr/c0V47cntzr6VM8XYrvXQmDezAE3ACOoAylNo=;
 b=V94lJhhIYF7dsKLMmVZ/SJx+BN0lN6M1uYMcHKPZpn7YbLh3dCJJHYscOAXsJESgyfjynUEZlVPP3lYs7sCECh7m9vIPLniazJIQ56SL9H2DGbDxr5pIx2bUq0ReWxjsQ24LRdG/WpKU1R2s6/3iudPH9fy/LXs405rDu5di4IU=
Authentication-Results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none header.from=sifive.com;
Received: from BN8PR13MB2611.namprd13.prod.outlook.com (2603:10b6:408:81::17)
 by BN8PR13MB2884.namprd13.prod.outlook.com (2603:10b6:408:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.14; Thu, 30 Apr
 2020 09:59:15 +0000
Received: from BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929]) by BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929%6]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 09:59:15 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH 0/2] update is25wp256d page write capabilities
Date:   Thu, 30 Apr 2020 02:58:50 -0700
Message-Id: <1588240732-13905-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BN8PR13MB2611.namprd13.prod.outlook.com
 (2603:10b6:408:81::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 09:59:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f194c6f-10a8-4a0f-10b3-08d7eced2372
X-MS-TrafficTypeDiagnostic: BN8PR13MB2884:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR13MB28844AFF04000F500A5F6BF099AA0@BN8PR13MB2884.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MLehkgPkdJOeopcQ5DInrJdPpBpzTm9wqLhZroxLVHda4Xe3cClvQlAAh9+JrrOvWSIVR6R2E7H2X+l1y1iVCXshdJG0E6dEo5LmYISOHTppGezXUcPnavuwovA7HuNGbHOaIg7YPR59Iw3U0fHaFSLUsn8JTJA2pcle3iW23I0Ie4/RNJ4gzbhwyKUV7ATKqT5nB6PLcnoEeygaIY6zEXNuhfeHSpGHpJPourywBUL0nNb1RAmEgmFvcg5PZkOU7hA5mksWHIcpu5NYFY8RmErfQSmPYtglJMZxLQalE37woFys/0P+/9w/E2JiS/ybg0xa2MSrdXJH2SGcNtJHQ5gdjTz/KRrO8NzHiNGTCoxRs11X+PHIbcz2QdM1H0bZd3MnIOWiZw0ZSAhhALUGP83otyhFgdgXhz7UVeN1IJrqX5GaP0icZLm/7RmYKxz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR13MB2611.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(39850400004)(396003)(366004)(7696005)(52116002)(8676002)(8936002)(16526019)(186003)(26005)(5660300002)(4744005)(956004)(478600001)(2906002)(2616005)(316002)(6666004)(66476007)(66556008)(66946007)(86362001)(15650500001)(36756003)(107886003)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DHrcdylyOx4qjkqpiFsp8JI4sGtnPjIfZeVf9QSsxAyZaOLM6U3DaA2nRihFvUjNM78RNyIvBqci0ZXMF+JMG0R6idQGeIcMJaxHe0jpIiOx3VJWnLpm8Kqev1HLaRtTshbzJHnoh01tt8WP16SvACPAJHWW0oym08R5J/T0eFEth10mEPAplG8oDlIfmDy+RDA7dfbsDuORvXDt8nJV3OxkZOLyHKYEMPrCnq0TUGGX30ETepqBif2MpRWu+PfWn/lbVO8TinS7eVEGzJ4BHk2eEzo3a+rfoVR9qJL86V8UfKekegNb/Kgpaulzp8wpzIaltC0/5Ri+WJCwKGRHBqgAT17zt2gfZ6ppo7J6z4BDL9XPMJngEwc8b/oHBmCjcppQQ1gIRW6cbjDzcfwYuFoTZyjEQMHsux/KdGuUE2rmU7Hjn2KZwFVmo/UOdejU1yaaMlN66TKZmn53asJrLd8HAsIVe24QmHiMfgV8oh15i+HrPx11/T4cJPofTJKbrNKep/XHEG48YnWPII+mETbjdDiOyhcXnkgffr6PGTutE81hie/lcwMDOLQHII5wz9oF06v9CqZEQoRVORfFDwKYfymwzGdybNb6m0+rrC3H6I6U6F5B3Crp/PMTnhBV5njBlwv8dLEQGWMxuGws86gtjtYeDn9JThnvB2DMaIS0U57PZ9tyjxupD/QKHhIN5c+joRcJHg4RW+XIRbE1ND/DWB9AVA8c2MCNcJxeMD8zsEKPzg9YveFVY7PRMYbL/bjt3jP266z/UZRNPXJs1/uxd12G8stAbivkhjyCBsU=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f194c6f-10a8-4a0f-10b3-08d7eced2372
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 09:59:14.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/iHnhN6rfjPAiU4XYNXWuSRwg175f0Z9QaDt7cH2VCLUI1FHSgc0RoNwes5Ll6UC6YzdmhBjqZdKCo0o4ACIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiFive Unleashed A00 board has is25wp256d snor chip. It is observed
that it gets configured with Serial Input Page program by the end
of spi_nor_scan. Using the post bfpt fixup hook we prioritize the
page program settings to use quad input page program (opcode:0x34)
over serial input page program (opcode: 0x12).

The patchset is tested on Linux 5.7-rc3.

Sagar Shrikant Kadam (2):
  riscv: defconfig: enable spi nor on Hifive Unleashed A00 board.
  spi: nor: update page program settings for is25wp256 using post bfpt
    fixup

 arch/riscv/configs/defconfig |  2 ++
 drivers/mtd/spi-nor/issi.c   | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.7.4

