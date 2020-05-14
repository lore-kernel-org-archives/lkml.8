Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6157AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245C42065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ke2x+OxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgENLva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:51:30 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:6114
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbgENLv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:51:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwdDURWcfMtJR/S41gP4v/Q4Dti3fTtMXWKSCk9uOoZX9OZoxOr00gFupJV2Ms8X0gs/2PambpppHsK6S9SukpBjrao5+TTeVGuN6HC464gpqvdxu+b0LJwevbv/wwduxGi35HQTJ8ywRe2KhCzd7mFgMAylfjmPXa4/qIlONmlJW0IMUn6T7fxhguGxmCYZoN0rxHA9bAkDZOXwz/z9ZuXICaGZfSwJHUPh47hClqCnV4UBJ2BWpjtCw9dIKHuHfyWe/r7GP7A/D0Q2ZXWolXHCMY1aOUWkA1Co7ht8ZmvL4bZVQo4uNjJG2MwwVrcRqfCI2On9WVWRxY6GPqLolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogKgRo1XCrzxS2vzAySQlYxO6v6ZmdLNFqo68ab5OJQ=;
 b=FAetFtp9mdXeqArmniDfbnyJsirQwC8UWKBXwl2/mN7piNsd4hwSxAp79x0ashQWorE5fsMgas8Nw1arDr/ER38v//YM8V0Tdgb7TvdapyYh/6sThDt/AKEahHM1vvMRdNdDcpQVm31u7BuC6q/wadjZ2zqAhqumKJZTU7DRmFF5TJgdIAHnhyF5L0wzjWjqudVJsGZip7a0/Q2jEaPW9e+IgjPSTK3eYUnmNsUGZSa6hKEbta04V4CPlsTLLIcmThaDeYHr5sYmcMfWYYa5N+uwQKjb0NIrhK6XxaGnl1DxckOhN6J3QMKid0WAzSoZZYJNtZ70zw6pmG0y8l4CkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogKgRo1XCrzxS2vzAySQlYxO6v6ZmdLNFqo68ab5OJQ=;
 b=Ke2x+OxHnYthSk5rGwdkTbsA4QJstj+lkl6CahnYvmalC3FmfQRPEAYl0BQf6F6OxW+NIkQ2YuIe2zRFy359D5RKo9dB+gAKH/H0Ha0hAZmn8ix6CIiM2WDNLbp2JaHpdXtdGu3qNuSbN292HNjv+r/Oqz0N76NoON5abuy4Ol0=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=sifive.com;
Received: from BYAPR13MB2614.namprd13.prod.outlook.com (2603:10b6:a03:b4::12)
 by BYAPR13MB2469.namprd13.prod.outlook.com (2603:10b6:a02:ca::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14; Thu, 14 May
 2020 11:51:25 +0000
Received: from BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6]) by BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6%7]) with mapi id 15.20.3000.013; Thu, 14 May 2020
 11:51:24 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, anup.patel@wdc.com,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v1 0/2] update is25wp256d page write capabilities  
Date:   Thu, 14 May 2020 04:50:49 -0700
Message-Id: <1589457051-5410-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To BYAPR13MB2614.namprd13.prod.outlook.com
 (2603:10b6:a03:b4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BYAPR08CA0053.namprd08.prod.outlook.com (2603:10b6:a03:117::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 11:51:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0bdc88b-2212-414f-b6fa-08d7f7fd20c1
X-MS-TrafficTypeDiagnostic: BYAPR13MB2469:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR13MB246965214D5440AE398507A399BC0@BYAPR13MB2469.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gaW9zEuA3g246S9Q7WEk1YGGMuFAL3ETeMxfuYLhds9VMjb9K9ztO2S3LNbuN8yoJtFZwm5rSQlk5bPHX0Wkx0vxb9NOgfHHnml6JzlDfMWN3qqlc6fynwGaZbqUl0jAHj7enjpdJtw1tqhNMzb3SVyV+O/kqKn5TZ3GJ71GQQhL1cqrSN+Bv30MSOn1Jvf9Ibr3YR0JDMRz8xjcQNQIi7OjvREXhTyIy2NIF11cRIUDeDSzojDtfMhh6qxQpThmMEHYV2GK4o3+YxNQZMNvEdqZC//s7yy5cXiUvWBKxGDp8lMuFxrYoteoOLsQzeYxMKQBpe1jLQ4djPq82vvwhgnQEl2zS/zK4j7iI2AwOS43eK5jUQvVTd5Al6jo0TLA5pxlUV0OsbmS8zsGLKSZLL5t4MbEWB33lnm40HB9EB/Nc2Uv9pJeHQvjBXEVQhx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2614.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(39850400004)(376002)(346002)(136003)(8936002)(186003)(4326008)(16526019)(4744005)(2906002)(5660300002)(15650500001)(107886003)(26005)(66946007)(8676002)(7416002)(6666004)(478600001)(2616005)(956004)(66476007)(52116002)(7696005)(86362001)(36756003)(66556008)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: A5I/wTLpOJSWcoT7l5VSGJ/SKIuAr77R3c7ZAIMRbCkQzd6Ow+2Q5hzOU7nbHhWz1FkAqos/uRpD8I/kAXflApPuQ+vhTEFSuBe1kfqPbDhTODt66LMgr3PpULjoDIVNMEoudHKq02cnhr0ZBfaMbMBY3e+gUY1EBxtRF0DtVtn4ADjm3OkHMOemm1QOBwHjwcVTxSIEcXrneW/YvlQQBzRbtvNcQRkg3vOwkupUkItmRCjMC3tlTI1+4XRExFps0DjuLUVeYRr/7zDFDApZFR/QgexPBZzM+2cCDiJfJM96Y5iGqJJA+8Sq+rdvsHBS/wMHEySSR8qAqRtnfmx6yEYsPOh0EiOLCPl1L3idlPS+8xXA+COGE17j/zyVmIMo1hlWRe5M+RbLOBuZkLlyr3b2lsXVOxdJF0ILAtK3oNBwn3TCxhefAmfJhnyultsf6H/c8XNAiPLfAEyvLlQFy/pBab1PmuNhtKOTmCBwADY=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bdc88b-2212-414f-b6fa-08d7f7fd20c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 11:51:24.7535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smQeG0auJXxFL5wmZuf7b52Fq+xaa5Ar1tf6UGMykWy8JIHxIbIoSaSwJn1M2n1o4ctTGeDARbe1wQ5l2D3Q0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiFive Unleashed A00 board has is25wp256d snor chip. It is observed
that it gets configured with Serial Input Page program by the end
of spi_nor_scan. Using the post bfpt fixup hook we prioritize the
page program settings to use quad input page program (opcode:0x34)
over serial input page program (opcode: 0x12).

The patchset is tested on Linux 5.7.0-rc5.

Changelog:
===============================
V1:
-Moved SPI_SIFIVE from defconfig to Kconfig.socs for SOC_SIFIVE.
 Retained it's configurability using "imply" instead of "select"

V0: Base version patch (Tested on 5.7.0-rc3).



Sagar Shrikant Kadam (2):
  riscv: defconfig: enable spi nor on Hifive Unleashed A00 board.
  spi: nor: update page program settings for is25wp256 using post bfpt
    fixup

 arch/riscv/Kconfig.socs      |  1 +
 arch/riscv/configs/defconfig |  3 ++-
 drivers/mtd/spi-nor/issi.c   | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.7.4

