Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D95BC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E1E2467B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="EicbclfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBFPYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:24:08 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:15398
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbgBFPYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPqFtkhpIGfC5P9fyPma03EteonMuqNrmP1tG7sOucoytF5PBmmWsgUSY49QChnrnNA2ajIw6uGGOp22igXStg/zTJHh83TpWnVZpoikPyxcs/dSMd8SZzBwCOFEEIVcwirLlPDro9iRvw3rtffUxTqwuz3SQ14tntGeKOelMMvlbfvO3lyq40O2MtfWdVT0mkGr4AmLMhVNECUfwgLfxrnLC08jnvuwbvo1z/pRHF4xcBWgsOg7ZYGgsOUySF937hgshbeJIRondw0jwWVlqoOxGeibP4gkCbb50kBMzsWDpCD7SAGMUfp0gMXH8Ckv2tYgTdNzN+R3vcJjRhkcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzzJX5wHn99Aaj+fNZlFofq9bdvra+Vzbf0T29LQPpM=;
 b=kunAFWF0ZNF9R+OUCxuP+I+trosqQnHmTxey6iJ0kM9VUKyD0xx/XeEnKp4vIljTAYKfttf83xsyU8wIDfr6vPnyVLbJCtJOxigC1Lym+U1e35Rw6lQTWnLFr4rn4M6R1BWyYsfBikTStmSB+oBh1lt6jE+9kVpM0uPq25KZtdZhlKAXjtSwA5V05cNGaoQEM8/O5C2mTztiWTBHPx3L4Zp30xl5GX9diNd7CxqcrRju5hKDZluIo/aQbH4yNLs4nXL8EMs2Cb+WfgEUHOIR+gzy/TRHpYQ9cUWouFSjCYqNsP2YtQvkVXPDe0+iac6SHK/41pZ0PXcL0+k4b+yjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzzJX5wHn99Aaj+fNZlFofq9bdvra+Vzbf0T29LQPpM=;
 b=EicbclfAzB8FzNKxRDArExsoGcJsIt+yqdN2JqqdaoFkRmKuhXu1oj6rbx5tF3LSgiXOXae0dKMFOWzBcd465rUofQX5l6G/qLJNS2Q5LtZuBHDi7L0fKuaQJ5wjBZ2XYKRAxwuSGXYh4BdoX3lu4X8d+XgTl+/F2N+cxLy6Uqs=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB1847.eurprd09.prod.outlook.com (10.171.76.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 15:24:04 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7%7]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 15:24:04 +0000
Received: from localhost (193.47.161.132) by GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 15:24:03 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>
CC:     "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC 0/5] arm64: dts: imx8qm: enable sata on imx8qm based board
Thread-Topic: [RFC 0/5] arm64: dts: imx8qm: enable sata on imx8qm based board
Thread-Index: AQHV3QF2KkUyDNPMQU6sTRVuZgujtA==
Date:   Thu, 6 Feb 2020 15:24:03 +0000
Message-ID: <20200206152222.31095-1-oliver.graute@kococonnector.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::16) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f24c63ba-d28f-4487-4505-08d7ab18995e
x-ms-traffictypediagnostic: DB6PR0902MB1847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0902MB18479CCFCD54565080F7369FEB1D0@DB6PR0902MB1847.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(346002)(376002)(136003)(366004)(199004)(189003)(508600001)(4326008)(64756008)(186003)(5660300002)(2906002)(6486002)(66446008)(6916009)(81166006)(81156014)(966005)(44832011)(16526019)(956004)(2616005)(26005)(66556008)(4744005)(66946007)(66476007)(54906003)(7416002)(6496006)(8676002)(52116002)(86362001)(36756003)(8936002)(71200400001)(1076003)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB1847;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDed0v5xpOZzOXEPtBoCRxqUd4xQP9n8Hpxb/aZQ9Vjmd1poQTTvpMs+AViJEW9Ua2VsBoPGde73DlnoekjWNUlkgNKjklSPetp50+ucuul3Mc5zTe+E+7pIfe8kg2WCV2KRQ0qU37Cq/ItSZMz5F733w/zj1Lcx46ZOpsqc4CW9nuo3KOYgMR90kaoMGpvShtAT13SxrpS5AWeznIUlVitlRT0+6eHVo5W6m4hI3f3fVDRgtNtLRp7MfLaX8EhdiI5p1Px7dnvvO8HRZM/Fj+wlCXS1YLipr24f4RsQQLIRQPbIahhzeXlXwvjJEUbnPM4RdTqgfCUtI/b/7Ycl62kQrszeEvJiycE1oukBgcMmKeFYWgFOHZF3M9GcS2EbQyHBJBAiFeBfQ8VX/zO02uH6AhDYsE7Xwe1/S8KSLaXkT4+IC9G7Wqrpd6HKHS47/cgf2F9qYTsgSzfh+dlg8dv2TI6aC7rg/B5TFbttypbWJDNnvn7WEOzTMSbydUdU4j5UGPTHEn3QXgFnZWvRGCkve63FmX5fF5JFafE5T6CfwVRQR38kAiF037kB+yiB
x-ms-exchange-antispam-messagedata: Yodpkq0+qFy9G3KyEA7qgur3vW6zQstqyKb4gAzJ3h2ZG/i9fg7KsJ5W1IKf195XgpwZcl1d/I+tqjs1j7DKfeHzVxqN5X7By2rSomigGY8nGY1JHw/gGirjWrIS1NB+sW79hHqe20VOeITFjVMeAw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24c63ba-d28f-4487-4505-08d7ab18995e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:24:03.8910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYG+r0qLR2P6tAAb8AYaYVLxL2Qq1wNGhf7L+leJXjxR3uCoLKvLVsEk2h8NvscVyCu0Q5wpcrMi039f2H3R7Ub946vnlDw+etzqGnLmQQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB1847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series tries to enable the sata interface on a imx8qm based boar=
d.
I'm not sure howto do the sata clocking right. Maybe some can comment on th=
at.

The patches are based on-top of these clock patches.

https://patchwork.kernel.org/patch/11248235/

Oliver Graute (5):
  arm64: dts: imx8qm: Add HSIO Subsystem node
  arm64: dts: imx8qm: added System MMU
  arm64: dts: imx8qm: added sata node
  arm64: dts: imx8qm: added pinctrl for pciea
  arm64: dts: imx8qm-rom7720: added sata node

 .../boot/dts/freescale/imx8qm-rom7720-a1.dts  | 14 ++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     | 45 +++++++++++++++++++
 2 files changed, 59 insertions(+)

--=20
2.17.1

