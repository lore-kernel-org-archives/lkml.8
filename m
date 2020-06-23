Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FD520772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sENlETPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgFWHBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:01:32 -0400
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:62429
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731053AbgFWHB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:01:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J21eKB6+vy0uNKh7zMQUQIIldXK6SPTlfMO4gJZCMBzFEbZMEm4l4bVnTF0v+xI24set+qAGcYoYLJ/Ll6ih4MBnXpgD/4qbR2GkmTVUyILujx8YXaA28ZQIw58OsSxcgM66svlAPHpWvgOZdOpZOS3TGPq7kazs8aNouIyCku/OtJaZsSjBZPTINU1g5ipIaSxgc6U8AAZclauAKphJjem1CwMm1z3f74heUDgmGssCrCxujh2wbwURa3Ogc+P2uoM6HDfj5q3fDGHpUv/yL+b9H0rNJyaslrVn7q2Qi7Gmh6EWVsEn1YJfFmxBwmBxtGWxLNCbXVSuDX4+A+Mumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh1UNVv5adGIvVtoENxI+LZCwHlb6Kz4CV0ZOReLSoU=;
 b=KC05tC4thMy7HcW1W9P3qTiSiXEPGBAOGNOzoinU63tKOPp7CKubD0SXu/IdPa2IoUiotCuT6tjcLXilV8oZVAPnNpP12EsnUuOITMxuP1SC4JKNXRoTt/UFaBW53NPpjIYNwHAHSVXUfzAM84RByewgFkbE01BzeYHHo4G01ymVByO1YQS4uVWxk779uOaCe1+8nj0K7CCGK/3Pq40jwzQae9nOfZzagp9vr2hoIfQPIuZIP74f8JBEgcdUo07Gbblr/ul0+XmX1DfyelVrcLIMvFKjxn5PUWLfQeLYWQAtzgXPfXPqJizUyWdiCBn3k4AB8fXiONCcOxFeDUGfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh1UNVv5adGIvVtoENxI+LZCwHlb6Kz4CV0ZOReLSoU=;
 b=sENlETPDmqR++FRCNGB4aPGsUYr8+5NzbB30y/uUv3liiEAf9oRx+YZlopwvqV742UswFJPBLG6JvotK5/B/MVXZqRPjsIVdU/X7jCpk55NUFV7jAcJPT244XiAGHomOewW5hK0QmbP8e0usDkEoCe35tCVKDGgL6y5ylO4TYHM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2711.eurprd04.prod.outlook.com (2603:10a6:4:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 07:01:25 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 07:01:25 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/3] arm64: dts: imx8qxp: dtb aliases fix/update
Date:   Tue, 23 Jun 2020 14:49:51 +0800
Message-Id: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0101.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::27) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR01CA0101.apcprd01.prod.exchangelabs.com (2603:1096:3:15::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 07:01:20 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3addb53f-d524-4b72-aacc-08d817433df3
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27118023AAC89BD89B978A6A88940@DB6PR0402MB2711.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVb3jZWnDmhsWVoFUUwOU3w7JlUdFxK/DnjYacuNAuB56MkBWygjkmyjkDOvMYxyLqPvPyBhyAVrT5AZp6LY6bPLEJzF0AU0Q93699vS6P+aKtfAWcqg3TO6kATIdYaKqNQbh8z3EnNCYZ1BEHpTSlu05hibV5qOthH9gX2GzHd0ZriQ11YPL6KMMV1/oFCA5z/1J20XzXUcas4gKWqrMesVpOMCdz5AEAQZR/teIRzfxpEEgCvIT2NC2FW4uzFhx8av9vku5KFRtrJjKEfcs7Mt40RWjjhbGN3AuHEJCspPPKxiVDG3a99Ob/xxATse2OIP23R8vOIR5hl3rx27qsTOMUQq7tGEA+ow8HBLMeMgceKE/5vrlHhO1X8AtQv62Ih7Op59DF0v3C2T7SQxxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(26005)(4744005)(15650500001)(478600001)(6486002)(6666004)(5660300002)(2906002)(186003)(316002)(8936002)(16526019)(66476007)(66556008)(956004)(2616005)(4326008)(66946007)(8676002)(52116002)(86362001)(36756003)(83380400001)(6506007)(6512007)(69590400007)(9686003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mjZGrdOVpX6nbHffvi/quXl5uNspv1qj9ZET4abdF+c01Vm9uy9Anibi3lFmNDQV0lzAkhbjbs3FETuBqRSQgBWlHrzI8Hu8QtkZmgKOYPUMhGUnLzPsrtnACt+lMMOAo12+2eG5cCKCx4KnhXz3gtbDfY/rJKgXWGxn34z949il6xwNKKId1CY8b861NqL7aNy8Zs3gN7I03JfIODWJCpKjba+yMtflo/5762kUC72yrFkngS/fMTYSpX0eyRB7h1Yy0U07/1lkoPxhZSNxqgenE27ronW2gBU/2p8/crGUDdE/B0dP70D91CuaGodntpeeIrfaznj1Tn8NcukYBZX4YIbK8PcWRmbnQGIEsZhm+kzqIxT1rKMEjgDWWgnP284oLRmFP5g5ET5VyefljtStoFFxaPONcIxDy/mccUTjNgVfZ9kyiUDhy7nsszNihURvJdqoXKDdjfPxiNJU8wrxbVcPH6h5RFPapcIOobs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3addb53f-d524-4b72-aacc-08d817433df3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 07:01:24.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JVFAFimEsB5IGoNdgVMJBluCp8wNxKF7xAQW9EtV8PZg9iYGJGT+H0PvO7kdx26FLl9FjmMeeX73E/kqJeUxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Fix order in patch 2/3, no other changes

Minor patchset to fix and update alias for i.MX8QXP

Peng Fan (3):
  arm64: dts: imx8qxp: add alias for lsio MU
  arm64: dts: imx8qxp: add i2c aliases
  arm64: dts: imx8qxp: Add ethernet alias

 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.16.4

