Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52189C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B10C20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M06uZftp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgERFUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:20:18 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:12514
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERFUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:20:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9ZqkWZxCMBZeQGdM7CQt1oIvg82C8WzYjOkDjlPZIx+3wd++iYPJUwBtowaXTv6Vj/iDCXiBHivY9/VURgH2vKAFiDbfqRV8x3s7eMwTN3Es3IIi/39Elq6DLlmsHE84bxhGO1u5M3AQIRDIHTPZAGsqK4ZVsBGwA83R0CTvbot0ClsMQ1sJY8Ii8I4gWdNKt338AW1xCzqkuF21CoyHkh54EoOdFwhbWaINhO5ybvgg3sGitjgLWtQWeCTh+qgF6nOpyWU2sdDqh8lJzh7rTXbfbzHuuvW3yfxwWeJqvUHhAqeZhrEyoeH1V4mvXKN3RhhCKZBDb325xZJwkA8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwXYQE6YrvSa9tdWIFHSBx2UhLciexEouHfq9Dh4Vag=;
 b=ExrUxgyU9/YndBfNSOOPF7GBf3V0dq28rZztqpfxb7+vufX/ZsxIvWQP+SVXKmhNxtdo5SZvERKbwUrPLu+FQ8hhrRUyPF3L/vs+wwFVAUIHDAf8x4IOOhJOAzaS/WRcWZWx2B33TciNFwrtTi+p0ZtpSL++3HKyTon5Dxxu4SQkl0H2p5Qs+mLPOgO0OzLiEXy+A00etBcW6f4DALnkodCaJRQSL4oie8ZiF/rMGN6Q7weYfZN6CN6aPB7YFtHluOR6+fTeJlZD2JldeBc2qdRfHifJbAqe0Yyg3/HCxQ8H6lPK3ieMMWxF1pYVojOA30wZ4zwd+6U3LRg9sOteaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwXYQE6YrvSa9tdWIFHSBx2UhLciexEouHfq9Dh4Vag=;
 b=M06uZftpWll22CqHIMFFe4Dett9baHLupNCcQFMBD0oJ003PXDTz4ylIUhRr811MgtpK9215a36sf2sanWnyFt93AwU/Vx2kY5/zue0xZzUwRofgy3xJGbdPSw0KuYCt2VzF3ScsnZchEPdEcLSL35D8vEfdL5Dh/6XCTZhZNpY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3658.eurprd04.prod.outlook.com (2603:10a6:8:2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 05:20:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 05:20:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: interrupt-controller: Convert imx irqsteer
 to json-schema
Thread-Topic: [PATCH] dt-bindings: interrupt-controller: Convert imx irqsteer
 to json-schema
Thread-Index: AQHWLLrjNbk2hqU7XkKTiiG/WSwz26itMpIAgAAbZAA=
Date:   Mon, 18 May 2020 05:20:13 +0000
Message-ID: <DB3PR0402MB3916609EB361691CA3254D23F5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589767841-4213-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966C2A615086069F9C05B7780B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966C2A615086069F9C05B7780B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bd6c7b5-a756-4dd9-7d9b-08d7faeb24b2
x-ms-traffictypediagnostic: DB3PR0402MB3658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3658B5376B928BBE41BB1D10F5B80@DB3PR0402MB3658.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rOyupQuNkIqu+8IyMBFa9+/jzDzt734a0CpAsHgo3Oxa6o9tfDTWWk/0Nuvn5AZiqEAP1TKk0ZO4iGBmgzEuNqB1WmCm4A1jQKID6fQ0gyTPa3vsafkXy+jk/xf3iY6kANLVDwvOulFjIZO57V33S12AlIHrN+TY8r+2HMmd1t6xzVn+pqHHNF38E+C/j9310RDKDL5XdCE+GzdavozX1uVx92hwCW+jmhaU/cg5RSiZpto4ppDxePfHdE/Tk0OShgWivOoYezFGgSqMhHsO5nspmYq22b9Z7LYAj5E86y5ZrHHv85+Hm2bOBfz3WJW/OMuGQerBAw1Kz2UNhXXnAYUOyhvsFcnkny3I2eTUiM1HzJW2qtKrmgnLxayuZLtZno8enykrmKQU2fjVDYexyFwXfLZ5mC0i3830f6O7bzLLuREF/oiZwelD/bUlGrV8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(26005)(5660300002)(71200400001)(186003)(7696005)(8936002)(55016002)(44832011)(66946007)(66556008)(66476007)(76116006)(2906002)(33656002)(316002)(86362001)(66446008)(52536014)(110136005)(6506007)(4326008)(478600001)(4744005)(8676002)(9686003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: O9t+gb6J9weXP9sAeDoS+JDfquvyJoRQ2F2GHaQmHR0JglvbJ870MBMEcX9WPnF32xLzqhpztK1FFx8brEt32FkEovujRosR2rxFNnpXoF8wk9WmiyI+nb9jw3ByTGV0tqWBA7xkEB+Y4vqozufYBnqtR1DoPAVjmCHaNGd2/TUg4hZ0VQUK0fiJWvy0mI26M7uaYQ5MgmhU7AiruZiSDLBzJWeVvezRfWWTcCzyfkhqaThrkcJ/jOlfAeHcoeHI8aJ+J1xLLDbqJSv6C2P+M2AeJcosWv1KmMhnPT+TbaCKexybJ270UVflfY0+a3E0m/Ls0wB8+4b7LN4xljnuENPWPifPwJ7+56RiW2IlvjdaB3Y1+4Ij0TOO8RiDmYUIfMoTK5/DH5+k00EdjwtGul67g8am/OwfxfhmrwRVno66tr5Ps/C4Ud0guAQsoLnqnMDTgnbVvgm8FQy267SgRp95IhDnHVgWjOovdNtNZsmddUzBCB8oOToOmY9ql8Dd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd6c7b5-a756-4dd9-7d9b-08d7faeb24b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 05:20:13.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKRe9QS9FiLCViIvpj1QR1iEqLwzKwuQsg+qZkebQXUDFDj3sugX7ZjQAXXAos7JkO8uxUhTVIexZJ+oI6WdLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHQtYmluZGluZ3M6IGludGVycnVwdC1jb250cm9s
bGVyOiBDb252ZXJ0IGlteCBpcnFzdGVlciB0bw0KPiBqc29uLXNjaGVtYQ0KPiANCj4gLi4uDQo+
ID4gKw0KPiA+ICt0aXRsZTogRnJlZXNjYWxlIElSUVNURUVSIEludGVycnVwdCBtdWx0aXBsZXhl
cg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0
aWJsZToNCj4gPiArICAgIGNvbnN0OiBmc2wsaW14LWlycXN0ZWVyDQo+IA0KPiBZb3UgY2hhbmdl
ZCBiaW5kaW5nIGhlcmUgd2l0aG91dCBjb21tZW50cz8NCg0KSXQgaXMgYmVjYXVzZSBkcml2ZXJz
L2lycWNoaXAvaXJxLWlteC1pcnFzdGVlci5jIE9OTFkgaGFzICJmc2wsaW14LWlycXN0ZWVyIiBh
cyB2YWxpZCBjb21wYXRpYmxlLA0Kc28gdGFrZSB0aGlzIGNoYW5jZSB0byBmaXggaXQgaW4gdGhp
cyBwYXRjaC4NCg0KQW5zb24gDQoNCg==
