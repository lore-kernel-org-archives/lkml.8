Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB803C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7962B20801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="co6vSdm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgBSNAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:00:53 -0500
Received: from mail-vi1eur05on2134.outbound.protection.outlook.com ([40.107.21.134]:38304
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbgBSNAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:00:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI3+zbcccony3TBt0HmudyxILPU4Npesdph0L5rba88zYxDP0w4FvarmzZWW0Tn7TBseOrLSlbmVvH5rwHwynxkz36bF17cTrwmaeyiU7H9cB934joKRYLb20xQjJEo57mBDaHPBDPbyjr03x3yOjzhjtWOgxdhZ1EJLO8GgmOtnCp+uLh67hFuQaNGHoXV73PYZUeQjb/n+nGicwhp6ovGtpEtxYig2zv36BSsatFu8tMbnXBqtK38aUxmBThmtMRHaTBsXQVIhYDgsE0DJGHe9h+ZEXMURFrNPCj2weqpVIslLg+htIIdy/TUpEc6YQ7lGgVE5moxZGUycZdoX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYpTI11WUhk8i2wGRu8ScNZf5lmon5LgE9t3hmjZgAk=;
 b=Dttu3hHH8d2Z9q8pwp7QRFrCGnlOCjbkbmhbcWsKz7tqzOwhc6EgkjzL25AupehHhtv4zSqrljOvJwKAIo+2laVnIjxTyWe2iCFuq07xFI1W6cK0vgQQsLMfEj+OVjDt8FqTF4JSj4kBCQkGQA+v50PREM5El/a7ba/q28PIa7zq7zJKIPUxMolqNwU9bRJpLeoewKMyvGiCbH1kRoQquX7GQHEUph5k3f47bu+YI10D7Eezfruc/pXitYnSF5SBcFDsmPRjtOk9uIM3lPZRYR4SYcAksu7WHz85MRGry8A9Wz0f9btymPC6TWIwPHMvdxQDIGv0oiBq29M6OO2GoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYpTI11WUhk8i2wGRu8ScNZf5lmon5LgE9t3hmjZgAk=;
 b=co6vSdm60JpYBYyf8hw84aMXCsHh7NBs3gLJPXardEI2ht5Ugb7emAnlTVBt+Z5KxRdpwvT5cI+WCDoeJ+q6D/xomPlEZLqkThxYgNLSKZ0o8NSFXne3V6uqKMlkea5NnAT6aNHm+Aa7z6aPirLSn46xUb7UCMff+oVLE5xrvU0=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB6495.eurprd05.prod.outlook.com (20.179.24.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 19 Feb 2020 13:00:49 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 13:00:49 +0000
Received: from localhost (194.105.145.90) by PR0P264CA0146.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 13:00:48 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?iso-8859-1?Q?S=E9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] Add Aster carrier board support for Colibri iMX7 CoM
Thread-Topic: [PATCH v2 0/3] Add Aster carrier board support for Colibri iMX7
 CoM
Thread-Index: AQHV5ySb67pU5Yy2iEe/NYkAPxlyFA==
Date:   Wed, 19 Feb 2020 13:00:48 +0000
Message-ID: <20200219130043.3563238-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0146.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::14) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2690287d-b7cb-41ae-4b6f-08d7b53bbdd5
x-ms-traffictypediagnostic: VI1PR05MB6495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6495CA840B6FE1E5EFFB527FF9100@VI1PR05MB6495.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(16526019)(52116002)(26005)(71200400001)(8936002)(186003)(8676002)(81166006)(6496006)(81156014)(7416002)(44832011)(6916009)(6486002)(1076003)(4326008)(86362001)(956004)(5660300002)(64756008)(66446008)(498600001)(66556008)(2906002)(2616005)(66476007)(36756003)(66946007)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6495;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Vs3rJp0bmttjUpkBiYmxhRy53QZoZVSsH3OlyZii5/vUxM2RaHVY6Tg6UVQjRwOG6QFOfWw2NqeKF/lqjWmDn1wq83uTEDMtudx6KfNKjq4npVqZQkS9GLqffKDPJpTQW8Bn86nurhNhm2jWy0JVpRgfnsRvfRoyV4Eh1akTqkMpkzW1No4w8T29iefROWwyzaDwqEqjI2xQnRSdo0M4m7tvcgC6lAoi7P2ARjxwlZw3KhVDXjxVWuRbkV2G6twLQ+OuL7JWAeunW19KZhd9s+Apde1vbACg8jW6MrehrlvrSPedX9qAh6cIl7VRZXqkWdHHXm0dreFnbz55Pc+1AGoaCex66OLboLpJcVgVW0/U4pghflhyCnQZ+jGPw7Pou2NW1aG1yhyECMxS+gREolCnHaJO+Upzz9vYJOpM9GVXL+m73hU6rBXvzQ5pexT
x-ms-exchange-antispam-messagedata: xtGxWj/D+BcqZV882KuR8IqATydymRQjECVrx0yD1kRb5gdeXMy03fAx10qOoP4xoJcTfHuDlW5HYBTCvePBZKapnIFDVlhw1rBLXGNkTVbkRBKHNXW9bsJtd0AXVflZkfCmFHsn73+rVYeVs+5ivw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2690287d-b7cb-41ae-4b6f-08d7b53bbdd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 13:00:49.0044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mG0UVUQdCuQ5jXQE55TJQk5oWAcepdcmlI6PIE5Kg41MdLk/0ZGrj+sioD7JmqCc1k949rIWMCl3NXtRmRLiKXcoHKi3cZnK7aU3ThvNS2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds devicetrees for the Toradex Aster board along with
Toradex Computer on Module Colibri iMX7S/iMX7D.

Changes in v2:
- Change X11 license to MIT
- Change X11 license to MIT
- Sort nodes alphabetically
- Document compatibles for an Aster board in the separate commit of
  the series
- Drop the undocumented device (spidev-around work will be sent in
  the separate patchset)

Oleksandr Suvorov (3):
  ARM: dts: imx7-colibri: Convert to SPDX license tags for Colibri iMX7
  dt-bindings: arm: fsl: add nxp based toradex colibri-imx7 bindings
  ARM: dts: imx7-colibri: add support for Toradex Aster carrier board

 .../devicetree/bindings/arm/fsl.yaml          |   3 +
 arch/arm/boot/dts/Makefile                    |   3 +
 arch/arm/boot/dts/imx7-colibri-aster.dtsi     | 169 ++++++++++++++++++
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi   |  40 +----
 arch/arm/boot/dts/imx7-colibri.dtsi           |  42 +----
 arch/arm/boot/dts/imx7d-colibri-aster.dts     |  20 +++
 .../arm/boot/dts/imx7d-colibri-emmc-aster.dts |  20 +++
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts   |  40 +----
 arch/arm/boot/dts/imx7s-colibri-aster.dts     |  15 ++
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts   |  40 +----
 10 files changed, 238 insertions(+), 154 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7-colibri-aster.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-aster.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-aster.dts

--=20
2.24.1

