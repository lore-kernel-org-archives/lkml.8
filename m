Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF33C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFEC205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCROti convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:49:38 -0400
Received: from mail-oln040092253062.outbound.protection.outlook.com ([40.92.253.62]:6063
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbgCROti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:49:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmBUq69SK91vYDIg+ewwX420h7/YLCYukeaaOlpifnohIL292QUPYR9XnAvTu6HXKS9WVHnfXKLO7clx9DBXREaX64a8e+c/+VlsHm5NeBUB8tmmdw1ItoHA3n6YM06Y9XTwZH9EcDBanjYm9TajYb+8VpAT7tpl4R4gOBHXY6omhxy/dBU0fkAXj06SX0iAlB3T+a9eMx5b4pqHjDaQLCkiBEYGl4PNGEs9BBW3xA9hCX1bj6fE9I/pq7UAmeG6hStHy09N6gRKDBexEsC2ku6YRyeGADlyn+wdCSFu99u+eSoezq/875/if0D2ZkDQSoTHuN9fGQEkiWyOdNZjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB5S4PoRNEO/naviICIgEb9IeCCXJmG0UFBbei/hhZw=;
 b=MpYvLsBpup73Zd10ljeVSBQhsc7RWMswxHvqgBKdgejwZmlfCl+fFCis/wrTxbSI/8iMDr6pr36ixa0q+urINmMAZovYcQPAB789v8DPXAA9oogoEW/1HndV+Qdhd6rt8Typ1QiwUyynm83bbf2q7D4sYY0y3crjcrLYgaPHmgEqtBPzmjwfEQAMpOLFQ0uuufUprLIRZ945VRs1jmS3hYOcQag7GAQSkvpdQT9kGW/BaoCzUkOeydR8WR30dS3ZOh7qFlSokwpXWWamvKpi+9ESBAxKf6Ckks30UpthG/7cHnu1c2eeCfMD+Id2NCNxg8JifBHRdmyvo3UKMJMXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT115.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::34) by
 HK2APC01HT071.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::229)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 18 Mar
 2020 14:49:33 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT115.mail.protection.outlook.com (10.152.248.194) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Wed, 18 Mar 2020 14:49:33 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 14:49:32 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by SYBPR01CA0009.ausprd01.prod.outlook.com (2603:10c6:10::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Wed, 18 Mar 2020 14:49:30 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v5 0/1] nvmem: Add support for write-only instances, and
 clean-up
Thread-Topic: [PATCH v5 0/1] nvmem: Add support for write-only instances, and
 clean-up
Thread-Index: AQHV/TRvkGs3/FHPXUWMfTjZCgJYDw==
Date:   Wed, 18 Mar 2020 14:49:32 +0000
Message-ID: <PSXP216MB0438BB51FBB5964FAD7E180F80F70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0009.ausprd01.prod.outlook.com (2603:10c6:10::21)
 To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:05B4DD883CBE1ACDC5878A3563E8E646E1A5ADBF72365271EF3C52A918781FE2;UpperCasedChecksum:8C4E2E7A042FDC400FE9A1075186D78E27636D9B943F4FCBE02773186BD43537;SizeAsReceived:7732;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [4n4vUuMLjoSAV6k74+q+as5OvNMzxxpvn7Ml3Rs+MTVOk7pzgcsdy2TyGNA94ilh]
