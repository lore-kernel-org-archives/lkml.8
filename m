Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526BDC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F7B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="S9WatSVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgD1LRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:17:04 -0400
Received: from mail-eopbgr750075.outbound.protection.outlook.com ([40.107.75.75]:52878
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgD1LRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:17:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iome/dToORdab2Es+kkzvDmZg2m+SV6j+th7IoZfxN5pj4gKhwqXKNfemG1VWPsfQgENq0wFR5+wvErTXWrKkd+UgnQbFd5LJtghXdihX6t4h9iCnm9s+XGMhH9YMpeiL4aNjmcT/vqSto2gliarEEkIMHil3e7tHYXd92fAFA32h66jsB333cmi3FIKuj7kxL5Bfn1QWY2HaBcsU5rlCn92eRBizxNecg8K9sZn7+orRVLWR254luhSHOOXzXP/B/IijuMHy/XzV+oJyFtdQ7r1YwSyAyajSTcbg19dPxj/qCfiybG/fMVPn+Bwuj1FdWvMn1dqiECGSXzFBOC2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aul5l5DQgIR5rCpNQ49LSf6UP/DM43dIay019PQDyjs=;
 b=jiZYG1S1JPxYcenXviT0TbVq40knWvuJbq30zHyKWFM6TA5PjK/35t9LmvY1e6ymMF3qqNPvu6NYrl/2mOHFg0l6wb3+yO5shaf0KlFLVgF6xKCtsrbCydsXre4aHOYvHwjYpgZm/2ljiIaSVCXO2vzcDkq+gtpzb2UM/DisBRAW/WHbAvalC2Lam5UAN34imoeai3IN/ms5wE2moi/Mqe6wkxnhB0T6WG+ciA/03c6cnURLxiiKX0UxKsFDuQbksZSZdBj82yVDx04scRXnVGCboNDxIpsVdYdjqPbOd3CUXzAfSKG7nn0viWOBKbWHxybgJ8LN/VA3Pf1OKr4IiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aul5l5DQgIR5rCpNQ49LSf6UP/DM43dIay019PQDyjs=;
 b=S9WatSVJHzk7XYepjupbtnpRCBc65nBSD6cfL4jkohB0Z0sqqj1zK1+ynsfzSuOOG8wQ3WaKeSTil5plioGPXRNA5ur0f0KzY/VZNMcLpCH+NJFPjZJusK0Xe2f3FMYGi6QlxvahLwmlvYGIVc/2+2tbKW4xmmhvDDjBU2z5I3c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BN8PR13MB2611.namprd13.prod.outlook.com (2603:10b6:408:81::17)
 by BN8PR13MB2737.namprd13.prod.outlook.com (2603:10b6:408:88::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.12; Tue, 28 Apr
 2020 11:17:00 +0000
Received: from BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929]) by BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929%6]) with mapi id 15.20.2958.014; Tue, 28 Apr 2020
 11:17:00 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, atish.patra@wdc.com,
        devicetree@vger.kernel.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [RFC PATCH 0/4] fix macb phy probe failure if phy-reset is not handled
