Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532D3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FFE20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YjE1Eqv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgETCMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:12:45 -0400
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:61919
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgETCMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:12:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+KxzhBK9kSFqRzc+syu+R5slMxxnmv9fLmUUQ6qzIrzZ+8pk4RW+jHZhwhnL8P7+Gn7WDVKRVSlBZr/pp5OvXDMDj+f44nj2m9EI+ixPspf/rcVrSFJP9p5Y5ixF8qHiuGvZL4D5dGd6wDla2GeUU8aQRN7D1TxubbUammMMmc7lT5I3TSlUPkSF9dPCO+DGcJAinZdZyyJBEEgvf1zm70RUleieGfNaVnIinGjKQJEzAWTMfqEhvoTs+YiTkwj7TnYRnfZB83C9cE+XMR1wmK9DNIceQ/lhcM2+hp+cRiHp8RjhHCs0mJ8QFRqhQaPgGEgR8BYc1M6Le0rxFJqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RnblXTQDwrw8LX5NWOSDTxGQELjPog/KQM1EDqmLzQ=;
 b=WoZ2wjBcofuMhTeD2lttzUBDFB0+i26a6qAMbfCn3Qg9GkG/XW3JeA/OGx2+r7EyJJ313866FkC5H2hQdXHYwvzrh4DphtjrDV2V2u1H7v5RV3C2xY4i2SM22bzP7dnK8FQ3ebdngmm9/ZgqwcjS25IaUs4+LVmN8+JTha7H4szoIQDb2HCRv7vfZOyFhB0HfpuNRZp9DLIo7wLie2RPQLg54hOhwS3ePJBlu1nh19ytDJVSqmAVcUsTHXqTIlmWBN26EBVgvpspsEBdX9zq1xmv/lfY6jXrQJGz12YPcL/jmX8ytuCIa/EjzBUgxYynjlzWPvg0yIdousxm4fwMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RnblXTQDwrw8LX5NWOSDTxGQELjPog/KQM1EDqmLzQ=;
 b=YjE1Eqv0ZR6yyaA1DvZr9CqmS0NTxu/65MDohTaytp2VxzzB5ali/tEs6PeZgiaF6AZsOKbzLmoDFeRGS5CYqRs8LTQEf+aA0km4zW2dX8gbvfHhZohkyZmTTi9hAiom/Wwcn8lEQOaqmnsZ/EFh5JNt2CyxptnVtpFjICjHsD8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2741.eurprd04.prod.outlook.com (2603:10a6:4:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 02:12:41 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 02:12:40 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/4] arm64: dts: imx8m: dtb aliases update
Date:   Wed, 20 May 2020 10:02:42 +0800
Message-Id: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0099.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::25) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0099.apcprd01.prod.exchangelabs.com (2603:1096:3:15::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 02:12:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31591d5e-9bcc-403c-505f-08d7fc63460c
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2741C54F5CC80208463F57E788B60@DB6PR0402MB2741.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZvIT+cNPamcFxqNAELrAYJVVSZynZbro46VYoG/n3YwHr4PhvoWYkRrEHBzqlr+IIoQfswV4rbfywwUIP9m/MNCuU20XKZ/CgFyndC6FwOwiQyeJst/Mnu7/ALF6xqApnSBI/f+2EGdmLCtI97vMyhP2hEI2csnhdsPM+OL51NVzRjJmKd3zLAyfbFioCLmznO3J1zlSZvyYmN/u6kVRvKMtdrPoi2akquTZSSAIkUX3qb+KSVAf+e1XcvYV/t27NUbqshAtttwMOVaL7JcZqlO9CO85z3oT/1Ud8myQoTH4DBEJEyzgO/ZUQ9cvdsVkwwFf7B5YQtZbZzQnwOVtqI0EETmfKXrZLnMLiCkxeElcaBhwTQTKqLK458ecu/kORnasBYGn4KDY91x6suaXHb04mtkNZkvHcHYDiMZlOjp4M824WLECS2dVnSAiUXzu18v4mruOpW9nq3jXFyD9F08W8fuOH49UYyPVpkB5HVB2rRZ6RO8j0Nunu92PzobjgQ0iv3X7C1e/ivKdxFPCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(36756003)(8676002)(6512007)(86362001)(6666004)(52116002)(9686003)(66946007)(66556008)(66476007)(8936002)(478600001)(316002)(5660300002)(4744005)(15650500001)(26005)(6486002)(69590400007)(6506007)(4326008)(2616005)(956004)(2906002)(186003)(16526019)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tCyhM1K8IvEyQO6y8iZ+emTcKC94L27RbIQfz6fmG/n7F+shXQ+//V/MwjqzqWB7WxnvCiIGIkLnkdahN42afO4OSwcLf9/ULov2yJpyR95hH8xBsvGIAJDRDBM11lBaIYWx6QiXZP20i0or59bn7PzmByQcIdfN+FvvrGnLF7wuqCtQEZCvgxXkO+rY/8texp7fCtci3uN4YEUEKJ1V+iZmpaAHKdnVZ6s6tAPSjLal7emHTQtq0V4KrBYd9Dh4Czswdf7tU7kewGnwpRTA1zY+3VdHIkUyy/vVMC7dVTdzC+aJ5qHfRwPgkaWupb7s/pQnY6XevHi7sxVnh9RYVjRUQLHNB6TxYFjVLuqsFuCwjRyjcYnxOcGRQ9a7nG4x8R1uNroDjXSJ4TAePY1S6dRFGUk8f3iZgfcFlQakP6ZeV7s/Zosh5EDifjXnLSG/67rsD8eV/hK7qDEsHEZMDK6X9xEOhq87meCZp9wbx5Bhwl8tIgZ5RBwkpdFmiy70
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31591d5e-9bcc-403c-505f-08d7fc63460c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 02:12:40.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7/1vRP+eQabKj1pJ/9ZBqoIuhaNxG6MZbc11Vrq8xVzO45nmUlJe8SsYbrzMIk2x8qs3AT3ERkX8p6QTmNJKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Minor patchset to update device tree aliases

Peng Fan (4):
  arm64: dts: imx8mq: Add mmc aliases
  arm64: dts: imx8mq: Add ethernet alias
  arm64: dts: imx8mm: sort the aliases
  arm64: dts: imx8mp: add i2c aliases

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/freescale/imx8mp.dtsi |  6 ++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi |  3 +++
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.16.4

