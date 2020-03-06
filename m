Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8EEC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA662072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rwq1l8gJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgCFIHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:07:24 -0500
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:21823
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbgCFIHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:07:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtVVeFuGxBWjnDqFWdpDTb1SW6FNIahkaZ4B3zUGDk9NCNUi+NEnoQkv8sgk41HJ2ZfY3cI5Zwyxj9u3e/Erd2c1ozSdbXl0ygxyVp0Gl9ysNUmmbAn1DMZBhEeQ1EjsDWOTdi0+i9KWPE6Zo9HPmIlXCBxS4KZOAOGd3L5SGHhY8cg/FQXYi2Y6mOYDdZjopfmiPBq+7SwRoTKrAfZNTcDErg3TcUD0ESNxqj4k719cAOI2K4QXRnCdGLMsdaYqbQa10Y+7zCnqcUnQqd5u50XQWvu6pbSxxmbviwluTPgfckQ6Ynu6uSkE+nCTKGXxLSjb0qXyPrVchwfUcUaxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6rzdEB+BaOMxCFIwpzT8mme1FmTxqpkup27Ac8TgOw=;
 b=ALw7gsc21nc19ZFdQ/SXQd6/3CRL1djduXkYZ22WLKa78I6mtc8EinNs//7ZLDTXyXIHgqkKWsnczn0qq4soVXD+pIYX8Apzj5XF7Z/eimcGlU/OY4dw0pZTUThK8Ew59jEAByICAMZpYZGePCI6I057D53vpeFffltEIgjqaSXAkd7CoTHZrMdGcs9s/+NKYbRkDrno7lD/JUFb1rHCOyVMh8G1lTmN7fjXc+FkvydSxF6uQOWc++6zTFHglhfAdfmx29bT1cV4b5nDbXJ7OWBG58vZ38qMaFJ8ELVekOVVT6JK1sUgYWgVf/yXCrxmmG+UBRwsjAHDuAgy/79cfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6rzdEB+BaOMxCFIwpzT8mme1FmTxqpkup27Ac8TgOw=;
 b=rwq1l8gJFdZ37I2G8ZJ3TFzHTWcqmFblEP8eDyyRDr6Dw2gGTfFVbjF3DwN6n3ydLqO81m9XJeNAhmlsMrlcD1GqGnS0ym9UjDAYzM2l9vP/8LW6tW4PqRrGad/E9odVFrdtI+ttFu1nEU+BWBFxoitXIb0+y3V4MnXhDM1FgUk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6052.eurprd04.prod.outlook.com (20.179.34.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Fri, 6 Mar 2020 08:07:19 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 08:07:19 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
Thread-Topic: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
Thread-Index: AQHV8QFMuMBBDfh8hE244PoeMX235qg4QIWAgAAijkCAAAqsUIAAPdoAgAEztyCAAE6qAIAAFpEAgAD1lAA=
Date:   Fri, 6 Mar 2020 08:07:19 +0000
Message-ID: <AM0PR04MB448167BD133BF57E548F2F0588E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583201219-15839-1-git-send-email-peng.fan@nxp.com>
 <1583201219-15839-3-git-send-email-peng.fan@nxp.com>
 <20200304103954.GA25004@bogus>
 <AM0PR04MB4481A6DB7339C22A848DAFC988E50@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB44814B71E92C02956F4BED4588E50@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200304170319.GB44525@bogus>
 <AM0PR04MB4481B90D03D1F68573B05BE088E20@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200305160613.GA53631@bogus>
 <d9734fd6-f855-296b-3a0b-ffc45ed0e3cb@gmail.com>
In-Reply-To: <d9734fd6-f855-296b-3a0b-ffc45ed0e3cb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db983e52-9624-4a29-b51c-08d7c1a5646f
x-ms-traffictypediagnostic: AM0PR04MB6052:|AM0PR04MB6052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB60527F0FB8A6245698F4175488E30@AM0PR04MB6052.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(6506007)(53546011)(86362001)(8936002)(7696005)(81166006)(81156014)(8676002)(66476007)(64756008)(76116006)(66446008)(66556008)(66946007)(33656002)(26005)(186003)(44832011)(5660300002)(4326008)(55016002)(110136005)(52536014)(2906002)(9686003)(54906003)(478600001)(316002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6052;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLAJG0kevuJWzrXc/gOAV8eZ1jQ7KeixdP4fVONCjfyi08BkYrokZ2u3VnkuqP/pxH64DzKT3SsG+KE/1PN8qtPccWjO1JTyITwlAyQ0qXnpHSv20KkQyqrjBaEvjy5zU/yvWw4uVQT6kIusXjKHD48amyay7uykH1OKvR+HFP1Yydmxv+LeH1VBpZ3jNKgWhlcTY2d6x/qrWPO39rZ6o7IPJfT2q/JNpBAdG3cniJIs9/LGzkAGsFB3JWh/jHeoMuo6cPaS6m2mmdBYACl0i3q905+zoQON2apE6R6IEX+tDp7NOuNeQocq2ZxkZeoYXye9BtpQVMEvVLNs+0FUz5S4fBfgMRGKZpM0OQ/BArDJ8WhjG09Cl8sQLoklRdBLzOFxWMgTPYoX5+CmqogItxYjLJSkVnoHcGDjAWyMTcYu82SLs6ZvVJ/XDfU+bQBb
x-ms-exchange-antispam-messagedata: o1m0Uy/Nt1fVnLE7iqSa+kqhTTe5Uelg/YiHuZDsM+K5r2/DDO8P2DVJ4eHVUYnBwj86z1DLIIMPHRaXHIR/d5SquvqUXLbzY0DMpwcK0JDBeyXly7cX0A6Vh0bbsoobs2Dgee3WNStoyL7+8lz/dQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db983e52-9624-4a29-b51c-08d7c1a5646f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 08:07:19.3572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNJZhcTMY5zcuun6m2ulD6QeRqpEqwxbX7Mdi6zIhg2SJKg13c35JUli2Ol+wG52o7K34ZKFkfzRIwdOqBoprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDIvMl0gZmlybXdhcmU6IGFybV9zY21pOiBhZGQgc21j
L2h2YyB0cmFuc3BvcnQNCj4gDQo+IE9uIDMvNS8yMCA4OjA2IEFNLCBTdWRlZXAgSG9sbGEgd3Jv
dGU6DQo+ID4gT24gVGh1LCBNYXIgMDUsIDIwMjAgYXQgMTE6MjU6MzVBTSArMDAwMCwgUGVuZyBG
YW4gd3JvdGU6DQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4+Pg0KPiA+Pj4gWWVzLCB0aGlzIG1h
eSBmaXggdGhlIGlzc3VlLiBIb3dldmVyIEkgd291bGQgbGlrZSB0byBrbm93IGlmIHdlIG5lZWQN
Cj4gPj4+IHRvIHN1cHBvcnQgbXVsdGlwbGUgY2hhbm5lbHMvc2hhcmVkIG1lbW9yeSBzaW11bHRh
bmVvdXNseS4gSXQgaXMNCj4gPj4+IGZhaXIgcmVxdWlyZW1lbnQgYW5kIG1heSBuZWVkIHNvbWUg
d29yayB3aGljaCBzaG91bGQgYmUgZmluZS4NCj4gPj4NCj4gPj4gRG8geW91IGhhdmUgYW55IHN1
Z2dlc3Rpb25zPyBDdXJyZW50bHkgSSBoYXZlIG5vdCB3b3JrZWQgb3V0IGFuIGdvb2QNCj4gPj4g
c29sdXRpb24uDQo+ID4+DQo+ID4NCj4gPiBUQkgsIEkgaGF2ZW4ndCBnaXZlbiBpdCBhIG11Y2gg
dGhvdWdodC4gSSB3b3VsZCBsaWtlIHRvIGtub3cgaWYgcGVvcGxlDQo+ID4gYXJlIGhhcHB5IHdp
dGgganVzdCBvbmUgU01DIGNoYW5uZWwgZm9yIFNDTUkgb3IgZG8gdGhleSBuZWVkIG1vcmUgPw0K
PiA+IElmIHRoZXkgbmVlZCBpdCwgd2UgY2FuIHRyeSB0byBzb2x2ZSBpdC4gT3RoZXJ3aXNlLCB3
aGF0IHlvdSBoYXZlIHdpbGwNCj4gPiBzdWZmaWNlIElNTy4NCj4gDQo+IE9uIG91ciBwbGF0Zm9y
bXMgd2UgaGF2ZSBvbmUgY2hhbm5lbC9zaGFyZWQgbWVtb3J5IGFyZWEvbWFpbGJveA0KPiBpbnN0
YW5jZSBmb3IgYWxsIHN0YW5kYXJkIFNDTUkgcHJvdG9jb2xzLCBhbmQgd2UgaGF2ZSBhIHNlcGFy
YXRlDQo+IGNoYW5uZWwvc2hhcmVkIG1lbW9yeSBhcmVhL21haWxib3ggZHJpdmVyIGluc3RhbmNl
IGZvciBhIHByb3ByaWV0YXJ5IG9uZS4NCj4gVGhleSBoYXBwZW4gdG8gaGF2ZSBkaWZmZXJlbmNl
IHRocm91Z2hwdXQgcmVxdWlyZW1lbnRzLCBoZW5jZSB0aGUgc3BsaXQuDQo+IA0KPiBJZiBJIHJl
YWQgUGVuZydzIHN1Ym1pc3Npb24gY29ycmVjdGx5LCBpdCBzZWVtcyB0byBtZSB0aGF0IHRoZSB1
c2FnZSBtb2RlbA0KPiBkZXNjcmliZWQgYmVmb3JlIGlzIHN0aWxsIGZpbmUuDQoNClRoYW5rcy4g
DQoNClN1ZGVlcCwNCg0KVGhlbiBzaG91bGQgSSByZXBvc3Qgd2l0aCB0aGUgZ2xvYmFsIG11dGV4
IGFkZGVkPw0KDQpUaGFua3MsDQpQZW5nLg0KDQoNCj4gLS0NCj4gRmxvcmlhbg0K