Date:   Tue, 28 Apr 2020 04:16:44 -0700
Message-Id: <1588072608-7747-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To BN8PR13MB2611.namprd13.prod.outlook.com
 (2603:10b6:408:81::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BY5PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:180::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.9 via Frontend Transport; Tue, 28 Apr 2020 11:16:58 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6855ea8d-7fa2-496f-68ac-08d7eb65ab63
X-MS-TrafficTypeDiagnostic: BN8PR13MB2737:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR13MB273792A5FF3DC40CA7243DD899AC0@BN8PR13MB2737.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR13MB2611.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(39850400004)(366004)(136003)(186003)(2616005)(52116002)(16526019)(7696005)(2906002)(86362001)(36756003)(26005)(107886003)(4326008)(5660300002)(66946007)(81156014)(956004)(66476007)(6666004)(66556008)(478600001)(966005)(316002)(8676002)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDWkWWT8lQbUYQGKEHL+yd7CxLXqFNN4AskxMMb4zCvbdE34ldrpt7TGNy4h7ztuitcYWTIE6AKlnYytxOn8oOLPe8YbqDpFekNQUWqKC/xkr0GFeX9QkcIz+I1Sz5S2tvRQd4LeRHQELK1Dsit4+XdQTRDhVLw7gvyK9LB+FW9FYCRNvMjF/nLGIwyNBZDZW4m/0678FcKgNGioi7m7zKcI38nxtfaUHUy9TJvCRxDN+azoP4jURv1OAsQCEyJKd1zh8ehnNitebuJpY3D7NzH7jZk0auMEkZy//JcCdAM7EDxGWu5cp/fy8QZtVeIsAhP7h4ATwZpDPwNiZnhYjeVFyBgUQQCxiKFcsSLX1pxYoAUkqPl6Rk/Z99/Utu5V7SJvjtrBnLCEJtWgOQ4Icqwq8GyQ4C4HL6taJCF+LvKOf9gQj0JzuJ7D1Frr5JOs1408NoYOqKHBUZLzdrvq39dBfNOLg9Of/NLuMKMhIkmS30rBfiUZnefOLc9YTOQpeClKW4amZ/F8xAsSVCk7aA==
X-MS-Exchange-AntiSpam-MessageData: /7bftCvEwBsey1mtFYryQw8dzCLTLF0XG1mCkqIDIb/kl42yNapPl1mkI0W84iDRMf6/WOHRScznP/Yn+LdzNP3XxQ/Xpcd2wMiYy4YT4g3480KSW18qiUAf3sf1Ed+CDZdz7E+YCdtp+hFet2FXfbXhTsKfGh4A8On0mURZnTOfOywEyXutq7+fJgmV+pVRWKLXuxjacB/0cvvhaBvPKxqgFNMsjmysOoUVuRYrrD12wo/AQ0nC54VSop1gJZmfCwhAPWwrQTtnvlgTBVcZ4N71ic1dWvXCjSVpRFB871bQ+nCSyyW9hIsYd/CpwPx2dIu+oZ15FIpTWZLSd055Jy69KzMBgDk6iMCQxHuVCVSANAb2YGBBa6UD3RPVDbvPB4H0TRDasPA1n3uxr0MRy8XwrMgLncdKEKGlDbnULl+DDH6n6gHb/sWhLCd5+aBQrtxBzjM7cqdOfxS9xDXyV9UF0mnY5ognbvrGYd2dvO/u4chXmPG/iX+7uI6+5HHlGJn4MI9MZzQnq2saMDmbEStY7owDNVY6tsg29eRwD2MgBsDVf7HvBmugI+o82/1oAAIBlXlYOyrXFe3/1TAMrIqHpLOw3KdWno2dNv+lbPqaAWQcn2nxTSjrghWyZKYEPSkT+rLr8Yp/WAsorTIr9gKMbaCJbKKwjVQX1mwjgy6lV9YUBqqji+E8RtxEQLFNNrlNcDnL4TmmcYBScRHsrdVzjfpElg4ta8ZLgQl4KMTQ/G3smQnO3ZuHo9ibgVtndo5l8aARXQQ2YuVv8hBy5WtJIDwhmh6CsglVL86W28c=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6855ea8d-7fa2-496f-68ac-08d7eb65ab63
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 11:16:59.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bp084uZbER0NTI1B6GBNktCCKAI9LdlhxjgX16MAE25Lo1BA6/CKd+s5IAclv/NBdF4ZgcNxYr0JgiziBx7UYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiFive Unleashed is having VSC8541-01 ethernet phy device and requires a
specific reset sequence of 0-1-0-1 in order to use it in unmanaged mode.
This series addresses a corner case where phy reset is not handled by boot
stages prior to linux.
Somewhat similar unreliable phy probe failure was reported and discussed
here [1].
The macb driver fails to detect the ethernet phy device if the bootloader
doesn't provide a proper reset sequence to the phy device or the phy itself
is in some invalid state. Currently, the FSBL is resetting the phy device,
and so there is no issue observed in the linux network setup.

The series is based on linux-5.7-rc2.
Patch 1: Add the OUI to the phy dt node to fix issue of missing mdio device
Patch 2 and 3:
	Resetting phy needs GPIO support so add to dt and defconfig.
Patch 4: Add dt binding for OUI introduced in patch 1.

[1] https://lkml.org/lkml/2018/11/29/154

To reproduce the issue: 
1. Comment out VSC8541 reset sequence in fsbl/main.c
   from within the freedom-u540-c000-bootloader.
2. Build and add fsbl.bin to micro sdcard.

Boot the board and bootlog will show network setup failure messages as:

[  1.069474] libphy: MACB_mii_bus: probed
[  1.073092] mdio_bus 10090000.ethernet-ffffffff: MDIO device at address 0
	       is missing 
.....
[  1.979252] macb 10090000.ethernet eth0: Could not attach PHY (-19)

3. Now apply the series build, and boot kernel.
4. MACB and VSC8541 driver get successfully probed and the network is set
   without any failure.


So irrespective of whether the prior stages handle the phy reset sequence,
the probing is successful in both the cases of cold boot and warm boot.

Sagar Shrikant Kadam (4):
  dts: phy: fix missing mdio device and probe failure of vsc8541-01
    device
  dts: phy: add GPIO number and active state used for phy reset
  riscv: defconfig: enable gpio support for HiFive Unleashed
  dt-bindings: net: phy: extend dt binding for VSC8541 ethernet-phy

 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 3 +++
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts        | 2 ++
 arch/riscv/configs/defconfig                               | 2 ++
 3 files changed, 7 insertions(+)

-- 
2.7.4

