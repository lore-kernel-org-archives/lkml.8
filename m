Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4BCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757F52075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="N44EygEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgE0URg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:17:36 -0400
Received: from mail-am6eur05on2120.outbound.protection.outlook.com ([40.107.22.120]:52449
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbgE0URg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:17:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwveDMlgkk2b6ktBKhmHLjRWGE0zbBGYUJc2i/Pye3wMP3dIt+efUphx2GAdeZWj2Cq1yI++6zyyXQ8+2pwb+2N04BoHp2PPOliLvu+FIwz8F6CT071WqKKfbgYs0xHVa4n+6+ul+JiOteXb09+S9r0avMmZY42XPqkiS4VkHE10KUM3tqciSXhbdgUs3hRmbcplY4hcjJoIl8afWIndnG6tvvpLWcdse5dtVZ3hDf3gUQ/ba3iMb6peHwinF9Dv7Yxso1Ph3k/SxLeW/UrleZxXhnoxJH/rSqMoqYBammfa4tIZ7DInNUq80+yHIRFPnm9kiMWKtneuHLUVnN0/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF6Hid4A2OUle2hh8nzxKUId47CAQ52XsqnMaQOFNgk=;
 b=Pv9jhfuAKHWoLdUujeqGPtcq8yBvuvFTZJpClijDDMapWw+gIXrGlCqZNl4w0cNAkJolj2/MDl0Ex982XsUOlcpUef05ieJpQ4aoKy5XC9+tQzbSvPXuJfaa6Krsy2D0cJplB96jS1Y9ISLkVucIMGuBQe1vsC2hkHiYNjrWtyuaO8CY3IiNeR4SpZIlBxKupceREriczAGcZ86pg2fVU4OaT4gHJi7leVcj5RToWlK5eonESb6k2fGxWUqmkCijhsCM6XrqvvT1WhpL33PBu9gJ/fl+jtWltt/QD/cnVpqPiTGRJffgLa77vZkmtz7oy7h0dQuBvQamb61+YYi3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF6Hid4A2OUle2hh8nzxKUId47CAQ52XsqnMaQOFNgk=;
 b=N44EygErtKtC9d/QnHA0QWXH8d2M+iZH+N2xPIY/fe/CK2mnbaMH5GUbb0UiSVEq/nHPJs4mwiIjvCZ5FSiFDls93/X7sMK8QtpvNeWFllpxtl5SneW/DuL4zmNnoNQlfOcsLoXXqbja1aS6BPiHBejrVpIVpJWofCEDdedWN1w=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10)
 by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Wed, 27 May
 2020 20:17:32 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f%7]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:17:32 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Taras Chornyi <taras.chornyi@plvision.eu>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 0/2] nvmem: add ONIE NVMEM cells provider
Date:   Wed, 27 May 2020 23:17:13 +0300
Message-Id: <20200527201715.3660-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0106.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::47) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P192CA0106.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:17:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e404f4-43af-49c7-83b2-08d8027afc81
X-MS-TrafficTypeDiagnostic: VI1P190MB0399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB03991C423FA4E5A97D138AF195B10@VI1P190MB0399.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpeOQISLvUhAFZH7r/H2B4Wv3kvekjOSyuLWGsEA3Oe0/u8USMl6DVmb6WpKnwH/1JmllvRnN+dDObfb7ardG2z1J3db8VD04a7eXKZqh5gWhV+Ri/r+/GnCToZuiIboiXVf4f+zCOItQ6GcweHlLJr1DGaVxVAtabMqIxkPWE0FDbkM5rQ7T7E5O13zCnIQ5OYLg+TgwtjWAuDnch05F31TM8azkemC14zZgzIRffedvh2ltVekihp79Oc5xQJ36Mvl7JZbqdlOiWHYI89lOpAZ/9eaO6DvQyiObSNvg3xDY6OK3oyVTKK5CC8GqCmWCXhqewQm348xi+C+bI1ZKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(39830400003)(136003)(396003)(6486002)(6506007)(6666004)(36756003)(66946007)(66556008)(66476007)(4326008)(83380400001)(5660300002)(44832011)(16526019)(8936002)(956004)(186003)(52116002)(2616005)(8676002)(107886003)(316002)(26005)(86362001)(4744005)(2906002)(1076003)(508600001)(6512007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8zQIuInVt8sRN0ti8LF7VIryPfvhL72VBZtim7T0jZrXtQQU+2Fr88Rmm4QjXZG279fkachZwJfq7hXv3ElIjF+kDnWVu97yOcfFFnHmOopewILrD8cqlY5arNBaYMRPu42BWObB6ZtXYEwClMaT9q0vLXdegNZRsxpXko0XENtrhnDFlCCI9C4Rs0Q/v4E25yFIOu/WCf7Hh9BpUGcvrrmw3BF0Ud2kQsdm5/Ac2H6Ovcb8sKrdk2PyrSPlONDQ24GRHAVRhrneT28PbPYZzlOzJ3plUpmf25qroQoYiozBft7yjuvJGPrGjm3d5BFROOmSDE5Q0H2XMCLAxDS5cXRoMXn/v5A6WrXLoUyq8S6g1u2AsFGnjqS1YURZ2q5htsOHRvr3gOXrlYJ7Z05Ox/gwghZLSXlCe/5azjU74BCiD8pK80mKDRMHoRJCwt9afgCBOAwZ/5PanUJ4wy9KeJLClyuwozLSFZZgOHbl3C0=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e404f4-43af-49c7-83b2-08d8027afc81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:17:32.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqei1NOotDJXQ0RwwEwzFTxpL4ZpRstBeQQJnrDIQErGUuGVqPcrwoEPsG17RtQkWs7Btox5s8s8Ahsp5D++o50+iIP57afZIBGCg6UBRZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds cells provider for the ONIE TLV attributes which are
stored on NVMEM device. It adds possibility to read the mac address (and
other info) by other drivers.

Driver needs to register NVMEM cells table for already registered
NVMEM device, this requires additional change to the core logic because
current logic only allows to add additional cells only before nvmem
device registration.

Vadym Kochan (2):
  nvmem: core: allow to register cells for existing device
  nvmem: add ONIE NVMEM cells support

 drivers/nvmem/Kconfig      |   9 ++
 drivers/nvmem/Makefile     |   3 +
 drivers/nvmem/core.c       |  61 ++++---
 drivers/nvmem/onie-cells.c | 324 +++++++++++++++++++++++++++++++++++++
 4 files changed, 375 insertions(+), 22 deletions(-)
 create mode 100644 drivers/nvmem/onie-cells.c

-- 
2.17.1

