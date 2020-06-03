Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1424BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF912074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mL6sYzK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgFCDm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:42:57 -0400
Received: from mail-eopbgr50079.outbound.protection.outlook.com ([40.107.5.79]:42883
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgFCDm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sij2O4qOCXpze/TInIvYP9ys9PwmUGqZx/CQFb/ZK6Rv8mADq8Q4splecyZvcjcBT+UBS/ExtB41lgej1LonEHBfhk57ufGGMsCvsjskLe0j6xW+XiUfLtqXLlKyaMFDLYNayKX22fsiYq9yKKYa1CqdT9o/OZjQQL7ZrnhoF06MU6U03TTDbXCE1FZsnFUPs0dNSClsfNsB4/YwzwqFIio5KU8oNtKI0SI1YOPnK6qGnU47fYMv0+9JZ0Ip8W7JdckYy/WOuqMAhSMO2Vvzs0qpT+gwNMPloaEvrI2k6+jdJKKNs/PqC+q+0MX+68xymEVDxXoXNuhPAm5pLwVQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxt6snazwSZaOkz+/3Uy5F1S9PEdTwIuBbF6fdmRRJM=;
 b=Hpk7aEwERF/VHkbJbJ0StVQV+t4Jaz0CW3WElW6m8Xhjbb4vi585kpr4IBWcCXkVrHngPbWA8Ggs2OnEk32KKP6+r8Wdu0yifcKmySHK7DdEOHAF9gdNC0stqW+aqgfy2iaNGtpgNSgfCTpnvukWbR2by7nMt5pzQ0f4mv2g4/cbwQ8519ejX0fj03NHht2aqKSldwZw12KidfaHP+i8kax7bV5VkcPehw1p/6PaWVP01rC3gRGQx//R0096KcuDWrH8TFBC9PRHmunXanQfta3ls+wa1XGsfVhogDbkjnHhyQpq4BhaAdEd0KLtS6/sp4/bwYD7SfmJ6stnW5p5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxt6snazwSZaOkz+/3Uy5F1S9PEdTwIuBbF6fdmRRJM=;
 b=mL6sYzK1GzxLaLv/WMrYnu2vwCzvOXHj2HIJmXbCQjHnS073XJNms81w3P7pyUawX+TeF+9VAzpf9ouGbRBUa0LXlGfdFivg+xvHupBHnwd5VFlEEZJAjPsNyZpAaYAKjzC8PDQVfCXRbebfNGAvFNlaW3Ib9HNr2espxLv25ks=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2854.eurprd04.prod.outlook.com (2603:10a6:4:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 03:42:53 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 03:42:53 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/3] firmware: imx: fix/update cm4 and add resource check 
Date:   Wed,  3 Jun 2020 11:32:20 +0800
Message-Id: <1591155143-25972-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 03:42:49 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 399fcaad-5cc5-48d0-dd76-08d8077031e2
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB28544E81F591EDC40AAD1D0588880@DB6PR0402MB2854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqSpCCmACce3Xv9cnk38eJZCTeQ6Vx5EhSMliXQH/N/3tM5RqmmwkV6Gqi9MJG+AIoJQYMFeGcTjdo3NIsflQNn7sWnxMTihJp42uOaVmhKUrTqklThpkSGOB9QE64DQT+6AR7CKpXoRfNoosq5PBVMioCVDDt/eYIiC4UegAjEtZVSsYWAXU32ZgVwrqDZAAQ60MFUDFc5q6O3QSGU3e+Ap1bMKNGfdg6kpT/oHCrmEAb5g3dHJQ3rRmF7xEA9DOLS5GguUYXJWIOABjxh1KcBw04TNz8zbGhcVVfmCdszVgf/hquu+wpgYeQKednfFCzEHlzUEpgck96dAnstmlw1h2VVjwQ+kq6MECKh7urP/TXtFWDMQwgafN+LgS4xDLVdiAmvnpm//6VgcZPg0Y5zRuIy8nnEYQ2OdbB5L6SPQKoZo/QbnRpSKwJtUOh+fUfelhtU8F6oXhUOTZv58Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(966005)(6506007)(478600001)(186003)(6486002)(36756003)(5660300002)(26005)(66476007)(15650500001)(66946007)(66556008)(83380400001)(4744005)(4743002)(2616005)(52116002)(8936002)(16526019)(9686003)(316002)(2906002)(956004)(6512007)(69590400007)(4326008)(8676002)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ae3afJGUIoMeY+sOc8Ncj8pbDMSi7aiQYD+WPV33UqHad2ctTRy4KTYq8Zec1ou4Vcr2w2bhmK1bhmJRnzMYjF67vudc+10AtDnujRGDvJ5gfiVMXRvg+9i3NvLO94ME9bU7xLyoUSmGUZwT9s6l0sDVIrSo45ly8gc18Rs/D58gFfYaH0Lj2chFie+TjcwmOOCJ2DbkwAEhQZQpDoTeP7xWViqYiukhygl6rR+MV3OSVRe1BttKEQayg0u9PwSSqmS3wGMZd5zPmgkL8uVsOPtQoQZ4dzg2/WTEj4XclzTkPVnq4MAbj3pWLdaz1bwphb1m46EpiVkwgsBw7v3wszV3SBNRj20Lm+w7/TKQlEk5LFYTGBibVIVVhGdokcikGqXWU7Y06+bLki+SNjpeUmatvixdbmq5CKfVGI3do6g1ccLIIMJ2zJFlP2THKlm0GIMN/wS/4LmggtP/L1X1Wh4VuhQvSiU1YxRZjgrZdcs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399fcaad-5cc5-48d0-dd76-08d8077031e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 03:42:53.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYrU5JxqGY+K/rpyyzsHt7kx5nxFSnmg0JM7h+lpsJl2yIE2jeHEevpxs/YWEAguFRPO2LPpsrXMkYiMA9WFRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Add R-b tag
 Drop patch 3/4 from V1
 Add comments and update Copyright for patch 2/3
 keep code consistency in Patch 3/3

V1:
 https://patchwork.kernel.org/cover/11505045/

Fix cm40 power domain, update to add more cm4 resources
Add resource owner check, to not register if not owned by Linux.


Peng Fan (3):
  firmware: imx: scu-pd: fix cm40 power domain
  firmware: imx: add resource management api
  firmware: imx: scu-pd: add more cm4 resources

 drivers/firmware/imx/Makefile       |  2 +-
 drivers/firmware/imx/rm.c           | 45 ++++++++++++++++++++++++
 drivers/firmware/imx/scu-pd.c       | 14 ++++++--
 include/linux/firmware/imx/sci.h    |  1 +
 include/linux/firmware/imx/svc/rm.h | 69 +++++++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 drivers/firmware/imx/rm.c
 create mode 100644 include/linux/firmware/imx/svc/rm.h

-- 
2.16.4

