Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391D6C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 06:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EADE206EF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 06:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l1wJMqar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgBRGiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 01:38:14 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:3810
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbgBRGiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:38:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfJ37iQ+W9iCbOCBrnPQ6gZAwY+cjIRslGikFwkoAezC4OJBt1zdNXWIqGUtQv5siosRYqYx4yHX6ftBuHhhdaOZ7APLsS3ANV3eU6VxumzW9KuFANqEf3NtEVSyJNWFJQpHx/gPYRzkHUwGHmfQi8SEMlCt9p8vjMIniroFmZXaYR1dESMFxUZHQvwGcm8+DD6Bi7aE+Lc3ht5NZ+B31leMgB38nepsYCAsoTYMzaGR0pWwwMz/Ma93FsSAkZ2i+74Jt8d55hTnFdD2YYKNpzcjsBRSpnGstVBosH+UVpzGRFW+A1TL5kIyk79s3d5pmLEySM2yKGhBtjRYHt15Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WehSuJh/StYJdKMdOSsx+Hr5FuhMeMwFTU5aHbBniqE=;
 b=fOQV66mn4n8Mg56KWYqKIYsTym1o7SMI/40IPxG9l6mBftG2ZUCzcDh3+oVnFbfHXQHzuqvLAHc1HcoSVHywO3aB6FeKkv/X7tueGRrk0JNbS2Z81DOT6kEb/pns+9p0P0L2fK1Dsy08m/rHjtXFOR/hLYAxoNpdROUUofTOqeyj0UdQiz+L+X1XZhD3GEulpT7XDo9usrF3EIc+842XmdJ/UDnal/vIe39UdRcfQaXDSPplUA22g/yBK8wRJ4sm2oEF+dRZZZ3iDr8ln76Ez/+brQ13vVg7BC6B5xcD+89FDiczTFM2vEJ7HnlyzL1JydtRgDsPFLy5DLYvb16AKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WehSuJh/StYJdKMdOSsx+Hr5FuhMeMwFTU5aHbBniqE=;
 b=l1wJMqarAyYjhB/uAjrFdpTKSJ9MghHa9RXFkuc68kiO/L5zN3a1aDM8gOWGTY0J9NBa1fD+Bwpwd7pOTyLxap2ENQsUTJpsLxkTZD1o+jIze+CEQBBhXoaPTwG9zJtPBv0HI0TABRBgkbWNb4NEaWdRadteCEyfYSfS+8lLa3g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3834.eurprd04.prod.outlook.com (52.134.71.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Tue, 18 Feb 2020 06:38:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 06:38:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] soc: imx: Remove unused include in gpcv2.c
Thread-Topic: [PATCH] soc: imx: Remove unused include in gpcv2.c
Thread-Index: AQHV5iBSEpuvkLJISUqKDGnVgUsxmKggdMkAgAAKVNA=
Date:   Tue, 18 Feb 2020 06:38:10 +0000
Message-ID: <DB3PR0402MB391676E0648E09A9E9864916F5110@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1582005089-23767-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB448194F2C0E2043661556C8588110@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB448194F2C0E2043661556C8588110@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [220.161.57.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dea4a92-e965-4212-1ab5-08d7b43d1f2c
x-ms-traffictypediagnostic: DB3PR0402MB3834:|DB3PR0402MB3834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB383498538408AF04CE758F7FF5110@DB3PR0402MB3834.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(66946007)(76116006)(5660300002)(7696005)(2906002)(55016002)(9686003)(316002)(186003)(110136005)(66556008)(66446008)(64756008)(52536014)(26005)(66476007)(6506007)(4326008)(8676002)(86362001)(44832011)(8936002)(81166006)(81156014)(33656002)(478600001)(4744005)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3834;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8k1HC2mR3MHVKKS9pQb8nzHf/9+OOuQuJdKJ1fbslC/Ts3U9PgfSuBD6ryDdPCHkGkEFAzdUj1bOFiI9vgJIBc8ccajLEEuIUXH4tJD9MnOAxaPmFwemMnyEn4Fgn2uoqOgsCiqEyboMm8kM+gRr4IMSqypCs5i4ptdWzmesaRocHwEDOtERzmdVeWTcfdqHD0Tethqm/40skVF1MtY55WkuA/yEs8RG39GlcEgRZsUGaOi5vIkG5NFJJLgLSruXzvlEW1AURUm9+BxUI7RIGnAoGTGLeAh2mPxYMSnuBlSTnJ0RsS0YBVn7zTvqhg/aRvAUibwu8XuMFCSxslJcfgVR++6yTA9XQpSkwPTzV0lofWuLTJkO6yBMByKg7VbYZjCpWDS2I/sA+UVJc6qdaEE1/qXGjyYshSQRtKB+pKZ2/MOAamEDQuX7o3c9ZbKhpEt574zMyd2ZrAP4+rPPCYE9sSwo42b2cNfn+jnK85qaTEP9qrOw66V1xv3G/Os/
x-ms-exchange-antispam-messagedata: xTiIKNiKmMCkRQ0tVwclQjFIJQBJxAA3KtIcvQNzHMkRGzNh01UzEDCLnW7/o4pn2VT3iCxpqg2d8s3JPP2xMe2FvgXPPnVTGmHmXLRwf3l2wkPCeudLBMM64Q/kkNxQuhvJ8k5sguM/AHmwcv3MeQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dea4a92-e965-4212-1ab5-08d7b43d1f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 06:38:10.4563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVucgw/thfq8NDdjk5j1YES3afqmhJPcdZIEpohnwn+4Aa1MTDjiCRGEYtPXzBVwzP5uYJ5RU9GkZLd1AviGgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gc29jOiBpbXg6IFJlbW92ZSB1bnVzZWQgaW5jbHVk
ZSBpbiBncGN2Mi5jDQo+IA0KPiA+IFN1YmplY3Q6IFtQQVRDSF0gc29jOiBpbXg6IFJlbW92ZSB1
bnVzZWQgaW5jbHVkZSBpbiBncGN2Mi5jDQo+ID4NCj4gPiBUaGVyZSBpcyBub3RoaW5nIGluIHVz
ZSBmcm9tIHNpemVzLmgsIHJlbW92ZSBpdC4NCj4gDQo+IFRoaXMgaXMgbmVlZGVkIHdoZW4gbW92
aW5nIHRvIHN1cHBvcnQgQ09NUElMRV9URVNUIGZvciBzb2MvaW14LCBwbGVhc2UNCj4ga2VlcCBp
dC4NCg0KQWgsIHllcywgSSBkaWQgTk9UIG5vdGljZSBiZWxvdyBwYXRjaCB3aGljaCBpcyBpbiBw
dXJwb3NlLCBzbyBqdXN0IGlnbm9yZSB0aGlzIHBhdGNoLg0KDQpjb21taXQgYjVjYzk2ZDNiZmNi
YzQ5NWEzNTBmNzhhYTJlMTI5NWIyMzhkMjZkYQ0KQXV0aG9yOiBMZW9uYXJkIENyZXN0ZXogPGxl
b25hcmQuY3Jlc3RlekBueHAuY29tPg0KRGF0ZTogICBNb24gSmFuIDIwIDE0OjUxOjI4IDIwMjAg
KzAyMDANCg0KICAgIHNvYzogaW14OiBncGN2MjogaW5jbHVkZSBsaW51eC9zaXplcy5oDQoNCnRo
YW5rcywNCkFuc29uDQo=