x-microsoft-original-message-id: <20200318144924.GA10037@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 2269c211-a77e-4f61-d6c0-08d7cb4b9195
x-ms-exchange-slblob-mailprops: =?us-ascii?Q?EvJfeA36uqIt+ku0zmot2SAHdMiltl7jQUbyMVtxFqThCmq/KqrlJfVIOoki?=
 =?us-ascii?Q?GGL44Z5j+un9+7rWCNEIWVMlXtsvkepHfgxkXavp5ZopJdhnx3U+2kaR5oEn?=
 =?us-ascii?Q?8ruUHNgUAeVknETH2otaf7OljgO22FHhhJCtuA9ajuoJiLO+OOwwIjcPGq9f?=
 =?us-ascii?Q?MtB8G3P8PVd8KV2FRwON2w4V4xHNBfQ21v01w/DltdjGkwfGp7iN1POiLdse?=
 =?us-ascii?Q?TKofqas8m0fAEnErDqUHqr8O8AZm7QdKEt75BSwnd2KBuXr3vzkFjodgkTMk?=
 =?us-ascii?Q?/8IJbN0HVvtfI5kSNHZNdc/Xk/YY/s+/CGOmHLuY6dtiO84YLDG4i+UXxbBH?=
 =?us-ascii?Q?X6IDwSqLVveAMaVP7R3uPnWb7I2gBRHEIRt2/zecOMm1tETLjbv1pCIfTPTm?=
 =?us-ascii?Q?pCj7grO7QZjue3su+xzKxI26JwFPKd5S/Pw4wcL9oojOG+NV+yviH8dliC97?=
 =?us-ascii?Q?z31GOatuXV7hlYpW1AWSQ+AossGXsaYDuNoc3i5OAiuwGMw+32WaKM6uODV8?=
 =?us-ascii?Q?k6hKhx9PUkhbHydCtQBUlh9xt2yaAD9mbfKLUy9neT/6KkoL2PEbvkBkasGU?=
 =?us-ascii?Q?hx0vx1M53PgStzoJ/+8UJPt9KdGnL8qsk4lFumC/KTHA/Kf++e6vOMKOArry?=
 =?us-ascii?Q?7+6Cpl7yvpLF3+QVXNbI2twPlwEreEQE8nCDOU5UZtE0ECdme0aWPmhlWtal?=
 =?us-ascii?Q?lqz8u3fxFfLrKnUyikCguc2kqIJH54voNwhGvvPIFIQM/r1/aIaslYCaZYGP?=
 =?us-ascii?Q?zQO283j8AhllxZ3TRs8f0MH1NI3SyQ2zijA1gp5SQFOSVx4GDuKCEH81SAhQ?=
 =?us-ascii?Q?BJNCxZGPIXFyr7xB0YKyUSRwxoRYqx0Mgv3601hknGlPntxpOxXviky06Dje?=
 =?us-ascii?Q?CY/1jgPr8U8rgHE4vNPq6Ea1XNouHEDIZzd6DD47zsdLBJQNa2eke3n9hpnp?=
 =?us-ascii?Q?Y3BpLuvEPsMjUOXB9DDbl1ffP16GghzAkBO5Y97X90NYdNKhV+U4Ni3OCn3E?=
 =?us-ascii?Q?g6RA8HclDhPaEXxe1FwY/0Z/jYzQ2GjY3mVvqeCyEexgwAESEmyQLwZSB08f?=
 =?us-ascii?Q?RotCrUDI?=
x-ms-traffictypediagnostic: HK2APC01HT071:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8On3JLaClxdV91OAmGv173LWLDHPQkaDgMi4TkvJY5qMoEhZcG1oVXj4JDKSrpKT3iiEKGNx4PypKR7y5ozBGDLJ/mZN1fNaVg98bN0Zd9NP99KT2GGd+U1nh5vccXWznzpCTRN7UDFYZce5uASaJa974ez/09yrBIs/mW+6DqCnJe5m0GRN41aLshUdNb1BiIl7Oquj6LZg1pi7khRFsry0gLZHj2ehtNCi5dtDZ2g=
x-ms-exchange-antispam-messagedata: r/JVAuXddVMlOxJmLDaeVKtsUcn77IadR4rLCMZ0g3NKaKtgCNPJTiWojW0ULUz/wlcM+gY3qCH/y4B2RMdKH63DKrlasXiKB4totMVKjbOAnPdhihQSIy095llTasKxxO3/KLwU3O+WckwfeK02kl1ptvWqbF03GRdXo1+Ps1BjRgnIFw1rcaMk2N4c9YXB9vFSSjJ5U8npajRMCXkB4A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <910E849CAC3F5B4FBA0E063565F6E7A8@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2269c211-a77e-4f61-d6c0-08d7cb4b9195
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 14:49:32.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Previous version: https://lkml.org/lkml/2020/3/16/1051

Changed since previous version:

- No longer leaking objects such as idr and gpio.

- Got rid of accidental line of diff removing blank line.

- Rebased on top of [0] as requested in [1] - no conflicts, anyway.

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/tree/drivers/nvmem/core.c?h=for-next

[1]
https://lkml.org/lkml/2020/3/18/171

Nicholas Johnson (1):
  nvmem: Add support for write-only instances

 drivers/nvmem/core.c        | 10 +++++--
 drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 10 deletions(-)

-- 
2.25.1

